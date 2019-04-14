# -*- Mode: Python; coding: utf-8; indent-tabs-mpythoode: nil; tab-width: 4 -*-

'''
================================================================================
Objetivo: 
		Ordenação pelo método de Inserção Direta.
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

# imprime os valores do vetor
def exibe (v):
	tamanho_vetor = len(v)
	for i in range(0, tamanho_vetor):
		print (v[i], " ")
	print ("\n")

# vetores no Portugol Studio são passados por referência
def ordena_insercao_direta(v):
	# vetores iniciam o índice em zero
	ultimo = len(v) - 1
	# para i do segundo elemento até o último inclusive (<=) 
	for i in range(0, ultimo):
		auxiliar = v[i]
		j = i - 1
		while(j >= 0 and v[j] > auxiliar):
			v[j + 1] = v[j]
			j = j - 1
		v[j + 1] = auxiliar
		
		# verificando as mudanças
		print ("etapa " + str(i) + ":")
		print (v)			

def inicio():
	vetor_inteiros= [8, -10, 0, 6, 1, -5, 4, 3]
	print ("vetor original: ")
	print (vetor_inteiros)
	ordena_insercao_direta(vetor_inteiros)
	print ("vetor ordenado: ")
	print (vetor_inteiros)

if __name__ == '__main__':
	inicio()