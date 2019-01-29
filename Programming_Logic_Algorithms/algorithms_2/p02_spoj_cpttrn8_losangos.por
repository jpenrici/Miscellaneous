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
		Bibliotecas
================================================================================		
*/ 
programa {

	funcao inicio() {
		
		cadeia borda, centro
		cadeia linha_superior, linha_inferior
		cadeia bloco_superior, bloco_inferior
		inteiro i, j, k, linhas, colunas, tamanho

		faca {
			escreva("Digite o número de linhas: ")
			leia(linhas)

			escreva("Digite o número de colunas: ")
			leia(colunas)

			escreva("Digite o número do tamanho: ")
			leia(tamanho)			

			se (linhas <= 0 ou colunas <= 0 ou tamanho <= 0) {
				escreva("valores inválidos!\n")
			}
		} enquanto (linhas <= 0 ou colunas <= 0)

		escreva("\nDesenho:\n")
		bloco_superior = ""
		bloco_inferior = ""
		para(i = 0; i < tamanho; i++) {
			borda = ""
			centro = ""
			linha_superior = ""
			linha_inferior = ""
			para(j = 0; j < (tamanho - i - 1); j++) {
				borda += "."
			}
			para(j = 0; j < (2 * i); j++) {
				centro += "*"
			}			
			para(k = 0; k < colunas; k++) {
				linha_superior += borda + "/" + centro + "\\" + borda
				linha_inferior += borda + "\\" + centro + "/" + borda
			}
			bloco_superior = bloco_superior + linha_superior + "\n"
			bloco_inferior = linha_inferior + "\n" + bloco_inferior
		}

		para(i = 0; i < linhas; i++) {
			escreva(bloco_superior)
			escreva(bloco_inferior)
		}
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 744; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */