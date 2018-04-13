#include <cerrno>
#include <dirent.h>
#include <string.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/types.h>

#include <iostream>
using std::string;
using std::cout;
using std::cerr;

#include <vector>
using std::vector;

#include <fstream>
using std::ofstream;

void list_path_files(vector<string>& list, const char* path)
{
    DIR* dir;
    struct dirent* entry;
    char entry_path[PATH_MAX + 1];
    size_t path_len = strlen(path);

    if (path == NULL) path = ".";

    strncpy (entry_path, path, sizeof(entry_path));
    if (entry_path[path_len - 1] != '/') {
        entry_path[path_len] = '/';
        entry_path[path_len + 1] = '\0';
        ++path_len;
    }

    dir = opendir(path);
    if (!dir) {
        cerr << path << " Error: " << strerror(errno)  << '\n';
        return;
    }

    struct stat info;
    while ((entry = readdir(dir)) != NULL) {
        strncpy(entry_path + path_len, entry->d_name,
            sizeof (entry_path) - path_len);
        lstat (entry_path, &info);
        if (S_ISDIR(info.st_mode) && entry_path[path_len] != '.') {
            list_path_files(list, entry_path);
        } else if (S_ISREG(info.st_mode)) {
            list.push_back(entry_path);
        } else if (S_ISLNK(info.st_mode)) {
            list.push_back(entry_path);
        }
    }

    closedir(dir);
}

int main(int argc, char const *argv[])
{
    cout << "started...\n";

    if (argc < 2) {
        cerr << "Usage: " << argv[0] << " [dir_name]\n";
        return (EXIT_FAILURE);
    }

    vector<string> dirs;
    list_path_files(dirs, argv[1]);

    ofstream out("list_path.txt");
    for (string dir: dirs)
        out << '\"' << dir << "\"\n";

    out.close();

    cout << "output: list_path.txt\n";

    return (EXIT_SUCCESS);
}
