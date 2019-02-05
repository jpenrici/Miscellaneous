/*
================================================================================
Objetivo:
		Converter número inteiro em binário.
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
	funcao cadeia inteiro_para_binario(inteiro decimal)
	{
		cadeia binario = ""
		inteiro resto

		se(decimal == 0) {
			retorne "0"
		}
		
		enquanto(decimal > 0) {
			
			resto = decimal %  2
			decimal = decimal / 2

			se(resto == 0) {
				binario = "0" + binario				
			} senao se (resto == 1) {
				binario = "1" + binario	
			}
		}
		retorne binario
	}

	// exibição do resultado
	funcao converta(inteiro decimal) {
		escreva(decimal,": ", inteiro_para_binario(decimal), "\n")
	}
	
	funcao inicio()
	{
		converta(0)
		converta(1)
		converta(3)
		converta(5)
		converta(10)
		converta(100)
		converta(127)
		converta(128)
		converta(255)
		converta(256)
		converta(512)
		converta(1024)
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 712; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */