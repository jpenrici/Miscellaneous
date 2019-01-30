# -*- Mode: Python; coding: utf-8; indent-tabs-mpythoode: nil; tab-width: 4 -*-

'''
================================================================================
Objetivo:
		Operadores lógicos.
		Manipulaçao Bit a Bit (Bitwise).
Pratica:
		Tipos, Variáveis, Constantes e Operadores
================================================================================
'''

# declaração de variáveis
a = 60  # 60 = 00111100
b = 13  # 13 = 00001101
c = 0	# 0  = 00000000 
print("a =", a,"\nb =", b)

# AND
c = a & b   # 12 = 00001100
print ("c = a & b     ", c)

# OR
c = a | b   # 61 = 0011 1101
print ("c = a | b     ", c)

# XOR
c = a ^ b   # 49 = 0011 0001
print ("c = a ^ b     ", c)

# NOT
c = ~a      # -61 = 1100 0011
print ("c = ~a       ", c)

# Binary Left Shift Operator
c = a << 2  # 240 = 1111 0000
print ("c = a << 2   ", c)

# Binary Right Shift Operator
c = a >> 2  # 15 = 0000 1111
print ("c = a >> 2    ", c)

'''
Output:

a = 60 
b = 13
c = a & b      12
c = a | b      61
c = a ^ b      49
c = ~a        -61
c = a << 2    240
c = a >> 2     15
'''