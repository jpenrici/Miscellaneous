/*
================================================================================
Objetivo:
		Estudo da declaração e uso de ponteiros.
		Passagem de parâmetro por valor (cópia).
		
Pratica:
		Tipos, Variáveis, Operadores
		Ponteiros
================================================================================		
*/
#include <iostream>

using namespace std;

void funcao_1(int valor)
{
	cout << "valor  = " << valor << endl;
	cout << "&valor = " << &valor << endl;
	valor = 1980;
	cout << "valor = " << valor <<  endl;
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
&variavel = 0xbff310fc
---------------------------
Função 1
valor  = 2019
&valor = 0xbff310e0
valor = 1980
---------------------------
Função Principal
variavel = 2019
*/