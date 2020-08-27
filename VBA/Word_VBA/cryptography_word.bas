Attribute VB_Name = "cryptography_word"
Option Explicit

'*******************************************************************************
' Objetivo: Treinamento de Macro
' Trocar letras e numeros por simbolos
'*******************************************************************************

'**********************
'***** Estruturas *****
'**********************

Type Config
    charFont As String
    charNum As Integer
End Type


'*******************
'*** Constantes ****
'*******************

' Caracteres especiais
Const CR = 13     ' Carriage Return (vbCr, ASCII 13)
Const LF = 10     ' Nova linha ou quebra de linha (vbLf, ASCII 10)


'*********************
'*****  Funcoes  *****
'*********************

Function translate(ByVal char As String) As Config

    Dim newConfig As Config

    char = Left(char, 1)
    char = UCase(char)
    
    Select Case char
    Case "A", "Á", "À", "Â", "Â", "Ä"
        newConfig.charFont = "Wingdings"
        newConfig.charNum = -4022
    Case "B"
        newConfig.charFont = "Wingdings"
        newConfig.charNum = -4019
    Case "C"
        newConfig.charFont = "Symbol"
        newConfig.charNum = -3927
    Case "Ç"
        newConfig.charFont = "Wingdings"
        newConfig.charNum = -4055
    Case "D"
        newConfig.charFont = "Wingdings"
        newConfig.charNum = -4035
    Case "E", "É", "È", "Ê", "Ë"
        newConfig.charFont = "Wingdings"
        newConfig.charNum = -4015
    Case "F"
        newConfig.charFont = "Wingdings"
        newConfig.charNum = -4016
    Case "G"
        newConfig.charFont = "Wingdings"
        newConfig.charNum = -4056
    Case "H"
        newConfig.charFont = "Wingdings"
        newConfig.charNum = -4006
    Case "I", "Í", "Ì", "Î", "Ï"
        newConfig.charFont = "Wingdings"
        newConfig.charNum = -4042
    Case "J"
        newConfig.charFont = "Wingdings"
        newConfig.charNum = -4062
    Case "K"
        newConfig.charFont = "Wingdings"
        newConfig.charNum = -4054
    Case "L"
        newConfig.charFont = "Wingdings"
        newConfig.charNum = -4060
    Case "M"
        newConfig.charFont = "Wingdings"
        newConfig.charNum = -4018
    Case "N"
        newConfig.charFont = "Wingdings"
        newConfig.charNum = -4033
    Case "O", "Ó", "Ò", "Õ", "Ô", "Ö"
        newConfig.charFont = "Wingdings"
        newConfig.charNum = -4012
    Case "P"
        newConfig.charFont = "Wingdings"
        newConfig.charNum = -3973
    Case "Q"
        newConfig.charFont = "Wingdings"
        newConfig.charNum = -3915
    Case "R"
        newConfig.charFont = "Wingdings"
        newConfig.charNum = -3978
    Case "S"
        newConfig.charFont = "Wingdings"
        newConfig.charNum = -3974
    Case "T"
        newConfig.charFont = "Wingdings"
        newConfig.charNum = -4013
    Case "U", "Ú", "Ù", "Û", "Ü"
        newConfig.charFont = "Wingdings"
        newConfig.charNum = -3980
    Case "V"
        newConfig.charFont = "Wingdings"
        newConfig.charNum = -4040
    Case "X"
        newConfig.charFont = "Wingdings"
        newConfig.charNum = -4031
    Case "Z"
        newConfig.charFont = "Wingdings"
        newConfig.charNum = -4023
    Case "W"
        newConfig.charFont = "Wingdings"
        newConfig.charNum = -4008
    Case "Y"
        newConfig.charFont = "Wingdings"
        newConfig.charNum = -4045
    Case "0"
        newConfig.charFont = "Wingdings"
        newConfig.charNum = -3879
    Case "1"
        newConfig.charFont = "Wingdings"
        newConfig.charNum = -4063
    Case "2"
        newConfig.charFont = "Wingdings"
        newConfig.charNum = -4059
    Case "3"
        newConfig.charFont = "Wingdings"
        newConfig.charNum = -4058
    Case "4"
        newConfig.charFont = "Wingdings"
        newConfig.charNum = -4014
    Case "5"
        newConfig.charFont = "Wingdings"
        newConfig.charNum = -4038
    Case "6"
        newConfig.charFont = "Wingdings"
        newConfig.charNum = -4029
    Case "7"
        newConfig.charFont = "Wingdings"
        newConfig.charNum = -4005
    Case "8"
        newConfig.charFont = "Wingdings"
        newConfig.charNum = -4021
    Case "9"
        newConfig.charFont = "Wingdings"
        newConfig.charNum = -4020
    Case Else
        newConfig.charNum = 0
        newConfig.charFont = ""
    End Select
    
    translate = newConfig

End Function

Function convert(ByVal separator As String)

    On Error GoTo Attention
    
    Dim charNum, charSize, i As Integer
    Dim newText, char, temp As String
    Dim newConfig As Config
    
    newText = Selection.Text
    charSize = Selection.Font.Size
    
    Selection.InsertAfter (Chr(CR) + Chr(LF))
    
    temp = ""
    If (separator <> "") Then
        For i = 1 To Len(newText)
            char = Mid(newText, i, 1)
            temp = temp + char + separator
        Next i
        newText = temp
        Selection.InsertAfter (newText + Chr(CR) + Chr(LF))
    End If
    
    For i = 1 To Len(newText)
        char = Mid(newText, i, 1)
        newConfig = translate(char)

        If (newConfig.charFont <> "") Then
            With Selection
             .Collapse Direction:=wdCollapseEnd
             .InsertSymbol CharacterNumber:=newConfig.charNum, _
             Font:=newConfig.charFont, Unicode:=True
             .Font.Size = charSize
            End With
        Else
            With Selection
             .Collapse Direction:=wdCollapseEnd
             .InsertAfter Text:=char
             .Font.Size = charSize
            End With
        End If
    Next i

    Exit Function
    
Attention:
    ' Caso ocorra algo errado na macro.
    MsgBox ("Sorry, there was something wrong.")

End Function

'*********************
'***** PRINCIPAL *****
'*********************

Sub ENIGMA()
    ' Modo normal
    Call convert("")
    
End Sub

Sub ENIGMA_TAB()
    ' Para facilitar a conversao para Tabela
    Call convert(";")
    
End Sub


