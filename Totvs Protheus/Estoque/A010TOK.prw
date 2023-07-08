#include 'protheus.ch'
#include 'parmtype.ch'

/*/{Protheus.doc} MA010FIL
@description Ponto de Entrada para preencher o custo standard de acordo com o dolar do dia
@author Felipe Souza - Actual Trend
@since 27/10/2022
@version 11.8
/*/

User Function A010TOK()

	Local lExecuta := .T.

	dbSelectArea(SB1)
	dbSetOrder(1)
	dbSeek(xfilial(SB1))
	If lExecuta .and. AllTrim(SB1->B1_GRUPO) == "0900"
		(M->B1_CUSTD := M->B1_B1_XUSD*SM2->M2_MOEDA2*70/100)
		lExecuta := .F.
	EndIf
	dbCloseArea()
return 
