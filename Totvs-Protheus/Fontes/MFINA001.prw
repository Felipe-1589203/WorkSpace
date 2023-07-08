#INCLUDE "Protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE "Rwmake.ch"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                                   MUL - T - LOCK                                      บฑฑ
ฑฑฬออออออออออออัอออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบPrograma    ณ MFINA001  ณ Simulador de Factory                                         บฑฑ
ฑฑฬออออออออออออุอออออออออออฯอออออออออออออออออออออออออออออออออออออออออออัออออออัอออออออออออนฑฑ
ฑฑบAutor       ณ Actual Trend                                          ณ Data ณ  16/11/09 บฑฑ
ฑฑศออออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออฯอออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

User Function MFINA001()

Local cPerg := "MFINA001"

A001PERG(cPerg)
If (lPerg := Pergunte(cPerg)) == .T.
	Processa({|| U_A001GERA() },"Simulador de Factory")
EndIf

Return()

User Function A001GERA()

Local aComboBco     := A010BANC()
Local nHRes	        := oMainWnd:nClientWidth
Local cThema        := IIf( (Alltrim(GetTheme()) == "TEMAP11") .Or. SetMdiChild(), "TEMAP11", "")
Local aCpoSE1       := { 'TMP_OK','LEGEND','E1_XTPPAG','E1_PREFIXO','E1_NUM','E1_PARCELA','E1_TIPO','E1_EMISSAO','E1_VENCTO','E1_VENCREA','DIAS','E1_VALOR','E1_SALDO','E1_NATUREZ','E1_CLIENTE','E1_LOJA','E1_NOMCLI','E1_DATABOR','E1_NUMBOR','E1_PORTADO','E1_AGEDEP','E1_CONTA','E1_NUMBCO','E1_XADITIV','E1_HIST','E1_NUMNOTA','E1_SERIE','E1_SITUACA'}
Local aAlter       	:= { '' }
Local nFreeze      	:=  000
Local nSuperior    	:=  C(085)
Local nEsquerda    	:=  C(002)
Local nInferior    	:=  IIf( nHRes < 1000 .and. !Empty(cThema),C(178),C(196))
Local nDireita     	:=  C(383)
Local nOpc         	:= 0
Local cIniCpos     	:= ""
Local cSuperApagar 	:= ""
Local cLinhaOk     	:= "AllwaysTrue"
Local cTudoOk      	:= "AllwaysTrue"
Local cCampoOk     	:= "AllwaysTrue"
Local cApagaOk     	:= "AllwaysTrue"
Local aHead        	:= A010HEAD( aCpoSE1 )
Local __Pesq        := ""
Local aRet          := {}
Local aCol         	:= {}
Local aButtons      := {}
Local nMax         	:= Len( acol )
Local nOpca         := 0

Private aSize       := MsAdvSize( .F. )
Private cThema      := IIf( (Alltrim(GetTheme()) == "TEMAP11") .Or. SetMdiChild(), "TEMAP11", "")
Private nHRes	    := oMainWnd:nClientWidth
Private cComboBco   := ""
Private cMark       := LoadBitMap( GetResources(), "LBOK" )
Private cNoMark     := LoadBitMap( GetResources(), "LBNO" )
Private nFloat      := 0
Private nPerDesag   := 0, nPerComis:= 0, nPerLoren:= 0, nPerIOF  := 0, nPerCmIOF:= 0, nPerISS  := 0
Private nValDupli   := 0, nValChequ:= 0, nValTAC  := 0, nValTED  := 0, nValDOC  := 0
Private nTarAutom   := 0, nVlrAutom:= 0, nTarCorpo:= 0, nVlrCorpo:= 0, nTarVarej:= 0, nVlrVarej:= 0, nTarMultl := 0, nVlrMultl := 0, nTarAssis := 0, nVlrAssis :=0, nTarIndus:= 0, nVlrIndus :=0
Private nTotDesag   := 0, nTotComis:= 0, nTotLoren:= 0, nTotIOF  := 0, nTotCmIOF:= 0, nTotISS  := 0
Private nTotDupli   := 0, nTotChequ:= 0, nTotTAC  := 0, nTotTED  := 0, nTotDOC  := 0
Private nTotTar     := 0, nTotBru  := 0, nTotLiq  := 0

Private _oDlg, oSE1Get
Private oFloat, oTotDesag, oTotComis,oTotLoren, oTotIOF, oTotCmIOF, oTotISS, oTotDupli, oTotChequ, oTotTAC, oTotTED, oTotDOC
Private oTarAutom, oTarCorpo, oTarVarej, oTarMultl, oTarAssis, oTarIndus
Private oVlrAutom, oVlrCorpo, oVlrvarej, oVlrMultl, oVlrAssis, oVlrIndus
Private oTotTar, oTotBru, oTotLiq

If nHRes < 1000
	If !Empty(cThema)
		aSize[6] += 65
		aSize[5] += 10
	EndIf
ElseIf nHRes > 1000 .And. nHRes < 1025
	If !Empty(cThema)
		aSize[6] += 65
		aSize[5] += 05
	Else
		aSize[6] -= 33
		aSize[5] -= 10
	EndIf
ElseIf nHRes > 1025 .And. nHRes < 1281
	If !Empty(cThema)
		aSize[6] += 30
		aSize[5] -= 150
	Else
		aSize[6] -= 70
		aSize[5] -= 260
	EndIf 
ElseIf nHRes > 1281
	If !Empty(cThema)
		aSize[6] += 30
		aSize[5] -= 250
	Else
		aSize[6] -= 70
		aSize[5] -= 260
	EndIf
EndIf

aAdd(aRet,1)
xOpcao := 1
aCol   := A010COLS( aCpoSE1, 1, NIL, NIL, NIL, __Pesq, aRet, xOpcao )

aAdd( aButtons, { "RELATORIO", { || U_MFINR004() }, "Espelho Simulador", "Espelho" } )

Define FONT oFont2 NAME "Arial"            SIZE 0,-12 BOLD
Define FONT oFont4 NAME "Courier New"      SIZE 0,14
If nHRes > 1000
	Define FONT oFont1 NAME "Arial"        SIZE 0,-10
	Define FONT oFont3 NAME "Arial"        SIZE 0,-09
	Define FONT oFont5 NAME "Arial"        SIZE 0,-12
Else
	Define FONT oFont1 NAME "Arial"        SIZE 0,-09
	Define FONT oFont3 NAME "Arial"        SIZE 0,-08
	Define FONT oFont5 NAME "Arial"        SIZE 0,-10
EndIf

