#include "protheus.ch"
#include "tbiconn.ch"
#include "tbicode.ch"
#INCLUDE "JPEG.ch"
#include "msmgadd.ch"
//------------------------------------------------------------------------------------------
/*/{Protheus.doc} ABRESZ1
Manutenção de dados em SB1-Descricao Generica do Produto.

@author    paulo.bindo
@version   11.3.10.201812061821
@since     21/06/2019
/*/

User Function ABRE()	
	RpcSetType(3)
	PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "FAT"

	FILHA()

	RESET ENVIRONMENT
Return


Static Function FILHA()
	Local nx       := 0
	Local aCampos  := {}
	Local aTitulos := {}

	AADD(aCampos,"C5_FILIAL")
	AADD(aCampos,"C5_NUM")

	SX3-> (dbSetOrder(2))

	For nx := 1 to len(aCampos)
		SX3->(dbSeek(aCampos[nX]))
		AADD(aTitulos,AllTrim(SX3->X3_TITULO))
	Next nx


	//mesma coisa de cima com ****aEval****
	aTitulos := {}
	SX3-> (dbGoTop())
	aEval(aCampos,{|x|SX3->(dbSeek(x)),AADD(AtITULOS,AllTrim(SX3->X3_TITULO))})

	RESET ENVIRONMENT

Return ()


