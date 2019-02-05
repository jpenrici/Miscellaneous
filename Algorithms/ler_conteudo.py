# -*- Mode: Python3; coding: utf-8; indent-tabs-mpythoode: nil; tab-width: 4 -*-

'''
================================================================================
Algoritmo executa leitura dos arquivos no diretório indicado pelo caminho e
retorna os detalhes (Objetivo e Pratica), que somente serão exibidos se 
estiverem na formatação abaixo.

=== ou //==
Detalhes:
		Texto...
=== ou //==

Por questão de codificação dos caracteres os arquivos do VisuAlg recebem
tratamento especial.
================================================================================
'''

import os
import sys

def lista_arquivos(caminho_diretorio):
	lista=[]
	try:
		for diretorio, subdiretorios, arquivos in os.walk(caminho_diretorio):
		   for arquivo in arquivos:
		      lista += [os.path.join(diretorio, arquivo)]
	except Exception:
		print("Erro: falha ao ler arquivo!")	      
	return lista

def ler_arquivo(caminho_arquivo, tipo='UTF-8'):
	texto=[]
	try:
		if os.path.exists(caminho_arquivo):
			with open(caminho_arquivo, encoding=tipo) as arquivo:
				for linha in arquivo:
					texto += [linha]
	except Exception:
		print("Erro: falha ao ler arquivo!")
	return texto

def exibir_detalhes(caminho_arquivo):
	extensao = (caminho_arquivo.split('/')[-1]).split('.')[-1]
	if (extensao != "por" and extensao != "cpp" and
		extensao != "py"  and extensao != "alg"):
		return
	exibir = False
	if (extensao == "alg"):
		texto = ler_arquivo(caminho_arquivo, 'ISO-8859-1')
	else:
		texto = ler_arquivo(caminho_arquivo)
	for linha in texto:
		if linha[2:5] == "===":
			exibir = not exibir
			continue
		if exibir:
			linha = linha.replace("\t"," ")
			linha = linha.replace("\n", "")
			if (linha[:2] == "//"):
				linha = linha.replace("//", "")
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
	informar(".")  # ler diretório atual

if __name__ == '__main__':
	main()