Define MsDialog _oDlg Title " Simulador  de Factoring " From aSize[1],aSize[2] TO aSize[6]-96,aSize[5]-12 FONT oFont1 Pixel
If !Empty(Mv_par01)
	@ C(aSize[1]+015),C(aSize[2]+005) Say "Border๔ : "+Mv_par01                               FONT oFont5 Size 050,008 Color CLR_BLUE  Pixel Of _oDlg
EndIf
@ C(aSize[1]+025),C(aSize[2]+005) Say "Factory"                                               FONT oFont5 Size 050,008 Color CLR_BLACK Pixel Of _oDlg
@ C(aSize[1]+023),C(aSize[2]+025) ComboBox oCombo Var cComboBco Items aComboBco FONT oFont4 On Change ( A010TARI(oCombo,aComboBco,.F.), _oDlg:Refresh(), MsgRun('Recalculando...', 'Aguarde', { || A010SOMA(oSE1Get,.F.) } ) ) Size C(180),C(010) Pixel Of _oDlg

@ C(aSize[1]+013),C(aSize[2]+208) To C(aSize[1]+038),C(aSize[2]+394)  Label "  T O T A I S " Color CLR_HRED  Pixel Of _oDlg
@ C(aSize[1]+025),C(aSize[2]+210) Say "Tarifas"                                               FONT oFont5 Size C(0500),C(008) Color CLR_BLACK Pixel Of _oDlg
@ C(aSize[1]+023),C(aSize[2]+227) MsGet    oTotTar   Var nTotTar   Picture "@E 99,999,999.99" When .F.    Size C(035),C(004) Color CLR_BLACK Pixel Of _oDlg
@ C(aSize[1]+025),C(aSize[2]+268) Say "Vl Bruto"                                              FONT oFont5 Size C(050),C(008) Color CLR_BLACK Pixel Of _oDlg
@ C(aSize[1]+023),C(aSize[2]+290) MsGet    oTotBru   Var nTotBru   Picture "@E 99,999,999.99" When .F.    Size C(036),C(004) Color CLR_BLACK Pixel Of _oDlg
@ C(aSize[1]+025),C(aSize[2]+332) Say "Vl Liquido"                                            FONT oFont5 Size C(050),C(008) Color CLR_BLACK Pixel Of _oDlg
@ C(aSize[1]+023),C(aSize[2]+358) MsGet    oTotLiq   Var nTotLiq   Picture "@E 99,999,999.99" When .F.    Size C(034),C(004) Color CLR_BLACK Pixel Of _oDlg

oPanel1:= TPanel():New(C(aSize[1]+40), C(aSize[2]+02), "", _oDlg, NIL, .T., .F., NIL, NIL, C(aSize[1]+392),C(aSize[2]+42), .T., .F. )

@ C(aSize[1]+002),C(aSize[2]+002) To C(aSize[1]+041),C(aSize[2]+100)  Label "" Pixel Of oPanel1
@ C(aSize[1]+002),C(aSize[2]+100) To C(aSize[1]+041),C(aSize[2]+198)  Label "" Pixel Of oPanel1
@ C(aSize[1]+002),C(aSize[2]+198) To C(aSize[1]+041),C(aSize[2]+295)  Label "" Pixel Of oPanel1
@ C(aSize[1]+002),C(aSize[2]+295) To C(aSize[1]+041),C(aSize[2]+392)  Label "" Pixel Of oPanel1

@ C(aSize[1]+005),C(aSize[2]+004) Say "Float"                                                                                                                             Size C(040),C(008) Color CLR_BLACK Pixel Of oPanel1
@ C(aSize[1]+003),C(aSize[2]+031) MsGet    oFloat    Var nFloat    Picture "@E 999"           On Change( MsgRun('Recalculando...', 'Aguarde', { || A010SOMA(oSE1Get,.T.) }))  Size C(018),C(001) Color CLR_BLACK Pixel Of oPanel1

@ C(aSize[1]+005),C(aSize[2]+103) Say "Taxa Juros"                                            FONT oFont3                                                                  Size C(040),C(008) Color CLR_BLACK Pixel Of oPanel1
@ C(aSize[1]+003),C(aSize[2]+124) MsGet oPerDesag Var nPerDesag    Picture "@E 999.9999"      On Change( nPerComis := IIf(nPerDesag==0,SA6->A6_XPCCOMI, 0), MsgRun('Recalculando...', 'Aguarde', { || A010SOMA(oSE1Get,.F.) }))  Size C(036),C(006) Color CLR_BLACK Pixel Of oPanel1
@ C(aSize[1]+003),C(aSize[2]+164) MsGet oTotDesag Var nTotDesag    Picture "@E 99,999,999.99" WHEN .F.                                                                     Size C(032),C(006) Color CLR_BLACK Pixel Of oPanel1

@ C(aSize[1]+005),C(aSize[2]+200) Say "Comissaria"                                            FONT oFont3                                                                  Size C(040),C(008) Color CLR_BLACK Pixel Of oPanel1
@ C(aSize[1]+003),C(aSize[2]+221) MsGet oPerComis Var nPerComis    Picture "@E 999.9999"      On Change( MsgRun('Recalculando...', 'Aguarde', { || A010SOMA(oSE1Get,.F.) }))  Size C(036),C(006) Color CLR_BLACK Pixel Of oPanel1
@ C(aSize[1]+003),C(aSize[2]+260) MsGet oTotComis Var nTotComis    Picture "@E 99,999,999.99" WHEN .F.                                                                     Size C(032),C(006) Color CLR_BLACK Pixel Of oPanel1

@ C(aSize[1]+005),C(aSize[2]+298) Say "AdValoren"                                             FONT oFont3                                                                  Size C(040),C(008) Color CLR_BLACK Pixel Of oPanel1
@ C(aSize[1]+003),C(aSize[2]+319) MsGet oPerLoren Var nPerLoren    Picture "@E 999.9999"      On Change( MsgRun('Recalculando...', 'Aguarde', { || A010SOMA(oSE1Get,.F.) }))  Size C(036),C(006) Color CLR_BLACK Pixel Of oPanel1
@ C(aSize[1]+003),C(aSize[2]+358) MsGet oTotLoren Var nTotLoren    Picture "@E 99,999,999.99" WHEN .F.                                                                     Size C(032),C(006) Color CLR_BLACK Pixel Of oPanel1


@ C(aSize[1]+018),C(aSize[2]+004) Say "IOF"                                                   FONT oFont3                                                                  Size C(040),C(008) Color CLR_BLACK Pixel Of oPanel1
@ C(aSize[1]+016),C(aSize[2]+031) MsGet oPerIOF   Var nPerIOF      Picture "@E 999.9999"      On Change( MsgRun('Recalculando...', 'Aguarde', { || A010SOMA(oSE1Get,.F.) }))  Size C(036),C(006) Color CLR_BLACK Pixel Of oPanel1
@ C(aSize[1]+016),C(aSize[2]+068) MsGet oTotIOF   Var nTotIOF      Picture "@E 99,999,999.99" WHEN .F.                                                                     Size C(032),C(006) Color CLR_BLACK Pixel Of oPanel1

@ C(aSize[1]+018),C(aSize[2]+103) Say "Compl.IOF"                                             FONT oFont3                                                                  Size C(040),C(008) Color CLR_BLACK Pixel Of oPanel1
@ C(aSize[1]+016),C(aSize[2]+124) MsGet oPerCmIOF Var nPerCmIOF    Picture "@E 999.9999"      On Change( MsgRun('Recalculando...', 'Aguarde', { || A010SOMA(oSE1Get,.F.) }))  Size C(036),C(006) Color CLR_BLACK Pixel Of oPanel1
@ C(aSize[1]+016),C(aSize[2]+164) MsGet oTotCmIOF Var nTotCmIOF    Picture "@E 99,999,999.99" WHEN .F.                                                                     Size C(032),C(006) Color CLR_BLACK Pixel Of oPanel1

@ C(aSize[1]+018),C(aSize[2]+200) Say "ISS"                                                   FONT oFont3                                                                  Size C(040),C(008) Color CLR_BLACK Pixel Of oPanel1
@ C(aSize[1]+016),C(aSize[2]+221) MsGet oPerISS   Var nPerISS      Picture "@E 999.9999"      On Change( MsgRun('Recalculando...', 'Aguarde', { || A010SOMA(oSE1Get,.F.) }))  Size C(036),C(006) Color CLR_BLACK Pixel Of oPanel1
@ C(aSize[1]+016),C(aSize[2]+260) MsGet oTotISS   Var nTotISS      Picture "@E 99,999,999.99" WHEN .F.                                                                     Size C(032),C(006) Color CLR_BLACK Pixel Of oPanel1

@ C(aSize[1]+018),C(aSize[2]+298) Say "Tarifa Titulo"                                         FONT oFont3                                                                  Size C(040),C(008) Color CLR_BLACK Pixel Of oPanel1
@ C(aSize[1]+016),C(aSize[2]+319) MsGet oValDupli Var nValDupli    Picture "@E 99,999,999.99" On Change( MsgRun('Recalculando...', 'Aguarde', { || A010SOMA(oSE1Get,.F.) }))  Size C(036),C(006) Color CLR_BLACK Pixel Of oPanel1
@ C(aSize[1]+016),C(aSize[2]+358) MsGet oTotDupli Var nTotDupli    Picture "@E 99,999,999.99" WHEN .F.                                                                     Size C(032),C(006) Color CLR_BLACK Pixel Of oPanel1


@ C(aSize[1]+032),C(aSize[2]+004) Say "Tarifa Cheque"                                         FONT oFont3                                                                  Size C(040),C(008) Color CLR_BLACK Pixel Of oPanel1
@ C(aSize[1]+030),C(aSize[2]+031) MsGet oValChequ Var nValChequ    Picture "@E 99,999,999.99" On Change( MsgRun('Recalculando...', 'Aguarde', { || A010SOMA(oSE1Get,.F.) }))  Size C(036),C(006) Color CLR_BLACK Pixel Of oPanel1
@ C(aSize[1]+030),C(aSize[2]+068) MsGet oTotChequ Var nTotChequ    Picture "@E 99,999,999.99" WHEN .F.                                                                     Size C(032),C(006) Color CLR_BLACK Pixel Of oPanel1

@ C(aSize[1]+032),C(aSize[2]+103) Say "Tarifa TAC"                                            FONT oFont3                                                                  Size C(040),C(008) Color CLR_BLACK Pixel Of oPanel1
@ C(aSize[1]+030),C(aSize[2]+124) MsGet oValTAC   Var nValTAC      Picture "@E 99,999,999.99" On Change( MsgRun('Recalculando...', 'Aguarde', { || nTotTED := Iif(nValTAC <> 0, 0, nTotTED),A010SOMA(oSE1Get,.F.) }))  Size C(036),C(006) Color CLR_BLACK Pixel Of oPanel1
@ C(aSize[1]+030),C(aSize[2]+164) MsGet oTotTAC   Var nTotTAC      Picture "@E 99,999,999.99" WHEN .F.                                                                     Size C(032),C(006) Color CLR_BLACK Pixel Of oPanel1

@ C(aSize[1]+032),C(aSize[2]+200) Say "Tarifa TED"                                            FONT oFont3                                                                  Size C(040),C(008) Color CLR_BLACK Pixel Of oPanel1
@ C(aSize[1]+030),C(aSize[2]+221) MsGet oValTED   Var nValTED      Picture "@E 99,999,999.99" On Change( nValDOC := IIf(nValTED==0,SA6->A6_XVLDOC, 0), MsgRun('Recalculando...', 'Aguarde', { || A010SOMA(oSE1Get,.F.) }))  Size C(036),C(006) Color CLR_BLACK Pixel Of oPanel1
@ C(aSize[1]+030),C(aSize[2]+260) MsGet oTotTED   Var nTotTED      Picture "@E 99,999,999.99" WHEN .F.                                                                     Size C(032),C(006) Color CLR_BLACK Pixel Of oPanel1

@ C(aSize[1]+032),C(aSize[2]+298) Say "Tarifa DOC"                                            FONT oFont3                                                                  Size C(040),C(008) Color CLR_BLACK Pixel Of oPanel1
@ C(aSize[1]+030),C(aSize[2]+319) MsGet oValDOC   Var nValDOC      Picture "@E 99,999,999.99" On Change( MsgRun('Recalculando...', 'Aguarde', { || A010SOMA(oSE1Get,.F.) }))  Size C(036),C(006) Color CLR_BLACK Pixel Of oPanel1
@ C(aSize[1]+030),C(aSize[2]+358) MsGet oTotDOC   Var nTotDOC      Picture "@E 99,999,999.99" WHEN .F.                                                                     Size C(032),C(006) Color CLR_BLACK Pixel Of oPanel1

oSE1Get := MsNewGetDados():New( nSuperior, nEsquerda, nInferior, nDireita, nOpc, cLinhaOk, cTudoOk, cIniCpos, aAlter, nFreeze, nMax, cCampoOk, cSuperApagar, cApagaOk, _oDlg, aHead, aCol )
oSE1Get:oBrowse:blDblClick := { || A010CLIC( oSE1Get ) }

oPanel2:= TPanel():New(C(aSize[1]+IIf( nHRes < 1000 .And. !Empty(cThema),180,200)), C(aSize[2]+02), "", _oDlg, NIL, .T., .F., NIL, NIL, C(aSize[1]+392),C(aSize[2]+28), .T., .F. )

@ C(aSize[1]+002),C(aSize[2]+002) To @ C(aSize[1]+028),C(aSize[2]+066) Label "" Pixel Of oPanel2
@ C(aSize[1]+002),C(aSize[2]+066) To @ C(aSize[1]+028),C(aSize[2]+131) Label "" Pixel Of oPanel2
@ C(aSize[1]+002),C(aSize[2]+131) To @ C(aSize[1]+028),C(aSize[2]+196) Label "" Pixel Of oPanel2
@ C(aSize[1]+002),C(aSize[2]+196) To @ C(aSize[1]+028),C(aSize[2]+261) Label "" Pixel Of oPanel2
@ C(aSize[1]+002),C(aSize[2]+261) To @ C(aSize[1]+028),C(aSize[2]+326) Label "" Pixel Of oPanel2
@ C(aSize[1]+002),C(aSize[2]+326) To @ C(aSize[1]+028),C(aSize[2]+390) Label "" Pixel Of oPanel2

@ C(aSize[1]+003),C(aSize[2]+016) Say "Automotivo"                                           FONT oFont2 Size C(140),C(014) Color CLR_HBLUE Pixel Of oPanel2
@ C(aSize[1]+003),C(aSize[2]+082) Say "Corporativo"                                          FONT oFont2 Size C(140),C(014) Color CLR_HBLUE Pixel Of oPanel2
@ C(aSize[1]+003),C(aSize[2]+152) Say "Varejo"                                               FONT oFont2 Size C(140),C(014) Color CLR_HBLUE Pixel Of oPanel2
@ C(aSize[1]+003),C(aSize[2]+203) Say "Mul-T-Lock Center"                                    FONT oFont2 Size C(140),C(014) Color CLR_HBLUE Pixel Of oPanel2
@ C(aSize[1]+003),C(aSize[2]+266) Say "Assit๊ncia T้cnica"                                   FONT oFont2 Size C(140),C(014) Color CLR_HBLUE Pixel Of oPanel2
@ C(aSize[1]+003),C(aSize[2]+343) Say "Industrial"                                           FONT oFont2 Size C(140),C(014) Color CLR_HBLUE Pixel Of oPanel2

@ C(aSize[1]+016),C(aSize[2]+003) MsGet    oTarAutom Var nTarAutom Picture "@E 9,999,999.99"  When .F.  Size C(030),C(004) Color CLR_BLACK Pixel Of oPanel2
@ C(aSize[1]+016),C(aSize[2]+035) MsGet    oVlrAutom Var nVlrAutom Picture "@E 9,999,999.99"  When .F.  Size C(030),C(004) Color CLR_BLACK Pixel Of oPanel2

@ C(aSize[1]+016),C(aSize[2]+068) MsGet    oTarCorpo Var nTarCorpo Picture "@E 9,999,999.99"  When .F.  Size C(030),C(004) Color CLR_BLACK Pixel Of oPanel2
@ C(aSize[1]+016),C(aSize[2]+100) MsGet    oVlrCorpo Var nVlrCorpo Picture "@E 9,999,999.99"  When .F.  Size C(030),C(004) Color CLR_BLACK Pixel Of oPanel2

@ C(aSize[1]+016),C(aSize[2]+133) MsGet    oTarVarej Var nTarVarej Picture "@E 9,999,999.99"  When .F.  Size C(030),C(004) Color CLR_BLACK Pixel Of oPanel2
@ C(aSize[1]+016),C(aSize[2]+165) MsGet    oVlrVarej Var nVlrVarej Picture "@E 9,999,999.99"  When .F.  Size C(030),C(004) Color CLR_BLACK Pixel Of oPanel2

@ C(aSize[1]+016),C(aSize[2]+198) MsGet    oTarMultl Var nTarMultl Picture "@E 9,999,999.99"  When .F.  Size C(030),C(004) Color CLR_BLACK Pixel Of oPanel2
@ C(aSize[1]+016),C(aSize[2]+230) MsGet    oVlrMultl Var nVlrMultl Picture "@E 9,999,999.99"  When .F.  Size C(030),C(004) Color CLR_BLACK Pixel Of oPanel2

@ C(aSize[1]+016),C(aSize[2]+263) MsGet    oTarAssis Var nTarAssis Picture "@E 9,999,999.99"  When .F.  Size C(030),C(004) Color CLR_BLACK Pixel Of oPanel2
@ C(aSize[1]+016),C(aSize[2]+295) MsGet    oVlrAssis Var nVlrAssis Picture "@E 9,999,999.99"  When .F.  Size C(030),C(004) Color CLR_BLACK Pixel Of oPanel2

@ C(aSize[1]+016),C(aSize[2]+328) MsGet    oTarIndus Var nTarIndus Picture "@E 9,999,999.99"  When .F.  Size C(030),C(004) Color CLR_BLACK Pixel Of oPanel2
@ C(aSize[1]+016),C(aSize[2]+360) MsGet    oVlrIndus Var nVlrIndus Picture "@E 9,999,999.99"  When .F.  Size C(030),C(004) Color CLR_BLACK Pixel Of oPanel2

A010TARI(oCombo,aComboBco,IIf(!Empty(Mv_par01),.T.,.F.) )
A010SOMA(oSE1Get,.F.)

Activate MsDialog _oDlg Centered On Init EnchoiceBar(_oDlg, { || nOpca:=1, U_A001GRAVA(), _oDlg:End() }, { || nOpca:=0,_oDlg:End() },, aButtons )
Return()

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                                   MUL - T - LOCK                                      บฑฑ
ฑฑฬออออออออออออัอออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบFuncao      ณ A001GRAVA ณ Gera e grava dados no bordero                                บฑฑ
ฑฑฬออออออออออออุอออออออออออฯอออออออออออออออออออออออออออออออออออออออออออัออออออัอออออออออออนฑฑ
ฑฑบAutor       ณ Actual Trend                                          ณ Data ณ  16/11/09 บฑฑ
ฑฑศออออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออฯอออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

User Function A001GRAVA()

Private LF060LOOP := .T.

If Empty(Mv_par01)
	If MsgYesno("Deseja gerar border๔ ?")
		FinA060(3)
		
		DbSelectArea("SEA")
	EndIf
Else
	MsgInfo("Boder๔ jแ gerado, impossivel gerar novamente")
EndIf

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                                   MUL - T - LOCK                                      บฑฑ
ฑฑฬออออออออออออัอออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบFuncao      ณ A010BANC  ณ Carrega array com bancos com tarifas de Factory              บฑฑ
ฑฑฬออออออออออออุอออออออออออฯอออออออออออออออออออออออออออออออออออออออออออัออออออัอออออออออออนฑฑ
ฑฑบAutor       ณ Actual Trend                                          ณ Data ณ  16/11/09 บฑฑ
ฑฑศออออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออฯอออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

Static Function A010BANC()

Local aBancos   := {}

DbSelectArea("SA6")
SA6->(DbSetOrder(1))
SA6->(DbGoTop())

While SA6->(!Eof())
	If SA6->A6_XFACTOR == "S" .And. SA6->A6_BLOCKED <> "1"
		aadd(aBancos, "Bco: "+SA6->A6_COD+"  Ag: "+SA6->A6_AGENCIA+"  Cta: "+SA6->A6_NUMCON +" "+AllTrim(SA6->A6_NOME))
	EndIf
	SA6->(DbSkip())
End-While

Return(aBancos)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                                   MUL - T - LOCK                                      บฑฑ
ฑฑฬออออออออออออัอออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบFuncao      ณ A010TARI  ณ Carrega tarifas conforme banco selecionado                   บฑฑ
ฑฑฬออออออออออออุอออออออออออฯอออออออออออออออออออออออออออออออออออออออออออัออออออัอออออออออออนฑฑ
ฑฑบAutor       ณ Actual Trend                                          ณ Data ณ  16/11/09 บฑฑ
ฑฑศออออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออฯอออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

Static Function A010TARI(oComboBco,aComboBco,lPrim)

Local cBco   := ""
Local cAgc   := ""
Local cCta   := ""
Local nPosCbo:= oComboBco:nAt
Default lPrim := .T.

If lPrim == .T.
	cBco := oSE1Get:aCols[1,GdFieldPos("E1_PORTADO",oSE1Get:aHeader)]
	cAgc := oSE1Get:aCols[1,GdFieldPos("E1_AGEDEP" ,oSE1Get:aHeader)]
	cCta := oSE1Get:aCols[1,GdFieldPos("E1_CONTA"  ,oSE1Get:aHeader)]
Else
	cBco := Subs(aComboBco[nPosCbo], At("Bco:"  ,aComboBco[nPosCbo])+5 , TAMSX3("E1_PORTADO")[1] )
	cAgc := Subs(aComboBco[nPosCbo], At("Ag:"   ,aComboBco[nPosCbo])+4 , TAMSX3("E1_AGEDEP")[1]  )
	cCta := Subs(aComboBco[nPosCbo], At("Cta:"  ,aComboBco[nPosCbo])+5 , TAMSX3("E1_CONTA")[1]   )
EndIf

For _n1 := 1 to Len(aComboBco)
	If ("Bco: "+cBco+"  Ag: "+cAgc+"  Cta: "+cCta) $ aComboBco[_n1]
		nPosCbo := _n1
		Exit
	EndIf
Next _n1

oComboBco:nAt := Iif(nPosCbo <> 0,nPosCbo , oComboBco:nAt)

DbSelectArea("SA6")
SA6->(DbSetOrder(1))
If SA6->(DbSeek( xFilial("SA6")+ cBco + cAgc + cCta ))
	nFloat   := Val(SA6->A6_XFLOAT)
	
	nPerDesag:= SA6->A6_XPCDESA
	nPerComis:= IIf(SA6->A6_XPCDESA <> 0,0,SA6->A6_XPCCOMI)
	nPerLoren:= SA6->A6_XPCVALO
	nPerIOF  := SA6->A6_XPCIOF
	nPerCmIOF:= SA6->A6_XPCCIOF
	nPerISS  := SA6->A6_XPCISS
	
	nValDupli:= SA6->A6_XVLDUPL
	nValChequ:= SA6->A6_XVLCHEQ
	nValTAC  := SA6->A6_XVLTAC
	nValTED  := SA6->A6_XVLTED
	nValDOC  := IIf(SA6->A6_XVLTED <> 0,0,SA6->A6_XVLDOC)
EndIf

oComboBco:Refresh()
_oDlg:Refresh()
Return()

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                                   MUL - T - LOCK                                      บฑฑ
ฑฑฬออออออออออออัอออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบPrograma    ณ A010HEAD  ณ Carrega Header na rotina de Simulador de Factory             บฑฑ
ฑฑฬออออออออออออุอออออออออออฯอออออออออออออออออออออออออออออออออออออออออออัออออออัอออออออออออนฑฑ
ฑฑบAutor       ณ Actual Trend                                          ณ Data ณ  16/11/09 บฑฑ
ฑฑศออออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออฯอออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

Static Function A010HEAD( aCpoSE1 )

Local nX	   := 0
Local aHead	   := {}
Local aArea	   := GetArea()
Local aSX3Area := SX3->( GetArea() )

DbSelectArea( 'SX3' )
SX3->( dbSetOrder( 2 ) )
For nX := 1 to Len( aCpoSE1 )
	If AllTrim( aCpoSE1[ nX ] ) == 'TMP_OK'
		Aadd( aHead,{ '',	'TMP_OK',	'@BMP', 2, 0, '','','','','','','' } )
		Loop
	EndIf
	
	If AllTrim( aCpoSE1[ nX ] ) == 'LEGEND'
		Aadd( aHead,{ '',	'LEGEND',	'@BMP', 2, 0, '','','','','','','' } )
		Loop
	EndIf
	
	If AllTrim( aCpoSE1[ nX ] ) == 'DIAS'
		Aadd( aHead,{ 'Dias',	'DIAS',	'@E 9999', 4, 0, '','','','','','','' } )
		Loop
	EndIf
	
	If SX3->( MsSeek( aCpoSE1[ nX ] ) )
		Aadd( aHead,{ AllTrim( X3Titulo() ), SX3->X3_CAMPO, SX3->X3_PICTURE, IIf(AllTrim( aCpoSE1[ nX ] ) == 'E1_XTPPAG',30,SX3->X3_TAMANHO), SX3->X3_DECIMAL,SX3->X3_VALID, SX3->X3_USADO, SX3->X3_TIPO, SX3->X3_F3,SX3->X3_CONTEXT, SX3->X3_CBOX, SX3->X3_RELACAO } )
	EndIf
Next nX

