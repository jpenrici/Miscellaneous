/*
================================================================================
Objetivo:
	Calcular o número perfeito.
	Um número perfeito é um número natural para o qual a soma de todos os seus
	divisores naturais próprios (excluindo ele mesmo) é igual ao próprio número.  

Pratica:
		Tipos, Variáveis, Operadores
		Estrutura de Decisão
		Estrutura de Repetição
		Bibliotecas
================================================================================		
*/ 
#include <iostream>

using namespace std;

bool perfeito(int numero);

int main()
{
	int numero;
	cout << "Digite um numero inteiro: ";
	cin >> numero;

	cout << "O numero " << numero;
	if(perfeito(numero))
		cout  << " é perfeito" << endl;
	else
		cout << " nao é perfeito" << endl;

	return 0;
}

bool perfeito(int n)
{
	int soma = 0, x;
	for(x = 1; x <=(n/2); x++)
		if(n % x == 0) soma += x;
	if(soma == n) return true;
	return false;
}
