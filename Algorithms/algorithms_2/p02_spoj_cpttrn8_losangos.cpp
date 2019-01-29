/*
================================================================================
Objetivo:
		Usando os caracteres ponto(.), asterisco(*) e barra(/ ou \).
		Desenhar um padrão de caracteres como sugerido abaixo.
		Usar o ponto para preencher os espaços.
		Entrada: número de linhas, de colunas e o tamanho do losango.
		
		Por exemplo:
		linhas = 2, colunas = 5, tamanho = 2
*/
//		./\../\../\../\../\.
//		/**\/**\/**\/**\/**\
//		\**/\**/\**/\**/\**/
//		.\/..\/..\/..\/..\/.
//		./\../\../\../\../\.
//		/**\/**\/**\/**\/**\
//		\**/\**/\**/\**/\**/
//		.\/..\/..\/..\/..\/.
/*
		Adaptado de:
					CCPTTRN8 - Character Patterns (Act 8)
					https://www.spoj.com/problems/CPTTRN8/

Pratica:
		Tipos, Variáveis, Operadores
		Estrutura de Decisão
		Estrutura de Repetição
		Vetores
		Bibliotecas
================================================================================        
*/
#include <iostream>
#include <vector>

using namespace std;

int main()
{
    int t(0), linhas(0), colunas(0), tamanho(0);

    cout << "Digite o número de linhas, de colunas e o tamanho: ";
    cin >> linhas >> colunas >> tamanho;
    
    vector<string> v_out(2 * tamanho);
    for (int i = 0; i < tamanho; ++i) {
        string linha_superior(""), linha_inferior("");
        string borda = string(tamanho - i - 1, char(46));
        string centro = string(2 * i, char(42));
        for (int j = 0; j < colunas; ++j) {
            linha_superior += borda + char(47) + centro + char(92) + borda; 
            linha_inferior += borda + char(92) + centro + char(47) + borda;                         
        }
        v_out[i] = linha_superior;
        v_out[2 * tamanho - i - 1] = linha_inferior;
    }

    while(linhas--) {
        for (string s: v_out) 
            cout << s << "\n";
    }

    return 0;
}

// Exemplos

// Input:
// 3 1 2 
// 4 4 1 
// 2 5 2

// Output:
// ./\.
// /**\
// \**/
// .\/.
// ./\.
// /**\
// \**/
// .\/.
// ./\.
// /**\
// \**/
// .\/.

// /\/\/\/\
// \/\/\/\/
// /\/\/\/\
// \/\/\/\/
// /\/\/\/\
// \/\/\/\/
// /\/\/\/\
// \/\/\/\/

// ./\../\../\../\../\.
// /**\/**\/**\/**\/**\
// \**/\**/\**/\**/\**/
// .\/..\/..\/..\/..\/.
// ./\../\../\../\../\.
// /**\/**\/**\/**\/**\
// \**/\**/\**/\**/\**/
// .\/..\/..\/..\/..\/.