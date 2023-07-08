#include "protheus.ch"
#include "tbiconn.ch"
#include "tbicode.ch"
#INCLUDE "JPEG.ch"
#include "msmgadd.ch"


User Function transacao()
	Local cCliente := "000001"
	Local cLoja    := "01"
	Local cProdut  := "000001"

	RpcSetType(3)
	PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "FAT"

	dbSelectArea("SZ1")

	Begin Transaction
		RecLock("SZ1",.T.)
		SZ1->Z1_FILIAL := xFilial()
		SZ1->Z1_CLIENT := cCliente
		SZ1->Z1_LOJA   := cLoja
		SZ1->Z1_PRODUT := cProdut
		SZ1->Z1_UM	  := "PC"
		SZ1->Z1_UMCLI  := "CX"
		SZ1->Z1_TIPO   := "M"
		SZ1->Z1_FATOR  :=  1
		SZ1->(MsUnlock())
	End Transaction

	BeginTran()
		RecLock("SZ1",.T.)
		SZ1->Z1_FILIAL := xFilial()
		SZ1->Z1_CLIENT := cCliente
		SZ1->Z1_LOJA   := cLoja
		SZ1->Z1_PRODUT := cProdut
		SZ1->Z1_UM	  := "PC"
		SZ1->Z1_UMCLI  := "CX"
		SZ1->Z1_TIPO   := "M"
		SZ1->Z1_FATOR  :=  1
		SZ1->(MsUnlock())
	DisarmTransaction()
	EndTran()
	
	SZ1->(MsUnlockAll())
	RESET ENVIRONMENT
Return

