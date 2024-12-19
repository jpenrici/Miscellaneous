/*
    Treino de Programação
    ---------------------
    
    Objetivo:

      Refatorar para utilizar Array.

    Cenário:

      Desenvolver um script em Portugol para desenhar um gráfico de barras
      ao estilo horizontal no terminal.

      Exemplo:

      |# 1
      |#### 4
      |######### 9
      |############## 14
      |########### 10
      |## 2 
      | 0
        
    Fonte:

      Gráfico de Barras: https://pt.wikipedia.org/wiki/Gr%C3%A1fico_de_barras
*/

programa {

  funcao inicio() {

    // Teste : função para validar ideia de solução.
    // teste()

    // Teste : revisando reuso de código
    listar()
  }

  funcao gerar_barra(inteiro limite) {

    escreva("|")
    para (inteiro i = 0; i < limite; i++) { escreva("#") }
    escreva(" ", limite, "\n")

  }

  funcao teste() {

    gerar_barra(1)
    gerar_barra(4)
    gerar_barra(9)
    gerar_barra(14)
    gerar_barra(10)
    gerar_barra(2)
    gerar_barra(0)
    
  }

  funcao listar() {

    inteiro numeros[] = {1, 4, 9, 14, 10, 2, 0}
    inteiro limite = 7

    para(inteiro i = 0; i < limite; i++) {
      gerar_barra(numeros[i])
    }

  }

}
