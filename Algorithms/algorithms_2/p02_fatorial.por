/*
================================================================================
Objetivo:
		Calcular o fatorial.		
		fat(n) = n × (n − 1) × (n − 2) × . . . × 3 × 2 × 1 
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
		inteiro i, n, fat

		escreva("Fat(n), digite o valor de 'n': ")
		leia(n)

		escreva("Fat(", n, ") = ")
		
		i = n
		fat = 1	// inicialização do acumulador
		enquanto(i >= 1) {
			fat = fat * i
			se(i > 1) {
				escreva(i, " x ")
			} senao {
				escreva(i, " = ")
			}
			i = i - 1			
		}
		escreva(fat)
	}
}

/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 121; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */