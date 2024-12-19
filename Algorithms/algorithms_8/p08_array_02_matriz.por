/*
    Treino de Programação
    ---------------------
    
    Objetivo:

      Explicar Matriz (Array Bidimensional).

*/

programa {

  funcao inicio() {

    // Array Bidimensional : Matriz
    //
    //       0   1   2   3   4   --> índice das colunas
    //     +---+---+---+---+---+
    //   0 | A | B | C | D | F |
    //     +---+---+---+---+---+    
    //   1 | G | H | I | J | K |
    //     +---+---+---+---+---+    
    //   2 | L | M | N | O | P |
    //   | +---+---+---+---+---+    
    //   |__ índice das linhas

    // Inicializar
    caracter letras[][] = {
      {'A', 'B', 'C', 'D', 'F'},
      {'G', 'H', 'I', 'J', 'K'},
      {'L', 'M', 'N', 'O', 'P'}
    }

    // Exibir
    para (inteiro i = 0; i < 3; i++) {
      para (inteiro j = 0; j < 5; j++) {
        escreva("letras[", i, "][", j, "]: ", letras[i][j], "\n")
      }
    }

  }

}