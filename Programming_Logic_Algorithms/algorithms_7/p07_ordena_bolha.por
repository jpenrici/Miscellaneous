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
	funcao exibe (inteiro v[], inteiro bolha) {
		inteiro tamanho_vetor = u.numero_elementos(v)
		para(inteiro i = 0; i < tamanho_vetor; i++) {
			se (i == bolha) {
				escreva (v[i], "* ")
			} senao {
				escreva (v[i], " ")
			}
		}
		escreva("\n")
	}

	// vetores no Portugol Studio são passados por referência
	funcao ordena_bolha(inteiro v[]) {
		// vetores iniciam o índice em zero
		inteiro ultimo = u.numero_elementos(v) - 1
		inteiro i, bolha, auxiliar
		// para i do primeiro elemento até o último inclusive (<=) 
		para(i = 0; i <= ultimo; i++) {
			bolha = i
			enquanto (bolha > 0) {
				se (v[bolha] < v[bolha - 1]) {
					auxiliar = v[bolha - 1]	// troca
					v[bolha - 1] = v[bolha]
					v[bolha] = auxiliar
					bolha = bolha - 1		// bolha "sobe"
				} senao {
					bolha = 0			// fim da "subida"
				}
				// verificando mudança
				exibe(v, bolha)
			}		
		}
	}

	funcao inicio() {
		inteiro vetor_inteiros[] = {10, 5, 9, -2, 13, -8, 4, 12}
		escreva("vetor original: ")
		exibe(vetor_inteiros, 0)
		ordena_bolha(vetor_inteiros)
		escreva("vetor ordenado: ")
		exibe(vetor_inteiros, 0)
	}

}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 1087; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */