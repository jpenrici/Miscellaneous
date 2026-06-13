# -*- Mode: Python3; coding: utf-8; indent-tabs-mpythoode: nil; tab-width: 4 -*-

'''
*********************************************
*****     Python - LibreOffice 6.2      *****
*****          usa API (UNO)            *****
*****   Experimentar importar módulo    *****
*********************************************
'''

import os

# API
import uno
from com.sun.star.awt.MessageBoxType import MESSAGEBOX as MSGBOX

# Dependências
logErro = ""
dependencias = True
try:
    # Experiência com módulos extras, fora do diretório /Scripts/python
    from py_pkgs_libreoffice import modulo_principal
except ImportError as err:
    logErro = str(err)
    dependencias = False

# Constantes
PLANILHA = "Planilha Teste"


# Message Box - API Uno
def informe(msg=""):

    try:
        desktop = XSCRIPTCONTEXT.getDesktop()
        frame = desktop.getCurrentFrame()
        window = frame.getContainerWindow()
        toolkit = window.getToolkit()
        msgbox = toolkit.createMessageBox(window, MSGBOX, 1, "Informe", msg)
    except Exception as e:
        return False
    finally:
        return msgbox.execute()


# Retorna valor da célula
def valor(linha, coluna):

    desktop = XSCRIPTCONTEXT.getDesktop()
    model = desktop.getCurrentComponent()

    texto = ""
    if (not hasattr(model, "Sheets")):
        return ""

    planilha = model.Sheets.getByName(PLANILHA)
    celula = planilha.getCellByPosition(coluna, linha)

    texto = celula.getString()

    return texto


# Altera valor da célula
def inserir(linha, coluna, texto):

    desktop = XSCRIPTCONTEXT.getDesktop()
    model = desktop.getCurrentComponent()

    if (not hasattr(model, "Sheets")):
        return False

    planilha = model.Sheets.getByName(PLANILHA)
    celula = planilha.getCellByPosition(coluna, linha)

    celula.setString(texto)

    return True


def exemplo():

    linha = 0
    coluna = 2

    if (dependencias):

        dado = [PLANILHA.upper(), ""]
        dado += ["PATH"]
        dado += os.environ.get('PATH').split(":")

        dado += ["PYTHON PATH"]
        dado += os.environ.get('PYTHONPATH').split(":")

        dado += modulo_principal.info()

        for i in range(0, len(dado)):
            inserir(linha + i, coluna, dado[i])

    else:
        informe("Erro:\n" + logErro)


if __name__ == '__main__':
    pass
