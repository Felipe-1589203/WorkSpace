#INCLUDE "Protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE "Rwmake.ch"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                              M U L T  -  T  -  L O C K                                บฑฑ
ฑฑฬออออออออออออัอออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบPrograma    ณ MFINR004  ณ Simulador de Factory - Espelho bordero/aditivo de factory    บฑฑ
ฑฑฬออออออออออออุอออออออออออฯอออออออออออออออออออออออออออออออออออออออออออัออออออัอออออออออออนฑฑ
ฑฑบAutor       ณ  Especifico Actual Trend - www.actualtrend.com.br     ณ Data ณ  20/07/10 บฑฑ
ฑฑศออออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออฯอออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

User Function MFINR004()

Local nLin   	  := 100
Local nCol  	  := 100
Local nPagina     := 1
Local nLinIni	  := 090
Local nColIni	  := 080
Local nColFim	  := 3205
Local nLinFim	  := 2200                               
Local nLinMax     := 2120

Private oFont10   := TFont():New("Courier New",10,08,,.F.,,,,.T.,.F.)	//Normal s/negrito
Private oFont10n  := TFont():New("Courier New",10,08,,.T.,,,,.T.,.F.)	//Negrito
Private oFont12   := TFont():New("Courier New",12,10,,.F.,,,,.T.,.F.)	//Normal s/negrito
Private oFont12n  := TFont():New("Courier New",12,10,,.T.,,,,.T.,.F.)	//Negrito

oPrint:= TMSPrinter():New( "Simulador de Factory")
oPrint:Rebuild()
oPrint:SetLandScape()					// Modo paisagem -> SetLandScape() *** Retrato -> SetPortrait()
oPrint:SetPaperSize(9)					// Papel A4

For _n1 := 1 to Len(oSE1Get:aCols)
	If AllTrim(oSE1Get:aCols[_n1, GdFieldPos("TMP_OK",oSE1Get:aHeader)]:CNAME ) == "LBOK"
		If nLin == 100 .Or. nLin >= nLinMax
			nLin := 100
			nLin := R004CABEC(nPagina, nLinIni, nColIni, nColFim, nLinFim, nLin, nCol)
			nPagina++
		EndIf
		
		nxDias     := oSE1Get:aCols[_n1, GdFieldPos("DIAS",oSE1Get:aHeader)]
		nxSaldoTit := oSE1Get:aCols[_n1, GdFieldPos("E1_VALOR",oSE1Get:aHeader)]
		cTipoTitu  := oSE1Get:aCols[_n1, GdFieldPos("E1_XTPPAG",oSE1Get:aHeader)]
		
		nxTotDesag :=  ( nxSaldoTit * ((nPerDesag/30) * nxDias) / 100)
		nxTotComis :=  ( nxSaldoTit * ((nPerComis/30) * nxDias) / 100)
		nxTotCmIOF := (( nxSaldoTit * nPerCmIOF )/100)
		nxTotDupli := nValDupli
		nxTotChequ := IIf(AllTrim(cTipoTitu) == "CH", nValChequ, 0)
		nxTotFinal := nxSaldoTit - (nxTotDesag + nxTotComis + nxTotCmIOF + nxTotDupli + nxTotChequ)
		
		cLinha := oSE1Get:aCols[_n1,04]+" "
		cLinha += oSE1Get:aCols[_n1,05]+" "
		cLinha += oSE1Get:aCols[_n1,06]+"   "
		cLinha += oSE1Get:aCols[_n1,07]+"   "
		cLinha += Dtoc(oSE1Get:aCols[_n1,08])+"   "
		cLinha += Dtoc(oSE1Get:aCols[_n1,18])+"    "
		cLinha += Dtoc(oSE1Get:aCols[_n1,10])+"  "
		cLinha += Transform(oSE1Get:aCols[_n1,11],"@E 9999")+"  "
		cLinha += Transform(nxSaldoTit,"@E 99,999,999.99")+"    "
		cLinha += Transform(nxTotDesag,"@E 99,999,999.99")+"  "
		cLinha += Transform(nxTotComis,"@E 99,999,999.99")+"  "
		cLinha += Transform(nxTotCmIOF,"@E 99,999,999.99")+"  "
		cLinha += Transform(nxTotDupli,"@E 99,999,999.99")+"  "
		cLinha += Transform(nxTotChequ,"@E 99,999,999.99")+"    "
		cLinha += Transform(nxTotFinal,"@E 99,999,999.99")+"  "
		
		oPrint:Say(nLin, nCol, cLinha , oFont10)
		nLin += 040
	EndIf
Next _n1

If nPagina > 0
	If nLin >= nLinMax .Or. nLin > 1980
		nLin := 100
		nLin := R004CABEC(nPagina, nLinIni, nColIni, nColFim, nLinFim, nLin, nCol)
	EndIf
	
	R004RODAP(nPagina, nLinIni, nColIni, nColFim, nLinFim,nLin, nCol)
EndIf

oPrint:Preview()

Return()

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                              M U L T  -  T  -  L O C K                                บฑฑ
ฑฑฬออออออออออออัอออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบPrograma    ณ R004CABEC ณ Espelho Simulador - Imprime dados do cabecalho               บฑฑ
ฑฑฬออออออออออออุอออออออออออฯอออออออออออออออออออออออออออออออออออออออออออัออออออัอออออออออออนฑฑ
ฑฑบAutor       ณ  Especifico Actual Trend - www.actualtrend.com.br     ณ Data ณ  20/07/10 บฑฑ
ฑฑศออออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออฯอออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

Static Function R004CABEC(nPagina, nLinIni, nColIni, nColFim, nLinFim, nLin, nCol)

If nPagina == 1
	oPrint:StartPage()
	oPrint:Box(nLinIni, nColIni, nLinFim, nColFim)
	
	oPrint:Say(nLinIni+0035, nColIni+0010, "BORDERO : " , oFont10n)
	oPrint:Say(nLinIni+0035, nColIni+0190, Mv_par01     , oFont10n)
	
	oPrint:Say(nLinIni+0100, nColIni+0010,cComboBco     , oFont10n)
	
	// ********************** Resumo de totais
	oPrint:Box(nLinIni+047, nColIni+1740, nLinIni+155, nColFim-030)
	oPrint:Say(nLinIni+0050, nColIni+1990, " ********** T O T A I S **********", oFont12)
	
	oPrint:Say(nLinIni+0100, nColIni+1760, "TARIFAS"      , oFont10n)
	oPrint:Say(nLinIni+0100, nColIni+1910, Transform(nTotTar,"@E 99,999,999.99"), oFont10)
	oPrint:Say(nLinIni+0100, nColIni+2205, "VL BRUTO"     , oFont10n)
	oPrint:Say(nLinIni+0100, nColIni+2370, Transform(nTotBru,"@E 99,999,999.99"), oFont10)
	oPrint:Say(nLinIni+0100, nColIni+2660, "VL LIQUIDO"   , oFont10n)
	oPrint:Say(nLinIni+0100, nColIni+2850, Transform(nTotLiq,"@E 99,999,999.99"), oFont10)
	
	
	// ********************** Resumo de taxas
	oPrint:Box(nLinIni+200, nColIni+05, nLinIni+375, nColIni+750)
	
	oPrint:Say(nLinIni+0210, nColIni+0010, "FLOAT"                                , oFont10n)
	oPrint:Say(nLinIni+0210, nColIni+0435, Transform(nFloat,"@E 9999"), oFont10)
	
	oPrint:Say(nLinIni+0210, nColIni+0800, "TAXA JUROS"                           , oFont10n)
	oPrint:Say(nLinIni+0210, nColIni+1085, Transform(nPerDesag,"@E 999.999999"   ), oFont10)
	oPrint:Say(nLinIni+0210, nColIni+1290, Transform(nTotDesag,"@E 99,999,999.99"), oFont10)
	
	oPrint:Say(nLinIni+0210, nColIni+1590, "COMISSARIA"                           , oFont10n)
	oPrint:Say(nLinIni+0210, nColIni+1875, Transform(nPerComis,"@E 999.999999"   ), oFont10)
	oPrint:Say(nLinIni+0210, nColIni+2080, Transform(nTotComis,"@E 99,999,999.99"), oFont10)
	
	oPrint:Say(nLinIni+0210, nColIni+2380, "ADVALOREN"                            , oFont10n)
	oPrint:Say(nLinIni+0210, nColIni+2665, Transform(nPerLoren,"@E 999.999999"   ), oFont10)
	oPrint:Say(nLinIni+0210, nColIni+2870, Transform(nTotLoren,"@E 99,999,999.99"), oFont10)
	
	
	oPrint:Box(nLinIni+200, nColIni+05, nLinIni+375, nColIni+1535)
	oPrint:Say(nLinIni+0270, nColIni+0010, "IOF"                                  , oFont10n)
	oPrint:Say(nLinIni+0270, nColIni+0295, Transform(nPerIOF  ,"@E 999.999999"   ), oFont10)
	oPrint:Say(nLinIni+0270, nColIni+0500, Transform(nTotIOF  ,"@E 99,999,999.99"), oFont10)
	
	oPrint:Say(nLinIni+0270, nColIni+0800, "COMPL. IOF"                           , oFont10n)
	oPrint:Say(nLinIni+0270, nColIni+1085, Transform(nPerCmIOF,"@E 999.999999"   ), oFont10)
	oPrint:Say(nLinIni+0270, nColIni+1290, Transform(nTotCmIOF,"@E 99,999,999.99"), oFont10)
	
	oPrint:Say(nLinIni+0270, nColIni+1590, "ISS"                                  , oFont10n)
	oPrint:Say(nLinIni+0270, nColIni+1875, Transform(nPerISS  ,"@E 999.999999"   ), oFont10)
	oPrint:Say(nLinIni+0270, nColIni+2080, Transform(nTotISS  ,"@E 99,999,999.99"), oFont10)
	
	oPrint:Say(nLinIni+0270, nColIni+2380, "TARIFA TITULO", oFont10n)
	oPrint:Say(nLinIni+0270, nColIni+2610, Transform(nValDupli,"@E 99,999,999.99"), oFont10)
	oPrint:Say(nLinIni+0270, nColIni+2870, Transform(nTotDupli,"@E 99,999,999.99"), oFont10)
	
	
	oPrint:Box(nLinIni+200, nColIni+05, nLinIni+375, nColIni+2320)
	oPrint:Say(nLinIni+0320, nColIni+0010, "TARIFA CHEQUE"                        , oFont10n)
	oPrint:Say(nLinIni+0320, nColIni+0240, Transform(nValChequ,"@E 99,999,999.99"), oFont10)
	oPrint:Say(nLinIni+0320, nColIni+0500, Transform(nTotChequ,"@E 99,999,999.99"), oFont10)
	
	oPrint:Say(nLinIni+0320, nColIni+0800, "TARIFA TAC"                           , oFont10n)
	oPrint:Say(nLinIni+0320, nColIni+1030, Transform(nValTAC  ,"@E 99,999,999.99"), oFont10)
	oPrint:Say(nLinIni+0320, nColIni+1290, Transform(nTotTAC  ,"@E 99,999,999.99"), oFont10)
	
	oPrint:Say(nLinIni+0320, nColIni+1590, "TARIFA TED"                           , oFont10n)
	oPrint:Say(nLinIni+0320, nColIni+1820, Transform(nValTED  ,"@E 99,999,999.99"), oFont10)
	oPrint:Say(nLinIni+0320, nColIni+2080, Transform(nTotTED  ,"@E 99,999,999.99"), oFont10)
	
	oPrint:Say(nLinIni+0320, nColIni+2380, "TARIFA DOC"                           , oFont10n)
	oPrint:Say(nLinIni+0320, nColIni+2610, Transform(nValDOC  ,"@E 99,999,999.99"), oFont10)
	oPrint:Say(nLinIni+0320, nColIni+2870, Transform(nTotDOC  ,"@E 99,999,999.99"), oFont10)
	
	oPrint:Box(nLinIni+200, nColIni+05, nLinIni+375, nColIni+3120)
	nLin += 420
Else
	oPrint:Box(nLinFim-65, nColIni, nLinFim, nColFim)
	oPrint:Say(nLinIni+2070, nColIni+0010, "EMITIDO EM : "+Dtoc(Date())+" AS "+AllTrim(Time())+" HRS", oFont10)
	oPrint:Say(nLinIni+2070, nColIni+2885, "PAGINA : "+StrZero(nPagina-1,4)                            , oFont10)
	oPrint:EndPage()
	
	oPrint:StartPage()
	oPrint:Box(nLinIni, nColIni, nLinFim, nColFim)
EndIf

oPrint:Say(nLin, nCol+0000, "PRF TITULO    PARC TIPO DT.EMISSAO DT.BORDERO  DT.VENCTO  DIAS          VALOR       TAXA JUROS     COMISSARIA     COMPL. IOF  TARIFA TITULO  TARIFA CHEQUE      VALOR FINAL", oFont10n)
nLin += 050
oPrint:Say(nLin, nCol+0000, "--- --------- ---  ---- ---------- ----------  ---------  ----  -------------    -------------  -------------  -------------  -------------  -------------    -------------", oFont10)
nLin += 050

Return(nLin)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                              M U L T  -  T  -  L O C K                                บฑฑ
ฑฑฬออออออออออออัอออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบPrograma    ณ R004RODAP ณ Espelho Simulador - Imprime dados do rodape                  บฑฑ
ฑฑฬออออออออออออุอออออออออออฯอออออออออออออออออออออออออออออออออออออออออออัออออออัอออออออออออนฑฑ
ฑฑบAutor       ณ  Especifico Actual Trend - www.actualtrend.com.br     ณ Data ณ  20/07/10 บฑฑ
ฑฑศออออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออฯอออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

Static Function R004RODAP(nPagina, nLinIni, nColIni, nColFim, nLinFim, nLin, nCol)

oPrint:Box(nLinFim-190, nColIni+0005, nLinFim-65, nColIni+0500)
oPrint:Box(nLinFim-190, nColIni+0500, nLinFim-65, nColIni+1020)
oPrint:Box(nLinFim-190, nColIni+1020, nLinFim-65, nColIni+1540)
oPrint:Box(nLinFim-190, nColIni+1540, nLinFim-65, nColIni+2070)
oPrint:Box(nLinFim-190, nColIni+2070, nLinFim-65, nColIni+2595)
oPrint:Box(nLinFim-190, nColIni+2595, nLinFim-65, nColIni+3120)

oPrint:Say(nLinIni+1930, nColIni+0165, "AUTOMOTIVO"        , oFont12n)
oPrint:Say(nLinIni+1930, nColIni+0665, "CORPORATIVO"       , oFont12n)
oPrint:Say(nLinIni+1930, nColIni+1220, "VAREJO"            , oFont12n)
oPrint:Say(nLinIni+1930, nColIni+1640, "MUL-T-LOCK CENTER" , oFont12n)
oPrint:Say(nLinIni+1930, nColIni+2145, "ASSITสNCIA TษCNICA", oFont12n)
oPrint:Say(nLinIni+1930, nColIni+2740, "INDUSTRIAL"        , oFont12n)

oPrint:Say(nLinIni+1990, nColIni+0020, Transform(nTarAutom,"@E 99,999,999.99"), oFont10)
oPrint:Say(nLinIni+1990, nColIni+0270, Transform(nVlrAutom,"@E 99,999,999.99"), oFont10)

oPrint:Say(nLinIni+1990, nColIni+0540, Transform(nTarCorpo,"@E 99,999,999.99"), oFont10)
oPrint:Say(nLinIni+1990, nColIni+0790, Transform(nVlrCorpo,"@E 99,999,999.99"), oFont10)

oPrint:Say(nLinIni+1990, nColIni+1060, Transform(nTarVarej,"@E 99,999,999.99"), oFont10)
oPrint:Say(nLinIni+1990, nColIni+1310, Transform(nVlrVarej,"@E 99,999,999.99"), oFont10)

oPrint:Say(nLinIni+1990, nColIni+1580, Transform(nTarMultl,"@E 99,999,999.99"), oFont10)
oPrint:Say(nLinIni+1990, nColIni+1830, Transform(nVlrMultl,"@E 99,999,999.99"), oFont10)

oPrint:Say(nLinIni+1990, nColIni+2100, Transform(nTarAssis,"@E 99,999,999.99"), oFont10)
oPrint:Say(nLinIni+1990, nColIni+2350, Transform(nVlrAssis,"@E 99,999,999.99"), oFont10)

oPrint:Say(nLinIni+1990, nColIni+2620, Transform(nTarIndus,"@E 99,999,999.99"), oFont10)
oPrint:Say(nLinIni+1990, nColIni+2870, Transform(nVlrIndus,"@E 99,999,999.99"), oFont10)

oPrint:Say(nLinIni+2070, nColIni+0010, "EMITIDO EM : "+Dtoc(Date())+" AS "+AllTrim(Time())+" HRS", oFont10)
oPrint:Say(nLinIni+2070, nColIni+2885, "PAGINA : "+StrZero(nPagina-1,4)                           , oFont10)

oPrint:EndPage()                              

Return()	