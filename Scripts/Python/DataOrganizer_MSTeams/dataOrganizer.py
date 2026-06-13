# -*- Mode: Python; coding: utf-8; indent-tabs-mpythoode: nil; tab-width: 4 -*-

'''
    Simples leitura e consolidação dos dados do Relatório de Participação do MS Teams.

    Usar:
        python3 dataOrganizer.py <saida.csv> <entrada_1.csv> <entrada_N.csv>
        python3 dataOrganizer.py <saida.csv> <*.csv>

    Mais informações:
        https://docs.microsoft.com/pt-br/microsoftteams/teams-overview
''' 

import os, sys

EOL = '\n'
DELIM = ';'
IGNORE = ["\x00", "\n"]


def load(filename):
    data = []
    try:
        f = open(filename, 'rb')
        lines = f.readlines()
        for line in lines:
            text = "".join([(chr(x) if not chr(x) in IGNORE else "") for x in line])
            data += [text.split('\t')]
        f.close()
    except IOError:
         print("Error:", filename)
    return data

def save(filename, text):
    try:
        f = open(filename, "w")
        f.write(text)
        f.close()
        print("Save:", filename)
    except Exception:
        print("Error saving " + filename + " ...")
        exit(0) 

def prepare(path):
    HEADER = "Nome Completo;Horário de Entrada;Horário de Saída;Duração;Email;" + \
    "Função;ID do participante (UPN);Hora de Início da Reunião;Hora de Término " + \
    "da Reunião;Id da Reunião;Título da Reunião;Número Total de Participantes"
    data = [HEADER + EOL]
    for p in path:
        print("Load:", p)
        lines = load(p)
        for i in range(8, len(lines)):
            line = "".join(x + DELIM for x in lines[i])
            if line != DELIM:
                line += lines[3][1] + DELIM + lines[4][1] + DELIM
                line += lines[5][1] + DELIM + lines[2][1] + DELIM + lines[1][1]
                data += line + EOL
    return data
        
def main(argv):
    if (len(argv) < 2):
        print ('use => python3 dataOrganizer.py <outputfile.csv> <inputfiles.csv>')
        exit(0)
    path = []
    for item in argv:
        if (item[-3::].upper() == "CSV"):
            path += [item]
        else:
            print(item, ": wrong extension")
    data = prepare(path[1:])
    text = "".join(x for x in data)
    save(path[0], text)
    print("finished.")

if __name__ == "__main__":
   main(sys.argv[1:])