#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                                   MUL - T - LOCK                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºPrograma    ³ MT410TOK  ³ Relacao de Materias por pedidos de vendas. (Expedicao)       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAutor       ³ Actual Trend - Marcelo Pagliotto                      ³ Data ³  26/08/09 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function MFATR002(c_pedido)

Local cDesc1       := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2       := "de acordo com os parametros informados pelo usuario."
Local cDesc3       := "Relação de Materiais"
Local cPict        := ""
Local nLin         := 80
Local imprime      := .T.
Local aOrd         := {}
Local lPerg        := .T.
Local aArea   	   := GetArea()
Local aAreaSC5	   := SC5->( GetArea() )

Private Cabec1       := ""
Private Cabec2       := ""
Private titulo       := "Relação de Materiais"
Private lEnd       := .F.
Private lAbortPrint:= .F.
Private limite     := 80
Private tamanho    := "M"
Private nomeprog   := "MFATR002"
Private nTipo      := 18
Private aReturn    := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey   := 0
Private cbtxt      := Space(10)
Private cbcont     := 00
Private CONTFL     := 01
Private m_pag      := 01
Private wnrel      := "MFATR002"
Private cString    := "SC6"
Private cPerg      := "MFATR002"
Private c_EOL	   := chr(13)

c_pedido := Iif(c_pedido = Nil, '', c_pedido)

R002PERG(cPerg)

If !Empty(c_pedido)
	Pergunte(cPerg,.F.)
	MV_PAR01 := c_pedido
Else
	lPerg := Pergunte(cPerg,.T.)
EndIf

If lPerg == .T.
	wnrel := SetPrint(cString,NomeProg,"",@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)
	If nLastKey == 27
		Return
	Endif
	
	SetDefault(aReturn,cString)
	If nLastKey == 27
		Return
	Endif
	
	nTipo := If(aReturn[4]==1,15,18)
	
	Processa({|| R002IMPR(Cabec1,Cabec2,Titulo,nLin) },Titulo)
EndIf

RestArea( aArea )
RestArea( aAreaSC5 )

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                                   MUL - T - LOCK                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºPrograma    ³ MT410TOK  ³ Relacao de Materias por pedidos de vendas. (Expedicao)       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAutor       ³ Actual Trend - Marcelo Pagliotto                      ³ Data ³  26/08/09 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function R002IMPR(Cabec1,Cabec2,Titulo,nLin)

Local _n1
Local c_Query := ""
Local cAliasA := ""
Local nTotReg := 0
Local nTotQtd := 0
Local nTotPeso:= 0
Local c_Localiz:=''

cObserv := ''
cMensNF := ''
cInfoNF := ''


c_Query := " SELECT C6_NUM, C5_EMISSAO, C5_TIPO, C5_XTTPPED, C5_XSITPM, C5_XENTRPM, C5_XORIGEM, C6_SERIE, C6_NOTA, /*D2_EMISSAO,*/ C5_CLIENTE, C5_LOJACLI, C5_LOJAENT, A1_NOME," + c_EOL
c_Query += "        A1_END, A1_BAIRRO, A1_MUN, A1_EST, A1_CEP, C5_TRANSP, C6_PRODUTO, C6_ITEM, C6_UM, B1_DESC, B1_PESO, C6_LOTECTL, C6_LOCALIZ, C6_LOCAL, sum(C6_QTDVEN) as C6_QTDVEN," + c_EOL
c_Query += "        C5_MENNOTA, C9_NUMSEQ " + c_EOL


c_Query += "   FROM ( SELECT SC6.C6_NUM, SC5.C5_TIPO, SC5.C5_EMISSAO, SC5.C5_XTTPPED, SC5.C5_XSITPM, SC5.C5_XENTRPM, SC5.C5_XORIGEM, SC6.C6_SERIE, SC6.C6_NOTA, /*SD2.D2_EMISSAO,*/" + c_EOL
c_Query += "                 SC5.C5_CLIENTE, SC5.C5_LOJACLI, SC5.C5_LOJAENT, SA1.A1_NOME, SA1.A1_END, SA1.A1_BAIRRO, SA1.A1_MUN, SA1.A1_EST, SA1.A1_CEP,SA1., SC5.C5_TRANSP," + c_EOL
c_Query += "                 SC6.C6_PRODUTO, SC6.C6_ITEM,SC6.C6_UM, SB1.B1_DESC, SB1.B1_PESO, "+Iif(!Empty(SZ2->Z2_DOC),'C6_LOTECTL', "SC9.C9_LOTECTL AS C6_LOTECTL")+", C6_LOCALIZ as C6_LOCALIZ," + c_EOL
c_Query += "                 SC6.C6_LOCAL, "+Iif(!Empty(SZ2->Z2_DOC), 'D2_QUANT AS C6_QTDVEN', 'SC9.C9_QTDLIB as C6_QTDVEN')+ ", SC5.C5_MENNOTA, "+Iif(!Empty(SZ2->Z2_DOC), " '' as C9_NUMSEQ",'C9_NUMSEQ')+" " + c_EOL

c_Query += "            FROM "+RetSqlName("SC5")+" SC5 " + c_EOL

c_Query += "           INNER JOIN "+RetSqlName("SC6")+" SC6 " + c_EOL
c_Query += "              ON SC6.C6_FILIAL  = '"+ xFilial("SC6") +"'" + c_EOL
c_Query += "             AND SC6.C6_NUM     = SC5.C5_NUM" + c_EOL
If !Empty(SZ2->Z2_DOC)
//	c_Query += "         AND SC6.C6_NOTA    = '"+ SZ2->Z2_DOC    +"'" + c_EOL
//	c_Query += "         AND SC6.C6_SERIE   = '"+ SZ2->Z2_SERIE  +"'" + c_EOL
	c_Query += "         AND SC6.C6_CLI     = '"+ SZ2->Z2_CLIENTE+"'" + c_EOL
	c_Query += "         AND SC6.C6_LOJA    = '"+ SZ2->Z2_LOJA   +"'" + c_EOL
EndIf                                                                 
c_Query += "             AND SC6.D_E_L_E_T_ = ' '" + c_EOL

If !Empty(SZ2->Z2_DOC)
	c_Query += "            INNER JOIN "+RetSqlName("SD2")+" SD2 " + c_EOL
	c_Query += "              ON SD2.D2_FILIAL  = '"+ xFilial("SD2") +"'" + c_EOL
	c_Query += "             AND SD2.D2_DOC     = '"+ SZ2->Z2_DOC +"' " + c_EOL
	c_Query += "             AND SD2.D2_SERIE   = '"+ SZ2->Z2_SERIE +"' " + c_EOL
	c_Query += "             AND SD2.D2_CLIENTE = SC6.C6_CLI" + c_EOL
	c_Query += "             AND SD2.D2_LOJA    = SC6.C6_LOJA" + c_EOL
	c_Query += "             AND SD2.D2_PEDIDO  = SC6.C6_NUM" + c_EOL
	c_Query += "             AND SD2.D2_ITEMPV  = SC6.C6_ITEM" + c_EOL
	c_Query += "             AND SD2.D_E_L_E_T_ = ' '" + c_EOL
Else
	c_Query += "           INNER JOIN "+RetSqlName("SC9")+" SC9 " + c_EOL
	c_Query += "              ON SC9.C9_FILIAL  = '"+ xFilial("SC9") +"'" + c_EOL
	c_Query += "             AND SC9.C9_PEDIDO  = SC6.C6_NUM" + c_EOL
	c_Query += "             AND SC9.C9_ITEM    = SC6.C6_ITEM" + c_EOL
	c_Query += "             AND (SC9.C9_BLCRED = '  ' OR SC9.C9_BLCRED = '10' OR SC9.C9_BLCRED = 'ZZ') " + c_EOL
	c_Query += "             AND (SC9.C9_BLEST  = '  ' OR SC9.C9_BLEST  = '10' OR SC9.C9_BLEST  = 'ZZ') " + c_EOL
	c_Query += "             AND SC9.D_E_L_E_T_ = ' '" + c_EOL
EndIf

/*c_Query += "            LEFT JOIN "+RetSqlName("SDB")+" SDB " + c_EOL
c_Query += "             ON SDB.DB_FILIAL  = '"+ xFilial("SDB") +"'" + c_EOL
c_Query += "             AND SDB.DB_DOC     = SC6.C6_NOTA" + c_EOL
c_Query += "             AND SDB.DB_SERIE   = SC6.C6_SERIE" + c_EOL
c_Query += "             AND SDB.DB_PRODUTO = SC6.C6_PRODUTO" + c_EOL
c_Query += "             AND SDB.DB_LOCAL   = SC6.C6_LOCAL" + c_EOL
c_Query += "             AND SDB.DB_CLIFOR  = SC5.C5_CLIENTE" + c_EOL
c_Query += "             AND SDB.DB_LOJA    = SC5.C5_LOJACLI" + c_EOL
c_Query += "             AND SDB.DB_LOTECTL = SC9.C9_LOTECTL" + c_EOL
c_Query += "             AND SDB.D_E_L_E_T_ = ' '" + c_EOL*/

c_Query += "            LEFT JOIN "+RetSqlName("SB1")+" SB1 " + c_EOL
c_Query += "              ON SB1.B1_FILIAL  = '"+ xFilial("SB1") +"'" + c_EOL
c_Query += "             AND SB1.B1_COD     = SC6.C6_PRODUTO" + c_EOL
c_Query += "             AND SB1.D_E_L_E_T_ = ' '" + c_EOL

c_Query += "            LEFT JOIN "+RetSqlName("SA1")+" SA1 " + c_EOL
c_Query += "              ON SA1.A1_FILIAL  = '"+ xFilial("SA1") +"'" + c_EOL
c_Query += "             AND SA1.A1_COD     = SC5.C5_CLIENTE" + c_EOL
c_Query += "             AND SA1.A1_LOJA    = SC5.C5_LOJAENT" + c_EOL
c_Query += "             AND SA1.D_E_L_E_T_ = ' '" + c_EOL


c_Query += "           WHERE SC5.C5_FILIAL  = '"+ xFilial("SC5") +"'" + c_EOL
c_Query += "             AND SC5.C5_NUM     = '"+ MV_PAR01 + "'" + c_EOL
c_Query += "             AND SC5.D_E_L_E_T_ = ' '" + c_EOL

c_Query += "        ) XXX" + c_EOL
c_Query += "  GROUP BY C6_NUM, C5_EMISSAO, C5_TIPO, C5_XTTPPED, C5_XSITPM, C5_XENTRPM, C5_XORIGEM, C6_SERIE, C6_NOTA, /*D2_EMISSAO,*/ C5_CLIENTE, C5_LOJACLI, C5_LOJAENT, A1_NOME," + c_EOL
c_Query += "           A1_END, A1_BAIRRO, A1_MUN, A1_EST, A1_CEP, C5_TRANSP, C6_PRODUTO, C6_ITEM, C6_UM, B1_DESC, B1_PESO, C6_LOTECTL, C6_LOCALIZ, C6_LOCAL, " + c_EOL
c_Query += "           C5_MENNOTA, C9_NUMSEQ" + c_EOL

memowrite("MFATR002a.sql", c_Query)

c_Query := ChangeQuery(c_Query)
cAliasA:= GetNextAlias()

dbUseArea(.T.,"TOPCONN",TcGenQry(,,c_Query),cAliasA)
aEval(SC5->(dbStruct()),{|x| If(x[2]!="C", TcSetField(cAliasA,AllTrim(x[1]),x[2],x[3],x[4]),Nil)})
aEval(SC6->(dbStruct()),{|x| If(x[2]!="C", TcSetField(cAliasA,AllTrim(x[1]),x[2],x[3],x[4]),Nil)})
aEval(SC9->(dbStruct()),{|x| If(x[2]!="C", TcSetField(cAliasA,AllTrim(x[1]),x[2],x[3],x[4]),Nil)})
aEval(SD2->(dbStruct()),{|x| If(x[2]!="C", TcSetField(cAliasA,AllTrim(x[1]),x[2],x[3],x[4]),Nil)})
aEval(SB1->(dbStruct()),{|x| If(x[2]!="C", TcSetField(cAliasA,AllTrim(x[1]),x[2],x[3],x[4]),Nil)})

(cAliasA)->( dbGoTop() )
(cAliasA)->( dbEval( { || nTotReg++ },{ || .T. },{ || .T. } ) )
(cAliasA)->( dbGoTop() )

ProcRegua(nTotReg)

(cAliasA)->( dbGoTop() )
While (cAliasA)->(!Eof())
	IncProc(" Impressão de Materiais")
	
	If lAbortPrint
		@ nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
		Exit
	Endif
	
	If nLin > 57
		Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		nLin := 6
		
		If (cAliasA)->C5_TIPO $ 'B/D'
			DbSelectArea("SA2")
			DbSetOrder(1)
			DbSeek(xFilial("SA2")+(cAliasA)->C5_CLIENTE+(cAliasA)->C5_LOJACLI)
			c_nomecf	:=  SA2->A2_NOME
			c_end		:=  Alltrim(SA2->A2_END)
			c_bairro	:=  Alltrim(SA2->A2_BAIRRO)
			c_mun		:=  Alltrim(SA2->A2_MUN)
			c_est		:=  Alltrim(SA2->A2_EST)
			c_cep		:=  AllTrim(SA2->A2_CEP)
		Else
			DbSelectArea("SA1")
			DbSetOrder(1)
			DbSeek(xFilial("SA1")+(cAliasA)->C5_CLIENTE+(cAliasA)->C5_LOJACLI)
			c_nomecf	:=  SA1->A1_NOME
			c_end		:=  Alltrim(SA1->A1_END)
			c_bairro	:=  Alltrim(SA1->A1_BAIRRO)
			c_mun		:=  Alltrim(SA1->A1_MUN)
			c_est		:=  Alltrim(SA1->A1_EST)
			c_cep		:=  AllTrim(SA1->A1_CEP)
		EndIf
		
		@ nLin,000 Psay "Pedido.........: " + (cAliasA)->C6_NUM
		@ nLin,045 Psay "Emissao.: "        + Dtoc((cAliasA)->C5_EMISSAO)
		@ nLin,070 Psay "Origem..: "        + X3Combo("C5_XORIGE",(cAliasA)->C5_XORIGEM)
		nLin++; nLin := U_R002LINH(nLin)
		@ nLin,000 Psay "Nota Fiscal....: " + (cAliasA)->C6_NOTA+" - "+(cAliasA)->C6_SERIE
		@ nLin,045 Psay "Emissao.: " + Dtoc(GetAdvFval("SF2", "F2_EMISSAO", xFilial("SF2")+(cAliasA)->C6_NOTA+(cAliasA)->C6_SERIE, 1, "  /  / "))//+ Dtoc((cAliasA)->D2_EMISSAO)
		@ nLin,100 Psay Iif((cAliasA)->C5_XTTPPED == 'S', " ***** PEDIDO ESPECIAL ***** ","")
		nLin++; nLin := U_R002LINH(nLin)
		@ nLin,000 Psay "Cliente........: " + (cAliasA)->C5_CLIENTE+' - '+ Subs(c_nomecf,1,30)
		@ nLin,070 Psay "Loja....: "        + (cAliasA)->C5_LOJACLI
		nLin++; nLin := U_R002LINH(nLin)
		@ nLin,000 Psay "Endereço.......: " + c_end
		@ nLin,070 Psay "Bairro..: "        + c_bairro
		nLin++; nLin := U_R002LINH(nLin)
		@ nLin,000 Psay "Municipio......: " + c_mun
		@ nLin,070 Psay "Estado..: "        + c_est
		@ nLin,100 Psay "CEP.: "            + c_cep
		nLin+=2; nLin := U_R002LINH(nLin)
		@ nLin,000 Psay "Transportadora.: " + Alltrim((cAliasA)->C5_TRANSP) + " - " + GetAdvFval("SA4", "A4_NOME", xFilial('SA4')+(cAliasA)->C5_TRANSP, 1, '')
		
		nLin++; nLin := U_R002LINH(nLin)
		@ nlin,000 Psay __PrtThinLine()
		nLin+=2; nLin := U_R002LINH(nLin)
		@ nLin,000 Psay "Codigo          Descricao                                     Unid Amz       Qtde         Peso Lote       Endereço   "
		nLin++; nLin := U_R002LINH(nLin)
		@ nLin,000 Psay "--------------- --------------------------------------------- ---- --- ---------- ------------ ---------- ---------------"
		nLin++; nLin := U_R002LINH(nLin)
		
		DbSelectArea("SC5")
		SC5->(DbSetOrder(3))
		SC5->(DbSeek(xFilial("SC5") + (cAliasA)->C5_CLIENTE + (cAliasA)->C5_LOJACLI + (cAliasA)->C6_NUM ))
		                                 
		cObserv := AllTrim(SC5->C5_XOBS)
		cMensNF := AllTrim((cAliasA)->C5_MENNOTA)
		cInfoNF := AllTrim(SC5->C5_XINFCNF)
	EndIf
	
	DbSelectArea("SDB")
	DbSetOrder(1) //DB_FILIAL, DB_PRODUTO, DB_LOCAL, DB_NUMSEQ, DB_DOC, DB_SERIE, DB_CLIFOR, DB_LOJA, DB_ITEM, R_E_C_N_O_, D_E_L_E_T_
	c_Localiz := ''
	If DbSeek(xFilial("SDB")+(cAliasA)->C6_PRODUTO+(cAliasA)->C6_LOCAL+(cAliasA)->C9_NUMSEQ+(cAliasA)->C6_NOTA+(cAliasA)->C6_SERIE)
		c_Localiz := SDB->DB_LOCALIZ
	EndIf
	
	
	@ nLin,000 Psay (cAliasA)->C6_PRODUTO                                                    // Produto
	@ nLin,016 Psay Left((cAliasA)->B1_DESC,45)                                              // Descrição
	@ nLin,063 Psay (cAliasA)->C6_UM	                                                      // Unidade de Medida
	@ nLin,068 Psay (cAliasA)->C6_LOCAL                                                      // Armazem
	If (cAliasA)->C6_LOCAL == '77'
		@ nLin,071 Psay "PRODUTO JÁ ENTREGUE"
	Else
		@ nLin,071 Psay (cAliasA)->C6_QTDVEN                     Picture "@E 999,999.99"     // Quantidade
		@ nLin,082 Psay (cAliasA)->B1_PESO*(cAliasA)->C6_QTDVEN Picture "@E 999,999.9999"   // PESO
		@ nLin,095 Psay (cAliasA)->C6_LOTECTL                                                // Lote
		@ nLin,106 Psay If(empty(c_Localiz),(cAliasA)->C6_LOCALIZ,c_Localiz)                // Endereco
		nTotQtd  += (cAliasA)->C6_QTDVEN                                                     // Totaliza quantidade
		nTotPeso += (cAliasA)->C6_QTDVEN*(cAliasA)->B1_PESO                                 // Totaliza peso
	EndIf
	nLin++; nLin := U_R002LINH(nLin)
	
	
	(cAliasA)->( DbSkip() )
End-While

nLin+= 3; nLin := U_R002LINH(nLin)
@ nLin, 000  Psay "Data Separação..:  [    /    /   ]
nLin++; nLin := U_R002LINH(nLin)
@ nLin, 000  Psay "Nome Responsavel:  [			  	    ]"
nLin++; nLin := U_R002LINH(nLin)
@ nLin, 000  Psay "Quant. Volume...:  ["+Transform(nTotQtd , "@E 999,999.9999")+"]            [               ]"
nLin++; nLin := U_R002LINH(nLin)
@ nLin, 000  Psay "Peso Liquido....:  ["+Transform(nTotPeso, "@E 999,999.9999")+"]            [               ]"
nLin++; nLin := U_R002LINH(nLin)
@ nLin, 000  Psay "Observação......: "

If !Empty(cMensNF)
	For _n1 := 1 to (MLCount(cMensNF,112))
		@ nLin, 020  Psay Memoline(cMensNF,112,_n1)
		nLin++; nLin := U_R002LINH(nLin)
	Next _n1                                                                            
EndIf

If !Empty(cObserv)                                         
	For _n1 := 1 to (MLCount(cObserv,112))
		@ nLin, 020  Psay Memoline(cObserv,112,_n1)
		nLin++; nLin := U_R002LINH(nLin)
	Next _n1
EndIf

If !Empty(cInfoNF)
	For _n1 := 1 to (MLCount(cInfoNF,112))
		@ nLin, 020  Psay Memoline(cInfoNF,112,_n1)
		nLin++; nLin := U_R002LINH(nLin)
	Next _n1
EndIf
nLin+= 2; nLin := U_R002LINH(nLin)

@ nLin, 000  Psay "Estou de acordo que este material acima corresponde ao material solicitado"
nLin++; nLin := U_R002LINH(nLin)
@ nLin, 000  Psay "e que será faturado dentro deste mês."
nLin+=5; nLin := U_R002LINH(nLin)
@ nLin, 045  Psay "_____________________________"
nLin++; nLin := U_R002LINH(nLin)
@ nLin, 045  Psay "     Favor assinar e carimbar"

(cAliasA)->( DbCloseArea() )

Roda(cbCont,cbTxt,Tamanho)

SET DEVICE TO SCREEN
If aReturn[5]==1
	dbCommitAll()
	SET PRINTER TO
	OurSpool(wnrel)
Endif

MS_FLUSH()

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                                   MUL - T - LOCK                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºPrograma    ³ R002LINH  ³ Funcao de pular linha                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAutor       ³ Actual Trend - Marcelo Pagliotto                      ³ Data ³  26/08/09 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function R002LINH(nLin)
If nLin > 57
	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	nLin := 6
EndIf
Return(nLin)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                                   MUL - T - LOCK                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºPrograma    ³ R002PERG  ³ Funcao de perguntas                                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAutor       ³ Actual Trend - Marcelo Pagliotto                      ³ Data ³  26/08/09 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function R002PERG(cPerg)

Local aAreaAtu	:= GetArea()
Local aAreaSX1	:= SX1->( GetArea() )

PutSx1(	cPerg,	"01","Numero do pedido    ?", "", "", "mv_ch1", TAMSX3( "C5_NUM" )[3], TAMSX3( "C5_NUM" )[1],TAMSX3( "C5_NUM" )[2],0,"G","","","","N","mv_par01",   "",   "",   "","",   "",   "",   "","","","","","","","","","",{"Informe o Numero do pedido       ",""},{""},{""},"")

RestArea( aAreaSX1 )
RestArea( aAreaAtu )

Return(cPerg) 