RestArea( aSX3Area )
RestArea( aArea )

Return( aHead )

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                                   MUL - T - LOCK                                      บฑฑ
ฑฑฬออออออออออออัอออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบPrograma    ณ A010COLS  ณ Carrega aCols  na rotina de Simulador de Factory             บฑฑ
ฑฑฬออออออออออออุอออออออออออฯอออออออออออออออออออออออออออออออออออออออออออัออออออัอออออออออออนฑฑ
ฑฑบAutor       ณ Actual Trend                                          ณ Data ณ  16/11/09 บฑฑ
ฑฑศออออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออฯอออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

Static Function A010COLS( aCpoSE1, nOpcx, ___Numero, cChavep, oObCols, __lPesq, aRet, xOpcao )

Local nInd
Local aArea		  := GetArea()
Local aCol		  := {}
Local cCampos	  := ""
Local cQuery      := ""
Local cSitCart    := ""
Local nTotReg     := 0
Local nSitCont    := 0

DbSelectArea("SX5")
SX5->(DbSetOrder(1))
If SX5->(DbSeek(xFilial("SX5")+"24"))
	While SX5->(!Eof()) .And. SX5->X5_TABELA == "24"
		cSitCart += CRLF + " (CASE WHEN SE1.E1_XTPPAG = '"+ AllTrim(SX5->X5_CHAVE)+"' THEN '"+ AllTrim(SX5->X5_DESCRI)+"' ELSE "
		nSitCont++
		SX5->(DbSkip())
	End-While
	cSitCart += IIf(Empty(cSitCart), "", "' ' ")
	cSitCart += IIf(Empty(cSitCart), "", Replicate( " END ) ", nSitCont))
	cSitCart += IIf(Empty(cSitCart), "", " AS E1_XTPPAG")
EndIf

AEval( aCpoSE1 , { | x | IIf( !( AllTrim( x ) == 'TMP_OK' ) .And. !( AllTrim( x ) == 'LEGEND' ) , cCampos += ',' + x , Nil ) } )
cCampos := IIf(!Empty(cSitCart), StrTran(cCampos, "E1_XTPPAG",cSitCart), cCampos)
cCampos := StrTran(cCampos, "DIAS",'0 AS DIAS')

cQuery := " SELECT '"+ Space( 2 ) +"' TMP_OK, '"+ Space( 1 ) +"' LEGEND, "+ SubStr( cCampos, 2 )
cQuery += CRLF + "   FROM "+ RetSQLName( 'SE1' ) +" SE1 "
cQuery += CRLF + "  WHERE SE1.D_E_L_E_T_ = ' '"
If !Empty(Mv_par01)
	cQuery += CRLF + "    AND SE1.E1_NUMBOR  = '"+ Mv_par01 +"'"
Else
	cQuery += CRLF + "  AND SE1.E1_NUMBOR  = '"+ CriaVar("E1_NUMBOR",.F.) +"'"
	cQuery += CRLF + "  AND ( SE1.E1_SALDO > 0  OR SE1.E1_OCORREN = '02' ) "
	cQuery += CRLF + "  AND SE1.E1_SITUACA IN ('0','F','G') "
	cQuery += CRLF + "  AND SE1.E1_VENCREA >= '"+Dtos(Date())+"'
EndIf
cQuery += CRLF + "  ORDER BY " + SqlOrder(SE1->(IndexKey()))
                      
MemoWrite("D:\MFINA001.txt",cQuery)

cAliasA	:= GetNextAlias()
cQuery  := ChangeQuery(cQuery)

DbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cAliasA , .F., .T.)
aEval( SE1->(dbStruct()),{|x| If(x[2]!="C", TcSetField(cAliasA,AllTrim(x[1]),x[2],x[3],x[4]),Nil)})

DbSelectArea( cAliasA )
(cAliasA)->(DbGoTop())
(cAliasA)->( dbEval( { || nTotReg++ },,{ || !Eof() } ) )
(cAliasA)->(DbGoTop())

If nTotReg == 0
	aAux := {}
	For nInd := 1 to Len( aCpoSE1 )
		If AllTrim( aCpoSE1[ nInd ] ) == 'TMP_OK'
			Aadd( aAux, cNoMark )
			Loop
		EndIf
		
		If AllTrim( aCpoSE1[ nInd ] ) == 'LEGEND'
			Aadd( aAux, 'BR_VERDE' )
			Loop
		EndIf
		
		If AllTrim( aCpoSE1[ nInd ] ) == 'DIAS'
			Aadd( aAux, 0   )
			Loop
		EndIf
		
		Aadd( aAux, CriaVar( aCpoSE1[ nInd ] , .F. ) )
	Next nInd
	
	Aadd( aAux ,.F. )
	Aadd( aCol , aAux )
Else
	( cAliasA )->( dbGoTop() )
	While ( cAliasA )->( !Eof() )
		
		aAux := {}
		For nInd := 1 To ( cAliasA )->( FCount() )
			If ( cAliasA )->( FieldName( nInd ) ) == 'TMP_OK'
				Aadd( aAux, IIf(!Empty(Mv_par01), cMark, cNoMark) )
				Loop
				
			ElseIf ( cAliasA )->( FieldName( nInd ) ) == 'LEGEND'
				If ROUND( (cAliasA)->E1_SALDO,2 ) = 0
					Aadd( aAux , "BR_VERMELHO")   // "Titulo Baixado"
				ElseIf (cAliasA)->E1_TIPO ==  MVRECANT .And. ROUND( (cAliasA)->E1_SALDO,2 ) > 0
					Aadd( aAux , "BR_BRANCO")     // "Adiantamento com saldo"
				ElseIf !Empty((cAliasA)->E1_NUMBOR)
					Aadd( aAux , "BR_PRETO")  	  // "Titulo em Bordero"
				ElseIf ROUND( (cAliasA)->E1_SALDO,2 ) <> ROUND((cAliasA)->E1_VALOR,2)
					Aadd( aAux ,"BR_AZUL")       // "Baixado parcialmente"
				ElseIf ROUND( (cAliasA)->E1_SALDO,2 ) == ROUND((cAliasA)->E1_VALOR,2) .And. (cAliasA)->E1_SITUACA == "F"
					Aadd( aAux , "BR_AMARELO")   // "Titulo Protestado"
				Else
					Aadd( aAux ,"BR_VERDE" )	 // "Titulo em aberto"
				EndIf
				
				Loop
				
			ElseIf ( cAliasA )->( FieldName( nInd ) ) == 'DIAS'
				nFloatDias := Val(GetAdvFval( "SA6", "A6_XFLOAT", xFilial("SA6") + ( cAliasA )->E1_PORTADO + ( cAliasA )->E1_AGEDEP + ( cAliasA )->E1_CONTA, 1, 0))
				dDataVenct := DataValida( (cAliasA)->E1_VENCREA )
				dDataBorde := IIf (Empty(DataValida( (cAliasA)->E1_DATABOR )), DataValida(Date()), DataValida( (cAliasA)->E1_DATABOR ))
				dFeriaVenc := Ctod("")
				dFeriaBord := Ctod("")
				
				While .T.
					dFeriaVenc := GetAdvFval( "SP3","P3_DATA",xFilial("SP3") + Dtos(dDataVenct) ,1, Ctod(""))
					
					If !Empty(dFeriaVenc)
						dDataVenct += 1
					Else
						Exit
					EndIf
				End-While
				
				While .T.
					dFeriaBord := GetAdvFval( "SP3","P3_DATA",xFilial("SP3") + Dtos(dDataBorde) ,1, Ctod(""))
					
					If !Empty(dFeriaBord)
						dDataBorde += 1
					Else
						Exit
					EndIf
				End-While
				
				dVenc := ( dDataVenct + nFloatDias )
				If Dow(dVenc) == 1 .Or.  Dow(dVenc) == 7
					For _n1 := 1 to 7
						If Dow(dVenc) == 1 .Or.  Dow(dVenc) == 7                                 
							dVenc := (dVenc+1)
						Else
							dVenc := (dVenc +  nFloatDias )
							Exit
						EndIf
					Next                                                                     
				EndIf                                      
				aAux[Len(aAux)] := dVenc
				Aadd( aAux, (dVenc - DataValida(dDataBorde)) )
			Else
				Aadd( aAux, ( cAliasA )->( FieldGet( nInd ) )   )
			EndIf
			
		Next nInd
		
		Aadd( aAux ,	.F. 	)
		Aadd( aCol , 	aAux 	)
		
		( cAliasA )->( dbSkip() )
	EndDo
EndIf

RestArea( aArea )
Return( aCol )

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                                   MUL - T - LOCK                                      บฑฑ
ฑฑฬออออออออออออัอออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบPrograma    ณ A010CLIC  ณ Marca e desmarca itens da GetDados no simulador de Factory   บฑฑ
ฑฑฬออออออออออออุอออออออออออฯอออออออออออออออออออออออออออออออออออออออออออัออออออัอออออออออออนฑฑ
ฑฑบAutor       ณ Actual Trend                                          ณ Data ณ  16/11/09 บฑฑ
ฑฑศออออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออฯอออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

Static Function A010CLIC( oSE1Get, lMarkAll )

Local _n1
Local lRet		   := .T.
Local nLinAtu	   := oSE1Get:nAt
Local nTMPPos  	   := GdFieldPos("TMP_OK",oSE1Get:aHeader)

Default lMarkAll   := .F.

If lMarkAll
	For _n1 := 1 to Len(oSE1Get:aCols)
		oSE1Get:Acols[ _n1 ][ nTMPPos ] := IIf( oSE1Get:Acols[ _n1 ][ nTMPPos ] == cMark, cNoMark, cMark)
	Next _n1
	A010SOMA( oSE1Get,.F.)
Else
	If AllTrim( oSE1Get:Acols[ nLinAtu ][ nTMPPos ]:CNAME) == cNoMark:CNAME
		oSE1Get:Acols[ nLinAtu ][ nTMPPos ] := cMark
	Else
		oSE1Get:Acols[ nLinAtu ][ nTMPPos ] := cNoMark
	EndIf
	A010SOMA( oSE1Get,.F.)
EndIf

oSE1Get:oBrowse:Refresh()

Return( lRet )

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                                   MUL - T - LOCK                                      บฑฑ
ฑฑฬออออออออออออัอออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบPrograma    ณ A010SOMA  ณ Soma valores conforme itens selecionados na GetDados         บฑฑ
ฑฑฬออออออออออออุอออออออออออฯอออออออออออออออออออออออออออออออออออออออออออัออออออัอออออออออออนฑฑ
ฑฑบAutor       ณ Actual Trend                                          ณ Data ณ  16/11/09 บฑฑ
ฑฑศออออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออฯอออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

Static Function A010SOMA( oSE1Get, lFloat )

Local nSaldoTit := 0
Local _n2       := 1
Local cSegmento := ""

nTarAutom:= 0; nVlrAutom:= 0; nTarCorpo:= 0; nVlrCorpo:= 0; nTarVarej:= 0; nVlrVarej:= 0; nTarMultl := 0; nVlrMultl := 0; nTarAssis := 0; nVlrAssis :=0; nTarIndus:= 0; nVlrIndus :=0
nTotDesag:= 0; nTotComis:= 0; nTotLoren:= 0; nTotIOF  := 0; nTotCmIOF:= 0; nTotISS  := 0
nTotDupli:= 0; nTotChequ:= 0; nTotTAC  := 0; nTotTED  := 0; nTotDOC  := 0
nTotTar  := 0; nTotBru  := 0; nTotLiq  := 0

For _n2 := 1 to Len(oSE1Get:aCols)
	If AllTrim(oSE1Get:aCols[_n2, GdFieldPos("TMP_OK",oSE1Get:aHeader)]:CNAME ) == "LBOK"
		nDias     := oSE1Get:aCols[_n2, GdFieldPos("DIAS",oSE1Get:aHeader)]
		cTipoTitu := oSE1Get:aCols[_n2, GdFieldPos("E1_XTPPAG",oSE1Get:aHeader)]
		nSaldoTit := oSE1Get:aCols[_n2, GdFieldPos("E1_VALOR",oSE1Get:aHeader)]
		cNotaFisc := oSE1Get:aCols[_n2, GdFieldPos("E1_NUM",oSE1Get:aHeader)] + oSE1Get:aCols[_n2, GdFieldPos("E1_PREFIXO",oSE1Get:aHeader)] + oSE1Get:aCols[_n2, GdFieldPos("E1_CLIENTE",oSE1Get:aHeader)] + oSE1Get:aCols[_n2, GdFieldPos("E1_LOJA",oSE1Get:aHeader)]
		cPedido   := GetAdvFval('SD2', 'D2_PEDIDO' , xFilial('SD2')+cNotaFisc, 3, '')
		cSegmento := GetAdvFval('SC5', 'C5_XORIGEM', xFilial('SC5')+cPedido, 1, '')
		
		nTotBru	  += nSaldoTit
		nTotDesag +=  ( nSaldoTit * ((nPerDesag/30) * nDias) / 100)
		nTotComis +=  ( nSaldoTit * ((nPerComis/30) * nDias) / 100)
		nTotCmIOF += (( nSaldoTit * nPerCmIOF )/100)
		nTotDupli += nValDupli
		nTotChequ += IIf(AllTrim(cTipoTitu) == "CHEQUE", nValChequ, 0)
		
		If cSegmento == "A"       //Automotivo
			nVlrAutom +=  nSaldoTit
			
		ElseIf cSegmento == "C"   //Corporativo
			nVlrCorpo +=  nSaldoTit
			
		ElseIf cSegmento == "V"   //Varejo
			nVlrVarej +=  nSaldoTit
			
		ElseIf cSegmento == "M"   //MultLock Center
			nVlrMultl +=  nSaldoTit
			
		ElseIf cSegmento == "T"   //Assitencia Tecnica
			nVlrAssis +=  nSaldoTit
			
		ElseIf cSegmento == "I"   //Industrial
			nVlrIndus +=  nSaldoTit
		EndIf
	EndIf
