/*
================================================================================
Objetivo:
		Imprima um padrão espiral de linha reta, conforme o exemplo abaixo.
		Usando o * (asterisco) e . (ponto).

		***********
		..........*
		*********.*
		*.......*.*
		*.*****.*.*
		*.*...*.*.*
		*.*.***.*.*
		*.*.....*.*
		*.*******.*
		*.........*
		***********			

		Adaptado de:
					SPTTRN1 - Straight Line Spiral Pattern (Act 1)
					https://www.spoj.com/problems/SPTTRN1/

Pratica:
		Tipos, Variáveis, Operadores
		Estrutura de Decisão
		Estrutura de Repetição
		Bibliotecas
================================================================================        
*/ 
#include <iostream>

using std::cin;
using std::cout;
using std::string;

/*
 * O plano será simular uma matriz para controlar a posição do preenchimento,
 * utilizando uma string.
 * 
 * Matriz Quadrada (tamanho x tamanho)
 * O índice na String será igual a [Posição_Linha * Tamnho + Posição_Coluna]
 */
int main()
{
	int tamanho;
	string linha;

	// para melhor visualização o tamanho limite será até 80
	cout << "Digite um número inteiro entre 3 e 80: ";
	cin >> tamanho;

	if (tamanho < 3 || tamanho > 80) {
		cout << "Tamanho não permitido. Será usado o valor padrão igual a 10.\n";
		tamanho = 10;
	}
    
    // linha padrão preenchida pelo caracter '.'
	// linha = string(tamanho * tamanho, char(46));
	for (int i = 0; i < tamanho * tamanho; ++i) {
		linha += ".";
	}

	// controladores
    int x = 0, y = 0;
    int x0 = 0, y0 = 2;
    int x1 = tamanho - 1, y1 = tamanho - 1;
    int etapa = 0;

    // montagem
    while(true) {
        while(true) {
            linha[y * tamanho + x] = '*';

            // andar para a direita
            if (etapa % 4 == 0) {
                x++;
                if (x == x1) {
                    x1 -= 2;
                    break;
                }
            }

			// andar para baixo
            if (etapa % 4 == 1) {
                y++;
                if (y == y1) {
                    y1 -= 2;
                    break;
                }
            }

            // andar para a esquerda
            if (etapa % 4 == 2) {
                x--;
                if (x == x0) {
                    x0 += 2;
                    break;
                }
            }

            // andar para cima
            if (etapa % 4 == 3) {
                y--;
                if (y == y0){;
                    y0 += 2;
                    break;
                }
            }
        }
        // trocar a direção
        etapa++;

        if (etapa == tamanho) 
        	break;
    }
    // preencher a última posição
    linha[y * tamanho + x] = '*';

    // exibição do resultado sem formatação
    cout << "String:\n" << linha << "\n\nDesenho:";

    // exibição do resultado com formatação em linhas,
    // imprime caracter por caracter,
    // pulando para a linha seguinte quando igual ao tamanho
    for(int i = 0; i < linha.size(); ++i) {
        if (i % tamanho == 0 && tamanho != 0) cout << '\n';
        cout << linha[i];
    }
}

/*
Exemplos:

Input:
4
5
11 
13

Output:
****
...*
*..*
****

*****
....*
***.*
*...*
*****

***********
..........*
*********.*
*.......*.*
*.*****.*.*
*.*...*.*.*
*.*.***.*.*
*.*.....*.*
*.*******.*
*.........*
***********

*************
............*
***********.*
*.........*.*
*.*******.*.*
*.*.....*.*.*
*.*.***.*.*.*
*.*.*...*.*.*
*.*.*****.*.*
*.*.......*.*
*.*********.*
*...........*
*************

*/