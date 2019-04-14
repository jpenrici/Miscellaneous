/*
================================================================================
Objetivo: 
		Ordenação pelo método de Seleção Direta.
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

	// imprime os valores do vetor
	funcao exibe (inteiro v[]) {
		inteiro tamanho_vetor = u.numero_elementos(v)
		para(inteiro i = 0; i < tamanho_vetor; i++) {
			escreva (v[i], " ")
		}
		escreva("\n")
	}

	// vetores no Portugol Studio são passados por referência
	funcao ordena_selecao_direta(inteiro v[]) {
		// vetores iniciam o índice em zero
		inteiro ultimo = u.numero_elementos(v) - 1
		inteiro i, j, pos_menor, auxiliar

		// para i do primeiro elemento até o penúltimo inclusive (<=)
		para(i = 0; i <= ultimo -1; i++) {
			pos_menor = i
			// para j do elemento posterior a i até o último inclusive
			para(j = i + 1; j <= ultimo; j++) {
				se (v[j] < v[pos_menor]) {
					// armmazenar a posição do valor menor
					pos_menor = j
				}
			}
			// troca de elementos
			auxiliar = v[pos_menor]
			v[pos_menor] = v[i]
			v[i] = auxiliar
			
			// verificando as mudanças
			escreva(" etapa ", i, ", menor ", auxiliar, " trocar por ", v[pos_menor], ": ")
			exibe(v)
		}
	}

	funcao inicio() {
		inteiro vetor_inteiros[] = {10, 5, 9, -2, 13, -8, 4, -5}
		escreva("vetor original: ")
		exibe(vetor_inteiros)
		ordena_selecao_direta(vetor_inteiros)
		escreva("vetor ordenado: ")
		exibe(vetor_inteiros)
	}

}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 1103; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */