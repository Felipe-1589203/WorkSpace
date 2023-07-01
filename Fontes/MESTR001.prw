#INCLUDE "MESTR001.CH"
#INCLUDE "PROTHEUS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡Æo    ³ MESTR001 ³ Autor ³ Jesus Pedro           ³ Data ³ 13.11.97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡Æo ³ Pick-List de Vendas/Ordem de Producao (Localizacao Fisica  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ MATR265(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Rodrigo Sart³14/04/98³XXXXXX³ Alterada rotina e acrescentada impressao ³±±
±±³            ³        ³      ³ para Ordem de Producao.                  ³±±
±±³Rodrigo Sart³23/04/98³XXXXXX³ Incluida pergunta mv_par10               ³±±
±±³Rodrigo Sart³07/02/99³META  ³ Filtragem por Tipo de OP.                ³±±
±±³Wagner      ³30/03/99³20633A³ Acerto Indregua com SQL                  ³±±
±±³CesarValadao³30/03/99³XXXXXX³ Manutencao na SetPrint()                 ³±±
±±³CesarValadao³08/07/99³22222A³ Acerto para Nao Truncar Campos.          ³±±
±±³Aline C.Vale³15/07/99³22899A³ Inclusao da loja na pesquisa cliente/forn³±±
±±³Rodrigo Sart³06/08/99³xxxxxx³ Acerto na impressao qdo lista NF         ³±±
±±³Patricia Sal³20/12/99³xxxxxx³ Exclusao dos controles p/ amb. DOS.      ³±±
±±³Marcello    ³19/08/00³oooooo³Impressao da relacao em outras moedas     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
USer Function MESTR001()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL tamanho:="P"
LOCAL cDesc1 :=STR0001	//"Este relatorio tem o objetivo de facilitar a retirada de materiais"
LOCAL cDesc2 :=STR0002	//"apos o Faturamento de uma NF ou a Criacao de uma OP caso consumam"
LOCAL cDesc3 :=STR0003	//"materiais que utilizam o controle de Localizacao Fisica"
LOCAL cString:="SD2"
PRIVATE cbCont,cabec1,cabec2,cbtxt
PRIVATE cPerg  :="MTR265"
PRIVATE aReturn := {STR0004,1,STR0005, 2, 2, 1, "",0 }	//"Zebrado"###"Administracao"
PRIVATE nomeprog:="MESTR001",nLastKey := 0
PRIVATE li:=80, limite:=132, lRodape:=.F.
PRIVATE wnrel  := "MESTR001"
PRIVATE titulo :=STR0006	//"Pick-List Localizacao Fisica"
PRIVATE cSerIni := ""
PRIVATE cSerFin := ""


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cbtxt   := SPACE(10)
cbcont  := 0
Li      := 80
m_pag   := 1
cabec2  := ""

cabec1  := ""// STR0007 "ENDERECO        |LOTE          |COD.NYTRON     |COD.CLIENTE       |QUANTIDADE"
//                                1         2         3         4         5         6         7         8         9        10        11        12        13        14
//                       012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AjustaSX1()
pergunte( cPerg,.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01       	  Pick List   1 - NF  2 - OP                 ³
//³ mv_par02	     	  De  Nota Fiscal Venda                  ³
//³ mv_par03	     	  Ate Nota Fiscal Venda                  ³
//³ mv_par04	     	  De  Data de Entrega                    ³
//³ mv_par05	     	  Ate Data de Entrega                    ³
//³ mv_par06	     	  De  Cliente                            ³
//³ mv_par07	     	  Ate Cliente                            ³
//³ mv_par08	     	  De  Ordem de Producao                  ³
//³ mv_par09	     	  Ate Ordem de Producao                  ³
//³ mv_par10	     	  Qtd p/ impressao 1 - Original 2 - Saldo³
//³ mv_par11        Considera OPs 1- Firmes 2- Previstas 3- Ambas³
//³ mv_par12	     	  Moeda                                  ³
//³ mv_par13              Outras moedas                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

wnrel:=SetPrint(cString,wnrel,cPerg,@Titulo,cDesc1,cDesc2,cDesc3,.F.,,.F.,Tamanho)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Lista Pick-List para Nota Fiscal de Venda                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cSerIni := If(cPaisLoc=="BRA",MV_PAR14,MV_PAR16)
cSerFin := If(cPaisLoc=="BRA",MV_PAR15,MV_PAR17)
If mv_par01 == 1
	titulo  += STR0008	//" (Nota Fiscal de Venda)"
	RptStatus({|lEnd| R001IMNF(@lEnd,tamanho,titulo,wnRel,cString)},titulo)
ElseIf mv_par01 == 2
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Lista Pick-List para Ordem de Producao                      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	titulo  += STR0009	//" (Ordem de Producao)"
	RptStatus({|lEnd| R001IMOP(@lEnd,tamanho,titulo,wnRel,cString)},titulo)
ElseIf cPaisLoc # "BRA"
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Lista Pick-List para Remito                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	If cPaisloc $ "CHI"
		titulo  += " (" + STR0030 + ") "	//" (Remitos)"
	Elseif cPaisloc $ "COL|MEX|PAR"
		titulo  += " (" + STR0031 + ") "	//" (Remitos)"
	Elseif cPaisloc $ "EUA|POR"
		titulo  += " (" + STR0032 + ") "	//" (Remitos)"
	Elseif cPaisloc $ "ARG|URU"
		titulo  += " (" + STR0029 + ") "	//" (Remitos)"
	Endif
	RptStatus({|lEnd| R001IREM(@lEnd,tamanho,titulo,wnRel,cString)},titulo)
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡Æo    ³ R001IMNF ³ Autor ³ Jesus Pedro           ³ Data ³ 13.11.97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡Æo ³ Chamada do Relatorio para Pick-List da Nota Fiscal de Venda³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR265	                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R001IMNF( lEnd, tamanho, titulo, wnRel )
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL bBlock, cChaveAnt:="",cChaveDB:=""
LOCAL lExistBlock:=ExistBlock("MR265MAIL")
Local n2
Local cDescric := ""
Local nLiDescr := 0
PRIVATE cNfAnt := Space(6)
PRIVATE nValorNf := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Coloca areas nas Ordens Corretas                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SB1")
dbSetOrder(1)

dbSelectArea("SD2")
dbSetOrder(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta filtro e indice da IndRegua                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cIndex :="D2_FILIAL+D2_DOC+D2_SERIE+D2_ITEM+D2_COD+D2_ITEMPV+D2_LOTECTL+D2_NUMLOTE"

cExpres:='D2_FILIAL=="'+xFilial()+'".And.'
cExpres+='D2_DOC>="'+mv_par02+'".And.D2_DOC<="'+mv_par03+'".And.'
If cPaisLoc<>"BRA"
	cExpres+=' !('+IsRemito(2,'SD2->D2_TIPODOC')+') .And. '
Endif
cExpres+='D2_SERIE>="'+cSerIni+'" .And. '
If !Empty(cSerFin)
	cExpres+='D2_SERIE<="'+cSerFin+'" .And. '
Endif
cExpres+='D2_CLIENTE>="'+mv_par06+'".And.D2_CLIENTE<="'+mv_par07+'" .And. '
cExpres+='D2_LOCAL  >="'+Mv_par16+'".And.D2_LOCAL  <="'+Mv_par17+'"'

cSD2ntx := CriaTrab(,.F.)
IndRegua("SD2", cSD2ntx, cIndex,,cExpres,STR0010)	//"Selecionando Registros ..."
nIndex := RetIndex("SD2")
#IFNDEF TOP
	dbSetIndex(cSD2ntx+OrdBagExt())
#ENDIF
dbSetOrder( nIndex+1 )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica o numero de registros validos para a SetRegua ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbGoTop()
SetRegua(LastRec())

cChaveAnt := "????????????????"

SB8->(dbSetOrder(1))

While !Eof()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se o usuario interrompeu o relatorio                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lAbortPrint
		@Prow()+1,001 PSAY STR0011	//"CANCELADO PELO OPERADOR"
		Exit
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica os parametros para data de entrega                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	_cPedcli := ""
	_cOBSPed := ""
	dbSelectArea("SC5")
	dbSetOrder( 1 )
	If dbSeek( xFilial( "SC5" ) + SD2->D2_PEDIDO)
		_cPedcli := "" //ActualTrend SC5->C5_XPEDCLI
		_cOBSPed := SC5->C5_XOBS
	endif
	
	
	dbSelectArea("SC6")
	dbSetOrder( 1 )
	If !dbSeek( xFilial( "SC6" ) + SD2->D2_PEDIDO + SD2->D2_ITEMPV + ;
		SD2->D2_COD ) .Or. ( C6_ENTREG < mv_par04 .Or. C6_ENTREG > mv_par05 )
		dbSelectArea("SD2")
		IncRegua()
		dbSkip()
		Loop
	EndIf
	
	dbSelectArea( "SF2" )
	dbSetOrder( 1 )
	dbSeek( xFilial() + SD2->D2_DOC )
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica Moeda                                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	if mv_par13==2  //nao imprimir notas com moeda diferente da escolhida
		if if(F2_MOEDA==0,1,F2_MOEDA)!=mv_par12
			dbselectarea("SD2")
			IncRegua()
			dbskip()
			loop
		endif
	endif
	
	dbSelectArea( "SB1" )
	dbSeek( xFilial() + SD2->D2_COD )
	
	If SF2->F2_TIPO $ "DºB"
		dbSelectArea( "SA2" )
		dbSetOrder( 1 )
		dbSeek( xFilial() + SD2->D2_CLIENTE + SD2->D2_LOJA )
	Else
		dbSelectArea( "SA1" )
		dbSetOrder( 1 )
		dbSeek( xFilial() + SD2->D2_CLIENTE + SD2->D2_LOJA)
	EndIf
	
	dbSelectArea( "SA4" )
	dbSetOrder( 1 )
	dbSeek( xFilial() + SF2->F2_TRANSP )
	
	dbSelectArea( "SC9" )
	
	nValorNf += xmoeda(SD2->D2_TOTAL,SF2->F2_MOEDA,mv_par12,SF2->F2_EMISSAO,msdecimais(mv_par12)+1,SF2->F2_TXMOEDA)
	
	If cChaveAnt == SD2->D2_FILIAL + SD2->D2_DOC + SD2->D2_SERIE + SD2->D2_ITEM +;
		SD2->D2_COD + SD2->D2_ITEMPV + SD2->D2_LOTECTL
		dbSelectArea( "SD2" )
		cChaveAnt := D2_FILIAL + D2_DOC + D2_SERIE + D2_ITEM + D2_COD + D2_ITEMPV + D2_LOTECTL
		dbSkip()
		Loop
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Lista o cabecalho da Nota Fiscal                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	R001CABE(Tamanho) // Jean
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Lista o detalhe da Nota Fiscal                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	//	R001DETA(Tamanho) // Jean
	
	If Localiza( SD2->D2_COD )
		dbSelectArea( "SDB" )
		dbSetOrder( 1 )
		cChaveDB :=xFilial("SDB")+SD2->D2_COD+SD2->D2_LOCAL+SD2->D2_NUMSEQ+SD2->D2_DOC+SD2->D2_SERIE+SD2->D2_CLIENTE+SD2->D2_LOJA
		If dbSeek( cChaveDB )
			While !Eof() .And. cChaveDB == DB_FILIAL+DB_PRODUTO+DB_LOCAL+DB_NUMSEQ+DB_DOC+DB_SERIE+DB_CLIFOR+DB_LOJA
				If DB_ESTORNO == "S"
					dbSkip()
					Loop
				EndIf
				
				cDescric := Posicione("SC6", 5, xFilial("SC6") + SF2->F2_CLIENTE + SF2->F2_LOJA + SD2->D2_COD, "C6_DESCRI" )
				nLiDescr := MlCount(cDescric,15)
				
				@ Li,000 PSAY DB_LOCALIZ       Picture PesqPict("SDB","DB_LOCALIZ",15)
				@ Li,016 PSAY "|"
				@ Li,017 PSAY DB_LOCAL         Picture PesqPict("SDB","DB_LOCAL")
				@ Li,025 PSAY "|"
				@ Li,026 PSAY SD2->D2_LOTECTL  Picture PesqPict("SD2","D2_LOTECTL",10)
				@ Li,037 PSAY "|"
				@ Li,038 PSAY SD2->D2_COD	    Picture PesqPict("SD2","D2_COD",15)
				@ Li,054 PSAY "|"
				@ Li,055 PSAY MemoLine(cDescric,14,1)
				@ Li,070 PSAY "|"
				@ Li,071 PSAY DB_QUANT  Picture "@E 99999" //Picture PesqPictQt("DB_QUANT",14)
				
				For n2 := 2 To nLiDescr
					If !Empty((MemoLine(cDescric,14,n2)))
						Li++
						@ Li,016 PSAY "|"
						@ Li,025 PSAY "|"
						@ Li,037 PSAY "|"
						@ Li,054 PSAY "|"
						@ Li,055 PSAY MemoLine(cDescric,14,n2)
						@ Li,070 PSAY "|"
					EndIf
				Next
				
				dbSkip()
				
				@ Li,000 Psay Replicate("_",80)
				Li++
				If Li > 55
					roda(cbcont,cbtxt,tamanho)
					R001CABE(Tamanho)
				EndIf
				
				
				//@ Li,065 PSAY  GetAdvFval("SA7","A7_CODCLI","  "+SF2->F2_CLIENTE+SF2->F2_LOJA+SD2->D2_COD,1,"")
				/*
				//				@ Li,086 PSAY DB_NUMSERI Picture PesqPict("SDB","DB_NUMSERI",20)
				DbSelectarea("SA7")
				DbSetOrder(1)
				DbSeek("  "+SF2->F2_CLIENTE+SF2->F2_LOJA+SD2->D2_COD,.t.)
				cProcCli := SA7->A7_CODCLI
				
				dbSelectArea( "SDB" )
				*/
				//				@ li,122 PSAY SD2->D2_DTVALID Picture PesqPict("SD2","D2_DTVALID",10)
				//				@ li,136 PSAY SD2->D2_POTENCI Picture PesqPictQt("D2_POTENCI", 14)
			EndDo
		Else
			dbSelectArea( "SC9" )
			dbSetOrder( 2 )
			cChaveC9 := xFilial( "SC9" ) + SD2->D2_CLIENTE + SD2->D2_LOJA + ;
			SD2->D2_PEDIDO + SD2->D2_ITEMPV
			dbSeek( cChaveC9 )
			While !Eof() .And. cChaveC9 == C9_FILIAL + C9_CLIENTE + C9_LOJA + ;
				C9_PEDIDO + C9_ITEM
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Verifica se a liberacao ja foi faturada  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If Rastro( SD2->D2_COD, "S" )
					bBlock  := { || C9_PRODUTO + C9_NUMLOTE + C9_NFISCAL + ;
					C9_SERIENF <> SD2->D2_COD + SD2->D2_NUMLOTE + SD2->D2_DOC +;
					SD2->D2_SERIE }
				ElseIf Rastro( SC9->C9_PRODUTO, "L" )
					bBlock  := { || C9_PRODUTO + C9_LOTECTL + C9_NFISCAL + ;
					C9_SERIENF <> SD2->D2_COD + SD2->D2_LOTECTL + SD2->D2_DOC +;
					SD2->D2_SERIE  }
				Else
					bBlock  := { || C9_PRODUTO + C9_NFISCAL + C9_SERIENF <> ;
					SD2->D2_COD + SD2->D2_DOC + SD2->D2_SERIE }
				EndIf
				
				If C9_BLEST <> "10" .Or. C9_BLCRED <> "10" .Or. Eval( bBlock )
					dbSkip()
					Loop
				EndIf
				dbSelectArea('SDC')
				dbSetOrder(1)
				If Rastro(SD2->D2_COD, 'S')
					bBlock  := {|| SC9->C9_LOTECTL+SC9->C9_NUMLOTE == DC_LOTECTL+DC_NUMLOTE}
					cChave  := xFilial()+SC9->C9_PRODUTO+SD2->D2_LOCAL+'SC6'+SC9->C9_PEDIDO+SC9->C9_ITEM+SC9->C9_SEQUEN
					cChave2 := SC9->C9_LOTECTL+SC9->C9_NUMLOTE
				ElseIf Rastro(SC9->C9_PRODUTO, 'L')
					bBlock  := {|| SC9->C9_LOTECTL == DC_LOTECTL}
					cChave  := xFilial()+SC9->C9_PRODUTO+SD2->D2_LOCAL+'SC6'+SC9->C9_PEDIDO+SC9->C9_ITEM+SC9->C9_SEQUEN
					cChave2 := SC9->C9_LOTECTL
				Else
					bBlock  := {|| .T.}
					cChave  := xFilial()+SC9->C9_PRODUTO+SD2->D2_LOCAL+'SC6'+SC9->C9_PEDIDO+SC9->C9_ITEM+SC9->C9_SEQUEN
					cChave2 := ''
				EndIf
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Varre composicao do empenho                                  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If dbSeek(cChave+cChave2, .F.)
					Do While !Eof() .And. cChave==DC_FILIAL+DC_PRODUTO+DC_LOCAL+DC_ORIGEM+DC_PEDIDO+DC_ITEM+DC_SEQ .And. Eval(bBlock)
						@ Li, 000 PSAY DC_LOCALIZ Picture PesqPict('SDC', 'DC_LOCALIZ', 15)
						//	@ Li, 086 PSAY DC_NUMSERI Picture PesqPict('SDC', 'DC_NUMSERI', 20)
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³Lista quantidade de acordo com o parametro selecionado        ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						SB8->(dbSeek(xFilial("SB8") + SDC->(DC_PRODUTO+DC_LOCAL+DTOS(SC9->C9_DTVALID)+DC_LOTECTL+DC_NUMLOTE)))
						If mv_par10 == 1
							@ Li, 071 PSAY DC_QTDORIG Picture "@E 99999" //Picture PesqPictQt('DC_QTDORIG',14)
							//		@ li,122 PSAY SC9->C9_DTVALID Picture PesqPict("SC9","C9_DTVALID",10)
							//							@ li,136 PSAY SB8->B8_POTENCI Picture PesqPictQt("B8_POTENCI", 14)
						Else
							@ Li, 071 PSAY DC_QUANT Picture "@E 99999" //Picture PesqPictQt('DC_QUANT',14)
							//			@ li,122 PSAY SC9->C9_DTVALID Picture PesqPict("SC9","C9_DTVALID",10)
							//							@ li,136 PSAY SB8->B8_POTENCI Picture PesqPictQt("B8_POTENCI", 14)
						EndIf
						dbSelectArea('SDC')
						dbSkip()
						//		Li++
						If Li > 55
							Roda(cbcont,cbtxt,tamanho)
							R001CABE()
							R001DETA()
						EndIf
					EndDo
				EndIf
				dbSelectArea('SC9')
				dbSkip()
			EndDo
		EndIf
	Else
		@ Li,016 PSAY "|"
		@ Li,025 PSAY "|"
		@ Li,037 PSAY "|"
		@ Li,054 PSAY "|"
		@ Li,070 PSAY "|"
		@ Li,071 PSAY SD2->D2_QUANT Picture "@E 99999" //Picture PesqPictQt("D2_QUANT",14)
		Li++
	EndIf
	dbSelectArea("SD2")
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Valor da N.f.                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//	Li++
	cNfAnt := SD2->D2_DOC
	IncRegua()
	dbSelectArea( "SD2" )
	cChaveAnt := D2_FILIAL + D2_DOC + D2_SERIE + D2_ITEM + D2_COD + D2_ITEMPV + D2_LOTECTL
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Executa EXECBLOCK p/ envio de e-mail ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lExistBlock
		ExecBlock("MR265MAIL",.F.,.F.)
	EndIf
	dbSkip()
	
	/*
	If SD2->D2_DOC != cNfAnt
	Li++
	@ Li, 00 PSAY STR0012 + Transform( nValorNf,PesqPict("SD2","D2_TOTAL",16,SF2->F2_MOEDA))    //"VALOR DA NOTA FISCAL: "
	Li++
	Li++
	@ Li, 00 PSAY STR0013	//"OBSERVACAO: "
	nValorNf := 0
	EndIf
	*/
	
	If SD2->D2_DOC != cNfAnt
		
		Li++
		@ 	Li++,000 Psay "Separador:                Conferente:               Motorista: "
		Li++
		Li++
		@ 	Li++,000 Psay "______________________    _______________________   ________________________ "
		Li++
	EndIf
EndDo


If Li != 80
	roda(cbcont,cbtxt,tamanho)
EndIf

dbSelectArea("SD2")
RetIndex("SD2")
Ferase( cSD2ntx + OrdBagExt() )

If aReturn[5] = 1
	Set Printer TO
	dbCommitAll()
	OurSpool(wnrel)
Endif

MS_FLUSH()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡Æo    ³ R001CABE ³ Autor ³ Jesus Pedro           ³ Data ³ 13.11.97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡Æo ³ Imprime o cabecalho do relatorio por PV                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR265	                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R001CABE(Tamanho)

Local n2

If Li > 55 .Or. SD2->D2_DOC != cNfAnt
	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,18)
	If SF2->F2_TIPO $ "DºB"
		@ Li, 00 PSAY STR0014 + AllTrim(SA2->A2_COD) + "/" + SA2->A2_LOJA + " - " + SA2->A2_NOME	//"CLIENTE/FORN.: "
		Li+=2
		@ Li, 00 PSAY STR0015 + AllTrim(SA2->A2_MUN) + " - " + SA2->A2_EST	//"MUNICIPIO....: "
		Li+=2
	Else
		@ Li, 00 PSAY STR0014 + AllTrim( SA1->A1_COD) + "/" + SA1->A1_LOJA + " - " + SA1->A1_NOME	//"CLIENTE/FORN.: "
		Li++
		@ Li, 00 Psay "ENDERECO.....: " + Alltrim(SA1->A1_END)+" - "+Alltrim(SA1->A1_BAIRRO)
		Li++
		@ Li, 00 PSAY STR0015 + AllTrim(SA1->A1_MUN) + " - " + SA1->A1_EST	+" - CEP: "+SA1->A1_CEP//"MUNICIPIO....: "
		Li++
		@ Li, 00 Psay "FONE.........: " + Alltrim(SA1->A1_DDD)+" - "+Alltrim(SA1->A1_TEL)+" - CGC: " + SA1->A1_CGC+ " - Ins.Est: " +SA1->A1_INSCR
		Li++
	EndIf
	@ Li, 00 PSAY STR0016 + Alltrim(SD2->D2_DOC)	//"NOTA FISCAL..: "
	//	cTxt := Padr(Alltrim(Upper(RetTitle("D2_SERIE"))),Len(STR0015)-1,".")
	//    @ Li,23 PSAY cTxt + ": " + SD2->D2_SERIE
	@ Li,23 PSAY " / " + SD2->D2_SERIE
	
	@ Li, 43 PSAY STR0017 + SD2->D2_PEDIDO	//"PEDIDO.......: "
	Li++
	@ Li, 00 PSAY STR0018 + SA4->A4_NOME	//"TRANSPORTE...: "
	Li++
	@ Li, 00 PSAY STR0019 + AllTrim( Str( SF2->F2_VOLUME1 ) )	//"VOLUME.......: "
	@ Li, 45 PSAY STR0020 + SF2->F2_ESPECI1	//"ESPECIE....: "
	Li++
	@ Li, 00 PSAY STR0021 + Transform( SF2->F2_PLIQUI,PesqPict( "SF2", "F2_PLIQUI" ) )	//"PESO LIQ.....: "
	@ Li, 45 PSAY STR0022 + Transform( SF2->F2_PBRUTO,PesqPict( "SF2", "F2_PBRUTO" ) )	//"PESO BRUTO.: "
	Li++
	
	//@ Li, 00 PSAY "PED.CLIENTE:    ###  " + _cPedcli + " ###"  ActualTrend
	//Li++
	
	@ Li, 00 PSAY "OBS.PEDIDO ..: "
	nObsPed := MlCount(_cOBSPed,65)
	If nObsPed > 0
		For n2 := 1 To nObsPed
			If !Empty((MemoLine(_cOBSPed,65,n2)))
				@Li,15 PSay MemoLine(_cOBSPed,65,n2)
				Li++
			EndIf
		Next
	Else
		@Li,15 PSay _cOBSPed
		Li++
	EndIf
	
	@ Li,000 Psay Replicate("_",80)
	Li++
	//	@ Li,000 Psay "ENDERECO        |LOTE          |COD.NYTRON     |COD.CLIENTE       |QUANTIDADE" // Jean
	@ Li,000 Psay "ENDERECO        |ARMAZEM |LOTE       |COD.PRODUTO     |DESCRICAO      |QUANTID. " // Jean
	//           01234567890123456789012345678901234567890123456789012345678901234567890123456789
	//                    10         2        3         4         5         6         7
	@ Li,000 Psay Replicate("_",80)
	Li++
Endif
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡Æo    ³ R001DETA ³ Autor ³ Jesus Pedro           ³ Data ³ 13.11.97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡Æo ³ Imprime o detalhe da Nota Fiscal de Venda                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR265	                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R001DETA_(Tamanho)
//@ Li,16 PSAY Left(SB1->B1_DESC,30)	Picture PesqPict("SB1","B1_DESC",30)
//@ Li,47 PSAY SB1->B1_UM					Picture PesqPict("SB1","B1_UM",2)
@ Li,016 PSAY SD2->D2_LOTECTL			Picture PesqPict("SD2","D2_LOTECTL",10)
@ Li,030 PSAY SD2->D2_COD				Picture PesqPict("SD2","D2_COD",15)
//@ Li,61 PSAY SD2->D2_NUMLOTE			Picture PesqPict("SD2","D2_NUMLOTE",6)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡Æo    ³ R001IMOP ³ Autor ³Rodrigo de A. Sartorio ³ Data ³ 14.04.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡Æo ³ Chamada do Relatorio para Pick-List da Ordem de Producao   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR265	                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R001IMOP( lEnd, tamanho, titulo, wnRel )
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL cChave,cCompara
PRIVATE cOpAnt := Space(11)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Coloca areas nas Ordens Corretas                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SB1")
dbSetOrder(1)

dbSelectArea("SD4")
dbSetOrder(2)

dbSelectArea("SDC")
dbSetOrder(2)

dbSelectArea("SC2")
dbSetOrder(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta filtro e indice da IndRegua                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cIndex:=IndexKey()

cExpres:='C2_FILIAL=="'+xFilial()+'".And.'
cExpres+='C2_NUM+C2_ITEM+C2_SEQUEN+C2_ITEMGRD>="'+mv_par08+'".And.'
cExpres+='C2_NUM+C2_ITEM+C2_SEQUEN+C2_ITEMGRD<="'+mv_par09+'".And.'
cExpres+='DTOS(C2_DATPRF)>="'+DTOS(mv_par04)+'".And.'
cExpres+='DTOS(C2_DATPRF)<="'+DTOS(mv_par05)+'"'

cSC2ntx := CriaTrab(,.F.)
IndRegua("SC2", cSC2ntx, cIndex,,cExpres,STR0010)	//"Selecionando Registros ..."
nIndex := RetIndex("SC2")
#IFNDEF TOP
	dbSetIndex(cSC2ntx+OrdBagExt())
#ENDIF
dbSetOrder( nIndex+1 )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica o numero de registros validos para a SetRegua ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbGoTop()
SetRegua(LastRec())

cChaveAnt := "????????????????"

While !Eof()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se o usuario interrompeu o relatorio                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	If lAbortPrint
		@Prow()+1,001 PSAY STR0011	//"CANCELADO PELO OPERADOR"
		Exit
	Endif
	
	If !MtrAvalOp(mv_par11)
		dbSkip()
		Loop
	EndIf
	
	dbSelectArea("SB1")
	dbSeek(xFilial()+SC2->C2_PRODUTO)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Lista o cabecalho da Ordem de Producao                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	R001CBOP(Tamanho)
	
	dbSelectArea("SD4")
	dbSeek(xFilial()+cOPAnt)
	While !Eof() .And. D4_FILIAL+D4_OP == xFilial()+cOpAnt
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Lista o detalhe da ordem de producao                         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		R001CBOP(Tamanho)
		R001DETA(Tamanho)
		If Localiza(SD4->D4_COD)
			dbSelectArea("SDC")
			cChave := ''
			If Rastro(SD4->D4_COD)
				cChave:=xFilial()+SD4->D4_COD+SD4->D4_LOCAL+SD4->D4_OP+SD4->D4_TRT+SD4->D4_LOTECTL+SD4->D4_NUMLOTE
				cCompara:="DC_FILIAL+DC_PRODUTO+DC_LOCAL+DC_OP+DC_TRT+DC_LOTECTL+DC_NUMLOTE"
			ElseIf !Rastro(SD4->D4_COD)
				cChave:=xFilial()+SD4->D4_COD+SD4->D4_LOCAL+SD4->D4_OP+SD4->D4_TRT
				cCompara:="DC_FILIAL+DC_PRODUTO+DC_LOCAL+DC_OP+DC_TRT"
			EndIf
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Varre composicao do empenho                                  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If !Empty(cChave) .AND. dbSeek(cChave)
				Do While !Eof() .And. cChave == &(cCompara)
					R001CBOP(Tamanho)
					@ Li,016 PSAY DC_LOTECTL	Picture PesqPict("SDC","DC_LOTECTL",10)
					//					@ Li,61 PSAY DC_NUMLOTE	Picture PesqPict("SDC","DC_NUMLOTE",6)
					@ Li,000 PSAY DC_LOCALIZ Picture PesqPict("SDC","DC_LOCALIZ",15)
					//					@ Li,86 PSAY DC_NUMSERI Picture PesqPict("SDC","DC_NUMSERI",20)
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Lista quantidade de acordo com o parametro selecionado        ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If mv_par10 == 1
						@ Li,064 PSAY DC_QTDORIG Picture PesqPictQt("DC_QTDORIG",14)
						//						@ li,122 PSAY SD4->D4_DTVALID Picture PesqPict("SD4","D4_DTVALID",10)
						//						@ li,136 PSAY SD4->D4_POTENCI Picture PesqPictQt("D4_POTENCI", 14)
					Else
						@ Li,064 PSAY DC_QUANT Picture PesqPictQt("DC_QUANT",14)
						//					@ li,122 PSAY SD4->D4_DTVALID Picture PesqPict("SD4","D4_DTVALID",10)
						//						@ li,136 PSAY SD4->D4_POTENCI Picture PesqPictQt("D4_POTENCI", 14)
					EndIf
					Li++
					dbSkip()
				EndDo
			Else
				@ Li,064 PSAY SD4->D4_QUANT Picture PesqPictQt("D4_QUANT",14)
			EndIf
		Else
			@ Li,064 PSAY SD4->D4_QUANT Picture PesqPictQt("D4_QUANT",14)
			//			@ li,122 PSAY SD4->D4_DTVALID Picture PesqPict("SD4","D4_DTVALID",10)
			//			@ li,136 PSAY SD4->D4_POTENCI Picture PesqPictQt("D4_POTENCI", 14)
		EndIf
		Li++
		dbSelectArea("SD4")
		dbSkip()
	EndDo
	dbSelectArea("SC2")
	dbSkip()
EndDo

If Li != 80
	roda(cbcont,cbtxt,tamanho)
EndIf

dbSelectArea("SC2")
RetIndex("SC2")
Ferase(cSC2ntx+OrdBagExt())

If aReturn[5] = 1
	Set Printer TO
	dbCommitAll()
	OurSpool(wnrel)
Endif

MS_FLUSH()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡Æo    ³ R001CBOP ³ Autor ³Rodrigo de A. Sartorio ³ Data ³ 14.04.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡Æo ³ Imprime o cabecalho do relatorio por Ordem de Producao     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR265	                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R001CBOP(Tamanho)
Local aArea    := GetArea()
Local aAreaSB1 := SB1->(GetArea())
If Li > 55 .Or. SC2->C2_NUM+SC2->C2_ITEM+SC2->C2_SEQUEN+SC2->C2_ITEMGRD != cOpAnt
	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,18)
	@ Li, 00 PSAY STR0023+SC2->C2_NUM+SC2->C2_ITEM+SC2->C2_SEQUEN+SC2->C2_ITEMGRD	//"ORDEM DE PRODUCAO: "
	Li+=2
	SB1->(dbSeek(xFilial("SB1")+SC2->C2_PRODUTO))
	@ Li, 00 PSAY STR0024+SC2->C2_PRODUTO+" - "+SB1->B1_DESC	//"PRODUTO..........: "
	Li+=2
	@ Li, 00 PSAY STR0025	//"DATA PREV. INICIO: "
	@ Li, 19 PSAY SC2->C2_DATPRI
	Li+=2
	@ Li, 00 PSAY STR0026	//"DATA PREV. ENTREG: "
	@ Li, 19 PSAY SC2->C2_DATPRF
	Li+=2
	@ Li, 00 PSAY STR0027+Transform(SC2->C2_QUANT,PesqPictQt("C2_QUANT",14))	//"QUANTIDADE.......: "
	Li+=2
	@ Li, 00 PSAY STR0028+SC2->C2_OBS	//"OBSERVACAO.......: "
	Li+=2
	@ Li,00 PSAY __PrtThinLine()
	Li+=2
	cOPAnt:=SC2->C2_NUM+SC2->C2_ITEM+SC2->C2_SEQUEN+SC2->C2_ITEMGRD
Endif
RestArea(aAreaSB1)
RestArea(aArea)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡Æo    ³ R001DETA ³ Autor ³Rodrigo de A. Sartorio ³ Data ³ 14.04.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡Æo ³ Imprime o detalhe da Ordem de Producao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR265	                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R001DETA(Tamanho)
Local cAlias:=Alias()
//@ Li,16 PSAY Left(SB1->B1_DESC,30)	Picture PesqPict("SB1","B1_DESC",30)
//@ Li,47 PSAY SB1->B1_UM					Picture PesqPict("SB1","B1_UM",2)
If !Localiza(SD4->D4_COD)
	@ Li,016 PSAY SD4->D4_LOTECTL	Picture PesqPict("SD4","D4_LOTECTL",10)
	//	@ Li,61 PSAY SD4->D4_NUMLOTE	Picture PesqPict("SD4","D4_NUMLOTE",6)
EndIf
dbSelectArea("SB1")
dbSeek(xFilial()+SD4->D4_COD)
@ Li,030 PSAY SD4->D4_COD				Picture PesqPict("SD4","D4_COD",15)

dbSelectArea(cAlias)
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³R001IREM  ºAutor  ³Guilherme C. Leal   º Data ³  04/18/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Picking List por/by Remito								  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function R001IREM( lEnd, tamanho, titulo, wnRel )
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL cChaveAnt:="",cChaveDB:=""
LOCAL lExistBlock:=ExistBlock("MR265MAIL")
PRIVATE cNfAnt := Space(TamSX3("D2_DOC")[1])
PRIVATE cSerAnt:= Space(TamSX3("D2_SERIE")[1])
PRIVATE nValorNf := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Coloca areas nas Ordens Corretas                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SB1")
dbSetOrder(1)

dbSelectArea("SD2")
dbSetOrder(3)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta filtro e indice da IndRegua                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cIndex :="D2_FILIAL+D2_DOC+D2_ITEM+D2_COD+D2_LOTECTL+D2_NUMLOTE"

cExpres:='D2_FILIAL=="'+xFilial()+'".And.'
cExpres+='D2_DOC >= "' + mv_par14 + '".And. D2_DOC<= "'+mv_par15+'".And.'
cExpres+='D2_CLIENTE>= "'+mv_par06+'".And. D2_CLIENTE<="'+mv_par07+'" .And. '
cExpres+='D2_LOCAL  >="'+Mv_par16+'".And.D2_LOCAL  <="'+Mv_par17+'"'
cExpres+='.And. ('+IsRemito(2,'SD2->D2_TIPODOC')+')'
cSD2ntx := CriaTrab(,.F.)
IndRegua("SD2", cSD2ntx, cIndex,,cExpres,STR0010)	//"Selecionando Registros ..."
nIndex := RetIndex("SD2")
#IFNDEF TOP
	dbSetIndex(cSD2ntx+OrdBagExt())
#ENDIF
dbSetOrder( nIndex+1 )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica o numero de registros validos para a SetRegua ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbGoTop()
SetRegua(LastRec())

cChaveAnt := "????????????????"

cNfAnt := Space(TamSX3("D2_DOC")[1])
cSerAnt:= Space(TamSX3("D2_SERIE")[1])

While !Eof()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se o usuario interrompeu o relatorio                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lAbortPrint
		@Prow()+1,001 PSAY STR0011	//"CANCELADO PELO OPERADOR"
		Exit
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica Moeda                                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	if mv_par13==2  //nao imprimir remitos com moeda diferente da escolhida
		if if(D2_MOEDA==0,1,D2_MOEDA)!=mv_par12
			dbselectarea("SD2")
			IncRegua()
			dbskip()
			loop
		endif
	endif
	
	dbSelectArea( "SB1" )
	dbSeek( xFilial() + SD2->D2_COD )
	
	If SD2->D2_TIPO =="D"      // Devolucao/Devolucion/Return
		dbSelectArea( "SA2" )
		dbSetOrder(1)
		dbSeek( xFilial() + SD2->D2_CLIENTE + SD2->D2_LOJA )
	Else
		dbSelectArea( "SA1" )
		dbSetOrder( 1 )
		dbSeek( xFilial() + SD2->D2_CLIENTE + SD2->D2_LOJA)
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Cabecalho do Remito/Encabezado del Remito/Remitos Header     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	R001CREM(Tamanho)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Detalhe do Remito/Detalle del Remito/Remito Detail           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	R001DREM(Tamanho)
	
	If Localiza( SD2->D2_COD )
		dbSelectArea( "SDB" )
		dbSetOrder(1)
		
		cChaveDB := xFilial("SDB")+SD2->D2_COD+SD2->D2_LOCAL+SD2->D2_NUMSEQ+SD2->D2_DOC+SD2->D2_SERIE+SD2->D2_CLIENTE+SD2->D2_LOJA
		If dbSeek(cChaveDB)
			While !Eof() .And. cChaveDB == DB_FILIAL+DB_PRODUTO+DB_LOCAL+DB_NUMSEQ+DB_DOC+DB_SERIE+DB_CLIFOR+DB_LOJA
				If DB_ESTORNO == "S"
					dbSkip()
					Loop
				EndIf
				@ Li,000 PSAY DB_LOCALIZ Picture PesqPict("SDB","DB_LOCALIZ",15)
				//  				@ Li,86 PSAY DB_NUMSERI Picture PesqPict("SDB","DB_NUMSERI",20)
				@ Li,064 PSAY DB_QUANT Picture PesqPictQt("DB_QUANT",14)
				dbSkip()
				Li := Li + 1
				If Li > 55
					roda(cbcont,cbtxt,tamanho)
					R001CREM(Tamanho)
					R001DREM(Tamanho)
				EndIf
			EndDo
		Else
		EndIf
	Else
		@ Li, 064 PSAY SD2->D2_QUANT Picture PesqPictQt("D2_QUANT",14)
	EndIf
	dbSelectArea("SD2")
	
	Li++
	IncRegua()
	dbSelectArea( "SD2" )
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Executa EXECBLOCK p/ envio de e-mail ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lExistBlock
		ExecBlock("MR265MAIL",.F.,.F.)
	EndIf
	dbSkip()
EndDo

dbSelectArea("SD2")
RetIndex("SD2")
Ferase( cSD2ntx + OrdBagExt() )

If aReturn[5] = 1
	Set Printer TO
	dbCommitAll()
	OurSpool(wnrel)
Endif

MS_FLUSH()
return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡Æo    ³ R001CREM ³ Autor ³ Guilherme C. Leal     ³ Data ³ 18.04.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡Æo ³ Cabecalho/Encabezado/Header				                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR265	                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R001CREM(Tamanho)
Local nEsp := 15
Local cTxt := ""
If Li > 55 .Or. (SD2->D2_REMITO != cNfAnt .And. SD2->D2_SERIE != cSerAnt)
	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,18)
	If SD2->D2_TIPO $ "D"
		cTxt := Padr(STR0014,nEsp,".")
		@ Li, 00 PSAY cTxt + ": " + AllTrim(SA2->A2_COD) + "/" + SA2->A2_LOJA + " - " + SA2->A2_NOME	//"CLIENTE/FORN.: "
		Li+=2
		cTxt := Padr(STR0015,nEsp,".")
		@ Li, 00 PSAY cTxt + ": " + AllTrim(SA2->A2_MUN) + " - " + SA2->A2_EST	//"MUNICIPIO....: "
		Li+=2
	Else
		cTxt := Padr(STR0014,nEsp,".")
		@ Li, 00 PSAY cTxt + ": " + AllTrim( SA1->A1_COD) + "/" + SA1->A1_LOJA + " - " + SA1->A1_NOME	//"CLIENTE/FORN.: "
		Li+=2
		cTxt := Padr(STR0015,nEsp,".")
		@ Li, 00 PSAY cTxt + ": " + AllTrim(SA1->A1_MUN) + " - " + SA1->A1_EST	//"MUNICIPIO....: "
		Li+=2
	EndIf
	If cPaisloc $ "CHI"
		cTxt := Padr(STR0030,nEsp,".")
	Elseif cPaisloc $ "COL|MEX|PAR"
		cTxt := Padr(STR0031,nEsp,".")
	Elseif cPaisloc $ "EUA|POR"
		cTxt := Padr(STR0032,nEsp,".")
	Elseif cPaisloc $ "ARG|URU"
		cTxt := Padr(STR0029,nEsp,".")
	Endif
	@ Li, 00 PSAY cTxt + ": " + SD2->D2_DOC
	
	Li+=2
	cTxt := Padr(Alltrim(Upper(RetTitle("D2_SERIE"))),nEsp,".")
	@ Li,00 PSAY cTxt +": " + SD2->D2_SERIE
	
	Li+=2
	cTxt := Padr(STR0017,nEsp,".")
	@ Li, 00 PSAY cTxt + ": " + SD2->D2_PEDIDO	//"PEDIDO.......: "
	Li+=2
	@ Li,00 PSAY __PrtThinLine()
	Li+=2
	cNfAnt := SD2->D2_DOC
	cSerAnt:= SD2->D2_SERIE
Endif
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡Æo    ³R001DREM  ³ Autor ³ Guilherme C. Leal     ³ Data ³ 18.04.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡Æo ³ Detalhe do Remito/Detalle del Remito/Remito Detail         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR265	                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R001DREM(Tamanho)
//@ Li,16 PSAY Left(SB1->B1_DESC,30)		Picture PesqPict("SB1","B1_DESC",30)
//@ Li,47 PSAY SB1->B1_UM				Picture PesqPict("SB1","B1_UM",2)
@ Li,016 PSAY SD2->D2_LOTECTL			Picture PesqPict("SD2","D2_LOTECTL",10)
@ Li,030 PSAY SD2->D2_COD			Picture PesqPict("SD2","D2_COD",15)

//@ Li,61 PSAY SD2->D2_NUMLOTE			Picture PesqPict("SD2","D2_NUMLOTE",6)
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AjustaSX1 ºAutor  ³Alexandre Lemes     º Data ³ 18/12/2003  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ MATR600 AP7                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function AjustaSX1()

Local aHelpPor	:= {}
Local aHelpEng	:= {}
Local aHelpSpa	:= {}
Local cSeq		:= If(cPaisLoc=="BRA","14","16")
Local cCH		:= If(cPaisLoc=="BRA","mv_chE","mv_chG")
Local cPAR		:= If(cPaisLoc=="BRA","MV_PAR14","MV_PAR16")

Aadd(aHelpPor,"Serie inicial a ser considerada na     ")
Aadd(aHelpPor,"filtragem do cadastro de notas fiscais.")
//
Aadd(aHelpSpa,"Serie inicial a considerarse en la     ")
Aadd(aHelpSpa,"filtracion del archivo de facturas.    ")
//
Aadd(aHelpEng,"Inicial serie to be considered in the  ")
Aadd(aHelpEng,"filtering of invoices file.            ")
//
PutSX1(cPerg,cSeq,"De Serie ?","¿ De serie ?","From series ?",cCH,"C",3,0,0,"G","","","","S",cPAR,"","","","","","","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa)
/*------------------------------------*/
cSeq := Soma1(cSeq)
cCH  := Soma1(cCH)
cPAR := Soma1(cPAR)
aHelpPor := {}
aHelpEng := {}
aHelpSpa := {}
//
Aadd(aHelpPor,"Serie final a ser considerada na       ")
Aadd(aHelpPor,"filtragem do cadastro de notas fiscais.")
//
Aadd(aHelpSpa,"Serie final a considerarse en la       ")
Aadd(aHelpSpa,"filtracion del archivo de facturas.    ")
//
Aadd(aHelpEng,"Final serie to be considered in the    ")
Aadd(aHelpEng,"filtering of invoices file.            ")
//
PutSX1(cPerg,cSeq,"A serie ?","¿ A serie ?","To series ?",cCH,"C",3,0,0,"G","","","","S",cPAR,"","","","","","","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa)

PutSX1(cPerg,"16","Armazem de ?                  ","¿De Deposito ?              ","From Warehouse ?              ","Mv_ChF","C", 2,0,0,"G","","","","S","Mv_par16",   "",  "",   "","",   "",  "",  "","","","","","","","","","",{"Informe o armazem inicial              "},{"",},{""},"")
PutSX1(cPerg,"17","Armazem ate ?                 ","¿A Deposito ?               ","To Warehouse ?                ","Mv_ChG","C", 2,0,0,"G","","","","S","Mv_par17",   "",  "",   "","",   "",  "",  "","","","","","","","","","",{"Informe o armazem final                "},{"",},{""},"")
Return