/*
================================================================================
Objetivo:
		Imprimir todos os números palíndromos entre 1 e 1000.

		Números palíndromos são aqueles que são lidos da direita para a
		esquerda da mesma maneira que da esquerda para a direita.
		Por exemplo o número 12321 é palíndromo, enquanto que 123 não é.
		
Pratica:
		Tipos, Variáveis, Operadores
		Estrutura de Decisão
		Estrutura de Repetição
================================================================================		
*/  
programa
{
	funcao inicio()
	{
		const inteiro MAX = 10000
		inteiro i, n, invertido, limite_linha

		i = 1
		limite_linha = 10
		enquanto(i <= MAX) {
			invertido = 0	// inicializa o acumulador
			n = i

			enquanto(n != 0) {
				invertido = invertido * 10 + n % 10
				n = n / 10
			}

			// imprime se for palindromo
			se(invertido == i) {
				escreva("\t", i, " ")
				
				// formatar exibição
				limite_linha = limite_linha - 1
				se(limite_linha < 0) {
					escreva("\n")
					limite_linha = 10
				}				
			}
			i = i + 1
		}
		
	}
}

/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 1055; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */