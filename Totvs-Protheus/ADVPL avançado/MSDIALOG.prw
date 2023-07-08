#INCLUDE 'Rwmake.ch'
#INCLUDE 'Protheus.ch'

User Function iVisual()   
    Local cTitulo :=  "Aula MSDIALOG"
    Local cTexto  := "CNPJ"
    Local cCgc    := Space(14)
    Local nOpca   := 0
    Private oDlg

        DEFINE MSDIALOG oDlg TITLE cTitulo FROM 000,000 TO 080,300 PIXEL
        @ 001,001 TO 040, 150 OF oDlg PIXEL 
        @ 010,010 SAY cTexto SIZE 55, 07 OF oDlg PIXEL
        @ 010,050 MSGET cCgc SIZE 55, 11 OF oDlg PIXEL PICTURE "@R 99.999.999/9999-99" VALID ACGC(@cCgc)
        DEFINE SBUTTON FROM 010, 120 TYPE 1 ACTION (nOpca := 1,oDlg:END()) ENABLE OF oDlg
        DEFINE SBUTTON FROM 020, 120 TYPE 2 ACTION (nOpca := 2,oDlg:END()) ENABLE OF oDlg 
        ACTIVATE MSDIALOG oDlg CENTERED 

        If  nOpca == 2
            RETURN
        EndIf
            MsgInfo("O CNPJ digitado foi :"+cCgc)
Return            


Static Function ACGC(cCgc)

    If cCgc # "11111111111111"
        MsgInfo("Erro CGC","Atencao !!!")    
        cCgc := "11111111111111"
        oDlg:Refresh()
    EndIf    
Return            
