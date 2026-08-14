#!/usr/bin/env perl

use strict;
use warnings;

use File::Spec;
use File::Path qw(make_path);
use File::Find;

use Cwd qw(abs_path);

# Check if running as root
if ( $> == 0 ) {
    die
"Error: Running this script as 'root' is not allowed for security reasons.\nPlease run it as a normal user.\n";
}

# Check if required external tools are available in the system PATH
my @required_tools = ( 'ctags', 'cscope', 'cqmakedb' );
my @missing_tools;

foreach my $tool (@required_tools) {
    my $path = qx(which $tool 2>/dev/null);
    chomp($path);
    if ( !$path ) {
        push @missing_tools, $tool;
    }
}

if (@missing_tools) {
    die "Error: The following required tool(s) are missing from your PATH: "
      . join( ', ', @missing_tools )
      . ".\nPlease install them before running this script.\n";
}

# Display help message if requested
if ( grep { $_ eq '--help' || $_ eq '-h' } @ARGV ) {
    print <<"HELP";
Usage:
  perl $0 [options]

Options:
  in=<path>   Path to the C++ project directory to scan (default: current directory)
  out=<path>  Path to the output directory where artifacts will be saved (default: output_codequery)
  --help, -h  Display this help message and exit

Example:
  perl $0 in=/path/to/cpp/project out=/path/to/output_folder
HELP
    exit 0;
}

# Parse command line arguments for in=<path> and out=<path>
my ( $project_dir, $output_dir );

foreach my $arg (@ARGV) {
    if ( $arg =~ /^in=(.+)$/ ) {
        $project_dir = $1;
    }
    elsif ( $arg =~ /^out=(.+)$/ ) {
        $output_dir = $1;
    }
}

# Default values if not provided
$project_dir ||= '.';
$output_dir  ||= 'output_codequery';

# Convert to absolute paths safely
$project_dir = abs_path($project_dir)
  or die "Error: Invalid project directory path: $project_dir\n";
make_path($output_dir) unless -d $output_dir;
$output_dir = abs_path($output_dir);

unless ( -d $project_dir ) {
    die
"Error: The project directory '$project_dir' does not exist.\nUse --help for usage information.\n";
}

print "[*] Scanning project directory: $project_dir\n";
print "[*] Saving output artifacts to: $output_dir\n\n";

# 1. Recursively collect C/C++ source files with absolute paths
my @source_files;
find(
    {
        wanted => sub {
            if (/\.(cpp|cc|cxx|h|hpp)$/i) {
                push @source_files, abs_path($_);
            }
        },
        no_chdir => 1
    },
    $project_dir
);

my $total_files = scalar @source_files;
print "[1/4] Found $total_files C/C++ source/header files.\n";

if ( $total_files == 0 ) {
    die "No C/C++ files found in the specified directory.\n";
}

# 2. Generate the absolute file list for cscope
my $cscope_files_path = File::Spec->catfile( $output_dir, 'cscope.files' );
open( my $fh_files, '>', $cscope_files_path )
  or die "Could not create $cscope_files_path: $!\n";

foreach my $file (@source_files) {
    print $fh_files "$file\n";
}
close($fh_files);
print "[2/4] Successfully generated absolute paths in 'cscope.files'.\n";

# 3. Run ctags and cscope targeted to the output directory
print "[3/4] Running ctags and cscope (this may take a few seconds)...\n";

my $tags_path       = File::Spec->catfile( $output_dir, 'tags' );
my $cscope_out_path = File::Spec->catfile( $output_dir, 'cscope.out' );
my $db_path         = File::Spec->catfile( $output_dir, 'codequery.db' );

# Run ctags with absolute paths and output redirection
system( 'ctags', '--fields=+i', '-n', '-L', $cscope_files_path, '-f',
    $tags_path ) == 0
  or warn "Warning: ctags exited with error code ($?).\n";

# Run cscope using the absolute file list (-i)
system( 'cscope', '-b', '-q', '-i', $cscope_files_path, '-f', $cscope_out_path )
  == 0
  or warn "Warning: cscope exited with error code ($?).\n";

# 4. Convert into the CodeQuery database format
print "[4/4] Generating CodeQuery database (.db)...\n";
system( 'cqmakedb', '-s', $db_path, '-c', $cscope_out_path, '-t', $tags_path )
  == 0
  or die "Critical Error: Failed to run cqmakedb.\n";

print "\n[SUCCESS] Pipeline completed successfully!\n";
print "To open the graphical user interface, run:\n";
print "  codequery -d $db_path\n";
