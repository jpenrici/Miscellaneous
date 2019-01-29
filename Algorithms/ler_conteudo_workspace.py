# -*- Mode: Python3; coding: utf-8; indent-tabs-mpythoode: nil; tab-width: 4 -*-

'''
Algoritmo executa leitura dos arquivos no diretório indicado pelo caminho e
retorna os nomes e os detalhes (Objetivo e Pratica). Os detalhes somente serão
exibidos se estiverem na formatação abaixo.

===
Detalhes:
		Texto...
===
'''
import os
import sys

def lista_arquivos(caminho_diretorio):
	lista=[]
	for diretorio, subdiretorios, arquivos in os.walk(caminho_diretorio):
	   for arquivo in arquivos:
	      lista +=[os.path.join(diretorio, arquivo)]
	return lista

def ler_arquivo(caminho_arquivo):
	texto=[]
	if os.path.exists(caminho_arquivo):
		with open(caminho_arquivo) as arquivo:
			for linha in arquivo:
				texto+=[linha]
	return texto

def exibir_detalhes(caminho_arquivo):
	exibir = False
	texto = ler_arquivo(caminho_arquivo)
	for linha in texto:
		if linha[0] == "=":
			exibir = not exibir
			continue
		if exibir:
			linha = linha.replace("\t", " ")
			linha = linha.replace("\n", "")
			print(linha)

def informar(caminho_diretorio):
	arquivos = lista_arquivos(caminho_diretorio)
	arquivos.sort()
	separador = 80 * '*'
	for arquivo in arquivos:
		temp = arquivo.split('/')
		print(temp[-1])
		exibir_detalhes(arquivo)
		print(separador)

def main():
	informar(".")  # teste

if __name__ == '__main__':
	main()