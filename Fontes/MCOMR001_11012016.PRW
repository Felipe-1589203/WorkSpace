#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                                   MUL - T - LOCK                                      บฑฑ
ฑฑฬออออออออออออัอออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบPrograma    ณ MCOMR001  ณ Pedido de compras Grafico                                    บฑฑ
ฑฑฬออออออออออออุอออออออออออฯอออออออออออออออออออออออออออออออออออออออออออัออออออัอออออออออออนฑฑ
ฑฑบAutor       ณ Actual Trend                                          ณ Data ณ  23/10/09 บฑฑ
ฑฑศออออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออฯอออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

User Function MCOMR001()
                                                             
Local cString := "SC7"
Local wnrel   := "MCOMR001"
Local Titulo  := "Pedido de Compras"
Local nLastKey:= 0

If nLastKey = 27
	dbClearFilter()
	Return
Endif

Processa({|lEnd| R001PRINT(@lEnd,wnRel,cString)},Titulo)

Return

Static Function R001PRINT(lEnd,wnRel,cString)

Local _n1, _n2
Local cUserId     := RetCodUsr()
Local nPagina     := 1
Local nLin   	  := 30
Local nCol  	  := 30
Local nLinIni	  := 090
Local nColIni	  := 080
Local nColFim	  := 2300
Local nLinFim	  := 3070
Local nTamDesc    := 27
Local nLinObs     := 0
Local cFiltro     := ""
Local cDescri     := ""
Local cPerg       := "XXXX"  //MCOMR001
Local aParamBox   := {}
Local aRet        := {}

Private nLinRoda  := 1750
Private nLinLim	  := 2890
Private nTxMoeda  := 0
Private nTotDesc  := 0
Private nTotMerc  := 0
Private lAuto	  := IIf(AllTrim(FunName()) <> "U_MCOMR001", .T., .F.)
Private lNewAlc   := .F.
Private lLiber    := .F.
Private cComprador:= ""
Private cAprovador:= ""
Private cAlternati:= ""
Private cSolicitan:= ""
Private cObs01    := ""
Private cObs02    := ""
Private cObs03    := ""
Private cObs04    := ""
Private cObs05    := ""
Private nIdioma   := 0

Private oFont10   := TFont():New("Courier New",10,08,,.F.,,,,.T.,.F.)	//Normal s/negrito
Private oFont10n  := TFont():New("Courier New",10,08,,.T.,,,,.T.,.F.)	//Negrito
Private oFont12n  := TFont():New("Courier New",12,10,,.T.,,,,.T.,.F.)	//Negrito
Private oFont14n  := TFont():New("Courier New",14,12,,.T.,,,,.T.,.F.)	//Negrito

Aadd( aParamBox,{3,"Selecione o idioma a ser impresso",1,{"Portugues","Ingl๊s"},50,"",.F.} )
If ParamBox(aParamBox, "Parโmetros...",@aRet,,,,,,,,.F.,.F.)
	nIdioma := aRet[1]
EndIf

If nIdioma <> 1 .And. nIdioma <> 2
	Return()
EndIf

If nIdioma == 1
	Private cMensg01 := "FONE : "
	Private cMensg02 := "CONTATO : "
	Private cMensg03 := "ITEM CODIGO           DESCRICAO DO MATERIAL         UM   QUANTIDADE VALOR UNITARIO   IPI   VALOR TOTAL ENTREGA   C.C.      S.C.  "
	Private cMensg04 := "EMISSรO : "
	Private cMensg05 := " AS "
	Private cMensg06 := "PมG : "
	Private cMensg07 := "PEDIDO  Nบ "
	Private cMensg08 := "     EM "
	Private cMensg09 := "AUTORIZAวรO DE ENTREGA  Nบ "
	Private cMensg10 := " D E S C O N T O S "
	Private cMensg11 := " Local de Entrega  : "
	Private cMensg12 := " Local de Cobranca : "
	Private cMensg13 := " Condicao de Pagto"
	Private cMensg14 := "Data de Emissao"
	Private cMensg15 := "Total das Mercadorias :"
	Private cMensg16 := "Total com impostos    :"
	Private cMensg17 := " Reajuste :"
	Private cMensg18 := " Observa็๕es"
	Private cMensg19 := "Frete    : "
	Private cMensg20 := "Grupo    : "
	Private cMensg21 := "Despesas    : "
	Private cMensg22 := "Seguro      : "
	Private cMensg23 := "TOTAL GERAL    : "
	Private cMensg24 := " P E D I D O   L I B E R A D O "
	Private cMensg25 := " P E D I D O   B L O Q U E A D O "
	Private cMensg26 := "Obs do Frete : "
	Private cMensg27 := " Solicitante  : "
	Private cMensg28 := " Comprador    : "
	Private cMensg29 := " Alternativos : "
	Private cMensg30 := " Aprovador(es): "
	Private cMensg31 := " Legendas da aprova็ใo  : BLQ -> Bloqueado  |  OK -> Liberado  |  ?? -> Aguard. Libera็ใo  |  ## -> Nivel Libera็ใo"
	Private cMensg32 := " NOTA: So aceitaremos a mercadoria se na sua Nota Fiscal constar o numero do nosso Pedido de Compras."
	Private cMensg33 := " Horario de recebimento de segunda a quinta dss 9:00 AS 16:00hrs e de Sexta Das 09:00 AS 15:00hrs"
	Private cMensg35 := " exceto horแrio de almo็o das 12:00 as 13:00hrs."
	Private cMensg34 := " -  CEP : "
Else
	Private cMensg01 := "PHONE: "
	Private cMensg02 := "CONTACT : "
	Private cMensg03 := "ITEM CAT Nบ           DESCRIPTION                   UM    QUANTITY      UNIT PRICE   IPI   TOTAL PRICE DELIVERY  C.C.      S.C.  "
	Private cMensg04 := "EMISSION: "
	Private cMensg05 := " AT "
	Private cMensg06 := "PAGE: "
	Private cMensg07 := "ORDER  Nบ "
	Private cMensg08 := "     IN "
	Private cMensg09 := "DELIVERY AUTHORIZATION Nบ "
	Private cMensg10 := " D E S C O U N T S "
	Private cMensg11 := " Delivery Place    : "
	Private cMensg12 := " Billing Place     : "
	Private cMensg13 := " Payment Condition"
	Private cMensg14 := "Emission Date  "
	Private cMensg15 := "Total of the goods    :"
	Private cMensg16 := "Total with taxes      :"
	Private cMensg17 := " Reajustment"
	Private cMensg18 := " Observation"
	Private cMensg19 := "Freight  : "
	Private cMensg20 := "Group    : "
	Private cMensg21 := "Expanditure : "
	Private cMensg22 := "Insurance   : "
	Private cMensg23 := "GLOBAL TOTAL   : "
	Private cMensg24 := " O R D E R  B L O C K E D "
	Private cMensg25 := " O R D E R  R E L E A S E D"
	Private cMensg26 := "Incoterm     : "
	Private cMensg27 := " Requesitor   : "
	Private cMensg28 := " Purchaser    : "
	Private cMensg29 := " Alternatives : "
	Private cMensg30 := " Approver(s)  : "
	Private cMensg31 := " Aprover subtitles      : BLQ -> Blocked    |  OK -> Released  |  ?? -> Waiting Release    |  ## -> Release level  "
	Private cMensg32 := " NOTE: We Will just accept the goods if in the invoice where included the number of our order."
	Private cMensg33 := ""
	Private cMensg34 := " -  ZIP : "
	Private cMensg35 := ""
EndIf

If Type("lPedido") != "L"
	lPedido := .F.
Endif

R001PERG(cPerg) // MTR110
lPerg := Pergunte(cPerg,Iif(lAuto == .T., .F., .T.) )

mv_par09 := 1

If lAuto == .T.
	dbSelectArea("SC7")
	mv_par01 := SC7->C7_NUM
	mv_par02 := SC7->C7_NUM
	mv_par03 := SC7->C7_EMISSAO
	mv_par04 := SC7->C7_EMISSAO
	mv_par05 := Eval({|| cCont:=ChkPerg(cUserId,"MTR110","05"),If(cCont == Nil,2,cCont) })
	mv_par08 := Eval({|| cCont:=ChkPerg(cUserId,"MTR110","08"),If(cCont == Nil,SC7->C7_TIPO,cCont) })
	mv_par08 := Eval({|| cCont:=ChkPerg(cUserId,"MTR110","08"),If(cCont == Nil,SC7->C7_TIPO,cCont) })
	mv_par09 := Eval({|| cCont:=ChkPerg(cUserId,"MTR110","09"),If(cCont == Nil,1,cCont) })
	mv_par10 := Eval({|| cCont:=ChkPerg(cUserId,"MTR110","10"),If(cCont == Nil,3,cCont) })
	mv_par11 := Eval({|| cCont:=ChkPerg(cUserId,"MTR110","11"),If(cCont == Nil,3,cCont) })
	mv_par14 := Eval({|| cCont:=ChkPerg(cUserId,"MTR110","14"),If(cCont == Nil,1,cCont) })
EndIf

DbSelectArea("SC7")
SC7->(DbSetOrder(1))
SC7->(DbSeek(xFilial("SC7")+mv_par01,.T.))

nRecFim := SC7->(RECNO())

If lPedido
	mv_par12 := MAX(SC7->C7_MOEDA,1)
Endif

If mv_par14 == 2
	cFiltro := "SC7->C7_QUANT-SC7->C7_QUJE <= 0 .Or. !EMPTY(SC7->C7_RESIDUO)"
Elseif mv_par14 == 3
	cFiltro := "SC7->C7_QUANT > SC7->C7_QUJE"
EndIf

oPrint:= TMSPrinter():New( "Pedido de Compras")
oPrint:Rebuild()
oPrint:SetPortrait()					// Modo retrato
oPrint:SetPaperSize(9)					// Papel A4

ProcRegua(RecCount())
While SC7->C7_NUM   >= Mv_par01 .And. SC7->C7_NUM     <= Mv_par02 .And.;
	SC7->C7_EMISSAO >= Mv_par03 .And. SC7->C7_EMISSAO <= Mv_par04 .And. SC7->(!Eof())
	
	If (SC7->C7_CONAPRO == "B" .And. mv_par10 == 1) .Or.;
		(SC7->C7_CONAPRO <> "B" .And. mv_par10 == 2) .Or.;
		(SC7->C7_EMITIDO == "S" .And. mv_par05 == 1) .Or.;
		((SC7->C7_EMISSAO < mv_par03) .Or. (SC7->C7_EMISSAO > mv_par04)) .Or.;
		(SC7->C7_TIPO == 1 .And. mv_par08 == 2) .Or.;
		(SC7->C7_TIPO == 2 .And. mv_par08 == 1) .Or. !MtrAValOP(mv_par11, "SC7") .Or.;
		(SC7->C7_QUANT > SC7->C7_QUJE .And. mv_par14 == 3) .Or.;
		((SC7->C7_QUANT - SC7->C7_QUJE <= 0 .Or. !Empty(SC7->C7_RESIDUO)) .And. mv_par14 == 2 )
		
		SC7->(DbSkip())
		Loop
	EndIf
	
	If !MtrAValOP(mv_par11, 'SC7')
		SC7->(DbSkip())
		Loop
	EndIf
	
	nRecSC7 := SC7->(RECNO())
	cNumPed := SC7->C7_NUM
	cCliPed := Posicione("SA2",1, xFilial("SA2")+SC7->C7_FORNECE+SC7->C7_LOJA, "A2_COD")
	nTxMoeda:= IIF(SC7->C7_TXMOEDA > 0,SC7->C7_TXMOEDA,Nil)
	
	nCont := 0
	For _n1 := 1 to Mv_par09
		nPagina := 1
		nLin    := 30
		oPrint:StartPage()
		
		MaFisEnd()
		MaFisIniPC(SC7->C7_NUM,,,cFiltro)
		
		While SC7->C7_NUM == cNumPed .And. SC7->(!Eof())
			IncProc("Pedido de compras "+SC7->C7_NUM +"/"+SC7->C7_ITEM)
			
			If (SC7->C7_CONAPRO == "B" .And. mv_par10 == 1) .Or.;
				(SC7->C7_CONAPRO <> "B" .And. mv_par10 == 2) .Or.;
				(SC7->C7_EMITIDO == "S" .And. mv_par05 == 1) .Or.;
				((SC7->C7_EMISSAO < mv_par03) .Or. (SC7->C7_EMISSAO > mv_par04)) .Or.;
				(SC7->C7_TIPO == 1 .And. mv_par08 == 2) .Or.;
				(SC7->C7_TIPO == 2 .And. mv_par08 == 1) .Or. !MtrAValOP(mv_par11, "SC7") .Or.;
				(SC7->C7_QUANT > SC7->C7_QUJE .And. mv_par14 == 3) .Or.;
				((SC7->C7_QUANT - SC7->C7_QUJE <= 0 .Or. !Empty(SC7->C7_RESIDUO)) .And. mv_par14 == 2 )
				
				SC7->(DbSkip())
				Loop
			EndIf
			
			If !MtrAValOP(mv_par11, 'SC7')
				SC7->(DbSkip())
				Loop
			EndIf
			
			If !Empty(SC7->C7_OBS) .And. nLinObs < 5
				nLinObs++
				cVar:="cObs"+StrZero(nLinObs,2)
				Eval(MemVarBlock(cVar),SC7->C7_OBS)
			Endif

			For _n2 := 1 to 2
				//*************************** Cabecalho
				If (( nPagina == 1 .And. (nLin <= 30 .Or. nLin >= nLinLim) ) .Or. ( nPagina > 1 .And. (nLin <= 30 .Or. nLin >= nLinLim) ))
					If nPagina > 1
						oPrint:Say(nLinLim+20,nColIni, PADC("C O N T I N U A...",120), oFont10)
					EndIf
					
					nLin := U_R001CABE(nLin, nCol, nPagina, nLinIni, nColIni, nLinFim, nColFim)
					nPagina++
					nLin+= 005
				EndIf
				
				//*************************** Descricao dos produtos
				cDescri := ""                                                
				If AllTrim(mv_par06) == "B1_DESC"
					cDescri := Alltrim(Posicione("SB1",1, xFilial("SB1")+SC7->C7_PRODUTO , "B1_DESC"))
				EndIf
				
				If AllTrim(mv_par06) == "B5_CEME"
					cDescri := Alltrim(Posicione("SB5",1, xFilial("SB5")+SC7->C7_PRODUTO , "B5_CEME"))
				EndIf
				
				If AllTrim(mv_par06) == "C7_DESCRI"
					cDescri := Alltrim(SC7->C7_DESCRI)
				EndIf
				
				If Empty(cDescri)
					cDescri := Alltrim(Posicione("SB1",1, xFilial("SB1")+SC7->C7_PRODUTO , "B1_DESC"))
				EndIf
				
				cCodING := Alltrim(Posicione("SA5",1, xFilial("SA5")+SC7->C7_FORNECE+SC7->C7_LOJA+SC7->C7_PRODUTO , "A5_XINGCOD"))
				cDescri += IIf(!Empty(cCodING), " ("+Alltrim(cCodING)+")", "")
				
				If nIdioma == 2                                     
					cDescri := IIf(!Empty(cCodING), Alltrim(cCodING)+" - "+AllTrim(SA5->A5_XINGDES), cDescri)
				EndIf
				
				nLinha:= MLCount(cDescri,nTamDesc)
				
				//*************************** Impressao dos itens
				oPrint:Say(nLin,nColIni+010, SC7->C7_ITEM                                          , oFont10)
				oPrint:Say(nLin,nColIni+100, SC7->C7_PRODUTO                                       , oFont10)
				oPrint:Say(nLin,nColIni+390, MemoLine(cDescri,nTamDesc,1)                          , oFont10)
				
				oPrint:Say(nLin,nColIni+0890, Iif( (Mv_par07 == 2 .And. !Empty(SC7->C7_SEGUM)), SC7->C7_SEGUM, SC7->C7_UM )                                                  , oFont10)
				oPrint:Say(nLin,nColIni+0940, Transform( Iif( (Mv_par07 == 2 .And. !Empty(SC7->C7_SEGUM)), SC7->C7_QTSEGUM, SC7->C7_QUANT ), PesqPict("SC7","C7_QUANT"))    , oFont10)
				If MV_PAR07 == 2 .And. !Empty(SC7->C7_QTSEGUM)
					oPrint:Say(nLin,nColIni+1165, Transform(xMoeda((SC7->C7_TOTAL/SC7->C7_QTSEGUM),SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,,nTxMoeda), PesqPict("SC7","C7_TOTAL")), oFont10)
				Else
					oPrint:Say(nLin,nColIni+1165, Transform(xMoeda(SC7->C7_PRECO,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,,nTxMoeda), PesqPict("SC7","C7_PRECO")), oFont10)
				EndIf
				
				If Mv_par08 == 1
					oPrint:Say(nLin,nColIni+1435, Transform(SC7->C7_IPI  , PesqPict("SC7","C7_IPI"  )), oFont10)
					oPrint:Say(nLin,nColIni+1540, Transform(xMoeda(SC7->C7_TOTAL,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,,nTxMoeda), PesqPict("SC7","C7_TOTAL")), oFont10)
					oPrint:Say(nLin,nColIni+1760, Dtoc(SC7->C7_DATPRF)                                     , oFont10)
					oPrint:Say(nLin,nColIni+1920, SC7->C7_CC                                               , oFont10)
					oPrint:Say(nLin,nColIni+2100, SC7->C7_NUMSC                                            , oFont10)
				Else
					oPrint:Say(nLin,1540, Transform(xMoeda(SC7->C7_TOTAL,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,,nTxMoeda), PesqPict("SC7","C7_TOTAL")), oFont10)
					oPrint:Say(nLin,1760, Dtoc(SC7->C7_DATPRF)                                             , oFont10)
					If !Empty(SC7->C7_OP)
						oPrint:Say(nLin,nColIni+1920, SC7->C7_OP                                           , oFont10)
					Else
						oPrint:Say(nLin,nColIni+1920, SC7->C7_CC                                           , oFont10)
					EndIf
				EndIf
				nLin+= 50
				nTotMerc += xMoeda(SC7->C7_TOTAL,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,,nTxMoeda)
				
				For _n2 := 2 to nLinha
					//*************************** Cabecalho
					If (( nPagina == 1 .And. (nLin <= 30 .Or. nLin >= nLinLim) ) .Or. ( nPagina > 1 .And. (nLin <= 30 .Or. nLin >= nLinLim) ))
						If nPagina > 1
							oPrint:Say(nLinLim+20,nColIni, PADC("C O N T I N U A...",120), oFont10)
						EndIf
						
						nLin := U_R001CABE(nLin, nCol, nPagina, nLinIni, nColIni, nLinFim, nColFim)
						nPagina++
						nLin+= 005
					EndIf
					
					
					oPrint:Say(nLin,nColIni+390, MemoLine(cDescri,nTamDesc,_n2)                         , oFont10)
					nLin+= 50
				Next _n2
				
				If SC7->C7_DESC1 != 0 .Or. SC7->C7_DESC2 != 0 .Or. SC7->C7_DESC3 != 0
					nTotDesc += CalcDesc(SC7->C7_TOTAL,SC7->C7_DESC1,SC7->C7_DESC2,SC7->C7_DESC3)
				Else
					nTotDesc += SC7->C7_VLDESC
				EndIf
			Next _n1
			SC7->( dbSkip() )
		End-While
		
		nRecFim := SC7->(RECNO())
		SC7->(DbGoTo(nRecSC7))
		
		cSolicitan := Alltrim(UsrFullName(GetAdvFval("SC1", "C1_USER", xFilial("SC1")+SC7->(C7_NUMSC+C7_ITEMSC), 1, 0)))
		
		If !Empty(SC7->C7_APROV)
			lNewAlc    := .T.
			cComprador += UsrFullName(SC7->C7_USER)
			
			If SC7->C7_CONAPRO != "B"
				lLiber := .T.
			EndIf
			
			DbSelectArea("SCR")
			SCR->(DbSetOrder(1))
			SCR->(DbSeek(xFilial("SCR")+"PC"+SC7->C7_NUM))
			While SCR->(!Eof()) .And. SCR->CR_FILIAL+Alltrim(SCR->CR_NUM)==xFilial("SCR")+Alltrim(SC7->C7_NUM) .And. SCR->CR_TIPO == "PC"
				cAprovador += AllTrim(UsrFullName(SCR->CR_USER))+" em "+Dtoc(SCR->CR_EMISSAO)+" ["
				Do Case
					Case SCR->CR_STATUS=="03" //Liberado
						cAprovador += "Ok"
					Case SCR->CR_STATUS=="04" //Bloqueado
						cAprovador += "BLQ"
					Case SCR->CR_STATUS=="05" //Nivel Liberado
						cAprovador += "##"
					OtherWise                 //Aguar.Lib
						cAprovador += "??"
				EndCase
				cAprovador += "] - "
				SCR->(DbSkip())
			End-While
			
			If !Empty(SC7->C7_GRUPCOM)
				DbSelectArea("SAJ")
				SAJ->(DbSetOrder(1))
				SAJ->(DbSeek(xFilial("SAJ")+SC7->C7_GRUPCOM))
				
				While SAJ->(!Eof()) .And. SAJ->AJ_FILIAL+SAJ->AJ_GRCOM == xFilial("SAJ")+SC7->C7_GRUPCOM
					If SAJ->AJ_USER != SC7->C7_USER
						cAlternativo += AllTrim(UsrFullName(SAJ->AJ_USER))+"/"
					EndIf
					
					SAJ->(DbSkip())
				End-While
			EndIf
		EndIf
		
		//*************************** Rodape
		If nLin >= nLinLim .Or. nLin >=  nLinRoda
			nLinLim := nLinRoda
			nLin    := U_R001CABE(nLin, nCol, nPagina, nLinIni, nColIni, nLinFim, nColFim)
			nPagina++
		EndIf
		nLin := U_R001RODA(nLin, nCol, nPagina, nLinIni, nColIni, nLinFim, nColFim)
		
		MaFisEnd()
		oPrint:EndPage()
	Next _n1
	SC7->(DbGoTo(nRecFim))
End-While

oPrint:Preview()

Return()

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                                   MUL - T - LOCK                                      บฑฑ
ฑฑฬออออออออออออัอออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบPrograma    ณ R001CABE  ณ Funcao cabecalho pedido compras Grafico                      บฑฑ
ฑฑฬออออออออออออุอออออออออออฯอออออออออออออออออออออออออออออออออออออออออออัออออออัอออออออออออนฑฑ
ฑฑบAutor       ณ Actual Trend                                          ณ Data ณ  23/10/09 บฑฑ
ฑฑศออออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออฯอออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

User Function R001CABE(nLin, nCol, nPagina, nLinIni, nColIni, nLinFim, nColFim)

Local cMoeda := IIf( mv_par12 < 10 , Str(mv_par12,1) , Str(mv_par12,2) )

If nLin >= nLinLim
	nLin   := 30
	
	oPrint:EndPage()
	oPrint:StartPage()
EndIf

If nPagina == 1
	//*************************** Cabecalho
	oPrint:SayBitmap(nLinIni+80, nColIni+10, "Lgrl"+cFilAnt+".bmp",nColIni+210, nLinIni+040) //"logo_email4.bmp"
	oPrint:Box(nLinIni    , nColIni, nLinFim    , nColFim)
	oPrint:Box(nLinIni    , nColIni, nLinIni+330, nColFim)
	oPrint:Box(nLinIni+330, nColIni, nLinIni+430, nColFim)
	oPrint:Box(nLinIni    , nColIni, nLinIni+330, nColIni+1150)
	
	//*************************** Dados da empresa
	oPrint:Say(nLinIni+020,nColIni+310, SM0->M0_NOMECOM                                                                                           , oFont10n)
	oPrint:Say(nLinIni+070,nColIni+315, "CNPJ : "+Transform( SM0->M0_CGC  , PesqPict("SA2","A2_CGC"))                                            , oFont10)
	oPrint:Say(nLinIni+070,nColIni+790, "I.E : " +Transform( SM0->M0_INSC , PesqPict("SA2","A2_INSCR"))                                          , oFont10)
	oPrint:Say(nLinIni+120,nColIni+310, AllTrim(SM0->M0_ENDENT)+" - "+AllTrim(SM0->M0_BAIRENT)                                                   , oFont10)
	oPrint:Say(nLinIni+170,nColIni+310, AllTrim(SM0->M0_CIDENT)+" - "+AllTrim(SM0->M0_ESTENT)+cMensg34+AllTrim(Transform(SM0->M0_CEPENT, PesqPict("SA2","A2_CEP")))    , oFont10)
	oPrint:Say(nLinIni+220,nColIni+310,cMensg01+SM0->M0_TEL +"  FAX : "+SM0->M0_FAX                                                             , oFont10)
	
	//*************************** Dados do fornecedor
	oPrint:Say(nLinIni+020,nColIni+1170, SubStr(SA2->A2_NOME,1,35)+" CLIENTE: "+SC7->C7_FORNECE+"/"+SC7->C7_LOJA                                , oFont10n)
	oPrint:Say(nLinIni+070,nColIni+1170, "CNPJ : "+Transform(SA2->A2_CGC  , PesqPict("SA2","A2_CGC"))                                            , oFont10)
	oPrint:Say(nLinIni+070,nColIni+1790, "I.E : " +Transform(SA2->A2_INSCR, PesqPict("SA2","A2_INSCR"))                                          , oFont10)
	oPrint:Say(nLinIni+120,nColIni+1175, AllTrim(SA2->A2_END)+", "+AllTrim(SA2->A2_XNUM)+" - "+AllTrim(SA2->A2_BAIRRO)                          , oFont10)
	oPrint:Say(nLinIni+170,nColIni+1175, AllTrim(SA2->A2_MUN)+" - "+AllTrim(SA2->A2_EST)+cMensg34+AllTrim(Transform(SA2->A2_CEP, PesqPict("SA2","A2_CEP") )) , oFont10)
	oPrint:Say(nLinIni+220,nColIni+1180,cMensg01+"("+SA2->A2_DDD+") "+AllTrim(SA2->A2_TEL)+"     FAX : ("+SA2->A2_DDD+") "+SA2->A2_FAX            , oFont10)
	oPrint:Say(nLinIni+270,nColIni+1180,cMensg02+ SC7->C7_CONTATO                                                                            , oFont10)
	
	If Mv_par08 == 1
		oPrint:Say(nLinIni+360, nColIni, PADC(cMensg07+SC7->C7_NUM+cMensg08+GetMV("MV_MOEDA"+cMoeda),090)                                   , oFont14n)
	Else
		oPrint:Say(nLinIni+365, nColIni,  PADC(cMensg09+SC7->C7_NUMSC + "/" + SC7->C7_NUM+cMensg07+GetMV("MV_MOEDA"+cMoeda),90), oFont14n)
	EndIf
	
	//*************************** Cabecalho dos itens
	oPrint:Say(nLinIni+450,nColIni+10,cMensg03 , oFont10n)
	nLin := nLinIni + 500
	
	//*************************** Rodape
	oPrint:Box(nLinFim-60, nColIni, nLinFim, nColFim)
	oPrint:Say(nLinFim-45, nColIni+15 , cMensg04+ Dtoc(dDatabase)+cMensg05+TIME()+" HRS"                                                        , oFont10n)
	oPrint:Say(nLinFim-45, nColFim-190, cMensg06+ Strzero(nPagina,4)                                                                               , oFont10n)
Else
	//*************************** Cabecalho dos itens
	oPrint:Box(nLinIni    , nColIni, nLinFim    , nColFim)
	oPrint:Say(nLinIni+050,nColIni+10,cMensg03 , oFont10n)
	nLin := nLinIni + 130
	
	//*************************** Rodape
	oPrint:Box(nLinFim-60, nColIni, nLinFim, nColFim)
	oPrint:Say(nLinFim-45, nColIni+15 , cMensg04+ Dtoc(dDatabase)+cMensg05+TIME()+" HRS"                                                        , oFont10n)
	oPrint:Say(nLinFim-45, nColFim-190, cMensg06+ Strzero(nPagina,4)                                                                               , oFont10n)
EndIf

Return(nLin)


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                                   MUL - T - LOCK                                      บฑฑ
ฑฑฬออออออออออออัอออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบPrograma    ณ R001RODA  ณ Funcao rodape do pedido compras Grafico                      บฑฑ
ฑฑฬออออออออออออุอออออออออออฯอออออออออออออออออออออออออออออออออออออออออออัออออออัอออออออออออนฑฑ
ฑฑบAutor       ณ Actual Trend                                          ณ Data ณ  23/10/09 บฑฑ
ฑฑศออออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออฯอออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

User Function R001RODA(nLin, nCol, nPagina, nLinIni, nColIni, nLinFim, nColFim)

Local _n1
Local nTotImpos := MaFisRet(,"NF_TOTAL")
Local nTotIpi	:= MaFisRet(,'NF_VALIPI')
Local nTotIcms	:= MaFisRet(,'NF_VALICM')
Local nTotDesp	:= MaFisRet(,'NF_DESPESA')
Local nTotFrete	:= MaFisRet(,'NF_FRETE')
Local nTotalNF	:= MaFisRet(,'NF_TOTAL')
Local nTotSeguro:= MaFisRet(,'NF_SEGURO')
//Local nTotMerc  := nTotImpos -(nTotIpi + nTotIcms + nTotDesp + nTotFrete + nTotalNF + nTotSeguro)

nRegistro := SM0->(Recno())
cFilEntre := Posicione("SM0",1, SUBS( cNumEmp,1,2)+SC7->C7_FILENT, "M0_FILIAL")
cDescPg   := Posicione("SE4",1, xFilial("SE4")+SC7->C7_COND, "E4_DESCRI")
cCondPg   := Posicione("SE4",1, xFilial("SE4")+SC7->C7_COND, "E4_COND")
cDesReaj  := Posicione("SM4",1, xFilial("SM4")+SC7->C7_REAJUST, "M4_DESCR")

oPrint:Line(nLinIni+1720,nColIni, nLinIni+1720, nColFim)
oPrint:Say(nLinIni+1740, nColIni, cMensg10             , oFont10)
oPrint:Say(nLinIni+1740, nColIni+0500, Transform(SC7->C7_DESC1, PesqPict("SC7","C7_DESC1")) , oFont10)
oPrint:Say(nLinIni+1740, nColIni+0800, Transform(SC7->C7_DESC2, PesqPict("SC7","C7_DESC2")) , oFont10)
oPrint:Say(nLinIni+1740, nColIni+1100, Transform(SC7->C7_DESC3, PesqPict("SC7","C7_DESC3")) , oFont10)
oPrint:Say(nLinIni+1740, nColIni+1600, Transform(xMoeda(nTotDesc,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,,nTxMoeda), PesqPict("SC7","C7_VLDESC")) , oFont10)

oPrint:Line(nLinIni+1800,nColIni, nLinIni+1800, nColFim)
oPrint:Say(nLinIni+1820, nColIni, cMensg11 , oFont10)
If Empty(MV_PAR13)
	oPrint:Say(nLinIni+1820, nColIni+370, AllTrim(Left(SM0->M0_ENDENT,55))+"  "+AllTrim(SM0->M0_CIDENT)+"  - "+AllTrim(SM0->M0_ESTENT)+cMensg34+Trans(Alltrim(SM0->M0_CEPENT),PesqPict("SA2","A2_CEP")) , oFont10)
Else
	oPrint:Say(nLinIni+1820, nColIni+370, AllTrim(MV_PAR13) , oFont10)
Endif
SM0->(DbGoto(nRegistro))

oPrint:Say(nLinIni+1870, nColIni     , cMensg12 , oFont10)
oPrint:Say(nLinIni+1870, nColIni+0370, AllTrim(Left(SM0->M0_ENDCOB,55))+"  "+AllTrim(SM0->M0_CIDCOB)+"  - "+AllTrim(SM0->M0_ESTCOB)+cMensg34+Trans(Alltrim(SM0->M0_CEPCOB),PesqPict("SA2","A2_CEP")) , oFont10)

oPrint:Line(nLinIni+1920,nColIni, nLinIni+1920, nColFim)
oPrint:Say(nLinIni+1940, nColIni     , cMensg13                  , oFont10)
oPrint:Say(nLinIni+1940, nColIni+0340, cCondPg                   , oFont10)
oPrint:Say(nLinIni+1990, nColIni+0050, cDescPg                   , oFont10)
oPrint:Say(nLinIni+1940, nColIni+1010, cMensg14                  , oFont10)
oPrint:Say(nLinIni+1990, nColIni+1070, Dtoc(SC7->C7_EMISSAO)     , oFont10)
oPrint:Say(nLinIni+1940, nColIni+1480, cMensg15                  , oFont10)
oPrint:Say(nLinIni+1940, nColIni+1890, Transform(xMoeda(nTotMerc,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,,nTxMoeda), tm(nTotMerc ,14,MsDecimais(MV_PAR12))) , oFont10)
oPrint:Say(nLinIni+1990, nColIni+1480, cMensg16                  , oFont10)
oPrint:Say(nLinIni+1990, nColIni+1890, Transform(xMoeda(nTotImpos,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,,nTxMoeda), tm(nTotImpos,14,MsDecimais(MV_PAR12))) , oFont10)

oPrint:Line(nLinIni+2120,nColIni,nLinIni+2120, nColFim-1230)
oPrint:Say(2150, nColIni, cMensg17                                , oFont10)
oPrint:Say(2150, nColIni+205, SC7->C7_REAJUST+"-"+ cDesReaj      , oFont10)

oPrint:Box(nLinIni+2030, nColIni ,nLinFim-0570, nColFim-1230)
oPrint:Say(2230, nColIni, cMensg18                                , oFont10)
oPrint:Say(2280, nColIni+10, cObs01                               , oFont10)
oPrint:Say(2320, nColIni+10, cObs02                               , oFont10)
oPrint:Say(2360, nColIni+10, cObs03                               , oFont10)
oPrint:Say(2400, nColIni+10, cObs04                               , oFont10)
oPrint:Say(2440, nColIni+10, cObs05                               , oFont10)

oPrint:Line(nLinIni+2030,nColIni, nLinIni+2030, nColFim)
oPrint:Say(2150, nColIni+1000, "IPI      : "                , oFont10)
oPrint:Say(2150, nColIni+1170, Transform(xMoeda(nTotIPI,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,,nTxMoeda), tm(nTotIpi ,14,MsDecimais(MV_PAR12))) , oFont10)
oPrint:Say(2220, nColIni+1000, cMensg19                     , oFont10)
oPrint:Say(2220, nColIni+1170, Transform(xMoeda(nTotFrete,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,,nTxMoeda),  tm(nTotFrete ,14,MsDecimais(MV_PAR12))) , oFont10)
oPrint:Say(2280, nColIni+1000, cMensg20                     , oFont10)

oPrint:Say(2150, nColIni+1660, "ICMS        : "             , oFont10)
oPrint:Say(2150, nColIni+1890, Transform(xMoeda(nTotIcms ,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,,nTxMoeda),  tm(nTotIcms ,14,MsDecimais(MV_PAR12))) , oFont10)
oPrint:Say(2220, nColIni+1660, cMensg21                     , oFont10)
oPrint:Say(2220, nColIni+1890, Transform(xMoeda(nTotDesp ,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,,nTxMoeda),  tm(nTotDesp ,14,MsDecimais(MV_PAR12))) , oFont10)
oPrint:Say(2280, nColIni+1660, cMensg22                     , oFont10)
oPrint:Say(2280, nColIni+1890, Transform(xMoeda(nTotSeguro,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,,nTxMoeda),  tm(nTotSeguro ,14,MsDecimais(MV_PAR12))) , oFont10)

oPrint:Line(nLinIni+2250,nColIni+0990, nLinIni+2250, nColFim)
oPrint:Say(nLinIni+2270, nColIni+1240, cMensg23             , oFont10)
oPrint:Say(nLinIni+2270, nColIni+1560, Transform(xMoeda(nTotalNF,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,,nTxMoeda), tm(nTotalNF ,14,MsDecimais(MV_PAR12))) , oFont10)

