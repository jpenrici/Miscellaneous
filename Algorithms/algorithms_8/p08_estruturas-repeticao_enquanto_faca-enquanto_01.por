/*
  Objetivo:

    Explicar Estruturas de Repetição (Laço, Loop).

    Enquanto (While)
    Faça Enquanto (Do While)
    ------------------------
*/

programa {

  funcao inicio() {
    
    inteiro i // Contador

    // Enquanto (While)
    // enquanto (condição de parada) { instruções }
    i = 0
    enquanto (i < 3) {  
      escreva("i = ", i, "\n") 
      i++ // i = i + 1 (pós-incremento)
    }

    escreva("i = ", i, " (valor final - comando enquanto)\n")

    escreva("----------------------------------\n")

    // Faça Enquanto (Do While)
    // faca { instruções } enquanto (condição de parada)
    i = 0
    faca {
      escreva("i = ", i, "\n") 
      i++
    } enquanto (i < 3)

    escreva("i = ", i, " (valor final - comando faça enquanto)\n")

  }
}
