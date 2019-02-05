/*
================================================================================
Objetivo:
		Simples utilização de vetores.
		Exibir o maior e menor número sem ordenar ou pesquisar o vetor.
Pratica:
		Tipos, Variáveis, Operadores
		Estrutura de Decisão
		Estrutura de Repetição
		Vetores
================================================================================		
*/  
programa
{
	funcao inicio()
	{
		const inteiro MAX = 5
		inteiro pos_maior, pos_menor
		
		real vetor[MAX]

		// entrada de dados
		pos_maior = 0
		pos_menor = 0
		para(inteiro i = 0; i < MAX; i++) {
			
			escreva("Digite o valor da posição [", i , "] :")
			leia(vetor[i])
			
			// checar maior e menor durante a entrada.
			// válido somente quando não existirem valores no vetor.
			se(vetor[pos_maior] < vetor[i]) {
				pos_maior = i
			}
			se(vetor[pos_menor] > vetor[i]) {
				pos_menor = i
			}
		}

		// exibir sequência
		para(inteiro i = 0; i < MAX; i++) {
			escreva("[", i, "]: ", vetor[i])
			escolha(i) {
				caso pos_menor:
					escreva("\tmenor")
				caso pos_maior:
					escreva("\tmaior")
				caso contrario:
					escreva("\n")
			}
			
		}		
		
	}
}

/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 657; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */