/*
================================================================================
Objetivo:
		Estudo da declaração e uso de ponteiros.
		
Pratica:
		Tipos, Variáveis, Operadores
		Ponteiros
================================================================================		
*/  
#include <iostream>

using namespace std;

int main ()
{
 int variavel;
 int *ponteiro;
 int valor;

 variavel = 3000;

 // Recebendo endereço da variável
 ponteiro = &variavel;

 // Recebendo o valor indicado pelo endereço do ponteiro
 valor = *ponteiro;

 cout << "Valor da variável : " << variavel << endl;
 cout << "Valor do ponteiro : " << ponteiro << " (endereço)" << endl;
 cout << "Valor de *ponteiro: " << valor << endl;

 return 0;
}
