#include "RWMAKE.CH"
#include "Protheus.Ch"
#include "TopConn.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ FGMENU1  บ Autor ณ Douglas V. Franca  บ Data ณ  07/10/05   บฑฑ             
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Gerenciar os arquivos de menu(xnu) dos usuarios.           บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Generico.                                                  บฑฑ            
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function FGMENU1(n_Opc)

	Local x_Ret                                    

	If !(alltrim(cusername) == 'csantos' .or. alltrim(cusername) == 'amartins'.or. alltrim(cusername) == 'caquino')
		msgAlert("Acesso restrito!!!", "A T E N ว ร O")
		Return
	EndIf

	If n_Opc <> Nil
		If n_Opc == 1
			x_Ret := fAltItem()
		ElseIf n_Opc == 2
			fReplCfg()
		ElseIf n_Opc == 3
			fCopyCfg()
		ElseIf n_Opc == 4
			fSelUser()
		ElseIf n_Opc == 5
			fGerXnuLt()
		ElseIf n_Opc == 6
			U_FGMENU3(.F., ZZS->ZZS_USER)
		Endif
		Return x_Ret
	Endif

	//Parametro MV_XTPMENU onde 0=Por Usuแrio ou 1=Por Grupo (Default)
	Private l_GrpMenu	:= (GetMV("MV_XTPMENU", ,"1") == "1")

	Private cCadastro 	:= "Manuten็ใo dos itens dos menus dos "+IIF(l_GrpMenu, "grupos","usuแrios")
	Private aRotina 	:= {}

	aAdd(aRotina, {"Pesquisar" 		, 'AxPesqui'  		,0,1})
	aAdd(aRotina, {"Visualizar"		, 'AxVisual' 		,0,2})
	aAdd(aRotina, {"Alterar"		, 'U_FGMENU1(1)'	,0,4})
	aAdd(aRotina, {"Manut. Config."	, 'U_FGMENU1(2)'	,0,4})
	aAdd(aRotina, {"Copia Config."	, 'U_FGMENU1(3)'	,0,4})
	aAdd(aRotina, {"Gerar XNU"		, 'U_FGMENU1(4)'	,0,4})
	aAdd(aRotina, {"Gerar em Lote"	, 'U_FGMENU1(5)'	,0,4})
	aAdd(aRotina, {"Vis. มrvore"	, 'U_FGMENU1(6)'	,0,4})

	MBrowse( ,,,,"ZZS")

Return Nil
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณ Descricao                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบfAltItem  ณ Alterar o registro posicionado da tabela ZZS.              บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function fAltItem()
	Local n_Ret := AxAltera("ZZS", ZZS->(Recno()), 4)
	
	If  n_Ret == 1
		
		CursorWait()
		
		U_fAtuAces("ZZS")

		c_UpdQry := "UPDATE "+RetSqlName("ZZS")+" "
		c_UpdQry += "SET ZZS_LACE01	= '"+IIF(ZZS->ZZS_LACE01, "T", "F")+"' "
		c_UpdQry += "	,ZZS_LACE02	= '"+IIF(ZZS->ZZS_LACE02, "T", "F")+"' "
		c_UpdQry += "	,ZZS_LACE03	= '"+IIF(ZZS->ZZS_LACE03, "T", "F")+"' "
		c_UpdQry += "	,ZZS_LACE04	= '"+IIF(ZZS->ZZS_LACE04, "T", "F")+"' "
		c_UpdQry += "	,ZZS_LACE05	= '"+IIF(ZZS->ZZS_LACE05, "T", "F")+"' "
		c_UpdQry += "	,ZZS_LACE06	= '"+IIF(ZZS->ZZS_LACE06, "T", "F")+"' "
		c_UpdQry += "	,ZZS_LACE07	= '"+IIF(ZZS->ZZS_LACE07, "T", "F")+"' "
		c_UpdQry += "	,ZZS_LACE08	= '"+IIF(ZZS->ZZS_LACE08, "T", "F")+"' "
		c_UpdQry += "	,ZZS_LACE09	= '"+IIF(ZZS->ZZS_LACE09, "T", "F")+"' "
		c_UpdQry += "	,ZZS_LACE10	= '"+IIF(ZZS->ZZS_LACE10, "T", "F")+"' "
		c_UpdQry += "	,ZZS_ACESSO	= '"+ZZS->ZZS_ACESSO+"' "
		c_UpdQry += "	,ZZS_STATUS	= '"+ZZS->ZZS_STATUS+"' "		
		c_UpdQry += "WHERE ZZS_FILIAL = '"+ZZS->ZZS_FILIAL+"' "
		c_UpdQry += "AND ZZS_FUNCAO = '"+ZZS->ZZS_FUNCAO+"' "
		c_UpdQry += "AND ZZS_USER = '"+ZZS->ZZS_USER+"' "
		c_UpdQry += "AND R_E_C_N_O_ NOT IN ("+AllTrim(Str(ZZS->(Recno())))+") "
		c_UpdQry += "AND D_E_L_E_T_ = ' ' "

		TcSqlExec(c_UpdQry)

		CursorArrow()
		
	Endif

Return(n_Ret)
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณ Descricao                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบfReplCfg  ณ Replicar as configuracoes do item posicionado.             บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function fReplCfg()

	Local oDlg
	Local c_Title 	:= OemToAnsi("Replica็ใo de configura็๕es dos Menus.")
	Local n_Opca 	:= 0
	Local a_CA		:= { OemToAnsi("Confirma"), OemToAnsi("Abandona"), OemToAnsi("Parโmetros")}
	Local a_Says	:={}
	Local a_Buttons	:={}
	Local c_Perg 	:= IIF(l_Grpmenu, "MYXNU50000", "MYXNU20000")

	ValidPerg(c_Perg)

	If !Pergunte(c_Perg, .T.)
		Return Nil
	Endif

	c_Texto	:= "Este programa tem como objetivo replicar as configura็๕es"
	aAdd(a_Says, OemToAnsi(c_Texto))
	c_Texto	:= "de acesso [x--- xx xx] e Status [H/I/D] para os registros"
	aAdd(a_Says, OemToAnsi(c_Texto))
	c_Texto	:= "conforme os parametros selecionados."
	aAdd(a_Says, OemToAnsi(c_Texto))
	c_Texto	:= "Aten็ใo.: Para nใo atualizar uma determinada posi็ใo do "
	aAdd(a_Says, OemToAnsi(c_Texto))
	c_Texto	:= "acesso, basta utilizar o caracter MENOS (-).            "
	aAdd(a_Says, OemToAnsi(c_Texto))
	aAdd(a_Buttons, { 1,.T.,{|o| n_Opca:= 1, If( .T., o:oWnd:End(), n_Opca:=0 ) }} )
	aAdd(a_Buttons, { 2,.T.,{|o| o:oWnd:End() }} )
	aAdd(a_Buttons, { 5,.T.,{|o| Pergunte(c_Perg, .T.) }} )
	FormBatch( c_Title, a_Says, a_Buttons ,,220,380)

	If n_Opca == 1
		Processa({|lend| fAtuZZS()},"Atualizando Registros...Por favor aguarde.")
	Else
		MsgStop("Atualizacao Cancelada!","Abortado")
	Endif

Return Nil

Static Function fAtuZZS()

	Local c_QryUpd 	:= ""
	Local c_Status 	:= IIF(MV_PAR04==1, "H", IIF(MV_PAR04==2, "D", "I"))
	Local c_Acesso	:= ""
	Local i			:= 1
	Local c_Aux		:= ""
	Local c_QryLACE	:= ""

	If MV_PAR01 == 2 .And. MV_PAR03 == 2
		MsgStop("Nใo existem registros para atualizar. Verifique os parโmetros.", "Nใo Achou")
	Endif

	If MV_PAR01 == 1
		For i := 1 To 10
			c_Aux := SubStr(MV_PAR02, i, 1)
			If c_Aux == "-"
				c_Acesso += IIF(i==1,"","+")+"SUBSTRING(ZZS_ACESSO, "+AllTrim(Str(i))+", 1)"
			Else
				c_Acesso += IIF(i==1,"","+")+"'"+c_Aux+"'"
				c_QryLACE += ", ZZS_LACE"+StrZero(i, 2)+" = '"+IIF(Upper(c_Aux)=="X","T","F")+"' "
			Endif
		Next i
		c_QryUpd := "UPDATE "+RetSqlName("ZZS")+" SET ZZS_ACESSO = "+c_Acesso+" "
		c_QryUpd += c_QryLACE
		If MV_PAR03 == 1
			c_QryUpd += ", ZZS_STATUS = '"+c_Status+"' "
		Endif
	Else
		c_QryUpd := "UPDATE "+RetSqlName("ZZS")+" SET ZZS_STATUS = '"+c_Status+"' "
	Endif

	c_QryUpd += "WHERE ZZS_FILIAL = '  ' "
	c_QryUpd += "AND ZZS_MODULO BETWEEN '"+MV_PAR11+"' AND '"+MV_PAR12+"' "
	c_QryUpd += "AND ZZS_USER BETWEEN '"+MV_PAR05+"' AND '"+MV_PAR06+"' "
	c_QryUpd += "AND ZZS_CHAVE BETWEEN '"+MV_PAR07+"' AND '"+MV_PAR08+"' "
	c_QryUpd += "AND ZZS_FUNCAO BETWEEN '"+MV_PAR09+"' AND '"+MV_PAR10+"' "
	c_QryUpd += "AND D_E_L_E_T_ = ' ' "

	//MemoWrite("FGMENU1.SQL", c_QryUpd)

	TcSqlExec(c_QryUpd)

Return Nil
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณ Descricao                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบfCopyCfg  ณ Copia as configuracoes do usuario posicionado para os sele-บฑฑ
ฑฑบ          ณ cionados.                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function fCopyCfg()

Local aSalvAmb 	:= GetArea()
Local cVar     	:= Nil
Local cVar1    	:= Nil
Local oDlg     	:= Nil
Local cTitulo  	:= "Copia configura็ใo do "+IIF(l_GrpMenu, "grupo", "usuแrio")+"."
Local lMark    	:= .F.
Local oOk      	:= LoadBitmap( GetResources(), "LBOK" )
Local oNo      	:= LoadBitmap( GetResources(), "LBNO" )
Local n_Bnt    	:= 0
Local c_Query 	:= ""

Private oLbx 	:= Nil
Private aVetor 	:= {}
Private oLbx1 	:= Nil
Private aVetor1	:= {}

c_Query := "SELECT DISTINCT ZZS_MODULO FROM "+RetSqlName("ZZS")+" "
c_Query += "WHERE D_E_L_E_T_ = ' ' AND ZZS_USER = '"+ZZS->ZZS_USER+"' ORDER BY ZZS_MODULO"

If Select("QRY") > 0
	QRY->(DbCloseArea())
Endif

TCQUERY c_Query NEW ALIAS "QRY"

//+-------------------------------------+
//| Carrega o vetor conforme a condicao |
//+-------------------------------------+
While QRY->(!Eof())

	aAdd( aVetor, { .T.,;
                   QRY->ZZS_MODULO})

	QRY->(DbSkip())
Enddo

If l_GrpMenu
	a_UserTemp := AllGroups()
	For i := 2 To Len(a_UserTemp)
		
		If AllTrim(ZZS->ZZS_USER) <> AllTrim(a_UserTemp[i][1][2])
			aAdd( aVetor1, { .F.,;
			              a_UserTemp[i][1][2]})
		Endif
	Next i
	aVetor1 := aSort(aVetor1,,,{ |x,y| x[2] < y[2] } )
Else
	a_UserTemp := AllUsers()
	For i := 2 To Len(a_UserTemp)
	
		If !a_UserTemp[i][1][17] .And. AllTrim(ZZS->ZZS_USER) <> AllTrim(a_UserTemp[i][1][2])
	
			aAdd( aVetor1, { .F.,;
			              a_UserTemp[i][1][2],;
			              a_UserTemp[i][1][4]})
	
		Endif
	
	Next i
	aVetor1 := aSort(aVetor1,,,{ |x,y| x[2] < y[2] } )
Endif
//+-----------------------------------------------+
//| Monta a tela para usuario visualizar consulta |
//+-----------------------------------------------+

DEFINE MSDIALOG oDlg TITLE cTitulo FROM 000,000 TO 240,500 PIXEL

@ 003,010 SAY OemToAnsi("Este programa irแ replicar os itens do menu do "+IIF(l_GrpMenu, "grupo", "usuแrio")+" ["+ZZS->ZZS_USER+"] conforme os m๓dulos e") Size 250,050 COLOR CLR_RED OF oDlg PIXEL
@ 010,010 SAY OemToAnsi(IIF(l_GrpMenu, "grupos", "usuแrios")+" selecionados abaixo. CUIDADO. Isto irแ sobrepor os registros atuais.") Size 250,050 COLOR CLR_RED OF oDlg PIXEL

@ 020,010 LISTBOX oLbx VAR cVar FIELDS HEADER " ",;
                                      "M๓dulo" SIZE 090,085 OF oDlg PIXEL ;
                                        ON dblClick( Inverter(@aVetor, @oLbx),oLbx:Refresh(.F.) )

oLbx:SetArray( aVetor )
oLbx:bLine := {|| {Iif(aVetor[oLbx:nAt,1],oOk,oNo),;
                    aVetor[oLbx:nAt,2]}}

If l_GrpMenu
	@ 020,105 LISTBOX oLbx1 VAR cVar1 FIELDS HEADER " ",;
	                                      	"Grupo" SIZE 135,085 OF oDlg PIXEL ;
	                                        ON dblClick( Inverter(@aVetor1, @oLbx1),oLbx1:Refresh(.F.) )
	
	oLbx1:SetArray( aVetor1 )
	oLbx1:bLine := {|| {Iif(aVetor1[oLbx1:nAt,1],oOk,oNo),;
	                    aVetor1[oLbx1:nAt,2]}}
Else
	@ 020,105 LISTBOX oLbx1 VAR cVar1 FIELDS HEADER " ",;
	                                      	"Login",;
	                                      	"Nome" SIZE 135,085 OF oDlg PIXEL ;
	                                        ON dblClick( Inverter(@aVetor1, @oLbx1),oLbx1:Refresh(.F.) )
	
	oLbx1:SetArray( aVetor1 )
	oLbx1:bLine := {|| {Iif(aVetor1[oLbx1:nAt,1],oOk,oNo),;
	                    aVetor1[oLbx1:nAt,2],;
	                    aVetor1[oLbx1:nAt,3]}}
Endif
	
DEFINE SBUTTON FROM 107,180 TYPE 1 ACTION (n_Bnt:=1,oDlg:End()) ENABLE OF oDlg
DEFINE SBUTTON FROM 107,213 TYPE 2 ACTION oDlg:End() ENABLE OF oDlg
ACTIVATE MSDIALOG oDlg CENTERED

If n_Bnt == 1

	l_Gerou := .F.

	oProcess := MsNewProcess():New({|| l_Gerou := fCopyUsr(aVetor, aVetor1, ZZS->ZZS_USER) },"Copiando itens do menu.","Aguarde...",.F.)
	oProcess:Activate()

	If l_Gerou
		MsgInfo("C๓pia realizada com sucesso!", "Processo OK!")
	Else
		MsgStop("Nenhum registro foi copiado.", "Nใo Gerou!")
	Endif

Endif

RestArea( aSalvAmb )
DeleteObject(oOk)
DeleteObject(oNo)

Return Nil
Static Function fCopyUsr(a_Modulo, a_Usuario, c_UsrPrinc)

	Local l_Gerou := .F.
	
	oProcess:SetRegua1(Len(a_Modulo))

	For i := 1 To Len(a_Modulo)

		oProcess:IncRegua1("M๓dulo ...: "+a_Modulo[i][2])
	
		If a_Modulo[i][1]

			c_Query := "SELECT * FROM "+RetSqlName("ZZS")+" "
			c_Query += "WHERE ZZS_FILIAL = '  ' "
			c_Query += "AND ZZS_MODULO = '"+a_Modulo[i][2]+"' "
			c_Query += "AND ZZS_USER = '"+c_UsrPrinc+"' "
			c_Query += "AND D_E_L_E_T_ = ' ' "
			
			If Select("QRY") > 0
				QRY->(DbCloseArea())
			Endif
					
			TCQUERY c_Query NEW ALIAS "QRY"
			
			oProcess:SetRegua2(Len(a_Usuario))

			For j := 1 To Len(a_Usuario)
		
				oProcess:IncRegua2(IIF(l_GrpMenu, "Grupo....:", "Usuแrio...: ")+a_Usuario[j][2])
	
				If a_Usuario[j][1]

					c_Query := "UPDATE "+RetSqlName("ZZS")+" SET D_E_L_E_T_ = '*' "
					c_Query += "WHERE ZZS_FILIAL = '  ' "
					c_Query += "AND ZZS_MODULO = '"+a_Modulo[i][2]+"' "
					c_Query += "AND ZZS_USER = '"+a_Usuario[j][2]+"' "
					c_Query += "AND D_E_L_E_T_ = ' ' "

					TcSqlExec(c_Query)
					
					l_Gerou := .T.
					DbSelectArea("QRY")
					DbGoTop()
					While QRY->(!Eof())
						DbSelectArea("ZZS")
						RecLock("ZZS", .T.)
							ZZS->ZZS_USER	:= a_Usuario[j][2]
							ZZS->ZZS_FUNCAO	:= QRY->ZZS_FUNCAO
							ZZS->ZZS_ACESSO	:= QRY->ZZS_ACESSO
							ZZS->ZZS_STATUS	:= QRY->ZZS_STATUS
							ZZS->ZZS_TITULO	:= QRY->ZZS_TITULO
							ZZS->ZZS_CHAVE	:= QRY->ZZS_CHAVE
							ZZS->ZZS_MODULO	:= QRY->ZZS_MODULO
							ZZS->ZZS_DACE01	:= QRY->ZZS_DACE01
							ZZS->ZZS_LACE01	:= IIF(QRY->ZZS_LACE01=="T", .T., .F.)
							ZZS->ZZS_DACE02	:= QRY->ZZS_DACE02
							ZZS->ZZS_LACE02	:= IIF(QRY->ZZS_LACE02=="T", .T., .F.)
							ZZS->ZZS_DACE03	:= QRY->ZZS_DACE03
							ZZS->ZZS_LACE03	:= IIF(QRY->ZZS_LACE03=="T", .T., .F.)
							ZZS->ZZS_DACE04	:= QRY->ZZS_DACE04
							ZZS->ZZS_LACE04	:= IIF(QRY->ZZS_LACE04=="T", .T., .F.)
							ZZS->ZZS_DACE05	:= QRY->ZZS_DACE05
							ZZS->ZZS_LACE05	:= IIF(QRY->ZZS_LACE05=="T", .T., .F.)
							ZZS->ZZS_DACE06	:= QRY->ZZS_DACE06
							ZZS->ZZS_LACE06	:= IIF(QRY->ZZS_LACE06=="T", .T., .F.)
							ZZS->ZZS_DACE07	:= QRY->ZZS_DACE07
							ZZS->ZZS_LACE07	:= IIF(QRY->ZZS_LACE07=="T", .T., .F.)
							ZZS->ZZS_DACE08	:= QRY->ZZS_DACE08
							ZZS->ZZS_LACE08	:= IIF(QRY->ZZS_LACE08=="T", .T., .F.)
							ZZS->ZZS_DACE09	:= QRY->ZZS_DACE09
							ZZS->ZZS_LACE09	:= IIF(QRY->ZZS_LACE09=="T", .T., .F.)
							ZZS->ZZS_DACE10	:= QRY->ZZS_DACE10
							ZZS->ZZS_LACE10	:= IIF(QRY->ZZS_LACE10=="T", .T., .F.)
						MsUnLock()
						QRY->(DbSkip())
					Enddo
				Endif
			
			Next j
		
		Endif
		
	Next i

Return l_Gerou
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณ Descricao                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบfGerXnuLt ณ Gera os arquivos de menu conforme os parametros informados บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function fGerXnuLt()

	Local c_Perg 	:= IIF(l_Grpmenu, "MYXNU60000", "MYXNU30000")
	Local c_Query	:= ""
	Local a_Menu	:= {}

	ValidPerg(c_Perg)
	
	If !Pergunte(c_Perg, .T.)
		Return Nil
	Endif
	
	c_Query += "SELECT ZZS_FILIAL, ZZS_USER, ZZS_MODULO "+Chr(13)
	c_Query += "FROM "+RetSqlName("ZZS")+" "+Chr(13)
	c_Query += "WHERE ZZS_FILIAL = '  ' "+Chr(13)
	c_Query += "AND ZZS_USER BETWEEN '"+MV_PAR01+"' AND '"+MV_PAR02+"' "+Chr(13)
	c_Query += "AND ZZS_FUNCAO BETWEEN '"+MV_PAR03+"' AND '"+MV_PAR04+"' "+Chr(13)
	c_Query += "AND ZZS_MODULO BETWEEN '"+MV_PAR05+"' AND '"+MV_PAR06+"' "+Chr(13)
	c_Query += "AND D_E_L_E_T_ = ' ' "+Chr(13)
	c_Query += "GROUP BY ZZS_FILIAL, ZZS_USER, ZZS_MODULO "+Chr(13)
	
	If Select("QRY") > 0
		QRY->(DbCloseArea())
	Endif
	
	TCQUERY c_Query NEW ALIAS "QRY"
	
	While QRY->(!Eof())
		aAdd(a_Menu, {QRY->ZZS_MODULO, QRY->ZZS_USER})
		QRY->(DbSkip())
	Enddo

	If Len(a_Menu) > 0

		Processa({|| fXnuLote(a_Menu) },"Gerando menu(s) do "+IIF(l_grpMenu, "grupo", "usuแrio")+".")
		MsgInfo("Foram gerados [ "+AllTrim(Str(Len(a_Menu)))+" ] arquivos de menu no diret๓rio "+AllTrim(GetMV("MV_XPATMNU"))+" com sucesso!", "Processo Finalizado!")
	
	Else
		MsgStop("Nใo foi localizado nenhum registro conforme os parametros selecionados.", "Sem registro")
	Endif

	
Return Nil
Static Function fXnuLote(a_Menu)

	Local c_NomMenu := ""
	ProcRegua(Len(a_Menu))
	
	For n_Menu := 1 To Len(a_Menu)
		IncProc(IIF(l_GrpMenu, "Grupo ...:", "Usuแrio ...: ")+AllTrim(a_Menu[n_Menu][2])+ "   - M๓dulo ...: "+a_Menu[n_Menu][1])
		c_NomMenu := SubStr(AllTrim(a_Menu[n_Menu][1]), 5)+"_"+AllTrim(a_Menu[n_Menu][2])
		U_germnu(.F., a_Menu[n_Menu][1], a_Menu[n_Menu][2], c_NomMenu)
	Next n_Menu

Return Nil
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณ Descricao                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบfSelUser  ณ Monta tela para selecionar os modulos.                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function fSelUser()
	
Local aSalvAmb 	:= GetArea()
Local cVar     	:= Nil
Local oDlg     	:= Nil
Local cTitulo  	:= "M๓dulos utilizados pela empresa ["+AllTrim(SM0->M0_NOME)+"]."
Local lMark    	:= .F.
Local oOk      	:= LoadBitmap( GetResources(), "LBOK" )
Local oNo      	:= LoadBitmap( GetResources(), "LBNO" )
Local oChk     	:= Nil
Local n_Bnt    	:= 0
Local c_Query 	:= ""

c_Query := "SELECT DISTINCT ZZR_MODULO, ZZR_TITMOD "
c_Query += "FROM "+RetSqlName("ZZR")+" "
c_Query += "INNER JOIN "+RetSqlName("ZZS")+" "
c_Query += "	ON ZZS_FILIAL = ZZR_FILIAL "
c_Query += "	AND ZZS_MODULO = ZZR_MODULO "
c_Query += "	AND ZZS_USER = '"+ZZS->ZZS_USER+"' "
c_Query += "	AND "+RetSqlName("ZZS")+".D_E_L_E_T_ = ' ' "
c_Query += "WHERE "+RetSqlName("ZZR")+".D_E_L_E_T_ = ' ' "
c_Query += "ORDER BY ZZR_TITMOD "

Private lChk	:= .F.

Private oLbx 	:= Nil
Private aVetor 	:= {}

If Select("QRY") > 0
	QRY->(DbCloseArea())
Endif

TCQUERY c_Query NEW ALIAS "QRY"

//+-------------------------------------+
//| Carrega o vetor conforme a condicao |
//+-------------------------------------+
While QRY->(!Eof())

	aAdd( aVetor, { lMark,;
                   QRY->ZZR_MODULO,;
                   QRY->ZZR_TITMOD})

	QRY->(DbSkip())
Enddo

//+-----------------------------------------------+
//| Monta a tela para usuario visualizar consulta |
//+-----------------------------------------------+
If Len( aVetor ) == 0
   Aviso( cTitulo, "Nao existem menus principais a consultar", {"Ok"} )
   Return Nil
Endif

DEFINE MSDIALOG oDlg TITLE cTitulo FROM 000,000 TO 240,500 PIXEL

@ 003,010 SAY OemToAnsi("Este programa irแ gerar os menus para o "+IIF(l_GrpMenu, "grupo", "usuแrio")+" ["+ZZS->ZZS_USER+"] conforme os m๓dulos") Size 250,050 COLOR CLR_RED OF oDlg PIXEL
@ 010,010 SAY OemToAnsi("selecionados abaixo.") Size 250,050 COLOR CLR_RED OF oDlg PIXEL

@ 020,010 LISTBOX oLbx VAR cVar FIELDS HEADER " ",;           
                                      "M๓dulo",;
                                      "Descri็ใo" SIZE 230,085 OF oDlg PIXEL ;
                                        ON dblClick( Inverter(@aVetor, @oLbx),oLbx:Refresh(.F.) )

oLbx:SetArray( aVetor )
oLbx:bLine := {|| {Iif(aVetor[oLbx:nAt,1],oOk,oNo),;
                    aVetor[oLbx:nAt,2],;
                    aVetor[oLbx:nAt,3]}}
	 
@107, 010 CHECKBOX oChk VAR lChk PROMPT "Marca/Desmarca" SIZE 80,10 PIXEL OF oDlg;
         ON CLICK(Iif(lChk,Marca(lChk),Marca(lChk)))

DEFINE SBUTTON FROM 107,180 TYPE 1 ACTION (n_Bnt:=1,oDlg:End()) ENABLE OF oDlg
DEFINE SBUTTON FROM 107,213 TYPE 2 ACTION oDlg:End() ENABLE OF oDlg
ACTIVATE MSDIALOG oDlg CENTERED

If n_Bnt == 1
	
	l_Gerou := .F.
	
	Processa({|| l_Gerou := fGerMenu(aVetor, ZZS->ZZS_USER) },"Gerando menu(s) do "+IIF(l_GrpMenu, "grupo", "usuแrio")+".")

	If l_Gerou
		MsgInfo("Arquivo(s) gerado(s) com sucesso!", "Processo OK!")
	Else
		MsgStop("Nenhum arquivo de menu foi gerado.", "Nใo Gerou!")
	Endif

Endif

RestArea( aSalvAmb )
DeleteObject(oOk)
DeleteObject(oNo)

Return Nil
Static Function fGerMenu(a_Mod, c_User)

	Local l_Gerou := .F.
	Local c_NomMenu	:= ""
	
	ProcRegua(Len(a_Mod))
	
	For n_Mod := 1 To Len(a_Mod)
		If a_Mod[n_Mod][1]
			IncProc(IIF(l_GrpMenu, "Grupo ...: ", "Usuแrio ...: ")+AllTrim(c_User)+ "   - M๓dulo ...: "+a_Mod[n_Mod][2])
			c_NomMenu := SubStr(AllTrim(a_Mod[n_Mod][2]), 5)+"_"+AllTrim(c_User)
			U_germnu(.F., a_Mod[n_Mod][2], c_User, c_NomMenu)
			l_Gerou := .T.
		Endif
	Next n_Mod

Return l_Gerou
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณ Descricao                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบInverter  ณ Inverte, marca / desmarca o item.                          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ aVet   => Vetor do objeto lista                            บฑฑ
ฑฑบ          ณ oObj   => Objeto lista                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function Inverter(aVet, oObj)

	aVet[oObj:nAt][1] := !aVet[oObj:nAt][1]
	oObj:Refresh()

Return Nil
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณ Descricao                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบMarca     ณ Inverte a marcacao de todos os itens.                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ lMarca  ==> Item marcado = .T., nao marcado = .F.          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function Marca(lMarca)
	
	Local i := 0
	For i := 1 To Len(aVetor)
	   aVetor[i][1] := lMarca
	Next i
	oLbx:Refresh()
	
Return Nil
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณVALIDPERG บ Autor ณ MKW Windows 2.0    บ Data ณ  06/01/99   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Verifica a existencia das perguntas criando-as caso seja   บฑฑ
ฑฑบ          ณ necessario (caso nao existam).                             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function ValidPerg(c_Perg)

	c_Alias := Alias()
	
	DbSelectArea("SX1")
	DbSetOrder(1)
	
	c_Perg 	:= PADR(c_Perg, 10)
	aRegs	:= {}
	
	If c_Perg == "MYXNU20000"
		//            Grupo /Ordem /Pergunta                 /PERSPA   / PERENG/Variavel/Tipo   /Tamanho  /Decimal/Presel /GSC /Valid/Var01      /Def01      /DEFSPA1 /DEFENG1 /Cnt01 /Var02     /Def02           /DEFSPA2 /DEFENG2 /Cnt02 /Var03     /Def03          /DEFSPA3 /DEFENG3 /Cnt03 /Var04     /Def04          /DEFSPA4 /DEFENG4 /Cnt04 /Var05     /Def05          /DEFSPA5/DEFENG5  /Cnt05 /F3   /PYME/GRPSXG
		aAdd(aRegs,{c_Perg,"01"  ,"Atualiz. Acesso        ?",""      ,""     ,"MV_CH1","N"    ,01      ,0       ,1     ,"C" ,""    ,"MV_PAR01","Sim"      	,""      ,""      ,""   ,""         ,"Nใo"         ,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"02"  ,"Acesso (- Nใo Atualiza)?",""      ,""     ,"MV_CH2","C"    ,10      ,0       ,0     ,"G" ,""    ,"MV_PAR02",""		      	,""      ,""      ,""   ,""         ,""				,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"03"  ,"Atualiz. Status        ?",""      ,""     ,"MV_CH3","N"    ,01      ,0       ,1     ,"C" ,""    ,"MV_PAR03","Sim"      	,""      ,""      ,""   ,""         ,"Nใo"         ,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"04"  ,"Status                 ?",""      ,""     ,"MV_CH4","N"    ,01      ,0       ,1     ,"C" ,""    ,"MV_PAR04","Habilitado"   ,""      ,""      ,""   ,""         ,"Desabilitado",""      ,""      ,""    ,""        ,"Inibido"      ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"05"  ,"Usuแrio de             ?",""      ,""     ,"MV_CH5","C"    ,15      ,0       ,0     ,"G" ,""    ,"MV_PAR05",""         	,""      ,""      ,""   ,""         ,""            ,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"06"  ,"Usuแrio at้            ?",""      ,""     ,"MV_CH6","C"    ,15      ,0       ,0     ,"G" ,""    ,"MV_PAR06",""		      	,""      ,""      ,""   ,""         ,""				,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"07"  ,"Chave(Tree Key) de     ?",""      ,""     ,"MV_CH7","C"    ,10      ,0       ,0     ,"G" ,""    ,"MV_PAR07",""         	,""      ,""      ,""   ,""         ,""            ,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"08"  ,"Chave(Tree Key) at้    ?",""      ,""     ,"MV_CH8","C"    ,10      ,0       ,0     ,"G" ,""    ,"MV_PAR08",""		      	,""      ,""      ,""   ,""         ,""				,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"09"  ,"Fun็ใo de              ?",""      ,""     ,"MV_CH9","C"    ,10      ,0       ,0     ,"G" ,""    ,"MV_PAR09",""         	,""      ,""      ,""   ,""         ,""            ,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"10"  ,"Fun็ใo at้             ?",""      ,""     ,"MV_CHA","C"    ,10      ,0       ,0     ,"G" ,""    ,"MV_PAR10",""		      	,""      ,""      ,""   ,""         ,""				,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"11"  ,"M๓dulo de              ?",""      ,""     ,"MV_CHB","C"    ,07      ,0       ,0     ,"G" ,""    ,"MV_PAR11",""         	,""      ,""      ,""   ,""         ,""            ,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"12"  ,"M๓dulo at้             ?",""      ,""     ,"MV_CHC","C"    ,07      ,0       ,0     ,"G" ,""    ,"MV_PAR12",""		      	,""      ,""      ,""   ,""         ,""				,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
	ElseIf c_Perg == "MYXNU50000"                          
		//            Grupo /Ordem /Pergunta                 /PERSPA   / PERENG/Variavel/Tipo   /Tamanho  /Decimal/Presel /GSC /Valid/Var01      /Def01      /DEFSPA1 /DEFENG1 /Cnt01 /Var02     /Def02           /DEFSPA2 /DEFENG2 /Cnt02 /Var03     /Def03          /DEFSPA3 /DEFENG3 /Cnt03 /Var04     /Def04          /DEFSPA4 /DEFENG4 /Cnt04 /Var05     /Def05          /DEFSPA5/DEFENG5  /Cnt05 /F3   /PYME/GRPSXG
		aAdd(aRegs,{c_Perg,"01"  ,"Atualiz. Acesso        ?",""      ,""     ,"MV_CH1","N"    ,01      ,0       ,1     ,"C" ,""    ,"MV_PAR01","Sim"      	,""      ,""      ,""   ,""         ,"Nใo"         ,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"02"  ,"Acesso (- Nใo Atualiza)?",""      ,""     ,"MV_CH2","C"    ,10      ,0       ,0     ,"G" ,""    ,"MV_PAR02",""		      	,""      ,""      ,""   ,""         ,""				,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"03"  ,"Atualiz. Status        ?",""      ,""     ,"MV_CH3","N"    ,01      ,0       ,1     ,"C" ,""    ,"MV_PAR03","Sim"      	,""      ,""      ,""   ,""         ,"Nใo"         ,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"04"  ,"Status                 ?",""      ,""     ,"MV_CH4","N"    ,01      ,0       ,1     ,"C" ,""    ,"MV_PAR04","Habilitado"   ,""      ,""      ,""   ,""         ,"Desabilitado",""      ,""      ,""    ,""        ,"Inibido"      ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"05"  ,"Grupo de               ?",""      ,""     ,"MV_CH5","C"    ,15      ,0       ,0     ,"G" ,""    ,"MV_PAR05",""         	,""      ,""      ,""   ,""         ,""            ,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"06"  ,"Grupo at้              ?",""      ,""     ,"MV_CH6","C"    ,15      ,0       ,0     ,"G" ,""    ,"MV_PAR06",""		      	,""      ,""      ,""   ,""         ,""				,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"07"  ,"Chave(Tree Key) de     ?",""      ,""     ,"MV_CH7","C"    ,10      ,0       ,0     ,"G" ,""    ,"MV_PAR07",""         	,""      ,""      ,""   ,""         ,""            ,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"08"  ,"Chave(Tree Key) at้    ?",""      ,""     ,"MV_CH8","C"    ,10      ,0       ,0     ,"G" ,""    ,"MV_PAR08",""		      	,""      ,""      ,""   ,""         ,""				,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"09"  ,"Fun็ใo de              ?",""      ,""     ,"MV_CH9","C"    ,10      ,0       ,0     ,"G" ,""    ,"MV_PAR09",""         	,""      ,""      ,""   ,""         ,""            ,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"10"  ,"Fun็ใo at้             ?",""      ,""     ,"MV_CHA","C"    ,10      ,0       ,0     ,"G" ,""    ,"MV_PAR10",""		      	,""      ,""      ,""   ,""         ,""				,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"11"  ,"M๓dulo de              ?",""      ,""     ,"MV_CHB","C"    ,07      ,0       ,0     ,"G" ,""    ,"MV_PAR11",""         	,""      ,""      ,""   ,""         ,""            ,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"12"  ,"M๓dulo at้             ?",""      ,""     ,"MV_CHC","C"    ,07      ,0       ,0     ,"G" ,""    ,"MV_PAR12",""		      	,""      ,""      ,""   ,""         ,""				,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
	ElseIf c_Perg == "MYXNU30000"
		//            Grupo /Ordem /Pergunta             /PERSPA   / PERENG/Variavel/Tipo   /Tamanho  /Decimal/Presel /GSC /Valid/Var01      /Def01      /DEFSPA1 /DEFENG1 /Cnt01 /Var02     /Def02           /DEFSPA2 /DEFENG2 /Cnt02 /Var03     /Def03          /DEFSPA3 /DEFENG3 /Cnt03 /Var04     /Def04          /DEFSPA4 /DEFENG4 /Cnt04 /Var05     /Def05          /DEFSPA5/DEFENG5  /Cnt05 /F3   /PYME/GRPSXG
		aAdd(aRegs,{c_Perg,"01"  ,"Usuแrio de         ?",""      ,""     ,"MV_CH1","C"    ,15      ,0       ,0     ,"G" ,""    ,"MV_PAR01",""         	,""      ,""      ,""   ,""         ,""            ,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"02"  ,"Usuแrio at้        ?",""      ,""     ,"MV_CH2","C"    ,15      ,0       ,0     ,"G" ,""    ,"MV_PAR02",""		      	,""      ,""      ,""   ,""         ,""				,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"03"  ,"Fun็ใo de          ?",""      ,""     ,"MV_CH3","C"    ,10      ,0       ,0     ,"G" ,""    ,"MV_PAR03",""         	,""      ,""      ,""   ,""         ,""            ,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"04"  ,"Fun็ใo at้         ?",""      ,""     ,"MV_CH4","C"    ,10      ,0       ,0     ,"G" ,""    ,"MV_PAR04",""		      	,""      ,""      ,""   ,""         ,""				,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"05"  ,"M๓dulo de          ?",""      ,""     ,"MV_CH5","C"    ,07      ,0       ,0     ,"G" ,""    ,"MV_PAR05",""         	,""      ,""      ,""   ,""         ,""            ,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"06"  ,"M๓dulo at้         ?",""      ,""     ,"MV_CH6","C"    ,07      ,0       ,0     ,"G" ,""    ,"MV_PAR06",""		      	,""      ,""      ,""   ,""         ,""				,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
	ElseIf c_Perg == "MYXNU60000"
		//            Grupo /Ordem /Pergunta             /PERSPA   / PERENG/Variavel/Tipo   /Tamanho  /Decimal/Presel /GSC /Valid/Var01      /Def01      /DEFSPA1 /DEFENG1 /Cnt01 /Var02     /Def02           /DEFSPA2 /DEFENG2 /Cnt02 /Var03     /Def03          /DEFSPA3 /DEFENG3 /Cnt03 /Var04     /Def04          /DEFSPA4 /DEFENG4 /Cnt04 /Var05     /Def05          /DEFSPA5/DEFENG5  /Cnt05 /F3   /PYME/GRPSXG
		aAdd(aRegs,{c_Perg,"01"  ,"Grupo de           ?",""      ,""     ,"MV_CH1","C"    ,15      ,0       ,0     ,"G" ,""    ,"MV_PAR01",""         	,""      ,""      ,""   ,""         ,""            ,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"02"  ,"Grupo at้          ?",""      ,""     ,"MV_CH2","C"    ,15      ,0       ,0     ,"G" ,""    ,"MV_PAR02",""		      	,""      ,""      ,""   ,""         ,""				,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"03"  ,"Fun็ใo de          ?",""      ,""     ,"MV_CH3","C"    ,10      ,0       ,0     ,"G" ,""    ,"MV_PAR03",""         	,""      ,""      ,""   ,""         ,""            ,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"04"  ,"Fun็ใo at้         ?",""      ,""     ,"MV_CH4","C"    ,10      ,0       ,0     ,"G" ,""    ,"MV_PAR04",""		      	,""      ,""      ,""   ,""         ,""				,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"05"  ,"M๓dulo de          ?",""      ,""     ,"MV_CH5","C"    ,07      ,0       ,0     ,"G" ,""    ,"MV_PAR05",""         	,""      ,""      ,""   ,""         ,""            ,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		aAdd(aRegs,{c_Perg,"06"  ,"M๓dulo at้         ?",""      ,""     ,"MV_CH6","C"    ,07      ,0       ,0     ,"G" ,""    ,"MV_PAR06",""		      	,""      ,""      ,""   ,""         ,""				,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
	Endif
	
	For i:=1 to Len(aRegs)
		If !dbSeek(c_Perg+aRegs[i,2])
			RecLock("SX1", .T.)
			For j:=1 to FCount()
				If j <= Len(aRegs[i])
					FieldPut(j,aRegs[i,j])
				Endif
			Next
			MsUnlock()
		Endif
	Next
	
	DbSelectArea(c_Alias)

Return Nil
