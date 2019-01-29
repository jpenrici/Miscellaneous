/*
================================================================================
Objetivo: 
		Boas vindas ao C++
Pratica:
		Comandos de Saída de Dados
		Compilação no terminal
================================================================================		
*/
#include <iostream>		// incluí a biblioteca de Entrada/Saída

// método principal
int main()
{
	/*
	 * std  : referência a biblioteca padrão do C++
	 * cout : comando de saída de dado textual
	 * endl : comando de final de linha
	 */
	std::cout << "Hello, World!" << std::endl;
	
	return 0;
}

/*
No terminal
Compilação: g++ -c PO1_helloworld.cpp
Ligação   : g++ -o helloworld PO1_helloworld.o
Execução  : ./helloworld
*/