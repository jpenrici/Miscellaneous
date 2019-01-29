/*
================================================================================
Objetivo:
		Exemplo de uso das variáveis local e global.
Pratica:
		Tipos, Variáveis, Operadores
		Funções
================================================================================		
*/ 
programa
{
	// variável global
	inteiro numero = -1

	funcao escreva_variavel_local()
	{
		// variavel local
		inteiro numero = 2
		escreva("número(variável local) = ",numero,"\n")
	}
	
	funcao inicio()
	{
		// imprime a variável declarada global
		escreva("número(variável global) = ",numero,"\n")
		// chama a função que imprime a variável declarada local
		escreva_variavel_local()
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 140; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */