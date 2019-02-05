/*
================================================================================
Objetivo:
		Triângulo de Pascal, que é um triângulo numérico infinito formado por
		números binomiais.
		Onde cada número é igual à soma do número imediatamente acima e do
		antecessor do número de cima.

                        1 
                      1   1 
                    1   2   1 
                 1    3   3   1 
               1   [4] [6]  4   1 
             1   5   =10  10  5   1

Pratica:
		Tipos, Variáveis, Operadores
		Estrutura de Decisão
		Estrutura de Repetição
		Matriz
================================================================================		
*/  
programa
{
	funcao inicio()
	{
		const inteiro NUM = 5
		inteiro  linha, coluna, colunas, anterior

		anterior = 1
		para(linha = 0; linha <= NUM; linha++) {
			colunas = linha + 1
			escreva(anterior, " ")
			para(coluna = 1; coluna < colunas; coluna++) {
				anterior = anterior * (linha - coluna + 1)/ coluna
				escreva(anterior, " ")
			}
			escreva("\n")
		}
	}
}

/*
Output:

1 
1 1 
1 2 1 
1 3 3 1 
1 4 6 4 1 
1 5 10 10 5 1 
*/

/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 727; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */