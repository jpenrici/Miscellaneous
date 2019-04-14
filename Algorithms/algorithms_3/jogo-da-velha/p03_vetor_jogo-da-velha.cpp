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
#include <iostream>
#include <vector>

using std::cout;
using std::cin;
using std::string;
using std::vector;

int main()
{
	// definições
	const string TITULO 	= "   JOGO DA VELHA   ";
	const string LINHA_1	= "===================";	
	const string LINHA_2	= "  ----|-----|----  ";
	const string ESPACO		= "    ";
	const char EOL	= '\n';
	const char VAZIO	= '.';
	const int CELULAS = 9;

	// Possibilidades de fechar a sequência
	const vector<vector<int> > JOGADAS {
		// horizontal
		{0, 1, 2}, {3, 4, 5}, {6, 7, 8},
		// vertical
		{0, 3, 6}, {1, 4, 7}, {2, 5, 8},
		// diagonal
		{0, 4, 8}, {2, 4, 6}
	};

	// inicialização
	vector<char> tabuleiro{
		// linha 0
		VAZIO, VAZIO, VAZIO, // COLUNA 0 1 2
		// linha 1
		VAZIO, VAZIO, VAZIO, // COLUNA 0 1 2
		// linha 2
		VAZIO, VAZIO, VAZIO  // COLUNA 0 1 2
	};
	
	vector<char> jogador = {'X', '0'};
	int jogador_atual = 0;
	int linha = 1, coluna = 1;
	int possibilidades = 9, jogada = 0;
	int ganhador = -1, i = 0;

	// jogar
	cout << TITULO, EOL;
	while (possibilidades > 0 && ganhador == -1) {

		// fazer uma jogada
		do {
			cout << EOL;
			cout << "Jogador " << jogador_atual + 1 << " [  ";
			cout << jogador[jogador_atual] << "  ]" << EOL;
			cout << "Linha e Coluna? ";
			cin >> linha >> coluna;
		} while (tabuleiro[3 * linha + coluna] != VAZIO);

		// marcar no tabuleiro
		tabuleiro[3 * linha + coluna] = jogador[jogador_atual];
		possibilidades = possibilidades - 1;
		jogada = jogada + 1;

		// checar se jogador atual ganhou
		i = 0;
		bool continuar = true;
		while(i < 8 && continuar) {
			if(tabuleiro[JOGADAS[i][0]] == jogador[jogador_atual] &&
			   tabuleiro[JOGADAS[i][1]] == jogador[jogador_atual] &&
			   tabuleiro[JOGADAS[i][2]] == jogador[jogador_atual]) {
			   	continuar = false;
			   	ganhador = jogador_atual + 1;
			   }
			   i = i + 1;
		}

		// exibir tabuleiro
		cout << LINHA_1 << EOL << TITULO << EOL << LINHA_1 << EOL;
		cout << "Jogada: " << jogada << EOL;
		for(i = 0; i < CELULAS; i++) {
			if(i % 3 == 0) {
				cout << EOL << LINHA_2 << EOL;
			}
			cout << ESPACO << tabuleiro[i];
		}
		cout << EOL;

		// trocar jogador
		if(jogador_atual == 0) {
			jogador_atual = 1;
		} else {
			jogador_atual = 0;
		}
	}

	// exibir ganhador
	cout << LINHA_1 << EOL << TITULO << EOL << LINHA_1 << EOL;
	if(ganhador != -1) {
		cout << "*** Jogador " << ganhador << " ***";
	} else {
		cout << "Empate!";
	}

	return 0;
}