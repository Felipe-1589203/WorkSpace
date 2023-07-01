#INCLUDE 'Protheus.ch'
#INCLUDE 'Rwmake.ch'

User Function tela01()
    Local cAlias := "SZ1"
    Local cTitulo := "Cadastro de lingeries Bianca"
    Local cVldExc := ".T."
    Local cVldAlt := "u_VldAlt()"

    dbSelectArea(cAlias)
    dbSetOrder(1)
    AxCadastro(cAlias,cTitulo,cVldExc,cVldAlt)
Return Nil

User Function VldAlt(cAlias,nReg,nOpc)
    Local lRet := .T.
    Local aArea := GetArea()
    Local nOpcao := 0

    If RetCodUsr() # "000000" .OR. INCLUI
       nOpcao := AxAltera(cAlias,nReg,nOpc)
    Else
        MsgStop("Usuario não autorizado.","Atenção!!!")
        lRet := .F.   
    EndIf

    If nOpcao == 1
        MsgInfo("Alteracao Concluida com sucesso")
    EndIf

    RestArea(aArea)
Return lRet


User Function VldExc(cAlias,nReg,nOpc)
    Local lRet := .T.
    Local aArea := GetArea()
    Local nOpcao := 0

    nOpcao := AxExclui(cAlias,nReg,nOpc)

    If nOpcao == 1
        MsgInfo("Exclusao concluida com sucesso")       
    EndIf
    
    RestArea(aArea)

Return lRet

