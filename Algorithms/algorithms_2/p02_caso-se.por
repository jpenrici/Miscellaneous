/*
================================================================================
Objetivo:
		Exemplificar um menu para terminal
Pratica:
		Tipos, Variáveis, Operadores
		Estrutura de Decisão (Caso se)
		Estrutura de Repetição
		Bibliotecas
================================================================================		
*/  
programa
{
	inclua biblioteca Texto
	
	funcao inicio()
	{
		cadeia resposta
		logico flag = verdadeiro

		cadeia menu = "\n"
		menu += "       Menu       \n"
		menu += "------------------\n"
		menu += "1) Escreva Opção 1\n"
		menu += "2) Escreva Opção 2\n"
		menu += "3) Escreva Opção 3\n"
		menu += "\nEscolha uma opção: "

		enquanto(flag) {
			escreva(menu)
			leia(resposta)

			se(Texto.numero_caracteres(resposta) != 1) {
				resposta = "*" 
			}

			// O comando "escolha" espera uma expressão do tipo "inteiro" ou "caracter", caso contrário gera erro.
			escolha(Texto.obter_caracter(resposta,0)) {
				caso '1':
					escreva("Opção 1...")
					flag = falso
					pare
				caso '2':
					escreva("Opção 2...")
					flag = falso
					pare
				caso '3':
					escreva("Opção 3...")
					flag = falso
					pare		
				caso contrario:
					escreva("Opção inválida!")			
			}
		}
	}
}

/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 162; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */