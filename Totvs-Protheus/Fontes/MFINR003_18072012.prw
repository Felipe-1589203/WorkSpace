#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"                                           

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                                   MUL - T - LOCK                                      บฑฑ
ฑฑฬออออออออออออัอออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบPrograma    ณ MFINR003  ณ Titulos em Factory                                           บฑฑ
ฑฑฬออออออออออออุอออออออออออฯอออออออออออออออออออออออออออออออออออออออออออัออออออัอออออออออออนฑฑ
ฑฑบAutor       ณ Actual Trend                                          ณ Data ณ  18/01/10 บฑฑ
ฑฑศออออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออฯอออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ                        
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

User Function MFINR003()

Local cDesc1        := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2        := "de acordo com os parametros informados pelo usuario."
Local cDesc3        := "Titulos a receber"
Local cPict         := ""
Local titulo        := "Titulos a receber"                        
Local nLin          := 80
Local Cabec1        := "Cliente   Nome Cliente         Prf Titulo    P Tip  Data de  Data de  Dt de          Valor    Natureza   Hist๓rico                 | Dias  Dt de           Valor       Valor    | Tip Nome do banco  Border๔ Situa็ใo"
Local Cabec2        := "                                                    Emissใo  Vencto   Venc Real      Original                                      |Atraso Baixa           Atual      Corrigido | Rec                                      
Local imprime       := .T.
Local aOrd          := {"Tipo de Recebimento","Banco/Agencia/Conta","Border๔","Cliente + Loja","Prefixo + Titulo","Data Vencto + Banco/Agencia/Conta", "Data Emiss]ao + Banco/Agencia/Conta","Data Vencto + Cliente/Loja", "Data Emiss]ao + Cliente/Loja"}
Local lPerg         := .F.

Private lEnd        := .F.
Private lAbortPrint := .F.
Private limite      := 220
Private tamanho     := "G"
Private nomeprog    := "MFINR003"
Private nTipo       := 15
Private aReturn     := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey    := 0
Private cbtxt       := Space(10)
Private cbcont      := 00
Private CONTFL      := 01
Private m_pag       := 01
Private wnrel       := "MFINR003"
Private cPerg       := "MFINR003"
Private cString     := "SE1"

R003PERG(cPerg)
lPerg := Pergunte(cPerg)
wnrel := SetPrint(cString,NomeProg,"",@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)
If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)
If nLastKey == 27
	Return
Endif

nTipo := If(aReturn[4]==1,15,18)

