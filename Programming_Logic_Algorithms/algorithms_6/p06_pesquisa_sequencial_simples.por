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
	inteiro vetor_inteiros[] = {8, -10, 0, 6, 1, -5, 4, 3}	// desordenado
	inteiro tamanho_vetor = u.numero_elementos(vetor_inteiros)

	funcao inteiro busca_simples(inteiro x) {
		inteiro posicao = -1
		inteiro ultimo = tamanho_vetor - 1
		// vetores iniciam o índice em zero
		para(inteiro i = 0; i <= ultimo; i++) {
			se(x == vetor_inteiros[i]) {
				posicao = i
			}
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
		inteiro resultado = busca_simples(x)
		se (resultado < 0) {
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
 * @POSICAO-CURSOR = 858; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */