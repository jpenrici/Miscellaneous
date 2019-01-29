/*
================================================================================
Objetivo:
		Estudo da declaração e uso de ponteiros.
		
Pratica:
		Tipos, Variáveis, Operadores
		Vetores
		Ponteiros
================================================================================		
*/  
#include <iostream>
using namespace std;

int main()
{
	int array[10];
	int indice;
	int* ptrA;

	// preenche o vetor ou array {0, 1, ..., 9}
	for (indice = 0; indice < 10; indice++)
		array[indice] = indice;

	// ptrA aponta para o endereço de array
	ptrA = array;

	// exibir array via posição ou índice com ponteiro
	for (indice = 0; indice < 10; indice++)
		cout << ptrA[indice] << " ";
	cout << '\n';

	// somar 1 a cada valor através do ponteiro
	for (indice = 0; indice < 10; indice++)
		ptrA[indice] = ptrA[indice] + 1;

	// exibir array via posição ou índice
	for (indice = 0; indice < 10; indice++)
		cout << array[indice] << " ";
	cout << '\n';

	return 0;
}

/*

Output:
0 1 2 3 4 5 6 7 8 9 
1 2 3 4 5 6 7 8 9 10

*/