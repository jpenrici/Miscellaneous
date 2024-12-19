/*
  Objetivo:

    Explicar Estruturas de Decisão (Estruturas Condicionais) e
    os Operadores Lógicos (E, OU, NÃO).

*/

programa
{
  funcao inicio() {
    
    const cadeia EOL = "\n"
    
    inteiro num1, num2, num3

    escreva ("Digite um número: ")
    leia (num1)

    num2 = 100  // início do intervalo
    num3 = 200  // final do intervalo

    // Operadores Lógicos
    se (num1 >= num2 e num1 <= num3) {
      escreva(num1, " >= ", num2, " e ", num1, " <= ", num3)
    } senao {
      se (num1 < num2) {
        escreva(num1, " < ", num2)
        } senao {
          escreva(num1, " > ", num3)
        }
    }
  }
}

