/*
================================================================================
Objetivo:
		Demonstrar a diferença entre "Enquanto-Faça" e "Faça-Enquanto"
Pratica:
		Tipos, Variáveis, Operadores
		Estrutura de Repetição
================================================================================		
*/  
programa
{
	funcao inicio()
	{
		inteiro numero, repeticao, contador

		numero = 0	// para exemplificar a diferença
		
		contador = 0
		repeticao = numero
		enquanto(repeticao > 0) {
			contador++
			repeticao--
		}

		escreva("Diferença entre \"Enquanto-Faça\" e \"Faça-Enquanto\" para ", numero, " repetições.\n")
		escreva("\"Enquanto-faça\": ", contador, " executado vezes\n")
		
		contador = 0
		repeticao = numero
		faca {
			contador++
			repeticao--			
		} enquanto(repeticao > 0)

		escreva("\"Faça-enquanto\": ", contador, " executado vezes\n")
	}
}

/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 118; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */