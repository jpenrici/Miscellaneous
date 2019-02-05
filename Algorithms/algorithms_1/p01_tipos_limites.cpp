/*
================================================================================
Objetivo: 
		Verificar a capacidade numérica de cada tipo com sinal e sem sinal.
Pratica:
		Tipos do C++
		Tipos, Variáveis e Constantes
		Bibliotecas
================================================================================		
*/
#include <iostream>
#include <limits>

using namespace std;

int main()
{
	const std::string LINHA  = "---------------------------------------------";

	cout << "Limite Numérico(Máximo e Mínimo de cada Tipo)" << endl;
	cout << LINHA << endl;

	cout << "SHORT" << endl; 
	cout << "min: " << numeric_limits<short>::min() << endl;
	cout << "max: " << numeric_limits<short>::max() << endl;
	cout << LINHA << endl;

	cout << "INT" << endl;
	cout << "min: " << numeric_limits<int>::min() << endl;
	cout << "max: " << numeric_limits<int>::max() << endl;	
	cout << LINHA << endl;

	cout << "LONG" << endl;
	cout << "min: " << numeric_limits<long>::min() << endl;
	cout << "max: " << numeric_limits<long>::max() << endl;	
	cout << LINHA << endl;

	cout << "FLOAT" << endl;
	cout << "min: " << numeric_limits<float>::min() << endl;
	cout << "max: " << numeric_limits<float>::max() << endl;	
	cout << LINHA << endl;

	cout << "DOUBLE" << endl;
	cout << "min: " << numeric_limits<double>::min() << endl;
	cout << "max: " << numeric_limits<double>::max() << endl;	
	cout << LINHA << endl;

	cout << "LONG DOUBLE" << endl;
	cout << "min: " << numeric_limits<long double>::min() << endl;
	cout << "max: " << numeric_limits<long double>::max() << endl;	
	cout << LINHA << endl;

	cout << "UNSIGNED SHORT" << endl;
	cout << "min: " << numeric_limits<unsigned short>::min() << endl;
	cout << "max: " << numeric_limits<unsigned short>::max() << endl;	
	cout << LINHA << endl;

	cout << "UNSIGNED INT" << endl;
	cout << "min: " << numeric_limits<unsigned int>::min() << endl;
	cout << "max: " << numeric_limits<unsigned int>::max() << endl;	
	cout << LINHA << endl;

	cout << "UNSIGNED LONG" << endl;
	cout << "min: " << numeric_limits<unsigned long>::min() << endl;
	cout << "max: " << numeric_limits<unsigned long>::max() << endl;	
	cout << LINHA << endl;

	return 0;
}