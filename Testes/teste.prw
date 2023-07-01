#INCLUDE 'Protheus.ch'
#INCLUDE 'Rwmake.ch'
#INCLUDE 'Topconn.ch'
#INCLUDE 'Totvs.ch'
#include "tbiconn.ch"

User Function exerc4()
	Local aFone := {}
	Local nP    := 0
	Local cRet  := ""

	AADD(aFone,{"SP","11"})
	AADD(aFone,{"RJ","21"})
	AADD(aFone,{"MG","31"})
	AADD(aFone,{"AM","91"})
	AADD(aFone,{"BA","71"})
	nP := aScan(aFone,{|x|x[1]== M->A1_EST})

	If nP <> 0
		cRet := aFone[nP][2]
	EndIf

Return(cRet)