oPrint:Line(nLinIni+2330,nColIni+0990, nLinIni+2330, nColFim-480)
oPrint:Say(nLinIni+2350, nColIni+1070, Iif(lLiber,cMensg24, cMensg25) , oFont10)

oPrint:Box(nLinIni+2330, nColIni+1700 , nLinFim-260, nColFim)
oPrint:Say(nLinIni+2350, nColIni+1730, cMensg26+IF( SC7->C7_TPFRETE $ "F","FOB",IF(SC7->C7_TPFRETE $ "C","CIF"," " ))   , oFont10)

nLiAprov := MlCount(cComprador,80)
nLiCompr := MlCount(cAlternati,080)

oPrint:Line(nLinIni+2410,nColIni,nLinIni+2410, nColFim-520)
oPrint:Say(nLinIni+2430, nColIni, cMensg27             , oFont10)
oPrint:Say(nLinIni+2430, nColIni+290, cSolicitan       , oFont10)
oPrint:Say(nLinIni+2480, nColIni, cMensg28             , oFont10)
oPrint:Say(nLinIni+2480, nColIni+290, cComprador       , oFont10)
oPrint:Say(nLinIni+2530, nColIni, cMensg29             , oFont10)
If nLiCompr == 0
	oPrint:Say(nLinIni+2530, nColIni+290,Left(cAlternati,80)     , oFont10)
ElseIf nLiCompr > 0
	nLinAlt := nLinIni+2530
	For _n1 := 1 to 2
		oPrint:Say(nLinAlt, nColIni+290, Memoline(cAlternati,080,_n1) , oFont10)
		nLinAlt+=50
	Next
EndIf

oPrint:Say(nLinIni+2630, nColIni, cMensg30            , oFont10)
If nLiAprov == 0
	oPrint:Say(nLinIni+2630, nColIni+290, Left(cAprovador,80) , oFont10)
ElseIf nLiAprov > 0
	nLinApr := nLinIni+2630
	For _n1 := 1 to 2
		oPrint:Say(nLinApr, nColIni+290, Memoline(cAprovador,080,_n1) , oFont10)
		nLinApr+=50
	Next
EndIf
oPrint:Line(nLinIni+2720,nColIni, nLinIni+2720, nColFim)
oPrint:Say(nLinIni+2730, nColIni, cMensg31 , oFont10)

oPrint:Line(nLinIni+2780, nColIni, nLinIni+2780, nColFim)
oPrint:Say(nLinIni+2800, 0000, PADC(cMensg32,140), oFont10n)
oPrint:Say(nLinIni+2835, 0000, PADC(cMensg33,140), oFont10n)
oPrint:Say(nLinIni+2870, 0000, PADC(cMensg35,140), oFont10n)

Return(nLin)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFun…o    ณChkPerg   ณ Autor ณ Nereu Humberto Junior ณ Data ณ21/09/07  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณ Funcao para buscar as perguntas que o usuario nao pode     ณฑฑ
ฑฑณ          ณ alterar para impressao de relatorios direto do browse      ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณSintaxe   ณ ChkPerg(ExpC1,ExpC2,ExpC3)                                 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametrosณ ExpC1 := Id do usuario                                     ณฑฑ
ฑฑณ          ณ ExpC2 := Grupo de perguntas                                ณฑฑ
ฑฑณ          ณ ExpC2 := Numero da sequencia da pergunta                   ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Uso      ณ MatR110                                                    ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function ChkPerg(cUserId,cGrupo,cSeq)

Local aArea  := GetArea()
Local cRet   := Nil
Local cParam := "MV_PAR"+cSeq

dbSelectArea("SXK")
dbSetOrder(2)
If dbSeek("U"+cUserId+cGrupo+cSeq)
	If ValType(&cParam) == "C"
		cRet := AllTrim(SXK->XK_CONTEUD)
	ElseIf 	ValType(&cParam) == "N"
		cRet := Val(AllTrim(SXK->XK_CONTEUD))
	ElseIf 	ValType(&cParam) == "D"
		cRet := CTOD((AllTrim(SXK->XK_CONTEUD)))
	Endif
Endif

RestArea(aArea)
Return(cRet)


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                                   MUL - T - LOCK                                      บฑฑ
ฑฑฬออออออออออออัอออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบPrograma    ณ R001PERG  ณ Funcao de perguntas                                          บฑฑ
ฑฑฬออออออออออออุอออออออออออฯอออออออออออออออออออออออออออออออออออออออออออัออออออัอออออออออออนฑฑ
ฑฑบAutor       ณ Actual Trend                                          ณ Data ณ  23/10/09 บฑฑ
ฑฑศออออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออฯอออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

Static Function R001PERG(cPerg)

Local aAreaAtu	:= GetArea()
Local aAreaSX1	:= SX1->( GetArea() )

