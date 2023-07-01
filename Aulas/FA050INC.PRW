#include 'protheus.ch'
#include 'parmtype.ch'

//-------------------------------------------------------------------
/*/{Protheus.doc} FA050INC
@description Ponto de Entrada para validar a inclusão de títulos a Pagar
@author Daniel R. Melo - Actual Trend
@since 12/12/2022
@version 11.8
/*/
//-------------------------------------------------------------------
user function FA050INC()

	Local lRet := .T.
	// impede a inclusão de um título sem preencher a Conta Contábil
	If lRet .and. AllTrim(M->E2_TIPO) <> "PA" .and. empty(M->E2_CONTAD)
		apMsgAlert("Favor informar a Conta Contábil para o Lançamento.","Conta Contábil em Branco")
		lRet := .F.
	EndIf

return lRet

