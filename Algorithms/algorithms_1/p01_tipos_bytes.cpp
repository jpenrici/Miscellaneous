/*
================================================================================
Objetivo: 
		Verificar os limites dos tipos em bytes.
Pratica:
		Tipos do C++
================================================================================		
*/
#include <iostream>

using namespace std;

int main(){
	
	cout << "Tamanho do Tipo (Bytes)" << endl;
	cout << "-----------------------" << endl;
	cout << "char     : " << sizeof(char) << endl;
	cout << "int      : " << sizeof(int) << endl;
	cout << "short int: " << sizeof(short int) << endl;
	cout << "long  int: " << sizeof(long int) << endl;
	cout << "float    : " << sizeof(float) << endl;
	cout << "double   : " << sizeof(double) << endl;
	cout << "wchar_t  : " << sizeof(wchar_t) << endl;
	
	return 0;
	}