PutSx1(	cPerg, "01", "Do Pedido ?          ","ฟDe Pedido ?            ","From Order ?         ","Mv_ch1", TAMSX3( "C7_NUM"     )[3], TAMSX3( "C7_NUM"     )[1],TAMSX3( "C7_NUM"     )[2], 0,"G","","","","N","Mv_par01","             ","             ","              ","","               ","               ","               ","         ","         ","          ","       ","        ","          ","       ","        ","          ","","","","","","","",{"Informe o numero do pedido inicial     ",""},{""},{""},"")
PutSx1(	cPerg, "02", "At้ o Pedido ?       ","ฟA Pedido ?             ","To Order ?           ","Mv_ch2", TAMSX3( "C7_NUM"     )[3], TAMSX3( "C7_NUM"     )[1],TAMSX3( "C7_NUM"     )[2], 0,"G","","","","N","Mv_par02","             ","             ","              ","","               ","               ","               ","         ","         ","          ","       ","        ","          ","       ","        ","          ","","","","","","","",{"Informe o numero do pedido final       ",""},{""},{""},"")
PutSx1(	cPerg, "03", "A partir da Data ?   ","ฟA Fecha ?              ","From Date ?          ","Mv_ch3", TAMSX3( "C7_EMISSAO" )[3], TAMSX3( "C7_EMISSAO" )[1],TAMSX3( "C7_EMISSAO" )[2], 0,"G","","","","N","Mv_par03","             ","             ","              ","","               ","               ","               ","         ","         ","          ","       ","        ","          ","       ","        ","          ","","","","","","","",{"Informe a data inicial                 ",""},{""},{""},"")
PutSx1(	cPerg, "04", "At้ a Data ?         ","ฟA Fecha ?              ","To Date ?            ","Mv_ch4", TAMSX3( "C7_EMISSAO" )[3], TAMSX3( "C7_EMISSAO" )[1],TAMSX3( "C7_EMISSAO" )[2], 0,"G","","","","N","Mv_par04","             ","             ","              ","","               ","               ","               ","         ","         ","          ","       ","        ","          ","       ","        ","          ","","","","","","","",{"Informe a data final                   ",""},{""},{""},"")
PutSx1(	cPerg, "05", "Somente os novos ?   ","ฟSolo los Nuevos ?      ","Only the new ones ?  ","Mv_ch5","N"                        ,                         1,                         0, 2,"C","","","","N","Mv_par05","Sim          ","Si           ","Yes           ","","Nao            ","No             ","No             ","         ","         ","          ","       ","        ","          ","       ","        ","          ","","","","","","","",{"Deseja imprimir novos pedidos          ",""},{""},{""},"")
PutSx1(	cPerg, "06", "Descricao Produto ?  ","ฟDescripcion Prodc. ?   ","Product Description ?","Mv_ch6","C"                        ,                        10,                         0, 0,"G","","","","N","Mv_par06","             ","             ","              ","","               ","               ","               ","         ","         ","          ","       ","        ","          ","       ","        ","          ","","","","","","","",{"Informe qual descri็ใo do produto      ",""},{""},{""},"")
PutSx1(	cPerg, "07", "Qual Unid. de Med. ? ","ฟCual Unidad de Medida ?","Which Unit of Meas. ?","Mv_ch7", TAMSX3( "C7_UM"      )[3], TAMSX3( "C7_UM"      )[1],TAMSX3( "C7_UM"      )[2], 1,"C","","","","N","Mv_par07","Primaria     ","Primaria     ","Primary       ","","Secundaria     ","Secundaria     ","Secondary      ","         ","         ","          ","       ","        ","          ","       ","        ","          ","","","","","","","",{"Informe qual a unidade medida          ",""},{""},{""},"")
PutSx1(	cPerg, "08", "Imprime ?            ","ฟImprime ?              ","Print ?              ","Mv_ch8","N"                        ,                         1,                         0, 1,"C","","","","N","Mv_par08","Pedido Compra","Pedido Compra","Purchase Order","","Aut. de Entrega","Aut. de Entrega","Delivery Author","         ","         ","          ","       ","        ","          ","       ","        ","          ","","","","","","","",{"Selecione o tipo de impressใo          ",""},{""},{""},"")
PutSx1(	cPerg, "09", "Numero de Vias ?     ","ฟNumero de Vias ?       ","Number of Copies ?   ","Mv_ch9","N"                        ,                         2,                         0, 0,"G","","","","N","Mv_par09","             ","             ","              ","","               ","               ","               ","         ","         ","          ","       ","        ","          ","       ","        ","          ","","","","","","","",{"Imprimir em quantas vias               ",""},{""},{""},"")
PutSx1(	cPerg, "10", "Imprime Pedidos ?    ","ฟImprime Pedidos ?      ","Print Orders ?       ","mv_cha","N"                        ,                         1,                         0, 3,"C","","","","N","Mv_par10","Liberados    ","Aprobados    ","Approved      ","","Bloqueados     ","Bloqueados     ","Blocked        ","Ambos    ","Ambos    ","Both      ","       ","        ","          ","       ","        ","          ","","","","","","","",{"Selecione o tipo de pedido             ",""},{""},{""},"")
PutSx1(	cPerg, "11", "Considera SCs ?      ","ฟConsiderar SCs ?       ","Consider Purc.Req. ? ","Mv_chb","N"                        ,                         1,                         0, 3,"C","","","","N","Mv_par11","Firmes       ","Firmes       ","Confirmed     ","","Previstas      ","Previstas      ","Estimated      ","Ambas    ","Ambas    ","Both      ","       ","        ","          ","       ","        ","          ","","","","","","","",{"Selecione o tipo de solicita็ใo        ",""},{""},{""},"")
PutSx1(	cPerg, "12", "Qual Moeda ?         ","ฟQue Moneda ?           ","Currency ?           ","Mv_chc", TAMSX3( "C7_MOEDA"   )[3], TAMSX3( "C7_MOEDA"   )[1],TAMSX3( "C7_MOEDA"   )[2], 1,"C","","","","N","Mv_par12","Moeda 1      ","Moneda 1     ","Currency 1    ","","Moeda 2        ","Moneda 2       ","Currency 2     ","Moeda 3  ","Moneda 3 ","Currency 3","Moeda 4","Moneda 4","Currency 4","Moeda 5","Moneda 5","Currency 5","","","","","","","",{"Informe a modeda para impressใo        ",""},{""},{""},"")
PutSx1(	cPerg, "13", "Endere็o de Entrega ?","ฟDireccion de Entrega ? ","Delivery Address ?   ","Mv_chd","C"                        ,                        40,                         0, 0,"G","","","","N","Mv_par13","             ","             ","              ","","               ","               ","               ","         ","         ","          ","       ","        ","          ","       ","        ","          ","","","","","","","",{"Informe o endere็o de entrega          ",""},{""},{""},"")
PutSx1(	cPerg, "14", "Lista quais ?        ","ฟQue Lista ?            ","List which ?         ","Mv_che","N"                        ,                         1,                         0, 2,"C","","","","N","Mv_par14","Todos        ","Todos        ","All           ","","Em aberto      ","Pendiente      ","Pending        ","Atendidos","Atendidos","Served    ","       ","        ","          ","       ","        ","          ","","","","","","","",{"Filtra os itens do PC a serem impressos",""},{""},{""},"")

RestArea( aAreaSX1 )
RestArea( aAreaAtu )

Return(cPerg)                       