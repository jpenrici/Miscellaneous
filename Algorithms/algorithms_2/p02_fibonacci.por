/*
================================================================================
Objetivo:
		Calcular a sequência de Fibonacci.
		Sendo os dois primeiros valores são 1 e 1. Os seguintes são obtidos
		pela soma dos dois anteriores. Assim, a sequência de Fibonacci é:
		1, 1, 2, 3, 5, 8, 13, 21, 34, 55, . . .
		
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
		const inteiro MAX = 46	// capacidade do inteiro no Portugol Studio 
		inteiro ultimo, penultimo, soma, contador

		ultimo = 1
		penultimo = 1
		escreva("1 ) ", penultimo, "\n")
		escreva("2 ) ", ultimo, "\n")
		contador = 3

		enquanto(contador <= MAX) {
			soma = penultimo + ultimo
			escreva(contador, " ) ", soma, "\n")
			penultimo = ultimo
			ultimo = soma
			contador = contador + 1
		}
	}
}

/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 648; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */