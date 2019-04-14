/*
================================================================================
Objetivo:
		Converter número binário em inteiro.
Pratica:
		Tipos, Variáveis, Operadores
		Estrutura de Decisão
		Estrutura de Repetição
		Procedimentos
		Funções
		Bibliotecas
================================================================================		
*/  
programa
{
	inclua biblioteca Matematica --> m
	inclua biblioteca Texto --> t

	funcao real binario_para_inteiro(cadeia binario) {
		// utilização de potenciação no Portugol Studio requer tipo real
		real decimal = 0.0
		inteiro tamanho = t.numero_caracteres(binario) - 1

		escreva("\nnúmero binário com ", tamanho + 1, " bit(s).\n")
		para(inteiro i = tamanho; i >= 0; i--) {
			caracter bit = t.obter_caracter(binario, i)
			escreva("bit = ", bit, " => decimal = ", decimal * 1, " + (")
			se (bit == '1') {
				escreva("1 * 2^", tamanho - i, ")")
				decimal = decimal + m.potencia(2.0, (tamanho - i) * 1.0) // multiplicação força casting
				escreva(" = ", decimal, "\n")
			} senao {
				escreva("0 * 2^", tamanho - i, ") = 0\n")
			}
		}
		retorne decimal
	}

	// exibição do resultado
	funcao converta(cadeia binario) {
		escreva("(binário) ", binario," : ", binario_para_inteiro(binario), " (decimal)\n")
	}
	
	funcao inicio()
	{
		converta("0")
		converta("1")
		converta("11")
		converta("1010")
		converta("11111111")
		converta("100000000")

	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 634; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */