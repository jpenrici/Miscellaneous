# Sublime_Text

The files in this directory were tested in **Sublime Text 3.2.2** and **Linux**.<br>

[README-pt-BR](https://github.com/jpenrici/Miscellaneous/blob/master/Sublime_Text/Create_Sublime-Snippet_Cpp/README-pt-BR.md)

## Create_Sublime-Snippet_Cpp

Creates **snippets** from file **C++ Header** for Sublime Text.<br>

## Operation

The `create_snippets_cpp_header.py` script reads the C++ Header file and separates possible constructors and functions.<br>
Detection is done with parentheses. The character `(` starts and `)` closes the reading.<br>
After separation, the snippets are saved in the `.\Output` directory.<br>
A corresponding list of commands is saved in the `output_snippets.csv` file.<br>

## Example

```c++
/*
 * Test : create_snippets_cpp_header.py
 *
 */
#ifndef __Test_H__
#define __Test_H__

#include <iostream>
#include <vector>

using namespace std;

#define TEST 100

 class Test
 {
 public:
    Test() { /* block */ }
    Test(string name) : name(name) {}
    ~Test() { std::cout << "goodbye ..." << std::endl;}
    
    string getName() { return name; }
    string get() { return "Name:" + getName(); }

    string get(
        int num1,
        float num2,
        double num3,
        bool isOk, 
        vector<string> strVector,
        vector<vector< double> > matrix
    );
    
    void setName(string name); // comments
    void clear();   /* comments */

private:
    string name;
};

#endif // __Test_H__
```

When running `create_snippets_cpp_header.py` the result will be:<br>

```xml
<!-- Automatically built. Update as needed! -->
<snippet>
    <description>get(num1,num2,num3,isOk,strVector,matrix)</description>
    <content><![CDATA[/* string get(int num1,float num2,double num3,bool isOk,vector<string> strVector,vector<vector< double> > matrix)  */
get(${1:/* num1 */},${2:/* num2 */},${3:/* num3 */},${4:/* isOk */},${5:/* strVector */},${6:/* matrix */})]]></content>
    <tabTrigger>get</tabTrigger>
    <scope>source.c++</scope>
</snippet> 
```

The `create (...)` function allows you to declare an output directory, an identifier for the `SCpp0N_IdenfierSnippetFunction.sublime-snippet` file name and the comment insert `\* function () *\`.<br>

```python
def create(path_cppheader, directory_snippet, identifier, comment):
```

When finished, this snippet must be installed in Sublime Text according to the documentation.<br>

## Learn more:

[Sublime Text](https://www.sublimetext.com/docs/3/) (Docs) <br>

**Attention:** Study the scripts and references before executing them.
