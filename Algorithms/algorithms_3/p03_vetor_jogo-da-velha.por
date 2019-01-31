/*
================================================================================
Objetivo:
		Jogo da Velha

                     ===================
                        JOGO DA VELHA
                     ===================

                       0     1     2      Coluna
                     ------|-----|-----			   
         Linha 0       0     1     2   <= Número
                     ------|-----|-----    da
               1       3     4     5      Célula
                     ------|-----|-----
               2       6     7     8

         Número da Célula = 3 * Linha + Coluna
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
		// definições
		const cadeia TITULO 	= "   JOGO DA VELHA   "
		const cadeia LINHA_1	= "==================="		
		const cadeia LINHA_2	= "  ----|-----|----  "
		const cadeia ESPACO		= "    "
		const caracter EOL	= '\n'
		const caracter VAZIO	= '.'
		const inteiro CELULAS = 9

		// Possibilidades de fechar a sequência
		const inteiro JOGADAS[8][3] = {
			// horizontal
			{0, 1, 2}, {3, 4, 5}, {6, 7, 8},
			// vertical
			{0, 3, 6}, {1, 4, 7}, {2, 5, 8},
			// diagonal
			{0, 4, 8}, {2, 4, 6}
		}

		// inicialização
		caracter tabuleiro[9] = {
			// linha 0
			VAZIO, VAZIO, VAZIO, // COLUNA 0 1 2
			// linha 1
			VAZIO, VAZIO, VAZIO, // COLUNA 0 1 2
			// linha 2
			VAZIO, VAZIO, VAZIO  // COLUNA 0 1 2
		}
		caracter jogador[2] = {'X', '0'}
		inteiro jogador_atual = 0
		inteiro linha = 1, coluna = 1
		inteiro possibilidades = 9, jogada = 0
		inteiro ganhador = -1, i = 0

		// jogar
		escreva(TITULO, EOL)
		enquanto (possibilidades > 0 e ganhador == -1) {

			// fazer uma jogada
			faca {
				escreva(EOL)
				escreva("Jogador ", jogador_atual + 1, " [  ")
				escreva(jogador[jogador_atual],"  ]", EOL)
				escreva("Linha? ")
				leia(linha)
				escreva("Coluna? ")
				leia(coluna)
			} enquanto (tabuleiro[3 * linha + coluna] != VAZIO) 

			// marcar no tabuleiro
			tabuleiro[3 * linha + coluna] = jogador[jogador_atual]
			possibilidades = possibilidades - 1
			jogada = jogada + 1

			// checar se jogador atual ganhou
			i = 0
			logico continuar = verdadeiro
			enquanto(i < 8 e continuar) {
				se(tabuleiro[JOGADAS[i][0]] == jogador[jogador_atual] e
				   tabuleiro[JOGADAS[i][1]] == jogador[jogador_atual] e
				   tabuleiro[JOGADAS[i][2]] == jogador[jogador_atual]) {
				   	continuar = falso
				   	ganhador = jogador_atual + 1
				   }
				   i = i + 1
			}

			// exibir tabuleiro
			escreva(LINHA_1, EOL, TITULO, EOL, LINHA_1, EOL)
			escreva("Jogada: ", jogada, EOL)
			para(i = 0; i < CELULAS; i++) {
				se(i % 3 == 0) {
					escreva(EOL, LINHA_2, EOL)
				}
				escreva(ESPACO, tabuleiro[i])		
			}
			escreva(EOL)

			// trocar jogador
			se (jogador_atual == 0) {
				jogador_atual = 1
			} senao {
				jogador_atual = 0
			}
		}

		// exibir ganhador
		escreva(LINHA_1, EOL, TITULO, EOL, LINHA_1, EOL)
		se(ganhador != -1) {
			escreva("*** Jogador ", ganhador, " ***")
		} senao {
			escreva("Empate!")
		}
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 1310; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */