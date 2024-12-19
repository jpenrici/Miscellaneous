/*
    Treino de Programação
    ---------------------
    
    Objetivo:

      Explicar Vetor (Array Unidimensional).

*/

programa {

  funcao inicio() {
    
    // Array Unidimensional : Vetor

    // Posição ou índice |0  1  2  3  4  5  6|
    inteiro numeros[] =  {1, 2, 3, 4, 5, 6, 0}  // Tamanho = 7 elementos

    // Atualizar valor no vetor
    numeros[6] = 999  // O elemento da posição 6 sendo 0 passa para 999.
    numeros[3] = 1000 // O elemento da posição 3 sendo 4 passa para 1000.

    // Acessar, visualizar ou exibir posições específicas
    escreva("numeros[0]: ", numeros[0], "\n")
    escreva("numeros[1]: ", numeros[1], "\n")
    escreva("numeros[3]: ", numeros[3], "\n")
    escreva("numeros[6]: ", numeros[6], "\n\n")

    // Exibir todos os elementos (Percorrer o Array ou Vetor)
    para(inteiro indice = 0; indice < 7; indice++) {
      escreva("numeros[", indice, "]: ", numeros[indice], "\n")
    }

  }
}