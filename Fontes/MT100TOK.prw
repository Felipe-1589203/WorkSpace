/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MT100TOK  ºAutor  ³Alexandre Sousa     º Data ³  08/06/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³PE durante o OK da prenota - Utilizado para validar os      º±±
±±º          ³valores digitados na pre-nota.                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³Especifico - MultLock.                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MT100TOK()


	Local l_Ret		:= .T.
	Local n_posPd	:= aScan(aHeader, { |x| Alltrim(x[2]) == "D1_PEDIDO" })
	Local n_posIt	:= aScan(aHeader, { |x| Alltrim(x[2]) == "D1_ITEMPC" })
	Local n_postt	:= aScan(aHeader, { |x| Alltrim(x[2]) == "D1_VUNIT" })
	Local n_valtol	:= GetMv("MV_XTLPREV")
    Local c_UF		:= Alltrim(GetAdvFval("SA2", "A2_EST", xFilial("SA2")+M->CA100FOR+M->CLOJA, 1, ' '))

	If c_UF == "EX"
       l_Ret := .T.
    Else
	    For n_x := 1 to len(aCols)
	    	
	    	If !aCols[n_x, len(aHeader)+1]
				If 	empty(aCols[n_x, n_posPd]) .and. empty(aCols[n_x, n_posIt])    	
			    	l_Ret := .T.
	    	    Else
			    	DbSelectArea('SC7')
			    	DbSetOrder(1) //C7_FILIAL, C7_NUM, C7_ITEM, C7_SEQUEN, R_E_C_N_O_, D_E_L_E_T_
			    	If DbSeek(xFilial('SC7')+aCols[n_x, n_posPd]+aCols[n_x, n_posIt])
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³Valor maximo de diferenca no parametro                 ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			    		If aCols[n_x, n_postt] > SC7->C7_PRECO + n_valtol
			    			l_Ret := .F.
			    		EndIf
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³Percentual maximo 5%                                   ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			    		If (((aCols[n_x, n_postt] - SC7->C7_PRECO)/SC7->C7_PRECO)*100) > 100 //Nao pode ser maior que 5% de diferenca...
			    			l_Ret := .F.
			    		EndIf
			    	Else
			    		l_Ret := .F.
			    	EndIf
			    Endif	
		    EndIf
		    
	    Next
	    
	    If !l_Ret 
	    	msgAlert('O pedido de compras está com o valor divergente da NOTA. Verifique os valores do pedido!', "A T E N Ç Ã O")
	    EndIf
	Endif

Return l_Ret