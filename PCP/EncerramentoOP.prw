#INCLUDE "Protheus.ch"

#DEFINE ENTER CHR(13)+CHR(10)


User Function RPCPA13()

	Local   cSQL := ""
	Private lMsErroAuto := .F.
	Private lMostraErro := .T.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Confirma encerramento	                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nAviso := Aviso( "Atenção","Confirma o encerramento da OP " + SUBSTRING(SBC->BC_OP,1,6) + " ? ", { "Sim", "Não" } )
	If nAviso == 2
		Return
	EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica apontamento da OP                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	SC2->(dbSetorder(1))
	SC2->(dbSeek(xFilial("SC2")+SUBSTRING(SBC->BC_OP,1,6)))

	cSQL := "SELECT * FROM " + RETSQLNAME("SD3") + " WHERE "   +ENTER
	cSQL += "D3_OP      = '" + ALLTRIM(SBC->BC_OP)  + "' AND " +ENTER
	cSQL += "D3_JOFPECA <> '' AND "                            +ENTER
	cSQL += "D3_CF = 'PR0' AND "                               +ENTER
	cSQL += "D3_ESTORNO <> 'S' AND "                           +ENTER
	cSQL += "D_E_L_E_T_ = '' ORDER BY R_E_C_N_O_ DESC"         +ENTER

	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cSQL),"TD3",.F.,.T.)

	If TD3->(Eof())
		Aviso( "Atenção", "A OP não pode ser encerrada pois não existe apontamento de produção. Exclua a OP para encerrar.", { "Sim", "Não" } )
		TD3->(dbCloseArea())
		Return
	EndIf

	TCSETFIELD("TD3","D3_EMISSAO","D",8,0)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Prepara vetor de encerramento                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aEncerra := { { "D3_OP"			, TD3->D3_OP			, NIL },;
		          { "D3_TM" 		, TD3->D3_TM			, NIL },;
		          { "D3_EMISSAO"	, TD3->D3_EMISSAO		, NIL },;
		          { "D3_COD"		, TD3->D3_COD			, NIL },;
		          { "D3_UM"			, TD3->D3_UM			, NIL },;
		          { "D3_LOCAL"		, TD3->D3_LOCAL		    , NIL },;
		          { "D3_DOC"		, TD3->D3_DOC   	  	, NIL },;
		          { "D3_NUMSEQ"	, TD3->D3_NUMSEQ  	        ,NIL } }

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Encerramento automatico de OP                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Begin Transaction

		lMsErroAuto := .F.
		MsgRun("Encerramento da OP do ultimo Palete. Aguarde...","MATA250 - Encerramento de OP",{|| MSExecAuto({|x,y| MATA250(x,y)},aEncerra, 6) })
		If lMsErroAuto
			DisarmTransaction()
			MostraErro()
		EndIf

	End Transaction

	TD3->(dbCloseAreA())

Return
