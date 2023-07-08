#include "Protheus.ch"

//aulas leitura de erro


User Function VerErros()
	Local nNumero := ""
	Local aArray  := {{1,2,3},{1,3,2}}
	Local cNumero := 1
    Local lTeste  := .T.
   


	If Val(nNumero) >= 0
		MsgAlert("NUMERO")
	ENDIF


	If aArray[2,2] == 3
		MsgAlert(cValToChar("ARRAY"))
	ENDIF

	If  cNumero > 0
		MsgAlert("TEXTO")
	ENDIF

	If lTeste == .T.
		MsgAlert("BOLEANO")
	ENDIF





RETURN
