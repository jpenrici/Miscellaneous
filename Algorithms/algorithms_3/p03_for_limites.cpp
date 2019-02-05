/*
================================================================================
Objetivo:
		Verificar as diferentes assinaturas das estrutura de repetição PARA.
		Imprimir uma sequência de valores de um vetor.
		Visualizar uso indevido de memória com vetores.
		
Pratica:
		Tipos, Variáveis, Operadores
		Estrutura de Decisão
		Estrutura de Repetição
		Vetores
		Bibliotecas
================================================================================		
*/ 
#include <iostream>

using std::cout;

#define MAX 5

int main()
{
	int i(0);
	char vetor[MAX] = {'A', 'E', 'I', 'O', 'U'};

	cout << "for (i = 0; i < MAX; ++i) {...}\n";
	for (i = 0; i < MAX; ++i) {
		cout << "[" << i << "] " << vetor[i] << "; ";

	}
	cout << "\ni = " << i << "\n";


	cout << "\nfor (i = 0; i < MAX; i++) {...}\n";
	for (i = 0; i < MAX; i++)
	{
		cout << "[" << i << "] " << vetor[i] << "; ";

	}
	cout << "\ni = " << i << "\n";


	cout << "\nfor (int i = MAX - 1; i > 0; --i) {...}\n";
	for (int i = MAX - 1; i > 0; --i)
	{
		cout << "[" << i << "] " << vetor[i] << "; ";

	}
	cout << "\ni = " << i << "\n";


	cout << "\nfor (int i = MAX - 1; i > 0; i--) {...}\n";
	for (int i = MAX - 1; i > 0; i--)
	{
		cout << "[" << i << "] " << vetor[i] << "; ";

	}
	cout << "\ni = " << i << "\n";

	cout << "\nfor (i = 0; i <= MAX; ++i) {...}\n";
	for (i = 0; i <= MAX; ++i)
	{
		cout << "[" << i << "] " << vetor[i] << "; ";

	}
	cout << "\ni = " << i << "\n";

	// a partir deste ponto ocorrem erros de acesso a memória
	// sem causar um erro de compilação, tão pouco, de execução.
	cout << "\nfor (i = 0; i <= MAX; i++) {...}\n";
	for (i = 0; i <= MAX; i++)
	{
		cout << "[" << i << "] " << vetor[i] << "; ";

	}
	cout << "\ni = " << i << "\n";


	cout << "\nfor (int i = MAX; i >= 0; --i) {...}\n";
	for (int i = MAX; i >= 0; --i)
	{
		cout << "[" << i << "] " << vetor[i] << "; ";

	}
	cout << "\ni = " << i << "\n";


	cout << "\nfor (int i = MAX; i >= 0; i--) {...}\n";
	for (int i = MAX; i >= 0; i--)
	{
		cout << "[" << i << "] " << vetor[i] << "; ";

	}
	cout << "\ni = " << i << "\n";

	return 0;
}