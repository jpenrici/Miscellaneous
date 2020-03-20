# -*- Mode: Python3; coding: utf-8; indent-tabs-mpythoode: nil; tab-width: 4 -*-

import os, sys

def ler_arquivo(arquivo):
	print("lendo " + arquivo + " ...")
	lista = []
	try:
		f = open(arquivo)
		for linha in f:
			lista += [linha.replace("\n", "")]
		f.close()
	except Exception:
		pass	      
	return lista

def salvar_arquivo(arquivo, texto):
	print("salvando " + arquivo + " ...")
	try:
		arquivo = open(arquivo, "w")
		arquivo.write(texto)
		arquivo.close()
	except Exception:
		print("erro: falha ao salvar " + arquivo)
		exit(0)

def texto(lista):
	saida = ""
	for dado in lista:
		saida += dado + "\n"
	return saida

if __name__ == '__main__':
	pass