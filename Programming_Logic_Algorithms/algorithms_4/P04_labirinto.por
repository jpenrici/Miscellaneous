/*
================================================================================
Objetivo:
		Encontrar a saída do labirinto.
		Uso da recursão.

			Entrada
				.#######
				.....###
				####..##
				#...#.##
				#.#...##
				..######
				.#...###
				...#....
					  Saída
	
Pratica:
		Tipos, Variáveis, Operadores
		Estrutura de Decisão
		Estrutura de Repetição
		Procedimentos
		Funções
		Matrizes
================================================================================		
*/  
programa
{
	// mapa e variáveis - declaração global
	const inteiro LARGURA = 8, COMPRIMENTO = 8
	inteiro labirinto[LARGURA][COMPRIMENTO] = {
		{0, 1, 1, 1, 1, 1, 1, 1},
		{0, 0, 0, 0, 0, 1, 1, 1},
		{1, 1, 1, 1, 0, 0, 1, 1},
		{1, 0, 0, 0, 1, 0, 1, 1},
		{1, 0, 1, 0, 0, 0, 1, 1},
		{0, 0, 1, 1, 1, 1, 1, 1},
		{0, 1, 0, 0, 0, 1, 1, 1},
		{0, 0, 0, 1, 0, 0, 0, 3}						
	}
	logico saida_encontrada = falso


	// imprimir mapa com símbolos
	funcao exibir()
	{
		caracter parede = '#'
		caracter caminho = ' '
		caracter visitado = '.'
		para(inteiro linha = 0; linha < LARGURA; linha++) {
			para(inteiro coluna = 0; coluna < COMPRIMENTO; coluna++) {
				escolha(labirinto[linha][coluna]) {
					caso 1:
						escreva(parede)
						pare
					caso 2:
						escreva(visitado)
						pare
					caso contrario:
						escreva(caminho)
						pare
				}
			}
			escreva("\n")
		}		
	}

	// checar se coordenada está no mapa
	funcao logico validar(inteiro x, inteiro y)
	{
		// checar se está dentro do mapa
		se(x < 0 ou x > COMPRIMENTO - 1) {
			retorne falso
		}
		se(y < 0 ou y > LARGURA - 1) {
			retorne falso
		}
		retorne verdadeiro
	}

	funcao caminhar(inteiro x, inteiro y)
	{
		se(validar(x,y)) {
			se(labirinto[y][x] == 0) {
				// coordenada liberada, marcar
				labirinto[y][x] = 2
				// procurar recursivamente nova saída
				escreva("D")
				caminhar(x + 1, y)
				escreva("S")
				caminhar(x, y - 1)
				escreva("I")
				caminhar(x, y + 1)
				escreva("E")
				caminhar(x - 1, y)
				// possibilidades esgotadas
				escreva(".")
			}
			// checar se posição corresponde a saída
			se(labirinto[y][x] == 3) {
				labirinto[y][x] = 2
				saida_encontrada = verdadeiro
			}
		}
	}

	funcao inicio()
	{
		inteiro x = 0, y = 0 // ponto de partida

		// procurar saída
		escreva("Sequência de tentativas:\n")
		caminhar(x, y)
		escreva("\nSáida encontrada: ", saida_encontrada, "\n")
		exibir()
	}
}

/*

Sequência de tentativas:
DSIDDDDDSIDDSIDSIDSIEDSIEDSDSIEDSIEDSIDSIDSIEDSIDSIDDDSDDDSIDDDSIE.SIE.SIE.E.SIE.SIE.IE.SIE.SIE.E.E..E.E...IE...E.E.SIE.E.SIE.SIE.SIE.SIE.E.
Sáida encontrada: verdadeiro
.#######
.....###
####..##
#...#.##
#.#...##
..######
.#...###
...#....

*/

/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 2669; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */