


User Function MT175ATU()
Local lRet   := .T.
Local cAmzCQ := AllTrim(GetMV("MV_CQ"))

DbSelectArea("SB2")
DbSetOrder(1)
If DbSeek(xFilial("SB2")+SD7->D7_PRODUTO+cAmzCQ)
 	RecLock("SB2",.F.)
 	SB2->B2_RESERVA = 0
 	MsUnlock()
EndIf

Return lRet