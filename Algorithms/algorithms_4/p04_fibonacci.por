/*
================================================================================
Objetivo:
		Cálculo Fibonacci.
		Conparação dos métodos Iterativo, Recursivo e Dinâmico.
		
Pratica:
		Tipos, Variáveis, Operadores
		Estrutura de Decisão
		Estrutura de Repetição
		Procedimentos
		Funções
		Vetores
		Bibliotecas
================================================================================		
*/ 
programa
{
	inclua biblioteca Util --> u

	// vetor global
	const inteiro FIBMAX = 100
	inteiro vetor_fibonacci[FIBMAX]
	
	funcao inteiro fib_iterativo(inteiro n) {
		inteiro f, f1, f2
		se (n < 2) {
			retorne n
		}
		f = 0
		f1 = 1
		f2 = 1
		para(inteiro k = 2; k < n; k++) {
			f = f1 + f2
			f2 = f1
			f1 = f
		}
		retorne f	 
	}

	funcao inteiro fib_dinamica(inteiro n) {
		se (n < 2) {
			vetor_fibonacci[n] = n
		}
		se(vetor_fibonacci[n] == -1) {
			vetor_fibonacci[n] = fib_dinamica(n - 1) + fib_dinamica(n - 2)
		}
		retorne vetor_fibonacci[n]
	}

	funcao inteiro fib_recursivo(inteiro n) {
		se (n < 2) {
			retorne n
		}
		retorne fib_recursivo(n - 1) + fib_recursivo(n - 2)
	}	
	
	funcao inicio()
	{
		inteiro tempo_inicial = 0
		inteiro tempo_final = 0

		// zerar vetor de números Fibonacci
		para(inteiro i = 0; i < FIBMAX; i++) {
			vetor_fibonacci[i] = -1
		}

		// valor a calcular
		inteiro n = 35

		// ITERATIVO
		tempo_inicial = u.tempo_decorrido()
		escreva("Iterativo: \nfib(", n, ") = ", fib_iterativo(n))
		tempo_final = u.tempo_decorrido()
		escreva("\ttempo : ", (tempo_final - tempo_inicial), " milissegundos\n")

		// RECURSIVO		
		tempo_inicial = u.tempo_decorrido()
		escreva("Recursivo: \nfib(", n, ") = ", fib_recursivo(n))
		tempo_final = u.tempo_decorrido()
		escreva("\ttempo : ", (tempo_final - tempo_inicial), " milissegundos\n")

		// DINÂMICA
		tempo_inicial = u.tempo_decorrido()
		escreva("Dinâmica: \nfib(", n, ") = ", fib_dinamica(n))
		tempo_final = u.tempo_decorrido()
		escreva("\ttempo : ", (tempo_final - tempo_inicial), " milissegundos\n")		
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 1200; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */