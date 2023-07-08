/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MFATA009  ºAutor  ³Bruno Parreira      º Data ³  05/17/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para inserir dados na SZ2 atraves da liberacao de    º±±
±±º          ³estoque.                                                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ MULTLOCK                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function MFATA009(cPedido)
                
Local lInclui := .F.                    

MontaQry1(cPedido)

QRY->(DbGoTop())    
If QRY->(!EOF())
    lInclui := .F. 
Else
  	lInclui := .T.
EndIf             
                                                      
If lInclui
	RecLock("SZ2", .T.)
	SZ2->Z2_FILIAL	:= xFilial("SZ2")
	SZ2->Z2_PEDIDO	:= SC5->C5_NUM
	//SZ2->Z2_DOC	:= QRY->D2_DOC
	//SZ2->Z2_SERIE	:= QRY->D2_SERIE
	SZ2->Z2_CLIENTE	:= SC5->C5_CLIENTE
	SZ2->Z2_LOJA	:= SC5->C5_LOJACLI
	If SC5->C5_TIPO = 'N'
		SZ2->Z2_NOMECLI	:= GetAdvFval("SA1", "A1_NOME", xFilial("SA1")+SC5->(C5_CLIENTE+C5_LOJACLI), 1, ' ')
	Else
		SZ2->Z2_NOMECLI	:= GetAdvFval("SA2", "A2_NOME", xFilial("SA2")+SC5->(C5_CLIENTE+C5_LOJACLI), 1, ' ')
	EndIf
	SZ2->Z2_TRANSP 	:= SC5->C5_TRANSP
	SZ2->Z2_DESCTRA	:= GetAdvFval("SA4", "A4_NOME", xFilial("SA4")+SC5->C5_TRANSP, 1, ' ')
	SZ2->Z2_STATUS	:= 'P'
	MsUnLock()	
EndIf

Return    
      
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MFATA010  ºAutor  ³Bruno Parreira      º Data ³  05/17/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para inserir dados na SZ2 atraves da liberacao de    º±±
±±º          ³pedidos.                                                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ MULTLOCK                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function MFATA010(cPedido)
                
Local lInclui := .F.                    

If SC5->C5_TIPO = 'B'
	MontaQry1(cPedido)
	
	QRY->(DbGoTop())    
	If QRY->(!EOF())
	    lInclui := .F. 
	Else
	  	lInclui := .T.
	EndIf             
	                                                      
	If lInclui
		RecLock("SZ2", .T.)
		SZ2->Z2_FILIAL	:= xFilial("SZ2")
		SZ2->Z2_PEDIDO	:= SC5->C5_NUM
		//SZ2->Z2_DOC	:= QRY->D2_DOC
		//SZ2->Z2_SERIE	:= QRY->D2_SERIE
		SZ2->Z2_CLIENTE	:= SC5->C5_CLIENTE
		SZ2->Z2_LOJA	:= SC5->C5_LOJACLI
		If SC5->C5_TIPO = 'N'
			SZ2->Z2_NOMECLI	:= GetAdvFval("SA1", "A1_NOME", xFilial("SA1")+SC5->(C5_CLIENTE+C5_LOJACLI), 1, ' ')
		Else
			SZ2->Z2_NOMECLI	:= GetAdvFval("SA2", "A2_NOME", xFilial("SA2")+SC5->(C5_CLIENTE+C5_LOJACLI), 1, ' ')
		EndIf
		SZ2->Z2_TRANSP 	:= SC5->C5_TRANSP
		SZ2->Z2_DESCTRA	:= GetAdvFval("SA4", "A4_NOME", xFilial("SA4")+SC5->C5_TRANSP, 1, ' ')
		SZ2->Z2_STATUS	:= 'P'
		MsUnLock()	
	EndIf
EndIf
	
Return                                                                                                                             

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MFATA020  ºAutor  ³Bruno Parreira      º Data ³  05/17/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para inserir dados na SZ2 atraves da emissao de NF.  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ MULTLOCK                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function MFATA020(cPedido,cNota,cSerie)

Local lAtualiza := .F.                    
Local nReg := 0 
Local aArea := GetArea()

MontaQry2(cPedido)

QRY->(DbGoTop())    
If QRY->(!EOF())
    lAtualiza := .T. 
    nReg := QRY->R_E_C_N_O_
Else
  	lAtualiza := .F.
EndIf                      
                                                      
If lAtualiza
    DbSelectArea("SZ2")
    DbSetOrder(1)
    SZ2->(DbGoTo(nreg))
	RecLock("SZ2", .F.)
	SZ2->Z2_DOC	  	:= cNota
	SZ2->Z2_SERIE 	:= cSerie
	MsUnLock()	
Else 
	DbSelectArea("SC6")
	DbSetOrder(1)                        
	If DbSeek(xFilial("SC6")+cPedido)
		DbSelectArea("SF4")
		DbSetOrder(1)
		If DbSeek(xFilial("SF4")+SC6->C6_TES)
			If SF4->F4_ESTOQUE = 'S' .or. SC5->C5_TIPO = 'B'
				RecLock("SZ2", .T.)
				SZ2->Z2_FILIAL	:= xFilial("SZ2")
				SZ2->Z2_PEDIDO	:= SC5->C5_NUM
				SZ2->Z2_DOC		:= cNota
				SZ2->Z2_SERIE	:= cSerie
				SZ2->Z2_CLIENTE	:= SC5->C5_CLIENTE
				SZ2->Z2_LOJA	:= SC5->C5_LOJACLI
				If SC5->C5_TIPO = 'N'
					SZ2->Z2_NOMECLI	:= GetAdvFval("SA1", "A1_NOME", xFilial("SA1")+SC5->(C5_CLIENTE+C5_LOJACLI), 1, ' ')
				Else
					SZ2->Z2_NOMECLI	:= GetAdvFval("SA2", "A2_NOME", xFilial("SA2")+SC5->(C5_CLIENTE+C5_LOJACLI), 1, ' ')
				EndIf
				SZ2->Z2_TRANSP 	:= SC5->C5_TRANSP
				SZ2->Z2_DESCTRA	:= GetAdvFval("SA4", "A4_NOME", xFilial("SA4")+SC5->C5_TRANSP, 1, ' ')
				SZ2->Z2_STATUS	:= 'P'
				MsUnLock()		
			EndIf	
		EndIf	
	EndIf	
EndIf
                        
RestArea(aArea)

Return 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MontaQry1 ºAutor  ³Bruno Parreira      º Data ³  05/17/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Query para selecionar os dados dos pedidos da SZ2 que foram º±±
±±º          ³incluidos pela rotina de liberacao.                         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ MULTLOCK                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function MontaQry1(cPedido)
Local cQuery := ''     

cQuery := " Select * from "+RetSqlName("SZ2")+" SZ2 where Z2_PEDIDO = '"+cPedido+"' and Z2_DOC = ' ' and Z2_STATUS = 'P' and D_E_L_E_T_ = ' ' "
//cQuery += " from       "+RetSqlName("SC6")+" SC6"

If Select("QRY") > 0
	DbSelectArea("QRY")
	DbCloseArea()
EndIf

dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "QRY", .T., .F. )    

Return       

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MontaQry2 ºAutor  ³Bruno Parreira      º Data ³  05/17/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Query para selecionar os dados dos pedidos da SZ2 que foram º±±
±±º          ³incluidos pela rotina de liberacao.                         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ MULTLOCK                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function MontaQry2(cPedido)
Local cQuery := ''  

cQuery := " Select * from "+RetSqlName("SZ2")+" SZ2 where Z2_PEDIDO = '"+cPedido+"' and Z2_DOC = ' ' and D_E_L_E_T_ = ' ' "
//cQuery += " from       "+RetSqlName("SC6")+" SC6"

If Select("QRY") > 0
	DbSelectArea("QRY")
	DbCloseArea()
EndIf

dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "QRY", .T., .F. )    

Return