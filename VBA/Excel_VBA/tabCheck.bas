Attribute VB_Name = "tabCheck"
Option Explicit

'*******************************************************************************
' Objetivo: Treinamento de Macro
' Validar tabela usando regras indicadas em arquivo CSV.
'*******************************************************************************

'*******************
'*** Estruturas ****
'*******************

Type Field
    name      As String
    num       As String
    alpha     As String
    capsLock  As String
    vDate     As String
    numChar   As Integer
    minChar   As Integer
    maxChar   As String
    format    As String
    condition(1 To 2) As String
End Type

'*******************
'*** Constantes ****
'*******************

Const SPACE As String = " "      ' Espaco de preenchimento a direita
Const ZERO  As String = "0"      ' Zero de preenchimento a esquerda
Const DELIM As String = ";"      ' Delimitador CSV
Const YES As String = "yes"
Const NO  As String = "no"

' Caracteres especiais
Const CR = 13     ' Carriage Return (vbCr, ASCII 13)
Const LF = 10     ' Nova linha ou quebra de linha (vbLf, ASCII 10)

' Arquivo de configuracao
Const CSVCONFIG As String = "table_config.csv"

'*****************
'***  Global  ****
'*****************

Dim data() As Field    ' Campos e Regras de Validacao
Dim status As Boolean  ' Estado da configuracao
Dim EOL    As String   ' vbCrLf

'******************
'***  Funcoes  ****
'******************

' CONFIG
Function config(ByVal path As String) As Boolean

    Dim lines() As String
    Dim entry() As String
    Dim i, j As Integer

    ' Carregar CONFIG
    If (status = False) Then
        status = True
        lines = load(path)
        Debug.Print path
    
        ' Regras
        j = 1
        ReDim data(UBound(lines))
        For i = 1 To UBound(lines)
            If (lines(i) <> "") Then
                entry() = Split(lines(i), DELIM)
                ' Simples
                data(j).name = entry(0)
                data(j).num = entry(1)
                data(j).alpha = entry(2)
                data(j).capsLock = entry(3)
                data(j).vDate = entry(4)
                data(j).minChar = entry(5)
                data(j).maxChar = entry(6)
                data(j).numChar = data(j).minChar + data(j).maxChar
                data(j).format = entry(7)
                ' Extras
                data(j).condition(1) = entry(8)
                data(j).condition(2) = entry(9)
                Debug.Print "["; j; "]:"; data(j).name
                j = j + 1
            End If
        Next i
        
    End If
       
    config = status ' Retornar estado
    
End Function

' Comunicar Erro
Function alert(ByVal wks As String, _
               ByVal row As Integer, _
               ByVal col As Integer, _
               ByVal msg As String, _
               ByVal change As Boolean)
    
    ' Indicar erro
    Worksheets(wks).Cells(row, col).Select
    MsgBox (msg)
    
    If (change = True) Then
        End ' Parar para corrigir
    End If
    
End Function

' Validadar
Function validate(ByVal wks As String, _
                  ByVal row As Integer, _
                  ByVal col As Integer, _
                  ByVal numCol As Integer, _
                  ByVal change As Boolean) As String
                           
    Dim vCell
    Dim r, c, numRow As Integer
    Dim msgError, logError As String

    ' Armazenar erros
    logError = ""
    
    numRow = 0  ' Contar registros
    While Cells(row + numRow, col).value <> ""
        numRow = numRow + 1
    Wend
    
    ' Analisar
    For r = row To row + numRow - 1     ' Registros
        For c = col To col + numCol - 1 ' Campos

            vCell = Cells(r, c).value   ' planilha
            msgError = "Line[" + CStr(r) + "], " + data(c).name _
                       + ":" + EOL + "Expected "
                
            ' Esperar preenchimento
            If (vCell = "") Then
                msgError = msgError + "Fill" + EOL
                logError = logError + msgError
                Call alert(wks, r, c, msgError, change)
            End If
            
            ' Esperar Alfanumerico
            If (data(c).num = NO Or data(c).alpha = NO) Then
            
                ' Esperar Numero
                If (data(c).num = YES And isNumeric(vCell) = False) Then
                    msgError = msgError + "Numeric, Value = " + CStr(vCell) + EOL
                    logError = logError + msgError
                    Call alert(wks, r, c, msgError, change)
                End If
                
                ' Esperar Alfabetico
                If (data(c).alpha = YES And isNumeric(vCell) = True) Then
                    msgError = msgError + "Alphabetic, Value = " + CStr(vCell) + EOL
                    logError = logError + msgError
                    Call alert(wks, r, c, msgError, change)
                End If
                
            End If
            
            ' Esperar Maiuscula
            If (data(c).capsLock = YES And UCase(vCell) <> vCell) Then
                msgError = msgError + "Upper Case, Value = " + CStr(vCell) + EOL
                logError = logError + msgError
                Call alert(wks, r, c, msgError, change)
            End If
            
            ' Esperar Data
            If (data(c).vDate = YES And IsDate(vCell) = False) Then
                msgError = msgError + "Date, Value = " + CStr(vCell) + EOL
                logError = logError + msgError
                Call alert(wks, r, c, msgError, change)
            End If
            
            ' Esperar entre Minimo e Maximo caracteres
            If (Len(vCell) < data(c).minChar And Len(vCell) > data(c).maxChar) Then
                msgError = msgError + "Characters (Min " + CStr(data(c).minChar) _
                        + ": Max " + CStr(data(c).maxChar) + "), Value = " _
                        + CStr(Len(vCell)) + EOL
                logError = logError + msgError
                Call alert(wks, r, c, msgError, change)
            End If
            
            ' Esperar formatacao
            If (vCell <> CStr(format(vCell, data(c).format)) And _
                data(c).format <> NO) Then
                msgError = msgError + "Format " + data(c).format + "," _
                    + "value = " + CStr(vCell) + EOL
                logError = logError + msgError
                Call alert(wks, r, c, msgError, change)
            End If
            
            'condition(1)
            'condition(2)
        
        Next c
    Next r
    
    validate = logError
    
End Function

' Carregar arquivo
Function load(ByVal path As String) As Variant

    Dim fileNumber As Integer
    Dim lines() As String
    Dim i As Long
    
    fileNumber = FreeFile()
    Open path For Input As #fileNumber
        lines = Split(Input$(LOF(fileNumber), #fileNumber), vbNewLine)
    Close #fileNumber
    
    load = lines    ' Retornar array

End Function

' Selecionar arquivo de saida
Function saveAs(ByVal filename As String) As String

    Dim newFile As Variant
    newFile = Application.GetSaveAsFilename(filename, _
        "Text Files (*.txt), *.txt")
    If newFile = False Then
        newFile = ""
    End If
    
    saveAs = newFile    ' Retornar nome do arquivo

End Function

' Armazenar arquivo
Function save(ByVal path As String, _
              ByVal text As String, _
              ByVal extension As String)

    If (UCase(Right(path, 4)) <> UCase("." + extension)) Then
        path = path + "." + extension
    End If
    
    ' Salvar
    Open path For Output As #1
    Print #1, text
    Close #1
    
    MsgBox ("Save: " + path)

End Function

' Criar nova planilha
Function createWks(ByVal name As String)

    Worksheets.Add(After:=Sheets(Sheets.Count)).name = name

End Function

' Verificar se planilha existe
Function searchWks(ByVal name As String) As Boolean

  Dim wks As Worksheet
  Dim result As Boolean
  
  result = False
  For Each wks In ThisWorkbook.Sheets
    Application.DisplayAlerts = False
    If wks.name = name Then
        result = True
    End If
    Application.DisplayAlerts = True
  Next wks
  
  searchSpreadsheet = result
  
End Function

'*********************
'***** PRINCIPAL *****
'*********************

Sub tabCheck()

    ' On Error GoTo Attention
    
    Dim pathConfig As String
    pathConfig = Application.ActiveWorkbook.path + "\" + CSVCONFIG
    
    Dim log, msgResponse As String
    Dim wks, filename As String
    Dim row, column As Integer
    Dim change As Boolean
    
    ' Incializar
    log = ""
    change = True
    EOL = Chr(CR) + Chr(LF) ' vbCrLf
    
    ' Valores teste
    wks = "DADOS"
    row = 2
    column = 1
    filename = "logError.txt"
    
    ' Carregar CONFIG
    status = config(pathConfig)
    Debug.Print "CONFIG Status: "; status
    Debug.Print "Data  :"; UBound(data); "items"
    
    ' Validar tabela
    If (status = True) Then
    
        ' Corrigir durante checagem
        msgResponse = MsgBox("Stop to change? ", _
                            vbYesNo + vbQuestion, "Check")
        If msgResponse = vbNo Then
            change = False
        End If
        
        log = validate(wks, row, column, UBound(data) - 1, change)
        Debug.Print "Log:"; EOL; log

        ' Exportar
        If (log <> "") Then
            msgResponse = MsgBox("Export errors? ", _
                            vbYesNo + vbQuestion, "Check")
            If msgResponse = vbYes Then
                filename = saveAs(filename)
            
                If (filename <> "") Then
                   Call save(filename, log, "TXT")
                End If
            End If
            
        End If
        
    End If
    
    Exit Sub
    
Attention:
    ' Caso ocorra algo errado na macro.
    MsgBox ("Sorry, there was something wrong.")

End Sub

Sub reconfigure()
    status = False
    tabCheck
End Sub
