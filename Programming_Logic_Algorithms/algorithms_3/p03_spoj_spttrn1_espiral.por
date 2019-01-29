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
		Matrizes
================================================================================        
*/ 
programa
{
	
	funcao inicio()
	{
		const inteiro TAMANHO = 10
		caracter matriz[TAMANHO][TAMANHO]

		// preenchimento
		para(inteiro linha = 0; linha < TAMANHO; linha++) {
			para(inteiro coluna = 0; coluna < TAMANHO; coluna++) {
				matriz[linha][coluna] = '.'
			}
		}

		// controladores
		inteiro x = 0, y = 0
    		inteiro x0 = 0, y0 = 2
    		inteiro x1 = TAMANHO - 1, y1 = TAMANHO - 1
    		inteiro etapa = 0
    		logico montar = verdadeiro
    		logico continuar = verdadeiro

		// montagem
		enquanto(montar) {
			enquanto(continuar) {
    				matriz[y][x] = '*'
    				
    				// andar para a direita
        			se(etapa % 4 == 0) {
            			x = x + 1
            			se(x == x1) {
                			x1 -= 2
                			continuar = falso
            			}
        			}

				// andar para baixo
        			se(etapa % 4 == 1) {
            			y = y + 1
            			se(y == y1) {
                			y1 -= 2
                			continuar = falso          			
            			}
        			}        			

    				// andar para esquerda
        			se(etapa % 4 == 2) {
            			x = x - 1
            			se(x == x0) {
                			x0 += 2
                			continuar = falso       			
            			}
        			}

    				// andar para cima
        			se(etapa % 4 == 3) {
            			y = y - 1
            			se(y == y0) {
                			y0 += 2
                			continuar = falso           			
            			}
        			}
			}
			// troacr etapa
			etapa = etapa + 1
			continuar = verdadeiro
 
    			se(etapa == TAMANHO) {
    				montar = falso
    			}
		}
    				       			
		// exibição
		para(inteiro linha = 0; linha < TAMANHO; linha++) {
			para(inteiro coluna = 0; coluna < TAMANHO; coluna++) {
				escreva(matriz[linha][coluna])
			}
			escreva("\n")
		}			
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 726; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */