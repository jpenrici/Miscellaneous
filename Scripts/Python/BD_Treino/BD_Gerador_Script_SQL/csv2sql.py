# -*- Mode: Python; coding: utf-8; indent-tabs-mpythoode: nil; tab-width: 4 -*-

'''
Objetivo:
	Gerar script SQL para inserção de dados em Tabela Simples.

	Entrada: Arquivo.csv
	Formato:
			Nome_da_Tabela
			ID;Atributo_1;Atributo_2;...;Atributo_N
			1;Dado_1;Dado_2;...;Dado_N
			2;Dado_1;Dado_2;...;Dado_N
			3;Dado_1;Dado_2;...;Dado_N
			4;Dado_1;Dado_2;...;Dado_N
			5;Dado_1;Dado_2;...;Dado_N

	Saída: Arquivo.sql
	Formato:
			INSERT INTO `Nome_da_Tabela`
				(`ID`,`Atributo_1`,`Atributo_2`,`...`,`Atributo_N`)
			VALUES
				("1","Dado_1","Dado_2","...","Dado_N"),
				("2","Dado_1","Dado_2","...","Dado_N"),
				("3","Dado_1","Dado_2","...","Dado_N"),
				("4","Dado_1","Dado_2","...","Dado_N"),
				("5","Dado_1","Dado_2","...","Dado_N");
'''

from manipula_arquivos import ler_arquivo, salvar_arquivo

class PreparaSQL(object):

	def __init__(self, diretorio_entrada, diretorio_saida):
		self.delimitador = ";"
		self.diretorio_entrada = diretorio_entrada
		self.diretorio_saida = diretorio_saida

	def ler(self, arquivo):
		arquivo = self.diretorio_entrada + arquivo
		return ler_arquivo(arquivo)

	def salvar(self, arquivo, texto):
		arquivo = self.diretorio_saida + arquivo
		return salvar_arquivo(arquivo, texto)

	def textoSQL(self, lista):
		nome_da_tabela = lista[0]
		atributo = lista[1].split(self.delimitador)
		capacidade = len(atributo)

		sql = "INSERT INTO `" + nome_da_tabela + "`\n\t(" 

		for argumento in atributo:
			sql += "`" + argumento + "`,"

		sql = sql[:-1] + ")"
		sql += "\nVALUES\n"

		for i in range(2, len(lista)):
			dado = lista[i].split(self.delimitador)
			temp = "\t("
			for argumento in dado:
				temp += "\"" + argumento + "\","
			sql += temp[:-1] + "),\n"
		
		sql = sql[:-2] + ";"
		return sql

	def gerar(self, arquivo_csv, arquivo_sql):
		lista = self.ler(arquivo_csv)
		texto = self.textoSQL(lista)
		self.salvar(arquivo_sql, texto)
		# print(texto)


def teste():

	sql = PreparaSQL("Dados_CSV_preparados/","Dados_SQL_prontos/")
	sql.gerar("teste.csv","teste.sql")

if __name__ == '__main__':
	# teste()
	pass