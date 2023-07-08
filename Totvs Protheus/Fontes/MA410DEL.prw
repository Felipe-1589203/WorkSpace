#INCLUDE "TOPCONN.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMA410DEL  บAutor  ณAlexandre Sousa     บ Data ณ  02/12/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณPonto de entrada durante a exclusao do pedido de vendas     บฑฑ
ฑฑบ          ณUtilizado para excluir os dados da ficha tecnica.           บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณEspecifico MULTLOCK.                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function MA410DEL()

	c_query := "select Z0_PEDIDO, R_E_C_N_O_ as RECZ0 from SZ0010 where D_E_L_E_T_ <> '*' and Z0_PEDIDO not in (select C5_NUM from SC5010 where D_E_L_E_T_ <> '*')"
	If Select("QRY") > 0
		DbSelectArea("QRY")
		DbCloseArea()
	EndIf
	TcQuery c_Query New Alias "QRY"

	While QRY->(!EOF())
		DbSelectArea('SZ0')
		DbGoto(QRY->RECZ0)
		RecLock('SZ0', .F.)
		DbDelete()
		MsUnLock()
		QRY->(DbSkip())
	EndDo

	c_query := "select Z4_PEDIDO, R_E_C_N_O_ as RECZ4 from SZ4010 where D_E_L_E_T_ <> '*' and Z4_PEDIDO not in (select C5_NUM from SC5010 where D_E_L_E_T_ <> '*')"
	If Select("QRY") > 0
		DbSelectArea("QRY")
		DbCloseArea()
	EndIf
	TcQuery c_Query New Alias "QRY"

	While QRY->(!EOF())
		DbSelectArea('SZ4')
		DbGoto(QRY->RECZ4)
		RecLock('SZ4', .F.)
		DbDelete()
		MsUnLock()
		QRY->(DbSkip())
	EndDo

Return