#Include "Protheus.ch"
#Include "Topconn.ch"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                              M U L T  -  T  -  L O C K                                บฑฑ
ฑฑฬออออออออออออัอออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบPrograma    ณ MFINR005  ณ Fluxo de caixa  X Naturezas financeira   (Impressao Grafica) บฑฑ
ฑฑฬออออออออออออุอออออออออออฯอออออออออออออออออออออออออออออออออออออออออออัออออออัอออออออออออนฑฑ
ฑฑบAutor       ณ Actual Trend - Cintia Aquino                          ณ Data ณ  15/09/10 บฑฑ
ฑฑบ            ณ                Desenvolvimento Inicial                ณ      ณ           บฑฑ
ฑฑศออออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออฯอออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

User Function MFINR005()

Local oDlg
Local oMark
Local oCheckBo1, oCheckBo2, oCheckBo3, oCheckBo4
Local cString    := "SE5"
Local wnrel      := "MFINR005"
Local Titulo     := "Fluxo de Caixa"
Local cQuery     := ""
Local nOpca      := 0
Local cMarArea   := GetMark()
Local lInverte   := .F.

Private lCheckBo1:= .T.
Private lCheckBo2:= .F.
Private lCheckBo3:= .T.
Private lCheckBo4:= .F.
Private nSaldoBco:= 0
Private dDataIni := Ctod("")
Private dDataFim := Ctod("")

// ************************ Seleciona registros do cadastro de bancos
cQuery := " SELECT '  ' AS TMP_OK, SA6.A6_COD, SA6.A6_AGENCIA, SA6.A6_NUMCON, SA6.A6_NOME, SA6.A6_NREDUZ"
cQuery += "   FROM "+ RetSQLName( 'SA6' ) +" AS SA6"
cQuery += "  WHERE SA6.A6_FILIAL   = '"+ xFilial("SA6") +"'"
cQuery += "    AND SA6.A6_FLUXCAI = 'S'"
cQuery += "    AND SA6.A6_BLOCKED <>'1'"
cQuery += "    AND SA6.D_E_L_E_T_  = ' ' "
cQuery += "  ORDER BY "+ StrTran( SqlOrder(SA6->(IndexKey())), "A6_FILIAL,", "")

cAliasA	:= GetNextAlias()
cQuery  := ChangeQuery(cQuery)

DbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cAliasA , .F., .T.)
aEval( SA6->(dbStruct()),{|x| If(x[2]!="C", TcSetField(cAliasA,AllTrim(x[1]),x[2],x[3],x[4]),Nil)})

// ************************ Monta arquivo temporario para Browse de bancos
_aStruct := (cAliasA)->(DbStruct())
cArqTMP  := CriaTrab( _aStruct )
DbUseArea( .T.,__LocalDriver, cArqTMP, "TMP", .T. , .F. )
IndRegua("TMP" , cArqTMP,  StrTran( SA6->(IndexKey(1)), "A6_FILIAL+", "")  ,,,"Criando Indice..." )

DbSelectArea("TMP")
Append From &cAliasA
( cAliasA )->( DbCloseArea())

DbSelectArea( "TMP" )
TMP->( DbGoTop() )

// ************************ Cria array de Campos do Browse da Producao
_aCampos := {}
For _n1 := 1 to Len(_aStruct)
	_cCampo := _aStruct[_n1,1]
	
	If AllTrim(_aStruct[_n1,1]) == "TMP_OK"
		aAdd(_aCampos  ,{"TMP_OK",,"", "@BMP"})
	Else
		aAdd(_aCampos  ,{_aStruct[_n1,1],, AllTrim(RetTitle(_cCampo)), PesqPict( "SA6", _cCampo )  })
	EndIf
Next _n1

// ************************ Monta Interface para selecionar os bancos do fluxo
Define MsDialog oDlg Title " Sele็ใo de Bancos - Fluxo de Caixa " From 000,000 TO 400,908 Pixel

@ 015, 003 GROUP oGroup1 TO 080, 053 PROMPT "Perํodo" OF oDlg COLOR 0, 16777215 PIXEL
@ 025, 010 SAY   oSay1 PROMPT "Data Inicial" SIZE 060, 007 OF oDlg COLORS 0, 16777215 PIXEL
@ 035, 010 MSGET oGet1 VAR dDataIni          SIZE 040, 008 OF oDlg COLORS 0, 16777215 PIXEL

@ 050, 010 SAY   oSay1 PROMPT "Data Final"   SIZE 060, 007 OF oDlg COLORS 0, 16777215 PIXEL
@ 060, 010 MSGET oGet1 VAR dDataFim          SIZE 040, 008 OF oDlg COLORS 0, 16777215 PIXEL

@ 083, 003 GROUP oGroup1 TO 140, 053 PROMPT "Formato" OF oDlg COLOR 0, 16777215 PIXEL
@ 100, 010 CHECKBOX oCheckBo1 VAR lCheckBo1 PROMPT "&Excel"     ON CLICK(lCheckBo2 := .F., lCheckBo2 := IIf(lCheckBo1 == .F., .T., .F.), oCheckBo1:Refresh(), oCheckBo2:Refresh() ) SIZE 048, 008 OF oDlg COLORS 0, 16777215 PIXEL
@ 120, 010 CHECKBOX oCheckBo2 VAR lCheckBo2 PROMPT "&Relat๓rio" ON CLICK(lCheckBo1 := .F., lCheckBo1 := IIf(lCheckBo2 == .F., .T., .F.), oCheckBo1:Refresh(), oCheckBo2:Refresh() ) SIZE 048, 008 OF oDlg COLORS 0, 16777215 PIXEL

@ 145, 003 GROUP oGroup1 TO 200, 053 PROMPT "Layout" OF oDlg COLOR 0, 16777215 PIXEL
@ 160, 010 CHECKBOX oCheckBo3 VAR lCheckBo3 PROMPT "&Sint้tico" ON CLICK(lCheckBo4 := .F., lCheckBo4 := IIf(lCheckBo3 == .F., .T., .F.), oCheckBo3:Refresh(), oCheckBo4:Refresh() ) SIZE 048, 008 OF oDlg COLORS 0, 16777215 PIXEL
@ 180, 010 CHECKBOX oCheckBo4 VAR lCheckBo4 PROMPT "&Analitico" ON CLICK(lCheckBo3 := .F., lCheckBo3 := IIf(lCheckBo4 == .F., .T., .F.), oCheckBo3:Refresh(), oCheckBo4:Refresh() ) SIZE 048, 008 OF oDlg COLORS 0, 16777215 PIXEL

oMark 						:= MsSelect():New(	"TMP", "TMP_OK" , "" , _aCampos , @lInverte, @cMarArea ,{ 15,58,200,450 },,, oDlg)
oMark:bAval               	:= {|| ( R005MARK(1,cMarArea,oMark,"TMP","TMP_OK") , oMark:oBrowse:Refresh() ) }
oMark:oBrowse:lhasMark    	:= .T.
oMark:oBrowse:lCanAllmark 	:= .F.
oMark:oBrowse:bAllMark   	:= {|| ( R005MARK(2,cMarArea,oMark,"TMP","TMP_OK") , oMark:oBrowse:Refresh() ) }

Activate MsDialog oDlg Centered On Init EnchoiceBar(oDlg, { || nOpca := 1, oDlg:End()}, { || nOpca := 0, oDlg:End()})

If nOpca <> 0
	// ************************ Verifica se o banco foi selecionado
	nSaldoBco := 0
	_cBancos  := ""
	
	TMP->(DbGoTop())
	While TMP->(!Eof())
		If TMP->TMP_OK == cMarArea
			_cBancos += TMP->A6_COD+TMP->A6_AGENCIA+TMP->A6_NUMCON+"/"
			
			cQuery := "SELECT * "
			cQuery += "  FROM " + RetSqlName("SE8") + " SE8 "
			cQuery += " WHERE SE8.E8_FILIAL  = '" + xFilial("SE8") + "'"
			cQuery += "   AND SE8.E8_BANCO||SE8.E8_AGENCIA||SE8.E8_CONTA = '"+ TMP->A6_COD+TMP->A6_AGENCIA+TMP->A6_NUMCON +"'"
			cQuery += "   AND SE8.E8_DTSALAT < '" + Dtos(dDataIni) + "'"
			cQuery += "   AND SE8.D_E_L_E_T_ = ' '"
			cQuery += " ORDER BY E8_FILIAL,E8_BANCO,E8_AGENCIA,E8_CONTA,E8_DTSALAT DESC"
			
			cAliasC	:= GetNextAlias()
			cQuery  := ChangeQuery(cQuery)
			
			DbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cAliasC , .F., .T.)
			aEval( SE5->(DbStruct()),{|x| If(x[2]!="C", TcSetField(cAliasC,AllTrim(x[1]),x[2],x[3],x[4]),Nil)})
			
			DbSelectArea( cAliasC )
			(cAliasC)->(DbGoTop())
			If (cAliasC)->(!Eof())
				nSaldoBco += (cAliasC)->E8_SALATUA
			EndIf
			(cAliasC)->(DbCloseArea())
		EndIf
		
		TMP->(DbSkip())
	End-While
	_cBancos := Left(AllTrim(_cBancos),(Len(AllTrim(_cBancos))-1) )
	
	// ************************ Gera processamento dos dados
	If Empty(_cBancos)
		MsgInfo("Nใo existem bancos selecionados, impossํvel continuar", "Aten็ใo")
	Else
		Processa({|lEnd| R005GERA(@lEnd,wnRel,cString, _cBancos)},Titulo)
	EndIf
EndIf

TMP->(DbCloseArea())
Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                              M U L T  -  T  -  L O C K                                บฑฑ
ฑฑฬออออออออออออัอออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบFuncao      ณ R005MARK  ณ Marca e desmarca itens do mbrowse                            บฑฑ
ฑฑฬออออออออออออุอออออออออออฯอออออออออออออออออออออออออออออออออออออออออออัออออออัอออออออออออนฑฑ
ฑฑบAutor       ณ Actual Trend - Cintia Aquino                          ณ Data ณ  15/09/10 บฑฑ
ฑฑบ            ณ                Desenvolvimento Inicial                ณ      ณ           บฑฑ
ฑฑศออออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออฯอออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

Static Function R005MARK(nTipo,cMarArea,oMark,_cAlias,_cCpo)

Local nReg := (_cAlias)->(Recno())

If nTipo == 1
	RecLock(_cAlias, .F.)
	If Empty((_cAlias)->&_cCpo)
		(_cAlias)->&_cCpo := cMarArea
	Else
		(_cAlias)->&_cCpo := ""
	EndIf
	MsUnlock()
Else
	(_cAlias)->(DbGoTop())
	While (_cAlias)->(!Eof())
		RecLock((_cAlias), .F.)
		If Empty((_cAlias)->&_cCpo)
			(_cAlias)->&_cCpo := cMarArea
		Else
			(_cAlias)->&_cCpo := ""
		EndIf
		MsUnlock()
		(_cAlias)->(DbSkip())
	End-While
Endif

(_cAlias)->(DbGoTo(nReg))
oMark:oBrowse:Refresh(.T.)

Return Nil

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                              M U L T  -  T  -  L O C K                                บฑฑ
ฑฑฬออออออออออออัอออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบFuncao      ณ R005GERA  ณ Logica do Fluxo de caixa  X Naturezas financeira             บฑฑ
ฑฑฬออออออออออออุอออออออออออฯอออออออออออออออออออออออออออออออออออออออออออัออออออัอออออออออออนฑฑ
ฑฑบAutor       ณ Actual Trend - Cintia Aquino                          ณ Data ณ  15/09/10 บฑฑ
ฑฑบ            ณ                Desenvolvimento Inicial                ณ      ณ           บฑฑ
ฑฑศออออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออฯอออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

Static Function R005GERA(lEnd,wnRel,cString,_cBancos)

Local cQuery      := ""
Local nLinIni	  := 090
Local nColIni	  := 080
Local nColFim	  := 3240
Local nLinFim	  := 2435
Local nLin        := 0
Local nPagina     := 0
Local cCposDia    := " "
Local cNatPAI     := ""

Private oFont08   := TFont():New("Courier New",-10,-08,,.F.,,,,.T.,.F.)
Private oFont08n  := TFont():New("Courier New",-10,-08,,.T.,,,,.T.,.F.)
Private oFont12n  := TFont():New("Courier New",-10,-12,,.T.,,,,.T.,.F.)

If lCheckBo3 == .T.   //Sintetico
	cQuery += " SELECT SE5.E5_FILIAL, SUBSTRING(PCX.PCX_GRPNAT,1,1) AS TIPOGRP, SE5.E5_RECPAG, PCX.PCX_GRPNAT, PCV.PCV_DESC, SE5.E5_DTDISPO, SUM(SE5.E5_VALOR) AS E5_VALOR"
Else
	cQuery += " SELECT SE5.E5_FILIAL, SUBSTRING(SE5.E5_NATUREZ,1,1) AS TIPOGRP, SE5.E5_RECPAG, PCX.PCX_GRPNAT, SE5.E5_NATUREZ, SED.ED_DESCRIC, PCV.PCV_DESC, SE5.E5_DTDISPO, SUM(SE5.E5_VALOR) AS E5_VALOR"
EndIf
cQuery += "    FROM" + RetSqlName("SE5")+" AS SE5"

cQuery += "   LEFT JOIN " + RetSqlName("PCX")+" AS PCX"
cQuery += "	    ON PCX.PCX_FILIAL = '" + xFilial("PCX") + "'"
cQuery += "    AND PCX.PCX_NATUR  = SE5.E5_NATUREZ"
cQuery += "    AND PCX.D_E_L_E_T_ = ' '"

cQuery += "   LEFT JOIN " + RetSqlName("PCV")+" AS PCV"
cQuery += "	    ON PCV.PCV_FILIAL = '" + xFilial("PCV") + "'"
cQuery += "    AND PCV.PCV_GRUPO  = PCX.PCX_GRPNAT"
cQuery += "    AND PCV.D_E_L_E_T_ = ' ' "

cQuery += "   LEFT JOIN " + RetSqlName("SED")+" AS SED"
cQuery += "	    ON SED.ED_FILIAL   = '" + xFilial("SED") + "'"
cQuery += "    AND SED.ED_CODIGO  = SE5.E5_NATUREZ"
cQuery += "    AND SED.D_E_L_E_T_ = ' '"

cQuery += "	 WHERE SE5.E5_FILIAL   = '" + xFilial("SE5") + "'"
cQuery += "    AND SE5.E5_DTDISPO  BETWEEN '"+ DtoS(dDataIni)   + "' AND '"+ DtoS(dDataFim) + "'"
cQuery += "    AND SE5.E5_BANCO||SE5.E5_AGENCIA||SE5.E5_CONTA IN "+FormatIn(_cBancos,"/")
cQuery += "    AND SE5.E5_TIPODOC  NOT IN ('DC','JR','MT','CM','D2','J2','M2','C2','V2','CP','TL','BA') "
cQuery += "    AND SE5.E5_SITUACA  <> 'C' "
cQuery += "    AND SE5.E5_VALOR    <> 0 "
cQuery += "    AND SE5.E5_NUMCHEQ  NOT LIKE '%*' "
cQuery += "    AND SE5.D_E_L_E_T_ = ' '

If lCheckBo3 == .T.   //Sintetico
	cQuery += "  GROUP BY SE5.E5_FILIAL, SUBSTRING(PCX.PCX_GRPNAT,1,1), SE5.E5_RECPAG, PCX.PCX_GRPNAT, PCV.PCV_DESC, SE5.E5_DTDISPO
	cQuery += "  ORDER BY SE5.E5_FILIAL, SUBSTRING(PCX.PCX_GRPNAT,1,1), SE5.E5_RECPAG DESC, PCX.PCX_GRPNAT, PCV.PCV_DESC, SE5.E5_DTDISPO
Else
	cQuery += "  GROUP BY SE5.E5_FILIAL, SUBSTRING(SE5.E5_NATUREZ,1,1), SE5.E5_RECPAG, PCX.PCX_GRPNAT, SE5.E5_NATUREZ, SED.ED_DESCRIC, PCV.PCV_DESC, SE5.E5_DTDISPO
	cQuery += "  ORDER BY SE5.E5_FILIAL, SUBSTRING(SE5.E5_NATUREZ,1,1), SE5.E5_RECPAG DESC, PCX.PCX_GRPNAT, SE5.E5_NATUREZ, SED.ED_DESCRIC, PCV.PCV_DESC, SE5.E5_DTDISPO
EndIf

nTotReg := 0
cAliasB	:= GetNextAlias()
cQuery  := ChangeQuery(cQuery)

DbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cAliasB , .F., .T.)
aEval( SE5->(DbStruct()),{|x| If(x[2]!="C", TcSetField(cAliasB,AllTrim(x[1]),x[2],x[3],x[4]),Nil)})

DbSelectArea( cAliasB )
(cAliasB)->(DbGoTop())
(cAliasB)->( dbEval( { || nTotReg++ },,{ || !Eof() } ) )
(cAliasB)->(DbGoTop())

If nTotReg == 0
	MsgInfo("Nใo existem dados, verifique parโmetros","Aten็ใo")
