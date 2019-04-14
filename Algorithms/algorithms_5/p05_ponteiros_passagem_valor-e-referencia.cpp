/*
================================================================================
Objetivo:
		Estudo da declaração e uso de ponteiros.
		Passagem de parâmetro por valor (cópia) e por refência.
		
Pratica:
		Tipos, Variáveis, Operadores
		Ponteiros
================================================================================		
*/
#include <iostream>		// incluí a biblioteca de Entrada/Saída

using namespace std;	// espaço reservado da biblioteca std (padrão)

void procedimento_passagem_valor(int valor)
{
	cout << "valor recebido = " << valor << endl;
	cout << "endereço       = " << &valor << endl;
	valor = 1980;
	cout << "valor atual = " << valor <<  endl;
}

void procedimento_passagem_referencia(int& valor)
{
	cout << "valor recebido = " << valor << endl;
	cout << "endereço       = " << &valor << endl;
	valor = 2020;
	cout << "valor atual = " << valor <<  endl;
}

int main()
{
	int variavel = -2019;

	// int* ==> ponteiro do tipo inteiro
	// &variavel ==> indica o endereço da variável na memória
	int* ponteiro_variavel = &variavel;

	// 30 pontilhados
	const string LINHA = "-------------------------------";

	cout << "Função Principal" << endl;
	cout << "valor da variavel         = " << variavel << endl;
	cout << "endereço da variavel      = " << &variavel << endl;

	cout << "endereço do ponteiro      = " << ponteiro_variavel << endl;
	// *ptr ==> significa que obter valor do ponteiro
	cout << "valor acessdo no ponteiro = " << *ponteiro_variavel << endl;
	cout << LINHA << endl;

	cout << "Procedimento Passagem por Valor" << endl;	
	procedimento_passagem_valor(variavel);
	cout << LINHA << endl;

	cout << "Função Principal" << endl;
	cout << "variavel = " << variavel << endl;
	cout << LINHA << endl;	

	cout << "Procedimento por Referência" << endl;	
	procedimento_passagem_referencia(variavel);
	cout << LINHA << endl;

	cout << "Função Principal" << endl;
	cout << "variavel = " << variavel << endl;
	cout << LINHA << endl;

	return 0;
}

/*
No terminal
Compilação: g++ -c PO1_helloworld.cpp
Ligação   : g++ -o helloworld PO1_helloworld.o
Execução  : ./helloworld
*/

/*
Função Principal
valor da variavel         = -2019
endereço da variavel      = 0xbfccd394
endereço do ponteiro      = 0xbfccd394
valor acessdo no ponteiro = -2019
-------------------------------
Procedimento Passagem por Valor
valor recebido = -2019
endereço       = 0xbfccd360
valor atual = 1980
-------------------------------
Função Principal
variavel = -2019
-------------------------------
Procedimento por Referência
valor recebido = -2019
endereço       = 0xbfccd394
valor atual = 2020
-------------------------------
Função Principal
variavel = 2020
-------------------------------
*/