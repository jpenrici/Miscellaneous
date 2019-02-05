/*
================================================================================
Objetivo: 
		Exibir os caracteres imprimíveis do código ASCII.
Pratica:
		Tipos do C++
================================================================================		
*/
#include <iostream>

int main()
{
	std::cout << "ASCII (Sinais Gráficos imprimíveis)" << std::endl;
	std::cout << "32\tEspaço" << std::endl;
	for (unsigned int i = 33; i <= 126; i++) {
		std::cout << i << "\t" << char(i) << "\t";
		if (i % 4 == 0)
			std::cout << std::endl;
	}
	return 0;
}

/*
ASCII
	inglês: American Standard Code for Information Interchange
    português: "Código Padrão Americano para o Intercâmbio de Informação"

É um código binário (cadeias de bits: 0s e 1s) que codifica um conjunto de
128 sinais, utilizando apenas 7 bits para representar todos os seus símbolos:
	95 sinais gráficos 
		letras do alfabeto latino, sinais de pontuação e sinais matemáticos
	33 sinais
		de controle

https://pt.wikipedia.org/wiki/ASCII
*/