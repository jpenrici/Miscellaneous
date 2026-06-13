# -*- Mode: Python; coding: utf-8; indent-tabs-mpythoode: nil; tab-width: 4 -*-

'''
Objetivo:
    Gerar um arquivo CSV para exercícios de pesquisa e filtragem em Planilha Eletrônica.
    Inserido dado fixo (semente) para busca.
    Demais dados são aleatórios.
    Utilizado delimitador ponto e vírgula(;)
''' 

import os, sys
from random import choice, randint, sample

INPUT = "Dados_CSV_exemplos/"
OUTPUT = "Dados_preparados/"
TIPO = ".csv"
DELIM = ';'

def ler_arquivo(arquivo):
    lista = []
    try:
        f = open(arquivo)
        for linha in f:
            lista += [linha.replace("\n", "")]
        f.close()
    except Exception:
        pass          
    return lista

def salvar_arquivo(arquivo, texto_saida):
    try:
        arquivo = open(arquivo, "w")
        arquivo.write(texto_saida)
        arquivo.close()
    except Exception:
        print("erro: falha ao salvar " + arquivo)
        exit(0) 

def texto(lista):
    saida = ""
    for dado in lista:
        for item in dado:
            saida += item + DELIM
        saida += "\n"
    return saida

def randomSequenciaNumeros(NumElementos):
    # randomiza números de 0 a 9 e insere em texto
    txt = ""
    for i in range(0, NumElementos):
        txt += str(randint(0,9))
    return txt 

def randomItem(lista):
    # retorna um valor aleatório de uma lista
    return choice(lista)

def correioEletronico(nome):
    # retorna um email
    provedor = ["gmail", "yahoo", "outlook", "terra", "bol", "uol"]
    nome = nome.lower()
    nome = nome.replace(" ","")
    nome = nome.replace("á","a")
    nome = nome.replace("à","a")
    nome = nome.replace("ã","a")
    nome = nome.replace("â","a")
    nome = nome.replace("é","e")
    nome = nome.replace("è","e")
    nome = nome.replace("ẽ","e")
    nome = nome.replace("ê","e")
    nome = nome.replace("í","i")
    nome = nome.replace("ì","i")
    nome = nome.replace("ó","o")
    nome = nome.replace("ò","o")
    nome = nome.replace("õ","o")
    nome = nome.replace("ô","o")
    nome = nome.replace("ú","u")
    nome = nome.replace("ú","u")
    nome = nome.replace("ç","c")
    if ((randint(0,10) % 2) == 0):
        nome += "_" + randomSequenciaNumeros(3)
    nome += "@" + randomItem(provedor) + ".com"
    return nome