Else
	// ************************ Monta Colunas de dias
	nDias := (dDataFim-dDataIni)
	aDias := {}
	For _n1 := 0 to nDias
		Aadd( aDias, StrTran(Dtoc(dDataIni+_n1),"/",""))
	Next _n1
	
	// ************************ Monta estrutura do temporario de impressao
	aStruTEMP := {}
	Aadd( aStruTEMP, {"TIPOGRP"   ,                     "C",                       1,                        0 } )
	Aadd( aStruTEMP, {"RECPAG"   , TAMSX3("E5_RECPAG" )[3], TAMSX3("E5_RECPAG" )[1], TAMSX3("E5_RECPAG" )[2] } )
	Aadd( aStruTEMP, {"GRPNAT"   , TAMSX3("PCX_GRPNAT")[3], TAMSX3("PCX_GRPNAT")[1], TAMSX3("PCX_GRPNAT")[2] } )
	Aadd( aStruTEMP, {"DESCGRP"  , TAMSX3("PCV_DESC"  )[3], TAMSX3("PCV_DESC"  )[1], TAMSX3("PCV_DESC"  )[2] } )
	If lCheckBo4 == .T.   //Analitico
		Aadd( aStruTEMP, {"NATUREZ"  , TAMSX3("ED_CODIGO" )[3], TAMSX3("ED_CODIGO" )[1], TAMSX3("ED_CODIGO" )[2] } )
		Aadd( aStruTEMP, {"DESCRIC"  , TAMSX3("ED_DESCRIC")[3], TAMSX3("ED_DESCRIC")[1], TAMSX3("ED_DESCRIC")[2] } )
	EndIf
	For _n2 := 1 to (nDias+1)
		Aadd( aStruTEMP, {"D_"+aDias[_n2],"N",13,2 } )
	Next _n2
	Aadd( aStruTEMP, {"TOTAL"  , TAMSX3("E5_VALOR"  )[3], TAMSX3("E5_VALOR"  )[1], TAMSX3("E5_VALOR"  )[2] } )
	
	// ************************ Cria temporario
	cArqTEMP  := CriaTrab( aStruTEMP )
	DbUseArea( .T.,__LocalDriver, cArqTEMP, "TRB", .T. , .F. )
	IndRegua("TRB" , cArqTEMP,  "TIPOGRP+RECPAG+GRPNAT"+Iif(lCheckBo4 == .T.,"+NATUREZ","")  ,,,"Criando Indice..." )
	
	// ************************ Armazena Saldos
	RecLock("TRB", .T.)
	TRB->RECPAG    := "A"
	TRB->DESCGRP   := "SALDOS INICIAIS"
	For _n2 := 1 to (nDias+1)
		TRB->&("D_"+aDias[_n2]) := nSaldoBCO
	Next _n2
	MsUnLock()
	
	// ************************ Aglutina registros no temporario
	(cAliasB)->(DbGoTop())
	While (cAliasB)->(!Eof())
		nMult     := 1
		cTipoRec  := (cAliasB)->E5_RECPAG
		
		If (cAliasB)->TIPOGRP == "1"
			cTipoRec := "R"
		ElseIf (cAliasB)->TIPOGRP == "2"
			cTipoRec := "P"
		EndIf
		
		If (cAliasB)->E5_RECPAG == "P"
			nMult := (-1)
		EndIf
		
		If lCheckBo4 == .T.  .And. lCheckBo1 == .F.  //Analitico e Relatorio
			If TRB->(!DbSeek( (cAliasB)->TIPOGRP + cTipoRec + (cAliasB)->PCX_GRPNAT  ))
				RecLock("TRB", .T.)
				TRB->TIPOGRP    := (cAliasB)->TIPOGRP
				TRB->RECPAG    := cTipoRec
				TRB->GRPNAT    := (cAliasB)->PCX_GRPNAT
				TRB->DESCGRP   := (cAliasB)->PCV_DESC
				TRB->TOTAL     := (cAliasB)->E5_VALOR*nMult
				TRB->&("D_"+StrTran(Dtoc((cAliasB)->E5_DTDISPO),"/","")) := (cAliasB)->E5_VALOR*nMult
			Else                                                                                                                                           
				RecLock("TRB", .F.)
				TRB->TOTAL     += (cAliasB)->E5_VALOR*nMult
				TRB->&("D_"+StrTran(Dtoc((cAliasB)->E5_DTDISPO),"/","")) += (cAliasB)->E5_VALOR*nMult
			EndIf
			MsUnLock()
		EndIf
		
		If TRB->(!DbSeek( (cAliasB)->TIPOGRP + cTipoRec + (cAliasB)->PCX_GRPNAT + Iif(lCheckBo4 == .T.,(cAliasB)->E5_NATUREZ,"") ))
			RecLock("TRB", .T.)
			TRB->TIPOGRP    := (cAliasB)->TIPOGRP
			TRB->RECPAG    := cTipoRec
			TRB->GRPNAT    := (cAliasB)->PCX_GRPNAT
			TRB->DESCGRP   := (cAliasB)->PCV_DESC
			If lCheckBo4 == .T.   //Analitico
				TRB->NATUREZ   := (cAliasB)->E5_NATUREZ
				TRB->DESCRIC   := (cAliasB)->ED_DESCRIC
			EndIf
			TRB->TOTAL     := (cAliasB)->E5_VALOR*nMult
			TRB->&("D_"+StrTran(Dtoc((cAliasB)->E5_DTDISPO),"/","")) := (cAliasB)->E5_VALOR*nMult
		Else
			RecLock("TRB", .F.)
			TRB->TOTAL     += (cAliasB)->E5_VALOR*nMult
			TRB->&("D_"+StrTran(Dtoc((cAliasB)->E5_DTDISPO),"/","")) += (cAliasB)->E5_VALOR*nMult
		EndIf
		MsUnLock()
		
		// ************************ Armazena Saldos
		If TRB->(DbSeek( "A"))
			RecLock("TRB", .F.)
			For _n2 := 1 to (nDias+1)
				If  CtoD(SubStr(aDias[_n2],1,2)+"/"+SubStr(aDias[_n2],3,2)+"/"+SubStr(aDias[_n2],5,2)) > (cAliasB)->E5_DTDISPO
					If CtoD(SubStr(aDias[_n2],1,2)+"/"+SubStr(aDias[_n2],3,2)+"/"+SubStr(aDias[_n2],5,2)) > dDataIni
						TRB->&("D_"+aDias[_n2]) += (cAliasB)->E5_VALOR *nMult//*IIf((cAliasB)->E5_RECPAG == "R", 1, -1)
					EndIf
				EndIf
			Next _n2
			
			MsUnLock()
		EndIf
		
		(cAliasB)->(DbSkip())
	End-While
	
	TRB->(DbGoTop())
	If lCheckBo1 == .T.   //Excel
		TRB->(DbCloseArea())
		
		cExcel :=  AllTrim(GetTempPath())+"FLUXO_"+StrTran(Dtoc(dDatabase),"/","")+"_"+StrTran(Left(Time(),5),":","")+".XLS"
		fErase(cExcel)
		
		__CopyFile(cArqTEMP+".DBF",cExcel)
		oExcelApp:= MsExcel():New()
		oExcelApp:WorkBooks:Open(cExcel)
		oExcelApp:SetVisible(.T.)
		
		fErase(cArqTEMP)
		
	Else   // Relatorio
		oPrint:= TMSPrinter():New( "Fluxo de Caixa")
		oPrint:Setup()
		oPrint:Rebuild()
		oPrint:SetLandscape()					// Modo paisagem
		oPrint:SetPaperSize(9)					// Papel A4
		
		nVezes := MlCount(Space(nDias+1),7)
		nCol   := 0
		nCabec := IIf(lCheckBo3 == .T.,4,6)
		
		For _n4 := 1 to nVezes
			If _n4 > 1
				nCol  := (_n4-1)*9
				nCabec:= ((_n4-1)*9)+IIf(lCheckBo3 == .T.,4,6)
				nLin  := 0
			EndIf
			
			cCabec:= "NATUREZA      | DESCRIวรO                      | "
			For _n3 := nCabec To Len(aStruTEMP)
				If _n3 <= nCabec+8  .And. _n3 <= Len(aStruTEMP)
					If ValType(TRB->&(aStruTEMP[_n3,1])) == "N" .And. !(AllTrim(aStruTEMP[_n3,1]) $ "TOTAL")
						cCabec += PadC(SubStr(Strtran(aStruTEMP[_n3,1],"D_",""),1,2)+"/"+SubStr(Strtran(aStruTEMP[_n3,1],"D_",""),3,2)+"/"+SubStr(Strtran(aStruTEMP[_n3,1],"D_",""),5,2), 13)+"| "
					EndIf
				EndIf
			Next
			
			If _n4 == nVezes
				cCabec += "        TOTAL|"
			EndIf
			
			TRB->(DbGoTop())
			While TRB->(!Eof())
				If nLin == 0 .Or.  nLin >= 2400
					nPagina++
					If nPagina > 1
						oPrint:EndPage()
					EndIf
					nLin := R005CABEC(nLin, nPagina, nLinIni, nColIni, nLinFim, nColFim )
				EndIf
				                               
				cCpoPrint := ""
				lPai      := .F.
				nVal      := 0
				
				For _n3 := 1 To Len(aStruTEMP)
					If nVal <= 8 .And. (_n3+nCol) <= Len(aStruTEMP)
						If !(AllTrim(aStruTEMP[_n3,1]) $ IIf(lCheckBo3 == .T.,"TIPOGRP.RECPAG.DESCGRP", "TIPOGRP.RECPAG.GRPNAT.DESCGRP"))
							If ValType(TRB->&(aStruTEMP[_n3,1])) == "N"
								cCpoPrint += Transform(TRB->&(aStruTEMP[_n3+nCol,1]), "@E 99,999,999.99")+"| "
								nVal++
							Else
								If (AllTrim(aStruTEMP[_n3,1]) $ IIf(lCheckBo3 == .T.,"GRPNAT","NATUREZ"))
									If lCheckBo3 == .T.
										cCpoPrint +=  TRB->GRPNAT+"        | "+SubStr(TRB->DESCGRP,1,30)+" | "
									Else
										If (Empty(TRB->NATUREZ) .And. !Empty(TRB->DESCGRP))
											cCpoPrint +=  TRB->GRPNAT+"        | "+SubStr(TRB->DESCGRP,1,30)+" | "
											lPai := .T.
										Else
											If lPai == .F.
												cCpoPrint += "   "+PadR(TRB->&(aStruTEMP[_n3,1]), aStruTEMP[_n3,3])+" | "
											EndIf
										EndIf
									EndIf
								Else
									If lPai == .F.
										cCpoPrint += PadR(TRB->&(aStruTEMP[_n3,1]), aStruTEMP[_n3,3])+" | "
									EndIf
								EndIf
							EndIf
						EndIf
					EndIf
				Next
				oPrint:Say(nLin,100, cCpoPrint, oFont08)
				nLin += 40
				
				TRB->(DbSkip())
			End-While
		Next
		TRB->(DbCloseArea())
		fErase(cArqTEMP)
		
		oPrint:EndPage()
		//oPrint:Print()
		oPrint:Preview()
	EndIf
EndIf
(cAliasB)->(DbCloseArea())

Return()

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                              M U L T  -  T  -  L O C K                                บฑฑ
ฑฑฬออออออออออออัอออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบFuncao      ณ R005CABEC ณ Cabecalho do Fluxo de caixa  X Naturezas financeira          บฑฑ
ฑฑฬออออออออออออุอออออออออออฯอออออออออออออออออออออออออออออออออออออออออออัออออออัอออออออออออนฑฑ
ฑฑบAutor       ณ Actual Trend - Cintia Aquino                          ณ Data ณ  15/09/10 บฑฑ
ฑฑบ            ณ                Desenvolvimento Inicial                ณ      ณ           บฑฑ
ฑฑศออออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออฯอออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

Static Function R005CABEC(nLin, nPagina, nLinIni, nColIni, nLinFim, nColFim )

oPrint:StartPage()
oPrint:Box(nLinIni,nColIni,nLinFim,nColFim)                                                

If nPagina == 1
	oPrint:Box(nLinIni,nColIni,nLinIni+220,nColFim)
	oPrint:SayBitmap(nLinIni+20, nColIni+20, "\SYSTEM\Lgrl"+cEmpAnt+".BMP",nColIni+400, nLinIni+100)
	oPrint:Say(180,1450, "F L U X O   D E   C A I X A ", oFont12n)
	oPrint:Say(200,2900, "DATA  : "+Dtoc(dDataBase)    , oFont08)
	oPrint:Say(250,2900, "HORA  : "+Time()             , oFont08)
	nLin := 330
Else
	nLin := 100                
EndIf                                                         
                                                                         
oPrint:Say(nLin,100, cCabec, oFont08)
nLin += 60
                                                                             
Return(nLin)