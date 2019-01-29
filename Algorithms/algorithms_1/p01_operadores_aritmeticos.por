/*
================================================================================
Objetivo:
		Operações aritméticas simples
Pratica:
		Tipos, Variáveis, Constantes e Operadores
		Estruturas de Decisão
================================================================================
*/  
programa
{
	funcao inicio()
	{
		real primeiro, segundo, soma, subtracao, multiplicacao, divisao, resto
		
		escreva("Primeiro número: ")
		leia(primeiro)

		escreva("Segundo número: ")
		leia(segundo)

		se (primeiro < 0) {
			escreva(primeiro, " é negativo.\n")
		}
		
		se (segundo < 0) {
			escreva(segundo, " é negativo.\n")
		}

		soma = primeiro + segundo
		subtracao = primeiro - segundo
		multiplicacao = primeiro * segundo

		escreva (primeiro, " + ", segundo, " = ", soma, "\n")
		escreva (primeiro, " - ", segundo, " = ", subtracao, "\n")
		escreva (primeiro, " * ", segundo, " = ", multiplicacao, "\n")

		se (segundo == 0) {
			escreva("Não é permitido divisão por zero!\n")
		} senao {
			escreva (primeiro, " / ", segundo, " = ", primeiro/segundo, "\n")
		}
	}
}

/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 455; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */