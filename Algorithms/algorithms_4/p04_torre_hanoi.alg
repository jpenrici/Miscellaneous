algoritmo "Torre de Hanoi"
//
// encoding='ISO-8859-1'
//
//==============================================================================
//Objetivo:
//         Torre de Han�i � um "quebra-cabe�a" que consiste em uma base contendo
//         tr�s pinos, em um dos quais s�o dispostos alguns discos uns sobre os
//         outros, em ordem crescente de di�metro, de cima para baixo.
//         O problema consiste em passar todos os discos de um pino para outro
//         qualquer, usando um dos pinos como auxiliar, de maneira que um disco
//         maior nunca fique em cima de outro menor em nenhuma situa��o.
//         O n�mero de discos pode variar sendo que o mais simples cont�m apenas
//         tr�s.
//
//	        https://pt.wikipedia.org/wiki/Torre_de_Han%C3%B3i
//		
//Pratica:
//        Tipos, Vari�veis, Operadores
//        Estrutura de Decis�o
//        Estrutura de Repeti��o
//        Procedimentos
//==============================================================================

procedimento hanoi(numero_discos: inteiro; origem, destino, temp: caractere)
inicio
      se numero_discos > 0 entao
         hanoi(numero_discos - 1, origem, temp, destino)
         escreval(origem, " -> ", destino)
         hanoi(numero_discos - 1, temp, destino, origem)
      fimse
fimprocedimento

var
   numero_discos : inteiro

inicio
      escreval("Torre de Han�i. Quantos discos: ")
      leia(numero_discos)

      escreval()
      escreval("Movimentos:")
      
      // iniciar o movimento com todos os discos na posi��o 1 (Origem)
      hanoi(numero_discos, "Origem", "Destino", "Trabalho")
fimalgoritmo
