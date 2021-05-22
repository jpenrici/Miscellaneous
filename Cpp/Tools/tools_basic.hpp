/*
 *  Useful functions for general use.
 */
#ifndef __TOOLS_BASIC_H__
#define __TOOLS_BASIC_H__

#include <algorithm>
#include <dirent.h>
#include <fstream>
#include <iostream>
#include <locale>
#include <sstream>
#include <stdexcept>
#include <string.h>
#include <string>
#include <sys/stat.h>
#include <unistd.h>
#include <unordered_map>
#include <vector>

using namespace std;

namespace ToolsBasic {

static const unordered_map<string, string> image_extension {
    {"PNG", "png"}, {"JPG", "jpg"}, {"JPEG", "jpeg"},
    {"png", "png"}, {"jpg", "jpg"}, {"jpeg", "jpeg"}
};

// Error message with line indication
void error(int line, const string &msg)
{
    throw domain_error("[Line: " + to_string(line) + "]: " + msg);
}

/* VECTOR */
template<typename T>
void view_vector_line(const vector<T> &v, const string &delimiter)
{
    if (v.empty()) {
        cout << "vector empty\n";
        return;
    }

    for (size_t i = 0; i < v.size() - 1; ++i) {
        cout << v[i] << delimiter;
    }
    cout << v[v.size() - 1] << '\n';
}

template<typename T>
void view_vector(const vector<T> &v)
{
    view_vector_line(v, ";");
}

template<typename T>
void view_vector_2D(const vector<vector<T> > &v, const string &delimiter)
{
    for (size_t i = 0; i < v.size(); ++i) {
        view_vector_line(v[i], delimiter);
    }
}

/* MAP */
string find_key(const string &key,
                const unordered_map<string, string> &map)
{
    string str("");

    if (map.empty()) {
        cout << "map empty\n";
    }

    if (key.empty()) {
        cout << "key empty\n";
    }

    unordered_map<std::string, std::string>::const_iterator it = map.find(key);

    if (it == map.end()) {
        return "";
    }

    return it->second;
}

template<typename T_first, typename T_second>
void view_map(const unordered_map<T_first, T_second> &map)
{
    if (map.empty()) {
        cout << "map empty\n";
    }

    for (auto it : map) {
        cout << it.first << " " << it.second << '\n';
    }
}

/* STRING */
void to_upper(string &str)
{
    if (str.empty()) {
        cout << " string empty\n";
    }

    locale loc;
    for (string::size_type i = 0; i < str.length(); ++i) {
        str[i] = toupper(str[i], loc);
    }
}

string upper(const string &str)
{
    if (str.empty()) {
        cout << "string empty\n";
    }

    string str_upper(str);
    to_upper(str_upper);

    return str_upper;
}

void to_lower(string &str)
{
    if (str.empty()) {
        cout << "string empty\n";
    }

    locale loc;
    for (string::size_type i = 0; i < str.length(); ++i) {
        str[i] = tolower(str[i], loc);
    }
}

string lower(const string &str)
{
    if (str.empty()) {
        cout << "string empty\n";
    }

    string str_lower(str);
    to_lower(str_lower);

    return str_lower;
}

void split(const string &str, vector<string> &tokens,
           const char &delimiter)
{
    if (str.empty()) {
        cout << "string empty\n";
    }

    tokens.clear();
    stringstream ss(str);
    string item;

    while (getline(ss, item, delimiter)) {
        tokens.push_back(item);
    }
}

vector<string> split(const string &str, const char &delimiter)
{
    if (str.empty()) {
        cout << "string empty\n";
    }

    vector<string> tokens;
    stringstream ss(str);
    string item;

    while (getline(ss, item, delimiter)) {
        tokens.push_back(item);
    }

    return tokens;
}

bool match_pos(const string &key, const string &str, unsigned pos)
{
    if ((pos + key.length()) > str.length()) {
        return false;
    }

    if (pos < 0 || pos > str.length()) {
        return false;
    }

    if (str.compare(pos, key.length(), key) == 0) {
        return true;
    }

    return false;
}

bool match(const string &key, const string &str)
{
    return match_pos(key, str, 0);
}

void remove_pos(const string &key, string &str, unsigned pos)
{
    if ((pos + key.length()) >= str.length()) {
        cout << "(pos + key.length) >= string.length\n";
    }

    if (pos < 0 || pos > str.length()) {
        cout << "pos > string.length\n";
    }

    if (str.compare(pos, key.length(), key) == 0) {
        str.erase(pos, key.length());
    } else {
        cout << "key not found in this position\n";
    }
}

void remove(const string &key, string &str)
{
    remove_pos(key, str, 0);
}

/* STRING -> PATH, DIRECTORY, FILENAME, EXTENSION */
void split_path(const string &path, vector<string> &tokens)
{
    if (path.empty()) {
        cout << "path empty\n";
    }

    vector<string> v_temp;
    split(path, v_temp, char(47));
    string filename(v_temp.back());

    size_t len =  path.size() - filename.size();
    if (len <= 0) {
        cout << "path < filename\n";
    }

    string directory = path.string::substr(0, len);
    split(filename, v_temp, char(46));
    string filename_extension = v_temp.back();

    len = filename.size() - filename_extension.size();
    if (len <= 0) {
        cout << "filename < extension\n";
    }

    string name = filename.string::substr(0, len - 1);

    tokens = {directory, filename, name, filename_extension};
}

string get_directory(const string &path)
{
    vector<string> tokens;
    split_path(path, tokens);

    return tokens.front();
}

string get_name(const string &filename)
{
    vector<string> tokens;
    split(filename, tokens, char(46));

    return tokens.front();
}

string get_filename(const string &path)
{
    vector<string> tokens;
    split_path(path, tokens);

    return tokens[1];
}

string get_filename_extension(const string &path)
{
    vector<string> tokens;
    split_path(path, tokens);

    return tokens.back();
}

bool check_filename_extension(const string &path,
                              const string &extension)
{
    if (extension.compare(get_filename_extension(path)) == 0) {
        return true;
    }

    return false;
}

bool check_filename_extension(const string &path,
                              const unordered_map<string, string> &map_extension)
{
    if (map_extension.empty()) {
        return false;
    }

    if (path.empty()) {
        return false;
    }

    unordered_map<string, string>
    ::const_iterator it = map_extension.find(get_filename_extension(path));

    if (it == map_extension.end()) {
        return false;
    }

    return true;
}

bool check_extension(const string &extension,
                     const unordered_map<string, string> &map_extension)
{
    if (map_extension.empty()) {
        return false;
    }

    if (extension.empty()) {
        return false;
    }

    unordered_map<string, string>
    ::const_iterator it = map_extension.find(extension);

    if (it == map_extension.end()) {
        return false;
    }

    return true;
}

void add_suffix_filename(string &src, string new_src)
{
    string src_temp("");
    while (src.back() != '.') {
        src_temp = src.back() + src_temp;
        src.pop_back();
    }
    src.pop_back();
    src.append(new_src);
    src.push_back('.');
    src.append(src_temp);
}

/* I/O FILES */
string current_dir()
{
    char buffer[FILENAME_MAX];
    getcwd(buffer, FILENAME_MAX);

    return string(buffer);
}

template<typename T>
void save(const vector<T> &v, const string &path)
{
    const char terminator = '\n';

    if (v.empty()) {
        cout << "vector empty\n";
    }

    string path_temp = path;
    while (path_temp[0] == char(32)) {
        path_temp.erase(path_temp.begin());
    }

    if (path_temp.empty()) {
        cout << "path empty\n";
    }

    try {
        ofstream file_out(path_temp, ios::out);

        for (auto s : v) {
            file_out << s << terminator;
        }

        file_out.close();
    } catch (const exception &e) {
        cout << "path failure\n";
    }
}

void save_new_file(const string &path)
{
    string path_temp = path;
    while (path_temp[0] == char(32)) {
        path_temp.erase(path_temp.begin());
    }

    if (path_temp.empty()) {
        cout << "path empty\n";
    }

    try {
        ofstream file_out(path_temp, ios::out);
        file_out.close();
    } catch (const exception &e) {
        cout << "path failure\n";
    }
}

template<typename T>
void write(const T &value,  const string &path)
{
    string path_temp = path;
    while (path_temp[0] == char(32)) {
        path_temp.erase(path_temp.begin());
    }

    if (path_temp.empty()) {
        cout << "path empty\n";
    }

    try {
        ofstream file_out(path, ios::app);
        file_out << value;
        file_out.close();
    } catch (const exception &e) {
        cout << "path failure\n";
    }
}

void load(const string &path, vector<string> &v_txt)
{
    v_txt.clear();
    string line;

    string path_temp = path;
    while (path_temp[0] == char(32)) {
        path_temp.erase(path_temp.begin());
    }

    if (path_temp.empty()) {
        cout << "path empty\n";
    }

    try {

        ifstream filein(path_temp, ios::in);

        while (getline(filein, line)) {
            v_txt.push_back(line);
        }

        filein.close();
    } catch (const exception &e) {
        cout << "path failure\n";
    }
}

void files(vector<string> &list, const string &folder)
{
    try {
        list.clear();
        const char *path = const_cast<char *>(folder.c_str());

        DIR *dir;
        struct dirent *entry;
        char entry_path[PATH_MAX + 1];
        size_t path_len = strlen(path);

        if (path == NULL) {
            path = ".";
        }

        strncpy(entry_path, path, sizeof(entry_path));
        if (entry_path[path_len - 1] != '/') {
            entry_path[path_len] = '/';
            entry_path[path_len + 1] = '\0';
            ++path_len;
        }

        struct stat info;
        dir = opendir(path);

        while ((entry = readdir(dir)) != NULL) {
            strncpy(entry_path + path_len, entry->d_name,
                    sizeof(entry_path) - path_len);
            lstat(entry_path, &info);
            if (S_ISREG(info.st_mode)) {
                list.push_back(string(entry_path));
            }
        }
        closedir(dir);
    } catch (const exception &e) {
        cout << "error: files\n";
    }
}

bool exist_path(const string &path)
{
    struct stat info;

    return (stat(path.c_str(), &info) == 0);
}

void create_directory(const string &folder)
{
    try {
        if (exist_path(folder)) {
            cout << folder << " exist\n";
            return;
        }

        cout << "mkdir " << folder;
        if (mkdir(folder.c_str(), S_IRWXU | S_IRWXG |
                  S_IROTH | S_IXOTH) == 0) {
            cout << " ok\n";
        } else {
            cout << " failure" << '\n';
        }
    } catch (const exception &e) {
        cout << "create_directory";
    }
}
} // namespace ToolsBasic

#endif // __TOOLS_BASIC_H__