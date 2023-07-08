#INCLUDE "Protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE "Rwmake.ch"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                              M U L T  -  T  -  L O C K                                บฑฑ
ฑฑฬออออออออออออัอออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบPrograma    ณ MPCPR003  ณ Emite o Relatorio de informacao de estrutura do produto.     บฑฑ
ฑฑบ            ณ           ณ Este relatorio tem a funcao de calcular os saldos e empenhos บฑฑ
ฑฑบ            ณ           ณ reservas somar as quantidades dos componentes em comum e     บฑฑ
ฑฑบ            ณ           ณ gerar previsใo de produ็ใo.                                  บฑฑ
ฑฑฬออออออออออออุอออออออออออฯอออออออออออออออออออออออออออออออออออออออออออัออออออัอออออออออออนฑฑ
ฑฑบAutor       ณ Actual Trend                                          ณ Data ณ  09/04/09 บฑฑ
ฑฑศออออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออฯอออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

User Function MPCPR003()                                                                    

Local cDesc1       := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2       := "de acordo com os parametros informados pelo usuario."
Local cDesc3       := "Previsใo de Consumo"
Local cPict        := ""
Local titulo       := "Previsใo de Consumo"
Local nLin         := 80
Local Cabec1       := "CODIGO               TI  DESCRICAO                                   UM     QUANTIDADE    SALDO ATUAL   EMPENHO PARA       RESERVAS         PREVISAO         SALDO       NECESSIDADE         SALDOS   PRAZO  EST.EM  CONSUMO "
Local Cabec2       := "PRODUTO              PO  PRODUTO                                            NECESSARIA                      PRODUCAO         VENDAS         ENTRADAS         PREVISTO           REAL     FINAIS MRP ENTREGA   MESES    MEDIO "
Local imprime      := .T.
Local aOrd         := {}

Local _nTipProd    := 1

Private lEnd       := .F.
Private lAbortPrint:= .F.
Private CbTxt      := ""
Private limite     := 220
Private tamanho    := "G"
Private nomeprog   := "MPCPR003"
Private nTipo      := 15
Private aReturn    := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey   := 0
Private cbtxt      := Space(10)
Private cbcont     := 00
Private CONTFL     := 01
Private m_pag      := 01
Private wnrel      := "MPCPR003"
Private cPerg      := "MPCPR003"
Private cString    := "SZO"

//Default _nTipProd  := 1

DbSelectArea("SZO")
SZO->(DbSetOrder(1))

R003PERG(cPerg)
lPerg := Pergunte(cPerg)

wnrel := SetPrint(cString,NomeProg,"",@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.F.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

nTipo := If(aReturn[4]==1,15,18)

Processa({|| R003GERA(Cabec1,Cabec2,Titulo,nLin,_nTipProd) },Titulo)

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

Local _n1
Local nOrdem
Local _aStru    := {}
Local aProdPai  := {}

aAdd(_aStru,{"FILIAL"	 ,TAMSX3("G1_FILIAL" )[3],TAMSX3("G1_FILIAL" )[1],TAMSX3("G1_FILIAL" )[2]}) //FILIAL
aAdd(_aStru,{"TIPOPAI"	 ,                    "N",                      1 ,                      0 }) //PRODUTO PAI 1 = SIM
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
aAdd(_aStru,{"QTDECONS"	 ,TAMSX3("B2_QATU"   )[3],TAMSX3("B2_QATU"   )[1],TAMSX3("B2_QATU"   )[2]}) //QUANTIDADE CONSUMIDA NO PERIODO

_cArq := CriaTrab(_aStru,.t.)                                                          
DbUseArea(.T.,,_cArq,"TR1",.T.,.F.)
cIndTMP1 := CriaTrab(,.F.)

IndRegua("TR1",cIndTMP1,"FILIAL+PRODPAI+PRODUTO+NIVEL",,,"Selecionando Registros...")

dbClearIndex()
dbSetIndex(cIndTMP1+OrdBagExt())
dbSetOrder(1)
                                                                
ProcRegua(SZO->(RecCount()))
SZO->(DbGoTop())
While SZO->(!Eof())                                                                                 
	IncProc("Analisando Produto "+SZO->ZO_PRODUTO)
	
	cBloqueio := Posicione("SB1",1,xFilial("SB1")+SZO->ZO_PRODUTO, "B1_MSBLQL" )
	
	If  SZO->ZO_FILIAL == xFilial("SZO") .And. cBloqueio <> "1" //.And. AllTrim(SZO->ZO_PRODUTO) == "01.01.003"
		DbSelectArea("SG1")
		SG1->(DbSetOrder(1))
		ProcRegua(SG1->(RecCount()))
		
		If SG1->(DbSeek( xFilial("SG1") + SZO->ZO_PRODUTO  ))
			IncProc("Analisando Produto "+SG1->G1_COD)
			
			nRecSG1   := SG1->(Recno())
			nEstru    := 0
			aEstrutura:= Estrut(SG1->G1_COD)  	// Obtem a estrutura
			
			For _n1 := 1 To Len(aEstrutura)
				//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
				//ณ Grava planejamento Produto PAI                         ณ
				//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
				If _n1 == 1
					DbSelectArea("TR1")
					TR1->(DbSetorder(1))
					If TR1->(!DbSeek(SG1->G1_FILIAL+aEstrutura[_n1][2]+aEstrutura[_n1][2],.F.))
						aSomaSB2   := R003SB2X(aEstrutura[_n1][2])
						_nSaldoMRP := ((aSomaSB2[1]+aSomaSB2[4])-(aSomaSB2[2]+aSomaSB2[3]))
						_nNecReal1 := _nSaldoMRP-SZO->ZO_QUANT
						_nSaldo    := IIf(_nSaldoMRP-SZO->ZO_QUANT < 0, 0 , _nSaldoMRP-SZO->ZO_QUANT)
						_nQtdBKP   := IIf(_nNecReal1 < 0, (_nNecReal1*-1), SZO->ZO_QUANT )
						_nQtdPai   := IIf(_nNecReal1 < 0, (_nNecReal1*-1), SZO->ZO_QUANT )
						
						Reclock("TR1",.T.)
						TR1->FILIAL		:= SG1->G1_FILIAL
						TR1->TIPOPAI 	:= 1
						If mv_par02 == 1
							TR1->PRODPAI 	:= Replicate("X",Len(SZO->ZO_PRODUTO))
						Else
							TR1->PRODPAI 	:= aEstrutura[_n1][2]
						EndIf
						TR1->PRODUTO	:= aEstrutura[_n1][2]
						TR1->NIVEL  	:= StrZero(1,2)
						TR1->DESCRICAO	:= GetAdvFVal("SB1","B1_DESC", xFilial("SB1")+aEstrutura[_n1][2], 1, "")
						TR1->UNIDADE	:= GetAdvFVal("SB1","B1_UM"  , xFilial("SB1")+aEstrutura[_n1][2], 1, "")
						TR1->TIPO   	:= GetAdvFVal("SB1","B1_TIPO", xFilial("SB1")+aEstrutura[_n1][2], 1, "")
						TR1->PE 		:= GetAdvFVal("SB1","B1_PE"  , xFilial("SB1")+aEstrutura[_n1][2], 1, "")
						TR1->TIPE		:= GetAdvFVal("SB1","B1_TIPE", xFilial("SB1")+aEstrutura[_n1][2], 1, "")
						TR1->QUANT		:= SZO->ZO_QUANT
						TR1->SALDO      := aSomaSB2[1]                                                        // Soma dos saldos em estoque
						TR1->EMPENHO    := aSomaSB2[2]                                                        // Soma dos empenhos
						TR1->RESERVA    := aSomaSB2[3]                                                        // Reservas do Produto por p.v.
						TR1->PREVISAO   := aSomaSB2[4]                                                        // Previsao de entrada por p.c.
						TR1->SALDOPRE	:= _nSaldoMRP                                                         // Saldo Previsto (Saldo + Previsao) - (Empenho + Reserva)
						TR1->QUANTREA	:= _nNecReal1                                                         // Qtde a ser utilizada ou produzida
						TR1->SALDOMRP	:= _nSaldo                                                            // Saldo Final MRP
						TR1->QTDECONS	:= aSomaSB2[6]                                                        // Qtde consumida no perido
					EndIf
					TR1->(MsUnlock())
				EndIf
				                                                               
				//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
				//ณ Grava planejamento Produtos da estrutura               ณ
				//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
				DbSelectArea("TR1")
				TR1->(DbSetorder(1))
				If mv_par02 == 1
					cCodPAIX := Replicate("X",Len(SZO->ZO_PRODUTO))                                
				Else
					cCodPAIX := IIf(aEstrutura[_n1][2] == SZO->ZO_PRODUTO,aEstrutura[_n1][3], aEstrutura[_n1][2] )
				EndIf
				
				aSomaSB2   := R003SB2X(aEstrutura[_n1][3])
				_nSaldoMRP := ((aSomaSB2[1]+aSomaSB2[4])-(aSomaSB2[2]+aSomaSB2[3]))
                                                                                                                              
				If _n1 == 1
					_nQtd001 := IIf(_nNecReal1 < 0 , (_nNecReal1*-1), 0)
					_nQtdPai := IIf(_nNecReal1 < 0 , (_nNecReal1*-1), 0)
				ElseIf _n1 >= 2
					If _nQtd001 <> 0 
						If aEstrutura[_n1][1] > aEstrutura[_n1-1][1]
							_nQtdPai := IIf(_nNecReal1 < 0 , (_nNecReal1*-1), 0)
						Else
							_nQtdPai := _nQtdBKP                                                      
						EndIf
					EndIf                                                                          
				EndIf

				_nNecReal1 := _nSaldoMRP-(aEstrutura[_n1][4]*_nQtdPai)
				_nSaldo    := IIf(_nSaldoMRP-_nQtdPai < 0, 0 , _nSaldoMRP-_nQtdPai)
				
				If TR1->(!DbSeek(SG1->G1_FILIAL+cCodPAIX+aEstrutura[_n1][3],.F.))
					Reclock("TR1",.T.)
					TR1->FILIAL		:= SG1->G1_FILIAL
					TR1->PRODPAI 	:= cCodPAIX
					TR1->PRODUTO	:= aEstrutura[_n1][3]
					TR1->NIVEL  	:= StrZero(aEstrutura[_n1][1]+1,2)
					TR1->DESCRICAO	:= GetAdvFVal("SB1","B1_DESC", xFilial("SB1")+aEstrutura[_n1][3], 1, "")
					TR1->UNIDADE	:= GetAdvFVal("SB1","B1_UM"  , xFilial("SB1")+aEstrutura[_n1][3], 1, "")
					TR1->TIPO   	:= GetAdvFVal("SB1","B1_TIPO", xFilial("SB1")+aEstrutura[_n1][3], 1, "")
					TR1->PE 		:= GetAdvFVal("SB1","B1_PE"  , xFilial("SB1")+aEstrutura[_n1][3], 1, "")
					TR1->TIPE		:= GetAdvFVal("SB1","B1_TIPE", xFilial("SB1")+aEstrutura[_n1][3], 1, "")
					TR1->QUANT		:= aEstrutura[_n1][4]*_nQtdPai
					TR1->SALDO      := aSomaSB2[1]                                                        // Soma dos saldos em estoque
					TR1->EMPENHO    := aSomaSB2[2]                                                        // Soma dos empenhos
					TR1->RESERVA    := aSomaSB2[3]                                                        // Reservas do Produto por p.v.
					TR1->PREVISAO   := aSomaSB2[4]                                                        // Previsao de entrada por p.c.
					TR1->SALDOPRE	:= _nSaldoMRP                                                         // Saldo Previsto (Saldo + Previsao) - (Empenho + Reserva)
					TR1->QUANTREA	:= _nNecReal1                                                         // Qtde a ser utilizada ou produzida
					TR1->SALDOMRP	:= _nSaldo                                                            // Saldo Final MRP
					TR1->QTDECONS	:= aSomaSB2[6]                                                        // Qtde consumida no perido
				Else
					Reclock("TR1",.F.)
					TR1->QUANT		+= aEstrutura[_n1][4]*_nQtdPai
					TR1->QUANTREA	+= _nNecReal1                                                         // Qtde a ser utilizada ou produzida
				EndIf
				TR1->(MsUnlock())
				
			Next _n1
		EndIf
	EndIf
	
	SZO->(DbSkip())
End-While

DbSelectArea("TR1")
dbClearIndex()
If Mv_par02 == 1
	IndRegua("TR1",cIndTMP1,"FILIAL+PRODPAI+NIVEL+PRODUTO",,,"Selecionando Registros...")
Else
	IndRegua("TR1",cIndTMP1,"FILIAL+PRODUTO"              ,,,"Selecionando Registros...")
EndIF

dbClearIndex()
dbSetIndex(cIndTMP1+OrdBagExt())
dbSetOrder(1)
TR1->(DbGoTop())

ProcRegua(TR1->(RecCount()))
While TR1->(!Eof())
	IncProc("Impressao de Dados")
	
	If lAbortPrint
		@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
		Exit
	Endif
	
	If nLin > 58
		Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		nLin := 9
	Endif
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Posiciona-se no arquivo de Demandas para pegar dados         ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	DbSelectArea("SB3")
	SB3->(DbSetOrder(1))
	lSB3    := SB3->(DbSeek(xFilial("SB3")+TR1->PRODUTO))
	nTotdias:= (MV_PAR06-(MV_PAR05-1))
	nNumInd := (nTotdias/30)
	nMedia  := Round( (TR1->QTDECONS / round(nNumInd,0)), 0)
	nCol    := Val(TR1->NIVEL)-1
	
	If TR1->TIPOPAI == 1
		aadd(aProdPai, {TR1->PRODUTO, TR1->TIPO, Left(TR1->DESCRICAO,43), TR1->UNIDADE, TR1->QUANT, TR1->SALDO, TR1->EMPENHO, TR1->RESERVA, TR1->PREVISAO, TR1->SALDOPRE, IIf(TR1->QUANTREA<0,TR1->QUANTREA,0), TR1->SALDOMRP, TR1->TIPE, SB1->B1_LE, nMedia })
	Else

		If mv_par02 == 1              
			nVal := (TR1->SALDOPRE-TR1->QUANT)                                                   
		Else
			nVal := TR1->QUANTREA
		EndIf                                                    
                                                 
		If Mv_par03 == 1 .And. nVal >= 0                                         
			TR1->(DbSkip())
			Loop
		EndIf
		
		@ nLin,000  PSAY TR1->PRODUTO
		@ nLin,021  PSAY TR1->TIPO
		@ nLin,025  PSAY Left(TR1->DESCRICAO,43)
		@ nLin,069  PSAY TR1->UNIDADE
		@ nLin,072  PSAY Transform(TR1->QUANT   , PesqPict("SB2","B2_QATU"))
		@ nlin,087  PSAY Transform(TR1->SALDO   , PesqPict("SB2","B2_QATU"))
		@ nlin,102  PSAY Transform(TR1->EMPENHO , PesqPict("SB2","B2_QEMP"))
		@ nlin,117  PSAY Transform(TR1->RESERVA , PesqPict("SB2","B2_QPEDVEN"))
		@ nlin,132  PSAY Transform(TR1->PREVISAO, PesqPict("SB2","B2_SALPEDI"))
		@ nlin,149  PSAY Transform(TR1->SALDOPRE, PesqPict("SB2","B2_SALPEDI"))
		If mv_par02 == 1
			@ nlin,166  PSAY Transform(IIf((TR1->SALDOPRE-TR1->QUANT) <0,TR1->SALDOPRE-TR1->QUANT ,0), "@Z 999,999,999.99" )
		Else
			@ nlin,166  PSAY Transform(IIf(TR1->QUANTREA<0,TR1->QUANTREA,0), "@Z 999,999,999.99" )
		EndIf
		@ nlin,181  PSAY Transform(TR1->SALDOMRP, PesqPict("SB2","B2_QATU"))
		@ nlin,196  PSAY CalcPrazo(SB1->B1_COD,SB1->B1_LE) Picture "99999"
		@ nLin,202  PSAY TR1->TIPE
		If lSB3
			If nMedia != 0
				@ nlin,204  PSAY TR1->SALDOMRP/nMedia Picture "99999.9"
			Else
				@ nlin,203  PSAY "    N/D"
			EndIf
			@ nlin,213  PSAY nMedia Picture "9999999"
		EndIf
		
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
			
			@ nLin,000  PSAY aProdPai[_n1,01]
			@ nLin,021  PSAY aProdPai[_n1,02]
			@ nLin,025  PSAY Left(aProdPai[_n1,03],43)
			@ nLin,069  PSAY aProdPai[_n1,04]
			@ nLin,072  PSAY Transform(aProdPai[_n1,05] , PesqPict("SB2","B2_QATU"))
			@ nlin,087  PSAY Transform(aProdPai[_n1,06] , PesqPict("SB2","B2_QATU"))
			@ nlin,102  PSAY Transform(aProdPai[_n1,07] , PesqPict("SB2","B2_QEMP"))
			@ nlin,117  PSAY Transform(aProdPai[_n1,08] , PesqPict("SB2","B2_QPEDVEN"))
			@ nlin,132  PSAY Transform(aProdPai[_n1,09] , PesqPict("SB2","B2_SALPEDI"))
			@ nlin,149  PSAY Transform(aProdPai[_n1,10] , PesqPict("SB2","B2_SALPEDI"))
			@ nlin,166  PSAY Transform(aProdPai[_n1,11] , "@Z 999,999,999.99" )
			@ nlin,181  PSAY Transform(aProdPai[_n1,12] , PesqPict("SB2","B2_QATU"))
			@ nlin,196  PSAY CalcPrazo(aProdPai[_n1,01] ,aProdPai[_n1,14]) Picture "99999"
			@ nLin,202  PSAY aProdPai[_n1,13]
			If lSB3
				If aProdPai[_n1,15] != 0
					@ nlin,204  PSAY aProdPai[_n1,12]/aProdPai[_n1,15] Picture "99999.9"
				Else
					@ nlin,203  PSAY "    N/D"
				EndIf
				@ nlin,213  PSAY aProdPai[_n1,15] Picture "9999999"
			EndIf
			
			nLin++
		EndIf
	Next _n1
EndIf

Roda(0,"",tamanho)

TR1->(DbCloseArea())
fErase(_cArq+".*")

SET DEVICE TO SCREEN

If aReturn[5]==1
	dbCommitAll()
	SET PRINTER TO
	OurSpool(wnrel)
Endif

MS_FLUSH()

Return

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

Local cQuery := ""

cQuery := "SELECT '"+ Space(02) +"' TRB_OK, SB2.B2_COD, SB1.B1_DESC, SB1.B1_UM, SB1.B1_TIPO, SUM(SB2.B2_QATU) AS SALDO, SUM(B2_RESERVA) AS RESERVA, "
cQuery += "      (SELECT SALDO_PV "
cQuery += "         FROM (SELECT SC6.C6_FILIAL, SC6.C6_PRODUTO, (SUM(SC6.C6_QTDVEN)-SUM(SC6.C6_QTDENT)) AS SALDO_PV "
cQuery += "                 FROM "+ RetSQLName( 'SC6' ) +" AS SC6"
cQuery += "                WHERE SC6.C6_FILIAL  = '"+ xFilial("SC6") +"' "
cQuery += "                  AND SC6.C6_PRODUTO = SB2.B2_COD
cQuery += "                  AND SC6.C6_LOCAL  IN "+ FormatIn(AllTrim(Mv_par01),"/")
cQuery += "                  AND SC6.C6_QTDENT <> SC6.C6_QTDVEN"
cQuery += "                  AND SC6.C6_BLQ    <> 'R'
cQuery += "                  AND SC6.D_E_L_E_T_ = ' '
cQuery += "                GROUP BY SC6.C6_FILIAL, SC6.C6_PRODUTO
cQuery += "              ) XX1
cQuery += "      ) AS SALDO_PV, "

cQuery += "      (SELECT SALDO_OP "
cQuery += "         FROM (SELECT SC2.C2_FILIAL, SC2.C2_PRODUTO, (SUM(SC2.C2_QUANT)-SUM(SC2.C2_QUJE)) AS SALDO_OP"
cQuery += "                 FROM "+ RetSQLName( 'SC2' ) +" AS SC2"
cQuery += "                WHERE SC2.C2_DATRF    = ' '
cQuery += "                  AND SC2.C2_PRODUTO  = SB2.B2_COD"
cQuery += "                  AND SC2.C2_FILIAL   = '"+ xFilial("SC2") +"'"
cQuery += "                  AND SC2.D_E_L_E_T_  = ' '
cQuery += "                GROUP BY SC2.C2_FILIAL, SC2.C2_PRODUTO
cQuery += "               ) XX2
cQuery += "      ) AS SALDO_OP, "

cQuery += "      (SELECT EMP_SLD "
cQuery += "         FROM (SELECT SD4.D4_FILIAL, SD4.D4_COD, SUM(SD4.D4_QUANT) AS EMP_SLD "
cQuery += "                 FROM "+ RetSQLName( 'SD4' ) +" AS SD4"
cQuery += "                WHERE SD4.D4_COD     = SB2.B2_COD"
cQuery += "                  AND SD4.D_E_L_E_T_ = ' '"
cQuery += "                GROUP BY SD4.D4_FILIAL, SD4.D4_COD"
cQuery += "              ) XX3
cQuery += "      ) AS EMP_SLD, "

cQuery += "      (SELECT SALDO_PC "
cQuery += "         FROM (SELECT SC7.C7_FILIAL, SC7.C7_PRODUTO, (SUM(SC7.C7_QUANT)-SUM(SC7.C7_QUJE)) AS SALDO_PC"
cQuery += "                 FROM "+ RetSQLName( 'SC7' ) +" AS SC7"
cQuery += "                WHERE SC7.C7_PRODUTO  = SB2.B2_COD"
cQuery += "                  AND SC7.C7_FILIAL   = '"+ xFilial("SC7") +"'"
cQuery += "                  AND SC7.D_E_L_E_T_  = ' '
cQuery += "                GROUP BY SC7.C7_FILIAL, SC7.C7_PRODUTO
cQuery += "               ) XX5
cQuery += "      ) AS SALDO_PC, "

cQuery += "      (SELECT QUANT_CONS "
cQuery += "         FROM (SELECT CODIGO, SUM(QUANT) AS QUANT_CONS
cQuery += "                 FROM (SELECT SD2.D2_COD AS CODIGO, SUM(SD2.D2_QUANT) AS QUANT"
cQuery += "                         FROM "+ RetSQLName( 'SD2' ) +"   AS SD2 , "+ RetSQLName( 'SF4' ) +"   AS SF4 "
cQuery += "                        WHERE SD2.D2_FILIAL  = '"+ xFilial("SD2") +"'"
cQuery += "                          AND SD2.D2_COD     = SB2.B2_COD"                         
cQuery += "                          AND SD2.D2_EMISSAO BETWEEN '"+ Dtos(Mv_Par05)+"' AND '"+Dtos(Mv_Par06)+"'"
cQuery += "                          AND SD2.D2_LOCAL   IN "+ FormatIn( Mv_par01, "/" )            
cQuery += "                          AND SD2.D2_TES     BETWEEN '500' AND '999'"
cQuery += "                          AND SD2.D_E_L_E_T_ = ' ' "
cQuery += "                          AND SF4.F4_CODIGO  = SD2.D2_TES"
cQuery += "                          AND SF4.F4_FILIAL  = '"+ xFilial("SF4") +"'"               
cQuery += "                          AND SF4.F4_ESTOQUE = 'S' "
cQuery += "                          AND SF4.D_E_L_E_T_ = ' ' "
cQuery += "                        GROUP BY SD2.D2_COD
cQuery += "                        UNION ALL "
cQuery += "                       SELECT SD3.D3_COD AS CODIGO, SUM(SD3.D3_QUANT) AS QUANT"                   
cQuery += "                         FROM "+ RetSQLName( 'SD3' ) +"   AS SD3"
cQuery += "                        WHERE SD3.D3_FILIAL  = '"+ xFilial("SD3") +"'"
cQuery += "                          AND SD3.D3_COD     = SB2.B2_COD"
cQuery += "                          AND SD3.D3_EMISSAO BETWEEN '"+ Dtos(Mv_Par05)+"' AND '"+Dtos(Mv_Par06)+"'"
cQuery += "                          AND SD3.D3_LOCAL   IN "+ FormatIn( Mv_par01, "/" )
cQuery += "                          AND (SD3.D3_TM     BETWEEN '500' AND '996'"
cQuery += "                           OR  SD3.D3_TM      >= '990')"
cQuery += "                          AND SD3.D3_ESTORNO <> 'S' "
cQuery += "                          AND SD3.D_E_L_E_T_ =  ' ' "
cQuery += "                        GROUP BY SD3.D3_COD
cQuery += "                      ) XX6                           
cQuery += "                GROUP BY CODIGO "
cQuery += "              ) XX7
cQuery += "      ) AS QUANT_CONS "

cQuery += "  FROM "+ RetSQLName( 'SB2' ) +"  AS SB2, "+ RetSQLName( 'SB1' ) +"   AS SB1 "
cQuery += " WHERE SB2.B2_FILIAL  = '"+ xFilial("SB2") +"'"
cQuery += "   AND SB2.B2_LOCAL   IN "+ FormatIn(AllTrim(Mv_par01),"/")
cQuery += "   AND SB2.B2_COD     = '"+ cProduto +"'"
cQuery += "   AND SB2.D_E_L_E_T_ = ' ' "
cQuery += "   AND SB1.B1_COD     = SB2.B2_COD"
cQuery += "   AND SB1.D_E_L_E_T_ = ' ' "
cQuery += " GROUP BY SB2.B2_COD, SB1.B1_DESC, SB1.B1_UM, SB1.B1_TIPO"
cQuery += " ORDER BY SB2.B2_COD"

cAliasA	:= GetNextAlias()                                                              
cQuery  := ChangeQuery(cQuery)                                                               
nTotReg := 0

DbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cAliasA , .F., .T.)
aEval( SB2->(dbStruct()),{|x| If(x[2]!="C", TcSetField(cAliasA,AllTrim(x[1]),x[2],x[3],x[4]),Nil)})
aEval( SB1->(dbStruct()),{|x| If(x[2]!="C", TcSetField(cAliasA,AllTrim(x[1]),x[2],x[3],x[4]),Nil)})

_aRet := {(cAliasA)->SALDO, (cAliasA)->EMP_SLD, (cAliasA)->SALDO_PV+((cAliasA)->SALDO_PV-(cAliasA)->RESERVA), (cAliasA)->SALDO_OP, (cAliasA)->SALDO_PC, (cAliasA)->QUANT_CONS}

(cAliasA)->(DbCloseArea())

Return(_aRet)

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
