algoritmo "Torre de Hanoi"
//==============================================================================
//Objetivo:
//         Torre de Hanói é um "quebra-cabeça" que consiste em uma base contendo
//         três pinos, em um dos quais são dispostos alguns discos uns sobre os
//         outros, em ordem crescente de diâmetro, de cima para baixo.
//         O problema consiste em passar todos os discos de um pino para outro
//         qualquer, usando um dos pinos como auxiliar, de maneira que um disco
//         maior nunca fique em cima de outro menor em nenhuma situação.
//         O número de discos pode variar sendo que o mais simples contém apenas
//         três.
//
//	        https://pt.wikipedia.org/wiki/Torre_de_Han%C3%B3i
//		
//Pratica:
//        Tipos, Variáveis, Operadores
//        Estrutura de Decisão
//        Estrutura de Repetição
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
      escreval("Torre de Hanói. Quantos discos: ")
      leia(numero_discos)

      escreval()
      escreval("Movimentos:")
      
      // iniciar o movimento com todos os discos na posição 1 (Origem)
      hanoi(numero_discos, "Origem", "Destino", "Trabalho")
fimalgoritmo
