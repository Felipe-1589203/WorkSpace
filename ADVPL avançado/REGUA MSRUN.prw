#include "Protheus.ch"

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} regua processa
regua para relatorios

@author    paulo.bindo
@version   11.3.10.201812061821
@since     21/06/2019
/*/

USER FUNCTION PBMsgRun()
	Local nOpcao := 0
	LOCAL nCnt := 0

	If nOpcao == 1
		MsgInfo("Inclusão efetudada com sucesso!")
	Else
		MsgInfo("Não é permitida a inclusao de um novo vendedor!")
	EndIf

	dbSelectArea("SX1")
	dbGoTop()
	MsgRun("Lendo arquivo, aguarde...","Processando dados",{||dbEval({|x| nCnt++}) })
	MsgInfo("FIM!!!, Total de "+AllTrim(Str(nCnt))+" registros",FunName())
RETURN()
