# -*- Mode: Python; coding: utf-8; indent-tabs-mpythoode: nil; tab-width: 4 -*-

'''
	************************
	Python - LibreOffice 6.2
	adaptado de vcf2csv.py e 
	  com uso da API (UNO)
	************************

	Importação executada via macro.

	Ao abrir janela indicar caminho ou arquivo:

	Ex:
		arquivo_entrada.vcf
		dados :
				BEGIN:VCARD
				VERSION:2.1
				N:;Name_1;;;
				FN:Name_1
				TEL;CELL:111111111
				END:VCARD
''' 

import os
import sys
import uno
from com.sun.star.awt.MessageBoxType import MESSAGEBOX as MSGBOX

# Constantes
DELIM = ';'
KEYS = ["N:", "FN:", "TEL;CELL:"]

# Configuração específica
PLANILHA = "Inserir VCF"
LINHA  = 1	# local de inserção dos dados
COLUNA = 2

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

# Dialog - API Uno
def obterArquivo():

	# caminho do arquivo
	path = ""

	try:
		ctx = uno.getComponentContext()
		smg = ctx.ServiceManager

		# Dialog Model
		m = smg.createInstance("com.sun.star.awt.UnoControlDialogModel")
		m.Title = "Abrir Arquivo"
		m.PositionX = 100
		m.PositionY = 100
		m.Width  = 200
		m.Height = 60
		
		# Label
		lbl = m.createInstance("com.sun.star.awt.UnoControlFixedTextModel")
		lbl.Label = u"Digite o caminho ou o nome do arquivo VCF:"
		lbl.PositionX = 5
		lbl.PositionY = 5 
		lbl.Width  = 150
		lbl.Height = 16
		lbl.Name = "lblInfo" 
		lbl.TabIndex = 1
				
		# Edit Text
		edt = m.createInstance('com.sun.star.awt.UnoControlEditModel')
		edt.PositionX = 5
		edt.PositionY = 17
		edt.Width  = 190
		edt.Height = 16
		edt.Name = "path"

		# Button
		btn = m.createInstance("com.sun.star.awt.UnoControlButtonModel")
		btn.PositionX = 165
		btn.PositionY = 35 
		btn.Width  = 30 
		btn.Height = 16
		btn.Name = "btnOK"
		btn.TabIndex = 0
		btn.PushButtonType = 1   
		btn.Label = u"Carregar" 

		# inserir objetos no Dialog
		m.insertByName("lblInfo", lbl)
		m.insertByName("path",    edt)				
		m.insertByName("btnOK",   btn)

		# ControlContainer
		ctrl = smg.createInstance("com.sun.star.awt.UnoControlDialog") 
		ctrl.setModel(m); 

		# Window
		toolkit = smg.createInstance("com.sun.star.awt.ExtToolkit")       
		ctrl.setVisible(False)      
		ctrl.createPeer(toolkit, None)

		# executar
		action = ctrl.execute()	# controle
		if action == 1:
			# botão OK
			path = edt.Text
		else:
			# outro click - fechar
			path = "abortado"

		# eliminar
		ctrl.dispose()

		# retornar caminho
		# sem verificação
		return path

	except Exception as e:
		return "erro"

# Altera valor da célula - API Uno
def inserir(linha, coluna, texto):

	desktop = XSCRIPTCONTEXT.getDesktop()
	m = desktop.getCurrentComponent()

	if (not hasattr(m, "Sheets")):
		return False

	planilha = m.Sheets.getByName(PLANILHA)
	celula = planilha.getCellByPosition(coluna, linha)

	celula.setString(texto)

	return True		

# Carregar dados do tipo texto do arquivo
def carregar_vcf(arquivo, text_coding='UTF-8'):
	dados = []
	try:
		if os.path.exists(arquivo):
			with open(arquivo, encoding=text_coding) as a:
				for linha in a:
					dados += [linha.replace("\n","")]
	except:
		informe("Houve algo errado!")

	return dados

# Converte em array
def converter(arquivo_vcf):
	dados = carregar_vcf(arquivo_vcf)
	if (len(dados) == 0):
		return []

	valores = ["N","FN","Cell"]
	for i in dados:
		for j in KEYS:
			if ( j == i[:len(j)] ):  # selecionar 
				valores += [ i[len(j):].replace(DELIM, "") ]
	return valores

# Importar arquivo.vcf
def importar():

	# abrir arquivo
	arquivo = obterArquivo()

	# checar caminho
	if (arquivo == ""):
		informe("Caminho vazio.\nNada a fazer!")
		return False

	if (arquivo == "abortado"):
		informe("Carregamento de arquivo,\nabortado!")
		return False

	# checar extensão
	if (arquivo[-4::].upper() != ".VCF"):
		informe("Arquivo inválido!")
		return False

	# obter dados do arquivo VCF
	valores = converter(arquivo)
	if (len(valores) == 0):
		informe('Houve algo errado ao carregar "' + arquivo + '".')
		return

	# inserir na planilha
	linha  = LINHA
	coluna = COLUNA
	for i in range(0, len(valores)):
		if (i % len(KEYS) == 0):
			linha += 1
			coluna = COLUNA
		inserir(linha, coluna, valores[i])
		coluna += 1
	
if __name__ == "__main__":
	pass