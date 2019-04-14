# -*- Mode: Python3; coding: utf-8; indent-tabs-mpythoode: nil; tab-width: 4 -*-

'''
================================================================================
Objetivo:
		Observar a tipagem dinâmica.
Pratica:
		Tipos, Variáveis, Constantes e Operadores
================================================================================
'''

# Tipagem dinâmica
print("Tipagem Dinâmica")

valor = 2019
print("valor = 2019      ", type(valor))

valor = 2019.2020
print("valor = 2019.2020 ", type(valor))

valor = True
print("valor = True      ", type(valor))

valor = 'A'
print("valor = 'A'       ", type(valor))

valor = "2019"
print("valor = \"2019\"    ", type(valor))

print("\nConvertendo de real para inteiro")
print("int(3.14) = ", int(3.14))

print("\nConvertendo de inteiro para real")
print ('float(1000) =', float(1000))

print("\nCalculo entre inteiro e real resulta em real")
print ('5.0 / 2 + 3 = ', 5.0 / 2 + 3)

print("\nInteiros em outra base")
print ("int('20', 8)  =", int('20', 8)) # base 8
print ("int('20', 16) =", int('20', 16)) # base 16

'''
Output:

Tipagem Dinâmica
valor = 2019       <class 'int'>
valor = 2019.2020  <class 'float'>
valor = True       <class 'bool'>
valor = 'A'        <class 'str'>
valor = "2019"     <class 'str'>

Convertendo de real para inteiro
int(3.14) =  3

Convertendo de inteiro para real
float(1000) = 1000.0

Calculo entre inteiro e real resulta em real
5.0 / 2 + 3 =  5.5

Inteiros em outra base
int('20', 8)  = 16
int('20', 16) = 32
'''