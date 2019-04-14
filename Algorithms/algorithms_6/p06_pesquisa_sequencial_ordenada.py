# -*- Mode: Python; coding: utf-8; indent-tabs-mpythoode: nil; tab-width: 4 -*-

'''
================================================================================
Objetivo: 
		Pesquisa (Busca) Sequencial Ordenada.
Pratica:
		Tipos, Variáveis, Operadores
		Estrutura de Decisão
		Estrutura de Repetição
		Procedimentos
		Funções
		Vetores
		Bibliotecas
		Python 2.7		
================================================================================		
'''

# declaração global
vetor_inteiros = [-10, -5, 0, 1, 3, 4, 6, 8]	# ORDENADO
tamanho_vetor = len(vetor_inteiros)
ultimo = tamanho_vetor - 1

def busca_ordenada(x):
	global vetor_inteiros, tamanho_vetor
	posicao = 0
	while(posicao < ultimo and vetor_inteiros[posicao] != x):
		posicao = posicao + 1
	if (posicao >= ultimo):
		return -1 
	return posicao

# imprime os valores do vetor
def exibe(vetor):
	saida = ""
	tamanho_vetor = len(vetor)
	for i in xrange(tamanho_vetor):
		saida += str(vetor[i])
		if (i < tamanho_vetor - 1):
			saida += ";"
	if (not saida == ""):
		print(saida)		

def pesquisar(x):
	resultado = busca_ordenada(x)
	if (resultado == -1):
		print("valor " + str(x) + " não encontrado!")
	else:
		print("valor " + str(x) + " encontrado na posição " + str(resultado))

def inicio():

	exibe(vetor_inteiros)
	pesquisar(0)
	pesquisar(-5)
	pesquisar(100)

if __name__ == '__main__':
	inicio()