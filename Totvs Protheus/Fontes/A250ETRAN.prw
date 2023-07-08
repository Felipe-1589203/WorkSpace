#INCLUDE "TOPCONN.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³A250ETRAN ºAutor  ³Alexandre Martins   º Data ³  12/11/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º          ³PE apos o apontamento de producao.                          º±±
±±ºDesc.     ³Verifica se o pedido vinculado esta liberado se nao         º±±
±±º          ³libera automaticamente.                                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³Especifico MULTLOCK.                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function A250ETRAN()

	Local c_query := ''
	Local c_ender := ''

	c_ender := GetAdvFval("SB1", "B1_LOCALIZ", xFilial("SB1")+SC2->C2_PRODUTO)

	If c_ender = 'S'
		Return
	EndIf

	If !Empty(SC2->C2_PEDIDO)
		DbSelectArea("SC9")
		DbSetOrder(1) //C9_FILIAL, C9_PEDIDO, C9_ITEM, C9_SEQUEN, C9_PRODUTO, R_E_C_N_O_, D_E_L_E_T_
		If DbSeek(xFilial("SC9")+SC2->(C2_PEDIDO+C2_ITEMPV))
			If SC9->C9_BLEST = '02'
				c_query := "select * from "+RetSqlName("SD3")+" where D3_OP LIKE '"+SC2->(C2_NUM+C2_ITEM+C2_SEQUEN)+"' and D3_ESTORNO = '' and D_E_L_E_T_ <> '*' order by D3_NUMSEQ DESC"
				If Select("QRY") > 0
					DbSelectArea("QRY")
					DbCloseArea()
				EndIf
				TcQuery c_Query New Alias "QRY"
			
				If QRY->(!EOF())
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Forca a liberacao do pedido em vendas.            ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If SC9->C9_QTDLIB  <= QRY->D3_QUANT
						RecLock('SC9', .F.)
						SC9->C9_BLEST = ''
						MsUnLock()
						DbSelectArea("SB2")
						DbSetOrder(1) //B2_FILIAL, B2_COD, B2_LOCAL, R_E_C_N_O_, D_E_L_E_T_
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³Forca a reserva do produto liberado em vendas.    ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						If DbSeek(xFilial("SB2")+QRY->(D3_COD+D3_LOCAL))
							RecLock("SB2", .F.)
							SB2->B2_RESERVA += SC9->C9_QTDLIB
							MsUnLock()
						EndIf
					EndIf
				EndIf
			EndIf
		EndIf
	EndIf

Return