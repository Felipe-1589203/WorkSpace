#INCLUDE "Protheus.ch"
#INCLUDE "TopConn.ch"                             
#INCLUDE "Rwmake.ch"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                              M U L T  -  T  -  L O C K                                บฑฑ
ฑฑฬออออออออออออัอออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบPrograma    ณ MPCPR001  ณ Analise Demanda - Lista de materias com os seus respectivos  บฑฑ
ฑฑบ            ณ           ณ consumos e simula o planejamento mrp                         บฑฑ       
ฑฑบ 29/12/2009 ณ Jean C.   ณ * Alteracao no range das TMs,desconsiderar as TMS 997,998,999บฑฑ
ฑฑฬออออออออออออุอออออออออออฯอออออออออออออออออออออออออออออออออออออออออออัออออออัอออออออออออนฑฑ
ฑฑบAutor       ณ Actual Trend                                          ณ Data ณ  31/03/09 บฑฑ
ฑฑศออออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออฯอออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

User Function MPCPR001(_nTipProd)                                         

Local cDesc1       := "Este relatorio tem a fun็ใo de calcular os saldos e"
Local cDesc2       := "empenhos/reservas somar as quantidades dos componentes"
Local cDesc3       := "em comum e gerar previsใo de produ็ใo"
Local cPict        := ""
Local titulo       := "Materiais com media de consumo no periodo de"
Local nLin         := 80
Local Cabec1       := "CODIGO           DESCRICAO                       TIPO     UM           SALDO        ESTOQUE           QTDE  PD.VENDA     O.P MULT    EMPENHOS        SC EM        PC EM      CONSUMO        MEDIA NECESSIDADE  NECESSIDADE"
Local Cabec2       := "PRODUTO          PRODUTO                         PRODUTO  MED     DISPONIVEL     ATUAL MULT      RESERVADA  CARTEIRA  EM PROCESSO EM PROCESSO     PROCESSO     PROCESSO   DO PERIODO   DE CONSUMO    PRODUCAO        BRUTA"
Local imprime      := .T.
Local aOrd         := {}
Local lPerg        :=  .T.

Private cDirDocs   := MsDocPath()                                           
Private cBarra	   := If(IsSrvUnix(), "/", "\")
Private cPath	   := AllTrim(GetTempPath())
Private cBuffer	   := ""
Private cArqExp	   := ""
Private nHdlXls	   := 0
Private lExcel	   := .F.

Private lEnd       := .F.
Private lAbortPrint:= .F.
Private limite     := 220
Private tamanho    := "G"
Private nomeprog   := "MPCPR001"
Private nTipo      := 18
Private aReturn    := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey   := 0
Private cbtxt      := Space(10)
Private cbcont     := 00
Private CONTFL     := 01
Private m_pag      := 01
Private wnrel      := "MPCPR001"
Private cPerg      := "MPCPR001"
Private cString    := "SB1"
Private _aTMParray := {}
Private lContinua  := .T.

Default _nTipProd  := 1

If _nTipProd == 1 .And. AllTrim(FunName()) == "MPCPR001"
	R001PERG(cPerg)
	lPerg := Pergunte(cPerg)
EndIf

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
	
	If _nTipProd == 2 .Or. (_nTipProd == 1  .And. AllTrim(FunName()) == "MPCPR001" )
		If !ApOleClient("MsExcel")
			Aviso("Gera็ใo Planilha","Excel nใo instalado ou nใo configurado para o Protheus."+Chr(13)+Chr(10)+"Verifique...",{"&Continua"},,"Falta Programa" )
			lExcel	:= .F.
		Else
			cArqExp := CriaTrab(,.F.)+".CSV"
			nHdlXls	:= fCreate(cDirDocs+cBarra+cArqExp)
			lExcel	:= .T.
			
			If nHdlXls == -1
				Aviso("Gera็ใo Planilha","Nใo foi possํvel criar o arquivo CSV para ser utilizado com o Excel. Verifique as permiss๕es.",{"&Continua"},,"Arquivo: "+Alltrim(cArqExp) )
				lExcel	:= .F.
			EndIf
		EndIf
	EndIf
	
	Titulo := AllTrim(Titulo)+" "+Dtoc(MV_PAR02)+ " a "+Dtoc(MV_PAR03)+" - Filial: " +mv_par01
	
	If Empty(Mv_Par01)
		MsgInfo("Nใo foi selecionado armazem","Impossivel gerar")
	Else
		Processa({|| R001GERA(Cabec1,Cabec2,Titulo,nLin,_nTipProd) },Titulo)
	EndIf
	
	If lExcel == .T.
		lGera := .F.
		
		If _nTipProd == 1 .And. AllTrim(FunName()) == "MPCPR001"
			If MsgYesNo("Deseja gerar planilha EXCEL ?",'Gera็ใo de planilha')
				lGera := .T.
			EndIf
		ElseIf _nTipProd == 2
			lGera := .T.
		EndIf
		
		If lGera == .T.
			fClose(nHdlXls)
			
			CpyS2T(cDirDocs + cBarra + cArqExp, cPath, ,.T.)
			fErase(cDirDocs+cBarra+cArqExp)
			
			If !File(cPath+cArqExp)
				Aviso("Gera็ใo Planilha","Arquivo '"+cPath+cArqExp+"', NรO encontrado! Verifique...",{"&Abortar"},,"Excel" )
			Else
				oExcelApp	:= MsExcel():New()
				oExcelApp:WorkBooks:Open(cPath+cArqExp)
				oExcelApp:SetVisible(.T.)
			EndIf
		EndIf
		
	EndIf
EndIf

Return()

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                                 M  U   L  - T -  L  O  C  K                           บฑฑ
ฑฑฬออออออออออออัอออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบPrograma    ณ R001GERA  ณ Demanda de consumo - Selecionado dados conforme parametros   บฑฑ
ฑฑฬออออออออออออุอออออออออออฯอออออออออออออออออออออออออออออออออออออออออออัออออออัอออออออออออนฑฑ
ฑฑบAutor       ณ  Especifico Actual Trend - www.actualtrend.com.br     ณ Data ณ  09/04/09 บฑฑ
ฑฑศออออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออฯอออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

Static Function R001GERA(Cabec1,Cabec2,Titulo,nLin,_nTipProd)

Local cQuery      := ""
Local nNumInd     := 0
Local nMedia      := 0
Local nNecess     := 0
Local nNecessEmp  := 0
Local nSaldoDp    := 0
Local nSaldoPV    := 0
Local nSaldoOP    := 0
Local nSaldoEM    := 0
Local nSaldoSC    := 0
Local nSaldoPC    := 0
Local nSaldoCO    := 0

Private cFilIni   := AllTrim( GetMV("MV_XFILINI" ,,"01") )
Private cFilFim   := AllTrim( GetMV("MV_XFILFIM" ,,"01") )
Private cArmIni   := AllTrim( GetMV("MV_XARMFIM" ,,"01") )
Private cArmFim   := AllTrim( GetMV("MV_XARMFIM" ,,"01") )

IncProc("Montando Query para sele็ใo dos Dados")

cQuery := "SELECT '"+ Space(02) +"' TRB_OK, SB2.B2_COD, SB1.B1_DESC, SB1.B1_UM, SB1.B1_TIPO, 0 AS SLDISPO, SUM(SB2.B2_QATU) AS SALDO, SUM(B2_RESERVA) AS RESERVA, "
cQuery += "      (SELECT SALDO_PV "
cQuery += "         FROM (SELECT SC6.C6_FILIAL, SC6.C6_PRODUTO, (SUM(SC6.C6_QTDVEN)-SUM(SC6.C6_QTDENT)) AS SALDO_PV "
cQuery += "                 FROM "+ RetSQLName( 'SC6' ) +" AS SC6"
cQuery += "                WHERE SC6.C6_FILIAL  = '"+ Mv_Par01 +"' "
cQuery += "                  AND SC6.C6_PRODUTO = SB2.B2_COD
cQuery += "                  AND SC6.C6_LOCAL   BETWEEN '"+ cArmIni +"' AND '"+ cArmFim +"'"
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
cQuery += "                  AND SC2.C2_FILIAL   BETWEEN '"+ cFilIni +"' AND '"+ cFilFim +"'"
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

cQuery += "      (SELECT SALDO_SC "
cQuery += "         FROM (SELECT SC1.C1_FILIAL, SC1.C1_PRODUTO, (SUM(SC1.C1_QUANT)-SUM(SC1.C1_QUJE)) AS SALDO_SC"
cQuery += "                 FROM "+ RetSQLName( 'SC1' ) +" AS SC1"
cQuery += "                WHERE SC1.C1_DATPRF   <> ' '
cQuery += "                  AND SC1.C1_PRODUTO  = SB2.B2_COD"
cQuery += "                  AND SC1.C1_FILIAL   BETWEEN '"+ cFilIni +"' AND '"+ cFilFim +"'"
cQuery += "                  AND SC1.D_E_L_E_T_  = ' '
cQuery += "                GROUP BY SC1.C1_FILIAL, SC1.C1_PRODUTO
cQuery += "               ) XX4
cQuery += "      ) AS SALDO_SC, "

cQuery += "      (SELECT SALDO_PC "
cQuery += "         FROM (SELECT SC7.C7_FILIAL, SC7.C7_PRODUTO, (SUM(SC7.C7_QUANT)-SUM(SC7.C7_QUJE)) AS SALDO_PC"
cQuery += "                 FROM "+ RetSQLName( 'SC7' ) +" AS SC7"
cQuery += "                WHERE SC7.C7_PRODUTO  = SB2.B2_COD"
cQuery += "                  AND SC7.C7_FILIAL   BETWEEN '"+ cFilIni +"' AND '"+ cFilFim +"'"
cQuery += "                  AND SC7.D_E_L_E_T_  = ' '
cQuery += "                GROUP BY SC7.C7_FILIAL, SC7.C7_PRODUTO
cQuery += "               ) XX5
cQuery += "      ) AS SALDO_PC, "

cQuery += "      (SELECT QUANT_CONS "
cQuery += "         FROM (SELECT CODIGO, SUM(QUANT) AS QUANT_CONS
cQuery += "                 FROM (SELECT SD2.D2_COD AS CODIGO, SUM(SD2.D2_QUANT) AS QUANT"
cQuery += "                         FROM "+ RetSQLName( 'SD2' ) +"   AS SD2 , "+ RetSQLName( 'SF4' ) +"   AS SF4 "
cQuery += "                        WHERE SD2.D2_FILIAL  = '"+ Mv_Par01 +"'"
cQuery += "                          AND SD2.D2_COD     = SB2.B2_COD"
cQuery += "                          AND SD2.D2_EMISSAO BETWEEN '"+ Dtos(Mv_Par02)+"' AND '"+Dtos(Mv_Par03)+"'"
cQuery += "                          AND SD2.D2_LOCAL   BETWEEN '"+ Mv_par09 +"' AND '"+ Mv_Par10 +"'"
cQuery += "                          AND SD2.D2_TES     BETWEEN '500' AND '999'"
cQuery += "                          AND SD2.D_E_L_E_T_ = ' ' "
cQuery += "                          AND SF4.F4_CODIGO  = SD2.D2_TES"
cQuery += "                          AND SF4.F4_FILIAL  = '"+ Mv_Par01 +"'"
cQuery += "                          AND SF4.F4_ESTOQUE = 'S' "
cQuery += "                          AND SF4.D_E_L_E_T_ = ' ' "
cQuery += "                        GROUP BY SD2.D2_COD
cQuery += "                        UNION ALL "
cQuery += "                       SELECT SD3.D3_COD AS CODIGO, SUM(SD3.D3_QUANT) AS QUANT"
cQuery += "                         FROM "+ RetSQLName( 'SD3' ) +"   AS SD3"
cQuery += "                        WHERE SD3.D3_FILIAL  = '"+ Mv_Par01 +"'"
cQuery += "                          AND SD3.D3_COD     = SB2.B2_COD"
cQuery += "                          AND SD3.D3_EMISSAO BETWEEN '"+ Dtos(Mv_Par02)+"' AND '"+Dtos(Mv_Par03)+"'"
cQuery += "                          AND SD3.D3_LOCAL   BETWEEN '"+ Mv_par09 +"' AND '"+ Mv_Par10 +"'"
cQuery += "                          AND (SD3.D3_TM     BETWEEN '500' AND '996'"
cQuery += "                           OR  SD3.D3_TM      >= '990')"
cQuery += "                          AND SD3.D3_ESTORNO <> 'S' "
cQuery += "                          AND SD3.D_E_L_E_T_ =  ' ' "
cQuery += "                        GROUP BY SD3.D3_COD
cQuery += "                      ) XX6
cQuery += "                GROUP BY CODIGO "
cQuery += "              ) XX7
cQuery += "      ) AS QUANT_CONS, "
cQuery += "   SUM(0) AS MEDIA, SUM(0) AS NECESS, SUM(0) AS NECBRU"

cQuery += "  FROM "+ RetSQLName( 'SB2' ) +"  AS SB2, "+ RetSQLName( 'SB1' ) +"   AS SB1 "
cQuery += " WHERE SB2.B2_FILIAL  = '"+ Mv_Par01 +"' "
cQuery += "   AND SB2.B2_LOCAL   BETWEEN '"+ Mv_Par11 +"' AND '"+ Mv_Par12 +"'"
cQuery += "   AND SB2.B2_COD     BETWEEN '"+ Mv_Par05 +"' AND '"+ Mv_Par06 +"'"
cQuery += "   AND SB2.D_E_L_E_T_ = ' ' "
cQuery += "   AND SB1.B1_COD     = SB2.B2_COD"
cQuery += "   AND SB1.B1_GRUPO   BETWEEN '"+ Mv_Par07 +"' AND '"+ Mv_Par08 +"'"
If !Empty(Mv_Par04)
	cQuery += " AND SB1.B1_TIPO  = '"+ Mv_Par04 +"'"
EndIf
cQuery += "   AND SB1.D_E_L_E_T_ = ' ' "
cQuery += " GROUP BY SB2.B2_COD, SB1.B1_DESC, SB1.B1_UM, SB1.B1_TIPO"
cQuery += " ORDER BY SB2.B2_COD"

cAliasA	:= GetNextAlias()
cQuery  := ChangeQuery(cQuery)
nTotReg := 0

DbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cAliasA , .F., .T.)
aEval( SB2->(dbStruct()),{|x| If(x[2]!="C", TcSetField(cAliasA,AllTrim(x[1]),x[2],x[3],x[4]),Nil)})
aEval( SB1->(dbStruct()),{|x| If(x[2]!="C", TcSetField(cAliasA,AllTrim(x[1]),x[2],x[3],x[4]),Nil)})

