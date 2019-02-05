/*
================================================================================
Objetivo:
		Imprimir o Máximo Divisor Comum (MDC) entre dois números dados.
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
		inteiro primeiro, segundo, resto

		escreva("O MDC de dois números inteiros é o maior número inteiro que divide ambos sem deixar resto.\n")
		escreva("https://pt.wikipedia.org/wiki/Algoritmo_de_Euclides \n\n")
		
		escreva("Primeiro número: ")
		leia(primeiro)

		escreva("Segundo número: ")
		leia(segundo)

		se (primeiro != 0 e segundo != 0) {
			
			escreva("MDC(", primeiro, "; ", segundo, ") = ")
			
			resto = primeiro % segundo
			enquanto(resto != 0) {
				primeiro = segundo
				segundo = resto
				resto = primeiro % segundo 
			}
			escreva(segundo)
		} senao {
			escreva("O algoritmo não funciona para entradas nulas.")
		}
	}
}

/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 588; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */