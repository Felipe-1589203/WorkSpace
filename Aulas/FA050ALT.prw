#INCLUDE "rwmake.ch"

//-------------------------------------------------------------------
/*/{Protheus.doc} FA050ALT
@description Ponto de Entrada para validar a Alteração de títulos a Pagar
@author Daniel R. Melo - Actual Trend
@since 12/12/2022
@version 11.8
/*/
//-------------------------------------------------------------------
user function FA050ALT()

	Local lRet := .T.

	// impede a inclusão de um título sem preencher a Conta Contábil
	If lRet .AND. AllTrim(M->E2_TIPO) <> "PA" .and. empty(M->E2_CONTAD)
		apMsgAlert("Favor informar a Conta Contábil para o Lançamento.","Conta Contábil em Branco")
		lRet := .F.
	EndIf

return lRet
