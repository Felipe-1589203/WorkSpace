/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MTA450T   ºAutor  ³Alexandre Sousa     º Data ³  08/18/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³PE final da liberacao manual de credidto.                   º±±
±±º          ³Utilizado para atualizar status de pedido especial.         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³Especifico MultLock.                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MTA450LIB()

	Local lRet 	 := .F.
	Local l_bloq := .F.
	Local a_Area := GetArea()
	Local a_SC9	 := SC9->(GetArea())

	DbSelectArea("SC5")
	DbSetOrder(1) //C5_FILIAL, C5_NUM, R_E_C_N_O_, D_E_L_E_T_
	DbSeek(xFilial("SC5")+SC9->C9_PEDIDO)

	DbSelectArea("SC9")
	DbSetOrder(1)//C9_FILIAL, C9_PEDIDO, C9_ITEM, C9_SEQUEN, C9_PRODUTO, R_E_C_N_O_, D_E_L_E_T_
	If DbSeek(xFilial("SC9")+SC5->C5_NUM)
		RecLock("SC9", .F.)
		SC9->C9_XORIGEM	:= SC5->C5_XORIGEM
		SC9->C9_XFATURA	:= SC5->C5_XFATURA
		SC9->C9_XPM		:= SC5->C5_XTTPPED
		MsUnLock()
	EndIf

	While !EOF() .AND. XFilial("SC9") == SC9->C9_FILIAL .AND. SC9->C9_PEDIDO == SC5->C5_NUM

		IF !EMPTY(SC9->C9_BLEST)
			l_bloq := .T.
			Exit
		Endif
		IF !EMPTY(SC9->C9_BLEST)
			l_bloq := .T.
			Exit
		Endif

		DbSelectarea("SC9")
		DbSkip()
	EndDo
	
	If !l_bloq .and. SC5->C5_XTTPPED = 'S'
		RecLock("SC5", .F.)
		SC5->C5_XSITPM := 'A'
		MsUnLock()
	EndIf

	U_MFATA004(SC5->C5_NUM)

    lRet := .T.

	RestArea(a_Area)
	RestArea(a_SC9)

Return(lRet)