#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                                   MUL - T - LOCK                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºPrograma    ³ MFINA002  ³ Ajusta formas de recebimentos SCV X SC5 X SE1                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAutor       ³ Actual Trend                                          ³ Data ³  11/01/10 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function MFINA002()
Processa( {|| A002GERA() }, "Analisando formas recebimento..." )
Return()

Static Function A002GERA()

Local cQuery  := ""
Local nTotReg := 0
Local cAliasA := ""

cQuery := " SELECT SE1.E1_PREFIXO, SE1.E1_NUM, SE1.E1_TIPO, SE1.E1_PARCELA, SE1.E1_XTPPAG, SCV.CV_FORMAPG, SCV.CV_PEDIDO, SCV.CV_XPARCEL, SCV.R_E_C_N_O_ AS RECSCV, SE1.R_E_C_N_O_ AS RECSE1, SC5.*
cQuery += "   FROM "+ RetSQLName( 'SC5' ) +" SC5 "

cQuery += "   LEFT JOIN "+ RetSQLName( 'SE1' ) +" SE1 "
cQuery += "     ON SE1.E1_FILIAL  = '"+ xFilial("SE1") +"'"
cQuery += "    AND SE1.D_E_L_E_T_ = ' '
cQuery += "    AND SE1.E1_PREFIXO = SC5.C5_SERIE
cQuery += "    AND SE1.E1_NUM     = SC5.C5_NOTA
cQuery += "    AND SE1.E1_TIPO    = 'NF'

cQuery += "   LEFT JOIN "+ RetSQLName( 'SCV' ) +" SCV "
cQuery += "     ON SCV.CV_FILIAL  = '"+ xFilial("SCV") +"'"
cQuery += "    AND SCV.CV_PEDIDO  = SC5.C5_NUM
cQuery += "    AND SCV.CV_XPARCEL = SE1.E1_PARCELA
cQuery += "    AND SCV.D_E_L_E_T_ = ' '

cQuery += "  WHERE SC5.C5_FILIAL  = '"+ xFilial("SC5") +"'"
cQuery += "    AND SC5.D_E_L_E_T_ = ' '
cQuery += "  ORDER BY SC5.C5_NUM, SE1.E1_PARCELA

nTotReg := 0
cAliasA	:= GetNextAlias()
cQuery  := ChangeQuery(cQuery)

DbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cAliasA , .F., .T.)
aEval( SE1->(dbStruct()),{|x| If(x[2]!="C", TcSetField(cAliasA,AllTrim(x[1]),x[2],x[3],x[4]),Nil)})

DbSelectArea( cAliasA )
(cAliasA)->(DbGoTop())
(cAliasA)->( dbEval( { || nTotReg++ },,{ || !Eof() } ) )
(cAliasA)->(DbGoTop())

cPedido := ((cAliasA)->CV_PEDIDO + (cAliasA)->CV_XPARCEL)
nConPed := 0

ProcRegua(nTotReg)
While (cAliasA)->(!Eof())
	IncProc("Analisando Pedido :"+(cAliasA)->CV_PEDIDO +", parcela "+ (cAliasA)->CV_XPARCEL)
	
	//************* Ajusta Parcela em branco
	If !Empty((cAliasA)->E1_NUM) .And. Empty((cAliasA)->CV_PEDIDO)
		SCV->(DbSetOrder(2))
		If SCV->(DbSeek(xFilial("SCV") +(cAliasA)->C5_NUM + IIf(Empty((cAliasA)->E1_PARCELA),"1 ",(cAliasA)->E1_PARCELA) ))
			RecLock("SCV",.F.)
			SCV->CV_XPARCEL := (cAliasA)->E1_PARCELA
			If !Empty((cAliasA)->E1_XTPPAG)
				SCV->CV_FORMAPG := (cAliasA)->E1_XTPPAG
			EndiF
			MsUnlock()
			
			If Empty((cAliasA)->E1_XTPPAG)
				SE1->(DbGoTo( (cAliasA)->RECSE1 ))
				RecLock("SE1",.F.)
				SE1->E1_XTPPAG := LEFT(SCV->CV_FORMAPG,3)
				MsUnlock()
			EndIf
		Else
			RecLock("SCV",.T.)
			SCV->CV_FILIAL  := xFilial("SCV")
			SCV->CV_PEDIDO  := (cAliasA)->C5_NUM
			SCV->CV_FORMAPG := IIf(!Empty((cAliasA)->E1_XTPPAG), (cAliasA)->E1_XTPPAG, "BOL")
			SCV->CV_DESCFOR := IIf(!Empty((cAliasA)->E1_XTPPAG), Tabela("24",(cAliasA)->E1_XTPPAG), Tabela("24","BOL") )
			SCV->CV_XPARCEL := (cAliasA)->E1_PARCELA
			MsUnlock()
		EndIf
	EndIf
	
	If !Empty((cAliasA)->CV_PEDIDO)
		//************* Deleta os que nao tem pedido
		If Empty((cAliasA)->C5_NUM)
			SCV->(DbGoTo( (cAliasA)->RECSCV ))
			RecLock("SCV",.F.)
			SCV->(DbDelete())
			MsUnlock()
		EndIf
		
		//************* Iguala forma pagto SCV X SE1
		If !Empty((cAliasA)->E1_NUM) .And. (cAliasA)->E1_XTPPAG <> LEFT((cAliasA)->CV_FORMAPG,3)
			If !Empty((cAliasA)->E1_XTPPAG)
				SCV->(DbGoTo( (cAliasA)->RECSCV ))
				RecLock("SCV",.F.)
				SCV->CV_FORMAPG := (cAliasA)->E1_XTPPAG
				MsUnlock()
			Else
				If !Empty((cAliasA)->CV_FORMAPG)
					SE1->(DbGoTo( (cAliasA)->RECSE1 ))
					RecLock("SE1",.F.)
					SE1->E1_XTPPAG := LEFT((cAliasA)->CV_FORMAPG,3)
					MsUnlock()
				EndIf
			EndIf
		EndIf
		
		//************* Exclui duplicidade
		If cPedido == ((cAliasA)->CV_PEDIDO + (cAliasA)->CV_XPARCEL)
			If nConPed > 0
				SCV->(DbGoTo( (cAliasA)->RECSCV ))
				RecLock("SCV",.F.)
				SCV->(DbDelete())
				MsUnlock()
			EndIf
			nConPed++
		Else
			nConPed := 1
			cPedido := (cAliasA)->CV_PEDIDO + (cAliasA)->CV_XPARCEL
		EndIf
		
		If Empty((cAliasA)->CV_FORMAPG)
			SCV->(DbGoTo( (cAliasA)->RECSCV ))
			RecLock("SCV",.F.)
			SCV->CV_FORMAPG := "BOL"
			SCV->CV_DESCFOR := Tabela("24","BOL")
			MsUnlock()

			SE1->(DbGoTo( (cAliasA)->RECSE1 ))
			RecLock("SE1",.F.)
			SE1->E1_XTPPAG := LEFT(SCV->CV_FORMAPG,3)
			MsUnlock()
		EndIf
	EndIf
	
	(cAliasA)->(DbSkip())
End-While
(cAliasA)->(DbCloseArea())

MsgInfo("Rotina de formas de recebimento finalizada...")

Return()