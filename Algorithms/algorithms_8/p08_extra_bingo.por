/*
    Desafio de Programação
    ----------------------

    Desenvolva um script para um Jogo de Bingo Simples no terminal.

    Regra:

	 A cartela terá 05 números.
	 O jogador deverá escolher cinco possibilidades de números entre 0 e 60.
	 O computador irá sortear 05 números e ao final exibir quantos valores o jogador acertou.    	  

    Fonte:

      https://pt.wikipedia.org/wiki/Bingo

    Tema:

      Tipos, Variáveis, Operadores
      Estrutura de Decisão
      Estrutura de Repetição
      Vetores
*/

programa
{
	inclua biblioteca Util --> u
	
	funcao inicio()
	{
		// Constantes
		const cadeia  EOL    = "\n"
		const inteiro LIMITE   = 61 // 0 a 60, são 61 números
		const inteiro INICIO   = 0
		const inteiro FINAL    = 60
    const inteiro ESCOLHAS = 5

		// Variáveis
		inteiro numeros1[LIMITE]		// Marca números escolhidos. Evitar repetições.
		inteiro numeros2[LIMITE]	  // Marca números sorteados. Evitar repetições.
		inteiro cartela[ESCOLHAS]   // Armazena números escolhidos.
		inteiro sorteios[ESCOLHAS]  // Armazena números sorteados.
		inteiro acertos =  0
		inteiro i, valor

		// Limpar
		para (i = 0; i < LIMITE; i++) {
			numeros1[i] = -1 // Marca número como livre.
			numeros2[i] = -1 // Marca número como livre.
		}

		escreva("Bem-vindo!", EOL)
		escreva("Escolha ", ESCOLHAS, " números entre ", INICIO, " e ", FINAL, " :", EOL)    

		// Escolher números
	  i = 0
		enquanto (i < ESCOLHAS) {
			escreva("Número[", i + 1, "]: ")
			leia(valor)
			se (valor < INICIO ou valor > FINAL) {
				escreva("Valor ", valor, " fora do limite!", EOL)
			} senao {
				se (numeros1[valor] == -1) {
					numeros1[valor] = 1   // Marca número como escolhido.
					cartela[i] = valor    // Armazena escolha.
					i++
				} senao {
					escreva("Valor ", valor, " já escolhido!", EOL)
				}
			}
		}

		// Sortear números
	  i = 0
	  escreva("Sorteando ")
		enquanto (i < ESCOLHAS) {
			valor = u.sorteia(INICIO, FINAL)
			se (numeros2[valor] < 0) {
				u.aguarde(1000)       // Pausa por 1 segundo. 
        escreva(".")
				numeros2[valor] = 1   // Marca número como sorteado.
				sorteios[i] = valor   // Armazena sorteio.
				i++
			}
		}

		// Exibir cartela
	  escreva(EOL, "Sua cartela: [ ")
	  para(i = 0; i < ESCOLHAS; i++) {
	    	escreva(cartela[i], " ")
	  }
	  escreva("]", EOL)		

		// Exibir cartela
	  escreva("Sorteados: [ ")
	  para(i = 0; i < ESCOLHAS; i++) {
	    	escreva(sorteios[i], " ")
	    	se (numeros1[sorteios[i]] > 0) {
	    		acertos++
	    }
	  }
	  escreva("]", EOL)

		se (acertos == 0) {
			escreva(EOL, "Você não acertou nenhum número!")
		} senao {
			escreva(EOL, "Você acertou ", acertos, " número(s)!")
		}
		
	}

}