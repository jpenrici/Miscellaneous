/*
================================================================================
Objetivo:
		Usando os caracteres ponto(.) e asterisco(*).
		Desenhar um padrão de caracteres como sugerido abaixo,
		onde serão fornecidos o número de linhas e de colunas.
		Cada quadrado da grade é do mesmo tamanho (4 pontos).

		Por exemplo:
		linhas e colunas = 4

		*************
		*..*..*..*..*
		*..*..*..*..*
		*************
		*..*..*..*..*
		*..*..*..*..*
		*************
		*..*..*..*..*
		*..*..*..*..*
		*************
		*..*..*..*..*
		*..*..*..*..*
		*************

		Adaptado de:
					CPTTRN3 - Character Patterns (Act 3)
					https://www.spoj.com/problems/CPTTRN3/

Pratica:
		Tipos, Variáveis, Operadores
		Estrutura de Decisão
		Estrutura de Repetição
		Bibliotecas
================================================================================		
*/ 
programa {

	funcao inicio() {

		cadeia linha
		inteiro linhas, colunas

		faca {
			escreva("Digite o número de linhas: ")
			leia(linhas)

			escreva("Digite o número de colunas: ")
			leia(colunas)

			se (linhas <= 0 ou colunas <= 0) {
				escreva("valores inválidos!\n")
			}
		} enquanto (linhas <= 0 ou colunas <= 0)

		escreva("\nDesenho:\n")
		para(inteiro i = 0; i <= 3 * linhas; i++) {
			linha = ""
			para(inteiro j = 0; j < 3 * colunas + 1; j++) {
				se (i % 3 == 0) {
					linha += "*"
				} senao {
					se (j % 3 == 0) {
						linha += "*"
					} senao {
						linha += "."
					}
				}
			}
			escreva(linha, "\n")
		}
	}
}

/*

Digite o número de linhas: 2
Digite o número de colunas: 5

Desenho:
****************
*..*..*..*..*..*
*..*..*..*..*..*
****************
*..*..*..*..*..*
*..*..*..*..*..*
****************

*/
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 959; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */