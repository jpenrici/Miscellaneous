/*
  Objetivo:

    Explicar Estruturas de Repetição (Laço, Loop).
    Observar a condição de parada ou expressão lógica de controle.

    Enquanto (While)
    Faça Enquanto (Do While)
    ------------------------
*/

programa {

  funcao inicio() {

    logico prosseguir = falso

    // Enquanto (While)
    // enquanto (condição de parada) { instruções }
    enquanto (prosseguir) {
      escreva("Enquanto: passei por aqui neste bloco de instruções!\n")
      prosseguir = falso
    }
    
    prosseguir = verdadeiro

    // Faça Enquanto (Do While)
    // faca { instruções } enquanto (condição de parada)
    faca {
      escreva("Faça Enquanto: passei por aqui neste bloco de instruções!\n")
      pare  // finaliza execução do loop independente da condição de parada.
    } enquanto (prosseguir)

    escreva("Terminei!!!!!")
    
  }
}
