/*
================================================================================
Objetivo:
		Operações aritméticas simples.
		Uso de operador % (módulo ou resto).
Pratica:
		Tipos, Variáveis, Constantes e Operadores
		Estruturas de Decisão
================================================================================		
*/  
programa
{
	funcao inicio()
	{
		inteiro numero

		escreva("Digite um número inteiro: ")
		leia(numero)

		escreva(numero)
		se (numero % 2 == 0) {
			escreva(" é par")
		} senao {
			escreva(" é ímpar")
		}
	}
}

/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 332; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */