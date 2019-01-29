/*
================================================================================
Objetivo:
		Uso de operadores lógicos
Pratica:
		Tipos, Variáveis, Constantes e Operadores
		Estruturas de Decisão
================================================================================		
*/  
programa
{
	funcao inicio()
	{
		caracter entrada
		logico primeiro, segundo

		escreva("Primeiro valor lógico (V - verdadeiro, F - falso):")
		leia(entrada)

		se(entrada == 'V' ou entrada == 'v') {
			primeiro = verdadeiro
		} senao {
			primeiro = falso
		}

		escreva("Segundo valor lógico (V - verdadeiro, F - falso):")
		leia(entrada)

		se(entrada == 'V' ou entrada == 'v') {
			segundo = verdadeiro
		} senao {
			segundo = falso
		}
		
		escreva("NÂO ", primeiro, " = ", nao(primeiro), "\n")
		escreva("NÂO ", segundo, " = ", nao(segundo), "\n")
		escreva(primeiro, " E ", segundo, " = ", (primeiro e segundo), "\n")
		escreva(primeiro, " OU ", segundo, " = ", (primeiro ou segundo), "\n")
	}				
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 405; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */