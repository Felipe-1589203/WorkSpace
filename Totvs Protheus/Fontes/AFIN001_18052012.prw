#INCLUDE "TOPCONN.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAFIN001   บAutor  ณBruno Parreira      บ Data ณ  25/04/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณPrograma para tranferencia de titulos em bodero para outras บฑฑ
ฑฑบ          ณcontas.                                                     บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Especifico MULTLOCK                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function AFIN001()

	Private cPerg	:= "AFIN001"

	AjustaSX1(cPerg)

	lPerg := Pergunte(cPerg)

	If lPerg == .T.
		MontaTela(mv_par01)
	EndIf

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณMontaTela บ Autor ณ Bruno Parreira     บ Data ณ  25/04/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Monta tela de visualizacao do titulos do bordero.          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Especifico MULTLOCK 								          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

Static Function MontaTela(cBordero)

Local cQuery := ""                                                                  
Private oFont1    := TFont():New("Times New Roman",,020,,.T.,,,,,.F.,.F.)
Private oFont2    := TFont():New("Times New Roman",,025,,.T.,,,,,.F.,.F.)        
Private oMSNewGe1 

cQuery :=        "  SELECT E1_PREFIXO, E1_NUM, E1_PARCELA, E1_TIPO, E1_PORTADO, E1_AGEDEP, E1_CONTA, E1_CLIENTE, E1_LOJA, E1_NOMCLI, E1_VALOR "
cQuery += CRLF + "    FROM "+RetSqlName("SE1")+" SE1 "
cQuery += CRLF + "     WHERE E1_FILIAL      = '"+xFilial("SE1")+"' "
cQuery += CRLF + "      AND E1_NUMBOR       = '"+cBordero+"' "
cQuery += CRLF + "      AND E1_SALDO        <> 0 "
cQuery += CRLF + "      AND SE1.D_E_L_E_T_  = ' ' "  
cQuery += CRLF + "     ORDER BY E1_FILIAL, E1_PREFIXO, E1_NUM, E1_PARCELA "

MemoWrite("AFIN001.txt",cQuery)

cAliasA := GetNextAlias()
cQuery  := ChangeQuery(cQuery)

DbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cAliasA , .F., .T.)
aEval( SE1->(DbStruct()),{|x| If(x[2] != "C", TcSetField(cAliasA, AllTrim(x[1]), x[2], x[3], x[4]),Nil)})
                     
aColAux := {}
aColOri := {}    
    
DbSelectarea(cAliasA)
DbGoTop()
if (cAliasA)->(!EOF())  
	While (cAliasA)->(!EOF())     		
		aAdd(aColAux,{(cAliasA)->E1_PREFIXO,(cAliasA)->E1_NUM,(cAliasA)->E1_PARCELA,(cAliasA)->E1_TIPO,(cAliasA)->E1_PORTADO,;
					   (cAliasA)->E1_AGEDEP,(cAliasA)->E1_CONTA,(cAliasA)->E1_CLIENTE,(cAliasA)->E1_LOJA,(cAliasA)->E1_NOMCLI,(cAliasA)->E1_VALOR,.F.})
		DbSkip()
	EndDo   
else                                                      
	MsgAlert("Numero de bordero nao existe ou jแ estแ baixado.")
	Return .F.	                                   
EndIf                                     

aColOri := aClone(aColAux)

DEFINE MSDIALOG oDlg TITLE "Transferencia de Contas do Bordero" FROM 000, 000  TO 280, 1000 COLORS 0,16777215 PIXEL

@ 012, 020 SAY oObra  PROMPT "Tํtulos do bordero: " + cBordero SIZE 150, 012 OF oDlg FONT oFont1 COLORS 0,16777215 PIXEL
@ 012, 280 SAY oTrans PROMPT "Transferir para portador "+AllTrim(mv_par02)+" Ag. "+AllTrim(mv_par03)+" Conta "+AllTrim(mv_par04) SIZE 250, 012 OF oDlg FONT oFont1 COLORS 0,16777215 PIXEL 
@ 105, 370 BUTTON oButton2  PROMPT "Transferir"  SIZE 050, 020 OF oDlg ACTION TransfBord(cBordero) PIXEL  MESSAGE "Tranferir Bordero"
@ 105, 430 BUTTON oButton1  PROMPT "Cancelar"    SIZE 050, 020 OF oDlg ACTION F_FECHA() PIXEL MESSAGE "Cancelar"

GeraGrade()

oMSNewGe1:aCols=aColAux

ACTIVATE MSDIALOG oDlg CENTERED   

DbCloseArea(cAliasA)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณGeraGrade   บ Autor ณ Bruno Parreira     บ Data ณ  25/04/12   บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Monta estrutura da grade.                                    บฑฑ
ฑฑบ          ณ                                                              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                           บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/                                                                     

Static Function GeraGrade()
	Local nX
	Local aHeaderEx := {}
	Local aColsEx := {}
	Local aFieldFill := {}
	Local aFields := {"E1_PREFIXO","E1_NUM","E1_PARCELA","E1_TIPO","E1_PORTADO","E1_AGEDEP","E1_CONTA","E1_CLIENTE","E1_LOJA","E1_NOMCLI","E1_VALOR"}
	Local aAlterFields := {}

// Define campos
	DbSelectArea("SX3")
	SX3->(DbSetOrder(2))
	For nX := 1 to Len(aFields)
		If SX3->(DbSeek(aFields[nX]))
			Aadd(aHeaderEx, {AllTrim(X3Titulo()),SX3->X3_CAMPO,SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL,"",;
				SX3->X3_USADO,SX3->X3_TIPO,SX3->X3_F3,SX3->X3_CONTEXT,SX3->X3_CBOX,SX3->X3_RELACAO})
		EndIf
	Next nX

// Define valor ao campo
	For nX := 1 to Len(aFields)
		If DbSeek(aFields[nX])
			aAdd(aFieldFill, CriaVar(SX3->X3_CAMPO))
		EndIf
	Next nX
	Aadd(aFieldFill, .F.)
	Aadd(aColsEx, aFieldFill)

	oMSNewGe1 := MsNewGetDados():New(030,020,100,480,GD_UPDATE,.T.,"cTudoOk",,aAlterFields,,999,"",,,oDlg,aHeaderEx,aColsEx)

Return

//ษอออออออออออออออออป
//บ Botao Cancelar  บ
//ศอออออออออออออออออผ                                                                     

Static Function F_FECHA()

	If MsgBox("Deseja realmente abandonar a transferencia de conta dos tํtulos em bordero ?","Transferencia de contas","YESNO")
		DbCloseArea(cAliasA)
		oDlg:End()
	EndIf

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณTransfBord  บ Autor ณ Bruno Parreira     บ Data ณ  25/04/12   บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Transfere a conta do bodero selecionado.                     บฑฑ
ฑฑบ          ณ                                                              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                           บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿          
*/                                                                                       

Static Function TransfBord(cBordero)

	Local cPortador	:= mv_par02
	Local cAgencia	:= mv_par03
	Local cConta	:= mv_par04
	Local lRet 		:= .T.

	DbSelectArea("SE1")
	DbSetOrder(5)
	If DbSeek(xFilial("SE1")+cBordero)
		If MsgBox("Deseja realmente efetuar a transferencia de conta dos tํtulos deste bordero ?","Transferencia de contas","YESNO")
			While !EOF() .And. SE1->E1_NUMBOR == cBordero
				RecLock("SE1",.F.)
				SE1->E1_PORTADO	:= cPortador
				SE1->E1_AGEDEP	:= cAgencia
				SE1->E1_CONTA  	:= cConta
				DbSkip()
			EndDo
			lRet := .T.
		else
			MsgInfo("Nenhum campo foi alterado.")
			lRet := .F.
		EndIf
	EndIf

	If lRet
		MsgInfo("Altera็ใo de contas efetuada com sucesso.")
	EndIf

	DbCloseArea("SE1")
	oDlg:End()

Return .F.


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณAjustaSX1 บ Autor ณ Bruno Parreira     บ Data ณ  25/04/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Cria parametros da rotina                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Especifico MULTLOCK 								          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

Static Function AjustaSX1(cPerg)

Local aAreaAtu	:= GetArea()
Local aAreaSX1	:= SX1->( GetArea() )
                                                                                                                                                                  //F3
PutSx1(	cPerg, "01", "Numero do bordero      ? ", "" , "", "Mv_ch1", TAMSX3( "E1_NUMBOR"  )[3], TAMSX3( "E1_NUMBOR"  )[1], TAMSX3( "E1_NUMBOR"  )[2], 0,"G","",   "","","N","Mv_par01","","","","","","","","","","","","","","","","",{"Digite o numero do bodero.      ",                                ""},{""},{""},"")
PutSx1(	cPerg, "02", "Portador Transf.       ? ", "" , "", "Mv_ch2", TAMSX3( "E1_PORTADO" )[3], TAMSX3( "E1_PORTADO" )[1], TAMSX3( "E1_PORTADO" )[2], 0,"G","","SA6","","N","Mv_par02","","","","","","","","","","","","","","","","",{"Digite o portador a qual deseja ","transferir os titulos do bodero."},{""},{""},"")
PutSx1(	cPerg, "03", "Agencia Transf.        ? ", "" , "", "Mv_ch3", TAMSX3( "E1_AGEDEP"  )[3], TAMSX3( "E1_AGEDEP"  )[1], TAMSX3( "E1_AGEDEP"  )[2], 0,"G","",   "","","N","Mv_par03","","","","","","","","","","","","","","","","",{"Digite a agencia a qual deseja  ","transferir os titulos do bodero."},{""},{""},"")
PutSx1(	cPerg, "04", "Conta Transf.          ? ", "" , "", "Mv_ch4", TAMSX3( "E1_CONTA"   )[3], TAMSX3( "E1_CONTA"   )[1], TAMSX3( "E1_CONTA"   )[2], 0,"G","",   "","","N","Mv_par04","","","","","","","","","","","","","","","","",{"Digite a conta a qual deseja    ","transferir os titulos do bodero."},{""},{""},"")

RestArea( aAreaSX1 )
RestArea( aAreaAtu )

Return(cPerg)
