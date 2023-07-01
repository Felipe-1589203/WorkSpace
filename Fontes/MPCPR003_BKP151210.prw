#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "RWMAKE.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                                 M  U   L  - T -  L  O  C  K                           บฑฑ
ฑฑฬออออออออออออัอออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบPrograma    ณ MPCPR003  ณ Emite o Relatorio de informacao de estrutura do produto.     บฑฑ
ฑฑบ            ณ           ณ Este relatorio tem a funcao de calcular os saldos e empenhos บฑฑ
ฑฑบ            ณ           ณ reservas somar as quantidades dos componentes em comum e     บฑฑ
ฑฑบ            ณ           ณ gerar previsใo de produ็ใo.                                  บฑฑ
ฑฑฬออออออออออออุอออออออออออฯอออออออออออออออออออออออออออออออออออออออออออัออออออัอออออออออออนฑฑ
ฑฑบAutor       ณ  Especifico Actual Trend - www.actualtrend.com.br     ณ Data ณ  09/04/09 บฑฑ
ฑฑศออออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออฯอออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

User Function MPCPR003(_nTipProd)                                                 

Local cDesc1       := "Este relatorio tem a fun็ใo de calcular os saldos e"
Local cDesc2       := "empenhos/reservas somar as quantidades dos componentes"
Local cDesc3       := "em comum e gerar previsใo de produ็ใo"
Local cPict        := ""
Local titulo       := "RELATORIO DE INFORMACOES DE PLANEJAMENTO"
Local nLin         := 80
Local Cabec1       := ""
Local Cabec2       := ""                                            
Local imprime      := .T.
Local aOrd         := {}

Private lEnd       := .F.
Private lAbortPrint:= .F.
Private limite     := 220
Private tamanho    := "G"                                                     
Private nomeprog   := "MPCPR003"
Private nTipo      := 18
Private aReturn    := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey   := 0
Private cbtxt      := Space(10)
Private cbcont     := 00
Private CONTFL     := 01                       
Private m_pag      := 01
Private wnrel      := "MPCPR003"
Private cPerg      := "MPCPR003"
Private cString    := "SB1"
Private _aTMParray := {}
Private lContinua  := .T.

Default _nTipProd  := 1

aAdd(_aTMParray, { CriaVar("ZO_PRODUTO",.F.) } )

// *********************** Verifica se existem registros selecionados no browse
If !(AllTrim(FunName()) == "MPCPR003")
	_nRecTMP   := TMP->(Recno())
	
	TMP->(DbGoTop())
	While TMP->(!Eof())
		If !Empty(TMP->TMP_OK)
			If (nPosTMP :=  Ascan( _aTMParray, { | x | x[1] == TMP->ZO_PRODUTO  } ) ) == 0
				If Len(	_aTMParray) == 1 .And. Empty(_aTMParray[1,1])
					_aTMParray := {}
				EndIf
				aAdd(_aTMParray, { TMP->ZO_PRODUTO })
			EndIf
		EndIf
		TMP->(DbSkip())
	End-While
	TMP->(DbGoTo(_nRecTMP))
	
	If Len(	_aTMParray) == 1 .And. Empty(_aTMParray[1,1])
		If MsgYesNo("Nใo foi selecionado nenhum registro, serแ gerado todos produtos cadastrados no Plano Mestre de Produ็ใo, deseja continuar ?",'ATENCAO')
			lContinua  := .T.
		Else
			lContinua  := .F.
		EndIf
	EndIf
EndIf

If lContinua == .T.
	// *********************** Chama funcoes
	R003PERG(cPerg)
	lPerg := Pergunte(cPerg)
	
	If lPerg == .T.
		If _nTipProd == 1        // Gerar Impressao
			wnrel := SetPrint(cString,NomeProg,"",@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)
			If nLastKey == 27
				Return
			Endif
			
			SetDefault(aReturn,cString)
			If nLastKey == 27
				Return
			Endif
			
			nTipo := If(aReturn[4]==1,15,18)
		EndIf
		
		If Empty(Mv_Par01)
			MsgInfo("Nใo foi selecionado armazem","Impossivel gerar")
		Else
			Processa({|| R003GERA(Cabec1,Cabec2,Titulo,nLin,_nTipProd) },Titulo)
		EndIf
	EndIf
EndIf

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                                 M  U   L  - T -  L  O  C  K                           บฑฑ
ฑฑฬออออออออออออัอออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบPrograma    ณ R003GERA  ณ  Simulador de MRP - Selecionado dados conforme parametros    บฑฑ
ฑฑฬออออออออออออุอออออออออออฯอออออออออออออออออออออออออออออออออออออออออออัออออออัอออออออออออนฑฑ
ฑฑบAutor       ณ  Especifico Actual Trend - www.actualtrend.com.br     ณ Data ณ  09/04/09 บฑฑ
ฑฑศออออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออฯอออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

Static Function R003GERA(Cabec1,Cabec2,Titulo,nLin,_nTipProd)

Local  lCodPai  := .F.
Local _cCodPAI  := ""
Local _aStru    := {}
Local _aCol     := {}
Local aProdPai  := {}
Local _aAreaSG1 := SB1->(GetArea())
Local _aAreaSB1 := SB1->(GetArea())
Local _aAreaSB3 := SB3->(GetArea())

Local cDirDocs	:= MsDocPath()
Local cBarra	:= If(IsSrvUnix(), "/", "\")
Local cPath		:= AllTrim(GetTempPath())
Local cBuffer	:= ""
Local cArqExp	:= ""
Local nHdlXls	:= 0
Local lExcel	:= .F.

Private _aSaldo := {}

aAdd(_aCol,000) // 01-CODIGO
aAdd(_aCol,016) // 02-TIPO
aAdd(_aCol,020) // 03-DESCRICAO
aAdd(_aCol,065) // 04-UM
aAdd(_aCol,068) // 05-QUANTIDADE
aAdd(_aCol,083) // 06-SALDO ATUAL
aAdd(_aCol,098) // 07-EMPENHO PARA A PRODUCAO
aAdd(_aCol,113) // 08-RESERVAS DE VENDAS
aAdd(_aCol,128) // 09-PREVISAO DE ENTRADAS
aAdd(_aCol,145) // 10-SALDOS PREVISTO
aAdd(_aCol,162) // 11-NECESSIDADES REAIS
aAdd(_aCol,177) // 12-SALDOS FINAIS
aAdd(_aCol,194) // 13-PRAZO DE ENTREGA
aAdd(_aCol,200) // 14-TIPO DE PRAZO DE ENTREGA
aAdd(_aCol,203) // 15-ESTOQUE EM MESES
aAdd(_aCol,213) // 16-CONSUMO MEDIO

aAdd(_aStru,{"FILIAL"	 ,TAMSX3("G1_FILIAL" )[3],TAMSX3("G1_FILIAL" )[1],TAMSX3("G1_FILIAL" )[2]}) //FILIAL
aAdd(_aStru,{"PRODPAI"	 ,TAMSX3("G1_COD"    )[3],TAMSX3("G1_COD"    )[1],TAMSX3("G1_COD"    )[2]}) //PRODUTO PAI
aAdd(_aStru,{"PRODUTO"	 ,TAMSX3("G1_COD"    )[3],TAMSX3("G1_COD"    )[1],TAMSX3("G1_COD"    )[2]}) //PRODUTO
aAdd(_aStru,{"NIVEL"  	 ,TAMSX3("G1_NIV"    )[3],TAMSX3("G1_NIV"    )[1],TAMSX3("G1_NIV"    )[2]}) //NIVEL
aAdd(_aStru,{"DESCRICAO" ,TAMSX3("B1_DESC"   )[3],TAMSX3("B1_DESC"   )[1],TAMSX3("G1_DESC"   )[2]}) //DESCRICAO DO PRODUTO
aAdd(_aStru,{"UNIDADE"	 ,TAMSX3("B1_UM"     )[3],TAMSX3("B1_UM"     )[1],TAMSX3("B1_UM"     )[2]}) //UNIDADE DO PRODUTO
aAdd(_aStru,{"TIPO"   	 ,TAMSX3("B1_TIPO"   )[3],TAMSX3("B1_TIPO"   )[1],TAMSX3("B1_TIPO"   )[2]}) //TIPO DO PRODUTO
aAdd(_aStru,{"PE" 		 ,"N"                     ,05                      ,0                      }) //PRAZO DE ENTREGA
aAdd(_aStru,{"TIPE"		 ,"C"                     ,01                      ,0                      }) //TIPO DE PRAZO
aAdd(_aStru,{"QUANT"	 ,TAMSX3("B2_QATU"   )[3],TAMSX3("B2_QATU"   )[1],TAMSX3("B2_QATU"   )[2]}) //QUANTIDADE ESTRUTURA
aAdd(_aStru,{"SALDO"	 ,TAMSX3("B2_QATU"   )[3],TAMSX3("B2_QATU"   )[1],TAMSX3("B2_QATU"   )[2]}) //SALDO ATUAL EM ESTOQUE
aAdd(_aStru,{"EMPENHO"   ,TAMSX3("B2_QEMP"   )[3],TAMSX3("B2_QEMP"   )[1],TAMSX3("B2_QEMP"   )[2]}) //SOMA DOS EMPENHOS
aAdd(_aStru,{"RESERVA"	 ,TAMSX3("B2_QPEDVEN")[3],TAMSX3("B2_QPEDVEN")[1],TAMSX3("B2_QPEDVEN")[2]}) //RESERVAS POR P.V.
aAdd(_aStru,{"PREVISAO"	 ,TAMSX3("B2_SALPEDI")[3],TAMSX3("B2_SALPEDI")[1],TAMSX3("B2_SALPEDI")[2]}) //PREVISAO ENTRADA
aAdd(_aStru,{"SALDOPRE"	 ,TAMSX3("B2_QATU"   )[3],TAMSX3("B2_QATU"   )[1],TAMSX3("B2_QATU"   )[2]}) //SALDO PREVISTO DE ESTOQUE
aAdd(_aStru,{"QUANTREA"	 ,TAMSX3("B2_QATU"   )[3],TAMSX3("B2_QATU"   )[1],TAMSX3("B2_QATU"   )[2]}) //QUANTIDADE NECESSARIA REAL
aAdd(_aStru,{"SALDOMRP"	 ,TAMSX3("B2_QATU"   )[3],TAMSX3("B2_QATU"   )[1],TAMSX3("B2_QATU"   )[2]}) //SALDO FINAL MRP

_cArq := CriaTrab(_aStru,.t.)
DbUseArea(.T.,,_cArq,"TR1",.T.,.F.)
cIndTMP1	:= CriaTrab(,.F.)

IndRegua("TR1",cIndTMP1,"FILIAL+PRODPAI+PRODUTO",,,"Selecionando Registros...")

dbClearIndex()
dbSetIndex(cIndTMP1+OrdBagExt())
dbSetOrder(1)

IncProc("Selecionando dados... Por favor aguarde!")

R003MONT(_aTMParray )

DbSelectArea("TR1")
DbClearIndex()
IndRegua("TR1",cIndTMP1,"FILIAL+PRODUTO",,,"Selecionando Registros...")
ProcRegua(TR1->(RecCount()))

TR1->(DbGoTop())
If TR1->(!Eof())
	If _nTipProd == 1        // Gerar Impressao
		Titulo := PADC("PREVISAO DE CONSUMO - PLANEJAMENTO DE PRODUCAO",220)
		Cabec1 := "CODIGO          TI  DESCRICAO                                    UM     QUANTIDADE    SALDO ATUAL   EMPENHO PARA       RESERVAS         PREVISAO         SALDO       NECESSIDADE         SALDOS     PRAZO   EST.EM   CONSUMO "
		Cabec2 := "PRODUTO         PO  PRODUTO                                             NECESSARIA                      PRODUCAO         VENDAS         ENTRADAS         PREVISTO           REAL     FINAIS MRP   ENTREGA    MESES     MEDIO "
	EndIf
	
	While TR1->(!Eof())
		If _nTipProd == 1        // Gerar Impressao
			If lAbortPrint
				@ nLin,000 PSAY "*** CANCELADO PELO OPERADOR ***"
				Exit                  '
			Endif
			
			If nLin > 56
				Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
				nLin := 9
			Endif
		EndIf
		
		IncProc("Imprimindo rela็ใo... Aguarde", "X")
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Posiciona-se no arquivo de PRODUTOS para pegar dados         ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		DbSelectArea("SB1")
		SB1->(DbSetOrder(1))
		SB1->(DbSeek(xFilial("SB1")+TR1->PRODUTO))
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Posiciona-se no arquivo de Demandas para pegar dados         ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		DbSelectArea("SB3")
		SB3->(DbSetOrder(1))
		lSB3    := SB3->(DbSeek(xFilial("SB3")+TR1->PRODUTO))
		nTotCon := R003CONSU(TR1->PRODUTO)
		nTotdias:= (MV_PAR06-(MV_PAR05-1))
		nNumInd := (nTotdias/30)
		nMedia  := Round( (nTotCon / round(nNumInd,0)), 0)
		
		If TR1->PRODUTO == TR1->PRODPAI
			aadd(aProdPai, {TR1->PRODUTO,TR1->NIVEL,TR1->TIPO,TR1->DESCRICAO,TR1->UNIDADE,TR1->QUANT,TR1->SALDO,TR1->EMPENHO,TR1->RESERVA,TR1->PREVISAO,TR1->SALDOPRE,TR1->QUANTREA,TR1->SALDOMRP,SB1->B1_COD,SB1->B1_LE,TR1->TIPE,nMedia})
			
			TR1->(DbSkip())
			Loop
		EndIf
		
		If Mv_par03 == 1 .And. TR1->QUANTREA >= 0
			TR1->(DbSkip())
			Loop
		EndIf
		
		If _nTipProd == 1        // Gerar Impressao
			DbSelectArea("TR1")
			@ nLin,_aCol[01] PSAY left(TR1->PRODUTO,6)
			@ nLin,_aCol[01]+8 PSAY TR1->NIVEL
			@ nLin,_aCol[02] PSAY TR1->TIPO
			@ nLin,_aCol[03] PSAY Left(TR1->DESCRICAO,43)
			@ nLin,_aCol[04] PSAY TR1->UNIDADE
			@ nLin,_aCol[05] PSAY Transform(TR1->QUANT   , PesqPict("SB2","B2_QATU"))
			@ nlin,_aCol[06] PSAY Transform(TR1->SALDO   , PesqPict("SB2","B2_QATU"))
			@ nlin,_aCol[07] PSAY Transform(TR1->EMPENHO , PesqPict("SB2","B2_QEMP"))
			@ nlin,_aCol[08] PSAY Transform(TR1->RESERVA , PesqPict("SB2","B2_QPEDVEN"))
			@ nlin,_aCol[09] PSAY Transform(TR1->PREVISAO, PesqPict("SB2","B2_SALPEDI"))
			@ nlin,_aCol[10] PSAY Transform(TR1->SALDOPRE, PesqPict("SB2","B2_SALPEDI"))
			@ nlin,_aCol[11] PSAY Transform(TR1->QUANTREA, PesqPict("SB2","B2_QATU"))
			@ nlin,_aCol[12] PSAY Transform(TR1->SALDOMRP, PesqPict("SB2","B2_QATU"))
			@ nlin,_aCol[13] PSay CalcPrazo(SB1->B1_COD,SB1->B1_LE) Picture "99999"
			@ nLin,_aCol[14] PSAY TR1->TIPE
			
			If nMedia != 0
				@ nlin,_aCol[15] PSAY TR1->SALDO/nMedia Picture "99999.9"
			Else
				@ nlin,_aCol[15] PSAY "    N/D"
			EndIf
			@ nlin,_aCol[16] PSAY nMedia Picture "9999999"
			nLin++
		EndIf
		
		TR1->(DbSkip())
	End-While
	
	If Mv_par04 == 1
		If Len(aProdPai) > 0
			If nLin > 56
				Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
				nLin := 9
			Endif
			
			@ nLin,000 PSAY Replicate("-",Limite)
			nLin++
			@ nLin,000 PSAY Padc("PRODUTOS PLANO MESTRE DE PRODUวรO",Limite)
			nLin++
			@ nLin,000 PSAY Replicate("-",Limite)
			nLin++
		EndIf
		
		For _n1 := 1 to Len(aProdPai)
			If _nTipProd == 1        // Gerar Impressao
				If lAbortPrint
					@ nLin,000 PSAY "*** CANCELADO PELO OPERADOR ***"
					Exit
				Endif
				
				If nLin > 56
					Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
					nLin := 9
				Endif
				
				@ nLin,_aCol[01] PSAY left(aProdPai[_n1,01],6)
				@ nLin,_aCol[01]+8 PSAY aProdPai[_n1,02]
				@ nLin,_aCol[02] PSAY aProdPai[_n1,03]
				@ nLin,_aCol[03] PSAY Left(aProdPai[_n1,04],43)
				@ nLin,_aCol[04] PSAY aProdPai[_n1,05]
				@ nLin,_aCol[05] PSAY Transform(aProdPai[_n1,06], PesqPict("SB2","B2_QATU"))
				@ nlin,_aCol[06] PSAY Transform(aProdPai[_n1,07], PesqPict("SB2","B2_QATU"))
				@ nlin,_aCol[07] PSAY Transform(aProdPai[_n1,08], PesqPict("SB2","B2_QEMP"))
				@ nlin,_aCol[08] PSAY Transform(aProdPai[_n1,09], PesqPict("SB2","B2_QPEDVEN"))
				@ nlin,_aCol[09] PSAY Transform(aProdPai[_n1,10], PesqPict("SB2","B2_SALPEDI"))
				@ nlin,_aCol[10] PSAY Transform(aProdPai[_n1,11], PesqPict("SB2","B2_SALPEDI"))
				@ nlin,_aCol[11] PSAY Transform(aProdPai[_n1,12], PesqPict("SB2","B2_QATU"))
				@ nlin,_aCol[12] PSAY Transform(aProdPai[_n1,13], PesqPict("SB2","B2_QATU"))
				@ nlin,_aCol[13] PSay CalcPrazo(aProdPai[_n1,14],aProdPai[_n1,15]) Picture "99999"
				@ nLin,_aCol[14] PSAY aProdPai[_n1,16]
				If lSB3
					If aProdPai[_n1,17] != 0
						@ nlin,_aCol[15] PSAY aProdPai[_n1,07]/aProdPai[_n1,17]Picture "99999.9"
					Else
						@ nlin,_aCol[15] PSAY "    N/D"
					EndIf
					@ nlin,_aCol[16] PSAY aProdPai[_n1,17] Picture "9999999"
				EndIf
				nLin++
			EndIf
		Next _n1
		
		Roda(0,"",tamanho)
	EndIf
EndIf

TR1->(DbCloseArea())
fErase( _cArq + GetDBExtension() )
fErase( _cArq + OrdBagExt() )

If _nTipProd == 1        // Gerar Impressao
	SET DEVICE TO SCREEN
	
	If aReturn[5]==1
		dbCommitAll()
		SET PRINTER TO
		OurSpool(wnrel)
	Endif
	
	MS_FLUSH()
	
EndIf

lGera := .F.

If _nTipProd == 2 .Or. (_nTipProd == 1 .And. AllTrim(FunName()) == "MPCPR003")    // Gerar Excel
	If _nTipProd == 1
		//If MsgYesNo("Deseja gerar planilha EXCEL ?",'Gera็ใo de planilha')
		//	lGera := .T.
		//EndIf
	ElseIf _nTipProd == 2
		lGera := .T.
	EndIf
	
	If lGera == .T.
		fClose(nHdlXls)
		cArqDestino	:= 'MRP_' + Right(DTOS(ddatabase),6) + '_HR_' + SUBSTR(TIME(),1,2)+SUBSTR(TIME(),4,2)+'.XLS'
		
		If __CopyFile(cDirDocs + cBarra + cArqExp , cPath+cArqDestino )
			fErase(cDirDocs+cBarra+cArqExp)
			
			If !File(cPath+cArqDestino)
				Aviso("Gera็ใo Planilha","Arquivo '"+cPath+cArqDestino+"', NรO encontrado! Verifique...",{"&Abortar"},,"Excel" )
			Else
				oExcelApp	:= MsExcel():New()
				oExcelApp:WorkBooks:Open(cPath+cArqDestino)
				oExcelApp:SetVisible(.T.)
			EndIf
		EndIf
	EndIf
EndIf

RestArea(_aAreaSB1)
RestArea(_aAreaSB3)

Return()

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                                 M  U   L  - T -  L  O  C  K                           บฑฑ
ฑฑฬออออออออออออัอออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบPrograma    ณ R003MONT  ณ Monta arq. temporario com dados selecionado para impressao   บฑฑ
ฑฑฬออออออออออออุอออออออออออฯอออออออออออออออออออออออออออออออออออออออออออัออออออัอออออออออออนฑฑ
ฑฑบAutor       ณ  Especifico Actual Trend - www.actualtrend.com.br     ณ Data ณ  09/04/09 บฑฑ
ฑฑศออออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออฯอออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

Static Function R003MONT(_aTMParray)

Local _n1
Local _aAreaSZO := SZO->(GetArea())
Local _aAreaSG1 := SG1->(GetArea())
Local _aAreaSB1 := SB1->(GetArea())
Local _cCod     := ""
Local _nProduto := 0
Local _cFilTMP  := xFilial("SZO")
Local _cProdTMP := _aTMParray[1,1]

If Len(	_aTMParray) == 1 .And. Empty(_aTMParray[1,1])
	_aTMParray := {}
EndIf

DbSelectArea("SZO")
SZO->(DbSetOrder(2))
If Len(_aTMParray) == 0
	SZO->(DbGoTop())
	_cFilTMP  := SZO->ZO_FILIAL
	_cProdTMP := SZO->ZO_PRODUTO
Else
	SZO->(DbSeek( _cFilTMP + _cProdTMP ),.T.)
EndIf

ProcRegua(SZO->(Recno()))
While SZO->(!Eof())
	IncProc("Analisando Produto "+SZO->ZO_PRODUTO)
	
	cBloqueio := Posicione("SB1",1,xFilial("SB1")+SZO->ZO_PRODUTO, "B1_MSBLQL" )
	
	If  _cFilTMP == SZO->ZO_FILIAL .And. _cProdTMP == SZO->ZO_PRODUTO .And. cBloqueio <> "1"
		_cCod    := SZO->ZO_PRODUTO
		_nQuantz := SZO->ZO_QUANT
		_nNivel  := 0
		
		DbSelectArea("SG1")
		SG1->(DbSetOrder(1))
		If SG1->(DbSeek( xFilial("SG1") + _cCod  ))
			
			DbSelectArea("SG1")
			ProcRegua(SG1->(Recno()))
			While SG1->G1_COD == _cCod .And. SG1->(!Eof())
				IncProc("Analisando Produto "+SG1->G1_COD+" - "+SG1->G1_COMP)
				
				aSomaSB2  := R003SB2X(SG1->G1_COD)
				_nSaldoMRP:= ((aSomaSB2[1]+aSomaSB2[4])-(aSomaSB2[2]+aSomaSB2[3]))
				
				If (nPosSald :=  Ascan( _aSaldo, { | x | x[1]+x[2] == SG1->G1_FILIAL+SG1->G1_COD  } ) ) <> 0
					_nSaldoMRP := _aSaldo[nPosSald,3]
				EndIf
				
				_nNecReal1:= (_nSaldoMRP) - _nQuantz
				_nNecReal1:= IIf(_nNecReal1 >= 0, 0, _nNecReal1)
				_nSaldo   := _nSaldoMRP - IIf(_nNecReal1 == 0,_nQuantz,_nNecReal1)
				
				If (nPosSald :=  Ascan( _aSaldo, { | x | x[1]+x[2] == SG1->G1_FILIAL+SG1->G1_COD  } ) ) == 0
					Aadd(_aSaldo, {SG1->G1_FILIAL, SG1->G1_COD, _nSaldo })
				Else
					_aSaldo[nPosSald,3] := _nSaldo
				EndIf
				
				//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
				//ณ Grava planejamento Produto PAI                         ณ
				//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
				DbSelectArea("TR1")
				If TR1->(!DbSeek(SG1->G1_FILIAL+SG1->G1_COD+SG1->G1_COD,.F.))
					Reclock("TR1",.T.)
					TR1->FILIAL		:= SG1->G1_FILIAL
					TR1->PRODPAI 	:= SG1->G1_COD
					TR1->PRODUTO	:= SG1->G1_COD
					TR1->NIVEL  	:= StrZero(_nNivel,2)
					TR1->DESCRICAO	:= GetAdvFVal("SB1","B1_DESC", SG1->G1_FILIAL+SG1->G1_COD, 1, "S/N")
					TR1->UNIDADE	:= GetAdvFVal("SB1","B1_UM"  , SG1->G1_FILIAL+SG1->G1_COD, 1, "S/N")
					TR1->TIPO   	:= GetAdvFVal("SB1","B1_TIPO", SG1->G1_FILIAL+SG1->G1_COD, 1, "S/N")
					TR1->PE 		:= GetAdvFVal("SB1","B1_PE"  , SG1->G1_FILIAL+SG1->G1_COD, 1, "S/N")
					TR1->TIPE		:= GetAdvFVal("SB1","B1_TIPE", SG1->G1_FILIAL+SG1->G1_COD, 1, "S/N")
					TR1->QUANT		:= _nQuantz
					TR1->SALDO      := aSomaSB2[1]                                                        // Soma dos saldos em estoque
					TR1->EMPENHO    := aSomaSB2[2]                                                        // Soma dos empenhos
					TR1->RESERVA    := aSomaSB2[3]                                                        // Reservas do Produto por p.v.
					TR1->PREVISAO   := aSomaSB2[4]                                                        // Previsao de entrada por p.c.
					TR1->SALDOPRE	:= _nSaldoMRP                                                         // Saldo Previsto (Saldo + Previsao) - (Empenho + Reserva)
					TR1->QUANTREA	:= _nNecReal1                                                         // Qtde a ser utilizada ou produzida
					TR1->SALDOMRP	:= _nSaldo                                                             // Saldo Final MRP
					TR1->(MsUnlock())
				Else
					Reclock("TR1",.F.)
					TR1->QUANT		+= _nQuantz
					TR1->QUANTREA	+= _nNecReal1
					TR1->SALDOPRE	:= _nSaldoMRP
				EndIf
				_nSaldoPAI:= IIf(_nNecReal1 <= 0, (_nNecReal1*-1), _nQuantz)
				
				//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
				//ณ Grava planejamento Produto Complementar, componentes   ณ
				//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
				_nNivel++
				nRecSG1   := SG1->(Recno())
				aNivelSld := {}
				nEstru    := 0
				aEstrutura:= Estrut(SG1->G1_COD)  	// Obtem a estrutura codigo PAI
				_CodSG1   := IIf(Mv_par02 == 1, Replicate("X", Len(SG1->G1_COD)), SG1->G1_COD)
				
				For _n1 := 1 to Len(aEstrutura)
					IncProc("Analisando Produto "+aEstrutura[_n1,2]+" - "+aEstrutura[_n1,3])
					
					nNive1 := aEstrutura[_n1,1]
					
					If _nNivel <> nNive1
						If nNive1 == 1
							_nNecReal1 := _nSaldoPAI
						Else
							If _nNivel > nNive1
								If (nPos := aScan(aNivelSld, {| x | x[1] == nNive1 }) ) <> 0
									_nNecReal1 := aNivelSld[nPos,2]
								Endif
							Else
								_nSaldAnte  := (_nNecReal1 * IIf(_nNecReal1<0,-1,1) )
								_nNecReal1 := _nNecReal2
							EndIf
						EndIf
						
						If (nPosX := aScan(aNivelSld, {| x | x[1] == nNive1 }) ) == 0
							aadd(aNivelSld, {nNive1, _nNecReal1})
						Else
							aNivelSld[nPosX,2] :=  _nNecReal1
						EndIf
						_nNivel := nNive1
					EndIf
					
					aSomaSB2  := R003SB2X(aEstrutura[_n1,3])
					_nSaldoMRP:= ((aSomaSB2[1]+aSomaSB2[4])-(aSomaSB2[2]+aSomaSB2[3]))
					If (nPosSald :=  Ascan( _aSaldo, { | x | x[1]+x[2] == SG1->G1_FILIAL+aEstrutura[_n1,3]  } ) ) <> 0
						_nSaldoMRP := _aSaldo[nPosSald,3]
					EndIf
					_nSaldAnte:= IIf(nNive1 == 1, _nSaldoPAI, _nNecReal1)
					_nQuantz  := _nSaldAnte * aEstrutura[_n1,4]
					_nNecReal2:= (_nSaldoMRP) - (_nQuantz*IIf(_nQuantz <=0, -1,1))
					_nNecReal2:= IIf(_nNecReal2 >= 0, 0, _nNecReal2)
					_nSaldo   := _nSaldoMRP - (_nQuantz*IIf(_nQuantz <=0, -1,1))   //IIf(_nSaldoMRP == 0, (_nNecReal2*IIf(_nNecReal2 <0,-1,1)), IIf(_nNecReal2 == 0,(_nQuantz*IIf(_nQuantz <=0, -1,1)),IIf(_nNecReal2 < 0,0,_nNecReal2) ))
					_CodSG1   := IIf(Mv_par02 == 1, Replicate("X", Len(aEstrutura[_n1,2])),aEstrutura[_n1,2])
					
					If (nPosSald :=  Ascan( _aSaldo, { | x | x[1]+x[2] == SG1->G1_FILIAL+aEstrutura[_n1,3]  } ) ) == 0
						Aadd(_aSaldo, {SG1->G1_FILIAL, aEstrutura[_n1,3], _nSaldo })
					Else
						_aSaldo[nPosSald,3] := _nSaldo
					EndIf
					
					DbSelectArea("TR1")
					If TR1->(!DbSeek(SG1->G1_FILIAL+_CodSG1+aEstrutura[_n1,3],.F.))
						Reclock("TR1",.T.)
						TR1->FILIAL		:= SG1->G1_FILIAL
						TR1->PRODPAI 	:= _CodSG1
						TR1->PRODUTO	:= aEstrutura[_n1,3]
						TR1->NIVEL  	:= StrZero(nNive1,2)
						TR1->DESCRICAO	:= GetAdvFVal("SB1","B1_DESC", SG1->G1_FILIAL+aEstrutura[_n1,3], 1, "S/N")
						TR1->UNIDADE	:= GetAdvFVal("SB1","B1_UM"  , SG1->G1_FILIAL+aEstrutura[_n1,3], 1, "S/N")
						TR1->TIPO   	:= GetAdvFVal("SB1","B1_TIPO", SG1->G1_FILIAL+aEstrutura[_n1,3], 1, "S/N")
						TR1->PE 		:= GetAdvFVal("SB1","B1_PE"  , SG1->G1_FILIAL+aEstrutura[_n1,3], 1, "S/N")
						TR1->TIPE		:= GetAdvFVal("SB1","B1_TIPE", SG1->G1_FILIAL+aEstrutura[_n1,3], 1, "S/N")
						TR1->QUANT		:= (_nQuantz*IIf(_nQuantz<0,-1,1))
						TR1->SALDO      := aSomaSB2[1]                                                        // Soma dos saldos em estoque
						TR1->EMPENHO    := aSomaSB2[2]                                                        // Soma dos empenhos
						TR1->RESERVA    := aSomaSB2[3]                                                        // Reservas do Produto por p.v.
						TR1->PREVISAO   := aSomaSB2[4]                                                        // Previsao de entrada por p.c.
						TR1->SALDOPRE	:= _nSaldoMRP                                                         // Saldo Previsto (Saldo + Previsao) - (Empenho + Reserva)
						TR1->QUANTREA	:= _nNecReal2                                                         // Qtde a ser utilizada ou produzida
						TR1->SALDOMRP	:= _nSaldo                                                            // Saldo Final MRP
					Else
						Reclock("TR1",.F.)
						TR1->QUANT		+= (_nQuantz*IIf(_nQuantz<0,-1,1))
						TR1->QUANTREA	+= _nNecReal2
						TR1->SALDOPRE	:= _nSaldoMRP
					EndIf
					TR1->(MsUnlock())
				Next _n1
				
				SG1->(DbSkip())
			End-While
		EndIf
	EndIf
	SZO->(DbSkip())
	
	If Len(_aTMParray) == 0
		_cFilTMP  := SZO->ZO_FILIAL
		_cProdTMP := SZO->ZO_PRODUTO
	Else
		If (nPosTMP :=  Ascan( _aTMParray, { | x | x[1] == SZO->ZO_PRODUTO  } ) ) <> 0
			_cFilTMP  := xFilial("SZO")
			_cProdTMP := _aTMParray[nPosTMP,1]
		EndIf
	EndIf
End-While

RestArea(_aAreaSZO)
RestArea(_aAreaSG1)
RestArea(_aAreaSB1)

Return Nil

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                                 M  U   L  - T -  L  O  C  K                           บฑฑ
ฑฑฬออออออออออออัอออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบPrograma    ณ R003SB2X  ณ Busca Saldos na tabelas SB2                                  บฑฑ
ฑฑฬออออออออออออุอออออออออออฯอออออออออออออออออออออออออออออออออออออออออออัออออออัอออออออออออนฑฑ
ฑฑบAutor       ณ  Especifico Actual Trend - www.actualtrend.com.br     ณ Data ณ  09/04/09 บฑฑ
ฑฑศออออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออฯอออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

Static Function R003SB2X(cProduto)

Local _aAreaSB2    := SB2->(GetArea())
Local _nValnSaldo  := 0
Local _nValEmpenho := 0
Local _nValReserva := 0
Local _nValPrevisao:= 0
Local _aRet        := {}

DbSelectArea("SB2")
SB2->(DbSetOrder(1))
SB2->(DbSeek(xFilial("SB2")+cProduto ))

While SB2->B2_FILIAL == xFilial("SB2") .And. SB2->B2_COD == cProduto .And. SB2->(!Eof())
	_nValEmpenho  += SB2->B2_QEMP         // Soma dos empenhos
	_nValReserva  += SB2->B2_QPEDVEN      // Reservas do Produto por p.v
	_nValPrevisao += SB2->B2_SALPEDI      // Previsao de Entrada
	
	If !Empty(MV_PAR01) .And. !(SB2->B2_LOCAL $ AllTrim(MV_PAR01))
		SB2->(DbSkip())
		Loop
	EndIf
	
	_nValnSaldo += SB2->B2_QATU           // Soma dos saldos em estoque
	
	SB2->(DbSkip())
End-While

_aRet := {_nValnSaldo, _nValEmpenho, _nValReserva, _nValPrevisao}

RestArea(_aAreaSB2)

Return(_aRet)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                                 M  U   L  - T -  L  O  C  K                           บฑฑ
ฑฑฬออออออออออออัอออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบPrograma    ณ R003CONSU ณ Busca Consumo medio conforme parametro                       บฑฑ
ฑฑฬออออออออออออุอออออออออออฯอออออออออออออออออออออออออออออออออออออออออออัออออออัอออออออออออนฑฑ
ฑฑบAutor       ณ  Especifico Actual Trend - www.actualtrend.com.br     ณ Data ณ  09/04/09 บฑฑ
ฑฑศออออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออฯอออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

Static Function R003CONSU(cProduto)

Local cQuery := {}

cQuery := " SELECT SD2.D2_COD AS CODIGO, SUM(SD2.D2_QUANT) AS QUANT"
cQuery += "   FROM "+ RetSQLName( 'SD2' ) +"   AS SD2 , "+ RetSQLName( 'SF4' ) +"   AS SF4 "
cQuery += "  WHERE SD2.D2_FILIAL   = '"+ xFilial("SD2") +"'"
cQuery += "    AND SD2.D2_COD      = '"+ cProduto +"'"
cQuery += "    AND  SD2.D2_EMISSAO BETWEEN '"+ Dtos(Mv_Par05)+"' AND '"+Dtos(Mv_Par06)+"'"
cQuery += "    AND  SD2.D2_LOCAL   IN "+ FormatIn( Mv_par01, "/" )
cQuery += "    AND  SD2.D2_TES     BETWEEN '500' AND '999'"
cQuery += "    AND  SD2.D_E_L_E_T_ = ' ' "
cQuery += "    AND  SF4.F4_CODIGO  = SD2.D2_TES"
cQuery += "    AND  SF4.F4_FILIAL  = '"+ xFilial("SF4") +"'"
cQuery += "    AND  SF4.F4_ESTOQUE = 'S' "
cQuery += "    AND  SF4.D_E_L_E_T_ = ' ' "
cQuery += "  GROUP BY SD2.D2_COD
cQuery += "  UNION ALL "
cQuery += " SELECT SD3.D3_COD AS CODIGO, SUM(SD3.D3_QUANT) AS QUANT"
cQuery += "   FROM "+ RetSQLName( 'SD3' ) +"   AS SD3"
cQuery += "  WHERE SD3.D3_FILIAL   = '"+  xFilial("SD3") +"'"
cQuery += "    AND  SD3.D3_COD     = '"+ cProduto +"'"
cQuery += "    AND  SD3.D3_EMISSAO BETWEEN '"+ Dtos(Mv_Par05)+"' AND '"+Dtos(Mv_Par06)+"'"
cQuery += "    AND  SD3.D3_LOCAL   IN "+ FormatIn( Mv_par01, "/" )
cQuery += "    AND  SD3.D3_TM      BETWEEN '500' AND '996'"
cQuery += "    AND  SD3.D3_ESTORNO <>'S' "
cQuery += "    AND  SD3.D_E_L_E_T_ = ' ' "
cQuery += "  GROUP BY SD3.D3_COD

cAliasA	:= GetNextAlias()
cQuery  := ChangeQuery(cQuery)
nTotCon := 0

DbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cAliasA , .F., .T.)
aEval( SD2->(dbStruct()),{|x| If(x[2]!="C", TcSetField(cAliasA,AllTrim(x[1]),x[2],x[3],x[4]),Nil)})
aEval( SD3->(dbStruct()),{|x| If(x[2]!="C", TcSetField(cAliasA,AllTrim(x[1]),x[2],x[3],x[4]),Nil)})
aEval( SF4->(dbStruct()),{|x| If(x[2]!="C", TcSetField(cAliasA,AllTrim(x[1]),x[2],x[3],x[4]),Nil)})

DbSelectArea(cAliasA)
(cAliasA)->(DbGoTop())

If (cAliasA)->(!Eof())
	nTotCon := (cAliasA)->QUANT
EndIf

(cAliasA)->(DbCloseArea())

Return(nTotCon)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                                 M  U   L  - T -  L  O  C  K                           บฑฑ
ฑฑฬออออออออออออัอออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบPrograma    ณ R003PERG  ณ Cria perguntas de parametros de filtro                       บฑฑ
ฑฑฬออออออออออออุอออออออออออฯอออออออออออออออออออออออออออออออออออออออออออัออออออัอออออออออออนฑฑ
ฑฑบAutor       ณ  Especifico Actual Trend - www.actualtrend.com.br     ณ Data ณ  09/04/09 บฑฑ
ฑฑศออออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออฯอออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

Static Function  R003PERG(cPerg)

Local aAreaAtu	:= GetArea()
Local aAreaSX1	:= SX1->( GetArea() )

PutSx1(	cPerg, "01", "Considerar saldo Armazens?   ","","","Mv_ch1","C",12,0, 0,"G","","","","N","Mv_par01","   ","  ","   ","","   ","  ","  ","","","","","","","","","","","","","","","","",{"Informe os armazens a ser considerados    ",""                          },{""},{""},"")
PutSx1(	cPerg, "02", "Aglutinar componentes?       ","","","Mv_ch2","N", 1,0, 2,"C","","","","N","Mv_par02","Sim","Si","Yes","","Nใo","No","No","","","","","","","","","","","","","","","","",{"Deseja aglutinar componentes ou imprimir  "," por estrutura de produtos"},{""},{""},"")
PutSx1(	cPerg, "03", "Somente itens a produzir ?   ","","","Mv_ch3","N", 1,0, 2,"C","","","","N","Mv_par03","Sim","Si","Yes","","Nใo","No","No","","","","","","","","","","","","","","","","",{"Deseja listar somente itens a produzir ou ","toda estrutura do produto" },{""},{""},"")
PutSx1(	cPerg, "04", "Imprimir resumo Prod PAI ?   ","","","Mv_ch4","N", 1,0, 2,"C","","","","N","Mv_par04","Sim","Si","Yes","","Nใo","No","No","","","","","","","","","","","","","","","","",{"Deseja imprimir resumo de produto pai     ",""                          },{""},{""},"")
PutSx1(	cPerg, "05", "Data de Consumo De         ? ","","","Mv_ch5",TAMSX3("D2_EMISSAO")[3],TAMSX3("D2_EMISSAO")[1],TAMSX3("D2_EMISSAO")[2],0,"G","",""   ,"","N","Mv_par05","","","","","","","","","","","","","","","","","","","","","","",{"Informe a data inicial de consumo"             ,""},{""},{""},"")
PutSx1(	cPerg, "06", "Data de Consumo At้        ? ","","","Mv_ch6",TAMSX3("D2_EMISSAO")[3],TAMSX3("D2_EMISSAO")[1],TAMSX3("D2_EMISSAO")[2],0,"G","",""   ,"","N","Mv_par06","","","","","","","","","","","","","","","","","","","","","","",{"Informe a data Final de consumo"               ,""},{""},{""},"")

RestArea( aAreaSX1 )
RestArea( aAreaAtu )

Return(cPerg)