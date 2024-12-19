/*
   Script Extra
   ------------

   Tema:
     
      Estruturas de repitção.

   Objetivo:

      Observar as formas de sair do loop e construção de instruções.

*/

programa {

  funcao inicio() {
    
    inteiro i
    inteiro limite = 3

    // Enquanto
    i = 0
    enquanto (i < limite) {
      escreva("Enquanto ", i , " < ", limite, " : ", i < limite, "\n")
      i = i + 1
    }
    escreva("Enquanto ", i , " < ", limite, " : ", i < limite, "\n\n")

    // Faça Enquanto
    i = 0
    faca {
      escreva("Faça Enquanto ", i , " < ", limite, " : ", i < limite, "\n")
      i = i + 1        
    } enquanto (i < limite)
    escreva("Faça Enquanto ", i , " < ", limite, " : ", i < limite, "\n\n")

    // Para até
    para(i = 0; i < 1000; i++) {
      escreva("Para ", i , " < 1000 : ", i < 1000, "\n")
      se (i >= limite) {
        escreva("Pare!\n")
        pare // Forçando parada.
      }
    }
    escreva("Para ", i , " < 1000 : ", i < 1000, "\n\n")

    para(i = 0; i < 1000; i++) {
      escreva("Para ", i , " < 1000 : ", i < 1000, "\n")
      se (i >= limite) {
        escreva("Pare!\n")
        i = 2000 // Forçando para por valor.
      }
    }
    escreva("Para ", i , " < 1000 : ", i < 1000, "\n\n")

  }
}
