# -*- Mode: Python; coding: utf-8; indent-tabs-mpythoode: nil; tab-width: 4 -*-

'''
	Simples conversão de contatos CSV em VCF.

	python3 csv2vcf.py <arquivo_entrada.csv> <arquivo_saida.vcf>

	arquivo_entrada.csv
	dados  :	Nome_1;Tel_1
				Nome_2;Tel_2
					...
				Nome_N;Tel_N
'''	

import os, sys

TEMPLATE = "\
BEGIN:VCARD\n\
VERSION:2.1\n\
N:;#NAME;;;\n\
FN:#FIRSTNAME\n\
TEL;CELL:#NUMBERCELL\n\
END:VCARD\n"

def csv(filename, text_coding='UTF-8'):
	data = []
	try:
		if os.path.exists(filename):
			print(filename + " ok ...")
			with open(filename, encoding=text_coding) as f:
				for line in f:
					data += [line.replace("\n","")]
		else:
			print(filename + " not found ...")
			exit(0)
	except:
		print("unexpected error:", sys.exc_info()[0])
		raise
	return data

def vcf(filename, text):
	try:
		f = open(filename, "w")
		f.write(text)
		f.close()
	except Exception:
		print("error saving " + filename + " ...")
		exit(0)	

def text(data):
	output = ""
	for i in data:
		item = i.split(";")
		if (len(item) != 2):
			continue
		if (item[0] == "" or item[1] == ""):
			continue
		s = TEMPLATE
		s = s.replace("#NAME", item[0])
		s = s.replace("#FIRSTNAME", item[0])
		s = s.replace("#NUMBERCELL", item[1])
		output += s;
	return output

def csv2vcf(filename_csv, filename_vsf):
	data = csv(filename_csv)
	if (len(data) > 0):
		output = text(data)
		vcf(filename_vsf, output)
		print("check " + filename_vsf)
	else:
		print(filename_csv + " empty")

def main(argv):
	if (len(argv) != 2):
		print ('python3 csv2vcf.py <inputfile.csv> <outputfile.vcf>')
		exit(0)
	if (argv[0][-3::].upper() != "CSV"):
		print(argv[0] + ": wrong extension")
		exit(0)
	csv2vcf(argv[0], argv[1])
	print("finished.")

if __name__ == "__main__":
   main(sys.argv[1:])