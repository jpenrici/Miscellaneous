# -*- Mode: Python; coding: utf-8; indent-tabs-mpythoode: nil; tab-width: 4 -*-

'''
================================================================================
Objetivo:
		Pesquisa (Busca) Sequencial.
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
vetor_inteiros = [8, -10, 0, 6, 1, -5, 4, 3]	# desordenado
tamanho_vetor = len(vetor_inteiros)

def busca_simples(x):
	global vetor_inteiros, tamanho_vetor
	posicao = -1
	ultimo = tamanho_vetor - 1
	# vetores iniciam o índice em zero
	for i in range(0,ultimo):
		if(x == vetor_inteiros[i]):
			posicao = i
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
	resultado = busca_simples(x)
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