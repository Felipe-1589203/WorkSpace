#INCLUDE "TOPCONN.CH"
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMFATG001  บAutor  ณCintia Aquino       บ Data ณ  07/10/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGatilho no digitacao da qtde do pedido de vendas para checarบฑฑ
ฑฑบ          ณestoque SB2.                                                บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณEspecifico MUL-T-LOCK                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

User Function MFATG001()
                                                                                                                          
Local _n1
Local _aProd    := {}                                                
Local _nScan    := 0
Local _nQuantid := 0                                           
Local _nEstoque := 0
Local _nPosProd := aScan(aHeader,{|x| AllTrim(x[2]) == "C6_PRODUTO"})
Local _nPosLoca	:= aScan(aHeader,{|x| AllTrim(x[2]) == "C6_LOCAL"  })
Local _nPosQtde	:= aScan(aHeader,{|x| AllTrim(x[2]) == "C6_QTDVEN" })
Local lRet      := .T.

If Alltrim(FunName()) == "MATA410" .And. (INCLUI == .T. .Or. ALTERA == .T.)
	For _n1 := 1 to Len(aCols)
		If aCols[_n1,Len(aHeader)+1] == .F. .and. SubStr(aCols[_n1,_nPosProd],1,2) <> 'MK'
			If (_nScan := aScan(_aProd, { |x,y| x[1]+x[2] == aCols[_n1,_nPosProd] + aCols[_n1,_nPosLoca] }) ) == 0
				aadd(_aProd,{ aCols[_n1,_nPosProd], aCols[_n1,_nPosLoca], aCols[_n1,_nPosQtde] })
			Else
				_aProd[_nScan, 3 ] += aCols[_n1,_nPosQtde]
			EndIf
		EndIf
	Next

		If aCols[n,Len(aHeader)+1] == .F. .and. SubStr(aCols[n,_nPosProd],1,2) <> 'MK'
		c_query := "select sum(C9_QTDLIB) as QTD from SC9010 where C9_PRODUTO = '"+aCols[n,_nPosProd]+"' and D_E_L_E_T_ <> '*' AND C9_NFISCAL = '' and C9_XPM = 'S' and C9_BLCRED <> '06'"
		If Select("QRT") > 0
			DbSelectArea("QRT")
			DbCloseArea()
		EndIf
		//desabilitada a linha abaixo em razao da query gerar uma qtde a ser deduzida sem um motivo que o sr.Andre e eu pudemos identificar [Mauro Nagata, Actual Trend, 06/01/201]
	    //foi consultado o sr.Alexandre, Actual, e tb nao soube informar o motivo da deducao da quantidade [Mauro Nagata, Actual Trend, 06/01/201]
		//dbUseArea( .T., "TOPCONN", TcGenQry(,,c_Query), "QRT", .T., .F. )

		_nQuantid := _aProd[aScan(_aProd, { |x,y| x[1]+x[2] == aCols[n,_nPosProd] + aCols[n,_nPosLoca] }) ][3]
		_nEstoque := GetAdvfVal("SB2","B2_QATU",xFilial("SB2")+ aCols[n,_nPosProd] + aCols[n,_nPosLoca],1,"")
		_nEstoque -= GetAdvfVal("SB2","B2_RESERVA",xFilial("SB2")+ aCols[n,_nPosProd] + aCols[n,_nPosLoca],1,"")
		_nEstoque -= GetAdvfVal("SB2","B2_QACLASS",xFilial("SB2")+ aCols[n,_nPosProd] + aCols[n,_nPosLoca],1,"")
		//desabilitadas as linhas abaixo em razao da query gerar uma qtde a ser deduzida sem um motivo que o sr.Andre e eu pudemos identificar [Mauro Nagata, Actual Trend, 06/01/201]
	    //foi consultado o sr.Alexandre, Actual, e tb nao soube informar o motivo da deducao da quantidade [Mauro Nagata, Actual Trend, 06/01/201]
		//If M->C5_XTTPPED == 'S' .and. QRT->QTD > 0 // PM 
		//_nEstoque -= QRT->QTD
		//EndIf

		If _nQuantid > _nEstoque
			If M->C5_XTTPPED == 'S' // PM
				MsgBox("A quantidade do pedido ้ maior que o estoque disponํvel."+Chr(13)+Chr(10)+"Impossํvel incluir este produto com esta quantidade"+Chr(13)+Chr(10)+;
				       Chr(13)+Chr(10)+"Estoque disponํvel: "+Transform(_nEstoque,"@RE 999,999.99"),"Estoque Disponํvel","ALERT")
				lRet := .F.                        
			Else
				MsgBox("A quantidade do pedido ้ maior que o estoque disponํvel","Estoque Disponํvel"+Chr(13)+Chr(10)+;
				       Chr(13)+Chr(10)+"Estoque disponํvel: "+Transform(_nEstoque,"@RE 999,999.99"),"ALERT")
				lRet := .T.
			EndIf
		EndIf
	EndIf
EndIf

Return(IIf(lRet==.F., aCols[n,_nPosQtde] := 0, aCols[n,_nPosQtde] ))