/*
   Script Extra
   ------------

   Tema:
     
      Escolha-caso (Caso se, Switch case)
      Funções
      Testes

   Objetivo:

      Observar o funcionamento do comando "parar" 
      da estrutura de decisão Escolha-caso.

      Observar a importância das funções na manutenção e
      organização do código.
*/

programa {

  const cadeia EOL = "\n"

  funcao inicio() {

    // Descomente para executar testes.
    // testar()

    // Principal
    logico parar = falso
    caracter opcao
    faca {
      opcao = menu()
      escreva("Sabor escolhido: ", escolher(opcao), EOL, EOL)
      escreva("Deseja continuar? S-sim/N-não: ")
      leia(opcao)
      se (opcao != 'S' e opcao != 's') {
        parar = verdadeiro
      }
    } enquanto (nao parar)
  }

  funcao caracter menu() {

    // Limpar tela do terminal.
    limpa()
  
    // Menu
    escreva("+--------------------------------------------+", EOL)
    escreva("|         Sorveteria  Mil Sabores            |", EOL)
    escreva("+---+----------------------------------------+", EOL)
    escreva("| A |  Baunilha                              |", EOL)
    escreva("| B |  Chocolate                             |", EOL)
    escreva("| C |  Creme                                 |", EOL)
    escreva("| D |  Doce de leite                         |", EOL)
    escreva("| E |  Flocos                                |", EOL)
    escreva("| F |  Morango                               |", EOL)
    escreva("+---+----------------------------------------+", EOL)    
    escreva("| G |  Creme, Doce de leite                  |", EOL)
    escreva("| H |  Flocos, Morango                       |", EOL)
    escreva("+---+----------------------------------------+", EOL)    
    escreva("| I |  Baunilha, Creme, Doce de leite        |", EOL)
    escreva("| J |  Chocolate, Flocos, Morango            |", EOL)
    escreva("+---+----------------------------------------+", EOL)        
    escreva("| ? |  Surpresinha                           |", EOL)
    escreva("+---+----------------------------------------+", EOL, EOL)

    caracter opcao
    escreva("Digite a opção: ")
    leia(opcao)

    retorne opcao
  }

  funcao cadeia escolher(caracter opcao) {

    cadeia sorvete = ""
    escolha (opcao) {
      caso 'a': 
      caso 'A':
        sorvete += "Baunilha"
        pare
      caso 'b':
      caso 'B':
        sorvete += "Chocolate"
        pare
      caso 'c':
      caso 'C':
        sorvete += "Creme"
        pare
      caso 'e':
      caso 'E':
        sorvete += "Flocos"
        pare
      caso 'j':
      caso 'J':
        sorvete += "Chocolate,"
      caso 'h':
      caso 'H':
        sorvete += "Flocos,"
      caso 'f':
      caso 'F':
        sorvete += "Morango"
        pare
      caso 'i':
      caso 'I':
        sorvete += "Baunilha,"  
      caso 'g': 
      caso 'G':   
        sorvete += "Creme,"
      caso 'd':
      caso 'D':
        sorvete += "Doce de leite"
        pare
      caso contrario:
        sorvete = "Surpresinha"
    }

    retorne sorvete
  }

  funcao comparar(cadeia processado, cadeia esperado) {
    escreva("Processado: '", processado, "'", EOL)
    escreva("Esperado  : '", esperado, "'", EOL)
    escreva("Resultado :  ", processado == esperado, EOL)
    escreva("-------------------------------------", EOL)
  }

  funcao testar() {
    comparar(escolher('1'), "Surpresinha")
    comparar(escolher('A'), "Baunilha")
    comparar(escolher('B'), "Chocolate")
    comparar(escolher('C'), "Creme")
    comparar(escolher('D'), "Doce de leite")
    comparar(escolher('E'), "Flocos")
    comparar(escolher('F'), "Morango")
    comparar(escolher('G'), "Creme,Doce de leite")
    comparar(escolher('H'), "Flocos,Morango")
    comparar(escolher('I'), "Baunilha,Creme,Doce de leite")
    comparar(escolher('J'), "Chocolate,Flocos,Morango")
  }
}
