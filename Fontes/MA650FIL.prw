/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMA650FIL  บAutor  ณAlexandre Sousa     บ Data ณ  10/07/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณPonto de entrada para filtrar pedidos para geracao de OP.   บฑฑ
ฑฑบ          ณFiltra PM's e pedidos aglutinadores.                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณEspecifico MULTLOCK                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ       
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/                                                     
User Function MA650FIL()      
                                                                                                                                                                                                                   
	Local c_Ret := ''             

	                                                       
	If __cuserid == '000048'
		c_Ret := " substring(C6_PRODUTO, 1, 2) $ 'MK/CV/CM/CC/FM'  "
		c_Ret += " .and. C6_LOCAL <> '77' " 
	 	c_Ret += " .and. Empty(GetAdvFval('SC5', 'C5_XPDAGLT', xFilial('SC5')+C6_NUM, 1, '')) "
	Else
		c_Ret := "(GetAdvFval('SC5', 'C5_XTTPPED', xFilial('SC5')+C6_NUM, 1, '') = 'N' .or. C6_PRODUTO $ 'MK/CM/CV/CC/FM') "
		c_Ret += " .and. C6_LOCAL <> '77' "
		c_Ret += " .and. Empty(GetAdvFval('SC5', 'C5_XPDAGLT', xFilial('SC5')+C6_NUM, 1, '')) "
	EndIf

	// ************ Filtra pedidos com bloqueio de credito para nao gerar OP
	c_Ret += " .And. (GetAdvFval('SC9', 'C9_BLCRED', xFilial('SC9') + C6_NUM + C6_ITEM, 1, '') = ' '  .Or."
   	c_Ret += "        GetAdvFval('SC9', 'C9_BLCRED', xFilial('SC9') + C6_NUM + C6_ITEM, 1, '') = '10' .Or."
	c_Ret += "        GetAdvFval('SC9', 'C9_BLCRED', xFilial('SC9') + C6_NUM + C6_ITEM, 1, '') = 'ZZ' )
	
	// ************ Chamado
	c_Ret += " .And. C6_TES != '569' " 	        
	
Return c_Ret

