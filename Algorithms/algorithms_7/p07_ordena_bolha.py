# -*- Mode: Python; coding: utf-8; indent-tabs-mpythoode: nil; tab-width: 4 -*-

'''
================================================================================
Objetivo: 
		Ordenção pelo método da Bolha.
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
def ordena_bolha(v):
	# vetores iniciam o índice em zero
	ultimo = len(v) - 1
	# para i do primeiro elemento até o último inclusive (<=)
	for i in range(0, ultimo): 
		bolha = i
		while (bolha > 0):
			if (v[bolha] < v[bolha - 1]):
				auxiliar = v[bolha - 1]	# troca
				v[bolha - 1] = v[bolha]
				v[bolha] = auxiliar
				bolha = bolha - 1		# bolha "sobe"
			else:
				bolha = 0			# fim da "subida"
			# verificando mudança
			print (v)

def  inicio():
	vetor_inteiros = [10, 5, 9, -2, 13, -8, 4, 12]
	print ("vetor original: ")
	print (vetor_inteiros)
	ordena_bolha(vetor_inteiros)
	print ("vetor ordenado: ")
	print (vetor_inteiros)

if __name__ == '__main__':
	inicio()