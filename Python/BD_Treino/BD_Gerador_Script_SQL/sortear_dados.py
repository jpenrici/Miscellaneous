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

# Diretórios
dir_entrada = "Dados_CSV_exemplos/"
dir_saida = "Dados_CSV_preparados/"
dir_sql = "Dados_SQL_prontos/"

# Constantes
DELIM = ";"
EOL = "\n"
MINIMO = 1;	# Quantidade mínima de pessoas a inserir.

def csv(tabela, atributos, lista_dados, arquivo_saida_csv, indexar=False):
	txt = tabela + EOL + atributos + EOL
	for i, item in enumerate(lista_dados, 1):
		if (indexar): txt += str(i) + DELIM
		txt += item + EOL
	salvar_arquivo(dir_saida + arquivo_saida_csv, txt)
	return len(lista_dados)

def tab_localidade(uf=""):
	arq = dir_entrada + "lista_municipios_brasileiros.csv"
	dados = ler_arquivo(arq)
	uf = uf.upper();

	lista_dados = []
	for item in dados:
		temp = item.split(DELIM)

		# selecionar por UF
		if (uf == ""):
			uf = temp[0]	# todos
		if (uf != temp[0]):
			continue

		lista_dados += [
			temp[1] + DELIM +
			uf + DELIM +
			temp[2]
		]

	if (len(lista_dados) == 0):
		print("Erro: UF não encontrada!")
		return -1

	contador = csv(
		"Localidade",
		"idMapa;cidade;uf;regiao",
		lista_dados,
		"tab_localidade.csv",
		True 	# indexar
	)
	return contador

def tab_signo():
	arq = dir_entrada + "lista_signos.csv"
	dados = ler_arquivo(arq)

	contador = csv(
		"Signo",
		"signo;dataInicial;dataFinal",
		dados,
		"tab_signo.csv"
		# não indexar
	)
	return contador

def tab_fruta():
	arq = dir_entrada + "lista_frutas.csv"
	dados = ler_arquivo(arq)
	contador = csv(
					"Fruta",
					"idFrutas;nomeFruta",
					dados,
					"tab_fruta.csv",
					True 	# indexar
				)
	return contador

def tab_comida():
	arq = dir_entrada + "lista_pratos_culinaria.csv"
	dados = ler_arquivo(arq)
	contador = csv(
					"Comida",
					"idComida;nomePrato",
					dados,
					"tab_comida.csv",
					True 	# indexar
				)
	return contador

def tab_carro(marcaCarro=""):
	arq = dir_entrada + "lista_carros.csv"
	dados = ler_arquivo(arq)

	lista_dados = []
	for item in dados:
		temp = item.split(DELIM)

		# selecionar por Marca
		if (marcaCarro == ""):
			marcaCarro = temp[0]	# todos
		if (marcaCarro != temp[0]):
			continue

		lista_dados += [
			temp[1] + DELIM +
			marcaCarro
		]

	if (len(lista_dados) == 0):
		print("Erro: Marca de Carro não encontrada!")
		return -1

	contador = csv(
		"Carro",
		"idCarro;nomeCarro;marcaCarro",
		lista_dados,
		"tab_carro.csv",
		True 	# indexar
	)
	return contador	

def tab_pessoa(num_pessoas, num_localidades):
	arq = dir_entrada + "lista_nomes.csv"
	dados = ler_arquivo(arq)
	arq = dir_entrada + "lista_signos.csv"
	signos = ler_arquivo(arq)

	lista_dados = []
	for i in range(1, num_pessoas + 1):
		sorteio = randint(0, len(dados) - 1)
		nome = dados[sorteio].split(DELIM)[0]

		dia = randint(1,28)			# simplificado
		mes = randint(1,12)
		ano = randint(1970,2002)	# mínimo 18 anos
		dataNascimento = str(ano) + "-" + str(mes) + "-" + str(dia)

		localidade = str(randint(1, num_localidades))
		estado_civil = choice(["casado", "solteiro", "divorciado"])

		mesSorteado = signos[mes - 1].split(DELIM)
		if (dia < int(mesSorteado[1][:2])):
			# pertence ao signo anterior
			if (mes == 1): mes = 11
			mesSorteado = signos[mes - 2].split(DELIM)
		signo = mesSorteado[0]

		lista_dados += [
			nome + DELIM +
			dataNascimento + DELIM +
			localidade + DELIM +
			estado_civil + DELIM +
			signo
		]

	contador = csv(
		"Pessoa",
		"idPessoa;nome;dataNascimento;Localidade_idMapa;estadoCivil;Signo_signo",
		lista_dados,
		"tab_pessoa.csv",
		True 	# indexar
	)
	return contador

def tab_pesquisa(num_pratos, num_carros, num_frutas, num_pessoas):
	lista_dados = []
	for i in range(1, num_pessoas + 1):
		comida = str(randint(1, num_pratos))
		carro = str(randint(1, num_carros))
		fruta = str(randint(1, num_frutas))
		pessoa = str(randint(1, num_pessoas))
		lista_dados += [
			comida + DELIM +
			carro + DELIM +
			fruta + DELIM +
			pessoa
		]
	contador = csv(
		"Pesquisa",
		"idPesquisa;Comida_idComida;Carro_idCarro;Frutas_idFrutas;Pessoa_idPessoa",
		lista_dados,
		"tab_pesquisa.csv",
		True 	# indexar
	)
	return contador		

def preparar(num_pessoas=MINIMO, uf="", marcaCarro=""):

	if (num_pessoas < MINIMO):
		num_pessoas = MINIMO
	
	localidades = tab_localidade(uf)
	if (localidades <= 0): exit()
	
	carros = tab_carro(marcaCarro)
	if (carros <= 0): exit()	
	
	signos = tab_signo()
	frutas = tab_fruta()
	pratos = tab_comida()	
	pessoas = tab_pessoa(num_pessoas, localidades)
	pesquisas = tab_pesquisa(pratos, carros, frutas, pessoas)

	print(50*'-')
	print("Preparado (Arquivos CSV):")
	print("\tlocalidades:" + str(localidades))
	print("\tsignos:" + str(signos))
	print("\tfrutas:" + str(frutas))
	print("\tpratos:" + str(pratos))
	print("\tcarros:" + str(carros))
	print("\tpessoas:" + str(pessoas))
	print("\tpesquisas:" + str(pesquisas))
	print(50*'-')

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
	preparar(marcaCarro="Audi", uf="rj", num_pessoas=10)
	gerarSQL()

if __name__ == '__main__':
	main()