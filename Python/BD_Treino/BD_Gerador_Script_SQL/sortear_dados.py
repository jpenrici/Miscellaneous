# -*- Mode: Python; coding: utf-8; indent-tabs-mpythoode: nil; tab-width: 4 -*-

'''
Objetivo:
	Gerar arquivos SQL para preencher as Tabelas do BD DBTeste.
	Utilizar dados aleatórios.
	
	DBTeste:
			Tabelas:
					Pessoa
					Localidade
					Signo
					Fruta
					Comida
					Carro
					Pesquisa

'''	

from random import choice, randint, sample
from manipula_arquivos import ler_arquivo, salvar_arquivo
from csv2sql import PreparaSQL

dir_entrada = "Dados_CSV_exemplos/"
dir_saida = "Dados_CSV_preparados/"
dir_sql = "Dados_SQL_prontos/"
delim = ";"

def novo(nome_tabela, atributos, lista_dados, arquivo_saida):
	texto = nome_tabela + "\n"
	texto += atributos + "\n"
	for item in lista_dados:
		texto += item + "\n"
	salvar_arquivo(dir_saida + arquivo_saida, texto)

def tab_localidade():
	arq = dir_entrada + "lista_municipios_brasileiros.csv"
	dados = ler_arquivo(arq)

	lista_dados = []
	contador = 1
	for item in dados:
		temp = item.split(delim)
		lista_dados += [
			str(contador) + delim +
			temp[1] + delim +
			temp[0] + delim +
			temp[2]
		]
		contador += 1

	novo("Localidade", "idMapa;cidade;uf;regiao", lista_dados, "tab_localidade.csv")

def tab_signos():
	lista_dados = [
		"1;Áries;21 de Março;19 de Abril",
		"2;Touro;20 de Abril;20 de Maio",
		"3;Gêmeos;21 de Maio;21 de Junho",
		"4;Câncer;22 de Junho;22 de Julho",
		"5;Leão;23 de Julho;22 de Agosto",
		"6;Virgem;23 de Agosto;22 de Setembro",
		"7;Libra;23 de Setembro;22 de Outubro",
		"8;Escorpião;23 de Outubro;21 de Novembro",
		"9;Sagitário;22 de Novembro;21 de Dezembro",
		"10;Capricórnio;22 de Dezembro;19 de Janeiro",
		"11;Aquário;20 de Janeiro;18 de Fevereiro",
		"12;Peixes;19 de Fevereiro;20 de Março"
	]
	novo("Signo", "idSigno;signo;dataInicial;dataFinal", lista_dados, "tab_signos.csv")

def preparar():
	tab_localidade()
	tab_signos()

def main():
	preparar()

	sql = PreparaSQL(dir_saida, dir_sql)
	# sql.gerar("tab_localidade.csv","tab_localidade.sql")
	sql.gerar("tab_signos.csv", "tab_signos.sql")
	

if __name__ == '__main__':
	main()