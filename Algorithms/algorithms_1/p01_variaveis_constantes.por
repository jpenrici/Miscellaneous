/*
================================================================================
Objetivo:
		Declaração de variáveis e constantes.
Pratica:
		Tipos, Variáveis, Constantes
================================================================================		
*/
programa
{
	funcao inicio()
	{
		const cadeia LINHA = "------------------------------"
		const caracter ESPACO = '\t'
		const caracter FIM = '\n'

		real float = 100.0
		inteiro int = 100
		logico bool = verdadeiro
		caracter borda = '|'
		cadeia string = "string"

		cadeia concatenacao = "\\" + "o" + "/"

		escreva(LINHA, FIM)
		escreva(borda, "Inteiro      ", ESPACO, int, FIM)
		escreva(borda, "Real         ", ESPACO, float, FIM)
		escreva(borda, "Caracter     ", ESPACO, 'A', FIM)
		escreva(borda, "Lógico       ", ESPACO, bool, FIM)
		escreva(borda, "Cadeia       ", ESPACO, string, FIM)
		escreva(borda, "Concatenação ", ESPACO, concatenacao, FIM)
		escreva(LINHA, FIM)
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 459; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */