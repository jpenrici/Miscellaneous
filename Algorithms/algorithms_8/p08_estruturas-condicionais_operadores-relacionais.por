/*
  Objetivo:

    Explicar Estruturas de Decisão (Estruturas Condicionais) e
    os Operadores relacionais.

*/

programa
{
  funcao inicio() {
    
    const cadeia EOL = "\n"

    inteiro num1, num2

    escreva ("Digite um número: ")
    leia (num1)

    num2 = 100

    // Operadores Relacionais
    se (num1 == num2) {
      escreva(num1, " é igual a ", num2, EOL)
    }

    se (num1 < num2) {
      escreva(num1, " é menor que ", num2, EOL)
    }

    se (num1 <= num2) {
      escreva(num1, " é menor ou igual a ", num2, EOL)
    }

    se (num1 > num2) {
      escreva(num1, " é maior que ", num2, EOL)
    }

    se (num1 >= num2) {
      escreva(num1, " é maior ou igual a ", num2, EOL)
    }

    se (num1 != num2) {
      escreva(num1, " é diferente de ", num2, EOL)
    }                

  }
}
