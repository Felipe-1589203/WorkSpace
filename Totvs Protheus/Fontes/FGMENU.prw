#include "RWMAKE.CH"
#include "Protheus.Ch"
#include "TopConn.Ch"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ       
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ FGMENU   บ Autor ณ Douglas V. Franca  บ Data ณ  07/10/05   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Gerenciar os arquivos de menu. (xnu)                       บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Gen้rico.                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ                       
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function FGMENU(n_Opc)
                                                         
If !(alltrim(cusername) == 'csantos' .or. alltrim(cusername) == 'amartins' .or. alltrim(cusername) == 'caquino')
	msgAlert("Acesso restrito!!!", "A T E N ว ร O")
	Return
EndIf

If n_Opc <> Nil
	If n_Opc == 1
		fImpMatriz()
	ElseIf n_Opc == 2
		fExpoXnu()
	ElseIf n_Opc == 3
		fGeraXnu()
	ElseIf n_Opc == 4
		fGrupo(3)
	ElseIf n_Opc == 5
		fNewItem()
	ElseIf n_Opc == 6
		If AllTrim(ZZR->ZZR_FUNCAO) == ""
			fGrupo(4)
		Else
			fAltera()
		Endif
	ElseIf n_Opc == 7
		fExclui()
	ElseIf n_Opc == 8
		U_FGMENU3()
	ElseIf n_Opc == 9
		If AllTrim(ZZR->ZZR_FUNCAO) == ""
			MsgStop("Apenas fun็๕es podem ser executadas.", "Aviso")
		ElseIf !(ZZR->ZZR_TIPO $ "1#3")
			MsgStop("Apenas fun็๕es do usuแrio ou do sistema podem ser executadas.", "Aviso")
		Else
			c_Func := AllTrim(ZZR->ZZR_FUNCAO)+"()"
			If ZZR->ZZR_TIPO == "3"
				c_Func := "U_"+c_Func
			Endif
			&(c_Func)
		Endif
	ElseIf n_Opc == 10
		If AllTrim(ZZR->ZZR_FUNCAO) <> ""
			U_LstFcZZS()
		Else
			MsgStop("Selecione uma fun็ใo.", cCadastro)
		Endif
	Endif
	Return Nil
Endif

Private cCadastro 	:= "Manuten็ใo dos Menus Principais"
Private aRotina 	:= {}

//Parametro MV_XTPMENU onde 0=Por Usuแrio ou 1=Por Grupo(Default)
Private l_GrpMenu	:= (GetMV("MV_XTPMENU", ,"1") == "1")

aAdd(aRotina, {"Pesquisar" 			, 'AxPesqui'  		,0,1})
aAdd(aRotina, {"Visualizar"			, 'AxVisual' 		,0,2})
aAdd(aRotina, {"Importar Menu"		, 'U_FGMENU(1)'		,0,3})
aAdd(aRotina, {"Inclui Pasta"		, 'U_FGMENU(4)'		,0,4})
aAdd(aRotina, {"Inclui Funcao"		, 'U_FGMENU(5)'		,0,4})
aAdd(aRotina, {"Alterar"			, 'U_FGMENU(6)'		,0,4})
aAdd(aRotina, {"Excluir"			, 'U_FGMENU(7)'		,0,4})
aAdd(aRotina, {"มrvore"				, 'U_FGMENU(8)'		,0,4})
aAdd(aRotina, {"Exp. Itens "		, 'U_FGMENU(2)'		,0,4})
aAdd(aRotina, {"Gerar Menu"			, 'U_FGMENU(3)'		,0,4})
aAdd(aRotina, {"Executar"			, 'U_FGMENU(9)'		,0,4})
aAdd(aRotina, {"Todas Utiliz"		, 'U_FGMENU(10)'	,0,4})

MBrowse( ,,,,"ZZR")

Return Nil
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณ Descricao                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบfNewGrp   ณ Inclui um novo grupo no menu.                              บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function fGrupo(n_Opcao)

Local oDlg
Local lReturn 	:= .F.
Local cTitulo 	:= IIF(n_Opcao==3, "Novo", "Altera") + " Grupo - Descri็ใo"
Local aGrupo 	:= {Space(25),Space(25),Space(25)}
Local oGrupo 	:= Array(3)
Local l_Continua:= .T.
Local c_Chave	:= AllTrim(ZZR->ZZR_CHAVE)
Local c_Modulo	:= ZZR->ZZR_MODULO

If n_Opcao == 4
	
	aGrupo[1] := ZZR->ZZR_TITPOR
	aGrupo[2] := ZZR->ZZR_TITESP
	aGrupo[3] := ZZR->ZZR_TITENG
	
ElseIf n_Opcao == 3
	
	If AllTrim(ZZR->ZZR_FUNCAO) <> ""
		MsgStop("Nใo ้ possํvel incluir um grupo abaixo de uma fun็ใo.", "I N C O N S I S T ส N C I A")
		l_Continua := .F.
	Endif
	
	If Len(c_Chave) > 4
		MsgStop("S๓ ้ possํvel ter at้ 3 niveis de grupo.", "I N C O N S I S T ส N C I A")
		l_Continua := .F.
	Endif
	
	If l_Continua
	
		DbSelectArea("ZZR")
		DbSetOrder(1) //ZZR_FILIAL, ZZR_MODULO, ZZR_CHAVE, R_E_C_N_O_, D_E_L_E_T_
		DbSeek(xFilial("ZZR")+c_Modulo+Left(c_Chave, 1), .F.)
		c_Caminho := AllTrim(ZZR->ZZR_TITPOR)
		
		If Len(c_Chave) > 1
			DbSelectArea("ZZR")
			DbSetOrder(1) //ZZR_FILIAL, ZZR_MODULO, ZZR_CHAVE, R_E_C_N_O_, D_E_L_E_T_
			DbSeek(xFilial("ZZR")+c_Modulo+Left(c_Chave, 4), .F.)
			c_Caminho += " -> "+AllTrim(ZZR->ZZR_TITPOR)
		Endif
		
		If Len(c_Chave) > 4
			DbSelectArea("ZZR")
			DbSetOrder(1) //ZZR_FILIAL, ZZR_MODULO, ZZR_CHAVE, R_E_C_N_O_, D_E_L_E_T_
			DbSeek(xFilial("ZZR")+c_Modulo+Left(c_Chave, 7), .F.)
			c_Caminho += " -> "+AllTrim(ZZR->ZZR_TITPOR)
		Endif
		
		c_Caminho += " -> <Novo Grupo>"
		
		If !MsgYesNo("O novo Grupo serแ incluํdo em "+c_Caminho, "C O N F I R M A ว ร O")
			l_Continua := .F.
		Endif
		
	Endif
	
Endif

If l_Continua

	DEFINE MSDIALOG oDlg TITLE cTitulo FROM 0,0 TO 200,300 PIXEL
	
	@ 003,003 TO 085,149 PIXEL
	
	@ 008,007 SAY "Portugu๊s" OF oDlg PIXEL
	@ 018,007 GET oGrupo[1] VAR aGrupo[1] PIXEL SIZE 139,011
	
	@ 033,007 SAY "Espanhol" OF oDlg PIXEL
	@ 043,007 GET oGrupo[2] VAR aGrupo[2] PIXEL SIZE 139,011
	
	@ 058,007 SAY "Ingl๊s" OF oDlg PIXEL
	@ 068,007 GET oGrupo[3] VAR aGrupo[3] PIXEL SIZE 139,011
	
	DEFINE SBUTTON FROM 87,090 TYPE 1 ENABLE OF oDlg ACTION ( If( !Empty(aGrupo[1]), (lReturn := .T., oDlg:End()), ApMsgStop("Titulo invแlido.","INCOSISTสNCIA") ))
	
	DEFINE SBUTTON FROM 87,120 TYPE 2 ENABLE OF oDlg ACTION oDlg:End()
	
	ACTIVATE DIALOG oDlg CENTERED
	
	If lReturn
		
		If AllTrim(aGrupo[2]) == ""
			aGrupo[2] := aGrupo[1]
		Endif
		
		If AllTrim(aGrupo[3]) == ""
			aGrupo[3] := aGrupo[1]
		Endif
		
		If n_Opcao == 4
			
			DbSelectArea("ZZR")
			RecLock("ZZR", .F.)
			ZZR->ZZR_TITPOR := aGrupo[1]
			ZZR->ZZR_TITESP := aGrupo[2]
			ZZR->ZZR_TITENG := aGrupo[3]
			MsUnLock()
			
		Endif
		
		If n_Opcao == 3
			
			c_AreaZZR := ZZR->(GetArea())
			
			c_Query := "SELECT MAX(ZZR_CHAVE) AS ZZR_CHAVE "
			c_Query += "FROM "+RetSqlName("ZZR")+" "
			c_Query += "WHERE ZZR_FILIAL = '"+xFilial("ZZR")+"' "
			c_Query += "AND ZZR_CHAVE LIKE '"+c_Chave+"%' "
			c_Query += "AND ZZR_MODULO = '"+ZZR->ZZR_MODULO+"' "
			c_Query += "AND D_E_L_E_T_ = ' ' "
			
			If Select("QRY") > 0
				QRY->(DbCloseArea())
			Endif
			
			TCQUERY c_Query NEW ALIAS "QRY"

			c_AuxChave := AllTrim(QRY->ZZR_CHAVE)
			
			If Len(c_AuxChave) == Len(c_AuxChave)
				c_AuxChave += ".00"
			Endif
			
			c_AuxChave	:= Soma1(Left(c_AuxChave, Len(c_Chave)+3))
//			c_AuxChave	:= Soma1(Left(QRY->ZZR_CHAVE, Len(c_Chave)+3))
			c_Modulo   	:= ZZR->ZZR_MODULO
			c_TitMod 	:= ZZR->ZZR_TITMOD
			c_NumMod 	:= ZZR->ZZR_NUMMOD
			
			DbSelectArea("ZZR")
			RecLock("ZZR", .T.)
			ZZR->ZZR_FILIAL	:= xFilial("ZZR")
			ZZR->ZZR_MODULO	:= c_Modulo
			ZZR->ZZR_CHAVE	:= c_AuxChave
			ZZR->ZZR_TITPOR	:= aGrupo[1]
			ZZR->ZZR_TITESP	:= aGrupo[2]
			ZZR->ZZR_TITENG	:= aGrupo[3]
			ZZR->ZZR_TITMOD	:= c_TitMod
			ZZR->ZZR_NUMMOD	:= c_NumMod
			MsUnLock()
			
			RestArea(c_AreaZZR)
			
		Endif
		
	EndIf

Endif

Return Nil
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณ Descricao                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบfNewItem  ณ Inclui um novo item no menu.                               บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function fNewItem()

Local c_Chave 	:= AllTrim(ZZR->ZZR_CHAVE)
Local c_Modulo 	:= ZZR->ZZR_MODULO

If AllTrim(ZZR->ZZR_FUNCAO) <> ""
	MsgStop("Selecione uma pasta (grupo) para inserir a nova fun็ใo.", "I N C O N S I S T ส N C I A")
	Return Nil
Endif

DbSelectArea("ZZR")
DbSetOrder(1) //ZZR_FILIAL, ZZR_MODULO, ZZR_CHAVE, R_E_C_N_O_, D_E_L_E_T_
DbSeek(xFilial("ZZR")+c_Modulo+Left(c_Chave, 1), .F.)
c_Caminho := AllTrim(ZZR->ZZR_TITPOR)

If Len(c_Chave) > 1
	DbSelectArea("ZZR")
	DbSetOrder(1) //ZZR_FILIAL, ZZR_MODULO, ZZR_CHAVE, R_E_C_N_O_, D_E_L_E_T_
	DbSeek(xFilial("ZZR")+c_Modulo+Left(c_Chave, 4), .F.)
	c_Caminho += " -> "+AllTrim(ZZR->ZZR_TITPOR)
Endif

If Len(c_Chave) > 4
	DbSelectArea("ZZR")
	DbSetOrder(1) //ZZR_FILIAL, ZZR_MODULO, ZZR_CHAVE, R_E_C_N_O_, D_E_L_E_T_
	DbSeek(xFilial("ZZR")+c_Modulo+Left(c_Chave, 7), .F.)
	c_Caminho += " -> "+AllTrim(ZZR->ZZR_TITPOR)
Endif

c_Caminho += " -> <novo item>"

If MsgYesNo("O novo item serแ incluํdo em "+c_Caminho, "C O N F I R M A ว ร O")
	If AxInclui("ZZR", 0, 3) == 1
		
		c_Query := "SELECT MAX(ZZR_CHAVE) AS ZZR_CHAVE "
		c_Query += "FROM "+RetSqlName("ZZR")+" "
		c_Query += "WHERE ZZR_FILIAL = '"+xFilial("ZZR")+"' "
		c_Query += "AND ZZR_CHAVE LIKE '"+c_Chave+"%' "
		c_Query += "AND ZZR_MODULO = '"+ZZR->ZZR_MODULO+"' "
		c_Query += "AND D_E_L_E_T_ = ' ' "
		
		If Select("QRY") > 0
			QRY->(DbCloseArea())
		Endif
		
		TCQUERY c_Query NEW ALIAS "QRY"
		
		c_NewChav := AllTrim(QRY->ZZR_CHAVE)
		
		If Len(c_NewChav) == Len(c_Chave)
			c_NewChav += ".00"
		Endif
		
		c_NewChav	:= Soma1(Left(c_NewChav, Len(c_Chave)+3))
		
		DbSelectArea("ZZR")
		RecLock("ZZR", .F.)
		ZZR->ZZR_CHAVE := c_NewChav
		If AllTrim(ZZR->ZZR_TITESP) == ""
			ZZR->ZZR_TITESP := ZZR->ZZR_TITPOR
		Endif
		If AllTrim(ZZR->ZZR_TITENG) == ""
			ZZR->ZZR_TITENG := ZZR->ZZR_TITPOR
		Endif
		MsUnLock()
		
		U_fAtuAces("ZZR")
		
		//Atualizo os menus dos usuแrios que jแ tem acesso ao m๓dulo que a funcao foi incluida.
		//Porem, a funcao entrara inibida (Hidden).
		c_Query := "SELECT ZZS_FILIAL, ZZS_USER "
		c_Query += "FROM "+RetSqlName("ZZS")+" "
		c_Query += "WHERE D_E_L_E_T_ = ' ' "
		c_Query += "AND ZZS_MODULO = '"+ZZR->ZZR_MODULO+"' "
		c_Query += "GROUP BY ZZS_FILIAL, ZZS_USER "
		
		If Select("QRY") > 0
			QRY->(DbCloseArea())
		Endif
		
		TCQUERY c_Query NEW ALIAS "QRY"
		
		While QRY->(!Eof())
			RecLock("ZZS", .T.)
			ZZS->ZZS_FILIAL	:= ZZR->ZZR_FILIAL
			ZZS->ZZS_USER	:= QRY->ZZS_USER
			ZZS->ZZS_FUNCAO	:= ZZR->ZZR_FUNCAO
			ZZS->ZZS_ACESSO	:= Space(10)
			ZZS->ZZS_STATUS	:= "I"
			ZZS->ZZS_TITULO	:= ZZR->ZZR_TITPOR
			ZZS->ZZS_CHAVE	:= ZZR->ZZR_CHAVE
			ZZS->ZZS_MODULO	:= ZZR->ZZR_MODULO
			ZZS->ZZS_DACE01	:= ZZR->ZZR_DACE01
			ZZS->ZZS_LACE01	:= .F.
			ZZS->ZZS_DACE02	:= ZZR->ZZR_DACE02
			ZZS->ZZS_LACE02	:= .F.
			ZZS->ZZS_DACE03	:= ZZR->ZZR_DACE03
			ZZS->ZZS_LACE03	:= .F.
			ZZS->ZZS_DACE04	:= ZZR->ZZR_DACE04
			ZZS->ZZS_LACE04	:= .F.
			ZZS->ZZS_DACE05	:= ZZR->ZZR_DACE05
			ZZS->ZZS_LACE05	:= .F.
			ZZS->ZZS_DACE06	:= ZZR->ZZR_DACE06
			ZZS->ZZS_LACE06	:= .F.
			ZZS->ZZS_DACE07	:= ZZR->ZZR_DACE07
			ZZS->ZZS_LACE07	:= .F.
			ZZS->ZZS_DACE08	:= ZZR->ZZR_DACE08
			ZZS->ZZS_LACE08	:= .F.
			ZZS->ZZS_DACE09	:= ZZR->ZZR_DACE09
			ZZS->ZZS_LACE09	:= .F.
			ZZS->ZZS_DACE10	:= ZZR->ZZR_DACE10
			ZZS->ZZS_LACE10	:= .F.
			MsUnLock()
			QRY->(DbSkip())
		Enddo
		
	Endif
Endif

Return Nil
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณ Descricao                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบfAltera   ณ Altera o item do menu.                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function fAltera()

Local c_UpdQry 	:= ""
Local c_NomFunc	:= ZZR->ZZR_FUNCAO
Local c_ValidFc	:= "U_VALIDZZR()"
Local a_Buttons	:= {{"GROUP"	,{|| U_LstFcZZS()}, 'Todos que utilizam a fun็ใo', 'Utiliza็ใo' }}

If AxAltera("ZZR", ZZR->(Recno()), 4, , , , , c_ValidFc, , , a_Buttons) == 1
	
	CursorWait()
	
	U_fAtuAces("ZZR")
	
	c_UpdQry += "UPDATE "+RetSqlName("ZZS")+" "
	c_UpdQry += "SET ZZS_FUNCAO = '"+ZZR->ZZR_FUNCAO+"' "
	c_UpdQry += "	,ZZS_TITULO	= '"+ZZR->ZZR_TITPOR+"' "
	c_UpdQry += "	,ZZS_DACE01	= '"+ZZR->ZZR_DACE01+"' "
	c_UpdQry += "	,ZZS_DACE02	= '"+ZZR->ZZR_DACE02+"' "
	c_UpdQry += "	,ZZS_DACE03	= '"+ZZR->ZZR_DACE03+"' "
	c_UpdQry += "	,ZZS_DACE04	= '"+ZZR->ZZR_DACE04+"' "
	c_UpdQry += "	,ZZS_DACE05	= '"+ZZR->ZZR_DACE05+"' "
	c_UpdQry += "	,ZZS_DACE06	= '"+ZZR->ZZR_DACE06+"' "
	c_UpdQry += "	,ZZS_DACE07	= '"+ZZR->ZZR_DACE07+"' "
	c_UpdQry += "	,ZZS_DACE08	= '"+ZZR->ZZR_DACE08+"' "
	c_UpdQry += "	,ZZS_DACE09	= '"+ZZR->ZZR_DACE09+"' "
	c_UpdQry += "	,ZZS_DACE10	= '"+ZZR->ZZR_DACE10+"' "
	c_UpdQry += "WHERE ZZS_FILIAL = '"+ZZR->ZZR_FILIAL+"' "
	c_UpdQry += "AND ZZS_FUNCAO = '"+c_NomFunc+"' "
	c_UpdQry += "AND D_E_L_E_T_ = ' ' "
	
	TcSqlExec(c_UpdQry)
	
	
	c_UpdQry := "UPDATE "+RetSqlName("ZZR")+" "
	c_UpdQry += "SET ZZR_FUNCAO = '"+ZZR->ZZR_FUNCAO+"' "
	c_UpdQry += "	,ZZR_TIPO = '"+ZZR->ZZR_TIPO+"' "
	c_UpdQry += "	,ZZR_TITPOR	= '"+ZZR->ZZR_TITPOR+"' "
	c_UpdQry += "	,ZZR_TITESP	= '"+ZZR->ZZR_TITESP+"' "
	c_UpdQry += "	,ZZR_TITENG	= '"+ZZR->ZZR_TITENG+"' "
	c_UpdQry += "	,ZZR_DACE01	= '"+ZZR->ZZR_DACE01+"' "
	c_UpdQry += "	,ZZR_DACE02	= '"+ZZR->ZZR_DACE02+"' "
	c_UpdQry += "	,ZZR_DACE03	= '"+ZZR->ZZR_DACE03+"' "
	c_UpdQry += "	,ZZR_DACE04	= '"+ZZR->ZZR_DACE04+"' "
	c_UpdQry += "	,ZZR_DACE05	= '"+ZZR->ZZR_DACE05+"' "
	c_UpdQry += "	,ZZR_DACE06	= '"+ZZR->ZZR_DACE06+"' "
	c_UpdQry += "	,ZZR_DACE07	= '"+ZZR->ZZR_DACE07+"' "
	c_UpdQry += "	,ZZR_DACE08	= '"+ZZR->ZZR_DACE08+"' "
	c_UpdQry += "	,ZZR_DACE09	= '"+ZZR->ZZR_DACE09+"' "
	c_UpdQry += "	,ZZR_DACE10	= '"+ZZR->ZZR_DACE10+"' "
	c_UpdQry += "WHERE ZZR_FILIAL = '"+ZZR->ZZR_FILIAL+"' "
	c_UpdQry += "AND ZZR_FUNCAO = '"+c_NomFunc+"' "
	c_UpdQry += "AND R_E_C_N_O_ NOT IN ("+AllTrim(Str(ZZR->(Recno())))+") "
	c_UpdQry += "AND D_E_L_E_T_ = ' ' "
	
	TcSqlExec(c_UpdQry)
	
	CursorArrow()
	
Endif

Return Nil
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณ Descricao                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบfExclui   ณ Exclui o item ou o grupo do menu.                          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function fExclui()

Local c_Chave 		:= AllTrim(ZZR->ZZR_CHAVE)
Local c_Grupo 		:= AllTrim(ZZR->ZZR_TITPOR)
Local c_Modulo 		:= AllTrim(ZZR->ZZR_MODULO)
Local c_UpdQry 		:= ""
Local l_UpdOK		:= .F.
Local a_MenuFile	:= {}
Local c_MenuPath	:= ""
Local c_MenuFile	:= ""
Local n_Files		:= 0

If Len(c_Chave) == 1
	If MsgYesNo("Nใo ้ possํvel excluir um grupo de nํvel 1. "+;
		"O menu completo do m๓dulo "+c_Modulo+" serแ excluํdo."+Chr(13)+Chr(10)+Chr(13)+Chr(10)+;
		"Deseja Continuar?", "ATENวรO")
		Begin Transaction
		
		c_UpdQry := "UPDATE "+RetSqlName("ZZR")+" SET D_E_L_E_T_ = '*' WHERE ZZR_FILIAL = '"+xFilial("ZZR")+"' AND ZZR_MODULO = '"+c_Modulo+"' AND D_E_L_E_T_ = ' '"
		TcSqlExec(c_UpdQry)
		c_UpdQry := "UPDATE "+RetSqlName("ZZS")+" SET D_E_L_E_T_ = '*' WHERE ZZS_FILIAL = '"+xFilial("ZZS")+"' AND ZZS_MODULO = '"+c_Modulo+"' AND D_E_L_E_T_ = ' '"
		TcSqlExec(c_UpdQry)
		
		c_MenuPath	:= AllTrim(GetMV("MV_XPATMNU"))
		a_MenuFile 	:= Directory(c_MenuPath+Alltrim(SubStr(c_Modulo, 5))+"*.xnu")
		
		//Renomeio os menus dos usuarios
		For n_Files := 1 To Len(a_MenuFile)
			
			c_MenuFile := Left(a_MenuFile[n_Files,1], Len(a_MenuFile[n_Files,1])-4)
			fRename(c_MenuPath+c_MenuFile+".xnu", c_MenuPath+c_MenuFile+".###")
			
		Next n_Files
		
		//Renomeio o menu do Administrador
		c_MenuFile := Alltrim(c_Modulo)
		fRename(c_MenuPath+c_MenuFile+".xnu", c_MenuPath+c_MenuFile+".###")
		
		End Transaction
	Endif
ElseIf AllTrim(ZZR->ZZR_FUNCAO) == ""
	If MsgYesNo("Deseja excluir o grupo ["+c_Grupo+"] e todos os grupos/itens que estใo abaixo dele?", "I N C O N S I S T ส N C I A")
		
		a_AreaZZR := ZZR->(GetArea())
		
		DbSelectArea("ZZR")
		
		n_TamChave := Len(c_Chave)
		
		Begin Transaction
		l_UpdOK := .T.
		While ZZR->(!Eof()) .And. xFilial("ZZR")+c_Chave == ZZR->ZZR_FILIAL+Left(ZZR->ZZR_CHAVE, n_TamChave)
			fDelZZS()
			RecLock("ZZR", .F.)
			DbDelete()
			MsUnLock()
			ZZR->(DbSkip())
		Enddo
		
		MsgRun("Reordenando a chave. Por favor, aguarde...", "TreeKey", {|| U_OrdTreeKey(c_Modulo) })
		
		End Transaction
		
		RestArea(a_AreaZZR)
		MsgInfo("O grupo ["+c_Grupo+"] e todos os seus sub-grupos/fun็๕es foram excluํdas.", "Exclusใo Ok!")
		
	Endif
Else
	If MsgYesNo("Confirma a exclusใo da fun็ใo ["+AllTrim(ZZR->ZZR_FUNCAO)+" - "+AllTrim(ZZR->ZZR_TITPOR)+"]?", "C O N F I R M A ว ร O")
		Begin Transaction
		l_UpdOK := .T.
		fDelZZS()
		RecLock("ZZR", .F.)
		DbDelete()
		MsUnLock()
		MsgRun("Reordenando a chave. Por favor, aguarde...", "TreeKey", {|| U_OrdTreeKey(c_Modulo) })
		End Transaction
	Endif
Endif

If l_UpdOK
	c_Mens := "Gere o arquivo de menu do m๓dulo ["+c_Modulo+"]. "
	c_Mens += "Gere novamente tamb้m os menus dos "+IIF(l_GrpMenu, "grupos", "usuแrios")+" que tem acesso ao m๓dulo ["+c_Modulo+"]."
	MsgAlert(c_Mens, "L E I A   C O M   A T E N ว ร O")
Endif

Return Nil
Static Function fDelZZS()

Local c_UpdQry := ""

c_UpdQry += "UPDATE "+RetSqlName("ZZS")+" "
c_UpdQry += "SET D_E_L_E_T_ = '*' "
c_UpdQry += "WHERE ZZS_FILIAL = '"+ZZR->ZZR_FILIAL+"' "
c_UpdQry += "AND ZZS_MODULO = '"+ZZR->ZZR_MODULO+"' "
c_UpdQry += "AND ZZS_FUNCAO = '"+ZZR->ZZR_FUNCAO+"' "
c_UpdQry += "AND D_E_L_E_T_ = ' ' "

TcSqlExec(c_UpdQry)

Return Nil
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณ Descricao                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบfImpMatrizณ Importar os arquivos de menu (xnu) para a tabela ZZR.      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function fImpMatriz()

Local c_Perg	:= "MYXMNU1000"
Local a_Xnu 	:= {}
Local l_ImpOK 	:= .F.
Local n_ArqImp	:= 0

ValidPerg(c_Perg)

If !Pergunte(c_Perg, .T.)
	Return Nil
Endif

Private a_Diret := Directory(AllTrim(MV_PAR01)+Alltrim(MV_PAR02)+".xnu")

n_QtdArq := Len(a_Diret)

For n_Files := 1 To n_QtdArq

	l_ImpOK := .F.
	
	c_Path	:= AllTrim(MV_PAR01)
	c_Arq	:= a_Diret[n_Files,1]
	
	Processa({|| l_ImpOK := LeArquivo(c_Path, c_Arq) },"Arquivo" + Str(n_Files,2) + " de " + Str(n_QtdArq,2) + " - " + c_Path + c_Arq)
	
	If l_ImpOK
		n_ArqImp++
	Endif
	
Next n_Files

If n_ArqImp == 0
	MsgAlert("ATENวยO.: Nenhum arquivo de menu foi importado.", "Nใo Importou")
Else
	MsgInfo("Arquivo(s) Importado(s).: "+StrZero(n_ArqImp, 2), "Resumo")
Endif

Return Nil
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณ Descricao                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบLeArquivo ณ Ler o arquivo *.xnu informado atraves dos parametros e gra-บฑฑ
ฑฑบ          ณ var os registros na tabela ZZR.                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ c_Path   ==> Local onde encontra-se o arquivo XNU.         บฑฑ
ฑฑบ          ณ c_File   ==> Nome do arquivo XNU. Sem sua extensao.        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function LeArquivo(c_Path, c_File)

Local c_NomMod 	:= Space(10)
Local c_Mod		:= ""
Local c_File	:= AllTrim(c_File)
Local l_Aceitou	:= .F.
Local l_Continua:= .T.
Local c_QryUpd	:= ""

Private l_TemBuraco	:= .F.

c_File	:= Left(c_File, Len(c_File) - 4)

a_Xnu := XNULoad(c_Path+c_File+".xnu")

If Len(a_Xnu) == 0
	MsgStop("Arquivo(s) nใo localizado(s). Verifique os parโmetros.", "Importa็ใo cancelada.")
	Return .F.
Endif

If Left(c_File, 4) <> "SIGA"
	MsgStop("Arquivo de menu invแlido. S๓ serแ permitida a importa็ใo dos menus padr๕es da microsiga. Ex.: SIGAFAT.xnu ou SIGALOJA.xnu", "Importa็ใo cancelada.")
	Return .F.
Endif

a_RetMod := RetModName()

aAdd(a_RetMod, {99, "SIGACFG", "Configurador", .T.})

n_Pos := aScan(a_RetMod, {|x| Upper(AllTrim(x[2])) == Upper(AllTrim(c_File))})

If n_Pos == 0
	MsgStop("M๓dulo ["+AllTrim(c_File)+"] nใo localizado.", "Inconsist๊ncia")
	Return .F.
Endif

c_NumMod := StrZero(a_RetMod[n_Pos][1], 2)
c_NomMod := a_RetMod[n_Pos][2]+Replicate(" ", 10 - Len(a_RetMod[n_Pos][2]))
c_TitMod := a_RetMod[n_Pos][3]

DbSelectArea("ZZR")
DbSetOrder(1) //ZZR_FILIAL, ZZR_MODULO, ZZR_CHAVE, R_E_C_N_O_, D_E_L_E_T_
If DbSeek(xFilial("ZZR") + c_NomMod, .F.)
	MsgAlert("Jแ existem registros cadastrados para o m๓dulo "+c_NomMod+".", "Importa็ใo Cancelada")
	Return .F.
Endif

ProcRegua(Len(a_Xnu))

Begin Transaction

For n_N1 := 1 To Len(a_Xnu)
	
	c_Chave	 := StrZero(n_N1,1)
	c_TitPor := a_Xnu[n_N1][1][1]
	c_TitEsp := a_Xnu[n_N1][1][2]
	c_TitEng := a_Xnu[n_N1][1][3]
	
	IncProc("Gravando...: "+c_TitPor)
	
	fGrvMnu(c_NumMod, c_NomMod, c_TitMod, c_Chave, c_TitPor,;
	c_TitEsp, c_TitEng, "", "", "", "", .F.)
	
	For n_N2 := 1 To Len(a_Xnu[n_N1][3])
		
		If ValType(a_Xnu[n_N1][3][n_N2][3]) == "A"
			
			c_Chave	 := StrZero(n_N1,1)+"."+StrZero(n_N2,2)
			c_TitPor := a_Xnu[n_N1][3][n_N2][1][1]
			c_TitEsp := a_Xnu[n_N1][3][n_N2][1][2]
			c_TitEng := a_Xnu[n_N1][3][n_N2][1][3]
			
			fGrvMnu(c_NumMod, c_NomMod, c_TitMod, c_Chave, c_TitPor,;
			c_TitEsp, c_TitEng, "", "", "", "", .F.)
			
			For n_N3 := 1 To Len(a_Xnu[n_N1][3][n_N2][3])
				
				If ValType(a_Xnu[n_N1][3][n_N2][3][n_N3][3]) == "A"
					
					c_Chave	 := StrZero(n_N1,1)+"."+StrZero(n_N2,2)+"."+StrZero(n_N3,2)
					c_TitPor := a_Xnu[n_N1][3][n_N2][3][n_N3][1][1]
					c_TitEsp := a_Xnu[n_N1][3][n_N2][3][n_N3][1][2]
					c_TitEng := a_Xnu[n_N1][3][n_N2][3][n_N3][1][3]
					
					fGrvMnu(c_NumMod, c_NomMod, c_TitMod, c_Chave, c_TitPor,;
					c_TitEsp, c_TitEng, "", "", "", "", .F.)
					
					For n_N4 := 1 To Len(a_Xnu[n_N1][3][n_N2][3][n_N3][3])
						
						If ValType(a_Xnu[n_N1][3][n_N2][3][n_N3][3][n_N4][3]) == "A"
							
							c_Chave	 := StrZero(n_N1,1)+"."+StrZero(n_N2,2)+"."+StrZero(n_N3,2)
							c_TitPor := a_Xnu[n_N1][3][n_N2][3][n_N3][3][n_N4][1][1]
							c_TitEsp := a_Xnu[n_N1][3][n_N2][3][n_N3][3][n_N4][1][2]
							c_TitEng := a_Xnu[n_N1][3][n_N2][3][n_N3][3][n_N4][1][3]
							
							fGrvMnu(c_NumMod, c_NomMod, c_TitMod, c_Chave, c_TitPor,;
							c_TitEsp, c_TitEng, "", "", "", "", .F.)
							
							For n_N5 := 1 To Len(a_Xnu[n_N1][3][n_N2][3][n_N3][3][n_N4][3])
								
								c_TitPor := a_Xnu[n_N1][3][n_N2][3][n_N3][3][n_N4][3][n_N5][1][1]
								c_TitEsp := a_Xnu[n_N1][3][n_N2][3][n_N3][3][n_N4][3][n_N5][1][2]
								c_TitEng := a_Xnu[n_N1][3][n_N2][3][n_N3][3][n_N4][3][n_N5][1][3]
								
								c_Funcao := a_Xnu[n_N1][3][n_N2][3][n_N3][3][n_N4][3][n_N5][3]
								
								c_Access := a_Xnu[n_N1][3][n_N2][3][n_N3][3][n_N4][3][n_N5][5]
								c_Tipo   := AllTrim(Str(a_Xnu[n_N1][3][n_N2][3][n_N3][3][n_N4][3][n_N5][7]))
								
								c_Tabela := ""
								
								For n_Tabela := 1 To Len(a_Xnu[n_N1][3][n_N2][3][n_N3][3][n_N4][3][n_N5][4])
									
									c_Tabela += a_Xnu[n_N1][3][n_N2][3][n_N3][3][n_N4][3][n_N5][4][n_Tabela]
									
								Next n_Tabela
								
								c_Chave := StrZero(n_N1,1)+"."+StrZero(n_N2,2)+"."+StrZero(n_N3,2)+"."+StrZero(n_N4,2)+"."+StrZero(n_N5,2)
								
								fGrvMnu(c_NumMod, c_NomMod, c_TitMod, c_Chave, c_TitPor,;
								c_TitEsp, c_TitEng, c_Funcao, c_Tipo, c_Tabela, c_Access, .T.)
								
							Next n_N5
							
						Else
							
							c_TitPor := a_Xnu[n_N1][3][n_N2][3][n_N3][3][n_N4][1][1]
							c_TitEsp := a_Xnu[n_N1][3][n_N2][3][n_N3][3][n_N4][1][2]
							c_TitEng := a_Xnu[n_N1][3][n_N2][3][n_N3][3][n_N4][1][3]
							
							c_Funcao := a_Xnu[n_N1][3][n_N2][3][n_N3][3][n_N4][3]
							
							c_Access := a_Xnu[n_N1][3][n_N2][3][n_N3][3][n_N4][5]
							c_Tipo   := AllTrim(Str(a_Xnu[n_N1][3][n_N2][3][n_N3][3][n_N4][7]))
							
							c_Tabela := ""
							
							For n_Tabela := 1 To Len(a_Xnu[n_N1][3][n_N2][3][n_N3][3][n_N4][4])
								
								c_Tabela += a_Xnu[n_N1][3][n_N2][3][n_N3][3][n_N4][4][n_Tabela]
								
							Next n_Tabela
							
							c_Chave := StrZero(n_N1,1)+"."+StrZero(n_N2,2)+"."+StrZero(n_N3,2)+"."+StrZero(n_N4,2)
							
							l_Continua := fGrvMnu(c_NumMod, c_NomMod, c_TitMod, c_Chave, c_TitPor,;
							c_TitEsp, c_TitEng, c_Funcao, c_Tipo, c_Tabela, c_Access, .T.)
							
						Endif
						If !l_Continua
							Exit
						Endif
					Next n_N4
					
				Else
					
					c_TitPor := a_Xnu[n_N1][3][n_N2][3][n_N3][1][1]
					c_TitEsp := a_Xnu[n_N1][3][n_N2][3][n_N3][1][2]
					c_TitEng := a_Xnu[n_N1][3][n_N2][3][n_N3][1][3]
					
					c_Funcao := a_Xnu[n_N1][3][n_N2][3][n_N3][3]
					
					c_Access := a_Xnu[n_N1][3][n_N2][3][n_N3][5]
					c_Tipo   := AllTrim(Str(a_Xnu[n_N1][3][n_N2][3][n_N3][7]))
					
					c_Tabela := ""
					
					For n_Tabela := 1 To Len(a_Xnu[n_N1][3][n_N2][3][n_N3][4])
						
						c_Tabela += a_Xnu[n_N1][3][n_N2][3][n_N3][4][n_Tabela]
						
					Next n_Tabela
					
					c_Chave := StrZero(n_N1,1)+"."+StrZero(n_N2,2)+"."+StrZero(n_N3,2)
					
					l_Continua := fGrvMnu(c_NumMod, c_NomMod, c_TitMod, c_Chave, c_TitPor,;
					c_TitEsp, c_TitEng, c_Funcao, c_Tipo, c_Tabela, c_Access, .T.)
					
				Endif
				
				If !l_Continua
					Exit
				Endif
				
			Next n_N3
			
		Else
			
			c_TitPor := a_Xnu[n_N1][3][n_N2][1][1]
			c_TitEsp := a_Xnu[n_N1][3][n_N2][1][2]
			c_TitEng := a_Xnu[n_N1][3][n_N2][1][3]
			
			c_Funcao := a_Xnu[n_N1][3][n_N2][3]
			
			c_Access := a_Xnu[n_N1][3][n_N2][5]
			c_Tipo   := AllTrim(Str(a_Xnu[n_N1][3][n_N2][7]))
			
			c_Tabela := ""
			
			For n_Tabela := 1 To Len(a_Xnu[n_N1][3][n_N2][4])
				
				c_Tabela += a_Xnu[n_N1][3][n_N2][4][n_Tabela]
				
			Next n_Tabela
			
			c_Chave := StrZero(n_N1,1)+"."+StrZero(n_N2,2)
			
			l_Continua := fGrvMnu(c_NumMod, c_NomMod, c_TitMod, c_Chave, c_TitPor,;
			c_TitEsp, c_TitEng, c_Funcao, c_Tipo, c_Tabela, c_Access, .T.)
			
		Endif
		
		If !l_Continua
			Exit
		Endif
		
	Next n_N2
	
	If !l_Continua
		Exit
	Endif
	
Next n_N1

End Transaction

If !l_Continua
	c_QryUpd := "UPDATE "+RetSqlName("ZZR")+" SET D_E_L_E_T_ = '*' WHERE ZZR_FILIAL = '"+xFilial("ZZR")+"' AND ZZR_MODULO = '"+c_NomMod+"' AND D_E_L_E_T_ = ' ' "
	TcSqlExec(c_QryUpd)
	MsgStop("Nใo foi possํvel importar o menu do m๓dulo "+AllTrim(c_NomMod)+", pois existem fun็๕es duplicadas nesse menu.", "ATENวรO")
Else
	If l_TemBuraco //Refaz TreeKey
		MsgRun("Reordenando a chave. Por favor, aguarde...", "TreeKey", {|| U_OrdTreeKey(c_NomMod) })
	Endif
	DbSelectArea("ZZR")
	DbSetOrder(1)
	DbGoTop()
	DbSeek(xFilial("ZZR")+c_NomMod, .T.)
Endif

Return .T.
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณ Descricao                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบfGrvMnu   ณ Gravar os dados no arquivo ZZR.                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ c_NumMod ==> Numero (ID) do modulo.                        บฑฑ
ฑฑบ          ณ c_NomMod ==> Nome simplificado do Modulo. Ex.: SIGAFAT     บฑฑ
ฑฑบ          ณ c_TitMod ==> Nome completo do modulo.                      บฑฑ
ฑฑบ          ณ c_Chave  ==> Chave sequencial utilizada para ordenar o menuบฑฑ
ฑฑบ          ณ c_TitPor ==> Titulo em portugues do item do menu.          บฑฑ
ฑฑบ          ณ c_TitEsp ==> Titulo em espanhol do item do menu.           บฑฑ
ฑฑบ          ณ c_TitEng ==> Titulo em ingles do item do menu.             บฑฑ
ฑฑบ          ณ c_Funcao ==> Nome da funcao a ser executada no menu.       บฑฑ
ฑฑบ          ณ c_Tipo   ==> Tipo da funcao. Ex.: 1=Protheus; 3=Usuario.   บฑฑ
ฑฑบ          ณ c_Tabela ==> Tabelas que devem ser abertas pela funcao.    บฑฑ
ฑฑบ          ณ l_ADAces ==> Inclui as descricoes padroes de acessos       บฑฑ
ฑฑบ          ณ c_Access ==> Acessos aos itens das funcoes.                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function fGrvMnu(c_NumMod, c_NomMod, c_TitMod, c_Chave, c_TitPor,;
c_TitEsp, c_TitEng, c_Funcao, c_Tipo, c_Tabela, c_Access, l_DescAces)

Local l_Ok 			:= .T.
Local c_FuncSeek	:= c_Funcao + Replicate(" ", 10 - Len(c_Funcao))

DbSelectArea("ZZR")
DbSetOrder(3) //ZZR_FILIAL, ZZR_FUNCAO, ZZR_MODULO, R_E_C_N_O_, D_E_L_E_T_
If AllTrim(c_Funcao) <> "" .And. DbSeek(xFilial("ZZR")+c_FuncSeek+c_NomMod, .F.)
	//		RollBackDelTran("A Func็ใo "+AllTrim(c_Funcao)+" jแ foi cadastrada para o menu do m๓dulo "+AllTrim(c_NomMod)+".")
	If !MsgYesNo("A Fun็ใo "+AllTrim(c_Funcao)+" jแ foi cadastrada para o menu do m๓dulo "+AllTrim(c_NomMod)+". Deseja saltแ-la?", "Fun็ใo Duplicada")
		l_Ok := .F.
	Else
		l_TemBuraco := .T.
	Endif
Else
	RecLock("ZZR", .T.)
	ZZR->ZZR_NUMMOD	:= c_NumMod
	ZZR->ZZR_MODULO	:= c_NomMod
	ZZR->ZZR_TITMOD	:= c_TitMod
	ZZR->ZZR_CHAVE	:= c_Chave
	ZZR->ZZR_TITPOR	:= c_TitPor
	ZZR->ZZR_TITESP	:= c_TitEsp
	ZZR->ZZR_TITENG	:= c_TitEng
	ZZR->ZZR_FUNCAO	:= c_Funcao
	ZZR->ZZR_TIPO	:= c_Tipo
	ZZR->ZZR_TABELA	:= c_Tabela
	ZZR->ZZR_ACESSO	:= c_Access
	If l_DescAces
		ZZR->ZZR_DACE01	:= "PESQUISA"
		ZZR->ZZR_LACE01	:= .T.
		ZZR->ZZR_DACE02	:= "VISUALIZA"
		ZZR->ZZR_LACE02	:= .T.
		ZZR->ZZR_DACE03	:= "INCLUI"
		ZZR->ZZR_LACE03	:= .T.
		ZZR->ZZR_DACE04	:= "ALTERA"
		ZZR->ZZR_LACE04	:= .T.
		ZZR->ZZR_DACE05	:= "EXCLUI"
		ZZR->ZZR_LACE05	:= .T.
		ZZR->ZZR_DACE06	:= "A DEFINIR"
		ZZR->ZZR_LACE06	:= .T.
		ZZR->ZZR_DACE07	:= "A DEFINIR"
		ZZR->ZZR_LACE07	:= .T.
		ZZR->ZZR_DACE08	:= "A DEFINIR"
		ZZR->ZZR_LACE08	:= .T.
		ZZR->ZZR_DACE09	:= "A DEFINIR"
		ZZR->ZZR_LACE09	:= .T.
		ZZR->ZZR_DACE10	:= "A DEFINIR"
		ZZR->ZZR_LACE10	:= .T.
	Endif
	MsUnLock()
Endif

Return l_Ok
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณ Descricao                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบfExpoXnu  ณ Copia as configuracoes do usuario posicionado para os sele-บฑฑ
ฑฑบ          ณ cionados.                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function fExpoXnu()

Local aSalvAmb 	:= GetArea()
Local cVar     	:= Nil
Local cVar1    	:= Nil
Local oDlg     	:= Nil
Local cTitulo  	:= "Replica็ใo dos itens do menu principal p/ os "+IIF(l_GrpMenu, "grupos", "usuแrios")+"."
Local lMark    	:= .F.
Local oOk      	:= LoadBitmap( GetResources(), "LBOK" )
Local oNo      	:= LoadBitmap( GetResources(), "LBNO" )
Local n_Bnt    	:= 0
Local c_Query 	:= ""

Private oLbx 	:= Nil
Private aVetMod	:= {}
Private oLbx1 	:= Nil
Private aVetUsr	:= {}

c_Query := "SELECT DISTINCT ZZR_MODULO, ZZR_TITMOD FROM "+RetSqlName("ZZR")+" "
c_Query += "WHERE D_E_L_E_T_ = ' ' "
c_Query += "ORDER BY ZZR_MODULO"

If Select("QRY") > 0
	QRY->(DbCloseArea())
Endif

TCQUERY c_Query NEW ALIAS "QRY"

//+-------------------------------------+
//| Carrega o vetor conforme a condicao |
//+-------------------------------------+
While QRY->(!Eof())
	
	aAdd( aVetMod, { .F.,;
	QRY->ZZR_MODULO,;
	QRY->ZZR_TITMOD})
	
	QRY->(DbSkip())
Enddo

If l_GrpMenu
	a_UserTemp := AllGroups()
	For i := 2 To Len(a_UserTemp)
		
		aAdd( aVetUsr, { .F.,;
		a_UserTemp[i][1][2]})
		
	Next i
	aVetUsr := aSort(aVetUsr,,,{ |x,y| x[2] < y[2] } )
Else
	a_UserTemp := AllUsers()
	For i := 2 To Len(a_UserTemp)
		
		If !a_UserTemp[i][1][17]
			
			aAdd( aVetUsr, { .F.,;
			a_UserTemp[i][1][2],;
			a_UserTemp[i][1][4],;
			a_UserTemp[i][1][12]})
			
		Endif
		
	Next i
	aVetUsr := aSort(aVetUsr,,,{ |x,y| x[3] < y[3] } )
Endif

If Len(aVetUsr) == 0
	MsgStop("Nenhum "+IIF(l_GrpMenu, "Grupo", "Usuแrio")+" foi localizado. Verifique o cadastro.", "Inconsist๊ncia")
Else
	//+-----------------------------------------------+
	//| Monta a tela para usuario visualizar consulta |
	//+-----------------------------------------------+
	
	DEFINE MSDIALOG oDlg TITLE cTitulo FROM 000,000 TO 240,500 PIXEL
	
	@ 003,010 SAY OemToAnsi("Este programa irแ replicar as fun็๕es dos m๓dulos selecionados para os "+IIF(l_GrpMenu, "grupos", "usuแrios")+" selecionados.") Size 250,050 COLOR CLR_RED OF oDlg PIXEL
	@ 010,010 SAY OemToAnsi("Caso a fun็ใo jแ esteja cadastrada(ZZS-Menus Usuแrios), nenhuma altera็ใo serแ realizada.") Size 250,050 COLOR CLR_RED OF oDlg PIXEL
	
	@ 020,010 LISTBOX oLbx VAR cVar FIELDS HEADER " ",;
	"M๓dulo",;
	"Descri็ใo" SIZE 090,085 OF oDlg PIXEL ;
	ON dblClick( Inverter(@aVetMod, @oLbx),oLbx:Refresh(.F.) )
	
	oLbx:SetArray( aVetMod )
	oLbx:bLine := {|| {Iif(aVetMod[oLbx:nAt,1],oOk,oNo),;
	aVetMod[oLbx:nAt,2],;
	aVetMod[oLbx:nAt,3]}}
	
	If l_GrpMenu
		@ 020,105 LISTBOX oLbx1 VAR cVar1 FIELDS HEADER " ",;
		"Grupo" SIZE 135,085 OF oDlg PIXEL ;
		ON dblClick( Inverter(@aVetUsr, @oLbx1),oLbx1:Refresh(.F.) )
		
		oLbx1:SetArray( aVetUsr )
		oLbx1:bLine := {|| {Iif(aVetUsr[oLbx1:nAt,1],oOk,oNo),;
		aVetUsr[oLbx1:nAt,2]}}
	Else
		@ 020,105 LISTBOX oLbx1 VAR cVar1 FIELDS HEADER " ",;
		"Login",;
		"Nome",;
		"Departamento" SIZE 135,085 OF oDlg PIXEL ;
		ON dblClick( Inverter(@aVetUsr, @oLbx1),oLbx1:Refresh(.F.) )
		
		oLbx1:SetArray( aVetUsr )
		oLbx1:bLine := {|| {Iif(aVetUsr[oLbx1:nAt,1],oOk,oNo),;
		aVetUsr[oLbx1:nAt,2],;
		aVetUsr[oLbx1:nAt,3],;
		aVetUsr[oLbx1:nAt,4]}}
	Endif
	
	DEFINE SBUTTON FROM 107,180 TYPE 1 ACTION (n_Bnt:=1,oDlg:End()) ENABLE OF oDlg
	DEFINE SBUTTON FROM 107,213 TYPE 2 ACTION oDlg:End() ENABLE OF oDlg
	ACTIVATE MSDIALOG oDlg CENTERED
	
	If n_Bnt == 1
		
		l_Gerou := .F.
		
		Processa({|| l_Gerou := fGrvZZS(aVetMod, aVetUsr) },"Atualizando Fun็๕es - Menu "+IIF(l_GrpMenu, "Grupo", "Usuแrio")+".")
		
		If l_Gerou
			MsgInfo("Exporta็ใo dos itens realizada com sucesso!", "Processo OK!")
		Else
			MsgStop("Nenhum registro foi copiado.", "Nใo Gerou!")
		Endif
		
	Endif
	
	RestArea( aSalvAmb )
	DeleteObject(oOk)
	DeleteObject(oNo)
	
Endif

Return Nil
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
ฑฑบfGrvZZS   ณ Gravar os itens do menu na tabela ZZS (Menu usuario)       บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ a_Modulo  ==> Array com os Modulos.                        บฑฑ
ฑฑบ          ณ a_Usr     ==> Array com os usuarios/Grupos.                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function fGrvZZS(a_Modulo, a_Usr)

Local c_Modulo 	:= "("
Local c_Query 	:= ""
Local c_EOL 	:= CHR(13)
Local l_Ret 	:= .F.

For n_Cont := 1 To Len(a_Modulo)
	
	If a_Modulo[n_Cont][1]
		c_Modulo += "'"+AllTrim(a_Modulo[n_Cont][2])+"',"
	Endif
	
Next n_Cont

c_Modulo := Left(c_Modulo, Len(c_Modulo) - 1) + ")"

c_Query := "SELECT * FROM "+RetSqlName("ZZR")+" "+c_EOL
c_Query += "WHERE ZZR_FILIAL = '  '"+c_EOL
c_Query += "AND ZZR_MODULO IN "+c_Modulo+" "+c_EOL
//c_Query += "AND ZZR_FUNCAO <> ''"+c_EOL
c_Query += "AND D_E_L_E_T_ = ' '"+c_EOL

c_QryTop := "SELECT ISNULL(COUNT(*), 0) AS QTDREG FROM ("+c_Query+") as RESULT"

If Select("QRY") > 0
	QRY->(DbCloseArea())
Endif

TCQUERY c_QryTop NEW ALIAS "QRY"

n_QtdTot := QRY->QTDREG

If n_QtdTot <> 0
	
	ProcRegua(n_QtdTot)
	
	l_Ret := .T.
	
	If Select("QRY") > 0
		QRY->(DbCloseArea())
	Endif
	
	TCQUERY c_Query NEW ALIAS "QRY"
	
	TcSetField("QRY", "ZZR_FUNCAO", "C", 10, 0)
	TcSetField("QRY", "ZZR_MODULO", "C", 10, 0)
	
	i := 0
	
	While QRY->(!Eof())
		
		i++
		IncProc("Atualizando...: "+Str((i / n_QtdTot) * 100, 3)+" %")
		
		DbSelectArea("ZZS")
		DbSetOrder(3) //ZZS_FILIAL, ZZS_MODULO, ZZS_USER, ZZS_CHAVE, ZZS_FUNCAO, R_E_C_N_O_, D_E_L_E_T_
//		DbSetOrder(1)//ZZS_FILIAL, ZZS_USER, ZZS_FUNCAO, ZZS_MODULO, R_E_C_N_O_, D_E_L_E_T_
					//   2           15          10         10
		
		For n_Usuario := 1 To Len(a_Usr)
			
			If a_Usr[n_Usuario][1]
				If !DbSeek("  "+QRY->(ZZR_MODULO)+SubStr(a_Usr[n_Usuario][2],1,15)+QRY->ZZR_CHAVE, .F.)
					RecLock("ZZS", .T.)
					ZZS->ZZS_USER 	:= a_Usr[n_Usuario][2]
					ZZS->ZZS_FUNCAO	:= QRY->ZZR_FUNCAO
					ZZS->ZZS_TITULO	:= QRY->ZZR_TITPOR
					ZZS->ZZS_CHAVE	:= QRY->ZZR_CHAVE
					ZZS->ZZS_MODULO	:= QRY->ZZR_MODULO
					ZZS->ZZS_STATUS	:= "I"
					ZZS->ZZS_ACESSO	:= Space(10)
					ZZS->ZZS_DACE01	:= QRY->ZZR_DACE01
					ZZS->ZZS_LACE01	:= .F.
					ZZS->ZZS_DACE02	:= QRY->ZZR_DACE02
					ZZS->ZZS_LACE02	:= .F.
					ZZS->ZZS_DACE03	:= QRY->ZZR_DACE03
					ZZS->ZZS_LACE03	:= .F.
					ZZS->ZZS_DACE04	:= QRY->ZZR_DACE04
					ZZS->ZZS_LACE04	:= .F.
					ZZS->ZZS_DACE05	:= QRY->ZZR_DACE05
					ZZS->ZZS_LACE05	:= .F.
					ZZS->ZZS_DACE06	:= QRY->ZZR_DACE06
					ZZS->ZZS_LACE06	:= .F.
					ZZS->ZZS_DACE07	:= QRY->ZZR_DACE07
					ZZS->ZZS_LACE07	:= .F.
					ZZS->ZZS_DACE08	:= QRY->ZZR_DACE08
					ZZS->ZZS_LACE08	:= .F.
					ZZS->ZZS_DACE09	:= QRY->ZZR_DACE09
					ZZS->ZZS_LACE09	:= .F.
					ZZS->ZZS_DACE10	:= QRY->ZZR_DACE10
					ZZS->ZZS_LACE10	:= .F.
					MsUnLock()
				Else
					RecLock("ZZS", .F.)
					ZZS->ZZS_CHAVE	:= QRY->ZZR_CHAVE
					ZZS->ZZS_FUNCAO	:= QRY->ZZR_FUNCAO
					ZZS->ZZS_TITULO	:= QRY->ZZR_TITPOR
					ZZS->ZZS_CHAVE	:= QRY->ZZR_CHAVE
					ZZS->ZZS_MODULO	:= QRY->ZZR_MODULO
					MsUnLock()
				Endif
			Endif
			
		Next n_Usuario
		
		QRY->(DbSkip())
	Enddo
	
Endif

Return l_Ret
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณ Descricao                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบfGeraXnu  ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function fGeraXnu()

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
c_Query += "WHERE ZZR_FILIAL = '"+xFilial("ZZR")+"' "
c_Query += "AND D_E_L_E_T_ = ' ' "
c_Query += "ORDER BY ZZR_MODULO "

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
	Aviso( cTitulo, "Nao existem m๓dulos a consultar", {"Ok"} )
	Return Nil
Endif

DEFINE MSDIALOG oDlg TITLE cTitulo FROM 000,000 TO 240,500 PIXEL

@ 003,010 SAY OemToAnsi("Este programa irแ gerar os menus para o Administrador conforme os m๓dulos selecionados") Size 250,050 COLOR CLR_RED OF oDlg PIXEL
@ 010,010 SAY OemToAnsi("abaixo.") Size 250,050 COLOR CLR_RED OF oDlg PIXEL

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
	
	Processa({|| l_Gerou := fGerMenu(aVetor) },"Gerando menu(s) do Administrador.")
	
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
Static Function fGerMenu(a_Mod)

Local l_Gerou := .F.
Local c_NomMenu	:= ""

ProcRegua(Len(a_Mod))

For n_Mod := 1 To Len(a_Mod)
	If a_Mod[n_Mod][1]
		IncProc("M๓dulo ...: "+a_Mod[n_Mod][2])
		U_germnu(.T., a_Mod[n_Mod][2], "", AllTrim(a_Mod[n_Mod][2]))
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
ฑฑบgermnu  ณ Gerar o arquivo de menu (xnu) principal ou do usuario.     บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametro ณ l_AdmMnu   => .T. eh o menu principal.                     บฑฑ
ฑฑบ          ณ            => .F. eh o menu do usuario.                    บฑฑ
ฑฑบ          ณ cModulo    => Ex.: SIGAFAT, SIGAFIN, SIGACTB, etc...       บฑฑ
ฑฑบ          ณ cUsuario   => login de acesso do usuario/Grupo do usuario. บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function germnu(l_AdmMnu, cModulo, cUsuario, c_NomMenu)

#define CRLF Chr(13)+Chr(10)
Local c_Status		:= ""

Private c_Modulo  	:= AllTrim(cModulo)
Private c_Usuario 	:= cUsuario
Private c_Arquivo 	:= GetMV("MV_XPATMNU")+c_NomMenu
Private c_Tab		:= Chr(9)
Private c_UltChave	:= ""
Private c_Chave		:= ""
Private c_EnableNiv	:= ""
Private l_TableSAH	:= .F.

//cria backup do arquivo
fErase(c_Arquivo+".#03")
fRename(c_Arquivo+".#02", c_Arquivo+".#03")
fRename(c_Arquivo+".#01", c_Arquivo+".#02")
fRename(c_Arquivo+".XNU", c_Arquivo+".#01")

c_Arquivo := c_Arquivo+".XNU"

//cria e verifica se houve sucesso
nHdl := fCreate(c_Arquivo)
If nHdl < 0
	MsgAlert("Nใo foi possํvel criar o arquivo "+c_Arquivo+" .","Aten็ใo")
Else
	
	If !l_AdmMnu
		
		c_Query := "SELECT LEFT(ZZS_CHAVE, LEN(ZZS_CHAVE) - 3) AS ZZS_CHAVE FROM "+RetSqlName("ZZS")+" "+CRLF
		c_Query += "WHERE D_E_L_E_T_ = ' ' "+CRLF
		c_Query += "AND ZZS_MODULO = '"+c_Modulo+"' "+CRLF
		c_Query += "AND ZZS_USER = '"+c_Usuario+"' "+CRLF
		c_Query += "AND ZZS_STATUS <> 'I' "+CRLF
		c_Query += "AND LEN(ZZS_CHAVE) > 3"+CRLF
		c_Query += "GROUP BY LEFT(ZZS_CHAVE, LEN(ZZS_CHAVE) - 3) "+CRLF
		
		If Select("QRYDIS") > 0
			QRYDIS->(DbCloseArea())
		Endif
		
		TCQUERY c_Query NEW ALIAS "QRYDIS"
		
		While QRYDIS->(!Eof())
			If !(AllTrim(QRYDIS->ZZS_CHAVE) $ c_EnableNiv)
				c_EnableNiv += AllTrim(QRYDIS->ZZS_CHAVE) + "#"
			Endif
			QRYDIS->(DbSkip())
		Enddo
		
		QRYDIS->(DbCloseArea())
		
	Endif
	
	FWrite( nHdl, '<ApMenu>' + CRLF )
	FWrite( nHdl, c_Tab + '<DocumentProperties>' + CRLF )
	FWrite( nHdl, c_Tab + c_Tab + '<Module>'+c_Modulo+'</Module>' + CRLF )
	FWrite( nHdl, c_Tab + c_Tab + '<Version>8.11</Version>' + CRLF )
	FWrite( nHdl, c_Tab + '</DocumentProperties>' + CRLF )
	
	DbSelectArea("ZZR")
	DbSetOrder(1) //ZZR_FILIAL, ZZR_MODULO, ZZR_CHAVE
	DbSeek(xFilial("ZZR")+c_Modulo, .F.)
	
	c_Condicao := 'ZZR->(!Eof()) .And. ZZR->(ZZR_FILIAL+AllTrim(ZZR_MODULO)) == xFilial("ZZR")+c_Modulo'
	
	While &(c_Condicao)
		
		c_Nv1 	 := AllTrim(ZZR->ZZR_CHAVE)
		n_TamNv1 := Len(c_Nv1)
		
		FWrite( nHdl, c_Tab + '<Menu Status="Enable">' + CRLF )
		FWrite( nHdl, c_Tab + '<Title lang="pt">' + Capital(AllTrim(ZZR->ZZR_TITPOR)) + '</Title>' + CRLF )
		FWrite( nHdl, c_Tab + '<Title lang="es">' + Capital(AllTrim(ZZR->ZZR_TITESP)) + '</Title>' + CRLF )
		FWrite( nHdl, c_Tab + '<Title lang="en">' + Capital(AllTrim(ZZR->ZZR_TITENG)) + '</Title>' + CRLF )
		
		ZZR->(DbSkip())
		
		While &(c_Condicao) .And. c_Nv1 == Left(ZZR->ZZR_CHAVE, n_TamNv1)
			
			c_Nv2 	 := AllTrim(ZZR->ZZR_CHAVE)
			n_TamNv2 := Len(c_Nv2)
			
			If AllTrim(ZZR->ZZR_FUNCAO) <> ""
				
				fGrvMnuItem(l_AdmMnu, 2)
				
				ZZR->(DbSkip())
				
			Else
				
				c_Status := IIF(l_AdmMnu, "Enable", IIF(AllTrim(ZZR->ZZR_CHAVE)$c_EnableNiv,"Enable","Hidden"))
				
				FWrite( nHdl, c_Tab + c_Tab + '<Menu Status="'+c_Status+'">' + CRLF )
				FWrite( nHdl, c_Tab + c_Tab + '<Title lang="pt">' + Capital(AllTrim(ZZR->ZZR_TITPOR)) + '</Title>' + CRLF )
				FWrite( nHdl, c_Tab + c_Tab + '<Title lang="es">' + Capital(AllTrim(ZZR->ZZR_TITESP)) + '</Title>' + CRLF )
				FWrite( nHdl, c_Tab + c_Tab + '<Title lang="en">' + Capital(AllTrim(ZZR->ZZR_TITENG)) + '</Title>' + CRLF )
				
				ZZR->(DbSkip())
				
				While &(c_Condicao) .And.;
					c_Nv1 == Left(ZZR->ZZR_CHAVE, n_TamNv1) .And.;
					c_Nv2 == Left(ZZR->ZZR_CHAVE, n_TamNv2)
					
					c_Nv3 	 := AllTrim(ZZR->ZZR_CHAVE)
					n_TamNv3 := Len(c_Nv3)
					
					If AllTrim(ZZR->ZZR_FUNCAO) <> ""
						
						fGrvMnuItem(l_AdmMnu, 3)
						
						ZZR->(DbSkip())
						
					Else
						
						c_Status := IIF(l_AdmMnu, "Enable", IIF(AllTrim(ZZR->ZZR_CHAVE)$c_EnableNiv,"Enable","Hidden"))
						
						FWrite( nHdl, c_Tab + c_Tab + c_Tab + '<Menu Status="'+c_Status+'">' + CRLF )
						FWrite( nHdl, c_Tab + c_Tab + c_Tab + '<Title lang="pt">' + Capital(AllTrim(ZZR->ZZR_TITPOR)) + '</Title>' + CRLF )
						FWrite( nHdl, c_Tab + c_Tab + c_Tab + '<Title lang="es">' + Capital(AllTrim(ZZR->ZZR_TITESP)) + '</Title>' + CRLF )
						FWrite( nHdl, c_Tab + c_Tab + c_Tab + '<Title lang="en">' + Capital(AllTrim(ZZR->ZZR_TITENG)) + '</Title>' + CRLF )
						
						ZZR->(DbSkip())
						
						While &(c_Condicao) .And.;
							c_Nv1 == Left(ZZR->ZZR_CHAVE, n_TamNv1) .And.;
							c_Nv2 == Left(ZZR->ZZR_CHAVE, n_TamNv2) .And.;
							c_Nv3 == Left(ZZR->ZZR_CHAVE, n_TamNv3)
							
							If AllTrim(ZZR->ZZR_FUNCAO) <> ""
								
								fGrvMnuItem(l_AdmMnu, 4)
								
							Endif
							
							ZZR->(DbSkip())
							
						Enddo
						
						FWrite( nHdl, c_Tab + c_Tab + c_Tab + '</Menu>' + CRLF )
						
					Endif
					
				Enddo
				
				FWrite( nHdl, c_Tab + c_Tab + '</Menu>' + CRLF )
				
			Endif
			
		Enddo
		
		FWrite( nHdl, c_Tab + '</Menu>' + CRLF )
		
	Enddo
	
	FWrite( nHdl, '</ApMenu>' + CRLF )
	
	Fclose(nHdl)
	
EndIf

Return Nil

Static Function fGrvMnuItem(l_AdmMnu, n_Tab)

Local c_Status := ""

If l_AdmMnu
	c_Status := "H"  //Habilitado
	c_Acesso := ZZR->ZZR_ACESSO
Else
	DbSelectArea("ZZS")
	DbSetOrder(1)
	If DbSeek(xFilial("ZZS")+c_Usuario+ZZR->(ZZR_FUNCAO+ZZR_MODULO), .F.)
		c_Status := ZZS->ZZS_STATUS
		c_Acesso := ZZS->ZZS_ACESSO
	Else
		c_Status := "I" //Inibido
		c_Acesso := ZZR->ZZR_ACESSO
	Endif
Endif

c_Tabulacao := Replicate(c_Tab, n_Tab)

FWrite( nHdl, c_Tabulacao + '<MenuItem Status="'+IIF(c_Status=="D",'Disable',IIF(c_Status=="I",'Hidden','Enable'))+'">' + CRLF )

FWrite( nHdl, c_Tabulacao + '<Title lang="pt">' + Capital(AllTrim(ZZR->ZZR_TITPOR)) + '</Title>' + CRLF )
FWrite( nHdl, c_Tabulacao + '<Title lang="es">' + Capital(AllTrim(ZZR->ZZR_TITESP)) + '</Title>' + CRLF )
FWrite( nHdl, c_Tabulacao + '<Title lang="en">' + Capital(AllTrim(ZZR->ZZR_TITENG)) + '</Title>' + CRLF )

FWrite( nHdl, c_Tabulacao + '	<Function>' + AllTrim(ZZR->ZZR_FUNCAO) + '</Function>' + CRLF )
FWrite( nHdl, c_Tabulacao + '	<Type>' + AllTrim(ZZR->ZZR_TIPO) + '</Type>' + CRLF )

For n_Table := 1 To Len( AllTrim(ZZR->ZZR_TABELA) ) Step 3
	
	c_Tabela := SubStr(ZZR->ZZR_TABELA, n_Table, 3 )
	
	FWrite( nHdl, c_Tabulacao + '	<Tables>' + c_Tabela + '</Tables>' + CRLF )
	
Next n_Table

If !l_TableSAH .And. !(AllTrim(ZZR->ZZR_FUNCAO) $ "LERDA#MPVIEW") .And. c_Status == "H"
	FWrite( nHdl, c_Tabulacao + '	<Tables>SAH</Tables>' + CRLF )
	l_TableSAH := .T.
Endif

FWrite( nHdl, c_Tabulacao + '	<Access>' + c_Acesso + '</Access>' + CRLF )
FWrite( nHdl, c_Tabulacao + '	<Module>' + ZZR->ZZR_NUMMOD + '</Module>' + CRLF )
FWrite( nHdl, c_Tabulacao + '</MenuItem>' + CRLF )

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

If c_Perg == "MYXMNU1000"
	//            Grupo /Ordem /Pergunta             /PERSPA   / PERENG/Variavel/Tipo   /Tamanho  /Decimal/Presel /GSC /Valid/Var01      /Def01      /DEFSPA1 /DEFENG1 /Cnt01 /Var02     /Def02           /DEFSPA2 /DEFENG2 /Cnt02 /Var03     /Def03          /DEFSPA3 /DEFENG3 /Cnt03 /Var04     /Def04          /DEFSPA4 /DEFENG4 /Cnt04 /Var05     /Def05          /DEFSPA5/DEFENG5  /Cnt05 /F3   /PYME/GRPSXG
	aAdd(aRegs,{c_Perg,"01"  ,"Caminho dos menus  ?",""      ,""     ,"MV_CH1","C"    ,20      ,0       ,0     ,"G" ,""    ,"MV_PAR01",""         	,""      ,""      ,""   ,""         ,""            ,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
	aAdd(aRegs,{c_Perg,"02"  ,"Arq. Menu s/ ext.  ?",""      ,""     ,"MV_CH2","C"    ,20      ,0       ,0     ,"G" ,""    ,"MV_PAR02",""		      	,""      ,""      ,""   ,""         ,""				,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
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

User Function fAtuAces(c_Alias)

Local n_Item 	:= 1
Local c_Aces	:= ""

For n_Item := 1 To 10
	
	If &(c_Alias+"->"+c_Alias+"_LACE"+StrZero(n_Item, 2))
		c_Aces += "x"
	Else
		c_Aces += " "
	Endif
	
Next n_Item

DbSelectArea(c_Alias)
RecLock(c_Alias, .F.)
If c_Alias == "ZZR"
	ZZR->ZZR_ACESSO := c_Aces
ElseIf c_Alias == "ZZS"
	ZZS->ZZS_ACESSO := c_Aces
Endif
MsUnLock()

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

User Function ValidZZR()

Local l_Ret 	:= .T.
Local c_ChvFunc	:= GetAdvFVal('ZZR', 'ZZR_CHAVE', xFilial('ZZR')+M->ZZR_FUNCAO+M->ZZR_MODULO, 3, '')

If !Empty(c_ChvFunc) .And. c_ChvFunc <> M->ZZR_CHAVE
	MsgStop("A Func็ใo "+AllTrim(M->ZZR_FUNCAO)+" jแ foi cadastrada nesse menu.", "Ja existe")
	l_Ret := .F.
Endif

Return l_Ret

User Function LstFcZZS()

Local c_Tit 	:= "Grupos/Modulos que utilizam a fun็ใo"
Local a_Cpos	:= {"ZZS_USER", "ZZS_MODULO", "ZZS_STATUS", "ZZS_LACE01", "ZZS_LACE02", "ZZS_LACE03", "ZZS_LACE04", "ZZS_LACE05", "ZZS_LACE06", "ZZS_LACE07", "ZZS_LACE08", "ZZS_LACE09", "ZZS_LACE10"}
Local a_Tits	:= {"Grupo", "M๓dulo", "Status", ZZR->ZZR_DACE01, ZZR->ZZR_DACE02, ZZR->ZZR_DACE03, ZZR->ZZR_DACE04, ZZR->ZZR_DACE05, ZZR->ZZR_DACE06, ZZR->ZZR_DACE07, ZZR->ZZR_DACE08, ZZR->ZZR_DACE09, ZZR->ZZR_DACE10}
Local a_Picts 	:= {"","","","","","","","","","","","",""}
Local a_ButZZS	:= {}
Local oDlg		:= Nil
Local oLbx		:= Nil
Local oCombo	:= Nil
Local c_Combo	:= "M๓dulo + Grupo + Status"
Local a_Combo	:= {"M๓dulo + Grupo + Status", "Grupo + M๓dulo + Status", "Status + Grupo + M๓dulo"}
Local oFntLbx 	:= TFont():New("Courier New",6,0)
Local a_VetZZS 	:= fCarrAVet(a_Cpos, a_Picts, 1, Nil)

aAdd(a_ButZZS, {"EDIT"		,{|| U_EditZZS(oLbx, @a_VetZZS, a_Cpos, a_Picts, oCombo)}, 'Editar registro (ZZS)', 'Alterar' })
aAdd(a_ButZZS, {"PRODUTO"	,{|| ZZS->(DbGoTo(a_VetZZS[oLbx:nAt,14])), U_FGMENU3(.F., ZZS->ZZS_USER)}, 'Visualiza o Menu do Usuแrio/Grupo', 'Vis Menu' })
If l_GrpMenu
	aAdd(a_ButZZS, {"GROUP"	,{|| U_ShowUsers(a_VetZZS[oLbx:nAt,1])}, 'Exibir Usuแrios do Grupo', 'Usuแrios' })
Endif

If Len(a_VetZZS) == 0
	MsgStop("Fun็ใo "+AllTrim(ZZR->ZZR_FUNCAO)+" nใo cadastrada na tabela de Grupos/Usuแrios (ZZS).", cCadastro)
Else

	DEFINE MSDIALOG oDlg TITLE c_Tit FROM 0,0 TO 500,1000 PIXEL
	
	@ 17,005 SAY "Fun็ใo ..: " 		SIZE 60,007 PIXEL OF oDlg
	@ 17,035 SAY ZZR->ZZR_FUNCAO 	SIZE 60,007 PIXEL OF oDlg
	@ 17,100 SAY "Tํtulo ..: " 		SIZE 60,007 PIXEL OF oDlg
	@ 17,130 SAY ZZR->ZZR_TITPOR	SIZE 60,007 PIXEL OF oDlg
	@ 17,250 SAY "Ordenar por .: " 	SIZE 60,007 PIXEL OF oDlg
	@ 15,290 MSCOMBOBOX oCombo VAR c_Combo ITEMS a_Combo SIZE 82,50 PIXEL OF oDlg ON CHANGE fOrdZZS(@a_VetZZS, oCombo:nAt, oLbx)
	
	oLbx := TwBrowse():New(30,5,490,215,,a_Tits,,oDlg,,,,,,,oFntLbx,,,,,.F.,,.T.,,.F.,,,)
	oLbx:SetArray(a_VetZZS)
	//   oLbx:bLine := {|| aEval( a_VetZZS[oLbx:nAt],{|z,w| a_VetZZS[oLbx:nAt,w]})}
	oLbx:bLine := {|| {a_VetZZS[oLbx:nAt,1],;
						a_VetZZS[oLbx:nAt,2],;
						IIF(a_VetZZS[oLbx:nAt,3]=="I", "Inibido", IIF(a_VetZZS[oLbx:nAt,3]=="H", "Habilitado", "Desabilitado")),;
						IIF(a_VetZZS[oLbx:nAt,4]==".T.", "x", " "),;
						IIF(a_VetZZS[oLbx:nAt,5]==".T.", "x", " "),;
						IIF(a_VetZZS[oLbx:nAt,6]==".T.", "x", " "),;
						IIF(a_VetZZS[oLbx:nAt,7]==".T.", "x", " "),;
						IIF(a_VetZZS[oLbx:nAt,8]==".T.", "x", " "),;
						IIF(a_VetZZS[oLbx:nAt,9]==".T.", "x", " "),;
						IIF(a_VetZZS[oLbx:nAt,10]==".T.", "x", " "),;
						IIF(a_VetZZS[oLbx:nAt,11]==".T.", "x", " "),;
						IIF(a_VetZZS[oLbx:nAt,12]==".T.", "x", " "),;
						IIF(a_VetZZS[oLbx:nAt,13]==".T.", "x", " ")}}
	
	oLbx:BLDBLCLICK := {|| U_EditZZS(oLbx, @a_VetZZS, a_Cpos, a_Picts, oCombo)}
	
	ACTIVATE MSDIALOG oDlg CENTER ON INIT EnchoiceBar(oDlg,{||oDlg:End()},{||oDlg:End()},, a_ButZZS)

Endif

Return Nil

User Function EditZZS(oLbx, a_VetZZS, a_Cpos, a_Picts, oCombo)
	
	DbSelectArea("ZZS")
	DbGoTo(a_VetZZS[oLbx:nAt,14])
	
	//If AxAltera("ZZS", ZZS->(Recno()), 4) == 1
	If U_FGMENU1(1) == 1
		
		a_VetZZS := fCarrAVet(a_Cpos, a_Picts, oCombo:nAt, oLbx)
		
		oLbx:SetArray(a_VetZZS)
		oLbx:bLine := {|| {a_VetZZS[oLbx:nAt,1],;
							a_VetZZS[oLbx:nAt,2],;
							IIF(a_VetZZS[oLbx:nAt,3]=="I", "Inibido", IIF(a_VetZZS[oLbx:nAt,3]=="H", "Habilitado", "Desabilitado")),;
							IIF(a_VetZZS[oLbx:nAt,4]==".T.", "x", " "),;
							IIF(a_VetZZS[oLbx:nAt,5]==".T.", "x", " "),;
							IIF(a_VetZZS[oLbx:nAt,6]==".T.", "x", " "),;
							IIF(a_VetZZS[oLbx:nAt,7]==".T.", "x", " "),;
							IIF(a_VetZZS[oLbx:nAt,8]==".T.", "x", " "),;
							IIF(a_VetZZS[oLbx:nAt,9]==".T.", "x", " "),;
							IIF(a_VetZZS[oLbx:nAt,10]==".T.", "x", " "),;
							IIF(a_VetZZS[oLbx:nAt,11]==".T.", "x", " "),;
							IIF(a_VetZZS[oLbx:nAt,12]==".T.", "x", " "),;
							IIF(a_VetZZS[oLbx:nAt,13]==".T.", "x", " ")}}
		oLbx:Refresh()
	Endif
	
Return Nil

Static Function fCarrAVet(a_Cpos, a_Picts, n_Index, oLbx)
	
	Local a_Ret 	:= {}
	Local n_Cpos	:= 0
	Local i 		:= 0
	
	DbSelectArea("ZZS")
	DbSetOrder(2) //ZZS_FILIAL, ZZS_FUNCAO, ZZS_USER, ZZS_CHAVE, ZZS_MODULO, R_E_C_N_O_, D_E_L_E_T_
	DbSeek(xFilial("ZZS")+ZZR->ZZR_FUNCAO, .T.)
	
	While ZZS->(!Eof()) .And. ZZS->(ZZS_FILIAL+ZZS_FUNCAO) == xFilial("ZZS")+ZZR->ZZR_FUNCAO
		aAdd(a_Ret,Array(Len(a_Cpos)+1))
		n_Cpos++
		For i := 1 To Len(a_Cpos)
			a_Ret[n_Cpos, i] := TransForm(FieldGet(FieldPos(a_Cpos[i])),a_Picts[i])
		Next i
		a_Ret[n_Cpos,i] := ZZS->(Recno())
		ZZS->(DbSkip())
	Enddo
	
	fOrdZZS(@a_Ret, n_Index, oLbx)
	
Return a_Ret

Static Function fOrdZZS(a_Dados, n_Index, oLbx)

	If n_Index == 1 //"M๓dulo + Grupo + Status"
		a_Dados := aSort(a_Dados,,,{|x,y| x[2]+x[1]+x[3] < y[2]+y[1]+y[3]})
	ElseIf n_Index == 2 //"Grupo + M๓dulo + Status"
		a_Dados := aSort(a_Dados,,,{|x,y| x[1]+x[2]+x[3] < y[1]+y[2]+y[3]})
	ElseIf n_Index == 3 //"Status + Grupo + M๓dulo"
		a_Dados := aSort(a_Dados,,,{|x,y| x[3]+x[2]+x[1] < y[3]+y[2]+y[1]})
	Endif
	
	If oLbx <> Nil
		oLbx:Refresh()
	Endif
	
Return Nil

User Function VldFuncMenu(c_Func, c_Tip)

	Local c_Funcao := AllTrim(c_Func)
	If c_Tip == "3"
		c_Funcao := "U_"+c_Funcao
	Endif

	If !FindFunction(c_Funcao)
		MsgAlert("ATENวรO.: A fun็ใo "+AllTrim(c_Funcao)+" nใo foi localizada no RPO.", "Fun็ใo "+IIF(c_Tip=="3", "de Usuแrio", "Protheus"))
	Endif

Return c_Func


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณShowUsers บAutor  ณThiago Barreto      บ Data ณ  16/08/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Exibe os Usuarios pertencentes ao Grupo Selecionado        บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Exclusivo Hilti do Brasil                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function ShowUsers(c_GrupoSel)
	Local a_xAllUsers := AllUsers()
	Local a_xAllGroups := AllGroups()
	Local a_xListGrp := {}
	Local n_xColGrp
	Local c_xGrupo := UPPER(ALLTRIM(c_GrupoSel))
	Local n_xCol, n_xC, n_xL, n_xCount
	Local c_xMsg := ""

	For n_xC := 1 to Len(a_xAllGroups)
		aAdd(a_xListGrp, {a_xAllGroups[n_xC][1][1], a_xAllGroups[n_xC][1][2], {}})
	Next n_xC
		
	For n_xL := 1 to Len(a_xAllUsers)
		If Len(a_xAllUsers[n_xL]) > 0	
			If Len(a_xAllUsers[n_xL][1]) > 0
				If Len(a_xAllUsers[n_xL][1][10]) > 0
					n_xColGrp := aScan(a_xListGrp, {|x| UPPER(ALLTRIM(x[1])) == UPPER(ALLTRIM(a_xAllUsers[n_xL][1][10][1]))})
					If n_xColGrp > 0
						aAdd(a_xListGrp[n_xColGrp][3], {a_xAllUsers[n_xL][1][1], a_xAllUsers[n_xL][1][2], a_xAllUsers[n_xL][1][4]})
					Endif
				Endif
			Endif
		Endif
	Next n_xL

	n_xCol := aScan(a_xListGrp, {|x| UPPER(ALLTRIM(x[2])) == c_xGrupo})
	
	If n_xCol > 0
		If Len(a_xListGrp[n_xCol]) > 0
			For n_xCount := 1 to Len(a_xListGrp[n_xCol][3])
				If Len(a_xListGrp[n_xCol][3]) > 0
					If Len(a_xListGrp[n_xCol][3][1]) > 0
						c_xMsg := c_xMsg + AllTrim(a_xListGrp[n_xCol][3][n_xCount][2]) + " - " + AllTrim(a_xListGrp[n_xCol][3][n_xCount][3]) + Chr(13) + Chr(10)
					Endif
				Endif
			Next n_xCount
			
			If Len(c_xMsg) > 0
				MsgInfo("Usuแrios para o Grupo " + c_xGrupo + ":" + Chr(13) + Chr(10) + c_xMsg)
			Else
				MsgInfo("O Grupo " + c_xGrupo + " nใo possui usuแrios vinculados", "Aviso")
			Endif
		Else
			MsgInfo("O Grupo " + c_xGrupo + " nใo possui usuแrios vinculados", "Aviso")
		Endif
	Else
		MsgInfo("O Grupo " + c_xGrupo + " nใo estแ cadastrado", "Aviso")
	Endif
Return Nil