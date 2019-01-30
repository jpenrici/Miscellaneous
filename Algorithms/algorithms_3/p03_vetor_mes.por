/*
================================================================================
Objetivo:
		Escreva o nome do mês por extenso, a partir de um número (1 a 12).
Pratica:
		Tipos, Variáveis, Operadores
		Estrutura de Decisão
		Estrutura de Repetição
		Vetores
================================================================================		
*/  
programa
{
	
	funcao inicio()
	{
		cadeia mes[12] = {"Janeiro", "Fevereiro", "Março", "Abril", "Maio",
			"Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro",
			"Dezembro"}

		inteiro numero
		logico flag = verdadeiro

		enquanto(flag) {
			escreva("Digite um número entre 1 e 12: ")
			leia(numero)

			se(numero < 1 ou numero > 12) {
				escreva("Valor inválido. Sair!")
				flag = falso
			} senao {
				escreva(mes[numero - 1], "\n")
			}
		}			
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 583; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */