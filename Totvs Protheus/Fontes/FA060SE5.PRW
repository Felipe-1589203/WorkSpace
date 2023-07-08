#include "rwmake.ch"
#include "topconn.ch"
#INCLUDE "PROTHEUS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFA060SE5  บAutor  ณGustavo Naconesky   บ Data ณ  07/22/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Ponto de Entrada rotina Transferencias CR - Geracao de     บฑฑ
ฑฑบ          ณ bordero para desconto de duplicatas                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/


User Function FA060SE5()

local aArea	:= GetArea()
local cPict	:= "@E 999,999,999.99"
c_EOL		:= Chr(13)+Chr(10)

If Empty(nTaxaDesc ) .or. nTaxaDesc == 0
    RestArea(aArea)
	Return
Endif                

_cNrBordero := SE5->E5_DOCUMEN 
dDataBor	:= SE5->E5_DATA

cQuery	:= U_QryBordero(_cNrBordero)

TcQuery cQuery New Alias "TRBTIT"
dbSelectArea("TRB") 
dbGoTop()


cQryTot	:= "select count(*) AS QTDTIT, sum(E1_VALOR) AS TOTAL, SUM(PRZMED) AS TOTPRZ, sum(VLRPRES) as TOTVP from ("+cQuery+") as QRY1"
TcQuery cQryTot New Alias "TOTAL"
dbSelectArea("TOTAL")

_nQtdTit	:= TOTAL->QTDTIT
_nValorTot	:= TOTAL->TOTAL
_nPrzMed	:= TOTAL->TOTPRZ / _nQtdTit

TOTAL->(dbCloseArea())

_nTxIof1	:= GetMv("MV_XIOF1") / 100
_nTxIof2	:= GetMv("MV_XIOF2") / 100

//_nPrazoFinal:= _nPrzTotal / _nValorTot + SA6->A6_XFLOAT 
//_nTaxa		:= (SA6->A6_TAXADES / 100 / 30)  * _nPrazoFinal * _nValorTot
_nAdValorem	:= _nValorTot * SA6->A6_XADVAL / 100
_nIOF1		:= _nValorTot * _nTxIof1
_nIOF2		:= _nValorTot * _nTxIof2
_nOutDesp	:= SA6->(A6_XSERASA + A6_XTAC + A6_XFACTED + A6_XTARINS) + (SA6->A6_XTARCOB * _nQtdTit)
                                       
//_nLiquido	:= _nValorTot - _nTaxa - _nAdValorem - _nOutDesp - _nIOF1 - _nIOF2 
_nVlrTaxa	:= (SA6->A6_TAXADES / 100 / 30) * _nPrzMed * _nValorTot
_nLiquido	:= _nValorTot - _nVlrTaxa - _nAdValorem - _nOutDesp - _nIOF1 - _nIOF2 

cMsg	:= "Valor Total: " + Transform(_nValorTot, cPict) + c_EOL
cMsg	+= "Titulos:     " + Transform(_nQtdTit, "@E 99,999,999,999") + c_EOL
cMsg	+= "Valor TED:   " + Transform(_nLiquido, cPict) + c_eol
cMsg	+= "Deseja informar Outros Valores? " + c_eol

If MsgYesNo(cMsg, "Confer๊ncia Valores")
   
	_nDesp		:= 0.00
	_nOutDesp	:= 0.00 
	_nRecompra	:= 0.00
	
	DEFINE MSDIALOG oDlg FROM C(224),C(247) TO C(359),C(581) PIXEL TITLE "Outras Despesas" PIXEL
		
	@ 09, 12 SAY "Outras Despesas: " SIZE 40, 8 OF oDlg PIXEL 
	@ 09, 50 MSGET oEdit var _nDesp Picture "@E 999,999,999.99" SIZE 56, 8 OF oDlg PIXEL
	
	@ 21, 12 SAY "Recompra       : " SIZE 40, 8 OF oDlg PIXEL 
	@ 21, 50 MSGET oEdit var _nRecompra Picture "@E 999,999,999.99" SIZE 56, 8 OF oDlg PIXEL
	
	DEFINE SBUTTON FROM 50, 139 TYPE 1 ENABLE OF oDlg ACTION (nOutDesp:=_nDesp,oDlg:End())
	ACTIVATE MSDIALOG oDlg CENTERED 
	
	_nLiquido	:= _nLiquido - nOutDesp - _nRecompra
	
Endif


RecLock("SE5")
SE5->E5_VALOR	:= _nLiquido
MsUnlock()

DbSelectArea("SZA")
RecLock("SZA",.T.)
	SZA->ZA_NUMBOR		:= _cNrBordero
	SZA->ZA_DATA		:= dDataBor 
	SZA->ZA_QTDTIT		:= _nQtdTit
	SZA->ZA_BANCO		:= SA6->A6_COD
	SZA->ZA_AGENCIA		:= SA6->A6_AGENCIA
	SZA->ZA_NUMCON		:= SA6->A6_NUMCON
	SZA->ZA_TAXADES		:= SA6->A6_TAXADES
	SZA->ZA_FLOAT		:= SA6->A6_XFLOAT
	SZA->ZA_ADVAL		:= SA6->A6_XADVAL
	SZA->ZA_TARCOB		:= SA6->A6_XTARCOB
	SZA->ZA_SERASA		:= SA6->A6_XSERASA
	SZA->ZA_TED			:= SA6->A6_XFACTED
	SZA->ZA_TARINS		:= SA6->A6_XTARINS
	SZA->ZA_OUTROS		:= nOutDesp 
	SZA->ZA_VALTAXA		:= _nVlrTaxa
	SZA->ZA_VLRADVA		:= _nAdValorem
	SZA->ZA_VLRIOF1		:= _nIof1
	SZA->ZA_VLRIOF2		:= _nIof2
	SZA->ZA_PRZMED		:= _nPrzMed
	SZA->ZA_LIQUIDO		:= _nLiquido

SZA->(MsUnlock())

TRBTIT->(DBCLOSEAREA())


RestArea(aArea)
  
Return      




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFA060SE5  บAutor  ณGustavo NAconesky   บ Data ณ  07/22/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Retorna query para rotina e relat๓rio de desconto de       บฑฑ    
ฑฑบ          ณ duplicatas                                                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Multlock                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function QryBordero(_cNrBordero)

c_EOL		:= Chr(13)+Chr(10)

cQuery := "SELECT QRY.*" + c_EOL
cQuery += "	,PRZMED = (PESOMED / QTD / E1_VALOR) + 1" + c_EOL
cQuery += "FROM " + c_EOL
cQuery += "(" + c_EOL
cQuery += "	SELECT EA_NUMBOR " + c_EOL
cQuery += "		, E1_PREFIXO, E1_NUM, E1_PARCELA   " + c_EOL
cQuery += "		, QTD = 1  " + c_EOL 
cQuery += "		, E1_EMISSAO " + c_EOL 
cQuery += "		, EA_DATABOR " + c_EOL
cQuery += "		, E1_VENCREA " + c_EOL
cQuery += "		, E1_VALOR " + c_EOL
//cQuery += "		, PRZMED =  E1_VALOR * (DATEDIFF(DAY, convert(DATETIME,EA_DATABOR,101) , convert(DATETIME,E1_VENCREA,101))) " + c_EOL
cQuery += "		, PESOMED =  E1_VALOR * (DATEDIFF(DAY, convert(DATETIME,EA_DATABOR,101) , convert(DATETIME,E1_VENCREA,101))) 
cQuery += "		, VLRPRES = E1_VALOR * (1-((" +STR(SA6->A6_TAXADES)+ "/30.0) * (DATEDIFF(DAY, convert(DATETIME,EA_DATABOR,101) , convert(DATETIME,E1_VENCREA,101))) / 100)) " + c_EOL
cQuery += "	FROM " +RetSqlName("SEA")+ " AS SEA " + c_EOL
cQuery += "	LEFT JOIN  " +RetSqlName("SE1")+ " AS SE1 " + c_EOL
cQuery += "		ON EA_FILIAL = E1_FILIAL " + c_EOL
cQuery += "		AND EA_PREFIXO = E1_PREFIXO " + c_EOL
cQuery += "		AND EA_NUM = E1_NUM " + c_EOL
cQuery += "		AND EA_PARCELA = E1_PARCELA " + c_EOL
cQuery += "		AND SE1.D_E_L_E_T_='' " + c_EOL
cQuery += "	WHERE EA_NUMBOR = '" +_cNrBordero+ "' " + c_EOL
cQuery += "	AND SEA.D_E_L_E_T_='' " + c_EOL  
cQuery += ") AS QRY" + c_EOL

memowrite("titdesc.sql", cquery)

Return (cQuery)
    
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
	If nHRes == 640	// Resolucao 640x480 (soh o Ocean e o Classic aceitam 640)  
		nTam *= 0.8                                                                
	ElseIf (nHRes == 798).Or.(nHRes == 800)	// Resolucao 800x600                
		nTam *= 1                                                                  
	Else	// Resolucao 1024x768 e acima                                           
		nTam *= 1.28                                                               
	EndIf                                                                         
                                                                                
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ                                               
	//ณTratamento para tema "Flat"ณ                                               
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู                                               
	If "MP8" $ oApp:cVersion                                                      
		If (Alltrim(GetTheme()) == "FLAT") .Or. SetMdiChild()                      
			nTam *= 0.90                                                            
		EndIf                                                                      
	EndIf                                                                         
Return Int(nTam)                                                                