(cAliasA)->(DbGoTop())
(cAliasA)->( dbEval( { || nTotReg++ },,{ || !Eof() } ) )
(cAliasA)->(DbGoTop())

If _nTipProd <> 3  // WorkArea
	ProcRegua(nTotReg)
	
	If nTotReg > 0
		nTotdias := (MV_PAR03-(MV_PAR02-1))
		nNumInd  := (nTotdias/30)
		
		If lExcel == .T.
			cBuffer	:= ToXlsFormat(" ") +";"+ ToXlsFormat(Titulo)
			FWrite(nHdlXls, cBuffer)
			FWrite(nHdlXls, CRLF)
			
			cBuffer	:= "CODIGO ;DESCRICAO;TIPO   ;UM ;SALDO;ESTOQUE;QTDE;PED. VENDA;O.P MULT   ;EMPENHOS   ;SC EM   ;PC EM   ;CONSUMO   ;MEDIA     ;NECESSIDADE;NECESSIDADE"
			FWrite(nHdlXls, cBuffer)
			FWrite(nHdlXls, CRLF)
			
			cBuffer	:= "PRODUTO;PRODUTO  ;PRODUTO;MED;DISPONIVEL;ATUAL MULT;RESERVADA;CARTEIRA  ;EM PROCESSO;EM PROCESSO;PROCESSO;PROCESSO;DO PERIODO;DE CONSUMO;PRODUCAO   ;BRUTA"
			FWrite(nHdlXls, cBuffer)
			FWrite(nHdlXls, CRLF)
			FWrite(nHdlXls, CRLF)
		EndIf
		
		While !(cAliasA)->(Eof())
			_nValSLD  := 0
			
			SB2->(DbSetOrder(1))
			If SB2->( DbSeek(xFilial("SB2") +(cAliasA)->B2_COD ))
				_nValSLD := SaldoSB2(,,,,,"SB2")
			EndIf
			nMedia    := Round( ((cAliasA)->QUANT_CONS / round(nNumInd,0)), 0)
			nNecess   := Round( ((cAliasA)->SALDO + (cAliasA)->SALDO_OP + (cAliasA)->SALDO_SC + (cAliasA)->SALDO_PC)-((cAliasA)->SALDO_PV +((cAliasA)->RESERVA-(cAliasA)->SALDO_PV)+ nMedia + (cAliasA)->EMP_SLD), 0)
			nNecessEmp:= Round( (((cAliasA)->SALDO)-((cAliasA)->SALDO_PV+((cAliasA)->RESERVA-(cAliasA)->SALDO_PV)+nMedia)), 0)
			
			If lExcel == .T.
				cBuffer	:= ToXlsFormat( IIf(ValType((cAliasA)->B2_COD ) == "C" .And. LEFT((cAliasA)->B2_COD ,1) == "0","'","") + (cAliasA)->B2_COD ) +";"
				cBuffer	+= ToXlsFormat( IIf(ValType((cAliasA)->B1_DESC) == "C" .And. LEFT((cAliasA)->B1_DESC,1) == "0","'","") + (cAliasA)->B1_DESC) +";"
				cBuffer	+= ToXlsFormat( IIf(ValType((cAliasA)->B1_TIPO) == "C" .And. LEFT((cAliasA)->B1_TIPO,1) == "0","'","") + (cAliasA)->B1_TIPO) +";"
				cBuffer	+= ToXlsFormat( IIf(ValType((cAliasA)->B1_UM  ) == "C" .And. LEFT((cAliasA)->B1_UM  ,1) == "0","'","") + (cAliasA)->B1_UM  ) +";"
				cBuffer	+= ToXlsFormat( Transform(_nValSLD             , PesqPict("SB2","B2_QATU"  )) ) +";"
				cBuffer	+= ToXlsFormat( Transform((cAliasA)->SALDO     , PesqPict("SB2","B2_QATU"  )) ) +";"
				cBuffer	+= ToXlsFormat( Transform((cAliasA)->RESERVA-(cAliasA)->SALDO_PV, PesqPict("SB2","B2_RESERVA")) ) +";"
				cBuffer	+= ToXlsFormat( Transform((cAliasA)->SALDO_PV  , PesqPict("SC6","C6_QTDVEN")) ) +";"
				cBuffer	+= ToXlsFormat( Transform((cAliasA)->SALDO_OP  , PesqPict("SC2","C2_QUANT" )) ) +";"
				cBuffer	+= ToXlsFormat( Transform((cAliasA)->EMP_SLD   , PesqPict("SD4","D4_QUANT" )) ) +";"
				cBuffer	+= ToXlsFormat( Transform((cAliasA)->SALDO_SC  , PesqPict("SC1","C1_QUANT" )) ) +";"
				cBuffer	+= ToXlsFormat( Transform((cAliasA)->SALDO_PC  , PesqPict("SC7","C7_QUANT" )) ) +";"
				cBuffer	+= ToXlsFormat( Transform((cAliasA)->QUANT_CONS, PesqPict("SD2","D2_QUANT" )) ) +";"
				cBuffer	+= ToXlsFormat( Transform(nMedia                , PesqPict("SC2","C2_QUANT" )) ) +";"
				cBuffer	+= ToXlsFormat( Transform(IIf(nNecess < 0,nNecess, 0), PesqPict("SC2","C2_QUANT" )) ) +";"
				cBuffer	+= ToXlsFormat( Transform(IIf(nNecessEmp  < 0,nNecessEmp , 0), PesqPict("SC2","C2_QUANT" )) ) +";"
				FWrite(nHdlXls, cBuffer)
				FWrite(nHdlXls, CRLF)
			EndIf
			
			If _nTipProd == 1        // Gerar Impressao
				IncProc("Imprimindo demanda")
				
				If lAbortPrint
					@ nLin,000 PSAY "*** CANCELADO PELO OPERADOR ***"
					Exit
				Endif
				
				If nLin > 56
					Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
					nLin := 9
				Endif
				
				@ nLin, 000 PSAY (cAliasA)->B2_COD
				@ nLin, 017 PSAY Left((cAliasA)->B1_DESC,36)
				@ nLin, 054 PSAY (cAliasA)->B1_TIPO
				@ nLin, 058 PSAY (cAliasA)->B1_UM
				
				@ nLin, 062 PSAY Transform(_nValSLD            , PesqPict("SB2","B2_QATU"))    // 999,999,999.99
				
				If Mv_par01 == '01'
					@ nLin, 077 PSAY Transform((cAliasA)->SALDO, PesqPict("SB2","B2_QATU"))    // 999,999,999.99
				EndIf
				
				@ nLin, 092 PSAY Transform((cAliasA)->RESERVA-(cAliasA)->SALDO_PV, PesqPict("SB2","B2_RESERVA"))   // 999,999,999.99
				@ nLin, 107 PSAY Transform((cAliasA)->SALDO_PV, PesqPict("SC6","C6_QTDVEN"))   // 99,999.99
				@ nLin, 117 PSAY Transform((cAliasA)->SALDO_OP, PesqPict("SC2","C2_QUANT") )   // 9,999,999.99
				@ nLin, 130 PSAY Transform((cAliasA)->EMP_SLD , PesqPict("SD4","D4_QUANT") )   // 9999,999.99
				@ nLin, 142 PSAY Transform((cAliasA)->SALDO_SC, PesqPict("SC1","C1_QUANT") )   // 9,999,999.99
				@ nLin, 155 PSAY Transform((cAliasA)->SALDO_PC, PesqPict("SC7","C7_QUANT") )   // 9,999,999.99
				@ nLin, 168 PSAY Transform((cAliasA)->QUANT_CONS, PesqPict("SD2","D2_QUANT") ) // 9999,999.99
				@ nLin, 181 PSAY Transform(nMedia    , PesqPict("SC2","C2_QUANT") )            // 9,999,999.99
				
				If nNecess < 0
					@ nLin, 194 PSAY Transform(nNecess   , PesqPict("SC2","C2_QUANT") )   // 9,999,999.99
				Endif
				
				If nNecessEmp < 0
					@ nLin, 207 PSAY Transform(nNecessEmp, PesqPict("SC2","C2_QUANT") )   // 9,999,999.99
				Endif
				
				nSaldoDp += _nValSLD
				nSaldoPV += (cAliasA)->SALDO
				nSaldoOP += (cAliasA)->SALDO_PV
				nSaldoEM += (cAliasA)->SALDO_OP
				nSaldoSC += (cAliasA)->EMP_SLD
				nSaldoPC += (cAliasA)->SALDO_SC
				nSaldoCO += (cAliasA)->QUANT_CONS
				nLin++
			EndIf
			
			(cAliasA)->(DbSkip())
		End-While
		
		If _nTipProd == 1        // Gerar Impressao
			nLin++
			@ nLin, 000 PSAY Replicate("-",Limite)
			nLin++
			@ nLin, 082 PSAY Transform(nSaldoPV, PesqPict("SC6","C6_QTDVEN"))   // 99,999.99
			@ nLin, 104 PSAY Transform(nSaldoOP, PesqPict("SC2","C2_QUANT") )   // 9,999,999.99
			@ nLin, 118 PSAY Transform(nSaldoEM, PesqPict("SD4","D4_QUANT") )   // 9999,999.99
			@ nLin, 129 PSAY Transform(nSaldoSC, PesqPict("SC1","C1_QUANT") )   // 9,999,999.99
			@ nLin, 142 PSAY Transform(nSaldoPC, PesqPict("SC7","C7_QUANT") )   // 9,999,999.99
			@ nLin, 168 PSAY Transform(nSaldoCO, PesqPict("SD2","D2_QUANT") )   // 9999,999.99
			
			nLin++
			@ nLin, 000 PSAY Replicate("-",Limite)
			nLin+= 2
			
			@ nLin, 000 PSAY "Consumo e media calculada considerando os ultimos -> "+ALLTRIM(STR(Round(nNumInd,0)))+" <- meses."
			nLin++
			
			Roda(cbCont,cbTxt,Tamanho)
			
			SET DEVICE TO SCREEN
			If aReturn[5]==1
				dbCommitAll()
				SET PRINTER TO
				OurSpool(wnrel)
			Endif
			
			MS_FLUSH()
		EndIf
		
		If lExcel == .T.
			fClose(nHdlXls)
			
			CpyS2T(cDirDocs + cBarra + cArqExp, cPath, ,.T.)
			fErase(cDirDocs+cBarra+cArqExp)
		EndIf
	EndIf
