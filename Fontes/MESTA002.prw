#include "rwmake.ch"
#Include "Protheus.ch"                                 
#Include "Topconn.ch" 


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MESTA002  ºAutor  ³Jean Cavalcante     º Data ³  13/12/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Programa para limpar as reservas do SB2, SB8 e SBF         º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Uso especifico MULTLOCK - www.actualtrend.com.br           º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function MESTA002()

Processa({|| ASB2001() },"Processando Reservas do SB2, Aguarde....")
//Processa({|| ASB8002() },"Processando Reservas do SB8, Aguarde....")
Processa({|| ASBF003() },"Processando Reservas do SBF, Aguarde....")

Return



/*BEGINDOC
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Elimina Reservas do SB2³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ENDDOC*/
Static Function ASB2001()

DbSelectarea("SB2")
DbGotop()

ProcRegua(SB2->(Recno()))

While !eof() 

	IncProc("Produto: "+SB2->B2_COD)
	
	If B2_LOCAL != "77"
	   DbSelectarea("SB2")
	   DbSkip()
	   Loop
	Endif
	   	
	If B2_QATU <= 0
	   DbSelectarea("SB2")
	   DbSkip()
	   Loop
	Endif
	
	RecLock("SB2",.F.)
	SB2->B2_QEMP	:= 0
	SB2->B2_QEMPN	:= 0
	SB2->B2_RESERVA	:= 0
	SB2->B2_QPEDVEN	:= 0
	SB2->B2_QTNP	:= 0
	SB2->B2_QNPT	:= 0
	SB2->B2_QTER	:= 0

	MSUNLOCK()
	
	DbSelectarea("SB2")
	DBSkip()
End
Return 



/*BEGINDOC
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Elimina Reservas do SB8³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ENDDOC*/
Static Function ASB8002()

DbSelectarea("SB8")
DbGotop()



ProcRegua(SB8->(Recno()))

While !eof() 

	IncProc("Produto: "+SB8->B8_PRODUTO)
	
	If B8_LOCAL != "77"
	   DbSelectarea("SB8")
	   DbSkip()
	   Loop
	Endif
	   	
	If B8_SALDO <= 0
	   DbSelectarea("SB8")
	   DbSkip()
	   Loop
	Endif
	
	RecLock("SB8",.F.)
	SB8->B8_EMPENHO	:= 0
	MSUNLOCK()
	
	DbSelectarea("SB8")
	DBSkip()
End
Return 


/*BEGINDOC
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Elimina Reservas do SBF³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ENDDOC*/
Static Function ASBF003()

DbSelectarea("SBF")
DbGotop()

SET FILTER TO BF_LOCAL == "77"

ProcRegua(SBF->(Recno()))

While !eof() 

	IncProc("Produto: "+SBF->BF_PRODUTO)
	
	If BF_LOCAL != "77"
	   DbSelectarea("SBF")
	   DbSkip()
	   Loop
	Endif
	   	
	If BF_QUANT <= 0
	   DbSelectarea("SBF")
	   DbSkip()
	   Loop
	Endif
	
	RecLock("SBF",.F.)
	SBF->BF_EMPENHO	:= 0
	MSUNLOCK()
	
	DbSelectarea("SBF")
	DBSkip()
End
Return 