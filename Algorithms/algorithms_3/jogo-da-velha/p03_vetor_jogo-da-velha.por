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
	inclua biblioteca Tipos
	inclua biblioteca Arquivos

	// variável global
	logico arquivo_novo = verdadeiro

	// Salvar em arquivo externo a tabela verdade
	funcao exportar_tabela_verdade(cadeia texto_saida)
	{
		inteiro endereco
		se (arquivo_novo) {
			// cria um arquivo vazio
			endereco = Arquivos.abrir_arquivo("velha_tab-verdade.txt", Arquivos.MODO_ESCRITA)
			arquivo_novo = nao arquivo_novo
		} senao {
			// agrega conteúdo ao final do arquivo
			endereco = Arquivos.abrir_arquivo("velha_tab-verdade.txt", Arquivos.MODO_ACRESCENTAR)
		}
		Arquivos.escrever_linha(texto_saida, endereco)
		Arquivos.fechar_arquivo(endereco)
	}

	// principal
	funcao inicio()
	{
		// definições
		const cadeia TITULO 	= "   JOGO DA VELHA   "
		const cadeia LINHA_1	= "==================="		
		const cadeia LINHA_2	= "  ----|------|-----"
		const cadeia ESPACO		= "   "
		const cadeia ESPACO_1    = "  |"
		const cadeia EOL		= "\n"
		const caracter VAZIO	= '.'
		const inteiro CELULAS 	= 9

		// Possibilidades de fechar a sequência
		const inteiro JOGADAS[8][3] = {
			// na horizontal
			{0, 1, 2}, {3, 4, 5}, {6, 7, 8},
			// na vertical
			{0, 3, 6}, {1, 4, 7}, {2, 5, 8},
			// na diagonal
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
		caracter jogador[2] = {'X', 'O'}
		inteiro jogador_atual = 0
		inteiro linha = 1, coluna = 1
		inteiro possibilidades = 9, jogada = 0
		inteiro ganhador = -1, i = 0

		// para observação da tabela verdade
		const cadeia SEP = ";"	// separador para abrir no excel
		const logico SALVAR = verdadeiro

		cadeia texto_saida
		texto_saida = "jogador_atual" + SEP
		texto_saida += "linha" + SEP
		texto_saida += "coluna" + SEP
		texto_saida += "possibilidades" + SEP
		texto_saida += "jogada" + SEP 
		texto_saida += "i" + SEP
		texto_saida += "tab[JOG[i][0]]" + SEP
		texto_saida += "tab[JOG[i][1]]" + SEP
		texto_saida += "tab[JOG[i][2]]" + SEP
		texto_saida += "ganhador" + SEP
		texto_saida += "continuar" + SEP
		texto_saida += "i < 8 e continuar"
		// salvar cabeçalho
		se (SALVAR) { exportar_tabela_verdade(texto_saida) }

		// jogar
		escreva(TITULO, EOL)
		enquanto (possibilidades > 0 e ganhador == -1) {

			// fazer uma jogada
			faca {
				escreva(EOL)
				escreva("Jogador ", jogador_atual + 1, " [  ")
				escreva(jogador[jogador_atual],"  ]", EOL)
				
				faca {	// evitar erro de posição inválida
					escreva("Linha? ")
					leia(linha)
				} enquanto (linha < 0 ou linha > 2)

				faca {
					escreva("Coluna? ")
					leia(coluna)
				} enquanto (coluna < 0 ou coluna > 2)

			// repete até que encontre uma posição livre
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

				// atualização da tabela verdade
				texto_saida = jogador[jogador_atual] + SEP
				texto_saida += Tipos.inteiro_para_cadeia(linha, 10) + SEP
				texto_saida += Tipos.inteiro_para_cadeia(coluna, 10) + SEP
				texto_saida += Tipos.inteiro_para_cadeia(possibilidades, 10) + SEP
				texto_saida += Tipos.inteiro_para_cadeia(jogada, 10) + SEP 
				texto_saida += Tipos.inteiro_para_cadeia(i, 10) + SEP
				texto_saida += tabuleiro[JOGADAS[i][0]] + SEP
				texto_saida += tabuleiro[JOGADAS[i][1]] + SEP
				texto_saida += tabuleiro[JOGADAS[i][2]] + SEP
				texto_saida += Tipos.inteiro_para_cadeia(ganhador, 10) + SEP
				texto_saida += Tipos.logico_para_cadeia(continuar) + SEP
				texto_saida += Tipos.logico_para_cadeia(i < 8 e continuar)
				
				se (SALVAR) { 
					// escreva(texto_saida, EOL)
					exportar_tabela_verdade(texto_saida)
				}				   
			
				i = i + 1		  
			}

			// exibir tabuleiro
			escreva(LINHA_1, EOL, TITULO, EOL, LINHA_1, EOL)
			escreva("Jogada: ", jogada, EOL)
			para(i = 0; i < CELULAS; i++) {
				se(i % 3 == 0 e i != 0) {
					escreva(EOL, LINHA_2, EOL)
				}
				escreva(ESPACO, tabuleiro[i])
				se(i != 2 e  i != 5 e i != 8) {
					escreva (ESPACO_1)		
				}
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
			texto_saida = "*** Jogador " // tabela verdade
			texto_saida +=  Tipos.inteiro_para_cadeia(ganhador, 10) + " ***"
		} senao {
			escreva("Empate!")
			texto_saida = "Empate!" // tabela verdade
		}
		se (SALVAR) { exportar_tabela_verdade(texto_saida) }		
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 5484; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */