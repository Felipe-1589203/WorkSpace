#INCLUDE "Protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE "Rwmake.ch"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                                   MUL - T - LOCK                                      บฑฑ
ฑฑฬออออออออออออัอออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบPrograma    ณ FA060QRY  ณ PE usado para buscar dados do Simulador de Factory           บฑฑ
ฑฑฬออออออออออออุอออออออออออฯอออออออออออออออออออออออออออออออออออออออออออัออออออัอออออออออออนฑฑ
ฑฑบAutor       ณ Actual Trend                                          ณ Data ณ  16/11/09 บฑฑ
ฑฑศออออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออฯอออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

User Function FA060QRY()

Local _n1                                                    
Local cQry   := ""
Local cTitul := ""

If AllTrim(FunName())  == "MFINA001"  //Somente se for chamado pelo Simulador de factory
	For _n1 := 1 to Len(oSE1Get:aCols)
		If AllTrim(oSE1Get:aCols[_n1, GdFieldPos("TMP_OK",oSE1Get:aHeader)]:CNAME ) == "LBOK"
			cTitul += oSE1Get:aCols[_n1,4]+oSE1Get:aCols[_n1,5]+oSE1Get:aCols[_n1,6]+oSE1Get:aCols[_n1,7]+oSE1Get:aCols[_n1,15]+oSE1Get:aCols[_n1,16]+"/"
		EndIf
	Next _n1
	cTitul := SubStr(AllTrim(cTitul),1,Len(Alltrim(cTitul))-1)
	
	If !Empty(cTitul)
		cQry += "   E1_PREFIXO||E1_NUM||E1_PARCELA||E1_TIPO||E1_CLIENTE||E1_LOJA IN "+FormatIn(cTitul,"/")                                               
	EndIf
EndIf
                                               
If Empty(cQry)                                        
	cQry += "   D_E_L_E_T_ = ' '"
EndIf

Return(cQry)                               
