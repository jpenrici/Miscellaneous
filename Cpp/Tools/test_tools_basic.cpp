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
    vector<string> v {"imageA.jpg", "imageB.png", "imageC.jpeg"};
    view_vector_line(v, " | ");
    view_vector(v);

    vector<vector<string> > m {
        {"image1.jpg", "image1.png", "image1.jpeg"},
        {"image2.jpg", "image2.png", "image2.jpeg"},
    };
    view_vector_2D(m, "\t");

    // Map
    unordered_map<string, string> map {
        {"image", "image1.jpg"}, {"label", "computer"}, {"status", "OK"}
    };

    view_map(map);
    cout << upper(find_key("label", map)) << '\n';
    cout << lower(find_key("status", map)) << '\n';

    // String
    string str = find_key("image", map);
    to_upper(str);
    cout << str << '\n';
    to_lower(str);
    cout << str << '\n';

    vector<string> tokens;
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
    str = "/dir/dir1/dir2/filename.ext";
    tokens.clear();
    split_path(str, tokens);
    view_vector_line(tokens, "\n");

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

    // create_directory("Output");

    return 0;
}
