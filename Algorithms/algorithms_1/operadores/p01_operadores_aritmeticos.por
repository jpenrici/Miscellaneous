/*
================================================================================
Objetivo:
		Operações aritméticas simples.
Pratica:
		Tipos, Variáveis, Constantes e Operadores
		Estruturas de Decisão
================================================================================
*/  
programa
{
	funcao inicio()
	{
		real primeiro, segundo
		real soma, subtracao, multiplicacao, divisao
		inteiro resto, quociente, converte1, converte2
		
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
			
			converte1 = primeiro			// conversão implícita
			converte2 = segundo				// real para inteiro

			divisao = primeiro / segundo
			resto = converte1 % converte2		// módulo requer inteiros

			// conversão implícita para obter somente a parte inteira
			quociente = (primeiro - resto) / segundo	

			escreva (primeiro, " / ", segundo, " = ", divisao, "\n")
			escreva ("\ndivisor x quocinete + resto = dividendo\n")
			escreva (segundo, " x ", quociente, " + ", resto, " = ")
			escreva (segundo * quociente + resto, "\n")
			escreva ("quociente = ", quociente, "\nresto = ", resto, "\n")
		}
	}
}

/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 1608; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */