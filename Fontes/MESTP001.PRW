#INCLUDE "protheus.ch"
#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"
#include "TOTVS.CH"
#Define CRLF  CHR(13)+CHR(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MESTP001  ºAutor  ³ Actual Trend       º Data ³  13/02/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina de Manutenção de estoque					          º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function MESTP050()
	local cVldAlt	:= ".T."
	local cVldExc	:= ".T."
	local cAliasd
	
	cAlias	:= "SC5"
	chkFile(cAlias)
	dbSelectArea(cAlias)
	dbSetOrder(1)
	private cCadastro := "Status de Pedido de Venda"

	aRotina := {;
		{ "Pesquisar" 	, "AxPesqui"		, 0, 1},;
		{ "Atualizar"	, "u_MESTPED()"		, 0, 3}}

	dbSelectArea(cAlias)
	mBrowse( 6, 1, 22, 75, cAlias)
	
return

USer Function MESTPED()

IF Alltrim(SC5->C5_XPEDFAT) == "" 
	Pergunte("MPEDFAT",.T.)
	RecLock("SC5",.F.)
		Replace C5_XPEDFAT	with MV_PAR01
	MsUnLock()
Endif

If alltrim(SC5->C5_XPEDENT) == ""
	Pergunte("MPEDFAT",.T.)
	RecLock("SC5",.F.)
		Replace C5_XPEDENT	with MV_PAR01
	MsUnLock()
Endif

TelaSC5()

Return
         
Static Function TelaSC5()

Local oButton1
Local oButton2
Local oButton3
Local oButton4
Local oGet1
Local cGet1 := SC5->C5_XPEDFAT
Local oGet2
Local cGet2 := SC5->C5_XPEDENT
Local oGet3
Local cGet3 := Posicione("SA1",1,xfilial("SA1")+SC5->C5_CLIENTE+SC5->C5_LOJA,"A1_NOME")
Local oGet4
Local cGet4 := SC5->C5_EMISSAO
Local oGet5
Local cGet5 := SC5->C5_NUM
Local oGet6
Local cGet6 := SC5->C5_XSTAFAT 
Local oGet7
Local cGet7 := SC5->C5_XSTAENT
Local oSay1
Local oSay2
Local oSay3
Local oSay4
Local oSay5
Local oSay6
Local oSay7
Static oDlg

  DEFINE MSDIALOG oDlg TITLE "Status do Pedido" FROM 000, 000  TO 500, 900 COLORS 0, 16777215 PIXEL

    @ 015, 114 SAY oSay3 PROMPT "Cliente" SIZE 025, 007 OF oDlg COLORS 0, 16777215 PIXEL
    @ 015, 151 MSGET oGet3 VAR cGet3 SIZE 189, 010 OF oDlg COLORS 0, 16777215 READONLY PIXEL
    @ 015, 350 SAY oSay4 PROMPT "Data" SIZE 025, 007 OF oDlg COLORS 0, 16777215 PIXEL
    @ 015, 379 MSGET oGet4 VAR cGet4 SIZE 060, 010 OF oDlg COLORS 0, 16777215 READONLY PIXEL
    @ 015, 005 SAY oSay5 PROMPT "Pedido Atual" SIZE 045, 007 OF oDlg COLORS 0, 16777215 PIXEL
    @ 015, 044 MSGET oGet5 VAR cGet5 SIZE 060, 010 OF oDlg COLORS 0, 16777215 READONLY PIXEL
    @ 037, 005 SAY oSay1 PROMPT "Pedido Faturamento" SIZE 056, 007 OF oDlg COLORS 0, 16777215 PIXEL
    @ 037, 061 MSGET oGet1 VAR cGet1 SIZE 060, 010 OF oDlg COLORS 0, 16777215 READONLY PIXEL
    @ 037, 230 SAY oSay2 PROMPT "Pedido Entrega" SIZE 043, 007 OF oDlg COLORS 0, 16777215 PIXEL
    @ 037, 274 MSGET oGet2 VAR cGet2 SIZE 060, 010 OF oDlg COLORS 0, 16777215 READONLY PIXEL
    @ 037, 130 SAY oSay6 PROMPT "Status" SIZE 025, 007 OF oDlg COLORS 0, 16777215 PIXEL
    @ 037, 161 MSGET oGet6 VAR cGet6 SIZE 060, 010 OF oDlg COLORS 0, 16777215 PIXEL
    @ 037, 346 SAY oSay7 PROMPT "Status" SIZE 025, 007 OF oDlg COLORS 0, 16777215 PIXEL
    @ 037, 374 MSGET oGet7 VAR cGet7 SIZE 060, 010 OF oDlg COLORS 0, 16777215 PIXEL
    @ 227, 267 BUTTON oButton1 PROMPT "Romaneio" SIZE 037, 012 OF oDlg PIXEL
    @ 227, 312 BUTTON oButton2 PROMPT "O.P." SIZE 037, 012 ACTION GeraOP() OF oDlg PIXEL
    @ 227, 358 BUTTON oButton3 PROMPT "Ok" SIZE 037, 012 ACTION (Save(cGet1,Cget6,cGet2,cGet7),oDlg:End()) OF oDlg PIXEL
    @ 227, 404 BUTTON oButton4 PROMPT "Cancelar" SIZE 037, 012 ACTION oDlg:End() OF oDlg PIXEL
    fMSNewGe1()


  ACTIVATE MSDIALOG oDlg CENTERED

Return

//------------------------------------------------ 
Static Function fMSNewGe1()
//------------------------------------------------ 
Local nX
Local aHeaderEx := {}
Private aColsEx := {}
Local aFieldFill := {}
Local aFields := {"C6_PRODUTO","C6_DESC","C6_QUANT"}
Local aAlterFields := {}
Static oMSNewGe1

  // Get fields from SC6
  aEval(ApBuildHeader("SC6", Nil), {|x| Aadd(aFields, x[2])})
  aAlterFields := aClone(aFields)

  // Define field properties
  DbSelectArea("SX3")
  SX3->(DbSetOrder(2))
  For nX := 1 to Len(aFields)
    If SX3->(DbSeek(aFields[nX]))
      Aadd(aHeaderEx, {AllTrim(X3Titulo()),SX3->X3_CAMPO,SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL,SX3->X3_VALID,;
                       SX3->X3_USADO,SX3->X3_TIPO,SX3->X3_F3,SX3->X3_CONTEXT,SX3->X3_CBOX,SX3->X3_RELACAO})
    Endif
  Next nX

  // Define field values
  For nX := 1 to Len(aFields)
    If DbSeek(aFields[nX])
      Aadd(aFieldFill, CriaVar(SX3->X3_CAMPO))
    Endif
  Next nX
  Aadd(aFieldFill, .F.)
  Aadd(aColsEx, aFieldFill)

  oMSNewGe1 := MsNewGetDados():New( 050, 001, 217, 446, GD_INSERT+GD_DELETE+GD_UPDATE, "AllwaysTrue", "AllwaysTrue", "+Field1+Field2", aAlterFields,, 999, "AllwaysTrue", "", "AllwaysTrue", oDlg, aHeaderEx, aColsEx)


Return

Static Function Save(cPedFat,cStaFat,cPedEnt,cStaEnt)

	DbSelectArea("SC5")
	_area := GetArea()
	DbSetOrder(1)
	DbSeek(xFilial("SC5")+cPedFat)
	RecLock("SC5",.F.)
		Replace C5_XSTAFAT  with cStaFat
		Replace C5_XSTAENT  with cStaEnt
	MsUnLock()
	
	DbSeek(xFilial("SC5")+cPedEnt)
	RecLock("SC5",.F.)
		Replace C5_XSTAFAT  with cStaFat
		Replace C5_XSTAENT  with cStaEnt
	MsUnLock()
	
	RestArea(_area)

Return

Static Function GeraOP()

For _i := 1 to len(aColsEX)

	DbSelectArea("SB1")
	DbSetOrder(1)
	DbSeek(xfilial("SB1")+aColsEX[_i,1])
	
	cNumOp := GetSxENum("SC2","C2_NUM",1)
	
	aMata650:= {{'C2_FILIAL'	,xfilial("SC2")			,NIL},;
				{'C2_NUM'		,cNumOp					,NIL},;
				{'C2_ITEM'     	,"01" 					,NIL},;
				{'C2_SEQUEN'   	,"001"					,NIL},;
				{'C2_PRODUTO'  	,aColsEX[_i,1]			,NIL},;
				{'C2_LOCAL'    	,SB1->B1_LOCPAD			,NIL},;
				{'C2_QUANT'    	,aColsEX[_i,3]			,NIL},;
				{'C2_UM'       	,SB1->B1_UM  			,NIL},;
				{'C2_DATPRI'   	,ddatabase				,NIL},;
				{'C2_DATPRF'   	,ddatabase				,NIL},;
				{'C2_TPOP'     	,"F" 					,NIL},;
				{'C2_EMISSAO'  	,ddatabase				,NIL},;
				{'AUTEXPLODE'  	,'S'					,NIL},;
				{'INDEX'  		,1						,NIL}}

				lMsErroAuto := .f.
				msExecAuto({|x,Y| Mata650(x,Y)},aMata650,3)
			
				If lMsErroAuto
					Mostraerro() 
				Else
					ConfirmSX8()
				Endif
Next

Return