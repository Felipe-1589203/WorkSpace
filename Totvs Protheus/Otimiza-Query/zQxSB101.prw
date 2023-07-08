#include 'protheus.ch'
#include 'parmtype.ch'

//Constantes
#DEFINE STR_PERG Padr("MDATAPDR",10)
#DEFINE STR_NAME	'SQLSB101' //ZZS_CODE

/*/{Protheus.doc} zQxSB101
//TODO User Function criada para consumir o relatório SQLSB101 da Tabela ZZS
@author Macedo
@since 11/02/2020
@version 1.0
@return ${return}, ${return_description}

@type function
/*/
User Function zQxSB101()
	Local cPerg		:= STR_PERG
	Local cCndcao	:= ""
	
	If !Pergunte(cPerg,.T.)
		Return
	EndIf

	cCndcao := " AND SB1.B1_DATREF BETWEEN " + DtoS(MV_PAR01) + " AND " + DtoS(MV_PAR02) + " "
	
	Processa( {||U_mSQLM5BX(STR_NAME,cCndcao)} , , "Processando a consulta " + STR_NAME  )
	
	
Return