def gerarTabela(numSorteios):
    # ler arquivos base
    listaNomes      = ler_arquivo(INPUT + "lista_nomes.csv")
    listaCarros     = ler_arquivo(INPUT + "lista_carros.csv")
    listaFlores     = ler_arquivo(INPUT + "lista_flores.csv")
    listaFrutas     = ler_arquivo(INPUT + "lista_frutas.csv")
    listaAnimais    = ler_arquivo(INPUT + "lista_animais.csv")  
    listaEsporte    = ler_arquivo(INPUT + "lista_tipos_esporte.csv")
    listaTimes      = ler_arquivo(INPUT + "lista_times_brasileiros.csv")
    listaPratos     = ler_arquivo(INPUT + "lista_pratos_culinaria.csv") 
    listaCidades    = ler_arquivo(INPUT + "lista_municipios_brasileiros.csv")
    listaProfissoes = ler_arquivo(INPUT + "lista_profissoes.csv")   

    listaCarros     += ["Não tem;Não tem"]
    listaProfissoes += ["Não tem"]
    listaPratos     += ["Sem preferência"]
    listaFrutas     += ["Sem preferência"]
    listaEsporte    += ["Sem preferência"]
    listaTimes      += ["Sem preferência"]
    listaAnimais    += ["Não gosta de animais"]
    listaFlores     += ["Não gosta de flores"]

    # gerar dados aleatórios
    lista = [[
        "ID", "Nome", "Sexo", "Idade", "Estado Civil", "Identidade", "CPF",
        "Cidade", "UF", "Região", "Nº Filhos", "Altura", "Peso", "Saúde",
        "Signo", "Telefone Celular", "Uso do Celular", "Internet", "E-mail",
        "Banco", "Saldo em Conta", "Cartão de Crédito", "Dívida no Cartão",
        "TV", "Gosta de Games", "Gosta de Filmes", "Lê Livros", "Casa Própria", 
        "Ocupação ou Trabalho", "Carro", "Marca do Carro", "Custo Combustivel Mensal",
        "Comida", "Ir ao Restaurante", "Fruta", "Flor", "Animal", "Esporte",
        "Time de Futebol", "Escola do Filhos", "Mensalidade Escola" 
    ]]

    for i in range(numSorteios):
        nomes   = randomItem(listaNomes).split(DELIM)
        cidades = randomItem(listaCidades).split(DELIM)
        carros  = randomItem(listaCarros).split(DELIM)
        nome = nomes[0]
        sexo = nomes[1]
        estado = cidades[0]
        cidade = cidades[1]
        regiao = cidades[2]         
        idade  = str(randint(21, 85))
        numFilhos = randint(0,4)
        peso      = str(randint(60,110))
        altura = "1," + str(randint(5,9)) + str(randint(0,9))
        cpf = randomSequenciaNumeros(11)

        # dado fixo
        marcador = 8640 # 8642
        if (i == marcador):
            nome = "Tyler"
            sexo = "Masculino"
            profissao = "Pedreiro"
            esporte = "Dormir"
            time = "Guapiense"

        temAlgumaAlergia = randomItem(["Alérgico", "Não Alérgico", "Não Alérgico"])
        if (sexo == "Feminino"): temAlgumaAlergia = temAlgumaAlergia[0:-1] + "a"
        casado = randomItem(["Casado", "Solteiro", "Divorciado"])
        if (sexo == "Feminino"): casado = casado[0:-1] + "a"

        identidade  = randomItem(["R","M","Y","W"]) + randomSequenciaNumeros(9)
        telefone    = "9" + randomSequenciaNumeros(4) + randomSequenciaNumeros(4)
        internet    = randomItem(["Wifi", "Banda Larga", "4G", "Não tem internet"])
        email       = correioEletronico(nome)   
        whatsapp    = randomItem(["Whatsapp", "Celular"])
        casaPropria = randomItem(["Própria", "Alugada", "Emprestada"])
        tv = randomItem(["TV por assinatura", "TV aberta", "TV pela internet"])
        gostaDeGames  = randomItem(["Gosta", "Não Gosta"])
        gostaDeFilmes = randomItem(["Gosta", "Não Gosta"])
        leLivros   = randomItem(["Uma vez por mês", "Toda semana", "Raramente", "Não"])
        profissao  = randomItem(listaProfissoes)
        marcaCarro = carros[0]
        carro = carros[1]
        fruta = randomItem(listaFrutas)
        prato = randomItem(listaPratos)
        gostaDeAlmocarFora = randomItem(["Gosta", "Não Gosta"])
        flor    = randomItem(listaFlores)       
        animal  = randomItem(listaAnimais)
        time    = randomItem(listaTimes)
        esporte = randomItem(listaEsporte)
        signo   = randomItem(["Áries", "Touro", "Gêmeos", "Câncer",
            "Leão", "Virgem", "Libra", "Escorpião", "Sagitário",
            "Capricórnio", "Aquário", "Peixes"])
        banco   = randomItem(["Bradesco", "Caixa Econômica", "Itaú",
            "Banco do Brasil", "Santander"])
        saldoConta    = str(randint(-1000, 1000000))
        cartaoCredito = randomItem(["Visa", "Mastercard", "American Express",
            "Elo", "Hipercard", "Diners Club"])
        possuiDividaCartao = randomItem(["Não", "Sim"])

        if (numFilhos > 0):
            filhosEscola = randomItem(["Particular", "Pública"])
            if (filhosEscola == "Particular"):
                custoEscola = str(randint(300, 600))
            else:
                custoEscola = "0"
        else:
            filhosEscola = "Não"
            custoEscola = "x"

        if (carro == "Não tem"):
            custoCombustivel = "x"
        else:
            custoCombustivel = str(randint(50, 350))

        id = "id-" + str('%07d' % i)
        numFilhos = str(numFilhos)

        lista += [[
            id, nome, sexo, idade, casado, identidade, cpf, cidade, estado, regiao,
            numFilhos, altura, peso, temAlgumaAlergia, signo, telefone, whatsapp,
            internet, email, banco, saldoConta, cartaoCredito, possuiDividaCartao,
            tv, gostaDeGames, gostaDeFilmes, leLivros, casaPropria, profissao,
            carro, marcaCarro, custoCombustivel, prato, gostaDeAlmocarFora, fruta,
            flor, animal, esporte, time, filhosEscola, custoEscola  
        ]]
        print("gerando item  " + str(i) + "  " + '.'*randint(3,10) + " ")

    return lista

def main():
    capacidade = 10000
    nome_arquivo = "aula-treino_excel_"
    arquivo_saida = OUTPUT + nome_arquivo + str(capacidade) + TIPO

    # gerar tabela
    lista = gerarTabela(capacidade)

    # converter lista em string
    saida = texto(lista)

    # salvar lista gerada
    print ("salvando em " + arquivo_saida)
    salvar_arquivo(arquivo_saida, saida)

    # exibir lista gerada
    # print(saida)

if __name__ == '__main__':
    main()