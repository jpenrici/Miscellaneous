/*
================================================================================
Objetivo:
		Imprimir a tabuada para um número inteiro.
Pratica:
		Tipos, Variáveis, Operadores
		Estrutura de Decisão
		Estrutura de Repetição (Aninhadas)
		Bibliotecas
================================================================================		
*/  
programa
{
	inclua biblioteca Texto
	
	funcao inicio()
	{
		inteiro numero, i
		cadeia resposta
		logico continuar = verdadeiro		// flag

		enquanto(continuar) {
			escreva("Tabuada. Digite o número: ")
			leia(numero)

			escreva("TABUADA de ", numero, "\n")

			i = 0
			enquanto(i <= 10) {
				escreva(numero, " x ", i, " = ", numero * i, "\n")
				i = i + 1
			}

			resposta = ""
			enquanto(resposta == "") {
				escreva("\nCalcular outro número? Sim/Não (S/N)? ")
				leia(resposta)
				se (resposta != "") {
					se (resposta == "Não" ou resposta == "Nao" ou
					    resposta == "não" ou resposta == "nao" ou
					    Texto.obter_caracter(resposta, 0) == 'N' ou
					    Texto.obter_caracter(resposta, 0) == 'n') {
						continuar = falso
					}
				}
			}
		}
	}
}
						




/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 562; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */