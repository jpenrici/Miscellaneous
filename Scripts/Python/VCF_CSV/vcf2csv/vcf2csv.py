# -*- Mode: Python; coding: utf-8; indent-tabs-mpythoode: nil; tab-width: 4 -*-

'''
	Simples conversão de contatos VCF em CSV.

	python3 vcf2csv.py <arquivo_entrada.vcf> <arquivo_saida.csv>

	arquivo_entrada.vcf
	dados :
			BEGIN:VCARD
			VERSION:2.1
			N:;Name_1;;;
			FN:Name_1
			TEL;CELL:111111111
			END:VCARD
''' 

import os, sys

EOL = '\n'
DELIM = ';'
KEYS = ["N:", "FN:", "TEL;CELL:"]

def vcf(filename, text_coding='UTF-8'):
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

def csv(filename, text):
	try:
		f = open(filename, "w")
		f.write(text)
		f.close()
	except Exception:
		print("error saving " + filename + " ...")
		exit(0) 

def text(data):
	output = "N;FN;Cell" + EOL
	k = 0
	for i in data:
		for j in KEYS:
			if (j == i[:len(j)]):
				k += 1
				output += i[len(j):].replace(DELIM, "")
				if (k % len(KEYS) == 0):
					output += EOL
				else:
					output += DELIM
	return output

def vcf2csv(filename_vcf, filename_csv):
	data = vcf(filename_vcf)
	if (len(data) > 0):
		output = text(data)
		csv(filename_csv, output)
		print("check " + filename_csv)
	else:
		print(filename_vcf + " empty")

def main(argv):
	if (len(argv) != 2):
		print ('use => python3 vcf2csv.py <inputfile.vcf> <utputfile.csv>')
		exit(0)
	if (argv[0][-4::].upper() != ".VCF"):
		print(argv[0] + ": wrong extension")
		exit(0)
	vcf2csv(argv[0], argv[1])
	print("finished.")

if __name__ == "__main__":
   main(sys.argv[1:])