/*
================================================================================
Objetivo:
		Imprimir número de 3 dígitos invertido.
		
Pratica:
		Tipos, Variáveis, Operadores
		Estrutura de Decisão
		Estrutura de Repetição
================================================================================		
*/  
programa
{
	funcao inicio()
	{
		inteiro numero, unidade, dezena, centena, inverso

		faca {
			escreva("Entre com o número de três dígitos: ")
			leia(numero)
		} enquanto(numero < 100 ou numero > 999)

		centena = numero / 100
		dezena = (numero % 100) / 10
		unidade = numero % 10
		inverso = unidade * 100 + dezena * 10 + centena
		escreva("Inverso: ", inverso)
	}
}

/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 503; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */