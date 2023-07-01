/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³M410STTS  ºAutor  ³Alexandre Sousa     º Data ³  20/08/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³PE para gravacao de campos customizados apos a geracao      º±±
±±º          ³do Pedido de vendas.                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³Especifico MUL-T-LOCK                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function M410STTS()                                                                         
                                                          
Local _aAreaOLD := GetArea()                                                                            
Local _aAreaSC9 := SC9->(GetArea())         
                                                                 
If !(!Empty(M->C5_LIBEROK) .And. Empty(M->C5_NOTA) .And. Empty(M->C5_BLQ) ) // Pedido de vendas nao liberado
	RecLock("SC5", .F.)                             
	M->C5_XSITPM := ''
	MsUnLock()
EndIf                                                                              

DbSelectArea("SC9")
DbSetOrder(2)//C9_FILIAL, C9_CLIENTE, C9_LOJA, C9_PEDIDO, C9_ITEM, R_E_C_N_O_, D_E_L_E_T_
If DbSeek(xFilial("SC9")+M->C5_CLIENTE+M->C5_LOJACLI+M->C5_NUM)
	While SC9->C9_FILIAL == xFilial("SC9") .And. SC9->C9_CLIENTE == M->C5_CLIENTE .And. SC9->C9_LOJA ==  M->C5_LOJACLI .And. SC9->C9_PEDIDO == M->C5_NUM .And. SC9->(!Eof())

		RecLock("SC9", .F.)
		SC9->C9_XORIGEM	:= M->C5_XORIGEM
		SC9->C9_XFATURA	:= M->C5_XFATURA
		SC9->C9_XPM		:= M->C5_XTTPPED
		MsUnLock()             
		
		SC9->(DbSkip())                                           
	End-While                                      
EndIf
                                                                                         
RestArea(_aAreaOLD)
RestArea(_aAreaSC9)

Return .T.