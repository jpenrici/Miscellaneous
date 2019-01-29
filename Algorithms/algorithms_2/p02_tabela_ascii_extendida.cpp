/*
================================================================================
Objetivo: 
		Verificar as características de cada código ASCII

Pratica:
		Tipos do C/C++
		Operador ternário (<condição> ? <operação> verdade : <operação> falso)
		Bibliotecas do C
================================================================================		
*/
#include <stdio.h>		// biblioteca de entrada/saída
#include <ctype.h>		// biblioteca de tipos

#define LIMITE_MAX 0xFF	// 255 em Hexadecimal

int main()
{
	int codigo;

	for (codigo = 0; codigo <= LIMITE_MAX; ++codigo)
	{
		/*
		 * printf - imprimir saída de dados no terminal
		 * % - formatação
		 * d - decimal, inteiro
		 * c - caracter
		 * s - string
		 * https://en.wikipedia.org/wiki/Printf_format_string
		*/
		printf("%3d ", codigo);
		printf("%#04x ", codigo);						// hexadecimal
		printf("%3s ", isalnum(codigo) ? "AN" : " ");	// número 
		printf("%2s ", isalpha(codigo) ? "A" : " ");	// alfanumérico ?
		printf("%2s ", isblank(codigo) ? "B" : " ");	// espaço ?
		printf("%2s ", iscntrl(codigo) ? "C" : " ");	// caracter de controle ?
		printf("%2s ", isdigit(codigo) ? "D" : " ");	// dígito ?
		printf("%2s ", isgraph(codigo) ? "G" : " ");	// símbolo gráfico ?
		printf("%2s ", islower(codigo) ? "L" : " ");	// minúscula ?
		printf(" %c ", isprint(codigo) ? codigo : ' ');	// imprimir se visível.
		printf("%3s ", ispunct(codigo) ? "PU" : " ");	// pontuação ?
		printf("%2s ", isspace(codigo) ? "S" : " ");	// espaço, \t, \n ... ?
		printf("%3s ", isprint(codigo) ? "PR" : " ");	// imprimível ?
		printf("%2s ", isupper(codigo) ? "U" : " ");	// maiúscula ?
		printf("%2s ", isxdigit(codigo) ? "X" : " ");	// digito hexadecimal
		putchar('\n');
	}
	return 0;
}