#INCLUDE 'Protheus.ch'
#INCLUDE 'tbiconn.ch'
#INCLUDE 'tbicode.ch'


User Function Manipul()
	Local cCliente := "Z1_CLIENTE"
	Local cLoja    := "Z1_LOJA"  
    Local cProd    := "CHUTE01" 
	RpcSetType(3)
	PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "FAT"

	dbSelectArea("SZ1")
	dbSetOrder(1)
	dbGoTop()
	If dbSeek(xFilial()+cCliente+cLoja)
		MsgInfo("Achou!!!")
	Else
		RecLock("SZ1",.T.)
		Z1_FILIAL := xFilial()
		Z1_CLIENT := "000001"
		Z1_LOJA   := "01"
		Z1_PRODUT := "000001"
		Z1_UM     := "PC"
		Z1_UMCLI  := "CX"
		Z1_TIPO   := "M"
		Z1_FATOR  := 1
		MsUnlock()
    EndIf

    dbSelectArea("SA1")
    dbSetOrder(1)   
    iF dbSeek(xFilial()+SZ1->Z1_CLIENT+SZ1->Z1_LOJA)
        MsgInfo("O nome do Cliente e: "+SA1->A1_NOME)
    else
        MsgInfo("Cliente não encontrado!")
    EndIf         

    dbSelectArea("SB1")
    dbSetOrder(1)
    If dbSeek(xFilial("SB1")+cProd)
     MsgInfo(Alltrim("O nome do Produto e: "+SB1->B1_DESC))
    Else
        MsgInfo("O produto não foi encontrado!")
    EndIf
    RESET ENVIRONMENT
Return
