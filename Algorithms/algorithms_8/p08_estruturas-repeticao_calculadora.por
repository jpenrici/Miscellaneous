/*
    Treino de Programação
    ---------------------

    Estruturas de Decisão (ESCOLHA-CASO, CASO SE)
    Estruturas de Repetição (Enquanto, While)

    Atividade:
      
      Desenvolva um script em Portugol que simule uma calculadora que faz
      as quatro operações matemáticas (soma, subtração, multiplicação e divisão).

      Entrada de Dados:

        02 números fornecidos pelo usuário, que serão os operandos.
        01 número  fornecido  pelo usuário, que corresponderá ao operador.

        Lembrando:

          resultado = operando1 operador operando2

        Por exemplo:

          primeiro número = 10
          segundo  número = 20

          +---------------+--------+----------------------------------+-----------+
          | Operação      | Número |              Cálculo             | Resultado |
          +---------------+--------+----------------------------------+-----------+
          | soma          |    1   | primeiro número + segundo número |     30    |
          +---------------+--------+----------------------------------+-----------+
          | subtração     |    2   | primeiro número - segundo número |    -10    |
          +---------------+--------+----------------------------------+-----------+
          | multiplicação |    3   | primeiro número * segundo número |    200    |
          +---------------+--------+----------------------------------+-----------+
          | divisão       |    4   | primeiro número / segundo número |    0.5    |
          +---------------+--------+----------------------------------+-----------+

       Dica:

          Crie um menu pra informar o usuário. Use a criatividade!

      Saída dos Resultados:

        Exiba os resultados na forma mais atraente para o usuário.

      Atenção:

        Pratique o hábito de comentar o código!

*/

programa {

  funcao inicio() {

    // Declarar variáveis
    cadeia  menu
    inteiro opcao
    logico  armazenar_resultado
    real    primeiro_numero, segundo_numero, resultado

    // Declarar constantes
    const cadeia EOL = "\n"

    // Menu
    menu  = "+------------------------+\n"
    menu += "|      Calculadora       |\n"
    menu += "+---------------+--------+\n"
    menu += "| Operação      | Número |\n"
    menu += "+---------------+--------+\n"
    menu += "| soma          |    1   |\n"
    menu += "+---------------+--------+\n"
    menu += "| subtração     |    2   |\n"
    menu += "+---------------+--------+\n"
    menu += "| multiplicação |    3   |\n"
    menu += "+---------------+--------+\n"
    menu += "| divisão       |    4   |\n"
    menu += "+---------------+--------+\n\n"
    menu += "+---------------+--------+\n"    
    menu += "| sair          |    0   |\n"    
    menu += "+---------------+--------+\n\n"
    menu += "Digite o número da operação desejada: "

    // Controlador de armazenamento
    armazenar_resultado = falso

    // Loop
    enquanto (opcao != 0) {

      limpa() // limpar tela do terminal      

      // Entrada de Dados
      escreva(menu)
      leia(opcao)

      se (opcao >= 1 e opcao <= 4) {

        escreva("Digite o primeiro número: ")
        se (nao armazenar_resultado) {  
          leia(primeiro_numero)
        } senao {
          escreva(primeiro_numero, EOL)
        }

        escreva("Digite o segundo número : ")
        leia(segundo_numero)

        escreva(EOL)
      }

      // Calcular, processar e exibir
      escolha (opcao) {
        caso 1:
          resultado = primeiro_numero + segundo_numero
          escreva(primeiro_numero," + ", segundo_numero, " = ", resultado, EOL)
          pare
        caso 2:
          resultado = primeiro_numero - segundo_numero
          escreva(primeiro_numero," - ", segundo_numero, " = ", resultado, EOL)
          pare  
        caso 3:
          resultado = primeiro_numero * segundo_numero        
          escreva(primeiro_numero," * ", segundo_numero, " = ", resultado, EOL)           
          pare 
        caso 4:     
          escreva(primeiro_numero," / ", segundo_numero)
          se (segundo_numero == 0) {
            escreva(" : Erro, divisão por Zero", EOL)
          } senao {
            resultado = primeiro_numero / segundo_numero   
            escreva(" = ", resultado, EOL)
          }
          pare
        caso 0:
          escreva("Aplicação finalizada!")
          pare           
        caso contrario:
          escreva("Opção inválida!", EOL)
      }

      // Se não for a opção Sair.
      se (opcao != 0) {
        // Ações específicas
        caracter resposta

        escreva(EOL, "Deseja armazenar este resultado? S-sim/N-não: ")
        leia(resposta)
        se (resposta == 'S' ou resposta == 's') {
          primeiro_numero = resultado
          armazenar_resultado = verdadeiro
          escreva("Pronto! O valor será armazenado para o próximo cálculo.")
        } senao {
          resultado = 0
          armazenar_resultado = falso
        }

        // Somente para aguardar a leitura do resultado antes de limpar tela.        
        escreva(EOL, "Tecle Enter para continuar: ")
        leia(resposta) 
      }

    }

  }
}