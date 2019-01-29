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

	// imprime os valores do vetor
	funcao exibe (inteiro v[]) {
		inteiro tamanho_vetor = u.numero_elementos(v)
		para(inteiro i = 0; i < tamanho_vetor; i++) {
			escreva (v[i], " ")
		}
		escreva("\n")
	}

	// vetores no Portugol Studio são passados por referência
	funcao ordena_insercao_direta(inteiro v[]) {
		// vetores iniciam o índice em zero
		inteiro ultimo = u.numero_elementos(v) - 1
		inteiro i, j, auxiliar
		// para i do segundo elemento até o último inclusive (<=) 
		para(i = 1; i <= ultimo; i++) {
			auxiliar = v[i]
			j = i - 1
			enquanto(j >= 0 e v[j] > auxiliar) {
				v[j + 1] = v[j]
				j = j - 1
			}
			v[j + 1] = auxiliar
			
			// verificando as mudanças
			escreva(" etapa ", i, ": ")
			exibe(v)			
		}
	}

	funcao inicio() {
		inteiro vetor_inteiros[] = {8, -10, 0, 6, 1, -5, 4, 3}
		escreva("vetor original: ")
		exibe(vetor_inteiros)
		ordena_insercao_direta(vetor_inteiros)
		escreva("vetor ordenado: ")
		exibe(vetor_inteiros)
	}

}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 723; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */