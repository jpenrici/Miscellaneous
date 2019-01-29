/*
================================================================================
Objetivo:
		Simples utilização de matrizes e seus detalhes.
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
		const inteiro MAX = 10

		// declaração e alocação de memória
		real matriz[MAX][MAX]

		// preenchimento
		para(inteiro linha = 0; linha < MAX; linha++) {
			para(inteiro coluna = 0; coluna < MAX; coluna++) {
				matriz[linha][coluna] = (linha * 10 + coluna) / 10.0
			}
		}

		// exibição
		escreva("\t\tColuna\n\t\t")
		para(inteiro i = 0; i < MAX; i++) {
			escreva(i,"\t")
		}
		escreva("\nLinha\t")
		para(inteiro linha = 0; linha < MAX; linha++) {
			escreva(linha, "\t")
			para(inteiro coluna = 0; coluna < MAX; coluna++) {
				se(linha == coluna) {
					escreva(matriz[linha][coluna], " *\t")
				} senao {
					escreva(matriz[linha][coluna], "\t")
				}
			}
			escreva("\n\t")
		}
	}
}

/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 358; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */