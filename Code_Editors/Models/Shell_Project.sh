#!/bin/bash

# --- COLORS ---
# Messaging Patterns
#   [*] ou [info] : Status or general process
#   [>] ou >>>    : User input or subprocess
#   [!] ou [Error]: Alert for critical failures
#   [+]           : Indication of resource creation/addition or success

readonly BLACK='\033[0;30m'
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[0;33m'
readonly BLUE='\033[0;34m'
readonly PURPLE='\033[0;35m'
readonly CYAN='\033[0;36m'
readonly WHITE='\033[0;37m'
readonly NC='\033[0m' # No Color (Reset)

# Example:
# echo -ne "${BLUE}>>>${NC} Enter your name: "; read nome

# --- APPLICATION ---
readonly APP_NAME="ProjectBuilder"
readonly VERSION="1.0.0"

# --- DIRECTORIES AND FILES ---
# Base (Root) Directories with suffix _DIR or _HOME: ROOT_DIR, BASE_DIR, APP_HOME
# Structural Subdirectories: BIN_DIR, SRC_DIR, LIB_DIR, CONF_DIR ou CONFIG_DIR
# Data and Logs: DATA_DIR, LOG_DIR, TMP_DIR ou TEMP_DIR
# File Naming Suffixes: _FILE ou _PATH: LOG_FILE, CONFIG_FILE

# Defines the root based on the script's location.
readonly BASE_DIR=$(dirname "$(readlink -f "$0")")

# Folder structure
readonly LOG_DIR="${BASE_DIR}/logs"
readonly CONF_DIR="${BASE_DIR}/config"
readonly TMP_DIR="/tmp/myProject"

# Specific files
readonly CONFIG_FILE="${CONF_DIR}/settings.conf"
readonly LOG_FILE="${LOG_DIR}/deploy_$(date +%Y%m%d).log"

# Current script directory
readonly SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

# --- STATE CONSTANTS ---
readonly SCRIPT_FILENAME=$(basename $0)
readonly TODAY=$(date +%Y-%m-%d)
readonly NOW=$(date +%Y-%m-%d-%H:%M:%S)

# --- COMMUNICATION FUNCTIONS ---
log_info()  { echo -e "${BLUE}[*]${NC} $1"; }
log_success() { echo -e "${GREEN}[+]${NC} $1"; }
log_warn()  { echo -e "${YELLOW}[!]${NC} $1"; }
log_error() { echo -e "${RED}[Error]${NC} $1" >&2; }

# --- HELP FUNCTION ---
usage() {
    cat << EOF
Use: $script [options]

Opções:
  -h, --help      Show this help message
  -v, --version   Displays the script version
  -v, --verbose   Enable detailed mode
EOF
    exit 0
}

# --- CLEANLINESS AND SAFETY ---
cleanup() {
    echo "" # Insert a line break after Ctrl+C
    log_warn "Interruption detected! Cleaning up temporary files...."
    rm -rf "${TMP_DIR}/*"
    exit 1
}
trap cleanup SIGINT SIGTERM

# --- CHECK FUNCTION ---
check_root() {
    if [[ $EUID -ne 0 ]]; then
       log_error "This script needs to be run as root (sudo)."
       exit 1
    fi
}

check_dependencies() {
    local dependencies=("curl" "git" "jq") # Example of tools
    for tool in "${dependencies[@]}"; do
        if ! command -v "$tool" &> /dev/null; then
            log_error "The tool '$tool' was not found. Please install it."
            exit 1
        fi
    done
    log_success "Verified dependencies."
}

# --- DIRECTORY CONSTRUCTION FUNCTION ---
create_structure() {
    local proj_name=$1
    log_info "Creating the project structure: ${proj_name}..."
    
    mkdir -p "${BASE_DIR}/${proj_name}"/{src,docs,tests}
    sleep 1
    log_success "src/, docs/, and tests/ directories successfully created."
}

# --- MENU FUNCTION ---
menu() {
    log_info "Choose an option:"
    options=("Run Backup" "Check System" "Exit")
    select opt in "${options[@]}"; do
        case $opt in
            "Perform Backup") task; break ;;
            "Check System") check_dependencies; break ;;
            "Exit") exit 0 ;;
            *) log_warn "Invalid option: $REPLY" ;;
        esac
    done
}

# --- ARBITRARY FUNCTION ---
task() {
    # Example of flag usage
    if [ "$VERBOSE_MODE" = true ]; then
        echo "[*] Connecting as $DB_USER on port $DB_PORT"
    fi
}

# -- OTHER FUNCTIONS ---
# task1 ...

# --- EXECUTION LOGIC ---
main() {
    # --- PREPARATION ---

    check_root
    check_dependencies

    # Argument Parsing
    while getopts "u:p:v" opt; do
      case $opt in
        u) DB_USER="$OPTARG" ;;
        p) DB_PORT="$OPTARG" ;;
        v) VERBOSE_MODE=true ;;
        *) usage ;;
      esac
    done
    shift $((OPTIND-1)) # Clears the arguments processed by getopts.

    # Example of initial verification
    if [[ ! -f "$CONFIG_FILE" ]]; then
        log_alert "Configuration file not found. Using defaults."
        exit 1
    fi

    mkdir -p "$LOG_DIR" "$TMP_DIR"
    echo "--- Session: $NOW ---" >> "$LOG_FILE"

    # --- START ---
    log_info "Starting $APP_NAME v$VERSION..."
    
    menu

    # --- EXIT ---
    echo -e "---"
    log_success "Pipeline completed for the project: ${PROJECT_NAME}"
    log_info "Logs saved to: ${LOG_FILE}"
}

# --- EXECUTION  ---
main "$@"

# Captures interrupt (SIGINT) and termination (SIGTERM) signals.
trap cleanup SIGINT SIGTERM