If lPerg == .T.
	Processa({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
EndIf

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                                   MUL - T - LOCK                                      บฑฑ
ฑฑฬออออออออออออัอออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบFuncao      ณ R003GERA  ณ  Funcao para processamento dos dados do relatorio.           บฑฑ
ฑฑฬออออออออออออุอออออออออออฯอออออออออออออออออออออออออออออออออออออออออออัออออออัอออออออออออนฑฑ
ฑฑบAutor       ณ Actual Trend                                          ณ Data ณ  18/01/10 บฑฑ
ฑฑศออออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออฯอออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

Local cQuery    := ""
Local cAliasA   := ""
Local cQuebra   := ""
Local nTotReg   := 0
Local nTitTot   := 0
Local nVlrTotal := 0
Local nSldTotal := 0
Local nCorTotal := 0
Local nOrdem    := aReturn[8]
Local cMoeda    := "1"
Local ndecs     := Msdecimais(Val(cMoeda))

Private nTitulo   := 0
Private nVlrQuebra:= 0
Private nSldQuebra:= 0
Private nCorQuebra:= 0

cQuery := " SELECT SA6.A6_XFACTOR, SA6.A6_NREDUZ, SEA.EA_NUMBOR, SEA.EA_PORTADO, SEA.EA_AGEDEP, SEA.EA_NUMCON, SE1.E1_NOMCLI, SE1.R_E_C_N_O_ AS SE1REC, SE1.*"
cQuery += "   FROM "+ RetSQLName( 'SE1' ) +" SE1 "

If Mv_par01 == 1
	cQuery += "  INNER JOIN "+ RetSQLName( 'SA6' ) +" SA6 "
Else
	cQuery += "   LEFT JOIN "+ RetSQLName( 'SA6' ) +" SA6 "
EndIf
cQuery += "     ON SA6.A6_FILIAL   = '"+ xFilial("SA6") +"'"
cQuery += "    AND SA6.A6_COD      = SE1.E1_PORTADO"
cQuery += "    AND SA6.A6_AGENCIA  = SE1.E1_AGEDEP"
cQuery += "    AND SA6.A6_NUMCON   = SE1.E1_CONTA"
If Mv_par01 == 1
	cQuery += "    AND SA6.A6_XFACTOR  = 'S'"
EndIf
cQuery += "    AND SA6.D_E_L_E_T_  = ' '"

cQuery += "   LEFT JOIN "+ RetSQLName( 'SEA' ) +" SEA "
cQuery += "     ON SEA.EA_FILIAL   = SE1.E1_FILIAL"
cQuery += "    AND SEA.EA_PREFIXO  = SE1.E1_PREFIXO"
cQuery += "    AND SEA.EA_NUM      = SE1.E1_NUM"
cQuery += "    AND SEA.EA_PARCELA  = SE1.E1_PARCELA"
cQuery += "    AND SEA.EA_TIPO     = SE1.E1_TIPO"
cQuery += "    AND SEA.EA_CART     = 'R'"
cQuery += "    AND SEA.EA_PORTADO  = SE1.E1_PORTADO"
cQuery += "    AND SEA.EA_AGEDEP   = SE1.E1_AGEDEP"
cQuery += "    AND SEA.EA_NUMCON   = SE1.E1_CONTA"
cQuery += "    AND SEA.D_E_L_E_T_  = ' '"
                                                            
cQuery += "  WHERE SE1.E1_FILIAL   = '"+ xFilial("SE1") +"'"
If Mv_par02 == 1
	If Mv_par03 == 1     //  Boleto
		cQuery += "    AND SE1.E1_XTPPAG = 'BOL'"
	ElseIf Mv_par03 == 2 //  Cheque
		cQuery += "    AND SE1.E1_XTPPAG = 'CH '"
	ElseIf Mv_par03 == 3 //  Comissaria
		cQuery += "    AND SE1.E1_XTPPAG = 'CO '"
	ElseIf Mv_par03 == 4 //  Credito Conta
		cQuery += "    AND SE1.E1_XTPPAG = 'CC '"
	ElseIf Mv_par03 == 5 //  Dinheiro
		cQuery += "    AND SE1.E1_XTPPAG = 'R$ '"
	EndIf
EndIf
cQuery += "    AND ((SE1.E1_NUMBOR  BETWEEN '"+ Mv_par04       +"' AND '"+ Mv_par05       +"'"
cQuery += "    AND   SE1.E1_DATABOR BETWEEN '"+ Dtos(Mv_par06) +"' AND '"+ Dtos(Mv_par07) +"')"
cQuery += "     OR  (SE1.E1_NUMBOR  = '"+ Space(Len(Mv_par04)) +" '"
cQuery += "    AND   SE1.E1_DATABOR = '"+ Dtos(Ctod("")) +"')) "

cQuery += "    AND SE1.E1_PORTADO BETWEEN '"+ Mv_par08       +"' AND '"+ Mv_par11       +"'"
cQuery += "    AND SE1.E1_AGEDEP  BETWEEN '"+ Mv_par09       +"' AND '"+ Mv_par12       +"'"
cQuery += "    AND SE1.E1_CONTA   BETWEEN '"+ Mv_par10       +"' AND '"+ Mv_par13       +"'"

cQuery += "    AND SE1.E1_CLIENTE BETWEEN '"+ Mv_par14       +"' AND '"+ Mv_par16       +"'"
cQuery += "    AND SE1.E1_LOJA    BETWEEN '"+ Mv_par15       +"' AND '"+ Mv_par17       +"'"

cQuery += "    AND ((SE1.E1_EMISSAO BETWEEN '"+ Dtos(Mv_par18) +"' AND '"+ Dtos(Mv_par19) +"') OR (SE1.E1_EMIS1 BETWEEN '"+ Dtos(Mv_par18) +"' AND '"+ Dtos(Mv_par19) +"'))"
cQuery += "    AND SE1.E1_VENCREA BETWEEN '"+ Dtos(Mv_par20) +"' AND '"+ Dtos(Mv_par21) +"'"
cQuery += "    AND ((SE1.E1_SALDO > 0 ) OR (SE1.E1_SALDO = 0 AND SE1.E1_BAIXA  = '"+ Dtos(Ctod("")) +"') )"

cQuery += "    AND SE1.E1_PREFIXO BETWEEN '"+ Mv_par22       +"' AND '"+ Mv_par23       +"'"
cQuery += "    AND SE1.E1_NUM     BETWEEN '"+ Mv_par24       +"' AND '"+ Mv_par25       +"'"
cQuery += "    AND SE1.E1_PARCELA BETWEEN '"+ Mv_par26       +"' AND '"+ Mv_par27       +"'"
cQuery += "    AND SE1.E1_TIPO    BETWEEN '"+ Mv_par28       +"' AND '"+ Mv_par29       +"'"

If Mv_par30 == 2 // Imprime titulos em desconto
	cQuery += "    AND SE1.E1_SITUACA NOT IN ('2','7')"
EndIf

If Mv_par31 == 2 // Imprime titulos provisorios
	cQuery += "    AND SE1.E1_TIPO    NOT IN "+ FormatIn(MVPROVIS,"/")
EndIf

If Mv_par32 == 2 // Imprime titulos de adiantamento
	cQuery += "    AND SE1.E1_TIPO    NOT IN "+ FormatIn(MVRECANT+"/"+MV_CRNEG,"/")
EndIf

If Mv_par33 == 2 // Imprime titulos de abatimento
	cQuery += "    AND SE1.E1_TIPO    NOT IN "+ FormatIn(MVABATIM,"/")
EndIf

cQuery += "    AND SE1.D_E_L_E_T_  = ' '"
titulo := Alltrim(titulo)

If nOrdem == 1        // Tipo de Recebimento
	cQuery += " ORDER BY SE1.E1_XTPPAG, SE1.E1_PORTADO, SE1.E1_AGEDEP, SE1.E1_CONTA, SE1.E1_CLIENTE, SE1.E1_LOJA, SE1.E1_PREFIXO, SE1.E1_NUM, SE1.E1_PARCELA"
	titulo += " por Tipo de Recebimento"
	
ElseIf nOrdem == 2    // Banco/Agencia/Conta
	cQuery += " ORDER BY SE1.E1_PORTADO, SE1.E1_AGEDEP, SE1.E1_CONTA, SE1.E1_XTPPAG, SE1.E1_CLIENTE, SE1.E1_LOJA, SE1.E1_PREFIXO, SE1.E1_NUM, SE1.E1_PARCELA"
	titulo += " Por Banco/Agencia/Conta"
	
ElseIf nOrdem == 3    // Border๔
	cQuery += " ORDER BY SE1.E1_NUMBOR, SE1.E1_CLIENTE, SE1.E1_LOJA, SE1.E1_PREFIXO, SE1.E1_NUM, SE1.E1_PARCELA"
	titulo += " por N๚mero de Border๔"
	
ElseIf nOrdem == 4    // Cliente + Loja
	cQuery += " ORDER BY SE1.E1_CLIENTE, SE1.E1_LOJA, SE1.E1_PREFIXO, SE1.E1_NUM, SE1.E1_PARCELA"
	titulo += " por Cliente + Loja"
	
ElseIf nOrdem == 5    // Prefixo + Titulo
	cQuery += " ORDER BY SE1.E1_PREFIXO, SE1.E1_NUM, SE1.E1_PARCELA, SE1.E1_CLIENTE, SE1.E1_LOJA"
	titulo += " por Prefixo + Titulo"
	
ElseIf nOrdem == 6    // Data Vencto + Banco/Agencia/Conta
	cQuery += " ORDER BY Dtos(SE1.E1_VENCREA)+SE1.E1_PORTADO, SE1.E1_AGEDEP, SE1.E1_CONTA, SE1.E1_XTPPAG, SE1.E1_CLIENTE, SE1.E1_LOJA, SE1.E1_PREFIXO, SE1.E1_NUM, SE1.E1_PARCELA"
	titulo += " Por  Data Vencto + Banco/Agencia/Conta"
	
ElseIf nOrdem == 7    // Data Emiss]ao + Banco/Agencia/Conta
	cQuery += " ORDER BY Dtos(SE1.E1_EMISSAO)+SE1.E1_PORTADO, SE1.E1_AGEDEP, SE1.E1_CONTA, SE1.E1_XTPPAG, SE1.E1_CLIENTE, SE1.E1_LOJA, SE1.E1_PREFIXO, SE1.E1_NUM, SE1.E1_PARCELA"
	titulo += " Por  Data Vencto + Banco/Agencia/Conta"
	
ElseIf nOrdem == 8    // Data Vencto + Cliente/Loja
	cQuery += " ORDER BY Dtos(SE1.E1_VENCREA) + SE1.E1_CLIENTE, SE1.E1_LOJA, SE1.E1_PREFIXO, SE1.E1_NUM, SE1.E1_PARCELA"
	titulo += " Por  Data Vencto + Banco/Agencia/Conta"
	
ElseIf nOrdem == 9    // Data Emiss]ao + Cliente/Loja
	cQuery += " ORDER BY Dtos(SE1.E1_EMISSAO) + SE1.E1_CLIENTE, SE1.E1_LOJA, SE1.E1_PREFIXO, SE1.E1_NUM, SE1.E1_PARCELA"
	titulo += " Por  Data Vencto + Banco/Agencia/Conta"
EndIf
nCont   := 0
cAliasA	:= GetNextAlias()
cQuery  := ChangeQuery(cQuery)

DbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cAliasA , .F., .T.)
aEval( SE1->(dbStruct()),{|x| If(x[2]!="C", TcSetField(cAliasA,AllTrim(x[1]),x[2],x[3],x[4]),Nil)})
aEval( SEA->(dbStruct()),{|x| If(x[2]!="C", TcSetField(cAliasA,AllTrim(x[1]),x[2],x[3],x[4]),Nil)})
aEval( SA6->(dbStruct()),{|x| If(x[2]!="C", TcSetField(cAliasA,AllTrim(x[1]),x[2],x[3],x[4]),Nil)})

DbSelectArea( cAliasA )
(cAliasA)->(DbGoTop())
(cAliasA)->( dbEval( { || nTotReg++ },,{ || !Eof() } ) )
(cAliasA)->(DbGoTop())

ProcRegua(nTotReg)
While (cAliasA)->(!Eof())
    IncProc("Gerando relatorio "+StrZero(++nCont,5)+" de "+StrZero(nTotReg,5) )
    
	nSaldo := 0
	nJuros := 0
	
	SE1->(DbGoTo( (cAliasA)->SE1REC ))
	If  (cAliasA)->SE1REC <> SE1->(Recno())
		(cAliasA)->(DbSkip())
		Loop
	Endif
	
	If lAbortPrint
		@ nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
		Exit
	Endif
	
	If (cAliasA)->E1_VENCREA < dDataBase
		If RecMoeda((cAliasA)->E1_VENCREA,cMoeda) > 0
			dDataReaj := (cAliasA)->E1_VENCREA
		Else
			dDataReaj := dDataBase
		EndIf
	Else
		dDataReaj := dDataBase
	EndIf
	
	nSaldo := SaldoTit((cAliasA)->E1_PREFIXO,(cAliasA)->E1_NUM,(cAliasA)->E1_PARCELA,(cAliasA)->E1_TIPO,(cAliasA)->E1_NATUREZ,"R",(cAliasA)->E1_CLIENTE,Val(cMoeda),dDataReaj,,(cAliasA)->E1_LOJA,,Iif(!Empty((cAliasA)->E1_TXMOEDA),(cAliasA)->E1_TXMOEDA,RecMoeda((cAliasA)->E1_EMISSAO,(cAliasA)->E1_MOEDA)),2)
	
	// Subtrai decrescimo para recompor o saldo na data escolhida.
	If Str((cAliasA)->E1_VALOR,17,2) == Str(nSaldo,17,2) .And. (cAliasA)->E1_DECRESC > 0 .And. (cAliasA)->E1_SDDECRE == 0
		nSaldo -= (cAliasA)->E1_DECRESC
	Endif
	
	// Soma Acrescimo para recompor o saldo na data escolhida.
	If Str((cAliasA)->E1_VALOR,17,2) == Str(nSaldo,17,2) .And. (cAliasA)->E1_ACRESC > 0 .And. (cAliasA)->E1_SDACRES == 0
		nSaldo += (cAliasA)->E1_ACRESC
	Endif
	
	//Se abatimento verifico a data da baixa.
	//Por nao possuirem movimento de baixa no SE5, a saldotit retorna
	//sempre saldo em aberto quando mv_par33 = 1 (Abatimentos = Lista)
	If (cAliasA)->E1_TIPO $ MVABATIM .and. ;
		(((cAliasA)->E1_BAIXA <= dDataBase .and. !Empty((cAliasA)->E1_BAIXA)) .or. ;
		((cAliasA)->E1_MOVIMEN <= dDataBase .and. !Empty((cAliasA)->E1_MOVIMEN))	)
		nSaldo := 0
	Endif
	
	If !(cAliasA)->E1_TIPO $ MVABATIM
		If !((cAliasA)->E1_TIPO $ MVRECANT+"/"+MV_CRNEG) .And. !(nSaldo == 0 )  	// deve olhar abatimento pois e zerado o saldo na liquidacao final do titulo
			//Quando considerar Titulos com emissao futura, eh necessario
			//colocar-se a database para o futuro de forma que a Somaabat()
			//considere os titulos de abatimento
			If (cAliasA)->E1_EMISSAO > dDataBase
				dOldData := dDataBase
				dDataBase := CTOD("31/12/40")
			Endif
			
			nAbatim := SomaAbat((cAliasA)->E1_PREFIXO,(cAliasA)->E1_NUM,(cAliasA)->E1_PARCELA,"R",Val(cMoeda),dDataReaj,(cAliasA)->E1_CLIENTE,(cAliasA)->E1_LOJA)
			
			If (cAliasA)->E1_EMISSAO > dDataBase
				dDataBase := dOldData
			Endif
			
			If STR(nSaldo,17,2) == STR(nAbatim,17,2)
				nSaldo := 0
			ElseIf mv_par33 == 2 //Se nao listar ele diminui do saldo
				nSaldo-= nAbatim
			Endif
		EndIf
	Endif
	nSaldo:=Round(NoRound(nSaldo,3),2)
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Desconsidera caso saldo seja menor ou igual a zero   ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	//If nSaldo <= 0
	//	(cAliasA)->(DbSkip())
	//	Loop
	//Endif
	
	If dDataBase > (cAliasA)->E1_VENCREA	//vencidos
		nJuros := fa070Juros(Val(cMoeda))
	Endif
	
	nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	
	If nOrdem == 1        // Tipo de Recebimento
		If cQuebra <> (cAliasA)->E1_XTPPAG
			If nTitulo > 0
				@ nlin,000 Psay __PrtThinLine()
				nlin++; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
				
				R003TOTAL(nLin,_cDescQuebra, nVlrQuebra, nSldQuebra, nCorQuebra)
				
				nLin += 1; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
				@ nlin,000 Psay __PrtThinLine()
				nLin += 2; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			EndIf
			
			_cDescQuebra := (cAliasA)->E1_XTPPAG+" - "+Posicione("SX5",1, xFilial("SX5")+"24"+(cAliasA)->E1_XTPPAG, "X5_DESCRI")
			
			@ nLin,000 PSAY Left("TIPO RECEBIMENTO: "+_cDescQuebra,74)
			nLin+= 2; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			
			cQuebra:= (cAliasA)->E1_XTPPAG
		EndIf
		
	ElseIf nOrdem == 2    // Banco/Agencia/Conta
		
		If cQuebra <> (cAliasA)->E1_PORTADO+(cAliasA)->E1_AGEDEP+(cAliasA)->E1_CONTA
			If nTitulo > 0
				@ nlin,000 Psay __PrtThinLine()
				nlin++; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
				
				R003TOTAL(nLin,_cDescQuebra, nVlrQuebra, nSldQuebra, nCorQuebra)
				
				nLin += 1; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
				@ nlin,000 Psay __PrtThinLine()
				nLin += 2; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			EndIf
			
			_cDescQuebra := (cAliasA)->E1_PORTADO+"/"+(cAliasA)->E1_AGEDEP+"/"+(cAliasA)->E1_CONTA+" - "+Posicione("SA6",1, xFilial("SA6")+(cAliasA)->E1_PORTADO+(cAliasA)->E1_AGEDEP+(cAliasA)->E1_CONTA, "A6_NOME")
			@ nLin,000 PSAY Left("BANCO: "+_cDescQuebra,74)
			nLin+= 2; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			
			cQuebra:= (cAliasA)->E1_PORTADO+(cAliasA)->E1_AGEDEP+(cAliasA)->E1_CONTA
		EndIf
		
	ElseIf nOrdem == 3    // Border๔
		If cQuebra <> (cAliasA)->E1_NUMBOR
			If nTitulo > 0
				@ nlin,000 Psay __PrtThinLine()
				nlin++; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
				
				R003TOTAL(nLin,_cDescQuebra, nVlrQuebra, nSldQuebra, nCorQuebra)
				
				nLin += 1; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
				@ nlin,000 Psay __PrtThinLine()
				nLin += 2; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			EndIf
			
			_cDescQuebra := (cAliasA)->E1_NUMBOR
			@ nLin,000 PSAY Left("BORDERิ: "+_cDescQuebra,74)
			nLin+= 2; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			
			cQuebra:= E1_NUMBOR
		EndIf
		
	ElseIf nOrdem == 4    // Cliente + Loja
		If cQuebra <> (cAliasA)->E1_CLIENTE+(cAliasA)->E1_LOJA
			If nTitulo > 0
				@ nlin,000 Psay __PrtThinLine()
				nlin++; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
				
				R003TOTAL(nLin,_cDescQuebra, nVlrQuebra, nSldQuebra, nCorQuebra)
				
				nLin += 1; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
				@ nlin,000 Psay __PrtThinLine()
				nLin += 2; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			EndIf
			
			_cDescQuebra := (cAliasA)->E1_CLIENTE+"/"+(cAliasA)->E1_LOJA+" - "+Posicione("SA1",1, xFilial("SA1")+(cAliasA)->E1_CLIENTE+(cAliasA)->E1_LOJA, "A1_NOME")
			@ nLin,000 PSAY Left("CLIENTE/LOJA: "+_cDescQuebra,74)
			nLin+= 2; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			
			cQuebra:= (cAliasA)->E1_CLIENTE+(cAliasA)->E1_LOJA
		EndIf
		
	ElseIf nOrdem == 5    // Prefixo + Titulo
		/*
		If cQuebra <> (cAliasA)->E1_PREFIXO+(cAliasA)->E1_NUM
		If nTitulo > 0
		@ nlin,000 Psay __PrtThinLine()
		nlin++; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		
		R003TOTAL(nLin,_cDescQuebra, nVlrQuebra, nSldQuebra, nCorQuebra)
		
		nLin += 1; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		@ nlin,000 Psay __PrtThinLine()
		nLin += 2; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		EndIf
		
		_cDescQuebra := (cAliasA)->E1_PREFIXO+"/"+(cAliasA)->E1_NUM
		@ nLin,000 PSAY Left("PREFIXO/TITULO : "+_cDescQuebra,74)
		nLin+= 2; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		
		cQuebra:= (cAliasA)->E1_PREFIXO+(cAliasA)->E1_NUM
		EndIf
		*/
	ElseIf nOrdem == 6    // Data Vencto + Banco/Agencia/Conta
		If cQuebra <> Dtos((cAliasA)->E1_VENCTO)+(cAliasA)->E1_PORTADO+(cAliasA)->E1_AGEDEP+(cAliasA)->E1_CONTA
			If nTitulo > 0
				@ nlin,000 Psay __PrtThinLine()
				nlin++; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
				
				R003TOTAL(nLin,_cDescQuebra, nVlrQuebra, nSldQuebra, nCorQuebra)
				
				nLin += 1; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
				@ nlin,000 Psay __PrtThinLine()
				nLin += 2; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			EndIf
			
			_cDescQuebra := Dtoc((cAliasA)->E1_VENCTO)+"  "+(cAliasA)->E1_PORTADO+"/"+(cAliasA)->E1_AGEDEP+"/"+(cAliasA)->E1_CONTA
			@ nLin,000 PSAY Left("DT VENCTO + BANCO/AGENCIA/CONTA: "+_cDescQuebra,74)
			nLin+= 2; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			
			cQuebra:= Dtos((cAliasA)->E1_VENCTO)+(cAliasA)->E1_PORTADO+(cAliasA)->E1_AGEDEP+(cAliasA)->E1_CONTA
		EndIf
		
	ElseIf nOrdem == 7    // Data Emiss]ao + Banco/Agencia/Conta
		If cQuebra <> Dtos((cAliasA)->E1_EMISSAO)+(cAliasA)->E1_PORTADO+(cAliasA)->E1_AGEDEP+(cAliasA)->E1_CONTA
			If nTitulo > 0
				@ nlin,000 Psay __PrtThinLine()
				nlin++; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
				
				R003TOTAL(nLin,_cDescQuebra, nVlrQuebra, nSldQuebra, nCorQuebra)
				
				nLin += 1; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
				@ nlin,000 Psay __PrtThinLine()
				nLin += 2; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			EndIf
			
			_cDescQuebra := Dtoc((cAliasA)->E1_EMISSAO)+"  "+(cAliasA)->E1_PORTADO+"/"+(cAliasA)->E1_AGEDEP+"/"+(cAliasA)->E1_CONTA
			@ nLin,000 PSAY Left("DT EMISSAO + BANCO/AGENCIA/CONTA: "+_cDescQuebra,74)
			nLin+= 2; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			
			cQuebra:= Dtos((cAliasA)->E1_EMISSAO)+(cAliasA)->E1_PORTADO+(cAliasA)->E1_AGEDEP+(cAliasA)->E1_CONTA
		EndIf
		
	ElseIf nOrdem == 8    // Data Vencto + Cliente/Loja
		If cQuebra <> Dtos((cAliasA)->E1_VENCTO)+(cAliasA)->E1_CLIENTE+(cAliasA)->E1_LOJA
			If nTitulo > 0
				@ nlin,000 Psay __PrtThinLine()
				nlin++; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
				
				R003TOTAL(nLin,_cDescQuebra, nVlrQuebra, nSldQuebra, nCorQuebra)
				
				nLin += 1; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
				@ nlin,000 Psay __PrtThinLine()
				nLin += 2; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			EndIf
			
			_cDescQuebra := Dtoc((cAliasA)->E1_VENCTO)+"  "+(cAliasA)->E1_CLIENTE+"/"+(cAliasA)->E1_LOJA+" - "+Posicione("SA1",1, xFilial("SA1")+(cAliasA)->E1_CLIENTE+(cAliasA)->E1_LOJA, "A1_NOME")
			@ nLin,000 PSAY Left("DT VENCTO + CLIENTE/LOJA: "+_cDescQuebra,74)
			nLin+= 2; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			
			cQuebra:= Dtos((cAliasA)->E1_VENCTO)+(cAliasA)->E1_CLIENTE+(cAliasA)->E1_LOJA
		EndIf
		
	ElseIf nOrdem == 9    // Data Emiss]ao + Cliente/Loja
		If cQuebra <> Dtos((cAliasA)->E1_EMISSAO)+(cAliasA)->E1_CLIENTE+(cAliasA)->E1_LOJA
			If nTitulo > 0
				@ nlin,000 Psay __PrtThinLine()
				nlin++; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
				
				R003TOTAL(nLin,_cDescQuebra, nVlrQuebra, nSldQuebra, nCorQuebra)
				
				nLin += 1; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
				@ nlin,000 Psay __PrtThinLine()
				nLin += 2; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			EndIf
			
			_cDescQuebra := Dtoc((cAliasA)->E1_EMISSAO)+"  "+(cAliasA)->E1_CLIENTE+"/"+(cAliasA)->E1_LOJA+" - "+Posicione("SA1",1, xFilial("SA1")+(cAliasA)->E1_CLIENTE+(cAliasA)->E1_LOJA, "A1_NOME")
			@ nLin,000 PSAY Left("DT EMISSAO + CLIENTE/LOJA: "+_cDescQuebra,74)
			nLin+= 2; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			
			cQuebra:= Dtos((cAliasA)->E1_EMISSAO)+(cAliasA)->E1_CLIENTE+(cAliasA)->E1_LOJA
		EndIf
	EndIf
	
	@ nLin,000 PSAY (cAliasA)->E1_CLIENTE+"/"+(cAliasA)->E1_LOJA
	@ nLin,010 PSAY (cAliasA)->E1_NOMCLI
	@ nLin,031 PSAY (cAliasA)->E1_PREFIXO
	@ nLin,035 PSAY (cAliasA)->E1_NUM
	@ nLin,045 PSAY (cAliasA)->E1_PARCELA
	@ nLin,048 PSAY (cAliasA)->E1_TIPO
	@ nLin,052 PSAY Dtoc((cAliasA)->E1_EMISSAO)
	@ nLin,061 PSAY Dtoc((cAliasA)->E1_VENCTO)
	@ nLin,070 PSAY Dtoc((cAliasA)->E1_VENCREA)
	@ nLin,079 PSAY TransForm( (cAliasA)->E1_VALOR*Iif(((cAliasA)->E1_TIPO $ MVRECANT+"/"+MV_CRNEG),-1,1) , "@E 999,999,999.99" )
	@ nLin,094 PSAY (cAliasA)->E1_NATUREZ
	@ nLin,105 PSAY (cAliasA)->E1_HIST
	@ nLin,131 PSAY "|"
	@ nLin,133 PSAY IIf((dDataBase-(cAliasA)->E1_VENCREA) <= 0, "", StrZero(dDataBase-(cAliasA)->E1_VENCREA,3))
	@ nLin,137 PSAY Dtoc((cAliasA)->E1_BAIXA)
	@ nLin,146 PSAY TransForm( nSaldo*Iif(((cAliasA)->E1_TIPO $ MVRECANT+"/"+MV_CRNEG),-1,1), "@E 999,999,999.99" )
	@ nLin,161 PSAY TransForm( (nSaldo+nJuros)*Iif(((cAliasA)->E1_TIPO $ MVRECANT+"/"+MV_CRNEG),-1,1), "@E 999,999,999.99" )
	@ nLin,176 PSAY "|"
	@ nLin,178 PSAY Left(Posicione("SX5",1, xFilial("SX5")+"24"+(cAliasA)->E1_XTPPAG, "X5_DESCRI"),3)
	@ nLin,182 PSAY (cAliasA)->A6_NREDUZ
	@ nLin,198 PSAY (cAliasA)->E1_NUMBOR      
	@ nLin,205 PSAY Left(Posicione("SX5",1, xFilial("SX5")+"07"+(cAliasA)->E1_SITUACA, "X5_DESCRI"),15)
//	@ nLin,211 PSAY Dtoc((cAliasA)->E1_DATABOR)
	nlin++; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	
	nTitulo++
	nTitTot++                              
	                                                                                  
	nVlrQuebra += (cAliasA)->E1_VALOR*Iif(((cAliasA)->E1_TIPO $ MVRECANT+"/"+MV_CRNEG),-1,1)
	nSldQuebra += nSaldo*Iif(((cAliasA)->E1_TIPO $ MVRECANT+"/"+MV_CRNEG),-1,1)
	nCorQuebra += (nSaldo+nJuros)*Iif(((cAliasA)->E1_TIPO $ MVRECANT+"/"+MV_CRNEG),-1,1)
	
	nVlrTotal  += (cAliasA)->E1_VALOR*Iif(((cAliasA)->E1_TIPO $ MVRECANT+"/"+MV_CRNEG),-1,1)
	nSldTotal  += nSaldo*Iif(((cAliasA)->E1_TIPO $ MVRECANT+"/"+MV_CRNEG),-1,1)
	nCorTotal  += (nSaldo+nJuros)*Iif(((cAliasA)->E1_TIPO $ MVRECANT+"/"+MV_CRNEG),-1,1)
	
	(cAliasA)->(DbSkip())
End-While
(cAliasA)->(DbCloseArea())

SET DEVICE TO SCREEN

If nTotReg > 0
	
	If nOrdem == 1        // Tipo de Recebimento
		@ nlin,000 Psay __PrtThinLine()
		nlin++; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		
		R003TOTAL(nLin,_cDescQuebra, nVlrQuebra, nSldQuebra, nCorQuebra)
		
		nLin += 1; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		@ nlin,000 Psay __PrtThinLine()
		nLin += 2; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		
	ElseIf nOrdem == 2    // Banco/Agencia/Conta
		@ nlin,000 Psay __PrtThinLine()
		nlin++; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		
		R003TOTAL(nLin,_cDescQuebra, nVlrQuebra, nSldQuebra, nCorQuebra)
		
		nLin += 1; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		@ nlin,000 Psay __PrtThinLine()
		nLin += 2; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		
	ElseIf nOrdem == 3    // Border๔
		@ nlin,000 Psay __PrtThinLine()
		nlin++; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		
		R003TOTAL(nLin,_cDescQuebra, nVlrQuebra, nSldQuebra, nCorQuebra)
		
		nLin += 1; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		@ nlin,000 Psay __PrtThinLine()
		nLin += 2; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		
	ElseIf nOrdem == 4    // Cliente + Loja
		@ nlin,000 Psay __PrtThinLine()
		nlin++; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		
		R003TOTAL(nLin,_cDescQuebra, nVlrQuebra, nSldQuebra, nCorQuebra)
		
		nLin += 1; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		@ nlin,000 Psay __PrtThinLine()
		nLin += 2; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		
	ElseIf nOrdem == 5    // Prefixo + Titulo
		/*
		@ nlin,000 Psay __PrtThinLine()
		nlin++; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		
		R003TOTAL(nLin,_cDescQuebra, nVlrQuebra, nSldQuebra, nCorQuebra)
		
		nLin += 1; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		@ nlin,000 Psay __PrtThinLine()
		nLin += 2; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		*/
	ElseIf nOrdem == 6    // Data Vencto + Banco/Agencia/Conta
		@ nlin,000 Psay __PrtThinLine()
		nlin++; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		
		R003TOTAL(nLin,_cDescQuebra, nVlrQuebra, nSldQuebra, nCorQuebra)
		
		nLin += 1; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		@ nlin,000 Psay __PrtThinLine()
		nLin += 2; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		
	ElseIf nOrdem == 7    // Data Emiss]ao + Banco/Agencia/Conta
		@ nlin,000 Psay __PrtThinLine()
		nlin++; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		
		R003TOTAL(nLin,_cDescQuebra, nVlrQuebra, nSldQuebra, nCorQuebra)
		
		nLin += 1; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		@ nlin,000 Psay __PrtThinLine()
		nLin += 2; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		
	ElseIf nOrdem == 8    // Data Vencto + Cliente/Loja
		@ nlin,000 Psay __PrtThinLine()
		nlin++; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		
		R003TOTAL(nLin,_cDescQuebra, nVlrQuebra, nSldQuebra, nCorQuebra)
		
		nLin += 1; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		@ nlin,000 Psay __PrtThinLine()
		nLin += 2; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		
	ElseIf nOrdem == 9    // Data Emiss]ao + Cliente/Loja
		@ nlin,000 Psay __PrtThinLine()
		nlin++; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		
		R003TOTAL(nLin,_cDescQuebra, nVlrQuebra, nSldQuebra, nCorQuebra)
		
		nLin += 1; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		@ nlin,000 Psay __PrtThinLine()
		nLin += 2; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	EndIf
	
	@ nlin,000 Psay __PrtThinLine()
	nlin++; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	
	@ nlin,000 Psay "TOTAL GERAL ("+AllTrim(Str(nTitTot))+" MOVIMENTOS)"
	@ nLin,079 PSAY TransForm( nVlrTotal, "@E 999,999,999.99" )
	@ nLin,131 PSAY "|"
	@ nLin,146 PSAY TransForm( nSldTotal, "@E 999,999,999.99" )
	@ nLin,161 PSAY TransForm( nCorTotal, "@E 999,999,999.99" )
	@ nLin,176 PSAY "|"
	
	nLin += 1; nLin := R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	@ nlin,000 Psay __PrtThinLine()
	
	Roda(cbcont,cbtxt,Tamanho)
EndIf

If aReturn[5]==1
	dbCommitAll()
	SET PRINTER TO
	OurSpool(wnrel)
Endif

MS_FLUSH()

Return()

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                                   MUL - T - LOCK                                      บฑฑ
ฑฑฬออออออออออออัอออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบFuncao      ณR003PULA   ณ  Pula linha ou inicia nova pagina                            บฑฑ
ฑฑฬออออออออออออุอออออออออออฯอออออออออออออออออออออออออออออออออออออออออออัออออออัอออออออออออนฑฑ
ฑฑบAutor       ณ Actual Trend                                          ณ Data ณ  18/01/10 บฑฑ
ฑฑศออออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออฯอออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

Static Function R003PULA(nLin,Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)

If nLin > 56
	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	nLin := 9
Else
	nLin := nLin
Endif

Return(nLin)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                                   MUL - T - LOCK                                      บฑฑ
ฑฑฬออออออออออออัอออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบFuncao      ณ R001PERG  ณ Funcao de perguntas                                          บฑฑ
ฑฑฬออออออออออออุอออออออออออฯอออออออออออออออออออออออออออออออออออออออออออัออออออัอออออออออออนฑฑ
ฑฑบAutor       ณ Actual Trend                                          ณ Data ณ  18/01/10 บฑฑ
ฑฑศออออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออฯอออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

Static Function R003PERG(cPerg)

Local aAreaAtu	:= GetArea()
Local aAreaSX1	:= SX1->( GetArea() )

PutSx1(	cPerg, "01", "Somente Tit.Factory? ", "Somente Tit.Factory? ", "Somente Tit.Factory? ","Mv_ch1","N"                        ,                         1,                          0, 2,"C","",   "","","N","Mv_par01","Sim          ","Si           ","Yes           ","","Nao            ","No             ","No             ","          ","          ","           ","            ","             ","             ","        ","        ","        ",{"Listar somente titulos em Factory?    ",""},{""},{""},"")
PutSx1(	cPerg, "02", "Filtra  Recebimento? ", "Filtra  Recebimento? ", "Filtra  Recebimento? ","Mv_ch2","N"                        ,                         1,                          0, 2,"C","",   "","","N","Mv_par02","Sim          ","Si           ","Yes           ","","Nao            ","No             ","No             ","          ","          ","           ","            ","             ","             ","        ","        ","        ",{"Filtrar formas de recebimento, se nใo "," irแ listar todas"},{""},{""},"")
PutSx1(	cPerg, "03", "Tipo de Recebimento? ", "Tipo de Recebimento? ", "Tipo de Recebimento? ","Mv_ch3","N"                        ,                         1,                          0, 2,"C","",   "","","N","Mv_par03","Boleto       ","Boleto       ","Boleto        ","","Cheque         ","Cheque         ","Cheque         ","Comissaria","Comissaria","Comissaria","Credito Conta","Credito Conta","Credito Conta","Dinheiro","Dinheiro","Dinheiro",{"Selecione a forma de recebimento      ",""},{""},{""},"")
PutSx1(	cPerg, "04", "Border๔ de         ? ", "Border๔ de         ? ", "Border๔ de         ? ","Mv_ch4", TAMSX3( "E1_NUMBOR"  )[3], TAMSX3( "E1_NUMBOR"  )[1], TAMSX3( "E1_NUMBOR"  )[2], 0,"G","",   "","","N","Mv_par04","             ","             ","              ","","               ","               ","               ","          ","          ","           ","            ","             ","             ","        ","        ","        ",{"Informe o boder๔ inicial               ",""},{""},{""},"")
PutSx1(	cPerg, "05", "Border๔ ate        ? ", "Border๔ ate        ? ", "Border๔ ate        ? ","Mv_ch5", TAMSX3( "E1_NUMBOR"  )[3], TAMSX3( "E1_NUMBOR"  )[1], TAMSX3( "E1_NUMBOR"  )[2], 0,"G","",   "","","N","Mv_par05","             ","             ","              ","","               ","               ","               ","          ","          ","           ","            ","             ","             ","        ","        ","        ",{"Informe o border๔ final                ",""},{""},{""},"")
PutSx1(	cPerg, "06", "Data Border๔ de    ? ", "Data Border๔ de    ? ", "Data Border๔ de    ? ","Mv_ch6", TAMSX3( "E1_DATABOR" )[3], TAMSX3( "E1_DATABOR" )[1], TAMSX3( "E1_DATABOR" )[2], 0,"G","",   "","","N","Mv_par06","             ","             ","              ","","               ","               ","               ","          ","          ","           ","            ","             ","             ","        ","        ","        ",{"Informe a data border๔ inicial         ",""},{""},{""},"")
PutSx1(	cPerg, "07", "Data Border๔ ate   ? ", "Data Border๔ ate   ? ", "Data Border๔ ate   ? ","Mv_ch7", TAMSX3( "E1_DATABOR" )[3], TAMSX3( "E1_DATABOR" )[1], TAMSX3( "E1_DATABOR" )[2], 0,"G","",   "","","N","Mv_par07","             ","             ","              ","","               ","               ","               ","          ","          ","           ","            ","             ","             ","        ","        ","        ",{"Informe a data border๔ final           ",""},{""},{""},"")
PutSx1(	cPerg, "08", "Banco de           ? ", "Banco de           ? ", "Banco de           ? ","Mv_ch8", TAMSX3( "EA_PORTADO" )[3], TAMSX3( "EA_PORTADO" )[1], TAMSX3( "EA_PORTADO" )[2], 0,"G","","SA6","","N","Mv_par08","             ","             ","              ","","               ","               ","               ","          ","          ","           ","            ","             ","             ","        ","        ","        ",{"Informe o banco inicial                ",""},{""},{""},"")
PutSx1(	cPerg, "09", "Agencia de         ? ", "Agencia de         ? ", "Agencia de         ? ","Mv_ch9", TAMSX3( "EA_AGEDEP"  )[3], TAMSX3( "EA_AGEDEP"  )[1], TAMSX3( "EA_AGEDEP"  )[2], 0,"G","",   "","","N","Mv_par09","             ","             ","              ","","               ","               ","               ","          ","          ","           ","            ","             ","             ","        ","        ","        ",{"Informe a agencia inicial              ",""},{""},{""},"")
PutSx1(	cPerg, "10", "Conta de           ? ", "Conta de           ? ", "Conta de           ? ","Mv_cha", TAMSX3( "EA_NUMCON"  )[3], TAMSX3( "EA_NUMCON"  )[1], TAMSX3( "EA_NUMCON"  )[2], 0,"G","",   "","","N","Mv_par10","             ","             ","              ","","               ","               ","               ","          ","          ","           ","            ","             ","             ","        ","        ","        ",{"Informe a conta inicial                ",""},{""},{""},"")
PutSx1(	cPerg, "11", "Banco ate          ? ", "Banco ate          ? ", "Banco ate          ? ","Mv_chb", TAMSX3( "EA_PORTADO" )[3], TAMSX3( "EA_PORTADO" )[1], TAMSX3( "EA_PORTADO" )[2], 0,"G","","SA6","","N","Mv_par11","             ","             ","              ","","               ","               ","               ","          ","          ","           ","            ","             ","             ","        ","        ","        ",{"Informe o banco final                  ",""},{""},{""},"")
PutSx1(	cPerg, "12", "Agencia ate        ? ", "Agencia ate        ? ", "Agencia ate        ? ","Mv_chc", TAMSX3( "EA_AGEDEP"  )[3], TAMSX3( "EA_AGEDEP"  )[1], TAMSX3( "EA_AGEDEP"  )[2], 0,"G","",   "","","N","Mv_par12","             ","             ","              ","","               ","               ","               ","          ","          ","           ","            ","             ","             ","        ","        ","        ",{"Informe a agencia final                ",""},{""},{""},"")
PutSx1(	cPerg, "13", "Conta ate          ? ", "Conta ate          ? ", "Conta ate          ? ","Mv_chd", TAMSX3( "EA_NUMCON"  )[3], TAMSX3( "EA_NUMCON"  )[1], TAMSX3( "EA_NUMCON"  )[2], 0,"G","",   "","","N","Mv_par13","             ","             ","              ","","               ","               ","               ","          ","          ","           ","            ","             ","             ","        ","        ","        ",{"Informe a conta final                  ",""},{""},{""},"")
PutSx1(	cPerg, "14", "Cliente de         ? ", "Cliente de         ? ", "Cliente de         ? ","mv_che", TAMSX3( "E1_CLIENTE" )[3], TAMSX3( "E1_CLIENTE" )[1], TAMSX3( "E1_CLIENTE" )[2], 0,"G","","SA1","","N","Mv_par14","             ","             ","              ","","               ","               ","               ","          ","          ","           ","            ","             ","             ","        ","        ","        ",{"Informe o cliente inicial              ",""},{""},{""},"")
PutSx1(	cPerg, "15", "Loja de            ? ", "Loja de            ? ", "Loja de            ? ","Mv_chf", TAMSX3( "E1_LOJA"    )[3], TAMSX3( "E1_LOJA"    )[1], TAMSX3( "E1_LOJA"    )[2], 0,"G","",   "","","N","Mv_par15","             ","             ","              ","","               ","               ","               ","          ","          ","           ","            ","             ","             ","        ","        ","        ",{"Informe a loja inicial                 ",""},{""},{""},"")
PutSx1(	cPerg, "16", "Cliente ate        ? ", "Cliente ate        ? ", "Cliente ate        ? ","Mv_chg", TAMSX3( "E1_CLIENTE" )[3], TAMSX3( "E1_CLIENTE" )[1], TAMSX3( "E1_CLIENTE" )[2], 0,"G","","SA1","","N","Mv_par16","             ","             ","              ","","               ","               ","               ","          ","          ","           ","            ","             ","             ","        ","        ","        ",{"Informe o cliente final                ",""},{""},{""},"")
PutSx1(	cPerg, "17", "Loja ate           ? ", "Loja ate           ? ", "Loja ate           ? ","Mv_chh", TAMSX3( "E1_LOJA"    )[3], TAMSX3( "E1_LOJA"    )[1], TAMSX3( "E1_LOJA"    )[2], 0,"G","",   "","","N","Mv_par17","             ","             ","              ","","               ","               ","               ","          ","          ","           ","            ","             ","             ","        ","        ","        ",{"Informe a loja final                   ",""},{""},{""},"")
PutSx1(	cPerg, "18", "Data emissao de    ? ", "Data emissao de    ? ", "Data emissao de    ? ","Mv_chi", TAMSX3( "E1_EMISSAO" )[3], TAMSX3( "E1_EMISSAO" )[1], TAMSX3( "E1_EMISSAO" )[2], 0,"G","",   "","","N","Mv_par18","             ","             ","              ","","               ","               ","               ","          ","          ","           ","            ","             ","             ","        ","        ","        ",{"Informe a data de emissใo inicial      ",""},{""},{""},"")
PutSx1(	cPerg, "19", "Data emissao ate   ? ", "Data emissao ate   ? ", "Data emissao ate   ? ","Mv_chj", TAMSX3( "E1_EMISSAO" )[3], TAMSX3( "E1_EMISSAO" )[1], TAMSX3( "E1_EMISSAO" )[2], 0,"G","",   "","","N","Mv_par19","             ","             ","              ","","               ","               ","               ","          ","          ","           ","            ","             ","             ","        ","        ","        ",{"Informe a data de emissใo final        ",""},{""},{""},"")
PutSx1(	cPerg, "20", "Data vencto de     ? ", "Data vencto de     ? ", "Data vencto de     ? ","Mv_chk", TAMSX3( "E1_VENCTO"  )[3], TAMSX3( "E1_VENCTO"  )[1], TAMSX3( "E1_VENCTO"  )[2], 0,"G","",   "","","N","Mv_par20","             ","             ","              ","","               ","               ","               ","          ","          ","           ","            ","             ","             ","        ","        ","        ",{"Informe a data de vencto inicial       ",""},{""},{""},"")
PutSx1(	cPerg, "21", "Data vencto ate    ? ", "Data vencto ate    ? ", "Data vencto ate    ? ","Mv_chl", TAMSX3( "E1_VENCTO"  )[3], TAMSX3( "E1_VENCTO"  )[1], TAMSX3( "E1_VENCTO"  )[2], 0,"G","",   "","","N","Mv_par21","             ","             ","              ","","               ","               ","               ","          ","          ","           ","            ","             ","             ","        ","        ","        ",{"Informe a data de vencto final         ",""},{""},{""},"")
PutSx1(	cPerg, "22", "Prefixo de         ? ", "Prefixo de         ? ", "Prefixo de         ? ","Mv_chm", TAMSX3( "E1_PREFIXO" )[3], TAMSX3( "E1_PREFIXO" )[1], TAMSX3( "E1_PREFIXO" )[2], 0,"G","",   "","","N","Mv_par22","             ","             ","              ","","               ","               ","               ","          ","          ","           ","            ","             ","             ","        ","        ","        ",{"Informe o prefixo inicial              ",""},{""},{""},"")
PutSx1(	cPerg, "23", "Prefixo ate        ? ", "Prefixo ate        ? ", "Prefixo ate        ? ","Mv_chn", TAMSX3( "E1_PREFIXO" )[3], TAMSX3( "E1_PREFIXO" )[1], TAMSX3( "E1_PREFIXO" )[2], 0,"G","",   "","","N","Mv_par23","             ","             ","              ","","               ","               ","               ","          ","          ","           ","            ","             ","             ","        ","        ","        ",{"Informe o prefixo final                ",""},{""},{""},"")
PutSx1(	cPerg, "24", "Titulo de          ? ", "Titulo de          ? ", "Titulo de          ? ","Mv_cho", TAMSX3( "E1_NUM"     )[3], TAMSX3( "E1_NUM"     )[1], TAMSX3( "E1_NUM"     )[2], 0,"G","",   "","","N","Mv_par24","             ","             ","              ","","               ","               ","               ","          ","          ","           ","            ","             ","             ","        ","        ","        ",{"Informe o titulo inicial               ",""},{""},{""},"")
PutSx1(	cPerg, "25", "Titulo ate         ? ", "Titulo ate         ? ", "Titulo ate         ? ","Mv_chp", TAMSX3( "E1_NUM"     )[3], TAMSX3( "E1_NUM"     )[1], TAMSX3( "E1_NUM"     )[2], 0,"G","",   "","","N","Mv_par25","             ","             ","              ","","               ","               ","               ","          ","          ","           ","            ","             ","             ","        ","        ","        ",{"Informe o titulo final                 ",""},{""},{""},"")
PutSx1(	cPerg, "26", "Parcela de         ? ", "Parcela de         ? ", "Parcela de         ? ","Mv_chq", TAMSX3( "E1_PARCELA" )[3], TAMSX3( "E1_PARCELA" )[1], TAMSX3( "E1_PARCELA" )[2], 0,"G","",   "","","N","Mv_par26","             ","             ","              ","","               ","               ","               ","          ","          ","           ","            ","             ","             ","        ","        ","        ",{"Informe o parcela inicial              ",""},{""},{""},"")
PutSx1(	cPerg, "27", "Parcela ate        ? ", "Parcela ate        ? ", "Parcela ate        ? ","Mv_chr", TAMSX3( "E1_PARCELA" )[3], TAMSX3( "E1_PARCELA" )[1], TAMSX3( "E1_PARCELA" )[2], 0,"G","",   "","","N","Mv_par27","             ","             ","              ","","               ","               ","               ","          ","          ","           ","            ","             ","             ","        ","        ","        ",{"Informe o parcela final                ",""},{""},{""},"")
PutSx1(	cPerg, "28", "Tipo de            ? ", "Tipo de            ? ", "Tipo de            ? ","Mv_chs", TAMSX3( "E1_TIPO"    )[3], TAMSX3( "E1_TIPO"    )[1], TAMSX3( "E1_TIPO"    )[2], 0,"G","",   "","","N","Mv_par28","             ","             ","              ","","               ","               ","               ","          ","          ","           ","            ","             ","             ","        ","        ","        ",{"Informe o tipo inicial                 ",""},{""},{""},"")
PutSx1(	cPerg, "29", "Tipo ate           ? ", "Tipo ate           ? ", "Tipo ate           ? ","Mv_cht", TAMSX3( "E1_TIPO"    )[3], TAMSX3( "E1_TIPO"    )[1], TAMSX3( "E1_TIPO"    )[2], 0,"G","",   "","","N","Mv_par29","             ","             ","              ","","               ","               ","               ","          ","          ","           ","            ","             ","             ","        ","        ","        ",{"Informe o tipo final                   ",""},{""},{""},"")
PutSx1(	cPerg, "30", "Tit em desconto    ? ", "Tit em desconto    ? ", "Tit em desconto    ? ","Mv_chu","N"                        ,                         1,                          0, 2,"C","",   "","","N","Mv_par30","Sim          ","Si           ","Yes           ","","Nao            ","No             ","No             ","          ","          ","           ","            ","             ","             ","        ","        ","        ",{"Imprimir titulos em desconto ?         ",""},{""},{""},"")
PutSx1(	cPerg, "31", "Tit provis๓rios    ? ", "Tit provis๓rios    ? ", "Tit provis๓rios    ? ","Mv_chw","N"                        ,                         1,                          0, 2,"C","",   "","","N","Mv_par31","Sim          ","Si           ","Yes           ","","Nao            ","No             ","No             ","          ","          ","           ","            ","             ","             ","        ","        ","        ",{"Imprimir titulos provis๓rios ?         ",""},{""},{""},"")
PutSx1(	cPerg, "32", "Tit de adiantamento? ", "Tit de adiantamento? ", "Tit de adiantamento? ","Mv_chx","N"                        ,                         1,                          0, 2,"C","",   "","","N","Mv_par32","Sim          ","Si           ","Yes           ","","Nao            ","No             ","No             ","          ","          ","           ","            ","             ","             ","        ","        ","        ",{"Imprimir titulos de adiantamento ?     ",""},{""},{""},"")
PutSx1(	cPerg, "33", "Tit de abatimento  ? ", "Tit de abatimento  ? ", "Tit de abatimento  ? ","Mv_chy","N"                        ,                         1,                          0, 2,"C","",   "","","N","Mv_par33","Sim          ","Si           ","Yes           ","","Nao            ","No             ","No             ","          ","          ","           ","            ","             ","             ","        ","        ","        ",{"Imprimir titulos de abatimento ?       ",""},{""},{""},"")

RestArea( aAreaSX1 )
RestArea( aAreaAtu )

Return(cPerg)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                                   MUL - T - LOCK                                      บฑฑ
ฑฑฬออออออออออออัอออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบFuncao      ณR003TOTAL  ณ  Totalizador                                                 บฑฑ
ฑฑฬออออออออออออุอออออออออออฯอออออออออออออออออออออออออออออออออออออออออออัออออออัอออออออออออนฑฑ
ฑฑบAutor       ณ Actual Trend                                          ณ Data ณ  18/01/10 บฑฑ
ฑฑศออออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออฯอออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

Static Function R003TOTAL(nLin,_cDescQuebra, nVlrQuebra, nSldQuebra, nCorQuebra)

@ nlin,000 Psay "TOTAL DE "+AllTrim(_cDescQuebra)
@ nLin,079 PSAY TransForm( nVlrQuebra, "@E 999,999,999.99" )
@ nLin,131 PSAY "|"
@ nLin,146 PSAY TransForm( nSldQuebra, "@E 999,999,999.99" )
@ nLin,161 PSAY TransForm( nCorQuebra, "@E 999,999,999.99" )
@ nLin,176 PSAY "|"
nTitulo    := 0
nVlrQuebra := 0                                 
nSldQuebra := 0
nCorQuebra := 0
                                                                                       
Return()