/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณM410ALOK  บAutor  ณAlexandre Sousa     บ Data ณ  20/08/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณValida a alteracao do pedido de venda quando ja foi         บฑฑ
ฑฑบ          ณentregue pela rotina de controle de pedidos especiais.      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณEspecifico MultLock                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

User Function M410ALOK()

Local _aAreaOLD := GetArea()                            
Local _aAreaSZ2 := SZ2->(GetArea())
Local a_SC9		:= SC9->(GetArea())
Local a_SC6		:= SC6->(GetArea())
Local a_SC5		:= SC5->(GetArea())
Local l_Ret     := .T.                                                     

If SC5->C5_XTTPPED == 'S' .and. !Empty(C5_NOTA)
	MsgAlert("Esse pedido nใo poderแ ser alterado pois, jแ foi entregue ao cliente pelo controle de pedidos especiais!", "A T E N ว ร O")
	l_Ret := .F.
EndIf

DbSelectArea("SZ2")
DbSetOrder(1) //Z2_FILIAL, Z2_PEDIDO, Z2_DOC, Z2_SERIE, R_E_C_N_O_, D_E_L_E_T_
If DbSeek(xFilial("SZ2")+SC5->C5_NUM)
	If SZ2->Z2_STATUS == 'S'
		MsgAlert("Esse pedido jแ foi separado na expedi็ใo. Nao poderแ ser alterado!", "A T E N ว ร O")
		l_Ret := .F.              	
	EndIf
	If SZ2->Z2_STATUS == 'I'
		MsgAlert("Esse pedido jแ foi impresso na expedi็ใo. Nao poderแ ser alterado!", "A T E N ว ร O")
		l_Ret := .F.              	
	EndIf
EndIf

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณVerifica se existe alguma OP vinculada a esse pedido, se existir nใo permite alterar      ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If !U_MFATV005()
	l_Ret := .F.
EndIf

RestArea(_aAreaSZ2)
RestArea(a_SC9)
RestArea(a_SC6)
RestArea(a_SC5)
RestArea(_aAreaOLD)

Return l_Ret