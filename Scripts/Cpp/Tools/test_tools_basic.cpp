/*
 *   Compile:
 *      g++ test_tools_basic.cpp -o Test
 *
 *   Run:
 *      ./Test
*/
#include "tools_basic.hpp"

using namespace ToolsBasic;

int main(int argc, char const *argv[])
{
    // void error(int line, const string& msg)
    // error(__LINE__, "simple test error ...");

    // Vector
    cout << "VECTOR ...\n";
    view_vector(vector<int> {});

    vector<string> v {"imageA.jpg", "imageB.png", "imageC.jpeg"};
    view_vector_line(v, " | ");
    view_vector(v);

    vector<vector<string> > m {
        {"image1.jpg", "image1.png", "image1.jpeg"},
        {"image2.jpg", "image2.png", "image2.jpeg"},
    };
    view_vector_2D(m, "\t");

    // Map
    cout << "MAP ...\n";
    view_map(unordered_map<int, string> {});
    find_key("key", unordered_map<string, string> {});

    unordered_map<string, string> map {
        {"image", "image1.jpg"}, {"label", "computer"}, {"status", "OK"}
    };

    view_map(map);
    cout << find_key("", map) << '\n';
    cout << find_key("image", map) << '\n';
    cout << upper(find_key("label", map)) << '\n';
    cout << lower(find_key("status", map)) << '\n';

    // String
    cout << "STRING ...\n";

    string str = find_key("image", map);
    to_upper(str);
    cout << str << '\n';
    to_lower(str);
    cout << str << '\n';

    vector<string> tokens;
    split("", tokens, ';');
    split("file1;file2;file3", tokens, ';');
    view_vector_line(tokens, "\n");

    tokens = split("text1,text2,text3", ',');
    view_vector(tokens);

    str = "filename.ext";
    cout << boolalpha << match_pos(".", str, str.size() - 4) << '\n';

    str = "#test";
    cout << boolalpha << match("#", str) << '\n';
    remove("#", str);
    cout << str << '\n';

    str = "filename.ext1";
    remove_pos(".ext", str, str.size() - 5);
    cout << str << '\n';

    // Path ...
    cout << "PATH, DIRECTORY, FILENAME, EXTENSION ...\n";
    str = "/dir/dir1/dir2/filename.ext";
    tokens.clear();
    split_path(str, tokens);
    view_vector_line(tokens, " : ");

    cout << get_directory(str) << '\n';
    cout << get_filename(str) << '\n';
    cout << get_filename_extension(str) << '\n';
    cout << get_name("filename.extension") << '\n';
    cout << boolalpha << check_filename_extension(str, "ext") << '\n';
    cout << boolalpha << check_filename_extension(str, image_extension) << '\n';
    cout << boolalpha << check_filename_extension("jpg", image_extension) << '\n';
    cout << boolalpha << check_filename_extension(".jpg", image_extension) << '\n';
    cout << boolalpha << check_filename_extension("filename.jpg", image_extension) << '\n';
    cout << boolalpha << check_extension("jpeg", image_extension) << '\n';

    add_suffix_filename(str, "_new");
    cout << str << '\n';

    cout << current_dir() << '\n';
    cout << boolalpha << exist_path("test_tools_basic.cpp") << '\n';

    // Save, Write, Load ...
    cout << "I/O FILES ...\n";
    create_directory("Output");
    save(v, "Output/info.txt");
    write("write", "Output/info.txt");

    vector<string> temp;
    load("Output/info.txt", temp);
    cout << "Result: ";
    view_vector_line(temp, " - ");

    temp.clear();
    save_new_file("Output/files.txt");
    list_files(temp, "Output");
    for (auto f : temp) {
        cout << f << '\n';
        write(f + "\n", "Output/files.txt");
    }

    return 0;
}


/*

***** OUTPUT *****

VECTOR ...
vector empty
imageA.jpg | imageB.png | imageC.jpeg
imageA.jpg;imageB.png;imageC.jpeg
image1.jpg  image1.png  image1.jpeg
image2.jpg  image2.png  image2.jpeg
MAP ...
map empty
map empty
status OK
image image1.jpg
label computer
key empty

image1.jpg
COMPUTER
ok
STRING ...
IMAGE1.JPG
image1.jpg
string empty
file1
file2
file3
text1;text2;text3
true
true
test
filename1
PATH, DIRECTORY, FILENAME, EXTENSION ...
/dir/dir1/dir2/ : filename.ext : filename : ext
/dir/dir1/dir2/
filename.ext
ext
filename
true
false
path size < filename size
filename size < extension size
true
path size < filename size
true
path size < filename size
true
true
/dir/dir1/dir2/filename_new.ext
/home/user/Tools
true
I/O FILES ...
mkdir Output ok
save vector in Output/info.txt
imageA.jpg
imageB.png
imageC.jpeg
write in Output/info.txt
load vector in Output/info.txt
Result: imageA.jpg - imageB.png - imageC.jpeg - write
Output/info.txt
write in Output/files.txt
Output/files.txt
write in Output/files.txt

*/
