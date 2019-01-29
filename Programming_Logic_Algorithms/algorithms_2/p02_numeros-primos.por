/*
================================================================================
Objetivo:
		Verificar se um número natural 'N' é primo.
		Números naturais primos são aqueles que são divisíveis apenas por ele
		mesmo e por 1. Ou seja, se N é um número natural, então ele é primo
		se, e somente se, não existe outro número 1 < P < N que divida N.
		
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
		inteiro n, contador
		logico continue = verdadeiro		

		escreva("Digite -1 para sair, ")
		enquanto(continue) {
			escreva("número: ")
			leia(n)

			se(n >= 0) { 
				contador = 0
				para(inteiro i = 1; i <= n; i++) {
					se(n % i == 0) {
						contador = contador + 1	// achou um divisor
					}
				}

				escreva("O número ", n)
				se(contador == 2) {
					escreva(" é primo.\n") 
				} senao {
					escreva(" não é primo.\n") 
				}
			} senao {
				continue = falso
			}
		}
	}
}

/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 636; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */