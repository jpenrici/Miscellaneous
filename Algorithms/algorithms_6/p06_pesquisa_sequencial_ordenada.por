/*
================================================================================
Objetivo: 
		Pesquisa (Busca) Sequencial Ordenada.
Pratica:
		Tipos, Variáveis, Operadores
		Estrutura de Decisão
		Estrutura de Repetição
		Procedimentos
		Funções
		Vetores
		Bibliotecas
================================================================================		
*/
programa {

	inclua biblioteca Util --> u

	// declaração global
	inteiro vetor_inteiros[] = {-10, -5, 0, 1, 3, 4, 6, 8}	// ORDENADO
	inteiro tamanho_vetor = u.numero_elementos(vetor_inteiros)
	inteiro ultimo = tamanho_vetor - 1

	funcao inteiro busca_ordenada(inteiro x) {
		inteiro posicao = 0
		enquanto(posicao < ultimo e vetor_inteiros[posicao] != x) {
			posicao = posicao + 1
		}
		retorne posicao
	}

	// imprime os valores do vetor
	funcao exibe () {
		para(inteiro i = 0; i < tamanho_vetor; i++) {
			escreva ("[",i,"]= ",vetor_inteiros[i], " ")
		}
		escreva("\n")
	}	

	funcao pesquisar(inteiro x) {
		inteiro resultado = busca_ordenada(x)
		se (resultado == ultimo) {
			escreva("valor ", x," não encontrado!\n")
		}
		senao {
			escreva("valor ", x," encontrado na posição ", resultado, "\n")
		}
	}
	
	funcao inicio() {

		exibe()
		pesquisar(0)
		pesquisar(-5)
		pesquisar(100)

	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 260; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */