# -*- Mode: Python; coding: utf-8; indent-tabs-mpythoode: nil; tab-width: 4 -*-

'''
Objetivo:
	Preparar lista de pacotes para reinstalação.
'''	

import os, sys

INPUT = "package_list_bkp"
OUTPUT = "package_list_reinstall"
DELIM = "\t"

def load(path):
	list = []
	try:
		f = open(path)
		for line in f:
			list += [line.replace("\n", "")]
		f.close()
	except Exception:
		print("error ... " + path)
		exit(0)		      
	return list

def save(path, txt):
	try:
		path = open(path, "w")
		path.write(txt)
		path.close()
	except Exception:
		print("error ... " + path)
		exit(0)	

def read_list(list):
	txt = ""
	char = 'a'
	for i in list:
		if (i[0] == '#' or i[0] == '-'):
			continue
		if (i[0] == char):
			txt += i.split(DELIM)[0] + " "
		else:
			char = i[0]
			txt += i.split(DELIM)[0] + "\n"
	return txt

def main():
	list = load(INPUT)
	txt = read_list(list)
	print(txt)
	save(OUTPUT, txt)

if __name__ == '__main__':
	main()