Next _n2                                                                                      

If nTotBru <> 0
	nTotLoren+= (( nTotBru  * nPerLoren)/100)
	nTotIOF  += (( nTotBru  * nPerIOF   )/100)
	nTotISS  += (( nTotLoren* nPerISS   )/100)
	nTotTAC  += nValTAC
	nTotTED  += nValTED
	nTotDOC  += nValDOC
	
	nTotTar  += ( nTotDesag + nTotComis + nTotLoren + nTotIOF + nTotCmIOF + nTotISS + nTotDupli + nTotChequ + nTotTAC + nTotTED + nTotDOC )
	nTotLiq  += nTotBru - ( nTotDesag + nTotComis + nTotLoren + nTotIOF + nTotCmIOF + nTotISS + nTotDupli + nTotChequ + nTotTAC + nTotTED + nTotDOC )
	
	If cSegmento == "A"       //Automotivo
		nTarAutom += ( nTotDesag + nTotComis + nTotLoren + nTotIOF + nTotCmIOF + nTotISS + nTotDupli + nTotChequ + nTotTAC + nTotTED + nTotDOC )
		
	ElseIf cSegmento == "C"   //Corporativo
		nTarCorpo += ( nTotDesag + nTotComis + nTotLoren + nTotIOF + nTotCmIOF + nTotISS + nTotDupli + nTotChequ + nTotTAC + nTotTED + nTotDOC )
		
	ElseIf cSegmento == "V"   //Varejo
		nTarVarej += ( nTotDesag + nTotComis + nTotLoren + nTotIOF + nTotCmIOF + nTotISS + nTotDupli + nTotChequ + nTotTAC + nTotTED + nTotDOC )
		
	ElseIf cSegmento == "M"   //MultLock Center
		nTarMultl += ( nTotDesag + nTotComis + nTotLoren + nTotIOF + nTotCmIOF + nTotISS + nTotDupli + nTotChequ + nTotTAC + nTotTED + nTotDOC )
		
	ElseIf cSegmento == "T"   //Assitencia Tecnica
		nTarAssis += ( nTotDesag + nTotComis + nTotLoren + nTotIOF + nTotCmIOF + nTotISS + nTotDupli + nTotChequ + nTotTAC + nTotTED + nTotDOC )
		
	ElseIf cSegmento == "I"   //Industrial
		nTarIndus += ( nTotDesag + nTotComis + nTotLoren + nTotIOF + nTotCmIOF + nTotISS + nTotDupli + nTotChequ + nTotTAC + nTotTED + nTotDOC )
	EndIf
EndIf

oTotDesag:Refresh();oTotComis:Refresh();oTotLoren:Refresh();oTotIOF:Refresh();oTotCmIOF:Refresh();oTotISS:Refresh();oTotDupli:Refresh();oTotChequ:Refresh()
oTotTAC:Refresh();oTotTED:Refresh();oTotDOC:Refresh()
oTarAutom:Refresh();oTarCorpo:Refresh();oTarVarej:Refresh();oTarMultl:Refresh();oTarAssis:Refresh();oTarIndus:Refresh()
oVlrAutom:Refresh();oVlrCorpo:Refresh();oVlrvarej:Refresh();oVlrMultl:Refresh();oVlrAssis:Refresh();oVlrIndus:Refresh()
oTotTar:Refresh();oTotBru:Refresh();oTotLiq:Refresh()
_oDlg:Refresh()
oSE1Get:Refresh()

Return()

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณPrograma   ณ   C()   ณ Autores ณ Norbert/Ernani/Mansano ณ Data ณ10/05/2005ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescricao  ณ Funcao responsavel por manter o Layout independente da       ณฑฑ
ฑฑณ           ณ resolucao horizontal do Monitor do Usuario.                  ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function C(nTam)

Local nHRes	:=	oMainWnd:nClientWidth	// Resolucao horizontal do monitor
Local cTema := IIf( (Alltrim(GetTheme()) == "TEMAP10") .Or. SetMdiChild(), "TEMAP10", "")

If nHRes <= 1000	// Resolucao 800x600
	nTam *= 1.00
Else       	        // Resolucao 1024x768 e acima
	nTam *= 1.28
EndIf

If !Empty(cTema)
	nTam *= 1.00
EndIf

Return Int(nTam)


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                              M U L T  -  T  -  L O C K                                บฑฑ
ฑฑฬออออออออออออัอออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบFuncao      ณ A001PERG  ณ Verifica a existencia das perguntas criando-as caso seja     บฑฑ
ฑฑบ            ณ           ณ  necessario (caso nao existam).                              บฑฑ
ฑฑฬออออออออออออุอออออออออออฯอออออออออออออออออออออออออออออออออออออออออออัออออออัอออออออออออนฑฑ
ฑฑบAutor       ณ Actual Trend                                          ณ Data ณ  09/04/09 บฑฑ
ฑฑศออออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออฯอออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

Static Function A001PERG(cPerg)

Local aAreaAtu	:= GetArea()
Local aAreaSX1	:= SX1->( GetArea() )

PutSx1(	cPerg, "01","Numero do border๔        ? ","","","Mv_ch1",TAMSX3("EA_NUMBOR")[3] ,TAMSX3("EA_NUMBOR")[1] ,TAMSX3("EA_NUMBOR")[2] ,0,"G","","","","N","Mv_par01","","","","","","","","","","","","","","","","",{"Informe o numero do bordero ou deixe em branco","para efetuar simula็ใo"},{""},{""},"")

RestArea( aAreaSX1 )
RestArea( aAreaAtu )

Return(cPerg)