/*
    Desafio de Programação
    ----------------------

      Desenvolva um script para exibir no terminal a sequência de símbolos
      abaixo, expressando visualmente uma Árvore de Natal.

      Entrada de dados: número de linhas.

      Saída: 
                   _
          *         | Copa:
         ***        |
        *****       |   O usuário indicará o número de linhas da copa.
       *******     _|
          #        _| Tronco 

    Tema:

      Estrutura de repetição
*/

programa {

  funcao inicio() {
  
    // Declarar variáveis
    inteiro linhas
    inteiro esquerda, centro, direita

    // Declarar constantes
    const caracter ESPACO = ' '
    const caracter FOLHA  = '*'
    const caracter TRONCO = '#'
    const cadeia   EOL    = "\n" 

    // Entrada de dados
    faca {
      escreva("Digite o número de linhas da copa: ")
      leia(linhas)
    } enquanto (linhas < 3)

    // Processamento e exibição da copa
    para (inteiro linha = 0; linha < linhas; linha++) {
      esquerda = 1 * linhas - linha 
      direita  = 2 * linhas - esquerda
      para(inteiro i = 0; i < esquerda; i++) {
        escreva(ESPACO)
      }
      para(inteiro i = esquerda; i <= direita; i++) {
        escreva(FOLHA)
      }      
      escreva(EOL)
    }

    // Processamento e exibição do tronco
    centro = linhas
    para(inteiro i = 0; i < centro; i++) {
      escreva(ESPACO)
    }
    escreva(TRONCO, EOL)

  }
}
