Attribute VB_Name = "insert_textBox"
Option Explicit

'*******************************************************************************
' Objetivo: Treinamento de Macro
' Inserir textos referenciados em arquivo CSV nos slides.
'
'   Arquivo text.CSV
'       Dados: Texto_a_inserir;pos_X;pos_Y;largura;altura;numero_slide
'
'*******************************************************************************

'*******************
'*** Constantes ****
'*******************

Const DELIM As String = ";" ' Delimitador CSV
Const CSVPATH As String = "text.csv"

' Caracteres especiais
Const CR = 13     ' Carriage Return (vbCr, ASCII 13)
Const LF = 10     ' Nova linha ou quebra de linha (vbLf, ASCII 10)

'*****************
'***  Global  ****
'*****************

Dim status As Boolean
Dim EOL    As String   ' vbCrLf

'******************
'***  Funcoes  ****
'******************

'TEXTBOX
Function addText(ByVal Text As String, _
                 ByVal x As Integer, ByVal y As Integer, _
                 ByVal w As Integer, ByVal h As Integer, _
                 ByVal SlideNumber As Integer)
    
    Dim currentSlide As PowerPoint.Slide
    EOL = Chr(CR) + Chr(LF) ' vbCrLf
    
    If (ActivePresentation.Slides.Count < SlideNumber) Then
        MsgBox ("Slide number does not exist. Action ignored!" _
                + EOL + "Text: " + Text + EOL + "Slide: " + CStr(SlideNumber))
    Else
        Set currentSlide = ActivePresentation.Slides(SlideNumber)
        currentSlide.Shapes.addTextBox(Orientation:=msoTextOrientationHorizontal, _
            Left:=x, Top:=y, Width:=w, Height:=h).TextFrame _
            .TextRange.Text = Text
    End If
    
End Function

'TEXTO
Function prepare(ByVal path As String) As Boolean

    Dim lines() As String
    Dim entry() As String
    Dim i As Integer
    Dim temp
    
    If (status = False) Then
        status = True
        ' Havendo erro de tipo ou quantidade de dados.
        ' Chamar -> Attention
        lines = load(path)
        ' Inserir textos
        For i = 0 To UBound(lines)
            If (lines(i) <> "") Then
                entry() = Split(lines(i), DELIM)
                temp = addText(entry(0), CInt(entry(1)), CInt(entry(2)), _
                       CInt(entry(3)), CInt(entry(4)), CInt(entry(5)))
                Debug.Print "Prepare: "; lines(i); " ..."
            End If
        Next i
    Else
        MsgBox ("Preparation already done.")
    End If

    prepare = status ' Retornar estado
    
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
    
    Debug.Print "Path: "; path
    Debug.Print "Data:"; UBound(lines); "items"
    
    load = lines    ' Retornar array

End Function

'*********************
'***** PRINCIPAL *****
'*********************

Sub createSlides()

    On Error GoTo Attention
    
    Dim status As Boolean

    status = prepare(ActivePresentation.path + "\" + CSVPATH)
    If (status = False) Then
        Debug.Print "Nothing to do."
    End If
    
    Exit Sub

Attention:
    ' Caso ocorra algo errado na macro.
    MsgBox ("Sorry, there was something wrong.")

End Sub

Sub restart()
    status = False
    MsgBox ("Check TextBox Overlay!")
    createSlides
End Sub
