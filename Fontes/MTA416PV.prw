/*
User Function MTA416PV()
Local nAux := PARAMIXB      //Numero da linha do aCols 
//1-CK_ITEM 2-CK_PRODUTO 3-CK_DESCRI 4-CK_UM 5-CK_QTDVEN 6-CK_PRCVEN 7-CK_VALOR

DbSelectArea("SCK") 
DbSetOrder(1)
If DbSeek(xFilial("SCK")+SCJ->CJ_NUM+_aCols[nAux][1]) 
	nQtdEnt := SCK->CK_XQTDENT //Quantidade Atendida
	nQtdVen := SCK->CK_QTDVEN  //Quantidade Orcada
	
	nQtdSol := _aCols[nAux][5] //Quantidade Efetivada/Solicitada
	
	nTotQtd := nQtdEnt + nQtdSol
	                       
	If nTotQtd <= nQtdVen
		RecLock("SCK",.F.)
		SCK->CK_XQTDENT := nTotQtd
		MsUnlock()
	else
		MsgAlert("Quantidade solicitada ultrapassa o total orçado.")	
	EndIf	

EndIf                    

Return Nil
  */
User Function MT416FIM()

DbSelectArea("SCK")
DbSetOrder(1)

DbSelectArea("SC6") 
DbSetOrder(1)
If DbSeek(xFilial("SC6")+M->C5_NUM)
	While SC6->(!EOF()) .And. SC6->C6_NUM == M->C5_NUM
		If SCK->(DbSeek(xFilial("SCK")+SCJ->CJ_NUM+SC6->C6_ITEM))
			nQtdEnt := SCK->CK_XQTDENT //Quantidade Atendida
			nQtdVen := SCK->CK_QTDVEN  //Quantidade Orcada
			
			nQtdSol := SC6->C6_QTDVEN //Quantidade Efetivada/Solicitada
			
			nTotQtd := nQtdEnt + nQtdSol 
			
			If nTotQtd <= nQtdVen
				RecLock("SCK",.F.)
				SCK->CK_XQTDENT := nTotQtd
				MsUnlock()               
			    If nTotQtd == nQtdVen
			    	lEncerra := .T.
			    else	
					RecLock("SCJ",.F.)
					SCJ->CJ_STATUS := "A"
					MsUnlock()           
				EndIf
			else
				MsgAlert("Quantidade solicitada ultrapassa o total orçado.")	
			EndIf		
		EndIf
		SC6->(DbSkip())
	EndDo	
EndIf                                                   

Return Nil