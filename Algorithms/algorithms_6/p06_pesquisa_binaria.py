# -*- Mode: Python; coding: utf-8; indent-tabs-mpythoode: nil; tab-width: 4 -*-

'''
================================================================================
Objetivo: 
		Pesquisa (Busca) Binária.
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
vetor_inteiros = [-10, -5, 0, 1, 3, 4, 6, 8]	# ORDENADO OBRIGATORIAMENTE
tamanho_vetor = len(vetor_inteiros)

def busca_binaria(x):
	global vetor_inteiros, tamanho_vetor
	pos_inicial = 0					# aponta para o inicio do vetor
	pos_final = tamanho_vetor - 1 	# aponta para o último do vetor
	meio = (pos_inicial + pos_final) / 2

	while((vetor_inteiros[meio] != x) and (pos_final >= pos_inicial)):
		if(vetor_inteiros[meio] > x):
			pos_final = meio + 1
		else:
			pos_inicial = meio + 1
		meio = (pos_inicial + pos_final) / 2

	if(vetor_inteiros[meio] == x):
		return meio
	else:
		return -1

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
	resultado = busca_binaria(x)
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