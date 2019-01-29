/*
================================================================================
Objetivo:
		Simples utilização de vetores e seus detalhes.
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
		const inteiro MAX = 10

		// declaração e alocação de memória
		real vetor[MAX]

		// preenchimento
		para(inteiro i = 0; i < MAX; i++) {
			vetor[i] = i * 1.0
		}

		// alteração
		vetor[5] = 0.0

		// exibição
		para(inteiro i = 0; i < MAX; i++) {
			escreva("posição ", i, ", valor: ", vetor[i], "\n")
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