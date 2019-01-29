/*
================================================================================
Objetivo:
		Simples utilização de vetores.
		Entrar números inteiros em um vetor e separar os pares dos ímpares.
		Exibir o vetor de origem na sequência de entrada.
		Exibir os demais vetores na sequência contrária a entrada.
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
		inteiro pos_ultimo_par, pos_ultimo_impar
		inteiro vetor[MAX], vetor_par[MAX], vetor_impar[MAX]

		// entrada de dados
		pos_ultimo_par = 0
		pos_ultimo_impar = 0
		para(inteiro i = 0; i < MAX; i++) {
			escreva("Digite o valor da posição [", i , "] :")
			leia(vetor[i])
			se(vetor[i] % 2 == 0) {
				vetor_par[pos_ultimo_par] = vetor[i]
				pos_ultimo_par++
			} senao {
				vetor_impar[pos_ultimo_impar] = vetor[i]
				pos_ultimo_impar++				
			}
		}

		// exibir sequência
		escreva("vetor  :")
		para(inteiro i = 0; i < MAX; i++) {
			escreva(" ", vetor[i])			
		}
		escreva("\n")
			
		escreva("pares   :")
		para(inteiro i = pos_ultimo_par - 1; i >= 0; i--) {
			escreva(" ", vetor_par[i])			
		}
		escreva("\n")
		
		escreva("impares :")
		para(inteiro i = pos_ultimo_impar - 1; i >= 0; i--) {
			escreva(" ", vetor_impar[i])			
		}	
	}
}

/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 397; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */