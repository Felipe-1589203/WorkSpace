/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MTA410    ºAutor  ³Marcelo Pagliotto   º Data ³  08/20/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Restaura o campo de marcacao para Status do contole de PM  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³Uso Especifio MultiLock                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MTA410()


	Local a_area:= GetArea()
	Local a_sc9 := SC9->(GetArea())
 
	If SC5->C5_XTTPPED == 'S'
		M->C5_XSITPM := ' ' 
	ENDIF

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Garante que bloqueia o pedido novamente a cada alteracao      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
/*	Foi retirado por conta do estorno da reserva do pedido de vendas - o bloqueio sera feito como se tivesse uma op aberta.
	DbSelectArea("SC9")
	DbSetOrder(1) //C9_FILIAL, C9_PEDIDO, C9_ITEM, C9_SEQUEN, C9_PRODUTO, R_E_C_N_O_, D_E_L_E_T_
	If DbSeek(xFilial("SC9")+SC5->C5_NUM)
		While SC9->(!EOF()) .and. C9_PEDIDO == SC5->C5_NUM
			If SC9->C9_BLCRED <> '10' .and. SC9->C9_BLEST <> '10'
				RecLock("SC9", .F.)
				SC9->C9_BLCRED := '01'
				MsUnLock()
			EndIf
			SC9->(DbSkip())
		EndDo
	EndIf
*/
	U_MFATA004(SC5->C5_NUM)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Verifica o valor das parcelas quando usa condição 999            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If INCLUI .OR. ALTERA
		If M->C5_CONDPAG = '999'
			n_valor := M->C5_PARC1+M->C5_PARC2+M->C5_PARC3+M->C5_PARC4+M->C5_PARC5+M->C5_PARC6+M->C5_PARC7+M->C5_PARC8+M->C5_PARC9+M->C5_PARCA
			n_valPed:= 0
			n_postes := aScan(aHeader,{|x| AllTrim(x[2]) == "C6_TES"})
			For n_x := 1 to len(acols)
				If !aCols[n_x, len(aHeader)+1]                                                
					If GetAdvFval("SF4", "F4_DUPLIC", xFilial("SF4")+acols[n_x, n_postes]) = 'S'
						n_valPed += acols[n_x, aScan(aHeader,{|x| AllTrim(x[2]) == "C6_VALOR"})]
					EndIf
				EndIf
			Next
			If n_valor < n_valPed
				msgAlert("Verifique o valor das parcelas, o pedido deve estar configurado com os valores corretos para pagamento!", "A T E N Ç Ã O")
				Return .F.
			EndIf
		EndIf
	EndIf

	RestArea(a_sc9)
	RestArea(a_area)
Return .T.
