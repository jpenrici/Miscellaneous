/*
    Treino de Programação
    ---------------------

    Temas:
        
        Funções,
        Variáveis, Constantes, 
        Estruturas de Decisão, Estrutura de Repetição,
        Entrada e Saída de Dados.

        Performance ao lidar com estruturas de repetição.

    Tarefa:
    
        1) Construa um script em Portugol que irá exibir os 100 primeiros números primos.
        
        2) Execute teste e posteriormente construa uma função que exiba a quantidade de
           números primos escolhida pelo usuário.

    Fonte:

        Números primos
        https://www.todamateria.com.br/numeros-primos/

    Exemplo teste:

        10 primeiros números primos: 2, 3, 5, 7, 11, 13, 17, 19, 23, 29

*/

programa {
    
  funcao inicio() {

    // Teste
    // listar(10)

    // Requesitos
    listar(100)

  }

  funcao logico primo(inteiro numero) {

        // Declarar variáveis
        inteiro contador = 0
        logico  eh_primo = falso

        // Verificar se número é primo.
        para (inteiro i = 1; i <= numero; i++) {
            se (numero % i == 0) {
                contador++ // achou um divisor
            }
            se (contador > 2) {
                pare // não é primo
            }
        }

        se (contador == 2) { // é primo
            eh_primo = verdadeiro
        }

        retorne eh_primo
  }

  funcao listar(inteiro limite) {

    // Declarar variáveis
    inteiro numero, repeticao

    // Processar e exibir
    numero    = 0
    repeticao = 0
    enquanto (repeticao < limite) {

        // Verificar se número é primo.
        se (primo(numero)) { // é primo, se retorno verdadeiro
            repeticao++      // abrir novo ciclo  
            escreva(numero, " ")
        }

        numero++ // passar pro próximo número
    }

  }
}