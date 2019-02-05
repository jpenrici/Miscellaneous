algoritmo "Pesquisa Sequencial Simples"
//
// encoding='ISO-8859-1'
//
//==============================================================================
//Objetivo:
//    Pesquisa (Busca) Sequencial.
//
//Pratica:
//		Tipos, Variáveis, Operadores
//		Estrutura de Decisão
//		Estrutura de Repetição
//		Procedimentos
//		Funções
//		Vetores
//==============================================================================

procedimento exibe
var
	i: inteiro
inicio
	escreva("Vetor: ")
	para i de 0 ate tamanhoVetor - 1 faca
   		escreva(vetorDeNumeros[i])
	fimpara
	escreval()
fimprocedimento

funcao buscaSimples(x: inteiro): inteiro
var
	i, posicao, ultimo: inteiro

inicio
	posicao <- -1
	ultimo <- tamanhoVetor - 1
	para i de 0 ate ultimo faca
   		se x = vetorDeNumeros[i] entao
      		posicao <- i
   		fimse
	fimpara
	retorne posicao
fimfuncao

procedimento pesquisar(x: inteiro)
var
	resultado: inteiro

inicio
	resultado <- buscaSimples(x)
	se (resultado < 0) entao
		escreval("valor ", x, " não encontrado!")
	senao
		escreval("valor ", x, " encontrado na posição ", resultado)
	fimse
fimprocedimento

var
	vetorDeNumeros : vetor[0..7] de inteiro
	tamanhoVetor: inteiro

inicio
	// atribuições iniciais para variáveis globais
	tamanhoVetor <- 8
	vetorDeNumeros[0] <- 8
	vetorDeNumeros[1] <- -10
	vetorDeNumeros[2] <- 0
	vetorDeNumeros[3] <- 6
	vetorDeNumeros[4] <- 1
	vetorDeNumeros[5] <- -5
	vetorDeNumeros[6] <- 4
	vetorDeNumeros[7] <- 3

	// busca
	exibe
	pesquisar(0)
	pesquisar(-5)
	pesquisar(100)
fimalgoritmo
