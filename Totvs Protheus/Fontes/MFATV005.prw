#INCLUDE "TOPCONN.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MFATV005  ºAutor  ³Alexandre Sousa     º Data ³  12/11/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Verifica se o pedido de vendas tem alguma OP amarrada       º±±
±±º          ³se tiver nao deixa alterar.                                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³Especifico MULTLOCK.                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MFATV005()
	
	Local c_query := ''
	Local n_qtdrg := 0
	Local c_numOP := ''
	Local a_SC6	  := SC6->(GetArea())
	Local a_SC9	  := SC9->(GetArea())
	Local cUserOP := GetMV("MV_XUSPVOP")

	DbSelectArea("SC6")
	DbSetOrder(1)//C6_FILIAL, C6_NUM, C6_ITEM, C6_PRODUTO, R_E_C_N_O_, D_E_L_E_T_
	If DbSeek(xFilial("SC6")+SC5->C5_NUM)
		While SC6->(!EOF()) .and. SC5->C5_NUM = SC6->C6_NUM
			If !Empty(SC6->C6_NUMOP)
				If !(__cuserid $ AllTrim(cUserOP))
					msgAlert("Não será permitido alterar esse pedido, pois existe uma OP vinculada! OP :" + SC6->C6_NUMOP, "A T E N Ç Ã O")
					Return .F.
				Else
					If !msgYesNo("Esse pedido, possue uma OP vinculada! OP :" + SC6->C6_NUMOP + ". Deseja alterar mesmo assim?", "A T E N Ç Ã O")
						RestArea(a_SC6)
						RestArea(a_SC9)
						Return .F.
					Else
						RestArea(a_SC6)
						RestArea(a_SC9)
						Return .T.
					EndIf
				EndIf
			EndIf
			SC6->(DbSkip())
		EndDo
	EndIf

	c_query := "select * from "+RetSqlName("SC2")+" where D_E_L_E_T_ <> '*' and C2_PEDIDO = '"+SC5->C5_NUM+"'"
	
	If Select("QRY") > 0
		DbSelectArea("QRY")
		DbCloseArea()
	EndIf
	
	TcQuery c_Query New Alias "QRY"

	While QRY->(!EOF())
		n_qtdrg++
		c_numOP := QRY->C2_NUM
		QRY->(DbSkip())
	EndDo

	If !(__cuserid $ AllTrim(cUserOP))
		If n_qtdrg > 0
			msgAlert("Não será permitido alterar esse pedido, pois existe uma OP vinculada! OP :" + c_numOP, "A T E N Ç Ã O")
			RestArea(a_SC6)
			RestArea(a_SC9)
			Return .F.
		EndIf
	Else
		If n_qtdrg > 0
			If !msgYesNo("Esse pedido, possue uma OP vinculada! OP :" + c_numOP + ". Deseja alterar mesmo assim?", "A T E N Ç Ã O")
				RestArea(a_SC6)
				RestArea(a_SC9)
				Return .F.
			EndIf
		EndIf
	EndIf
    
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Verifica tambem se existe algum item liberado pelo credito                              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DbSelectArea('SC9')
	DbSetOrder(1) //C9_FILIAL, C9_PEDIDO, C9_ITEM, C9_SEQUEN, C9_PRODUTO, R_E_C_N_O_, D_E_L_E_T_
	If DbSeek(xFilial('SC9')+SC5->C5_NUM)
		While SC9->(!EOF()) .and. SC9->C9_PEDIDO == SC5->C5_NUM
			If Empty(SC9->C9_BLCRED)
				msgAlert('Esse pedido não poderá ser alterado, pois já foi efetuada a liberação de crédito. Atualize a liberação através da rotina "NOVA LIBERAÇÃO" em liberação de estoque!', 'A T E N Ç Ã O ! ! !')
				RestArea(a_SC6)
				RestArea(a_SC9)
				Return .F.
			EndIf
			SC9->(DbSkip())
		EndDo
	EndIf
	
	RestArea(a_SC6)
	RestArea(a_SC9)

Return .T.