/*
================================================================================
Objetivo:
		Exemplo de uso das variáveis local e global.
Pratica:
		Tipos, Variáveis, Operadores
		Funções
================================================================================		
*/ 
#include <iostream>
using namespace std;

// Declaração de variavel Global
int global = 100;

void funcao_1()
{
	// Declaração de variavel Local
	int local_1, local_2;

	// inicialização
	local_1 = 100;
	local_2 = 200;

	cout << "Função 1:" << endl
		 << "Variavel global  = " << global << endl;

	global = local_1 + local_2;

	cout << "Variavel local 1 = " << local_1 << endl
		 << "Variavel local 2 = " << local_2 << endl
		 << "Variavel global = local_1 + local_2 = " << global << endl;
}

int main() 
{
	// Declaração de variavel Local
	int local_1, local_2;

	// inicialização
	local_1 = 10;
	local_2 = 20;

	cout << "Função Principal:" << endl
		 << "Variavel global  = " << global << endl;

	global = local_1 + local_2;

	cout << "Variavel local 1 = " << local_1 << endl
		 << "Variavel local 2 = " << local_2 << endl
		 << "Variavel global = local_1 + local_2 = " << global << endl;

	cout << endl;
	funcao_1();

	return 0;
}
