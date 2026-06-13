# Sublime_Text

Os arquivos deste diretório foram testados no **Sublime Text 3.2.2** e ambiente **Linux**.<br>

## Create_Sublime-Snippet_Cpp

Cria **snippets** de arquivo **C++ Header** para o Sublime Text.<br>

## Funcionamento

O script `create_snippets_cpp_header.py` lê o arquivo C++ Header e separa possíveis construtores e funções.<br>
A detecção é feita com o parêntesis. O caractere `(` inicia e o `)` fecha a leitura.<br>
Após a separação, os snippets são salvos no diretório `.\Output`.<br>
Uma lista de comandos correspondente é salvo no arquivo `output_snippets.csv`.<br>

## Exemplo

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

Ao executar `create_snippets_cpp_header.py` o resultado será:<br>

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

A função `create(...)` permite declarar um diretório de saída, um identificador para nomeclatura do arquivo `SCpp0N_IdenfierSnippetFunction.sublime-snippet` e a inserção de comentário `\* function() *\`.<br>

```python
def create(path_cppheader, directory_snippet, identifier, comment):
```

Ao final este snippet deve ser instalado no Sublime Text conforme documentação.<br>

## Learn more:

Sublime Text (Docs) <br>

**Attention:** Study the scripts and references before executing them.
