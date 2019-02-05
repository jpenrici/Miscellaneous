/*
================================================================================
Objetivo:
		Fórmula de Bhaskara.
		Calcular as raízes da equação do segundo grau ax^2 − bx + c = 0.
Pratica:
		Tipos, Variáveis, Constantes e Operadores
		Estrutura de Decisão
		Bibliotecas
================================================================================		
*/  
programa
{
	inclua biblioteca Matematica
	
	funcao inicio()
	{
		/*	
		 * x: incógnita
		 * a: coeficiente quadrático
		 * b: coeficiente linear
		 * c: coeficiente constante
		 * delta: discriminante
		 * x1, x2: raízes resultantes
		 */
		real a, b, c, x1, x2, delta

		escreva("Digite o valor de a:")
		leia(a)

		se (a == 0) {
			escreva("\"a\" deve ser diferente de \"0\"\"\n")
			escreva("não é uma equação do segundo grau!")
		} senao {
			escreva("Digite o valor de b:")
			leia(b)

			escreva("Digite o valor de c:")
			leia(c)

			delta = ((b * b) - (4 * a * c))

			se (delta > 0) {
				escreva("Delta: ", delta, "\n")
				x1 = (-b + Matematica.raiz(delta, 2.0)) / 2 * a
				x2 = (-b - Matematica.raiz(delta, 2.0)) / 2 * a
				se (x1 == x2) {
					escreva("x = ", x1, "\traiz única")
				} senao {
					escreva("x1 = ", x1, "\nx2 = ", x2)
				}
			} senao {
				escreva("delta negativo!\n")
				escreva("resultado não pertence aos reais")
			}
		}
	}
}

/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 434; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */