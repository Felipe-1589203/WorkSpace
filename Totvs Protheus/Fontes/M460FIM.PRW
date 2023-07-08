/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³M460FIM   ºAutor  ³Alexandre Sousa     º Data ³  09/25/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³PE no final da geracao da nota fiscal. Usado para atualizar º±±
±±º          ³as informacoes para expedicao.                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³Especifico MultLocck.                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function M460FIM()

Local _aArea    := GetArea()
Local _aAreaSF2 := SF2->(GetArea())
Local _aAreaSE1 := SE1->(GetArea())
Local _aAreaSCV := SCV->(GetArea())

DbSelectArea("SCV")
SCV->(DbSetOrder(2))

DbSelectArea("SE1")
SE1->(DbSetOrder(2))
SE1->(DbSeek( xFilial("SE1") + SF2->F2_CLIENTE + SF2->F2_LOJA + SF2->F2_PREFIXO + SF2->F2_DUPL ) )
While SE1->E1_CLIENTE == SF2->F2_CLIENTE .And. SE1->E1_LOJA == SF2->F2_LOJA .And. SE1->E1_TIPO == "NF " .And.;
	SE1->E1_PREFIXO == SF2->F2_PREFIXO .And. SE1->E1_NUM  == SF2->F2_DUPL .And. SE1->(!Eof())
	
	If SCV->(DbSeek( xFilial("SCV") + SC5->C5_NUM + ALLTRIM(SE1->E1_PARCELA )))
		RecLock("SE1",.F.)
		SE1->E1_XTPPAG := SCV->CV_FORMAPG
		MsUnLock()
	EndIf                                                                
	
	SE1->(DbSkip())                                                              
End-While

RestArea(_aArea)
RestArea(_aAreaSF2)
RestArea(_aAreaSE1)
RestArea(_aAreaSCV)

U_MFATA004(SC5->C5_NUM)

Return()