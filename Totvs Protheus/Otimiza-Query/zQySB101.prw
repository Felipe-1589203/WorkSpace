//Includes necessários para compilição e funcionamento da função
#include 'protheus.ch'
#include 'parmtype.ch'

//Constantes pré-definida
#DEFINE STR_PERG Padr("MDATAPDR",10) /* Pergunta SX1 */
#DEFINE STR_NAME	'SQLSB101' /* Nome da consulta = ZZS_CODE */

/*/{Protheus.doc} zQySB101
	User Function criada para consumir o relatório SQLSB101 da Tabela ZZS
@author Macedo
@since 11/02/2020
@version 1.0
/*/
User Function zQySB101()
	Local cPerg		:= STR_PERG
	Local cCndcao	:= ""
	
	/* Chamado a pergunta dentro de um IF */
	If !Pergunte(cPerg,.T.)
		/* Caso o usuário cancele, a rotina encerra */
		Return
	EndIf
	
	/* Informo os parâmetros complementares utilizando os dados inseridos via pergunta SX1 */
	cCndcao := " AND SB1.B1_DATREF BETWEEN " + DtoS(MV_PAR01) + " AND " + DtoS(MV_PAR02) + " "
	
	/* Chamo a rotina principal que desejo utilizar passando os dois parâmetros necessários */
	Processa( {||U_mSQLM5TR(STR_NAME,cCndcao)} , , "Processando a consulta " + STR_NAME  )
	
Return