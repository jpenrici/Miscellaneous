/*
================================================================================
Objetivo:
		Operadores condicionais.
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
		
		escreva("Digite o primeiro número (real ou inteiro): ")
		leia(primeiro)

		escreva("Degite o Segundo número (real ou inteiro): ")
		leia(segundo)

		se (primeiro == segundo) {
			escreva(primeiro, " é igual a ", segundo, "\n")
		}

		se (primeiro > segundo) {
			escreva(primeiro, " é maior que ", segundo, "\n")
		}

		se (primeiro < segundo) {
			escreva(primeiro, " é menor que ", segundo, "\n")
		}

		se (primeiro >= segundo) {
			escreva(primeiro, " é maior ou igual a ", segundo, "\n")
		}

		se (primeiro <= segundo) {
			escreva(primeiro, " é menor ou igual a ", segundo, "\n")
		}

		se (primeiro != segundo) {
			escreva(primeiro, " é diferente de ", segundo, "\n")
		}
	}				
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 791; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */