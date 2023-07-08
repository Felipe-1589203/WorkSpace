#Include "Protheus.ch"

/*/{Protheus.doc} UserForm
Funcao User Formulas, para executar formulas
@obs Assim como o formulas foi bloqueado no Protheus 12, cuidado ao deixar exposto no menu o User Formulas
/*/
User Function UserForm()

    Local aArea := GetArea()

    //Variaveis da tela
    Private oDlgForm
    Private oGrpForm
    Private oGetForm
    Private cGetForm := Space(250)
    Private oGrpAco
    Private oBtnExec

    //Tamanho da Janela
    Private nJanLarg := 500
    Private nJanAltu := 120
    Private nJanMeio := ((nJanLarg)/2)/2
    Private nTamBtn  := 048
	
    //RpcSetType(3)
	//RpcSetEnv('01','01',,,'COM')

    //Criando a janela
    DEFINE MSDIALOG oDlgForm TITLE "UserFormulas - Execucao de Formulas" FROM 000, 000  TO nJanAltu, nJanLarg COLORS 0, 16777215 PIXEL
        //Grupo Formula com o Get
        @ 003, 003  GROUP oGrpForm TO 30, (nJanLarg/2)-1        PROMPT "Formula: " OF oDlgForm COLOR 0, 16777215 PIXEL
            @ 010, 006  MSGET oGetForm VAR cGetForm SIZE (nJanLarg/2)-9, 013 OF oDlgForm COLORS 0, 16777215 PIXEL
         
        //Grupo Acoes com o Botao
        @ (nJanAltu/2)-30, 003 GROUP oGrpAco TO (nJanAltu/2)-3, (nJanLarg/2)-1 PROMPT "Acoes: " OF oDlgForm COLOR 0, 16777215 PIXEL
            @ (nJanAltu/2)-24, nJanMeio - (nTamBtn/2) BUTTON oBtnExec PROMPT "Executar" SIZE nTamBtn, 018 OF oDlgForm ACTION(FWMsgRun( ,{|| fExecuta()  },"Executando Formula","Executando Formula...")) PIXEL
         
    //Ativando a janela
    ACTIVATE MSDIALOG oDlgForm CENTERED
    
    //RpcClearEnv()

    RestArea(aArea)

Return
 

Static Function fExecuta()

    Local aArea    := GetArea()
    Local cFormula := Alltrim(cGetForm)
    Local cError   := ""
    Local bError   := ErrorBlock({ |oError| cError := oError:Description})
     
    //Se tiver conteudo digitado
    If ! Empty(cFormula)
        //Inicio a utilizacao da tentativa
        Begin Sequence
            &(cFormula)
        End Sequence
         
        //Restaurando bloco de erro do sistema
        ErrorBlock(bError)
         
        //Se houve erro, sera mostrado ao usuario
        If ! Empty(cError)
            MsgStop("Houve um erro na formula digitada: "+CRLF+CRLF+cError, "Atencao")
        EndIf
    EndIf
     
    RestArea(aArea)

Return
