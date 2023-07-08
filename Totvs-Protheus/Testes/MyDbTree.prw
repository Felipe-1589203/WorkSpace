#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TOTVS.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'TBICONN.CH'

User Function MydbTree()

	Local oDlg     := Nil
	Local oDlgTree := Nil
	Local oTree    := Nil
	Local oFont    := Nil
	Local nTop     := oMainWnd:nTop+23
	Local nLeft    := oMainWnd:nLeft+5
	Local nBottom  := oMainWnd:nBottom-60
	Local nRight   := oMainWnd:nRitht-10
	Local nOpc     := 0
	Local nCliente := Criavar("A1_COD")
	Local cLoja    := CriaVar("A1_LOJA")
	Local cSocial  := Space(30)
	Local aObs     := Array(6)
	Local nAux     := 0

	Private aHeaderSD2 := {}
	Private aColsSD2   := {}
	Private aHeadeSC6  := {}
	Private aColsSC6   := {}

	Private aRotina    := {{,,0,1},{,,0,2},{,,0,3},{,,0,4},{,,0,5}}

	INCLUI := .F.
	ALTERA := .F.

    DbSelectArea("SX3")
    DbSetOrder(1)
    MsSeek("SC6")

    While !EOF() .AND. (X3_ARQUIVO=="SC6")
        If X3USO(X3_USADO) .AND. cNivel >= X3_NIVEL
            AADD(aHeaderSC6,{TRIM(X3Titulo()),X3_CAMPO,X3_PICTURE,X3_TAMANHO,X3_DECIMAL,X3_VALID,X3_USADO,X3_TIPO,X3_ARQUIVO,X3_CONTEXT})
        EndIf
        DbSkip()
    EndDo    
    AADD(aColsSC6,Array(Len(aHeader)+1))
    
    MsSeek("SD2")
    While !EOF() .AND. (X3_ARQUIVO=="SD2")
        If X3USO(X3_USADO) .AND. cNivel >= X3_NIVEL
            AADD(aHeaderSD2,{TRIM(X3Titulo()),X3_CAMPO,X3_PICTURE,X3_TAMANHO,X3_DECIMAL,X3_VALID,X3_USADO,X3_TIPO,X3_ARQUIVO,X3_CONTEXT})
        EndIf
        DbSkip()
    EndDo         
    AADD(aColsSD2,Array(Len(aHeaderSD2)+1))

    For nAux := 1 to Len(aHeaderSC6)
        aColsSC6[1][nAux] := CriaVar(aHeaderSC6[nAux][2])
        aColsSC6[1][Len(aHeaderSC6)+1] := .F.
    Next

    For nAux := 1 TO Len(aHeaderSD2)    
        aColsSD2[1][nAux] := CriaVar(aHeaderSD2[nAux][2])
        aColsSD2[2][Len(aHeaderSD2)+1] := .F.
    Next

    DEFINE MsDialog oDlg TITLE "MyDbTree" OF oMainWnd PIXEL FROM 000,000 TO 100,400 

    @ 020,005 SAY "CLIENTE:" SIZE 100,007 OF oDlg PIXEL 
    @ 020,057 SAY "LOJA:"    SIZE 050,007 OF oDlg PIXEL
    @ 020,077 SAY "R.SOCIAL:" SIZE 100,007 OF oDlg PIXEL
    @ 030,005 MsGet cCliente PICTURE "@!" F3 "SA1" VALID CheckCli(cCliente,,@cSocial) SIZE 050,010 OF oDlg PIXEL 
    @ 030,057 MsGet cLoja    PICTURE "@!" VALID CheckCli(cCliente,,@cSocial) SIZE 020,010 OF oDlg PIXEL      
    @ 030,077 MsGet cSocial  PICTURE "@!" WHEN .F. SIZE 100,010 OF oDlg PIXEL 

    ACTIVATE MsDialog oDlg ON INIT EnchoiceBar(oDlg,{||nOpc := 1,oDlg:END()},{nOpc == 0,oDlg:END()}) CENTERED        

    SA1->(DbSetOrder(1))
    If !SA1 ->(MsSeek(Xfilia("SA1")+cCliente+ cLoja))
        nOpc := 0
    EndIf

    If nOpc == 1 
        DEFINE FONT oFont Name "Arial" SIZE 0,-10
        DEFINE MsDialog oDlgTree TITLE "MyDbTree" OF oMainWnd PIXEL FROM nTop,nLeft TO nBottom,nRight
        oPanel := Tpanel():New(15,160,"",oDlgTree,oDlgTree:oFont,.T.,.T.,,(nRight-nLeft)/2-160,((nBottom,nTop)/2)-25,.T.,.T.) 
        oTree  := DbTree():New(15,2,((nBottom-nTop)/2)-5,159,oDlgTree,,,.T.)
        oTree:LShowHint := .F.
        oTree:bChange := {||ShowScreen(oTree,aObjs,@oPanel,{0,0,((nBottom-nTop)/2)-24,(nRight-nLeft)/2-60})}
    EndIf

Return
