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

	cout << "Procediemto de passagem por referência." << endl;	
	funcao_1(variavel);
	cout << "---------------------------" << endl;

	cout << "Função Principal" << endl;
	cout << "variavel = " << variavel << endl;

	return 0;
}

/*
Função Principal
variavel  = 2019
&variavel = 0xbf91b66c
---------------------------
Procediemto de passagem por referência.
referencia  = 2019
&referencia = 0xbf91b66c
referencia = 1980
---------------------------
Função Principal
variavel = 1980
*/