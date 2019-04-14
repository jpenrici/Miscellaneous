# -*- Mode: Python; coding: utf-8; indent-tabs-mpythoode: nil; tab-width: 4 -*-

'''
================================================================================
Objetivo: 
		Ordenação pelo método de Seleção Direta.
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

# vetores no Portugol Studio são passados por referência
def ordena_selecao_direta(v):
	# vetores iniciam o índice em zero
	ultimo = len(v) - 1

	# para i do primeiro elemento até o penúltimo inclusive (<=)
	for i in range(0, ultimo):
		pos_menor = i
		# para j do elemento posterior a i até o último inclusive
		for j in range(0, ultimo):
			if (v[j] < v[pos_menor]):
				# armmazenar a posição do valor menor
				pos_menor = j

		# troca de elementos
		auxiliar = v[pos_menor]
		v[pos_menor] = v[i]
		v[i] = auxiliar
		
		# verificando as mudanças
		print ("etapa " + str(i) + ", menor " + str(auxiliar) +
			" trocar por " + str(v[pos_menor]) + ":")
		print (v)

def inicio():
	vetor_inteiros = [10, 5, 9, -2, 13, -8, 4, -5]
	print ("vetor original: ")
	print (vetor_inteiros)
	ordena_selecao_direta(vetor_inteiros)
	print ("vetor ordenado: ")
	print (vetor_inteiros)

if __name__ == '__main__':
	inicio()