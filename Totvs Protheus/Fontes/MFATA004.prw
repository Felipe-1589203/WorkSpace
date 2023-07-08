/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMFATA004  บAutor  ณAlexandre Sousa     บ Data ณ  09/22/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGrava as informacoes do pedido e da nota quando existem     บฑฑ
ฑฑบ          ณna tabela SZ2 de expedicao.                                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณEspecifico MULTLOCK.                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function MFATA004(c_pedido)
	
	Local a_area	:= GetArea()
	Local a_sc5		:= SC5->(GetArea())
	Local a_sc6		:= SC6->(GetArea())
	Local a_sd2		:= SD2->(GetArea())
	Local a_sc9		:= SC9->(GetArea())
	Local l_entrou	:= .F.

	c_ped1 := Iif (c_pedido = nil, '', c_pedido)
	
	If Empty(c_ped1)
		Return .F.
	EndIf

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณVerifica primeiro os itens que ja tem nota para depois se o pedido ainda estiver em aberto colocar o outro ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	MntQry(c_ped1)
    
	While QRY->(!EOF())

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณVerifica se a nota ja foi liberada em credito e estoque.ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If QRY->C5_XTTPPED = 'S' .or. !Empty(QRY->D2_DOC)
			DbSelectArea("SF4")
			DbSetOrder(1)
			DbSeek(xFilial("SF4")+QRY->D2_TES)
			If (SF4->F4_ESTOQUE = 'S' .and. QRY->C6_LOCAL = '01') .or. QRY->C5_XTTPPED = 'S'
				DbSelectArea("SZ2")
				DbSetOrder(1) //Z2_FILIAL, Z2_PEDIDO, Z2_DOC, Z2_SERIE, R_E_C_N_O_, D_E_L_E_T_
				If !DbSeek(xFilial("SZ2")+QRY->(C6_NUM+D2_DOC+D2_SERIE))
					RecLock("SZ2", .T.)
					SZ2->Z2_FILIAL	:= xFilial("SZ2")
					SZ2->Z2_PEDIDO	:= QRY->C5_NUM
					SZ2->Z2_DOC		:= QRY->D2_DOC
					SZ2->Z2_SERIE	:= QRY->D2_SERIE
					SZ2->Z2_CLIENTE	:= QRY->C6_CLI
					SZ2->Z2_LOJA	:= QRY->C6_LOJA
					If QRY->C5_TIPO = 'N'
						SZ2->Z2_NOMECLI	:= GetAdvFval("SA1", "A1_NOME", xFilial("SA1")+QRY->(C6_CLI+C6_LOJA), 1, ' ')
					Else
						SZ2->Z2_NOMECLI	:= GetAdvFval("SA2", "A2_NOME", xFilial("SA2")+QRY->(C6_CLI+C6_LOJA), 1, ' ')
					EndIf
					SZ2->Z2_TRANSP 	:= QRY->C5_TRANSP
					SZ2->Z2_DESCTRA	:= GetAdvFval("SA4", "A4_NOME", xFilial("SA4")+QRY->(C5_TRANSP), 1, ' ')
					SZ2->Z2_STATUS	:= 'P'
					MsUnLock()
				Else
					RecLock("SZ2", .F.)
					SZ2->Z2_DOC		:= QRY->D2_DOC
					SZ2->Z2_SERIE	:= QRY->D2_SERIE
					MsUnLock()
				EndIf
			EndIf
		EndIf
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณVerifica o status do pedido e atualiza se for necessario.           ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		DbSelectArea("SC5")
		DbSetOrder(1)//C5_FILIAL, C5_NUM, R_E_C_N_O_, D_E_L_E_T_
		If DbSeek(xFilial("SC5")+QRY->C5_NUM)
			If SC5->C5_XTTPPED = 'S'
				RecLock("SC5", .F.)
				SC5->C5_XSITPM := 'A'
				MsUnLock()
			EndIf
		EndIf

		l_entrou := .T.
				
		QRY->(DbSkip())
	EndDo	
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณVerifica se os itens a faturar estao com as infomacoes atualizadas. ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	DbSelectArea("SC9")
	DbSetOrder(1)//C9_FILIAL, C9_PEDIDO, C9_ITEM, C9_SEQUEN, C9_PRODUTO, R_E_C_N_O_, D_E_L_E_T_
	If DbSeek(xFilial("SC9")+c_ped1)
		DbSelectArea("SC5")
		DbSetOrder(1)
		DbSeek(xFilial("SC5")+c_ped1)
		While SC9->(!EOF()) .and. SC9->C9_PEDIDO == c_ped1
			RecLock("SC9", .F.)
			SC9->C9_XORIGEM	:= SC5->C5_XORIGEM
			SC9->C9_XFATURA	:= SC5->C5_XFATURA
			SC9->C9_XPM		:= SC5->C5_XTTPPED
			MsUnLock()
			SC9->(DbSkip())
		EndDo
	EndIf

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณVerifica se deve continuar no browse da expedicao.                  ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If !l_entrou
		DbSelectArea("SZ2")
		DbSetOrder(1) //Z2_FILIAL, Z2_PEDIDO, Z2_DOC, Z2_SERIE, R_E_C_N_O_, D_E_L_E_T_
		If DbSeek(xFilial("SZ2")+c_ped1)
			RecLock("SZ2", .F.)
			DbDelete()
			MsUnLock()
		EndIf
	EndIf
	
	RestArea(a_sc5)
	RestArea(a_sc6)
	RestArea(a_sd2)
	RestArea(a_sc9)
	RestArea(a_area)

Return .T.
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMntQry    บAutor  ณAlexandre Sousa     บ Data ณ  09/24/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณVerifica os dados do pedido para inclusao na SZ2.           บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function MntQry(c_npd)

	Local c_query := ''

	c_query := " select     distinct C5_TIPO, C5_NUM, C6_NUM, C6_CLI, C6_LOJA, C6_LOCAL, D2_DOC, D2_SERIE, D2_TES, C5_TRANSP, C5_XTTPPED, C5_XORIGEM, C5_XFATURA"
	c_query += " from       "+RetSqlName("SC6")+" SC6"
	c_query += " left join  "+RetSqlName("SD2")+" SD2"
	c_query += " on         D2_PEDIDO = C6_NUM"
	c_query += " and        D2_ITEMPV = C6_ITEM"
	c_query += " and        SD2.D_E_L_E_T_ <> '*'"
	c_query += " inner join "+RetSqlName("SC5")+" SC5"
	c_query += " on         C5_NUM = C6_NUM"
	c_query += " and        SC5.D_E_L_E_T_ <> '*'"
	c_query += " inner join "+RetSqlName("SC9")+" SC9"
	c_query += " on         C9_PEDIDO = C6_NUM"
	c_query += " and        C9_ITEM   = C6_ITEM"
	c_query += " and        SC9.D_E_L_E_T_ <> '*'"
	c_query += " and        (C9_BLEST = '' or C9_BLEST = '10')"
	c_query += " and        (C9_BLCRED = '' or C9_BLCRED = '10')"
	c_query += " where      SC6.D_E_L_E_T_ <> '*'"
	c_query += " and        C6_NUM = '"+c_npd+"'"
	c_query += " order by   C6_NUM, D2_DOC desc"

	If Select("QRY") > 0
		DbSelectArea("QRY")
		DbCloseArea()
	EndIf

	dbUseArea( .T., "TOPCONN", TcGenQry(,,c_Query), "QRY", .T., .F. )

Return