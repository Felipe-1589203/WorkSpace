#INCLUDE "TOPCONN.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MT410ACE  ºAutor  ³Alexandre Sousa     º Data ³  12/13/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Valida a inclusao de pedidos na empresa CONTAR.             º±±
±±º          ³Se o estoque estiver negativo nao sera permitido incluir.   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³Especifico MULTLOCK.                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MT410ACE()

	Local c_query := ''
	Local n_qtdrg := 0
	Local c_prod  := ''
	Local a_Area  := SC5->(GetArea())

	If SM0->M0_CODIGO <> '03'
		Return .T.
	EndIf

	DbSelectArea("SC5")
	DbSetOrder(2) //C5_FILIAL, C5_EMISSAO, C5_NUM, R_E_C_N_O_, D_E_L_E_T_
	If DbSeek(xFilial("SC5")+dtos(dDataBase))
		RestArea(a_Area)
		Return .T.
	EndIf

	c_query := " select * from ("
//	c_query += " select     D2_COD, sum(D2_QUANT) as QTD_ENT, sum(D1_QUANT) as QTD_SAI, sum(D2_QUANT) + sum(B9_QINI) - sum(D1_QUANT) as DIFF"
	c_query += " select     D2_COD, sum(D2_QUANT) as QTD_SAI, sum(D1_QUANT) as QTD_ENT, (sum(B9_QINI) + sum(D1_QUANT)) - sum(D2_QUANT) as DIFF"
	c_query += " from       SD2030 "
	c_query += " inner join SD1030 "
	c_query += " on         D2_COD = D1_COD"
	c_query += " and        SD1030.D_E_L_E_T_ <> '*'"
	c_query += " left join  SB9030"
	c_query += " on         B9_COD = D2_COD"
	c_query += " and        B9_DATA = ''"
	c_query += " and        SB9030.D_E_L_E_T_ <> '*'"
	c_query += " where      SD2030.D_E_L_E_T_ <> '*'"
	c_query += " group by   D2_COD"
	c_query += " ) A        where DIFF < 0"

	If Select("QRY") > 0
		DbSelectArea("QRY")
		DbCloseArea()
	EndIf
	
	TcQuery c_Query New Alias "QRY"

	While QRY->(!EOF())
		n_qtdrg++
		c_prod := QRY->D2_COD
		QRY->(DbSkip())
	EndDo

	If n_qtdrg > 0
		FINAL("Não será possível incluir pedidos enquanto houverem itens negativos!", "no estoque! Produto: " + c_prod)
	EndIf
	
	RestArea(a_Area)

Return .T.