Else
	// ************************ Monta arquivo temporario para Browse da Demanda
	If Select("TRB") > 0
		DbSelectArea("TRB")
		TRB->(DbCloseArea())
	EndIf
	
	_aStruct := (cAliasA)->(DbStruct())
	cArqTRB  := CriaTrab( _aStruct )
	dbUseArea( .T.,__LocalDriver, cArqTRB, "TRB", .T. , .F. )
	IndRegua("TRB" , cArqTRB, "B2_COD",,,"Criando Indice..." )
	
	DbSelectArea("TRB")
	Append From &cAliasA
	
	nTotdias := (MV_PAR03-(MV_PAR02-1))
	nNumInd  := (nTotdias/30)
	
	TRB->(DbGoTop())
	While TRB->(!Eof())
		SB2->(DbSetOrder(1))
		If SB2->( DbSeek(xFilial("SB2") +TRB->B2_COD ))
			_nValSLD  := 0
			
			SB2->(DbSetOrder(1))
			If SB2->( DbSeek(xFilial("SB2") +TRB->B2_COD ))
				_nValSLD := SaldoSB2(,,,,,"SB2")
			EndIf
			
			nMedia    := Round( (TRB->QUANT_CONS / round(nNumInd,0)), 0)
			nNecess   := Round( (TRB->SALDO + TRB->SALDO_OP + TRB->SALDO_SC + TRB->SALDO_PC)-(TRB->SALDO_PV +(TRB->RESERVA-TRB->SALDO_PV)+ nMedia + TRB->EMP_SLD), 0)
			nNecessEmp:= Round( ((TRB->SALDO)-(TRB->SALDO_PV+(TRB->RESERVA-TRB->SALDO_PV)+nMedia)), 0)
			
			RecLock("TRB",.F.)
			TRB->SLDISPO := _nValSLD
			TRB->RESERVA := TRB->RESERVA-TRB->SALDO_PV
			TRB->MEDIA   := nMedia
			TRB->NECESS  := IIf(nNecess    <=0, nNecess   , 0)
			TRB->NECBRU  := IIf(nNecessEmp <=0, nNecessEmp, 0)
			
			MsUnLock()
		EndIf
		
		TRB->(DbSkip())
	End-While
EndIf

( cAliasA )->( DbCloseArea())

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                              M U L T  -  T  -  L O C K                                บฑฑ
ฑฑฬออออออออออออัอออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบFuncao      ณ R001PERG  ณ Verifica a existencia das perguntas criando-as caso seja     บฑฑ
ฑฑบ            ณ           ณ  necessario (caso nao existam).                              บฑฑ
ฑฑฬออออออออออออุอออออออออออฯอออออออออออออออออออออออออออออออออออออออออออัออออออัอออออออออออนฑฑ
ฑฑบAutor       ณ Actual Trend                                          ณ Data ณ  09/04/09 บฑฑ
ฑฑศออออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออฯอออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

Static Function R001PERG(cPerg)

Local aAreaAtu	:= GetArea()
Local aAreaSX1	:= SX1->( GetArea() )      

PutSx1(	cPerg, "01","Filial de Consumo        ? ","","","Mv_ch1",TAMSX3("B2_FILIAL")[3] ,TAMSX3("B2_FILIAL")[1] ,TAMSX3("B2_FILIAL")[2] ,0,"G","","SM0","","N","Mv_par01","","","","","","","","","","","","","","","","","","","","","","",{"Informe a filial de consumo a ser considerada ",""},{""},{""},"")
PutSx1(	cPerg, "02","Data de Consumo De       ? ","","","Mv_ch2",TAMSX3("D2_EMISSAO")[3],TAMSX3("D2_EMISSAO")[1],TAMSX3("D2_EMISSAO")[2],0,"G","",""   ,"","N","Mv_par02","","","","","","","","","","","","","","","","","","","","","","",{"Informe a data inicial de consumo"             ,""},{""},{""},"")
PutSx1(	cPerg, "03","Data de Consumo At้      ? ","","","Mv_ch3",TAMSX3("D2_EMISSAO")[3],TAMSX3("D2_EMISSAO")[1],TAMSX3("D2_EMISSAO")[2],0,"G","",""   ,"","N","Mv_par03","","","","","","","","","","","","","","","","","","","","","","",{"Informe a data Final de consumo"               ,""},{""},{""},"")
PutSx1(	cPerg, "04","Tipo de Produto          ? ","","","Mv_ch4",TAMSX3("B1_TIPO")[3]   ,TAMSX3("B1_TIPO")[1]   ,TAMSX3("B1_TIPO")[2]   ,0,"G","","02" ,"","N","Mv_par04","","","","","","","","","","","","","","","","","","","","","","",{"Informe o tipo de produto a ser consideradao"  ,""},{""},{""},"")
PutSx1(	cPerg, "05","Produto De               ? ","","","Mv_ch5",TAMSX3("B1_COD")[3]    ,TAMSX3("B1_COD")[1]    ,TAMSX3("B1_COD")[2]    ,0,"G","","SB1","","N","Mv_par05","","","","","","","","","","","","","","","","","","","","","","",{"Informe o produto inicial a ser considerado"   ,""},{""},{""},"")
PutSx1(	cPerg, "06","Produto At้              ? ","","","Mv_ch6",TAMSX3("B1_COD")[3]    ,TAMSX3("B1_COD")[1]    ,TAMSX3("B1_COD")[2]    ,0,"G","","SB1","","N","Mv_par06","","","","","","","","","","","","","","","","","","","","","","",{"Informe o produto final a ser considerado"     ,""},{""},{""},"")
PutSx1(	cPerg, "07","Grupo de Produto De      ? ","","","Mv_ch7",TAMSX3("BM_GRUPO")[3]  ,TAMSX3("BM_GRUPO")[1]  ,TAMSX3("BM_GRUPO")[2]  ,0,"G","","SBM","","N","Mv_par07","","","","","","","","","","","","","","","","","","","","","","",{"Informe o grupo inicial a ser considerado"     ,""},{""},{""},"")
PutSx1(	cPerg, "08","Grupo de Produto At้     ? ","","","Mv_ch8",TAMSX3("BM_GRUPO")[3]  ,TAMSX3("BM_GRUPO")[1]  ,TAMSX3("BM_GRUPO")[2]  ,0,"G","","SBM","","N","Mv_par08","","","","","","","","","","","","","","","","","","","","","","",{"Informe o grupo final a ser considerado"       ,""},{""},{""},"")
PutSx1(	cPerg, "09","Armazem de Consumo De    ? ","","","Mv_ch9",TAMSX3("B2_LOCAL")[3]  ,TAMSX3("B2_LOCAL")[1]  ,TAMSX3("B2_LOCAL")[2]  ,0,"G","","SZ1","","N","Mv_par09","","","","","","","","","","","","","","","","","","","","","","",{"Informe o armazem de consumo inicial"          ,""},{""},{""},"")
PutSx1(	cPerg, "10","Armazem de Consumo At้   ? ","","","Mv_cha",TAMSX3("B2_LOCAL")[3]  ,TAMSX3("B2_LOCAL")[1]  ,TAMSX3("B2_LOCAL")[2]  ,0,"G","","SZ1","","N","Mv_par10","","","","","","","","","","","","","","","","","","","","","","",{"Informe o armazem de consumo final"            ,""},{""},{""},"")
PutSx1(	cPerg, "11","Armazem de Estoque De    ? ","","","Mv_chb",TAMSX3("B2_LOCAL")[3]  ,TAMSX3("B2_LOCAL")[1]  ,TAMSX3("B2_LOCAL")[2]  ,0,"G","","SZ1","","N","Mv_par11","","","","","","","","","","","","","","","","","","","","","","",{"Informe o armazem de estoque inicial"          ,""},{""},{""},"")
PutSx1(	cPerg, "12","Armazem de Estoque At้   ? ","","","Mv_chc",TAMSX3("B2_LOCAL")[3]  ,TAMSX3("B2_LOCAL")[1]  ,TAMSX3("B2_LOCAL")[2]  ,0,"G","","SZ1","","N","Mv_par12","","","","","","","","","","","","","","","","","","","","","","",{"Informe o armazem de estoque final"            ,""},{""},{""},"")

RestArea( aAreaSX1 )
RestArea( aAreaAtu )

Return(cPerg) 