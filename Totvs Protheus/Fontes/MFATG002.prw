/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMFATG002  บAutor  ณCintia Aquino       บ Data ณ  07/10/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGatilho no digitacao do armazem no pedido de vendas para    บฑฑ
ฑฑบ          ณdigitar armazem 77                                          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณEspecifico MUL-T-LOCK                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

User Function MFATG002()
                                                                   
Local l_Ret	  := .T.                                                                        
Local n_x     := 0
Local n_PosLoc:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_LOCAL"})
Local n_posTES:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_TES"})
Local c_Ret := ''

c_Ret := aCols[n, n_posloc]

If Alltrim(FunName()) == "MATA410"
	
	If M->C5_TIPO = 'N'
		If Empty(M->C5_XPDAGLT) .and. M->C5_XORIGEM <> 'T' .and. c_Ret <> '90'
			For n_x := 1 to len(aCols)
				If aCols[n_x,Len(aHeader)+1] == .F. 
					If aCols[n_x, n_PosLoc] <> '01'
						msgalert("Os produtos devem sair do almoxarifado 01. Verifique o item "+aCols[n_x, 1], "A T E N ว ร O")
						l_Ret := .F.
						Exit
					EndIf                                                     
				EndIf                                      
			Next
		ElseIf M->C5_XPDAGLT = 'S'  .and. c_Ret <> '90'
			For n_x := 1 to len(aCols)                                            
				If aCols[n_x, n_PosLoc] <> '77'                                
					M->C5_XPDAGLT := 'P'            
				EndIf
			Next                                                         
		EndIf

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณVerifica a digitacao do armazem 90                 ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		For n_x := 1 to len(aCols)
			If aCols[n_x,Len(aHeader)+1] == .F. 
				If aCols[n_x, n_PosLoc] = '90' .and. aCols[n_x, n_posTES] <> '569'
					msgalert("Os produtos do almoxarifado 90 devem utilizar a TES 569. Verifique o item "+aCols[n_x, 1], "A T E N ว ร O")
					l_Ret := .F.
					Exit
				EndIf                                                     
			EndIf                                      
		Next

	EndIf                                             
EndIf

Return c_Ret   