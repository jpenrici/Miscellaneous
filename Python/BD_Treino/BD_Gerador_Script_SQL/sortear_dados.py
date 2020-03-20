# -*- Mode: Python; coding: utf-8; indent-tabs-mpythoode: nil; tab-width: 4 -*-

'''
Objetivo:
	Gerar arquivos SQL para preencher as Tabelas do BD DBTeste.
	Utilizar dados aleatórios.
	
	DBTeste:
			Tabelas:
					Localidade
					Signo
					Fruta
					Comida
					Carro
					Pessoa					
					Pesquisa
'''	

from random import choice, randint
from csv2sql import PreparaSQL
from manipula_arquivos import ler_arquivo, salvar_arquivo

dir_entrada = "Dados_CSV_exemplos/"
dir_saida = "Dados_CSV_preparados/"
dir_sql = "Dados_SQL_prontos/"
delim = ";"

def novo(nome_tabela, atributos, lista_dados, arquivo_saida_csv):
	texto = nome_tabela + "\n"
	texto += atributos + "\n"
	for item in lista_dados:
		texto += item + "\n"
	salvar_arquivo(dir_saida + arquivo_saida_csv, texto)

def tab_simples(nome_tabela, atributos, dados, arquivo_saida_csv):
	lista_dados = []
	contador = 0
	for item in dados:
		contador += 1
		lista_dados += [str(contador) + delim + item]
	novo(nome_tabela, atributos, lista_dados, arquivo_saida_csv)
	return contador

def tab_localidade():
	arq = dir_entrada + "lista_municipios_brasileiros.csv"
	dados = ler_arquivo(arq)

	lista_dados = []
	contador = 0
	for item in dados:
		contador += 1
		temp = item.split(delim)
		lista_dados += [
			str(contador) + delim +
			temp[1] + delim +
			temp[0] + delim +
			temp[2]
		]
	novo(
		"Localidade",
		"idMapa;cidade;uf;regiao",
		lista_dados,
		"tab_localidade.csv"
	)
	return contador

def tab_signo():
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
	novo(
		"Signo",
		"idSigno;signo;dataInicial;dataFinal",
		lista_dados,
		"tab_signo.csv"
	)
	return 12

def tab_fruta():
	arq = dir_entrada + "lista_frutas.csv"
	dados = ler_arquivo(arq)
	contador = tab_simples(
					"Fruta",
					"idFrutas;nomeFruta",
					dados,
					"tab_fruta.csv"
				)
	return contador

def tab_comida():
	arq = dir_entrada + "lista_pratos_culinaria.csv"
	dados = ler_arquivo(arq)
	contador = tab_simples(
					"Comida",
					"idComida;nomePrato",
					dados,
					"tab_comida.csv"
				)
	return contador

def tab_carro():
	arq = dir_entrada + "lista_carros.csv"
	dados = ler_arquivo(arq)
	contador = tab_simples(
					"Carro",
					"idCarro;nomeCarro;marcaCarro",
					dados,
					"tab_carro.csv"
				)
	return contador	

def tab_pessoa(num_pessoas, num_localidades):
	arq = dir_entrada + "lista_nomes.csv"
	dados = ler_arquivo(arq)
	nomes = len(dados) - 1

	lista_dados = []
	for contador in range(1, num_pessoas + 1):
		sorteio = randint(0, nomes)
		nome = dados[sorteio].split(delim)[0]
		dataNascimento = str(randint(1970,2010)) \
			+ "-" + str(randint(1,12)) + "-" \
			+ str(randint(1,28))
		localidade = str(randint(1, num_localidades))
		estado_civil = choice(["casado", "solteiro", "divorciado"])
		signo = str(randint(1, 12))

		lista_dados += [
			str(contador) + delim +
			nome + delim +
			dataNascimento + delim +
			localidade + delim +
			estado_civil + delim +
			signo
		]
	novo(
		"Pessoa",
		"idPessoa;nome;dataNascimento;Localidade_idMapa;estadoCivil;Signo_idSigno",
		lista_dados,
		"tab_pessoa.csv"
	)
	return contador

def tab_pesquisa(num_pratos, num_carros, num_frutas, num_pessoas):
	lista_dados = []
	for contador in range(1, num_pessoas + 1):
		comida = str(randint(1, num_pratos))
		carro = str(randint(1, num_carros))
		fruta = str(randint(1, num_frutas))
		pessoa = str(randint(1, num_pessoas))
		lista_dados += [
			str(contador) + delim +
			comida + delim +
			carro + delim +
			fruta + delim +
			pessoa
		]
	novo(
		"Pesquisa",
		"idPesquisa;Comida_idComida;Carro_idCarro;Frutas_idFrutas;Pessoa_idPessoa",
		lista_dados,
		"tab_pesquisa.csv"
	)
	return contador		

def preparar():
	localidades = tab_localidade()
	signos = tab_signo()
	frutas = tab_fruta()
	pratos = tab_comida()
	carros = tab_carro()
	pessoas = tab_pessoa(1000, localidades)
	pesquisas = tab_pesquisa(pratos, carros, frutas, pessoas)

	print("Preparado:")
	print("\tlocalidades:" + str(localidades))
	print("\tsignos:" + str(signos))
	print("\tfrutas:" + str(frutas))
	print("\tpratos:" + str(pratos))
	print("\tpessoas:" + str(pessoas))
	print("\tpesquisas:" + str(pesquisas))

def gerarSQL():
	sql = PreparaSQL(dir_saida, dir_sql)
	sql.gerar("tab_localidade.csv","tab_localidade.sql")
	sql.gerar("tab_signo.csv", "tab_signo.sql")
	sql.gerar("tab_fruta.csv", "tab_fruta.sql")
	sql.gerar("tab_comida.csv", "tab_comida.sql")
	sql.gerar("tab_carro.csv", "tab_carro.sql")
	sql.gerar("tab_pessoa.csv", "tab_pessoa.sql")
	sql.gerar("tab_pesquisa.csv", "tab_pesquisa.sql")

def main():
	preparar()
	gerarSQL()

if __name__ == '__main__':
	main()