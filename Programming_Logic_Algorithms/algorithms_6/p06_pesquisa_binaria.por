/*
================================================================================
Objetivo: 
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
	inteiro vetor_inteiros[] = {-10, -5, 0, 1, 3, 4, 6, 8}	// ORDENADO OBRIGATORIAMENTE
	inteiro tamanho_vetor = u.numero_elementos(vetor_inteiros)

	funcao inteiro busca_binaria(inteiro x) {
		inteiro inicio = 0				// aponta para o inicio do vetor
		inteiro fim = tamanho_vetor - 1 	// aponta para o último do vetor
		inteiro meio = (inicio + fim) / 2

		enquanto((vetor_inteiros[meio] != x) e (fim >= inicio)) {
			se(vetor_inteiros[meio] > x) {
				fim = meio + 1
			} senao {
				inicio = meio + 1
			}
			meio = (inicio + fim) / 2
		}

		se(vetor_inteiros[meio] == x) {
			retorne meio
		} senao {
			retorne -1
		}
	}

	// imprime os valores do vetor
	funcao exibe () {
		para(inteiro i = 0; i < tamanho_vetor; i++) {
			escreva ("[",i,"]= ",vetor_inteiros[i], " ")
		}
		escreva("\n")
	}	

	funcao pesquisar(inteiro x) {
		inteiro resultado = busca_binaria(x)
		se (resultado == -1) {
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
 * @POSICAO-CURSOR = 824; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */