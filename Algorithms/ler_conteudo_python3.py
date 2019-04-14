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

Executar com: python3 ler_conteudo_python3.py
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
		pass	      
	return lista

def ler_arquivo(caminho_arquivo, tipo='UTF-8'):
	texto=[]
	try:
		if os.path.exists(caminho_arquivo):
			with open(caminho_arquivo, encoding=tipo) as arquivo:
				for linha in arquivo:
					texto += [linha]
	except Exception:
		pass
	return texto

def exibir_detalhes(caminho_arquivo):
	global filtro
	auxiliar = caminho_arquivo.split('/')
	extensao = auxiliar[-1].split('.')[-1]

	# exibir todos os arquivos
	if (filtro == "*"):
		print(auxiliar[-1])
		return False 

	# exibir somente o arquivo de extensão escolhida
	if (extensao != filtro):
		return False

	print("dir: " + auxiliar[-2])
	print("arq: " + auxiliar[-1] + "\n")		

	exibir = False
	if (extensao == "alg"):
		texto = ler_arquivo(caminho_arquivo, "ISO-8859-1")
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
	return True

def informar(caminho_diretorio):
	arquivos = lista_arquivos(caminho_diretorio)
	arquivos.sort()
	separador = 80 * '*'
	for arquivo in arquivos:
		if (exibir_detalhes(arquivo)):
			print(separador)

def main():
	informar(path)

if __name__ == '__main__':

	# filtro padrão, somente exibe arquivos
	filtro = "*"
	path = "."

	# parâmetros de entrada em linha de comando
	for param in sys.argv :
		if param == "--por": filtro = "por"
		if param == "--c++": filtro = "cpp"
		if param == "--py" : filtro = "py"
		if param == "--alg": filtro = "alg"
		if param[:5] == "path=":
			path = param.replace("path=", "")

	main()