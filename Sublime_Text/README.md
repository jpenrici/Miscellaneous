# Sublime_Text

The files in this directory were tested on **Sublime Text version 3.2.2**, running on **Linux**, **Debian 9** and **OpenBox**.<br>

[README-pt-BR](https://github.com/jpenrici/Miscellaneous/blob/master/Sublime_Text/README-pt-BR.md)

## Some Details

In the directory **`Sublime-Build`** the codes have as main objective, to facilitate the compilation and the visualization of the execution (results) in the terminal emulator, which in this case is the `xfce4-terminal`.<br>
There are other terminal emulators on Linux like `gnome-terminal`, ` xterm`, `konsole`, among others.

Example: <br>

**`C++17_xfce4-terminal.sublime-build`**<br>

```
{
  "cmd": ["bash", "-c", "g++ -std=c++17 '${file}' -o '${file_path}/${file_base_name}' && xfce4-terminal -e 'bash -c \"${file_path}/${file_base_name};echo;echo;echo Compilation Completed C++17;echo Press ENTER to continue; read line; rm ${file_path}/${file_base_name}; exit; exec bash\"'"],
  "file_regex": "^(..[^:]*):([0-9]+):?([0-9]+)?:? (.*)$",
  "working_dir": "${file_path}",
  "selector": "source.c, source.c++, source.cxx, source.cpp"
}
```
<br>

Explaining the steps:<br>

1. **Bash** is called to execute a sequence of commands, the first is from the compiler **g++**.<br>
- `"bash", "-c", "g++ -std=c++17 '${file}' -o '${file_path}/${file_base_name}'` ...<br>
2. Compiled the file **C++**, it will be opened in the external terminal, opening a window of **xfce4-terminal**. <br>
- `&& xfce4-terminal -e` ...<br>
3. In **xfce4-terminal** another sequence of Bash commands is executed which in short will run the executable C++ file, process and at the end write "Press ENTER to continue" and wait for "ENTER". When using the keyboard, Bash removes the executable file and the object file, returning to the initial state.
- `'bash -c \"${file_path}/${file_base_name};echo;echo;echo Compilation Completed C++17;echo Press ENTER to continue; read line; rm ${file_path}/${file_base_name}; exit` ...<br>

## Know more:

[xfce4-terminal](https://docs.xfce.org/apps/terminal/start) (Terminal do XFCE4) <br>
[Sublime Text](https://www.sublimetext.com/docs/3/build_systems.html) (DOCUMENTATION Build Systems) <br>
