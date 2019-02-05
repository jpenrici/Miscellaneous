/*
================================================================================
Objetivo:
		Operações aritméticas simples.
		Estudo do operador módulo (resto ou %).
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

		escreva("digite um número inteiro: ")
		leia(numero)

		escreva("O número ", numero, " é divisível por: ")
		se (numero % 2 == 0) {
			escreva("2 ")
		}
		se (numero % 3 == 0) {
			escreva("3 ")
		}
		se (numero % 4 == 0) {
			escreva("4 ")
		}
		se (numero % 5 == 0) {
			escreva("5 ")
		}
		se (numero % 6 == 0) {
			escreva("6 ")
		}
		se (numero % 7 == 0) {
			escreva("7 ")
		}
		se (numero % 8 == 0) {
			escreva("8 ")
		}
		se (numero % 9 == 0) {
			escreva("9 ")
		}			
	}
}

/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 412; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */