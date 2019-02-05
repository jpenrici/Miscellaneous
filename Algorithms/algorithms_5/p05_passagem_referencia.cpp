/*
================================================================================
Objetivo:
		Estudo da declaração e uso de ponteiros.
		Passagem de parâmetro por referência (endereço).
		
Pratica:
		Tipos, Variáveis, Operadores
		Ponteiros
================================================================================		
*/ 
#include <iostream>

using namespace std;

void funcao_1(int& referencia)
{
	cout << "referencia  = " << referencia << endl;
	cout << "&referencia = " << &referencia << endl;
	referencia = 1980;
	cout << "referencia = " << referencia <<  endl;
}

int main()
{
	int variavel = 2019;

	cout << "Função Principal" << endl;
	cout << "variavel  = " << variavel << endl;
	cout << "&variavel = " << &variavel << endl;
	cout << "---------------------------" << endl;

	cout << "Função 1" << endl;	
	funcao_1(variavel);
	cout << "---------------------------" << endl;

	cout << "Função Principal" << endl;
	cout << "variavel = " << variavel << endl;

	return 0;
}

/*
Função Principal
variavel  = 2019
&variavel = 0xbfb078ec
---------------------------
Função 1
referencia  = 2019
&referencia = 0xbfb078ec
referencia = 1980
---------------------------
Função Principal
variavel = 1980
*/