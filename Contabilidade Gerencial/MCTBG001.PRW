#INCLUDE "rwmake.ch"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัอออออออออออออออออออออออออออออหออออออัออออออออออปฑฑ
ฑฑบPrograma  ณMCTBG001  บ Autor ณ Marco Aurelio-Actual Trend  บ Data ณ 23/10/09 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯอออออออออออออออออออออออออออออสออออออฯออออออออออนฑฑ
ฑฑบDescricao ณ Gatilho para contabilizacao 								        บฑฑ
ฑฑบ          ณ																    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Especํfico - Multlock                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ                                        
//ณFuncao que Retorna Conta Contabil de Debitoณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
                                                            		
User Function MCTBG61A(c_tipo, c_dado)

	Local l_sai := .T.
	Local a_area := GetArea()

	If c_tipo <> 'X'
		SC5->(DbSetOrder(1))
		If SC5->(DbSeek(xFilial("SC5")+SD2->D2_PEDIDO))
			If c_tipo = SC5->C5_XORIGEM
				l_sai := .F.
			EndIf
		EndIf
		If l_sai
			RestArea(a_area)
			Return .F.
		EndIf
	EndIf
	
	c_Tes	:= GETMV("MV_XLP610A")
	c_ret := iif(SD2->D2_TES $ c_Tes,.T.,.F.)
	
	RestArea(a_area)
Return(c_ret)


User Function MCTBG61B(c_tipo, c_dado)

	Local l_sai := .T.
	Local a_area := GetArea()

	If c_tipo <> 'X'
		SC5->(DbSetOrder(1))
		If SC5->(DbSeek(xFilial("SC5")+SD2->D2_PEDIDO))
			If c_tipo = SC5->C5_XORIGEM
				l_sai := .F.
			EndIf
		EndIf
		If l_sai
			RestArea(a_area)
			Return .F.
		EndIf
	EndIf

	c_Tes	:= GETMV("MV_XLP610B")
	c_ret := iif(SD2->D2_TES $ c_Tes,.T.,.F.)

	RestArea(a_area)
	
Return(c_ret)

User Function MCTBG61C(c_tipo, c_dado)

	Local l_sai := .T.
	Local a_area := GetArea()

	If c_tipo <> 'X'
		SC5->(DbSetOrder(1))
		If SC5->(DbSeek(xFilial("SC5")+SD2->D2_PEDIDO))
			If c_tipo = SC5->C5_XORIGEM
				l_sai := .F.
			EndIf
		EndIf
		If l_sai
			RestArea(a_area)
			Return .F.
		EndIf
	EndIf

	c_Tes	:= GETMV("MV_XLP610C")
	c_ret := iif(SD2->D2_TES $ c_Tes,.T.,.F.)

	RestArea(a_area)
Return(c_ret)

                                                                                 
User Function MCTBG61D(c_tipo, c_dado)

	Local l_sai := .T.
	Local a_area := GetArea()

	If c_tipo <> 'X'
		SC5->(DbSetOrder(1))
		If SC5->(DbSeek(xFilial("SC5")+SD2->D2_PEDIDO))
			If c_tipo = SC5->C5_XORIGEM
				l_sai := .F.
			EndIf
		EndIf
		If l_sai
			RestArea(a_area)
			Return .F.
		EndIf
	EndIf

	c_Tes	:= GETMV("MV_XLP610D")
	c_ret := iif(SD2->D2_TES $ c_Tes,.T.,.F.)

	RestArea(a_area)
Return(c_ret)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMCTBG61E  บAutor  ณAlexandre Sousa     บ Data ณ  11/16/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณVerifica a devolucao de notas de entrada.                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function MCTBG61E()

	c_Tes	:= GETMV("MV_XLP610E")
	c_ret	:= iif(SD2->D2_TES $ c_Tes,.T.,.F.)

Return(c_ret)
