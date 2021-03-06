# -*- Mode: Python3; coding: utf-8; indent-tabuladors-mpythoode: nil; tabulador-width: 4 -*-

'''
  Leitura dos arquivos no diretório indicado pelo caminho.

    Comando:    python3 contents.py [opções]

      Ex:
        # Lista arquivos de extensão .py no diretório Python
        # Exibe cabeçalho se header for verdadeiro
          python3 contents.py type=".py" path="Python" header=True

'''

import os
import sys

# constantes
SEPARADOR = " "
MARCADOR1 = "|"
MARCADOR2 = "+---"
DELIM = "/"
EOL = "\n"


def percorrer(caminho):
    lista = []
    try:
        lista += [caminho.split(DELIM)[-1]]
        for diretorio, subdiretorios, arquivos in os.walk(caminho):
            r = [diretorio.replace(caminho, "")]
            for arquivo in arquivos:
                r += [arquivo]
            lista += [r]
    except Exception:
        pass
    return lista


def listar(caminho=".", tipo="*", titulo=False):
    # informações
    if titulo:
        print("Local : {}".format("atual" if caminho == "." else caminho))
        print("Listar: {}.\n".format("tudo" if tipo == "*" else tipo))

    # percorrer
    lista = percorrer(caminho)

    # listar
    txt = ""
    for d in lista:
        if d[0].find("/.") > 0:
            continue

        diretorio = d[0].split(DELIM)
        arquivos  = d[1:]
        space = len(diretorio) - 1

        if space > 1:
            txt += SEPARADOR * space + MARCADOR1 + diretorio[-1] + EOL
        else:
            txt += diretorio[-1] + EOL

        for arquivo in arquivos:
            if (tipo != "*" and tipo != arquivo[-len(tipo):]):
                continue
            if space > 1:
                txt += SEPARADOR * space + MARCADOR1
            if space >= 0:
                txt += MARCADOR2 + arquivo + EOL

    # output
    print(txt)


if __name__ == '__main__':

    # padrão
    caminho = "."
    tipo = "*"
    titulo = True

    # parâmetros de entrada em linha de comando
    for param in sys.argv:
        if param[:5] == "type=":
            tipo = param.replace("type=", "")
        if param[:5] == "path=":
            caminho = param.replace("path=", "")
        if param == "header=False":
            titulo = False

    listar(caminho, tipo, titulo)
