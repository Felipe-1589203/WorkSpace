/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³M410LIOK  ºAutor  ³Alexandre Sousa     º Data ³  08/24/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³PE no final da validacao da linha do pedido de vendas.      º±±
±±º          ³Usado para validar a alteracao da PM aglutinada.            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³Especifico MULTLOCK.                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function M410LIOK()
           
Local aAreaAtu   := GetArea()
Local n_x
Local l_Ret		:= .T.
Local n_posloc	:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_LOCAL"})
Local n_posPRD	:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_PRODUTO"})
Local n_posIte	:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_ITEM"})
Local n_posQtd	:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_QTDVEN"})
Local n_posOP	:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_NUMOP"})
Local n_posEnd	:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_LOCALIZ"})
Local n_posTES	:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_TES"})

Local c_locdest	:= SuperGetMV("MV_XARMTR")    
Local cTesSol   := GetMv("MV_XTESSOL")	  
Local cUserOP := GetMV("MV_XUSPVOP")	 

DbSelectArea("SB1")
DbSetOrder(1)
If DbSeek(xFilial("SB1")+aCols[n,n_PosPRD])
	If Empty(aCols[n,n_PosEnd])
		If SB1->B1_LOCALIZ == "S"
			l_Ret := .T. // Alterado para true para nao exibir a mensagem abaixo que esta comentada.
		EndIf 
	EndIf
	If !(__cuserid $ AllTrim(cUserOP))
		If !Empty(aCols[n,n_PosTES])
			DbSelectArea("SF4")
			DbSetOrder(1)
			If DbSeek(xFilial("SF4")+aCols[n,n_PosTES])
				If SB1->B1_IPI > 0 // Aliquota maior que zero significa que produto possui calculo de IPI
					If SF4->F4_CTIPI == '52' //.Or. SF4->F4_CTIPI == '53' // 52 - Saida Isenta / 53 - Saida Nao Tributada
						l_Ret := .F.
						Msgalert("Esse produto possui alíquota de IPI cadastrada. Deverá ser utilizado TES com tributação de IPI. Consulte o Dpto. Fiscal.")
					EndIf 
				else
					If SF4->F4_CTIPI == '50'  // 50 - Saida tributada
						l_Ret := .F.
						Msgalert("Esse produto não possui alíquota de IPI cadastrada. Deverá ser utilizado TES sem tributação de IPI. Consulte o Dpto. Fiscal.")
					EndIf	
				EndIf
			EndIf
		EndIf	  
	EndIf	
EndIf 

/*
If !l_Ret	
	msgAlert("Campo Endereco em branco ou preencuido incorretamente", "A T E N Ç Ã O - VERIFICAR ENDERECO")   
	Return .F.
EndIf     
*/

If l_Ret

	If ((aCols[n, n_posTes] $ cTesSol) .and. M->C5_TIPOCLI <> "S")
		l_Ret := .T.                                              
		msgAlert("Verifique se esta Utilizando o TES Corretamente para geração de ICMS-ST!", "A T E N Ç Ã O")
	End		   	    

	
	For n_x := 1 to len(aCols)
		DbSelectArea("SC6")
		DbSetOrder(1) //C6_FILIAL, C6_NUM, C6_ITEM, C6_PRODUTO, R_E_C_N_O_, D_E_L_E_T_
		If DbSeek(xFilial("SC6")+SC5->C5_NUM+aCols[n_x, n_posIte])
			                                                                     
			If (SC6->C6_LOCAL <> c_locdest) 
				Loop
			EndIf
			                                                                    
			If aCols[n_x, len(aHeader)+1]
				l_Ret := .F.
				Exit
			EndIf
			
			If SC6->C6_LOCAL <> aCols[n_x, n_posloc]
				l_Ret := .F.
				Exit
			EndIf
			
			If SC6->C6_PRODUTO <> aCols[n_x, n_posPRD]
				l_Ret := .F.
				Exit
			EndIf
			
			If SC6->C6_QTDVEN <> aCols[n_x, n_posQtd]
				l_Ret := .F.
				Exit
			EndIf                           
			
		EndIf
	Next
	
	If !l_Ret
		msgAlert("Esse item não poderá ser alterado pois foi gerado automaticamente na aglutinação de pedidos especiais!", "A T E N Ç Ã O")
	ElseIf !l_Ret .and. !Empty(aCols[n, n_posOP])
		msgAlert("Esse item não poderá ser alterado pois tem uma ordem de produção amarrada! Verifique com o setor produtivo!", "A T E N Ç Ã O")
		Return .F.
	EndIf  

EndIf
	
RestArea(aAreaAtu)

Return l_Ret