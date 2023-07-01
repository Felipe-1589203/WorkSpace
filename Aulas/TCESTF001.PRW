#INCLUDE "protheus.ch"
#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"
#include "TOTVS.CH"
#Include "TBICONN.ch"
#define DS_MODALFRAME  128
#Define ENTER  CHR(13)+CHR(10)


/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥TCESTF001 ∫Autor  ≥ Actual Trend       ∫ Data ≥  13/02/17   ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Desc.     ≥Rotina de cadastro de Produtos e Estrutura por Grade        ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
User Function TCESTF001() 

	cAlias	      := "SB4"
	local cVldAlt := ".T." 
	local cVldExc := ".T." 
	local cAliasd                                                                                
	
	
	chkFile(cAlias)
	dbSelectArea(cAlias)
	dbSetOrder(1)
	private cCadastro := "Cadastro Grade de Produtos"
	Private cTabPrc   := ""
	Private cRevisao  := ""
	aRotina := {;
				{"Pesquisar"   ,"AxPesqui"	   ,0,1},;
				{"Vis. Grade"  ,"u_GrdProd(4)" ,0,2},;
				{"Inc. Grade"  ,"u_GrdProd(1)" ,0,3},;
				{"Alt. Grade"  ,"u_GrdProd(2)" ,0,4},;
				{"Estrutura"   ,"u_EstPro1(1)" ,0,3},;
				{"SKU"         ,"u_GrdProd(15)",0,2},;
				{"Rot.Operac"  ,"u_CriaRot()"  ,0,2},;
				{"Modelo"      ,"u_modelo()"   ,0,2}}

//		{"Inc. Ficha"  ,"u_GrdProd(11)",0,2},;
//		{"Alt. Ficha"  ,"u_GrdProd(12)",0,3},;
//		{"Inc. Roteiro","u_GrdProd(13)",0,2},;
//		{"Alt. Roteiro","u_GrdProd(14)",0,3},;
//		{"Variantes"   ,"u_GrdProd(16)",0,2},;
//		{"PreÁo"       ,"u_Preco()"    ,0,2},;
//		{"Exc.PreÁo"   ,"u_EPreco()"   ,0,2},;
                                              
//	    {"Inc. PreÁo"  ,"u_PrecPro(1)" ,0,3},;
//		{"Vis. PreÁo"  ,"u_PrecPro(3)" ,0,3},;
//		{"Cod.Barras"  ,"u_GrdProd(7)" ,0,3},;
	dbSelectArea(cAlias)
	mBrowse( 6, 1, 22, 75, cAlias)

cQuery := "update "+RetSqlName("SB1")+" set D_E_L_E_T_ = '*', R_E_C_D_E_L_ = R_E_C_N_O_ " +ENTER
cQuery += "from "+RetSqlName("SB1")+" SB1 " +ENTER
cQuery += "where SB1.D_E_L_E_T_ = '' " +ENTER
cQuery += "and B1_DESC = 'P1-' " +ENTER
cQuery += "and (Select B1_COD from "+RetSqlName("SB1")+" SB1B where SB1B.D_E_L_E_T_ = '' and SubString(SB1.B1_COD,1,6) = SubString(SB1B.B1_COD,1,6) and " +ENTER
cQuery += "Substring(SB1.B1_COD,9,7) = Substring(SB1B.B1_COD,9,7) and SubString(SB1B.B1_COD,7,2) not in ('P1','P2')) is null " +ENTER

TcSqlExec(cQuery)

cQuery := "update "+RetSqlName("SB1")+" set D_E_L_E_T_ = '*', R_E_C_D_E_L_ = R_E_C_N_O_ " +ENTER
cQuery += "from "+RetSqlName("SB1")+" SB1 " +ENTER
cQuery += "where SB1.D_E_L_E_T_ = '' " +ENTER
cQuery += "and B1_DESC = 'P2-' " +ENTER
cQuery += "and (Select B1_COD from "+RetSqlName("SB1")+" SB1B where SB1B.D_E_L_E_T_ = '' and SubString(SB1.B1_COD,1,6) = SubString(SB1B.B1_COD,1,6) and " +ENTER
cQuery += "Substring(SB1.B1_COD,9,7) = Substring(SB1B.B1_COD,9,7) and SubString(SB1B.B1_COD,7,2) not in ('P1','P2')) is null " +ENTER
ChargeQuery(cQuery)
MEMOWRITE("QUERY\query.sql",cQuery)
TcSqlExec(cQuery)


return

user function modelo()

	If Pergunte("MODELO",.t.)
	
		DbSelectarea("SB1")
		DbSetOrder(14)
		dbseek(xfilial("SB1")+MV_PAR01)

		dbSelectArea("SB4")
		DbSetOrder(1)
		dbSeek(xfilial("SB4")+Substring(SB1->B1_COD,1,8))

		_oObj := GetObjBrow()
		_oObj:Default()
		_oObj:NAT := SB4->(RECNO())
		_oObj:Refresh()

	EndIf

Return()

User Function EPreco()
	IF Pergunte("EPRECO",.T.)
		DbSelectArea("ZB4")
		DbSetOrder(2)
		DbSeek(xfilial("ZB4")+MV_PAR01+dtos(MV_PAR02))
		
		While !EOF() .and. ZB4->ZB4_PROD = MV_PAR01 .and. ZB4->ZB4_DATA = MV_PAR02
			RecLock("ZB4",.F.)
				dbDelete()
			MsUnLock()
			DbSelectArea("ZB4")
			DbSkip()
		End
	Endif

Return

User Function GrdProd(_tp)

// Esta rotina È a respons·vel pelo cadastro da grade de produto, criando SB4 (Grade de Produtos) e SB1 (Produtos)
// SX5 criado: Z3
// Consulta Padr„o: SBM-02/SX5-Z3

Local cCabecalho

Local oSay01
Local oSay02
Local oSay03
Local oSay04
Local oSay05
Local oSay06
Local oSay07
Local oSay08
Local oSay09
Local oSay10
Local oSay11
Local oSay12
Local oSay13
Local oSay14
Local oSay15
Local oSay16
Local oSay17
Local oSay18
Local oSay19
Local oSay20
Local oSay21
Local oSay22
Local oSay23
Local oSay24
Local oSay25
Local oSay26
Local oSay27
Local oSay28
Local oSay29
Local oSay30
Local oSay31
Local oSay32
Local oSay33
Local oSay34
Local oSay35
Local oSay36
Local oSay37
Local oSay38
Local oSay39
Local oSay40
Local oSay41
Local oSay42
Local oSay43
Local oSay44
Local oSay45
Local oSay46
Local oSay47

Local oTipoDesc
Local oOrigemDesc
Local oGrupoDesc
Local oCodigoDesc
Local oUM
Local oMarcaDesc
Local oCicloDesc
Local oGpProd
Local oGpProdDesc
Local oSGrupo
Local oSGrupoDesc
Local oColecao
Local oColecaoDesc
Local oSubCol
Local oSubColDesc
Local oTpProd
Local oTpProdDesc
Local oCatProd
Local oCatProdDesc
Local oOcasiao
Local oOcasiaoDesc
Local oTecido
Local oRastro
Local oBloqueio
Local oGramat
Local oEnd
Local oLinha
Local oPeso
Local oPeso2
Local oDtCad
Local oWEB
Local oTempo
Local oDescriPTB
Local oDescriENG
Local oDescriSPA
Local oObsProd 
Local oObsImp
Local oPtoCri
Local oFoto
Local oTES
Local oCustSTD

Local oButton1
Local oButton2
Local oButton3
Local lSave			:= .F.

Private oFolder1
Private oFicha1
Private oFicha2
Private oFicha3
Private oFicha4
Private oFicha5
Private nLin
Private oTipo
Private oOrigem
Private oGrupo
Private oCodigo
Private oRefCli
Private oCoorden //marcelo
Private cPrototi := Space(10)
Private oPedCli
Private oCodCli
Private cCoorden
Private oLojaCli
Private oNomCli
Private oPrototi //:= Space(20)
Private o2TpProd
Private oMarca
Private oCiclo
Private oTipo
Private oGpProd
Private oSGrupo
Private oColecao
Private oSubCol
Private oTpProd
Private oCatProd
Private oOcasiao
Private oArm
Private oColuna
Private oPosIPI
Private cTipo		:= Space(02)
Private cTipoDesc	:= Space(60)
Private cClass		:= Space(05)
//Private cClassDesc	:= Space(60)
Private cOrigem		:= "0"
Private cOrigemDesc	:= POSICIONE("SX5",1,xFilial("SX5")+'S0'+cOrigem,"X5_DESCRI")
Private cGrupo		:= Space(04)
Private cGrupoDesc	:= Space(60)
Private cCodigo		:= alltrim(GetSxeNum("SB4","B4_COD"))+"00" //Space(08)
//Private cModelo     := Space(50)
Private cCodCli     := Space(06)
Private cLojaCli    := Space(02)
Private cNomCli     := Space(40)
//Private c2TpProd	:= POSICIONE("SX5",1,xFilial("SX5")+'TP'+"X5_DESCRI")
//Private c2TpProd	:= "3" - 210621 - marcelo
Private cRefCli     := Space(50)
Private cPedCli     := Space(50)
Private cCodigoDesc	:= Space(30)
Private cUM			:= Space(02)
Private cMarca		:= Space(05)
Private cMarcaDesc	:= Space(60)
Private cCiclo		:= Space(05)
Private cCicloDesc	:= Space(60)
Private cGpProd		:= Space(05)
Private cGpProdDesc	:= Space(60)
//Private cSGrupo		:= Space(04)
Private cSGrupoDesc	:= Space(20)
Private cColecao	:= Space(04)
Private cColecaoDesc:= Space(60)
Private cSubCol		:= Space(05)
Private cSubColDesc	:= Space(60)
Private cTpProd		:= Space(05)
Private cTpProdDesc	:= Space(60)
Private cCatProd		:= Space(04)
Private cCatProdDesc:= Space(60)
Private cOcasiao		:= Space(05)
Private cOcasiaoDesc:= Space(60)
Private cTecido		:= Space(20)
Private cArm			:= Space(02)
Private cRastro		:= 3
Private cBloqueio	:= "2"
Private cEnd			:= 2
Private cLinha		:= "COR"
Private cColuna		:= Space(03)
Private cColunx		:= Space(03)
Private cPosIPI		:= Space(10)
Private nPeso		:= 0
Private cTES		:= Space(03)
Private nCustSTD	:= 0

//Private nPeso2		:= 0
Private dDtCad		:= Date()
//Private cWEB			:= 2
Private cTempo		:= "  :  "
Private cTrib := " "
Private cDescriPTB	:= ""
Private cDescriENG	:= ""
Private cDescriSPA	:= ""
Private cObsProd    := ""
Private cObsImp 	:= ""
Private Foto		:= "LGRL01.bmp"
Private cAcab1      := Space(254)
Private cAcab2      := Space(254)
Private cAcab3      := Space(254)
Private cAcab4      := Space(254)
Private cAcab5      := Space(254)
Private cAcab6      := Space(254)
Private cAcab7      := Space(254)
Private cAcab8      := Space(254)
Private cAcab9      := Space(254)
Private cAcab10     := Space(254)
Private cAcab11     := Space(254)
Private cAcab12     := Space(254)
Private cAcab13     := Space(254)
Private cAcab14     := Space(254)
Private cAcab15     := Space(254)
Private cAcab16     := Space(254)
Private cAcab17     := Space(254)
Private cAcab18     := Space(254)
Private cAcab19     := Space(254)
Private cAcab20     := Space(254)
Private cFornece := SPACE(6)
Private nLargL    := 0
Private nGramatL  := 0
Private nLargE    := 0
Private nGramatE  := 0
Private cRefFor  := SPACE(50)
Private cComp1   := SPACE(30)
Private cComp2   := SPACE(30)
Private cComp3   := SPACE(30)
Private cGrau    := SPACE(2)
Private cFicha1  := SPACE(80)
Private cFicha2  := SPACE(80)
Private cFicha3  := SPACE(80)
Private cFicha4  := SPACE(80)
Private cFicha5  := SPACE(80)
Private cPtoCri  := ""
Private lInclui  := .F.

Private cNumParte := "01"

Private cTabPrc := AllTrim(SuperGetMV("MV_XTABPRC",.F.,"005"))

Static oDlg

If _tp = 1 .or. _tp = 2 .or. _tp = 4
	SetKey( VK_F11, { || hCompo() } )
	SetKey( VK_F12, { || hLavage()  } )
End

IF _tp = 2 .or. _tp = 4 .or. _tp = 7 .or. _tp = 8 .or. _tp = 9 .or. _tp = 10 .or. _tp = 11 .or. _tp = 12 .or. _tp = 13 .or. _tp = 14 .or. _tp = 15
	DbSelectArea("SB1")
	DbSetOrder(1)
	DbSeek(xfilial("SB1")+Alltrim(SB4->B4_COD))
	
	//cFicha1			:= SB4->B4_XFICHA1
	//cFicha2			:= SB4->B4_XFICHA2
	//cFicha3			:= SB4->B4_XFICHA3
	//cFicha4			:= SB4->B4_XFICHA4
	//cFicha5			:= SB4->B4_XFICHA5 
	cTipo			:= SB4->B4_TIPO
	cTipoDesc		:= POSICIONE("SX5",1,xFilial("SX5")+'02'+cTipo,"X5_DESCRI")
//	cClass			:= SB4->B4_YCLASPR
//	cClassDesc		:= POSICIONE("ZAE",1,xFilial("ZAE")+cClass,"ZAE_DESCRI")
	cOrigem		    := SB4->B4_YORIGEM
	cOrigemDesc	    := POSICIONE("SX5",1,xFilial("SX5")+'S0'+cOrigem,"X5_DESCRI")
	cGrupo			:= SB4->B4_GRUPO
	cGrupoDesc		:= POSICIONE("SBM",1,xFilial("SBM")+cGrupo,"BM_DESC")
	cCodigo 		:= SB4->B4_COD
	//cModelo         := SB4->B4_YMODELO
	cCodCli 		:= SB4->B4_XCLIENT
	cLojaCli		:= SB4->B4_XLJCLI
	cNomCli			:= POSICIONE("SA1",1,xFilial("SA1")+SB4->B4_XCLIENT+SB4->B4_XLJCLI,"A1_NOME")
	//c2TpProd		:= SB4->B4_XTPPROD // Marcelo 210621

	//cRefCli         := SB4->B4_YREFCLI
	//cPedCli         := SB4->B4_YPEDCLI
	cCodigoDesc		:= SB4->B4_DESC
	cUM				:= SB4->B4_UM
	cMarca			:= SB4->B4_YMARCA
	cMarcaDesc		:= SB4->B4_YNOMARC
	cCiclo			:= AllTrim(SB4->B4_YCICLO)
	cCicloDesc		:= SB4->B4_YNCICLO
	cGpProd			:= SB4->B4_YGPRODU
	//cGpProdDesc	:= SB4->B4_YNGPCOM
	cCoorden		:= SB4->B4_XCOORDE // Marcelo - Actual 210623
	cTES			:= SB1->B1_TE
	nCustSTD		:= SB1->B1_CUSTD

	cSGrupoDesc		:= SB1->B1_CONTA //Space(20) //POSICIONE("SZQ",1,xFilial("SZQ")+SB4->B4_XSUBGRU,"ZQ_DESCSUB")
	cColecao		:= SB4->B4_XCOLECA
	cColecaoDesc	:= POSICIONE("SZR",1,xFilial("SZR")+SB4->B4_XCOLECA,"ZR_DESCRI")
	//cSubCol		:= SB4->B4_YSUBCOL
	//cSubColDesc	:= SB4->B4_YNSUBCO
	//cTpProd		:= SB4->B4_YTPPROD
	//cTpProdDesc	:= SB4->B4_YNTPCOM
	cCatProd		:= SB4->B4_XCATEGO
	cCatProdDesc	:= POSICIONE("SZP",1,xFilial("SZP")+SB4->B4_XCATEGO,"ZP_DESCRI")
	//cOcasiao		:= AllTrim(SB4->B4_YOCASIA)
	If alltrim(cOcasiao) <> ""
		cOcasiaoDesc	:= POSICIONE("ZAD",1,xFilial("ZAD")+AllTrim(cOcasiao),"ZAD_DESCRI")
	Endif
	cTecido		    := SB4->B4_YTECIDO
	cArm 			:= SB4->B4_LOCPAD
	cRastro 		:= If(SB4->B4_RASTRO="N",3,If(SB4->B4_RASTRO="L",1,2))
	cEnd 			:= If(SB4->B4_LOCALIZ="S",1,2)
	If SUBSTRING(SB4->B4_LINHA,1,2)="CO"
		cLinha 		:= "COR"
	Else
		cLinha 		:= SB4->B4_LINHA
	End
		
	cColuna 		:= SB4->B4_COLUNA	
	nPeso 			:= SB4->B4_PESO
//	nPeso2 			:= SB4->B4_YPESO //Criar N PESO 2
	cPosIPI 		:= SB4->B4_POSIPI
	dDtCad 			:= SB4->B4_YDATCAD
	//cWeb 			:= If(SB4->B4_DWEB="S",1,2)
	cTempo			:= SB4->B4_YTEMPO
	cTrib			:= SB4->B4_SITTRIB
	cDescriPTB 		:= SB4->B4_YDESCPT
	//cDescriSPA 	:= SB4->B4_YDESCES
	//cDescriENG 	:= SB4->B4_YDESCIE
	cObsProd		:= SB4->B4_YOBS
	cObsImp	    	:= SB4->B4_XOBSIMP
	/*cAcab1          := SB4->B4_XACAB1
	cAcab2          := SB4->B4_XACAB2
	cAcab3          := SB4->B4_XACAB3
	cAcab4          := SB4->B4_XACAB4
	cAcab5          := SB4->B4_XACAB5
	cAcab6          := SB4->B4_XACAB6
	cAcab7          := SB4->B4_XACAB7
	cAcab8          := SB4->B4_XACAB8
	cAcab9          := SB4->B4_XACAB9
	cAcab10         := SB4->B4_XACABA
	cAcab11         := SB4->B4_XACABB
	cAcab12         := SB4->B4_XACABC
	cAcab13         := SB4->B4_XACABD
	cAcab14         := SB4->B4_XACABE
	cAcab15         := SB4->B4_XACABF
	cAcab16         := SB4->B4_XACABG
	cAcab17         := SB4->B4_XACABH
	cAcab18         := SB4->B4_XACABI
	cAcab19         := SB4->B4_XACABJ
	cAcab20         := SB4->B4_XACABK)*/
	cFornece 		:= SB4->B4_XFORNEC
	nLargL    		:= SB4->B4_XLARG
	nGramatL  		:= SB4->B4_XGRAM
	nLargE    		:= SB4->B4_XLARGES
	nGramatE  		:= SB4->B4_XGRAMES
	cRefFor  		:= SB4->B4_XREFFOR
	//cComp1          := SB4->B4_XCOMP1
	//cComp2          := SB4->B4_XCOMP2
	//cComp3          := SB4->B4_XCOMP3
	cGrau           := SB4->B4_XGRAU
	cPtoCri         := SB4->B4_XPTOCRI
	cPrototi		:= SB4->B4_XCODPRO
	
	
Endif

cBloqueio		:= If(SB4->B4_MSBLQL=="1",1,2)

If _tp == 1
	cCabecalho := "Inclus„o no Cadastro de Grades"
	lInclui := .T.
ElseIf _tp == 2
	cCabecalho := "AlteraÁ„o do Cadastro de Grades"
ElseIf _tp == 4
	cCabecalho := "Visualizar Cadastro de Grades"
ElseIf _tp == 7
	cCabecalho := "GeraÁ„o de codigo de Barras"
ElseIf _tp == 8
	cCabecalho := "Inclus„o de Cadastro de Mix para OP"
ElseIf _tp == 9
	cCabecalho := "AlteraÁ„o de Cadastro de Mix para OP"
ElseIf _tp == 10
	cCabecalho := "Ajuste de Status"
ElseIf _tp == 11 .or. _tp == 12 .or. _tp == 13 .or. _tp = 14
	cCabecalho := "Ficha TÈcnica"
ElseIf _tp = 15
	cCabecalho := "SKU do Cliente"
End

DEFINE MSDIALOG oDlg TITLE cCabecalho FROM 000, 000  TO 600, 1250 COLORS 0, 16777215 PIXEL // MARCELO 1250
//SIZE 620 // 123
@ 004, 004 FOLDER oFolder1 SIZE 620, 140 OF oDlg ITEMS "Cadastro" COLORS 0, 16777215 PIXEL //,"Outros","Acabamentos 1","Acabamentos 2","Ficha TÈcnica" COLORS 0, 16777215 PIXEL

	//FOLDER 01
	nLin	:= 004     
	If _tp == 1
    @ nLin	, 005 SAY oSay01 PROMPT "Tipo" 							SIZE 025, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
    @ nLin+8, 005 MSGET oTipo VAR cTipo		 					    SIZE 035, 010 OF oFolder1:aDialogs[1] VALID !VAZIO() .AND. GatTela(1,_tp) PICTURE "@!" COLORS 0, 16777215 F3 "02" 	PIXEL
    @ nLin	, 045 SAY oSay02 PROMPT "Desc. do Tipo" 				SIZE 050, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
    @ nLin+8, 045 MSGET oTipoDesc VAR cTipoDesc 					SIZE 155, 010 OF oFolder1:aDialogs[1] COLORS 0, 16777215 READONLY 		PIXEL
	Else
    GatTela(0,_tp)
   End

	//FOLDER 02
	nLin	:= 004     
    //@ nLin	, 005 SAY oSay40 PROMPT "Foto"							SIZE 055, 007 OF oFolder1:aDialogs[2] COLORS 0, 16777215 PIXEL    
    //@ nLin+8, 005 BITMAP oFoto	 									SIZE 110, 080 OF oFolder1:aDialogs[2] PIXEL
    //@ nLin	, 130 SAY oSay41 PROMPT "DescriÁ„o PortuguÍs"			SIZE 055, 007 OF oFolder1:aDialogs[2] COLORS 0, 16777215 PIXEL
    //@ nLin+8, 130 GET oDescriPTB VAR cDescriPTB		MULTILINE 	SIZE 235, 050 OF oFolder1:aDialogs[2] COLORS 0, 16777215 HSCROLL 		PIXEL
    //@ nLin	, 378 SAY oSay42 PROMPT "DescriÁ„o Espanhol"			SIZE 055, 007 OF oFolder1:aDialogs[2] COLORS 0, 16777215 PIXEL
    //@ nLin+8, 378 GET oDescriSPA VAR cDescriSPA		MULTILINE 	SIZE 235, 050 OF oFolder1:aDialogs[2] COLORS 0, 16777215 HSCROLL 		PIXEL
    
	//nLin	:= nLin+65    
    //@ nLin	, 130 SAY oSay43 PROMPT "DescriÁ„o InglÍs"			SIZE 055, 007 OF oFolder1:aDialogs[2] COLORS 0, 16777215 PIXEL
    //@ nLin+8, 130 GET oDescriENG VAR cDescriENG		MULTILINE 	SIZE 235, 050 OF oFolder1:aDialogs[2] COLORS 0, 16777215 HSCROLL 		PIXEL 
    //@ nLin	, 005 SAY oSay94 PROMPT "Pontos CrÌticos do Produto"	SIZE 065, 007 OF oFolder1:aDialogs[2] COLORS 0, 16777215 PIXEL
    //@ nLin+8, 005 GET oPtoCri 	VAR cPtoCri		    	MULTILINE 	SIZE 180, 050 OF oFolder1:aDialogs[2] COLORS 0, 16777215 HSCROLL 		PIXEL 
    
    //@ nLin	, 190 SAY oSay44 PROMPT "ObservaÁıes do Produto"		SIZE 065, 007 OF oFolder1:aDialogs[2] COLORS 0, 16777215 PIXEL
    //@ nLin+8, 190 GET oObsProd 	VAR cObsProd			MULTILINE 	SIZE 180, 050 OF oFolder1:aDialogs[2] COLORS 0, 16777215 HSCROLL 		PIXEL 
      
    //@ nLin,   375 SAY oSay54 PROMPT "ObservaÁoes para Impress„o"	SIZE 100, 007 OF oFolder1:aDialogs[2] COLORS 0, 16777215 PIXEL
    //@ nLin+8, 375 GET oObsImp 	VAR cObsImp			    MULTILINE 	SIZE 180, 050 OF oFolder1:aDialogs[2] COLORS 0, 16777215 HSCROLL 		PIXEL

// Rotinas para criaÁ„o dos acols para v·rias opÁıes do menu
	If _tp = 7
    	fMSCBar(_tp, cColuna)
    ElseIf _tp = 8 .or. _tp = 9
		fMSMix(_tp, cColuna)    
	ElseIf _tp = 10
		fMSSta(_tp, cColuna)
	ElseIf _tp = 11 .or. _tp = 12
		fMSFicha(_tp, cColuna)    
	ElseIf _tp = 13 .or. _tp = 14
		fMSFich1(_tp, cColuna)
	ElseIf _tp = 15
		fMSGrdSKU(_tp, cColuna)
	ElseIf _tp = 16
		fMSGrdVAR(_tp, cColuna)
    Else
    	fMSGrade(_tp, cColuna)
    Endif

	If _tp = 1 .or. _tp = 2 .or. _tp = 4
	    @ 279, 005 SAY oSay45 PROMPT "F11 - ComposiÁ„o"					SIZE 100, 008 OF oDlg COLORS 0, 16777215 PIXEL
	    @ 287, 005 SAY oSay46 PROMPT "F12 - Procedimentos de Lavagem"	SIZE 100, 008 OF oDlg COLORS 0, 16777215 PIXEL
	ElseIf _tp = 13 .or. _tp = 14
	    @ 283, 005 SAY oSay38 PROMPT "Tempo Estimado de ProduÁ„o"		SIZE 075, 007 OF oDlg COLORS 0, 16777215 PIXEL
	    @ 280, 085 MSGET oWeb VAR cTempo									SIZE 055, 010 OF oDlg VALID !VAZIO() PICTURE "99:99" COLORS 0, 16777215 PIXEL
	End
	If _tp = 1 .or. _tp = 2 
	    @ 282, 450 BUTTON oButton3 PROMPT "Replicar"						SIZE 040, 012 ACTION ReplyLn(_tp) OF oDlg PIXEL
	End
    @ 282, 500 BUTTON oButton1 PROMPT "Ok" 						SIZE 040, 012 ACTION Save(_tp) OF oDlg PIXEL
    @ 282, 550 BUTTON oButton2 PROMPT "Cancelar" 				SIZE 040, 012 ACTION (rollbacksx8(),Close(oDlg)) OF oDlg PIXEL

  ACTIVATE MSDIALOG oDlg CENTERED

If _tp = 1 .or. _tp = 2 .or. _tp = 4
	Set Key VK_F11 To
	Set Key VK_F12 To
End

Return

Static Function Gatilhos(cCodGat)
// Rotina para preenchimento dos campos de descriÁ„o
If cCodGat==2
	If !Empty(cOrigem)
		cOrigemDesc	:= POSICIONE("SX5",1,xFilial("SX5")+'S0'+cOrigem,"X5_DESCRI")
		If Alltrim(cOrigemDesc)=="" 
			oOrigem:SetFocus()
		EndIf
	EndIf	
ElseIf cCodGat==6
	//If !Empty(cSGrupo)
		//cSGrupoDesc	:= POSICIONE("ZAG",1,xFilial("ZAG")+cSGrupo,"ZAG_DESCRI")
	//	If Alltrim(cSGrupoDesc)=="" 
	//		oSGrupo:SetFocus()
	//	EndIf
	//EndIf	
ElseIf cCodGat==7
	If !Empty(cColecao)
		cColecaoDesc	:= POSICIONE("SZR",1,xFilial("SZR")+cColecao,"ZR_DESCRI")
		If Alltrim(cColecaoDesc)=="" 
			oColecao:SetFocus()
		EndIf
	EndIf	
ElseIf cCodGat==12
	If !Empty(cArm)
		If !EXISTCPO("NNR",cArm)	
			oArm:SetFocus()
		EndIf
	EndIf	
EndIf

Return

Static Function GatTela(cCodGat,_tp)
// Rotina para tratamento de habilitar campos para produtos do tipo PA

If cCodGat==1
	cTipoDesc	:= POSICIONE("SX5",1,xFilial("SX5")+'02'+cTipo,"X5_DESCRI")
	If Alltrim(cTipoDesc)=="" 
		oTipo:SetFocus()
	Else
		cArm 		:= "01"//IF(cTipo$"KT|PA|ME|PI","01",IF(cTipo$"MP|MI","A1","  "))
		cUM			:= IF(cTipo$"PA","PC",Space(02))
		//cWEB		:= IF(cTipo$"PA",1,2)
	End
Else 
    @ nLin	, 005 SAY oSay01 PROMPT "Tipo" 						SIZE 025, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
    @ nLin+8, 005 MSGET oTipo VAR cTipo 						SIZE 035, 010 OF oFolder1:aDialogs[1] COLORS 0, 16777215 F3 "02" READONLY	PIXEL
End
	If cTipo == "PA"
		nLin	:= 004
	    If _tp <> 1
	    	@ nLin	, 045 SAY oSay02 PROMPT "Desc. do Tipo" 	SIZE 050, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
	    	@ nLin+8, 045 MSGET oTipoDesc VAR cTipoDesc 		SIZE 155, 010 OF oFolder1:aDialogs[1] COLORS 0, 16777215 READONLY 		PIXEL
	    EndIf	
	    @ nLin	, 212 SAY oSay03 PROMPT "Origem Prod." 			SIZE 035, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 212 MSGET oOrigem VAR cOrigem 				SIZE 035, 010 OF oFolder1:aDialogs[1] VALID Gatilhos(2) COLORS 0, 16777215 F3 "S0" 	PIXEL
	    @ nLin	, 252 SAY oSay04 PROMPT "Desc. Origem Prod."	SIZE 070, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 252 MSGET oOrigemDesc VAR cOrigemDesc			SIZE 155, 010 OF oFolder1:aDialogs[1] COLORS 0, 16777215 READONLY 		PIXEL
	    @ nLin	, 419 SAY oSay05 PROMPT "Pos. IPI/NCM"			SIZE 040, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 419 MSGET oPosIPI VAR cPosIPI	 				SIZE 050, 010 PICTURE "@R 9999.99.99" OF oFolder1:aDialogs[1] VALID U_ExistCod(1,cPosIPI) COLORS 0, 16777215 F3 "SYD" PIXEL
	    @ nLin	, 489 SAY oSay06 PROMPT "ArmazÈm" 				SIZE 045, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 489 MSGET oArm VAR cArm 						SIZE 055, 010 OF oFolder1:aDialogs[1] VALID Gatilhos(12) PICTURE "@!" COLORS 0, 16777215 F3 "NNR" 		PIXEL
		@ nLin	, 559 SAY oSay07 PROMPT "Data de cadastro"		SIZE 055, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 559 MSGET oDtCad VAR dDtCad 					SIZE 055, 010 PICTURE "@D 99/99/9999" OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
		
		nLin	:= nLin+27
	    @ nLin	, 005 SAY oSay08 PROMPT "ReferÍncia" 			SIZE 050, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
	    IF _tp = 2 .OR. _tp = 4
	       @ nLin+8, 005 MSGET oCodigo VAR cCodigo 				SIZE 050, 010 OF oFolder1:aDialogs[1] PICTURE "@!" COLORS 0, 16777215 READONLY 		PIXEL
	    Else
	       @ nLin+8, 005 MSGET oCodigo VAR cCodigo 				SIZE 050, 010 OF oFolder1:aDialogs[1] PICTURE "@!" COLORS 0, 16777215 READONLY 		PIXEL
//	       @ nLin+8, 005 MSGET oCodigo VAR cCodigo 				SIZE 050, 010 OF oFolder1:aDialogs[1] VALID VldCod2(cCodigo) PICTURE "@!" COLORS 0, 16777215 PIXEL
	    End
	    @ nLin	, 060 SAY oSay09 PROMPT "DescriÁ„o"				SIZE 050, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 060 MSGET oCodigoDesc VAR cCodigoDesc			SIZE 140, 010 OF oFolder1:aDialogs[1] PICTURE "@!" COLORS 0, 16777215 PIXEL
	       
	    @ nLin	, 212 SAY oSay10 PROMPT "Unid.Med."				SIZE 035, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 212 MSGET oUM VAR cUM 						SIZE 035, 010 OF oFolder1:aDialogs[1] COLORS 0, 16777215 F3 "SAH" 		PIXEL
	    @ nLin	, 254 SAY oSay11 PROMPT "Cod. Cliente" 			SIZE 050, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
		@ nLin+8, 254 MSGET oCodCli VAR cCodCli					SIZE 035, 010 OF oFolder1:aDialogs[1] /*VALID VldCod()*/ PICTURE "@!" COLORS 0, 16777215 F3 "SA1GRD" 	PIXEL
	    @ nLin	, 291 SAY oSay11 PROMPT "Lj.Cli" 	   			SIZE 020, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
		@ nLin+8, 291 MSGET oLojaCli VAR cLojaCli				SIZE 020, 010 OF oFolder1:aDialogs[1] PICTURE "@!" COLORS 0, 16777215 READONLY 		PIXEL
       	@ nLin	, 317 SAY oSay12 PROMPT "Nome Cliente" 			SIZE 070, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
       	@ nLin+8, 317 MSGET oNomCli VAR cNomCli 				SIZE 150, 010 OF oFolder1:aDialogs[1] PICTURE "@!" COLORS 0, 16777215 READONLY 		PIXEL  
	    @ nLin	, 480 SAY oSay47 PROMPT "Cod.ProtÛtipo/Piloto"	SIZE 070, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
       	@ nLin+8, 480 MSGET oPrototi VAR cPrototi				SIZE 100, 010 OF oFolder1:aDialogs[1] PICTURE "@!" COLORS 0, 16777215 PIXEL
	    //@ nLin	, 489 SAY oSay13 PROMPT "Tp Prod" 				SIZE 070, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL // Marcelo 210621
	    //@ nLin+8, 489 MSCOMBOBOX o2TpProd VAR c2TpProd			ITEMS {"Amostra","Normal","Desenvolvimento"}		SIZE 055, 013 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL // Marcelo 2106021
       	//@ nLin	, 559 SAY oSay14 PROMPT "Ped. Cliente" 			SIZE 070, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
       	//@ nLin+8, 559 MSGET oPedCli VAR cPedCli 				SIZE 050, 010 OF oFolder1:aDialogs[1] PICTURE "@!" COLORS 0, 16777215 PIXEL
		
		nLin	:= nLin+27
		// Comentado por Marcelo Actual - 23/06/2021
		//@ nLin	, 005 SAY oSay15 PROMPT "Categoria" 			SIZE 025, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL 
		//@ nLin+8, 005 MSGET oCatProd VAR cCatProd  		    	SIZE 035, 010 OF oFolder1:aDialogs[1] /*VALID VldCod()*/ PICTURE "@!" COLORS 0, 16777215 F3 "SZP" 	PIXEL
		//@ nLin	, 045 SAY oSay16 PROMPT "Desc. Categoria"		SIZE 035, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
		//@ nLin+8, 045 MSGET oCatProdDesc VAR cCatProdDesc  		SIZE 155, 010 OF oFolder1:aDialogs[1] COLORS 0, 16777215 READONLY 		PIXEL
		// Fim ...
		@ nLin	, 005 SAY oSay15 PROMPT "Grupo" 				SIZE 025, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
		@ nLin+8, 005 MSGET oGrupo VAR cGrupo					SIZE 035, 010 OF oFolder1:aDialogs[1] COLORS 0, 16777215 F3 "SBM" 	PIXEL //"SBM-01"
		@ nLin	, 045 SAY oSay16 PROMPT "Desc. Grupo"			SIZE 035, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 045 MSGET oGrupoDesc VAR cGrupoDesc			SIZE 155, 010 OF oFolder1:aDialogs[1] COLORS 0, 16777215 READONLY 		PIXEL
		//@ nLin	, 419 SAY oSay17 PROMPT "Sub Grupo" 			SIZE 035, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL // Marcelo Actual - 230621
	    //@ nLin+8, 419 MSGET oSGrupo VAR cSGrupo 				SIZE 035, 010 OF oFolder1:aDialogs[1] COLORS 0, 16777215 F3 "SZQ" 		PIXEL
		@ nLin	, 230 SAY oSay18 PROMPT "Cta Contabil"			SIZE 050, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 			   	PIXEL //459
	    @ nLin+8, 230 MSGET oSGrupoDesc VAR cSGrupoDesc			SIZE 155, 010 OF oFolder1:aDialogs[1] COLORS 0, 16777215 F3 "CT1" 		PIXEL
		@ nLin	, 420 SAY oSay17 PROMPT "Coordenado:" 			SIZE 050, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
    	@ nLin+8, 420 MSGET oCoorden VAR cCoorden				SIZE 140, 010 OF oFolder1:aDialogs[1] PICTURE "@!" COLORS 0, 16777215 PIXEL
		//@ nLin	, 420 SAY oSay17 PROMPT "Modelo Cliente"				SIZE 050, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
	    //@ nLin+8, 420 MSGET oModeloCli VAR cModelo				SIZE 140, 010 OF oFolder1:aDialogs[1] PICTURE "@!" COLORS 0, 16777215 PIXEL

		//@ nLin+10, 005 SAY oSay85 PROMPT "ComposiÁ„o PA Linha 1"	SIZE 150, 007 OF oFolder1:aDialogs[2] COLORS 0, 16777215 PIXEL
		//@ nLin+18, 005 MSGET oComp1 VAR cComp1  		    	    	SIZE 155, 010 OF oFolder1:aDialogs[2] PICTURE "@!" COLORS 0, 16777215	PIXEL
		//@ nLin+10, 165 SAY oSay86 PROMPT "ComposiÁ„o PA Linha 2" 	SIZE 150, 007 OF oFolder1:aDialogs[2] COLORS 0, 16777215 PIXEL
		//@ nLin+18, 165 MSGET oComp2 VAR cComp2  		    	    	SIZE 155, 010 OF oFolder1:aDialogs[2] PICTURE "@!" COLORS 0, 16777215	PIXEL
		//@ nLin+10, 325 SAY oSay87 PROMPT "ComposiÁ„o PA Linha 3" 	SIZE 150, 007 OF oFolder1:aDialogs[2] COLORS 0, 16777215 PIXEL
		//@ nLin+18, 325 MSGET oComp3 VAR cComp3  		    	    	SIZE 155, 010 OF oFolder1:aDialogs[2] PICTURE "@!" COLORS 0, 16777215	PIXEL
		//@ nLin+10, 485 SAY oSay88 PROMPT "Grau de Dificuldade"     	SIZE 080, 007 OF oFolder1:aDialogs[2] COLORS 0, 16777215 PIXEL
		// nLin+18, 485 MSGET oGrau VAR cGrau  		    	         	SIZE 30, 010 OF oFolder1:aDialogs[2] PICTURE "@!" COLORS 0, 16777215	PIXEL
		
		
		nLin	:= nLin+27
		@ nLin	, 005 SAY oSay19 PROMPT "ColeÁ„o" 				SIZE 035, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
		@ nLin+8, 005 MSGET oColecao VAR cColecao 				SIZE 035, 010 OF oFolder1:aDialogs[1] COLORS 0, 16777215 F3 "SZR01"  	PIXEL
	    @ nLin	, 045 SAY oSay20 PROMPT "Desc. ColeÁ„o"			SIZE 050, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
		@ nLin+8, 045 MSGET oColecaoDesc VAR cColecaoDesc		SIZE 155, 010 OF oFolder1:aDialogs[1] COLORS 0, 16777215 READONLY 		PIXEL
	    @ nLin	, 209 SAY oSay21 PROMPT "Linha" 				SIZE 045, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 209 MSGET oLinha VAR cLinha 					SIZE 055, 010 OF oFolder1:aDialogs[1] COLORS 0, 16777215 READONLY			PIXEL
	    @ nLin	, 279 SAY oSay22 PROMPT "Coluna" 				SIZE 045, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 279 MSGET oColuna VAR cColuna					SIZE 055, 010 VALID u_valacols(_tp, cColuna) OF oFolder1:aDialogs[1] WHEN lInclui PICTURE "@!" COLORS 0, 16777215 F3 "SBV" PIXEL
	    @ nLin	, 349 SAY oSay23 PROMPT "Peso Liquido"			SIZE 045, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 349 MSGET oPeso VAR nPeso 					SIZE 055, 010 PICTURE "@E 999,999.9999" OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL 
	    //@ nLin	, 215 SAY oSay24 PROMPT "Segundo Peso"			SIZE 045, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
	    //@ nLin+8, 215 MSGET oPeso2 VAR nPeso2 					SIZE 055, 010 PICTURE "@E 999,999.9999" OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
	    @ nLin	, 419 SAY oSay25 PROMPT "Bloqueado"				SIZE 050, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 419 MSCOMBOBOX oBloqueio VAR cBloqueio		ITEMS {"Sim","N„o"}		SIZE 055, 013 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
       	@ nLin	, 489 SAY oSay26 PROMPT "Lote/SubLote"			SIZE 045, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 489 MSCOMBOBOX oRastro VAR cRastro			ITEMS {"Lote","SubLote","Nao Utiliza"}		SIZE 045, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL //055 PARA 045
	    @ nLin	, 559 SAY oSay27 PROMPT "EndereÁo" 				SIZE 045, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 559 MSCOMBOBOX oEnd VAR cEnd 					ITEMS {"Sim","N„o"}		SIZE 055, 013 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL

		// MARCELO OLIVEIRA
		nLin	:= nLin+27
	//	@ nLin	, 620 SAY oSay27 PROMPT "Gramatura" 			SIZE 045, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
	//   @ nLin+8, 620 MSGET oGramat VAR nGramatu			    SIZE 055, 013 PICTURE "@E 999,999.9999" OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
	 /*nLin := 004
	    @ nLin	, 005 SAY oSay61 PROMPT "Acabamento 1"		  	SIZE 035, 007 OF oFolder1:aDialogs[3] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 005 MSGET oAcab1 VAR cAcab1  					SIZE 300, 010 OF oFolder1:aDialogs[3] COLORS 0, 16777215 PIXEL
	    @ nLin	, 310 SAY oSay66 PROMPT "Acabamento 1"		  	SIZE 035, 007 OF oFolder1:aDialogs[3] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 310 MSGET oAcab2 VAR cAcab2  					SIZE 300, 010 OF oFolder1:aDialogs[3] COLORS 0, 16777215 PIXEL
	    @ nLin	, 005 SAY oSay71 PROMPT "Acabamento 6"		  	SIZE 050, 007 OF oFolder1:aDialogs[4] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 005 MSGET oAcab11 VAR cAcab11  				SIZE 300, 010 OF oFolder1:aDialogs[4] COLORS 0, 16777215 PIXEL
	    @ nLin	, 310 SAY oSay76 PROMPT "Acabamento 6"		  	SIZE 050, 007 OF oFolder1:aDialogs[4] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 310 MSGET oAcab12 VAR cAcab12  				SIZE 300, 010 OF oFolder1:aDialogs[4] COLORS 0, 16777215 PIXEL
	    nLin	:= nLin+20
	    @ nLin	, 005 SAY oSay62 PROMPT "Acabamento 2"		  	SIZE 035, 007 OF oFolder1:aDialogs[3] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 005 MSGET oAcab3 VAR cAcab3  					SIZE 300, 010 OF oFolder1:aDialogs[3] COLORS 0, 16777215 PIXEL
	    @ nLin	, 310 SAY oSay67 PROMPT "Acabamento 2"		  	SIZE 035, 007 OF oFolder1:aDialogs[3] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 310 MSGET oAcab4 VAR cAcab4  					SIZE 300, 010 OF oFolder1:aDialogs[3] COLORS 0, 16777215 PIXEL
	    @ nLin	, 005 SAY oSay72 PROMPT "Acabamento 7"		  	SIZE 050, 007 OF oFolder1:aDialogs[4] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 005 MSGET oAcab13 VAR cAcab13  				SIZE 300, 010 OF oFolder1:aDialogs[4] COLORS 0, 16777215 PIXEL
	    @ nLin	, 310 SAY oSay77 PROMPT "Acabamento 7"		  	SIZE 050, 007 OF oFolder1:aDialogs[4] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 310 MSGET oAcab14 VAR cAcab14  				SIZE 300, 010 OF oFolder1:aDialogs[4] COLORS 0, 16777215 PIXEL
	    nLin	:= nLin+20
	    @ nLin	, 005 SAY oSay63 PROMPT "Acabamento 3"		  	SIZE 035, 007 OF oFolder1:aDialogs[3] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 005 MSGET oAcab5 VAR cAcab5  					SIZE 300, 010 OF oFolder1:aDialogs[3] COLORS 0, 16777215 PIXEL
	    @ nLin	, 310 SAY oSay68 PROMPT "Acabamento 3"		  	SIZE 035, 007 OF oFolder1:aDialogs[3] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 310 MSGET oAcab6 VAR cAcab6  					SIZE 300, 010 OF oFolder1:aDialogs[3] COLORS 0, 16777215 PIXEL
	    @ nLin	, 005 SAY oSay73 PROMPT "Acabamento 8"		  	SIZE 050, 007 OF oFolder1:aDialogs[4] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 005 MSGET oAcab15 VAR cAcab15  				SIZE 300, 010 OF oFolder1:aDialogs[4] COLORS 0, 16777215 PIXEL
	    @ nLin	, 310 SAY oSay78 PROMPT "Acabamento 8"		  	SIZE 050, 007 OF oFolder1:aDialogs[4] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 310 MSGET oAcab16 VAR cAcab16  				SIZE 300, 010 OF oFolder1:aDialogs[4] COLORS 0, 16777215 PIXEL
	    nLin	:= nLin+20
	    @ nLin	, 005 SAY oSay64 PROMPT "Acabamento 4"		  	SIZE 035, 007 OF oFolder1:aDialogs[3] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 005 MSGET oAcab7 VAR cAcab7  					SIZE 300, 010 OF oFolder1:aDialogs[3] COLORS 0, 16777215 PIXEL
	    @ nLin	, 310 SAY oSay69 PROMPT "Acabamento 4"		  	SIZE 035, 007 OF oFolder1:aDialogs[3] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 310 MSGET oAcab8 VAR cAcab8  					SIZE 300, 010 OF oFolder1:aDialogs[3] COLORS 0, 16777215 PIXEL
	    @ nLin	, 005 SAY oSay74 PROMPT "Acabamento 9"		  	SIZE 050, 007 OF oFolder1:aDialogs[4] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 005 MSGET oAcab17 VAR cAcab17  				SIZE 300, 010 OF oFolder1:aDialogs[4] COLORS 0, 16777215 PIXEL
	    @ nLin	, 310 SAY oSay79 PROMPT "Acabamento 9"		  	SIZE 050, 007 OF oFolder1:aDialogs[4] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 310 MSGET oAcab18 VAR cAcab18  				SIZE 300, 010 OF oFolder1:aDialogs[4] COLORS 0, 16777215 PIXEL
	    nLin	:= nLin+20
	    @ nLin	, 005 SAY oSay65 PROMPT "Acabamento 5"		  	SIZE 035, 007 OF oFolder1:aDialogs[3] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 005 MSGET oAcab9 VAR cAcab9  					SIZE 300, 010 OF oFolder1:aDialogs[3] COLORS 0, 16777215 PIXEL
	    @ nLin	, 310 SAY oSay70 PROMPT "Acabamento 5"		  	SIZE 040, 007 OF oFolder1:aDialogs[3] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 310 MSGET oAcab10 VAR cAcab10					SIZE 300, 010 OF oFolder1:aDialogs[3] COLORS 0, 16777215 PIXEL
	    @ nLin	, 005 SAY oSay75 PROMPT "Acabamento 10"		  	SIZE 050, 007 OF oFolder1:aDialogs[4] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 005 MSGET oAcab19 VAR cAcab19  				SIZE 300, 010 OF oFolder1:aDialogs[4] COLORS 0, 16777215 PIXEL
	    @ nLin	, 310 SAY oSay80 PROMPT "Acabamento 10"		  	SIZE 050, 007 OF oFolder1:aDialogs[4] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 310 MSGET oAcab20 VAR cAcab20  				SIZE 300, 010 OF oFolder1:aDialogs[4] COLORS 0, 16777215 PIXEL

	    nLin := 004
	    @ nLin	, 005 SAY oSay61 PROMPT "Ficha Tec 1"		  	SIZE 035, 007 OF oFolder1:aDialogs[5] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 005 MSGET oFicha1 VAR cFicha1					SIZE 300, 010 OF oFolder1:aDialogs[5] COLORS 0, 16777215 PIXEL
	    nLin	:= nLin+20
	    @ nLin	, 005 SAY oSay66 PROMPT "Ficha Tec 2"		  	SIZE 035, 007 OF oFolder1:aDialogs[5] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 005 MSGET oFicha2 VAR cFicha2					SIZE 300, 010 OF oFolder1:aDialogs[5] COLORS 0, 16777215 PIXEL
	    nLin	:= nLin+20
	    @ nLin	, 005 SAY oSay71 PROMPT "Ficha Tec 3"		  	SIZE 050, 007 OF oFolder1:aDialogs[5] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 005 MSGET oFicha3 VAR cFicha3					SIZE 300, 010 OF oFolder1:aDialogs[5] COLORS 0, 16777215 PIXEL
	    nLin	:= nLin+20
	    @ nLin	, 005 SAY oSay76 PROMPT "Ficha Tec 4"		  	SIZE 050, 007 OF oFolder1:aDialogs[5] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 005 MSGET oFicha4 VAR cFicha4  				SIZE 300, 010 OF oFolder1:aDialogs[5] COLORS 0, 16777215 PIXEL
	    nLin	:= nLin+20
	    @ nLin	, 005 SAY oSay62 PROMPT "Ficha Tec 5"		  	SIZE 035, 007 OF oFolder1:aDialogs[5] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 005 MSGET oFicha5 VAR cFicha5 				SIZE 300, 010 OF oFolder1:aDialogs[5] COLORS 0, 16777215 PIXEL
	    */
   	Else

		nLin	:= 004
		If _tp <> 1
	    	@ nLin	, 045 SAY oSay02 PROMPT "Desc. do Tipo" 	SIZE 050, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
	    	@ nLin+8, 045 MSGET oTipoDesc VAR cTipoDesc 		SIZE 155, 010 OF oFolder1:aDialogs[1] COLORS 0, 16777215 READONLY 		PIXEL
	    EndIf	
	    @ nLin	, 212 SAY oSay03 PROMPT "Origem Prod." 			SIZE 035, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 212 MSGET oOrigem VAR cOrigem 				SIZE 035, 010 OF oFolder1:aDialogs[1] VALID Gatilhos(2) COLORS 0, 16777215 F3 "S0" 	PIXEL
	    @ nLin	, 252 SAY oSay04 PROMPT "Desc. Origem Prod."	SIZE 070, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 252 MSGET oOrigemDesc VAR cOrigemDesc			SIZE 155, 010 OF oFolder1:aDialogs[1] COLORS 0, 16777215 READONLY 		PIXEL
	    @ nLin	, 419 SAY oSay05 PROMPT "Pos. IPI/NCM"			SIZE 040, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 419 MSGET oPosIPI VAR cPosIPI	 				SIZE 050, 010 PICTURE "@R 9999.99.99" OF oFolder1:aDialogs[1] VALID U_ExistCod(1,cPosIPI) COLORS 0, 16777215 F3 "SYD" PIXEL
	    @ nLin	, 489 SAY oSay06 PROMPT "ArmazÈm" 				SIZE 045, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 489 MSGET oArm VAR cArm 						SIZE 055, 010 OF oFolder1:aDialogs[1] VALID Gatilhos(12) PICTURE "@!" COLORS 0, 16777215 F3 "NNR" 		PIXEL
		@ nLin	, 559 SAY oSay07 PROMPT "Data de cadastro"		SIZE 055, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 559 MSGET oDtCad VAR dDtCad 					SIZE 055, 010 PICTURE "@D 99/99/9999" OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
		
		nLin	:= nLin+27
	    @ nLin	, 005 SAY oSay08 PROMPT "ReferÍncia" 			SIZE 050, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
	    
	    IF _tp = 2 .OR. _tp = 4
	       @ nLin+8, 005 MSGET oCodigo VAR cCodigo 				SIZE 050, 010 OF oFolder1:aDialogs[1] PICTURE "@!" COLORS 0, 16777215 READONLY 		PIXEL
	    Else
			If cTipo == "SV"
	       		@ nLin+8, 005 MSGET oCodigo VAR cCodigo 				SIZE 050, 010 OF oFolder1:aDialogs[1] PICTURE "@!" COLORS 0, 16777215 READONLY 		PIXEL
			Else
	       		@ nLin+8, 005 MSGET oCodigo VAR cCodigo 				SIZE 050, 010 OF oFolder1:aDialogs[1] VALID VldCod2(cCodigo) PICTURE "@!" COLORS 0, 16777215 PIXEL
			Endif
	    End
	    
	    @ nLin	, 060 SAY oSay09 PROMPT "DescriÁ„o"				SIZE 050, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 060 MSGET oCodigoDesc VAR cCodigoDesc			SIZE 140, 010 OF oFolder1:aDialogs[1] PICTURE "@!" COLORS 0, 16777215 PIXEL
	       
	    @ nLin	, 212 SAY oSay09 PROMPT "Unid.Med."				SIZE 035, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 212 MSGET oUM VAR cUM 						SIZE 035, 010 OF oFolder1:aDialogs[1] COLORS 0, 16777215 F3 "SAH" 		PIXEL
	    @ nLin	, 252 SAY oSay10 PROMPT "Grupo" 				SIZE 025, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
		@ nLin+8, 252 MSGET oGrupo VAR cGrupo					SIZE 035, 010 OF oFolder1:aDialogs[1] COLORS 0, 16777215 F3 "SBM"       PIXEL //"SBM-01"
		@ nLin	, 292 SAY oSay11 PROMPT "Desc. Grupo"			SIZE 035, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 292 MSGET oGrupoDesc VAR cGrupoDesc			SIZE 120, 010 OF oFolder1:aDialogs[1] COLORS 0, 16777215 READONLY 		PIXEL
//	    @ nLin	, 470 SAY oSay17 PROMPT "Coordenado" 			SIZE 035, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL // Marcelo Actual 210623
//	    @ nLin+8, 470 MSGET oSGrupo VAR cCoorden				SIZE 035, 010 OF oFolder1:aDialogs[1] COLORS 0, 16777215 F3 "SZQ" 		PIXEL
		@ nLin	, 459 SAY oSay18 PROMPT "Cta Contabil"			SIZE 050, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 459 MSGET oSGrupoDesc VAR cSGrupoDesc			SIZE 155, 010 OF oFolder1:aDialogs[1] COLORS 0, 16777215 F3 "CT1" 		PIXEL
		
		nLin	:= nLin+27
	    @ nLin	, 005 SAY oSay12 PROMPT "Linha" 				SIZE 045, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 005 MSGET oLinha VAR cLinha 					SIZE 055, 010 OF oFolder1:aDialogs[1] COLORS 0, 16777215 READONLY			PIXEL
	    @ nLin	, 075 SAY oSay13 PROMPT "Coluna" 				SIZE 045, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 075 MSGET oColuna VAR cColuna					SIZE 055, 010 VALID u_valacols(_tp, cColuna) OF oFolder1:aDialogs[1] PICTURE "@!" COLORS 0, 16777215 F3 "SBV" PIXEL
	    //@ nLin	, 145 SAY oSay14 PROMPT "Peso Liquido"			SIZE 045, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
	    //@ nLin+8, 145 MSGET oPeso VAR nPeso 					SIZE 055, 010 PICTURE "@E 999,999.9999" OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
	    @ nLin	, 145 SAY oSay14 PROMPT "Fornecedor"			SIZE 045, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 145 MSGET oFornece VAR cFornece				SIZE 055, 010 OF oFolder1:aDialogs[1] COLORS 0, 16777215 F3 "SA2" PIXEL
	    @ nLin	, 212 SAY oSay17 PROMPT "Ref. Fornecedor"		SIZE 045, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 212 MSGET oRefFor VAR cRefFor					SIZE 055, 010 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL

	    @ nLin	, 279 SAY oSay18 PROMPT "TES"					SIZE 045, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 279 MSGET oTES VAR cTES	 					SIZE 055, 010 OF oFolder1:aDialogs[1] COLORS 0, 16777215 F3 "SF4" PIXEL
	    @ nLin	, 346 SAY oSay19 PROMPT "Custo Std"				SIZE 045, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 346 MSGET oLarg VAR nCustSTD 					SIZE 055, 010 PICTURE "@E 999,999.999999" OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
	    @ nLin	, 419 SAY oSay15 PROMPT "Bloqueado"				SIZE 045, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 419 MSCOMBOBOX oBloqueio VAR cBloqueio		ITEMS {"Sim","N„o"}		SIZE 055, 013 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL

	    @ nLin	, 489 SAY oSay15 PROMPT "Lote/SubLote"			SIZE 045, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 489 MSCOMBOBOX oRastro VAR cRastro			ITEMS {"Lote","SubLote","Nao Utiliza"}		SIZE 055, 013 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
	    @ nLin	, 559 SAY oSay16 PROMPT "EndereÁo" 				SIZE 045, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 559 MSCOMBOBOX oEnd VAR cEnd 					ITEMS {"Sim","N„o"}							SIZE 055, 013 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
	    
	    nLin	:= nLin+27
	    @ nLin	, 005 SAY oSay18 PROMPT "Gramatura"			SIZE 045, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 005 MSGET oGramatL VAR nGramatL 				SIZE 055, 010 PICTURE "@E 9,999.99" OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
	    @ nLin	, 075 SAY oSay19 PROMPT "Largura"			SIZE 045, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
	    @ nLin+8, 075 MSGET oLargL VAR nLargL 					SIZE 055, 010 PICTURE "@E 9,999.99" OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
//	    @ nLin	, 145 SAY oSay18 PROMPT "Gram. Estamp."			SIZE 045, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
//	    @ nLin+8, 145 MSGET oGramatE VAR nGramatE 				SIZE 055, 010 PICTURE "@E 9,999.99" OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
//	    @ nLin	, 215 SAY oSay19 PROMPT "Larg. Estamp."			SIZE 045, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
//	    @ nLin+8, 215 MSGET oLargE VAR nLargE 					SIZE 055, 010 PICTURE "@E 9,999.99" OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL

//	    @ nLin	, 279 SAY oSay18 PROMPT "Gramatura"				SIZE 045, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
//	    @ nLin+8, 279 MSGET oGramat VAR nGramat 				SIZE 055, 010 PICTURE "@E 9,999.99" OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
//	    @ nLin	, 346 SAY oSay19 PROMPT "Largura"				SIZE 045, 007 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL
//	    @ nLin+8, 346 MSGET oLarg VAR nLarg 					SIZE 055, 010 PICTURE "@E 9,999.99" OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL


    Endif
 
oDlg:refresh()

Return 

//------------------------------------------------ 
Static Function fMSGrdVAR(_tp, cColuna)
//------------------------------------------------ 
// Acols para Variantes
// Tabela: SZA

Local nX
Local aHeaderEx := {}
Local aColsEx := {}
Local aFieldFill := {}
Local aFields := {"ZS_REF"}
Local aAlterFields := {}
Local _i
Static oMSVAR

// Define field properties
DbSelectArea("SX3")
SX3->(DbSetOrder(2))
If SX3->(DbSeek("ZS_ITEM"))
	Aadd(aHeaderEx, {alltrim(X3Titulo())+Space(4),"ZS_ITEM","@!",2,0,,SX3->X3_USADO,"C","","R","",""})
Endif

If SX3->(DbSeek("ZS_VARIANT"))
	Aadd(aHeaderEx, {alltrim(X3Titulo())+Space(4),"ZS_VARIANT","",240,0,,SX3->X3_USADO,"C","","R","",""})
Endif

If SX3->(DbSeek("ZS_DESCRI"))
	Aadd(aHeaderEx, {alltrim(X3Titulo())+Space(4),"ZS_DESCRI","",240,0,,SX3->X3_USADO,"C","","R","",""})
Endif
          
DbSelectArea("SZS")
DbSetOrder(1)
DbSeek(xfilial("SZS")+SubStr(cCodigo,1,8))

IF Found()
	While !EOF() .and. alltrim(ZS_REF) == alltrim(SubStr(cCodigo,1,8))
		aFieldFill := {}
  		Aadd(aFieldFill, SZS->ZS_ITEM)
		Aadd(aFieldFill, SZS->ZS_VARIANT)
		Aadd(aFieldFill, SZS->ZS_DESCRI)
  		Aadd(aFieldFill, .F.)
  		Aadd(aColsEx, aFieldFill)

		DbSelectArea("SZ7")
		DbSkip()
	End
Else
	DbSelectArea("SZS")
	DbSetOrder(1)
	DbSeek(xfilial("SZS")+alltrim(SubStr(cCodigo,1,8)))

	While !EOF() .and. alltrim(SZS->ZS_REF) == alltrim(SubStr(cCodigo,1,8))
		aFieldFill := {}
  		Aadd(aFieldFill, SZS->ZS_ITEM)
		Aadd(aFieldFill, SZS->ZS_VARIANT)
		Aadd(aFieldFill, SZS->ZS_DESCRI)
  		Aadd(aFieldFill, .F.)
  		Aadd(aColsEx, aFieldFill)

		DbSelectArea("SZD")
		DbSkip()
	End
Endif 

oMSVAR   := MsNewGetDados():New( 131, 005, 275, 624, GD_UPDATE, "AllwaysTrue", "AllwaysTrue", "+Field1+Field2", aAlterFields,, 999, "AllwaysTrue", "", "AllwaysTrue", oEst, aHeaderEx, aColsEx)

Return

//------------------------------------------------ 
Static Function fMSGrdSKU(_tp, cColuna)
//------------------------------------------------ 
// Acols para SKU por cor e tamanho
// Tabela: SZA

Local nX
Local aHeaderEx := {}
Local aColsEx := {}
Local aFieldFill := {}
Local aFields := {"Z7_COR","Z7_COR","Z7_CORCLI"}
Local aAlterFields := {"Z7_CORCLI"}
Local _i
Static oMSSKU

// Define field properties
DbSelectArea("SX3")
SX3->(DbSetOrder(2))
If SX3->(DbSeek("Z7_COR"))
	Aadd(aHeaderEx, {alltrim(X3Titulo())+Space(4),"Z7_COR","@!",5,0,,SX3->X3_USADO,"C","","R","",""})
 	Aadd(aHeaderEx, {"DescriÁ„o"+Space(4),"Z7_COR","@!",10,0,,SX3->X3_USADO,"C","","R","",""})
 	Aadd(aHeaderEx, {"Cor Cliente","Z7_CORCLI","@!",30,0,,SX3->X3_USADO,"C","","R","",""})
Endif

DbSelectArea("SZD")
DbSetOrder(1)
DbSeek(xfilial("SZD")+alltrim(cCodigo))
_XTAM := {}	
While !EOF() .and. alltrim(SZD->ZD_PRODUTO) == alltrim(cCodigo)
	For _i := 1 to 25
  		_campo := "SZD->ZD_TAM"+StrZero(_i,3)
  		If &_campo == "X"
  			_tem := ASCAN( _xtam, {|x| x == _i})
  			If _tem == 0
  				aadd(_xtam,_i)
  			Endif
  		Endif
  	Next

  	DbSelectarea("SZD")
  	DbSkip()
End

aSort(_xtam)
  
For _i := 1 to len(_xtam)
  	DbSelectArea("SB4")
  	DbSetOrder(1)
  	DbSeek(xfilial("SB4")+alltrim(cCodigo))
  	_desc := rettam(_xtam[_i],SB4->B4_COLUNA,"D") 
	DbSelectArea("SX3")
	_campo := "Z7_TAM"+StrZero(_xtam[_i],3)
  	Aadd(aFields,_campo) 
  	Aadd(aAlterFields,_campo)

	SX3->(DbSetOrder(2))
   	If SX3->(DbSeek(_campo))
      	Aadd(aHeaderEx, {alltrim(_desc)+Space(4),SX3->X3_CAMPO,SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL,"",;
                       SX3->X3_USADO,SX3->X3_TIPO,"",SX3->X3_CONTEXT,SX3->X3_CBOX,SX3->X3_RELACAO})
	Endif 
  
Next

DbSelectArea("SZD")
DbSetOrder(1)
If DbSeek(xfilial("SZD")+alltrim(cCodigo))
	While SZD->(!EOF()) .and. alltrim(SZD->ZD_PRODUTO) == alltrim(cCodigo)
		aFieldFill := {}
		
		DbSelectArea("SZ7")
		DbSetOrder(1)
		If DbSeek(xfilial("SZ7")+Padr(cCodigo,15)+SZD->ZD_COR)
			Aadd(aFieldFill, SZ7->Z7_COR)
			Aadd(aFieldFill,POSICIONE("SBV",1,xFilial("SBV")+'COR'+SZ7->Z7_COR,"BV_DESCRI")) 
			Aadd(aFieldFill, SZ7->Z7_CORCLI)
			For nX := 4 to Len(aHeaderEx)
				_campo := "SZ7->"+aheaderEx[nX][2]
	  			Aadd(aFieldFill,&_campo)
	  		Next
	  		Aadd(aFieldFill, .F.)
	  		Aadd(aColsEx, aFieldFill)
	  	Else
	  		Aadd(aFieldFill, SZD->ZD_COR)
			Aadd(aFieldFill,POSICIONE("SBV",1,xFilial("SBV")+'COR'+SZD->ZD_COR,"BV_DESCRI")) 
			Aadd(aFieldFill, SPACE(30))
			For nX := 4 to Len(aHeaderEx)
	  			Aadd(aFieldFill,SPACE(15))
	  		Next
	  		Aadd(aFieldFill, .F.)
	  		Aadd(aColsEx, aFieldFill)
		EndIf
		
		SZD->(DbSkip())
	EndDo
EndIf

oMSSKU   := MsNewGetDados():New( 131, 005, 275, 624, GD_UPDATE, "AllwaysTrue", "AllwaysTrue", "+Field1+Field2", aAlterFields,, 999, "AllwaysTrue", "", "AllwaysTrue", oEst, aHeaderEx, aColsEx)

Return

/*If alltrim(oMSNewGe1:aCols[oMSNewGe1:nAT,1]) <> ""

	DbSelectArea("SZ7")
	DbSetOrder(1)
	DbSeek(xfilial("SZ7")+SubStr(cProduto,1,15))
	
	IF Found()
		
		While !EOF() .and. alltrim(Z7_PRODUTO) == alltrim(cProduto)
			aFieldFill := {}
  			Aadd(aFieldFill, SZ7->Z7_COR)
			Aadd(aFieldFill,POSICIONE("SBV",1,xFilial("SBV")+'COR'+SZ7->Z7_COR,"BV_DESCRI")) 
			For nX := 3 to Len(aHeaderEx)-2
				_campo := "SZ7->"+aheaderEx[nX][2]//Z7_TAM"+StrZero(nX,3)
	  			Aadd(aFieldFill,&_campo)
  			Next
  			Aadd(aFieldFill, .F.)
  			Aadd(aColsEx, aFieldFill)
	
			DbSelectArea("SZ7")
			DbSkip()
		End
	Else
		DbSelectArea("SZD")
		DbSetOrder(1)
		DbSeek(xfilial("SZD")+alltrim(cProduto))

		While !EOF() .and. alltrim(SZD->ZD_PRODUTO) == alltrim(cProduto)
			aFieldFill := {}
  			Aadd(aFieldFill, SZD->ZD_COR)
			Aadd(aFieldFill,POSICIONE("SBV",1,xFilial("SBV")+'COR'+SZD->ZD_COR,"BV_DESCRI")) 
			For nX := 3 to Len(aHeaderEx)-2
	  			Aadd(aFieldFill,"")
  			Next
  			Aadd(aFieldFill, .F.)
  			Aadd(aColsEx, aFieldFill)

			DbSelectArea("SZD")
			DbSkip()
		End
	Endif
Else
	DbSelectArea("SZD")
	DbSetOrder(1)
	DbSeek(xfilial("SZD")+alltrim(cProduto))

	While !EOF() .and. alltrim(SZD->ZD_PRODUTO) == alltrim(cProduto)
		aFieldFill := {}
		Aadd(aFieldFill, SZD->ZD_COR)
		Aadd(aFieldFill,POSICIONE("SBV",1,xFilial("SBV")+'COR'+SZD->ZD_COR,"BV_DESCRI")) 

		For nX := 3 to Len(aHeaderEx)-2
  			Aadd(aFieldFill,0)
		Next
		Aadd(aFieldFill, oMSNewGe1:aCols[oMSNewGe1:nAT,1])
		Aadd(aFieldFill, oMSNewGe1:aCols[oMSNewGe1:nAT,2])
		Aadd(aFieldFill, .F.)
		Aadd(aColsEx, aFieldFill)

		DbSelectArea("SZD")
		DbSkip()
	End
Endif     

  oMSQtd := MsNewGetDados():New( 190, 006, 275, 500, GD_UPDATE, "AllwaysTrue", "AllwaysTrue", "+Field1+Field2", aAlterFields,, 999, "AllwaysTrue", "", "AllwaysTrue", oEst, aHeaderEx, aColsEx)

Return
*/

//Carrega a grade da tabela
//------------------------------------------------
Static Function fMSGrade(_tp, cColuna)
//------------------------------------------------
// Monta acols para cadastro da Grade de Produtos
// Tabelas envolvidas: SZD

Local nX
Local aHeaderEx := {}
Local aColsEx := {}
Local aFieldFill := {}
Local aFields := {"ZD_COR","ZD_DESCRIC","ZD_COMPOS","ZD_DESCCP2","ZD_DESCCOM","ZD_DESCLAV","ZD_LAVAGE"} //"ZD_DTLIB","ZD_SITUAC",
Local aAlterFields := {"ZD_COR","ZD_DESCRIC","ZD_COMPOS","ZD_DESCCP2","ZD_DESCCOM","ZD_LAVAGE"}
Static oMSGrade

  // Define field properties
  DbSelectArea("SX3")
  SX3->(DbSetOrder(2))
  If SX3->(DbSeek("ZD_COR"))
    Aadd(aHeaderEx, {alltrim(X3Titulo())+Space(4),"ZD_COR","@!",5,0,,SX3->X3_USADO,"C","","R","",""})
  Endif
  If SX3->(DbSeek("ZD_DESCRIC"))
    Aadd(aHeaderEx, {alltrim(X3Titulo())+Space(4),"ZD_DESCRIC","@!",20,0,,SX3->X3_USADO,"C","","R","",""})
  Endif
  If SX3->(DbSeek("ZD_COMPOS"))
    Aadd(aHeaderEx, {alltrim(X3Titulo())+Space(4),"ZD_COMPOS","@!",20,0,,SX3->X3_USADO,"C","","R","",""})
  Endif
  If SX3->(DbSeek("ZD_DESCCP2"))
    Aadd(aHeaderEx, {alltrim(X3Titulo())+Space(4),"ZD_DESCCP2","@!",20,0,,SX3->X3_USADO,"C","","R","",""})
  Endif
  If SX3->(DbSeek("ZD_DESCCOM"))
    Aadd(aHeaderEx, {alltrim("Modelo")+Space(4),"ZD_DESCCOM","@!",20,0,,SX3->X3_USADO,"C","","R","",""})
  Endif


  If alltrim(cColuna) <> "" 
      // Busca os tamanhos disponÌveis selecionados na tabela SBV
      
	  cQuery  := "SELECT BV_FILIAL, BV_TABELA, BV_CHAVE, BV_DESCRI FROM " +RetSQLName("SBV") + " WHERE "
	  cQuery  += "BV_FILIAL = '" +xFilial("SBV") +"' AND BV_TABELA = '" +cColuna +"' AND D_E_L_E_T_ = '' " 
	  cQuery += "ORDER BY R_E_C_N_O_"

	  cQuery := ChangeQuery(cQuery)
	  
	  If Select("TMPSBV") > 0 
     	 TMPSBV->(DbCloseArea()) 
	  EndIf 
	  dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TMPSBV",.T.,.T.)

	  //Conta total e registros     
	  Count To nRecTMPSBV
	  If nRecTMPSBV == 0
		  oColuna:SetFocus()
	  EndIf 
 	  
  	DbSelectArea("TMPSBV")
  	DbGoTop()
 	   	
  	While !EOF() .and. Alltrim(TMPSBV->BV_TABELA) == Alltrim(cColuna)
		DbSelectArea("SX3")
		// Habilita as colunas com os tamanhos no Acols utilizando a tabela SZD atÈ o tamanho m·ximo de 200
		_campo := "ZD_TAM"+StrZero(len(aFields)-6,3)
	  	Aadd(aFields,_campo) //TMPSBV->BV_CHAVE)
	  	Aadd(aAlterFields,_campo)

  		SX3->(DbSetOrder(2))
    	If SX3->(DbSeek(_campo))
       		Aadd(aHeaderEx, {alltrim(TMPSBV->BV_DESCRI)+Space(4),SX3->X3_CAMPO,"@!",1,0,"",SX3->X3_USADO,"C","","R","",""})
 		Endif 
  	
  		DbSelectArea("TMPSBV")
  		DbSkip()
  	End
  	DbClosearea()
  Else
  	// Caso n„o tenha um tamanho cadastrado, habilita um tamanho ˙nico
  	Aadd(aFields,"ZD_TAM001")
  	Aadd(aAlterFields,"ZD_TAM001")

	DbSelectArea("SX3")
  	SX3->(DbSetOrder(2))
    If SX3->(DbSeek("ZD_TAM001"))
       Aadd(aHeaderEx, {AllTrim("Unico"),SX3->X3_CAMPO,"@!",1,0,"",SX3->X3_USADO,"C","","R","",""})
 	Endif 
  Endif
  If SX3->(DbSeek("ZD_DESCLAV"))
    Aadd(aHeaderEx, {AllTrim(X3Titulo())+Space(4),"ZD_DESCLAV",SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL,SX3->X3_VALID,;
                       SX3->X3_USADO,SX3->X3_TIPO,SX3->X3_F3,SX3->X3_CONTEXT,SX3->X3_CBOX,SX3->X3_RELACAO})
  Endif
  If SX3->(DbSeek("ZD_LAVAGE"))
    Aadd(aHeaderEx, {AllTrim(X3Titulo())+Space(4),"ZD_LAVAGE",SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL,SX3->X3_VALID,;
                       SX3->X3_USADO,SX3->X3_TIPO,SX3->X3_F3,SX3->X3_CONTEXT,SX3->X3_CBOX,SX3->X3_RELACAO})
  Endif
  // Define field values
  If _tp = 1
  	For nX := 1 to Len(aFields)
	   If nX == 1
    		Aadd(aFieldFill, Space(5))
    	ElseIf nX == 2 .or. nX == 3
    		Aadd(aFieldFill, Space(20))    	
    	ElseIf nX == 5
    		Aadd(aFieldFill, Space(100))    	
    	ElseIf nX == Len(aFields)
    		Aadd(aFieldFill, Space(0))
    	Else
	      	Aadd(aFieldFill, Space(1))
    	Endif
  	Next nX
  	Aadd(aFieldFill, .F.)
  	Aadd(aColsEx, aFieldFill)
  Else
		DbSelectArea("SZD")
		DbSetOrder(1)
		DbSeek(xfilial("SZD")+SubString(SB4->B4_COD,1,15))
  		
  		While !EOF() .and. SubString(SZD->ZD_PRODUTO,1,15) = SubString(SB4->B4_COD,1,15)
  		
  			Aadd(aFieldFill, SZD->ZD_COR)
  			Aadd(aFieldFill, SZD->ZD_DESCRIC)
  			Aadd(aFieldFill, SZD->ZD_COMPOS)
  			Aadd(aFieldFill, SZD->ZD_DESCCP2)
			Aadd(aFieldFill, SZD->ZD_DESCCOM)
		  	For nX := 6 to (Len(aFields)-2)
				_campo := "SZD->ZD_TAM"+StrZero(nX-5,3)
	  			Aadd(aFieldFill,&_campo) //TMPSBV->BV_CHAVE)
  			Next
  			Aadd(aFieldFill, SZD->ZD_DESCLAV)
  			Aadd(aFieldFill, SZD->ZD_LAVAGE)
  			Aadd(aFieldFill, .F.)
  			Aadd(aColsEx, aFieldFill)
  			aFieldFill :={}
  			DbSkip()
  		End  
  Endif
  
  oMSGrade := MsNewGetDados():New( 131, 005, 275, 624, GD_INSERT+GD_DELETE+GD_UPDATE, "AllwaysTrue", "AllwaysTrue", "+Field1+Field2", aAlterFields,, 999, "AllwaysTrue", "", "AllwaysTrue", oDlg, aHeaderEx, aColsEx)
    
Return


/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥ hLavage  ∫Autor  ≥Daniel R. Melo      ∫ Data ≥ 27/02/2017  ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Desc.     ≥                                                            ∫±±
±±∫          ≥                                                            ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥                                                            ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
Static Function hLavage()                        

Local nx
Local oBitmap1
Local oBitmap2
Local oBitmap3
Local oBitmap4
Local oBitmap5
Local oBitmap6
Local oBitmap7
Local oBitmap8
Local oBitmap9
Local oBitmap10
Local oBitmap11
Local oBitmap12
Local oBitmap14
Local oBitmap15
Local oBitmap16
Local oBitmap17
Local oBitmap18
Local oBitmap19
Local oBitmap20
Local oBitmap21
Local oBitmap22
Local oBitmap23
Local oBitmap24
Local oBitmap25
Local oBitmap26
Local oBitmap27
Local oBitmap28
Local oBitmap29
Local oBitmap30
Local oBitmap31
Local oBitmap32
Local oBitmap33
Local oBitmap34
Local oBitmap35
Local oBitmap36
Local oBitmap37
Local oBitmap38
Local oBitmap39
Local oBitmap41
Local oBitmap42
Local oBitmap43
Local oBitmap44
Local oBitmap45
Local oBitmap46
Local oBitmap47
Local oBitmap48
Local oBitmap49
Local oBitmap50
Local oBitmap51
Local oBitmap52
Local oBitmap53
Local oBitmap54
Local oBitmap55

Local oCheckBo1
Local oCheckBo2
Local oCheckBo3
Local oCheckBo4
Local oCheckBo5
Local oCheckBo6
Local oCheckBo7
Local oCheckBo8
Local oCheckBo9
Local oCheckBo10
Local oCheckBo11
Local oCheckBo12
Local oCheckBo13
Local oCheckBo14
Local oCheckBo15
Local oCheckBo16
Local oCheckBo17
Local oCheckBo18
Local oCheckBo19
Local oCheckBo20
Local oCheckBo21
Local oCheckBo22
Local oCheckBo23
Local oCheckBo24
Local oCheckBo25
Local oCheckBo26
Local oCheckBo27
Local oCheckBo28
Local oCheckBo29
Local oCheckBo30
Local oCheckBo31
Local oCheckBo32
Local oCheckBo33
Local oCheckBo34
Local oCheckBo35
Local oCheckBo36
Local oCheckBo37
Local oCheckBo38
Local oCheckBo39
Local oCheckBo40
Local oCheckBo41
Local oCheckBo42
Local oCheckBo43
Local oCheckBo44
Local oCheckBo45
Local oCheckBo46
Local oCheckBo47
Local oCheckBo48
Local oCheckBo49
Local oCheckBo50
Local oCheckBo51
Local oCheckBo52
Local oCheckBo53
Local oCheckBo54
Local oCheckBo55

Local oButton1
Local oButton2
Local oButton3

Private lCheckBo1 := .F.
Private lCheckBo2 := .F.
Private lCheckBo3 := .F.
Private lCheckBo4 := .F.
Private lCheckBo5 := .F.
Private lCheckBo6 := .F.
Private lCheckBo7 := .F.
Private lCheckBo8 := .F.
Private lCheckBo9 := .F.
Private lCheckBo10 := .F.
Private lCheckBo11 := .F.
Private lCheckBo12 := .F.
Private lCheckBo13 := .F.
Private lCheckBo14 := .F.
Private lCheckBo15 := .F.
Private lCheckBo16 := .F.
Private lCheckBo17 := .F.
Private lCheckBo18 := .F.
Private lCheckBo19 := .F.
Private lCheckBo20 := .F.
Private lCheckBo21 := .F.
Private lCheckBo22 := .F.
Private lCheckBo23 := .F.
Private lCheckBo24 := .F.
Private lCheckBo25 := .F.
Private lCheckBo26 := .F.
Private lCheckBo27 := .F.
Private lCheckBo28 := .F.
Private lCheckBo29 := .F.
Private lCheckBo30 := .F.
Private lCheckBo31 := .F.
Private lCheckBo32 := .F.
Private lCheckBo33 := .F.
Private lCheckBo34 := .F.
Private lCheckBo35 := .F.
Private lCheckBo36 := .F.
Private lCheckBo37 := .F.
Private lCheckBo38 := .F.
Private lCheckBo39 := .F.
Private lCheckBo40 := .F.
Private lCheckBo41 := .F.
Private lCheckBo42 := .F.
Private lCheckBo43 := .F.
Private lCheckBo44 := .F.
Private lCheckBo45 := .F.
Private lCheckBo46 := .F.
Private lCheckBo47 := .F.
Private lCheckBo48 := .F.
Private lCheckBo49 := .F.
Private lCheckBo50 := .F.
Private lCheckBo51 := .F.
Private lCheckBo52 := .F.
Private lCheckBo53 := .F.
Private lCheckBo54 := .F.
Private lCheckBo55 := .F.

Private oSay0
Private oSay1
Private oSay2
Private oSay3
Private oSay4
Private oSay5
Private oSay6
Private oSay7
Private oSay8
Private oSay9
Private oSay10
Private oSay11
Private oSay12
Private oSay13
Private oSay14
Private oSay15
Private oSay16
Private oSay17
Private oSay18
Private oSay19
Private oSay20
Private oSay21
Private oSay22
Private oSay23
Private oSay24
Private oSay25
Private oSay26
Private oSay27
Private oSay28
Private oSay29
Private oSay30
Private oSay31
Private oSay32
Private oSay33
Private oSay34
Private oSay35
Private oSay36
Private oSay37
Private oSay38
Private oSay39
Private oSay40
Private oSay41
Private oSay42
Private oSay43
Private oSay44
Private oSay45
Private oSay46
Private oSay47
Private oSay48
Private oSay49
Private oSay50
Private oSay51
Private oSay52
Private oSay53
Private oSay54
Private oSay55

Private MvParCod := Alltrim(oMSGrade:aCols[oMSGrade:nat,len(OMSGrade:aHeader)])+","   // Carrega Nome da Variavel do Get em Questao
Private MvParTxt := ""
Private nx	

If MvParCod <> ","
	For nx := 1 to len(MvParCod) step 3
		cAux2 	:= SubStr(MvParCod,nx,2)
		cCheck		:= "lCheckBo"+cValToChar(Val(cAux2))
	 	&cCheck		:= .T.
	Next
Else
	MvParCod := ""
End

Static oDlgLav 

/*@ 007, nCol BITMAP oBitmap45 SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\43.jpg" NOBORDER PIXEL
    @ 030, nCol BITMAP oBitmap46 SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\44.jpg" NOBORDER PIXEL
    @ 052, nCol BITMAP oBitmap47 SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\45.jpg" NOBORDER PIXEL
    @ 075, nCol BITMAP oBitmap48 SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\46.jpg" NOBORDER PIXEL
    @ 097, nCol BITMAP oBitmap49 SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\47.jpg" NOBORDER PIXEL
    @ 120, nCol BITMAP oBitmap50 SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\48.jpg" NOBORDER PIXEL
    @ 142, nCol BITMAP oBitmap51 SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\49.jpg" NOBORDER PIXEL
    @ 165, nCol BITMAP oBitmap52 SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\50.jpg" NOBORDER PIXEL
    @ 187, nCol BITMAP oBitmap53 SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\51.jpg" NOBORDER PIXEL
    @ 210, nCol BITMAP oBitmap54 SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\52.jpg" NOBORDER PIXEL
//    @ 232, nCol BITMAP oBitmap55 SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\??.jpg" NOBORDER PIXEL*/

nLin01 := 007
nLin02 := 030
nLin03 := 052
nLin04 := 075
nLin05 := 097
nLin06 := 120
nLin07 := 142
nLin08 := 165
nLin09 := 187
nLin10 := 210
nLin11 := 232

DEFINE FONT oFont1 NAME "Arial" SIZE 0,12

  DEFINE MSDIALOG oDlgLav TITLE "New Dialog" FROM 000, 000  TO 520, 1300 COLORS 0, 16777215 PIXEL

	nCol := 7
    	@ nLin01, nCol BITMAP oBitmap1  SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\01.jpg" NOBORDER PIXEL
    	@ nLin02, nCol BITMAP oBitmap2  SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\02.jpg" NOBORDER PIXEL
    	@ nLin03, nCol BITMAP oBitmap3  SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\03.jpg" NOBORDER PIXEL
    	@ nLin04, nCol BITMAP oBitmap4  SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\04.jpg" NOBORDER PIXEL
    	@ nLin05, nCol BITMAP oBitmap5  SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\05.jpg" NOBORDER PIXEL
    	@ nLin06, nCol BITMAP oBitmap6  SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\06.jpg" NOBORDER PIXEL
    	@ nLin07, nCol BITMAP oBitmap7  SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\07.jpg" NOBORDER PIXEL
    	@ nLin08, nCol BITMAP oBitmap8  SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\08.jpg" NOBORDER PIXEL
    	@ nLin09, nCol BITMAP oBitmap9  SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\09.jpg" NOBORDER PIXEL
    	@ nLin10, nCol BITMAP oBitmap10 SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\10.jpg" NOBORDER PIXEL
    	@ nLin11, nCol BITMAP oBitmap11 SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\11.jpg" NOBORDER PIXEL
    	nCol := nCol+22
    	@ nLin01, nCol CHECKBOX oCheckBo1  VAR lCheckBo1  PROMPT "" SIZE 010, 008 VALID SelCheck(1)  OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin02, nCol CHECKBOX oCheckBo2  VAR lCheckBo2  PROMPT "" SIZE 010, 008 VALID SelCheck(2)  OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin03, nCol CHECKBOX oCheckBo3  VAR lCheckBo3  PROMPT "" SIZE 010, 008 VALID SelCheck(3)  OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin04, nCol CHECKBOX oCheckBo4  VAR lCheckBo4  PROMPT "" SIZE 010, 008 VALID SelCheck(4)  OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin05, nCol CHECKBOX oCheckBo5  VAR lCheckBo5  PROMPT "" SIZE 010, 008 VALID SelCheck(5)  OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin06, nCol CHECKBOX oCheckBo6  VAR lCheckBo6  PROMPT "" SIZE 010, 008 VALID SelCheck(6)  OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin07, nCol CHECKBOX oCheckBo7  VAR lCheckBo7  PROMPT "" SIZE 010, 008 VALID SelCheck(7)  OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin08, nCol CHECKBOX oCheckBo8  VAR lCheckBo8  PROMPT "" SIZE 010, 008 VALID SelCheck(8)  OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin09, nCol CHECKBOX oCheckBo9  VAR lCheckBo9  PROMPT "" SIZE 010, 008 VALID SelCheck(9)  OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin10, nCol CHECKBOX oCheckBo10 VAR lCheckBo10 PROMPT "" SIZE 010, 008 VALID SelCheck(10) OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin11, nCol CHECKBOX oCheckBo11 VAR lCheckBo11 PROMPT "" SIZE 010, 008 VALID SelCheck(11) OF oDlgLav COLORS 0, 16777215 PIXEL
    	nCol := nCol+11
    	@ nLin01, nCol SAY oSay1  PROMPT "LAVAGEM NORMAL" 						   			FONT oFont1 SIZE 085, 016 OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin02, nCol SAY oSay2  PROMPT "TEMP.MAXIMA 95∫C - TRATATAMENTO BRANDO" 			FONT oFont1 SIZE 085, 016 OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin03, nCol SAY oSay3  PROMPT "TEMP.MAXIMA 90∫C - NORMAL" 			  	  		FONT oFont1 SIZE 085, 016 OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin04, nCol SAY oSay4  PROMPT "TEMP.MAXIMA 90∫C - TRATATAMENTO BRANDO" 			FONT oFont1 SIZE 085, 016 OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin05, nCol SAY oSay5  PROMPT "TEMP.MAXIMA 70∫C - NORMAL" 						FONT oFont1 SIZE 085, 016 OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin06, nCol SAY oSay6  PROMPT "TEMP.MAXIMA 60∫C - NORMAL" 						FONT oFont1 SIZE 085, 016 OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin07, nCol SAY oSay7  PROMPT "TEMP.MAXIMA 60∫C - TRATATAMENTO BRANDO" 			FONT oFont1 SIZE 085, 016 OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin08, nCol SAY oSay8  PROMPT "TEMP.MAXIMA 50∫C - TRATATAMENTO BRANDO" 			FONT oFont1 SIZE 085, 016 OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin09, nCol SAY oSay9  PROMPT "TEMP.MAXIMA 40∫C - NORMAL" 						FONT oFont1 SIZE 085, 016 OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin10, nCol SAY oSay10 PROMPT "TEMP.MAXIMA 40∫C - TRATATAMENTO BRANDO" 			FONT oFont1 SIZE 085, 016 OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin11, nCol SAY oSay11 PROMPT "TEMP.MAXIMA 40∫C - TRATATAMENTO MUITO BRANDO" 	FONT oFont1 SIZE 085, 016 OF oDlgLav COLORS 0, 16777215 PIXEL

	nCol := nCol+95
    	@ nLin01, nCol BITMAP oBitmap12 SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\12.jpg" NOBORDER PIXEL
    	@ nLin02, nCol BITMAP oBitmap13 SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\13.jpg" NOBORDER PIXEL
    	@ nLin03, nCol BITMAP oBitmap14 SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\14.jpg" NOBORDER PIXEL
    	@ nLin04, nCol BITMAP oBitmap15 SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\15.jpg" NOBORDER PIXEL
    	@ nLin05, nCol BITMAP oBitmap16 SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\16.jpg" NOBORDER PIXEL
    	@ nLin06, nCol BITMAP oBitmap17 SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\17.jpg" NOBORDER PIXEL
    	@ nLin07, nCol BITMAP oBitmap18 SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\18.jpg" NOBORDER PIXEL
    	@ nLin08, nCol BITMAP oBitmap19 SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\19.jpg" NOBORDER PIXEL
    	@ nLin09, nCol BITMAP oBitmap20 SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\20.jpg" NOBORDER PIXEL
    	@ nLin10, nCol BITMAP oBitmap21 SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\21.jpg" NOBORDER PIXEL
    	@ nLin11, nCol BITMAP oBitmap22 SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\22.jpg" NOBORDER PIXEL
    	nCol := nCol+22
    	@ nLin01, nCol CHECKBOX oCheckBo12 VAR lCheckBo12 PROMPT "" SIZE 010, 008 VALID SelCheck(12) OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin02, nCol CHECKBOX oCheckBo13 VAR lCheckBo13 PROMPT "" SIZE 010, 008 VALID SelCheck(13) OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin03, nCol CHECKBOX oCheckBo14 VAR lCheckBo14 PROMPT "" SIZE 010, 008 VALID SelCheck(14) OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin04, nCol CHECKBOX oCheckBo15 VAR lCheckBo15 PROMPT "" SIZE 010, 008 VALID SelCheck(15) OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin05, nCol CHECKBOX oCheckBo16 VAR lCheckBo16 PROMPT "" SIZE 010, 008 VALID SelCheck(16) OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin06, nCol CHECKBOX oCheckBo17 VAR lCheckBo17 PROMPT "" SIZE 010, 008 VALID SelCheck(17) OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin07, nCol CHECKBOX oCheckBo18 VAR lCheckBo18 PROMPT "" SIZE 010, 008 VALID SelCheck(18) OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin08, nCol CHECKBOX oCheckBo19 VAR lCheckBo19 PROMPT "" SIZE 010, 008 VALID SelCheck(19) OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin09, nCol CHECKBOX oCheckBo20 VAR lCheckBo20 PROMPT "" SIZE 010, 008 VALID SelCheck(20) OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin10, nCol CHECKBOX oCheckBo21 VAR lCheckBo21 PROMPT "" SIZE 010, 008 VALID SelCheck(21) OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin11, nCol CHECKBOX oCheckBo22 VAR lCheckBo22 PROMPT "" SIZE 010, 008 VALID SelCheck(22) OF oDlgLav COLORS 0, 16777215 PIXEL
    	nCol := nCol+11
    	@ nLin01, nCol SAY oSay12 PROMPT "TEMP.MAXIMA 30∫C - PROCESSO SUAVE" 			FONT oFont1 SIZE 085, 016 OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin02, nCol SAY oSay13 PROMPT "SOMENTE LAVAGEM MANUAL" 						FONT oFont1 SIZE 085, 016 OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin03, nCol SAY oSay14 PROMPT "NAO LAVAR" 									FONT oFont1 SIZE 085, 016 OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin04, nCol SAY oSay15 PROMPT "ALVEJAMENTO A BASE DE CLORO" 				 	FONT oFont1 SIZE 085, 016 OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin05, nCol SAY oSay16 PROMPT "PERMITIDO ALVEJAMENTO COM CLORO DILUIDO"	 	FONT oFont1 SIZE 085, 016 OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin06, nCol SAY oSay17 PROMPT "NAO ALVEJAR" 									FONT oFont1 SIZE 085, 016 OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin07, nCol SAY oSay18 PROMPT "SECAGEM" 										FONT oFont1 SIZE 085, 016 OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin08, nCol SAY oSay19 PROMPT "SECAGEM NA HORIZONTAL A SOMBRA" 				FONT oFont1 SIZE 085, 016 OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin09, nCol SAY oSay20 PROMPT "PERMITIDO TAMBOR ROTATIVO COM TEMP.MAXIMA" 	FONT oFont1 SIZE 085, 016 OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin10, nCol SAY oSay21 PROMPT "PERMITIDO TAMBOR ROTATIVO COM TEMP.MINIMA"	FONT oFont1 SIZE 085, 016 OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin11, nCol SAY oSay22 PROMPT "NAO SECAR EM TAMBOR" 							FONT oFont1 SIZE 085, 016 OF oDlgLav COLORS 0, 16777215 PIXEL

	nCol := nCol+95
    	@ nLin01, nCol BITMAP oBitmap23 SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\23.jpg" NOBORDER PIXEL
    	@ nLin02, nCol BITMAP oBitmap24 SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\24.jpg" NOBORDER PIXEL
    	@ nLin03, nCol BITMAP oBitmap25 SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\25.jpg" NOBORDER PIXEL
    	@ nLin04, nCol BITMAP oBitmap26 SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\26.jpg" NOBORDER PIXEL
    	@ nLin05, nCol BITMAP oBitmap27 SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\27.jpg" NOBORDER PIXEL
    	@ nLin06, nCol BITMAP oBitmap28 SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\28.jpg" NOBORDER PIXEL
    	@ nLin07, nCol BITMAP oBitmap29 SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\29.jpg" NOBORDER PIXEL
    	@ nLin08, nCol BITMAP oBitmap30 SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\30.jpg" NOBORDER PIXEL
    	@ nLin09, nCol BITMAP oBitmap31 SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\31.jpg" NOBORDER PIXEL
    	@ nLin10, nCol BITMAP oBitmap32 SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\32.jpg" NOBORDER PIXEL
    	@ nLin11, nCol BITMAP oBitmap37 SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\37.jpg" NOBORDER PIXEL
    	nCol := nCol+22
    	@ nLin01, nCol CHECKBOX oCheckBo23 VAR lCheckBo23 PROMPT "" SIZE 010, 008 VALID SelCheck(23) OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin02, nCol CHECKBOX oCheckBo24 VAR lCheckBo24 PROMPT "" SIZE 010, 008 VALID SelCheck(24) OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin03, nCol CHECKBOX oCheckBo25 VAR lCheckBo25 PROMPT "" SIZE 010, 008 VALID SelCheck(25) OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin04, nCol CHECKBOX oCheckBo26 VAR lCheckBo26 PROMPT "" SIZE 010, 008 VALID SelCheck(26) OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin05, nCol CHECKBOX oCheckBo27 VAR lCheckBo27 PROMPT "" SIZE 010, 008 VALID SelCheck(27) OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin06, nCol CHECKBOX oCheckBo28 VAR lCheckBo28 PROMPT "" SIZE 010, 008 VALID SelCheck(28) OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin07, nCol CHECKBOX oCheckBo29 VAR lCheckBo29 PROMPT "" SIZE 010, 008 VALID SelCheck(29) OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin08, nCol CHECKBOX oCheckBo30 VAR lCheckBo30 PROMPT "" SIZE 010, 008 VALID SelCheck(30) OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin09, nCol CHECKBOX oCheckBo31 VAR lCheckBo31 PROMPT "" SIZE 010, 008 VALID SelCheck(31) OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin10, nCol CHECKBOX oCheckBo32 VAR lCheckBo32 PROMPT "" SIZE 010, 008 VALID SelCheck(32) OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin11, nCol CHECKBOX oCheckBo37 VAR lCheckBo37 PROMPT "" SIZE 010, 008 VALID SelCheck(37) OF oDlgLav COLORS 0, 16777215 PIXEL
    	nCol := nCol+11
    	@ nLin01, nCol SAY oSay23 PROMPT "PERMITIDO SECAR NA VERTICAL" 						FONT oFont1 SIZE 085, 016 OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin02, nCol SAY oSay24 PROMPT "PERMITIDO NA VERTICAL SEM TORCER" 				FONT oFont1 SIZE 085, 016 OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin03, nCol SAY oSay25 PROMPT "SECAGEM NA HORIZONTAL" 							FONT oFont1 SIZE 085, 016 OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin04, nCol SAY oSay26 PROMPT "PASSADORIA A FERRO" 								FONT oFont1 SIZE 085, 016 OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin05, nCol SAY oSay27 PROMPT "CHAPA DA BASE DO FERRO ATE 200∫C" 				FONT oFont1 SIZE 085, 016 OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin06, nCol SAY oSay28 PROMPT "CHAPA DA BASE DO FERRO ATE 150∫C" 	 			FONT oFont1 SIZE 085, 016 OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin07, nCol SAY oSay29 PROMPT "TEMPERATURA MAXIMA BASE DO FERRO 110∫C SEM VAPOR" FONT oFont1 SIZE 085, 016 OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin08, nCol SAY oSay30 PROMPT "NAO PASSAR OU UTILIZAR VAPORIZACAO" 				FONT oFont1 SIZE 085, 016 OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin09, nCol SAY oSay31 PROMPT "LIMPEZA A SECO" 									FONT oFont1 SIZE 085, 016 OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin10, nCol SAY oSay32 PROMPT "LIMPEZA A SECO COM TODOS OS SOLVENTES" 			FONT oFont1 SIZE 085, 016 OF oDlgLav COLORS 0, 16777215 PIXEL
	@ nLin11, nCol SAY oSay37 PROMPT "NAO LIMPAR A SECO" 									FONT oFont1 SIZE 085, 016 OF oDlgLav COLORS 0, 16777215 PIXEL

	nCol := nCol+95
    	@ nLin01, nCol BITMAP oBitmap33 SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\33.jpg" NOBORDER PIXEL
    	@ nLin02, nCol BITMAP oBitmap34 SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\34.jpg" NOBORDER PIXEL
    	@ nLin03, nCol BITMAP oBitmap35 SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\35.jpg" NOBORDER PIXEL
    	@ nLin04, nCol BITMAP oBitmap36 SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\36.jpg" NOBORDER PIXEL
    	@ nLin05, nCol BITMAP oBitmap53 SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\53.jpg" NOBORDER PIXEL
    	@ nLin06, nCol BITMAP oBitmap43 SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\43.jpg" NOBORDER PIXEL
    	@ nLin07, nCol BITMAP oBitmap44 SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\44.jpg" NOBORDER PIXEL
    	@ nLin08, nCol BITMAP oBitmap46 SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\46.jpg" NOBORDER PIXEL
    	@ nLin09, nCol BITMAP oBitmap47 SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\47.jpg" NOBORDER PIXEL
    	@ nLin10, nCol BITMAP oBitmap48 SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\48.jpg" NOBORDER PIXEL
	nCol := nCol+22
	@ nLin01, nCol CHECKBOX oCheckBo33 VAR lCheckBo33 PROMPT "" SIZE 010, 008 VALID SelCheck(33) OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin02, nCol CHECKBOX oCheckBo34 VAR lCheckBo34 PROMPT "" SIZE 010, 008 VALID SelCheck(34) OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin03, nCol CHECKBOX oCheckBo35 VAR lCheckBo35 PROMPT "" SIZE 010, 008 VALID SelCheck(35) OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin04, nCol CHECKBOX oCheckBo36 VAR lCheckBo36 PROMPT "" SIZE 010, 008 VALID SelCheck(36) OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin05, nCol CHECKBOX oCheckBo53 VAR lCheckBo53 PROMPT "" SIZE 010, 008 VALID SelCheck(53) OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin06, nCol CHECKBOX oCheckBo43 VAR lCheckBo43 PROMPT "" SIZE 010, 008 VALID SelCheck(43) OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin07, nCol CHECKBOX oCheckBo44 VAR lCheckBo44 PROMPT "" SIZE 010, 008 VALID SelCheck(44) OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin08, nCol CHECKBOX oCheckBo46 VAR lCheckBo46 PROMPT "" SIZE 010, 008 VALID SelCheck(46) OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin09, nCol CHECKBOX oCheckBo47 VAR lCheckBo47 PROMPT "" SIZE 010, 008 VALID SelCheck(47) OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin10, nCol CHECKBOX oCheckBo48 VAR lCheckBo48 PROMPT "" SIZE 010, 008 VALID SelCheck(48) OF oDlgLav COLORS 0, 16777215 PIXEL
    	nCol := nCol+11
    	@ nLin01, nCol SAY oSay33 PROMPT "LIMPEZA A SECO COM TETRACLOROETILENO" 					FONT oFont1 SIZE 085, 016 OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin02, nCol SAY oSay34 PROMPT "LIMPEZA A SECO COM TETRACLOROETILENO SEM ACAO MECANICA" 	FONT oFont1 SIZE 085, 016 OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin03, nCol SAY oSay35 PROMPT "LIMPEZA A SECO COM HIDROCARBONETO" 						FONT oFont1 SIZE 085, 016 OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin04, nCol SAY oSay36 PROMPT "LIMPEZA A SECO COM HIDROCARBONETO SEM ACAO MECANICA" 		FONT oFont1 SIZE 085, 016 OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin05, nCol SAY oSay53 PROMPT "SECAGEM EM VARAL A SOMBRA" 								FONT oFont1 SIZE 085, 016 OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin06, nCol SAY oSay43 PROMPT "SECAGEM EM VARAL POR GOTEJAMENTO" 						FONT oFont1 SIZE 085, 016 OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin07, nCol SAY oSay44 PROMPT "SECAGEM A SOMBRA" 										FONT oFont1 SIZE 085, 016 OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin08, nCol SAY oSay46 PROMPT "LIMPEZA A UMIDO PRO-NORMAL" 								FONT oFont1 SIZE 085, 016 OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin09, nCol SAY oSay47 PROMPT "LIMPEZA A UMIDO PRO-SUAVE" 						   		FONT oFont1 SIZE 085, 016 OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin10, nCol SAY oSay48 PROMPT "LIMPEZA A UMIDO PRO-MUITO SUAVE" 							FONT oFont1 SIZE 085, 016 OF oDlgLav COLORS 0, 16777215 PIXEL

	nCol := nCol+95
    	@ nLin01, nCol BITMAP oBitmap49 SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\49.jpg" NOBORDER PIXEL
    	@ nLin02, nCol BITMAP oBitmap50 SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\50.jpg" NOBORDER PIXEL
    	@ nLin03, nCol BITMAP oBitmap51 SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\51.jpg" NOBORDER PIXEL
    	//incluido bloco abaixo [Mauro Nagata, Actual Trend, 20190212]
    	@ nLin04, nCol BITMAP oBitmap54 SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\54.jpg" NOBORDER PIXEL
    	@ nLin05, nCol BITMAP oBitmap55 SIZE 017, 017 OF oDlgLav FILENAME "\system\Imagens\55.jpg" NOBORDER PIXEL
    	//fim bloco [Mauro Nagata, Actual Trend, 20190212]
	nCol := nCol+22
    	@ nLin01, nCol CHECKBOX oCheckBo49 VAR lCheckBo49 PROMPT "" SIZE 010, 008 VALID SelCheck(49) OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin02, nCol CHECKBOX oCheckBo50 VAR lCheckBo50 PROMPT "" SIZE 010, 008 VALID SelCheck(50) OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin03, nCol CHECKBOX oCheckBo51 VAR lCheckBo51 PROMPT "" SIZE 010, 008 VALID SelCheck(51) OF oDlgLav COLORS 0, 16777215 PIXEL
    	//incluido bloco abaixo [Mauro Nagata, Actual Trend, 20190212]
    	@ nLin04, nCol CHECKBOX oCheckBo54 VAR lCheckBo54 PROMPT "" SIZE 010, 008 VALID SelCheck(54) OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin05, nCol CHECKBOX oCheckBo55 VAR lCheckBo55 PROMPT "" SIZE 010, 008 VALID SelCheck(55) OF oDlgLav COLORS 0, 16777215 PIXEL
    	//fim bloco [Mauro Nagata, Actual Trend, 20190212]
    	nCol := nCol+11
    	@ nLin01, nCol SAY oSay49 PROMPT "NAO LIMPAR A UMIDO" 										FONT oFont1 SIZE 085, 016 OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin02, nCol SAY oSay50 PROMPT "SECAGEM EM VARAL POR GOTEJAMENTO A SOMBRA" 				FONT oFont1 SIZE 085, 016 OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin03, nCol SAY oSay51 PROMPT "PERMITIDO ALVEJAMENTO SOMENTE COM OXIGENIO" 				FONT oFont1 SIZE 085, 016 OF oDlgLav COLORS 0, 16777215 PIXEL
    	//incluido bloco abaixo [Mauro Nagata, Actual Trend, 20190212]
    	@ nLin04, nCol SAY oSay54 PROMPT "TEMP.MAXIMA 30∫C - NORMAL" 								FONT oFont1 SIZE 085, 016 OF oDlgLav COLORS 0, 16777215 PIXEL
    	@ nLin05, nCol SAY oSay55 PROMPT "NAO PERMITIDO ALVEJANTES CLORADOS APENAS OXIGENIO"		FONT oFont1 SIZE 085, 016 OF oDlgLav COLORS 0, 16777215 PIXEL
    	//fim bloco [Mauro Nagata, Actual Trend, 20190212]
    	
    	@ 240, 496 BUTTON oButton3 PROMPT "Limpar" 		SIZE 043, 012 ACTION LimpaLav() OF oDlgLav PIXEL
    	@ 240, 548 BUTTON oButton2 PROMPT "Cancelar" 	SIZE 043, 012 ACTION Close(oDlgLav) OF oDlgLav PIXEL
    	@ 240, 599 BUTTON oButton1 PROMPT "Gravar" 		SIZE 043, 012 ACTION SalvaLav() OF oDlgLav PIXEL

  ACTIVATE MSDIALOG oDlgLav CENTERED

Return

/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥ LimpaLav ∫Autor  ≥Daniel R. Melo      ∫ Data ≥ 27/02/2017  ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Desc.     ≥ Limpar marcados.	                                          ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥ HOPE                                                       ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
Static Function LimpaLav() 

Local nX

For nX := 1 to 55
	cCheck		:= "lCheckBo"+cValToChar(nX)
 	&cCheck		:= .F.
Next
MvParCod	:= ""		//CODIGO
MvParTxt	:= ""		//TEXTO
oDlgLav:Refresh()

Return()

/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥ SelCheck ∫Autor  ≥Daniel R. Melo      ∫ Data ≥ 27/02/2017  ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Desc.     ≥ SELECIONA CHECKBOX E GRAVA NO MULTIGET                     ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥ HOPE                                                       ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
Static Function SelCheck(nNum) 

cCheck	:= "lCheckBo"+cValToChar(nNum)
cSay	:= "oSay"+cValToChar(nNum)

If &cCheck == .T.

	MvParCod	:= MvParCod+StrZero(nNum,2)+","		//CODIGO

end

If &cCheck == .F. .and. AT(StrZero(nNum,2),MvParCod)>0
	
	MvParCod  := StrTran(MvParCod,StrZero(nNum,2)+",","")

end

oDlgLav:Refresh()

Return()

/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥ SalvaLav ∫Autor  ≥Daniel R. Melo      ∫ Data ≥ 27/02/2017  ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Desc.     ≥ SALVA O PROCESSO DE LAVAGEM                                ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥ HOPE                                                       ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
Static Function SalvaLav() 

Local nx

MvParTxt2 := ""

If MvParCod <> ""

	For nx := 1 to len(MvParCod) step 3
		cAux2 	:= SubStr(MvParCod,nx,2)
		cSay2	:= "oSay"+cValToChar(Val(cAux2))
		MvParTxt2	:= MvParTxt2+&cSay2:CCAPTION+" |"
	Next
	    
	MvParCod	:= SubStr(MvParCod,1,len(MvParCod)-1)	//CODIGO
	MvParTxt	:= SubStr(MvParTxt2,1,len(MvParTxt2)-2)	//TEXTO

ElseIf MvParCod == ""
	Alert("Processo de Lavagem em Branco!")

	MvParCod	:= ""
	MvParTxt	:= ""

EndIf

oMSGrade:aCols[oMSGrade:nat,len(OMSGrade:aHeader)]	:= MvParCod
oMSGrade:aCols[oMSGrade:nat,len(OMSGrade:aHeader)-1]	:= MvParTxt
Close(oDlgLav)
oMsGrade:refresh()

Return()


Static Function ReplyLn(_tp)
// Rotina para replicaÁ„o das linhas da grade para outras cores escolhidas

Local nX
Local nX2

IF _tp = 2 .OR. _tp = 1
	If MsgYesNo("Ser„o replicadas as informaÁıes da Cor: "+oMSGrade:aCols[oMSGrade:nat,1]+" para as outras cores?")
	  	For nX := 1 to len(oMSGrade:aCols)
	  		for nX2 := 1 to len(oMSGrade:aCols[oMSGrade:nat])-1
			   If nX <> oMSGrade:nat .and. !AllTrim(Str(nX2)) $ "1|2|" .and. alltrim(oMSGrade:aCols[nX,nX2])=="" 
		    			oMSGrade:aCols[nX,nX2] := oMSGrade:aCols[oMSGrade:nat,nX2]
		    	Endif

		   Next nX2
	  	Next nX
	End
End  

oMsGrade:refresh() 

Return


//------------------------------------------------
Static Function fMSMix(_tp, cColuna)
//------------------------------------------------
// Rotina para cadastro de Mix para regra de aglutinaÁ„o de Ordem de ProduÁ„o
// Tabela criada: SZH

Local nX
Local aHeaderEx		    := {}
Local aColsEx			:= {}
Local aFieldFill		:= {}
Local aFields			:= {}
Local aAlterFields   	:= {}
Local cAchou			:= .F.
Local _i
Static oMSGrade

  // Define field properties
  If alltrim(cColuna) <> ""
	  cQuery  := "SELECT BV_FILIAL, BV_TABELA, BV_CHAVE, BV_DESCRI FROM " +RetSQLName("SBV") + " WHERE "
	  cQuery  += "BV_FILIAL = '" +xFilial("SBV") +"' AND BV_TABELA = '" +cColuna +"' AND D_E_L_E_T_ = '' " 
	  cQuery += "ORDER BY R_E_C_N_O_"

	  cQuery := ChangeQuery(cQuery)	  
  	  If Select("TMPSBV") > 0 
     	 TMPSBV->(DbCloseArea()) 
	  EndIf 
	  dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TMPSBV",.T.,.T.)
     DbSelectArea("TMPSBV")

     cQuery2  := "SELECT * FROM "+RetSQLName("SZD")+" WHERE D_E_L_E_T_ = ' ' AND ZD_FILIAL = '"+xFilial("SZD")+"' AND ZD_PRODUTO='"+SubString(SB4->B4_COD,1,15)+"'"

  	  If Select("TMPSZD") > 0 
     	 TMPSZD->(DbCloseArea()) 
	  EndIf 
  	  dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery2),"TMPSZD",.T.,.T.)
  	  DbSelectArea("TMPSBV")
  	
//  	While !EOF() .and. Alltrim(TMPSBV->BV_TABELA) == Alltrim(cColuna)
		DbSelectArea("TMPSZD")
		TMPSZD->(DbGoTop())
		While TMPSZD->(!EOF())
			For _i := 1 to 200
			 	If &("TMPSZD->ZD_TAM"+StrZero(_i,3))=="X"	
					_campo		:= "ZH_TAM"+StrZero(_i,3)
					_desc := rettam(_i,cColuna,"D")
					DbSelectArea("SX3")
		  			SX3->(DbSetOrder(2))
		    		If SX3->(DbSeek(_campo))
		    			nX := ASCAN( aFields, {|x| alltrim(x) == alltrim(_campo)})
		    			If nX = 0
				  			Aadd(aFields,_campo) //TMPSBV->BV_CHAVE)
			  				Aadd(aAlterFields,_campo)

				       		Aadd(aHeaderEx, {Space(5)+ alltrim(_desc)+ Space(5),SX3->X3_CAMPO,"@E 99",2,0,"",SX3->X3_USADO,"N","","R","",""})
				       	Endif
				
			 		Endif
		 		Endif 
	 		Next
	 		TMPSZD->(DbSkip())
	 	EndDo
  	
		aSort(aFields)
		aSort(aAlterFields)
		ASORT(aHeaderEx, , , { |x,y| x[2] < y[2] } )
		  	
//  		DbSelectArea("TMPSBV")
//  		DbSkip()
//  	End
//  	DbClosearea()

  Else
  	Aadd(aFields,"ZH_TAM001")
  	Aadd(aAlterFields,"ZH_TAM001")

	DbSelectArea("SX3")
  	SX3->(DbSetOrder(2))
    If SX3->(DbSeek("ZH_TAM001"))
       Aadd(aHeaderEx, {AllTrim("Unico"),SX3->X3_CAMPO,"@E 99",2,0,"",SX3->X3_USADO,"N","","R","",""})
 	Endif 

  Endif

  If _tp = 8 	//Inclusao  
	  DbSelectArea("SZH")
	  DbSetOrder(1)
	  DbSeek(xfilial("SZH")+SubString(SB4->B4_COD,1,15))
	  
	  While !EOF() .and. SubString(SZH->ZH_PRODUTO,1,15) = SubString(SB4->B4_COD,1,15)
	  
		  // Define field values
		  If !Found()
		  	For nX := 1 to Len(aHeaderEx)
				DbSelectArea("SX3")
		  		SX3->(DbSetOrder(2))
		    	If DbSeek(aFields[nX])
			    	Aadd(aFieldFill, CriaVar(SX3->X3_CAMPO))
			   End
		  	Next nX
		  	Aadd(aFieldFill, .F.)
		  	Aadd(aColsEx, aFieldFill)
		  	aFieldFill :={}
		  
		  ElseIf Found()
		  		Alert("Favor clicar em alterar, o produto em quest„o j· tem MIX cadastrado!")
		  		TMPSZD->(DbCloseArea())
		  		Close(oDlg)
		  		Return()
		  EndIf
	  DbSkip()
     EndDo
  EndIf 

  If _tp = 9 	//AlteraÁ„o
	  DbSelectArea("SZH")
	  DbSetOrder(1)
	  DbSeek(xfilial("SZH")+SubString(SB4->B4_COD,1,15))

	  While !EOF() .and. SubString(SZH->ZH_PRODUTO,1,15) = SubString(SB4->B4_COD,1,15)
	  		
	  		If Found()
			  	For nX := 1 to Len(aHeaderEx)
					_campo := aHeaderEx[Nx,2]//"SZH->ZH_TAM"+StrZero(nX,3)
					Aadd(aFieldFill,&_campo) //TMPSBV->BV_CHAVE)
		  		Next
		  		Aadd(aFieldFill, .F.)
		  		Aadd(aColsEx, aFieldFill)
		  		aFieldFill	:={}
		  		cAchou		:= .T.
	 	   Endif
  		DbSkip()
      EndDo
            	
      	If !Found() .and. cAchou == .F.
	  		Alert("Favor clicar em incluir, o produto em quest„o n„o tem MIX cadastrado!")
		  	TMPSZD->(DbCloseArea())
		  	Close(oDlg)
		  	Return()
		Endif
  EndIf

  oMSGrade := MsNewGetDados():New( 189, 005, 275, 624, GD_INSERT+GD_DELETE+GD_UPDATE, "AllwaysTrue", "AllwaysTrue", "+Field1+Field2", aAlterFields,, 1, "AllwaysTrue", "", "AllwaysTrue", oDlg, aHeaderEx, aColsEx)

TMPSZD->(DbCloseArea())
    
Return


//------------------------------------------------
Static Function fMSFicha(_tp, cColuna)
//------------------------------------------------
// Rotina para cadastro de Ficha TÈcnica
// Tabela criada: SZN

Local nX
Local aHeaderEx		:= {}
Local aColsEx			:= {}
Local aFieldFill		:= {}
Local aFields			:= {}
Local aAlterFields	:= {}
Local cAchou			:= .F.

Static oMSGrade

  // Define field properties
aFields := {"ZN_NMPARTE","ZN_PARTES","ZN_TOLERA"} //TMPSBV->BV_CHAVE)
aAlterFields := {"ZN_NMPARTE","ZN_PARTES","ZN_TOLERA"} 
 
SX3->(DbSetOrder(2))
If SX3->(DbSeek("ZN_NMPARTE")) 
	Aadd(aHeaderEx, {alltrim(X3Titulo())+Space(5),SX3->X3_CAMPO,SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL,"",SX3->X3_USADO,"C","","R","",""})
Endif
  
SX3->(DbSetOrder(2))
If SX3->(DbSeek("ZN_PARTES")) 
	Aadd(aHeaderEx, {alltrim(X3Titulo())+Space(5),SX3->X3_CAMPO,SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL,"",SX3->X3_USADO,"C","","R","",""})
Endif
  
SX3->(DbSetOrder(2))
If SX3->(DbSeek("ZN_TOLERA")) 
	Aadd(aHeaderEx, {alltrim(X3Titulo())+Space(5),SX3->X3_CAMPO,SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL,"",SX3->X3_USADO,"N","","R","",""})
Endif

If alltrim(cColuna) <> ""
	cQuery  := "SELECT BV_FILIAL, BV_TABELA, BV_CHAVE, BV_DESCRI FROM " +RetSQLName("SBV") + " WHERE "
	cQuery  += "BV_FILIAL = '" +xFilial("SBV") +"' AND BV_TABELA = '" +cColuna +"' AND D_E_L_E_T_ = '' " 
	cQuery += "ORDER BY R_E_C_N_O_"

	cQuery := ChangeQuery(cQuery)
	If Select("TMPSBV") > 0 
 		TMPSBV->(DbCloseArea()) 
	EndIf 
	
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TMPSBV",.T.,.T.)
	
	DbSelectArea("TMPSBV")

	cQuery2  := "SELECT * FROM "+RetSQLName("SZD")+" WHERE D_E_L_E_T_ = ' ' AND ZD_FILIAL = '"+xFilial("SZD")+"' AND ZD_PRODUTO='"+SubString(SB4->B4_COD,1,15)+"'"
	
	If Select("TMPSZD") > 0 
		TMPSZD->(DbCloseArea()) 
	EndIf 
	 
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery2),"TMPSZD",.T.,.T.)
	
	DbSelectArea("TMPSZD")
  	
	DbSelectArea("SX3")
		
	For nx := 1 to 200
		If &("TMPSZD->ZD_TAM"+StrZero(nx,3))=="X"	
			_campo		:= "ZN_TAM"+StrZero(nx,3)
			
		  	Aadd(aFields,_campo) 
		  	Aadd(aAlterFields,_campo)
				
	  		SX3->(DbSetOrder(2))
	    	If SX3->(DbSeek(_campo)) 
	       		Aadd(aHeaderEx,{Space(5)+AllTrim(rettam(nx,cColuna,"D"))+ Space(5),SX3->X3_CAMPO,SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL,"",SX3->X3_USADO,"N","","R","",""})
	 		Endif
	 	Endif 
 	Next	
  	
  	TMPSZD->(DbCloseArea())

  	DbClosearea()
Else
  	Aadd(aFields,"ZN_TAM001")
  	Aadd(aAlterFields,"ZN_TAM001")

	DbSelectArea("SX3")
  	SX3->(DbSetOrder(2))
    If SX3->(DbSeek("ZN_TAM001"))
    	Aadd(aHeaderEx, {AllTrim("Unico"),SX3->X3_CAMPO,SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL,"",SX3->X3_USADO,"N","","R","",""})
 	Endif 
Endif

If _tp = 11 	//Inclusao  
	DbSelectArea("SZN")
	DbSetOrder(2)
	DbSeek(xfilial("SZN")+PADR(SB4->B4_COD,15))
	  
	If Found()
		Alert("Favor clicar em alterar, o produto em quest„o j· tem Ficha cadastrada!")
		Close(oDlg)
		Return()
	Endif
	
	Aadd(aFieldFill,"01")
	
	For nX := 2 to Len(aHeaderEx)
		DbSelectArea("SX3")
	 	SX3->(DbSetOrder(2))
	  	
	  	If DbSeek(aFields[nX])
		  	Aadd(aFieldFill, CriaVar(SX3->X3_CAMPO))
		EndIf
	Next nX
	
	Aadd(aFieldFill, .F.)
	Aadd(aColsEx, aFieldFill)
	aFieldFill :={}
EndIf 

If _tp = 12 	//AlteraÁ„o
	DbSelectArea("SZN")
	DbSetOrder(2)
	DbSeek(xfilial("SZN")+PADR(SB4->B4_COD,15))

	If !Found() 
		Alert("Favor clicar em incluir, o produto em quest„o n„o tem Ficha cadastrado!")
		Close(oDlg)
		Return()
	Else
		While !EOF() .and. SubString(SZN->ZN_PRODUTO,1,15) = SubString(SB4->B4_COD,1,15)
	  		Aadd(aFieldFill,SZN->ZN_NMPARTE)
	  		Aadd(aFieldFill,SZN->ZN_PARTES)
			Aadd(aFieldFill,SZN->ZN_TOLERA)
			For nX := 4 to Len(aHeaderEx)
				_campo := "SZN->"+aHeaderEx[nx][2]//"SZN->ZN_TAM"+StrZero(nX,3)
				Aadd(aFieldFill,&_campo) //TMPSBV->BV_CHAVE)
		  	Next
		  	Aadd(aFieldFill, .F.)
		  	Aadd(aColsEx, aFieldFill)
		  	aFieldFill :={}
	  		DbSkip()
    		EndDo
  	Endif
EndIf

oMSGrade := MsNewGetDados():New( 189, 005, 275, 624, GD_INSERT+GD_DELETE+GD_UPDATE, "AllwaysTrue", "AllwaysTrue", "+Field1+Field2", aAlterFields,, 999, "AllwaysTrue", "", "AllwaysTrue", oDlg, aHeaderEx, aColsEx)

Return


//------------------------------------------------
Static Function fMSFich1(_tp, cColuna)
//------------------------------------------------
// Rotina para cadastro de Ficha TÈcnica
// Tabela criada: SZN

Local nX
Local aHeaderEx		:= {}
Local aColsEx			:= {}
Local aFieldFill		:= {}
Local aFields			:= {}
Local aAlterFields	:= {}
Local cAchou			:= .F.
Static oMSGrade

  // Define field properties
 	aFields := {"ZO_TEMPO","ZO_DESCRI","ZO_OBS","ZO_OBSMAQ"}
  	aAlterFields := {"ZO_TEMPO","ZO_DESCRI","ZO_OBS","ZO_OBSMAQ"}

	SX3->(DbSetOrder(2))
	For nX := 1 to len(aFields)
  		If SX3->(DbSeek(aFields[nX])) 
			Aadd(aHeaderEx, {alltrim(X3Titulo())+Space(5),SX3->X3_CAMPO,SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL,"",SX3->X3_USADO,SX3->X3_TIPO,"","R","",""})
  		Endif
  	Next

  If _tp = 13 	//Inclusao  
	  DbSelectArea("SZO")
	  DbSetOrder(1)
	  DbSeek(xfilial("SZO")+PADR(SB4->B4_COD,15))
	  
	  If Found()
		  	Alert("Favor clicar em alterar, o produto em quest„o j· tem Ficha cadastrada!")
		  	Close(oDlg)
		  	Return()
	  Endif
	  
	  	For nX := 1 to Len(aHeaderEx)
			DbSelectArea("SX3")
	  		SX3->(DbSetOrder(2))
	    	If DbSeek(aFields[nX])
		    	Aadd(aFieldFill, CriaVar(SX3->X3_CAMPO))
		   End
	  	Next nX
	  	Aadd(aFieldFill, .F.)
	  	Aadd(aColsEx, aFieldFill)
	  	aFieldFill :={}
		  
  EndIf 

  If _tp = 14 	//AlteraÁ„o
	  DbSelectArea("SZO")
	  DbSetOrder(1)
	  DbSeek(xfilial("SZO")+PADR(SB4->B4_COD,15))

	  If !Found() 
  		Alert("Favor clicar em incluir, o produto em quest„o n„o tem Ficha cadastrado!")
	  	Close(oDlg)
	  	Return()
	  Else
	  	While !EOF() .and. SubString(SZO->ZO_PRODUTO,1,15) = SubString(SB4->B4_COD,1,15)
	  		
	  		Aadd(aFieldFill,SZO->ZO_TEMPO)
	  		Aadd(aFieldFill,SZO->ZO_DESCRI)
	  		Aadd(aFieldFill,SZO->ZO_OBS)
	  		Aadd(aFieldFill,SZO->ZO_OBSMAQ)
		  	Aadd(aFieldFill, .F.)
		  	Aadd(aColsEx, aFieldFill)
		  	aFieldFill	:={}
	  		DbSkip()
    	  EndDo
       	Endif
  EndIf

  oMSGrade := MsNewGetDados():New( 189, 005, 275, 624, GD_INSERT+GD_DELETE+GD_UPDATE, "AllwaysTrue", "AllwaysTrue", "+Field1+Field2", aAlterFields,, 999, "AllwaysTrue", "", "AllwaysTrue", oDlg, aHeaderEx, aColsEx)

  oDlg:refresh()

Return

//------------------------------------------------
Static Function fMSSta(_tp, cColuna)
//------------------------------------------------
// Rotina para manuteÁ„o de cadastro de Status do Produto
// Tabela criada: SZL

Local aHeaderEx		:= {}
Local aColsEx		:= {}
Local aFieldFill	:= {}
Local aFields		:= {"ZL_PRODUTO","ZL_COR","ZL_TAM","ZL_STATUS","ZL_DTLIBER","ZL_DTENCER"}
Local aAlterFields	:= {"ZL_STATUS","ZL_DTLIBER","ZL_DTENCER"}
Static oMSSta

  DbSelectArea("SX3")
  SX3->(DbSetOrder(2))
  If SX3->(DbSeek("ZL_PRODUTO"))
    Aadd(aHeaderEx, {Space(25)+AllTrim(X3Titulo())+ Space(25),SX3->X3_CAMPO,SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL,SX3->X3_VALID,;
                          SX3->X3_USADO,SX3->X3_TIPO,SX3->X3_F3,SX3->X3_CONTEXT,SX3->X3_CBOX,SX3->X3_RELACAO})
  Endif
  If SX3->(DbSeek("ZL_COR"))
    Aadd(aHeaderEx, {Space(25)+AllTrim(X3Titulo())+ Space(25),SX3->X3_CAMPO,SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL,SX3->X3_VALID,;
                          SX3->X3_USADO,SX3->X3_TIPO,SX3->X3_F3,SX3->X3_CONTEXT,SX3->X3_CBOX,SX3->X3_RELACAO})
  Endif
  If SX3->(DbSeek("ZL_TAM"))
    Aadd(aHeaderEx, {Space(25)+AllTrim(X3Titulo())+ Space(25),SX3->X3_CAMPO,SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL,SX3->X3_VALID,;
                          SX3->X3_USADO,SX3->X3_TIPO,SX3->X3_F3,SX3->X3_CONTEXT,SX3->X3_CBOX,SX3->X3_RELACAO})
  Endif
  If SX3->(DbSeek("ZL_STATUS"))
    Aadd(aHeaderEx, {Space(25)+AllTrim(X3Titulo())+ Space(25),SX3->X3_CAMPO,SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL,"U_ExistCod(4,M->ZL_STATUS)",;
                          SX3->X3_USADO,SX3->X3_TIPO,SX3->X3_F3,SX3->X3_CONTEXT,SX3->X3_CBOX,SX3->X3_RELACAO})
  Endif
  If SX3->(DbSeek("ZL_DTLIBER"))
    Aadd(aHeaderEx, {Space(25)+AllTrim(X3Titulo())+ Space(25),SX3->X3_CAMPO,SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL,SX3->X3_VALID,;
                          SX3->X3_USADO,SX3->X3_TIPO,SX3->X3_F3,SX3->X3_CONTEXT,SX3->X3_CBOX,SX3->X3_RELACAO})
  Endif
  If SX3->(DbSeek("ZL_DTENCER"))
    Aadd(aHeaderEx, {Space(25)+AllTrim(X3Titulo())+ Space(25),SX3->X3_CAMPO,SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL,SX3->X3_VALID,;
                          SX3->X3_USADO,SX3->X3_TIPO,SX3->X3_F3,SX3->X3_CONTEXT,SX3->X3_CBOX,SX3->X3_RELACAO})
  Endif

  // Define field values
	DbSelectArea("SB1")
	DbSetOrder(1)
	DbSeek(xfilial("SB1")+SubString(cCodigo,1,8))
	aFieldFill :={}
	  		
	While !EOF() .and. SubString(SB1->B1_COD,1,8) = SubString(cCodigo,1,8)
  		
  		Aadd(aFieldFill, SubStr(SB1->B1_COD,1,8))
  		Aadd(aFieldFill, SubStr(SB1->B1_COD,9,5))
  		Aadd(aFieldFill, SubStr(SB1->B1_COD,14,2))
  		Aadd(aFieldFill, SB1->B1_YSITUAC)
  		Aadd(aFieldFill, SB1->B1_YDATLIB)
  		Aadd(aFieldFill, SB1->B1_YDATENC)
		Aadd(aFieldFill, .F.)
		Aadd(aColsEx, aFieldFill)
		aFieldFill :={}
		DbSkip()
	End  

  oMSSta := MsNewGetDados():New( 189, 005, 275, 624, GD_INSERT+GD_DELETE+GD_UPDATE, "AllwaysTrue", "AllwaysTrue", "+Field1+Field2", aAlterFields,, 999, "AllwaysTrue", "", "AllwaysTrue", oDlg, aHeaderEx, aColsEx)
    
Return

//------------------------------------------------
Static Function fMSCBar(_tp, cColuna)
//------------------------------------------------
// Rotina para cadastro de CÛdito de Barras EAN13
// Par‚metro criado: MV_HCODBAR

Local nX
Local aHeaderEx := {}
Local aColsEx := {}
Local aFieldFill := {}
Local aFields := {"ZD_COR","ZD_DESCRIC"}
Local aAlterFields := {}
Static oMSGrade

  // Define field properties
  DbSelectArea("SX3")
  SX3->(DbSetOrder(2))
  If SX3->(DbSeek("ZD_COR"))
    Aadd(aHeaderEx, {alltrim(X3Titulo())+Space(4),"ZD_COR","@!",5,0,,SX3->X3_USADO,"C","","R","",""})
  Endif
  If SX3->(DbSeek("ZD_DESCRIC"))
    Aadd(aHeaderEx, {alltrim(X3Titulo())+Space(4),"ZD_DESCRIC","@!",20,0,,SX3->X3_USADO,"C","","R","",""})
  Endif

  If alltrim(cColuna) <> ""
	  cQuery  := "SELECT BV_FILIAL, BV_TABELA, BV_CHAVE, BV_DESCRI FROM " +RetSQLName("SBV") + " WHERE "
	  cQuery  += "BV_FILIAL = '" +xFilial("SBV") +"' AND BV_TABELA = '" +cColuna +"' AND D_E_L_E_T_ = '' " 
	  cQuery += "ORDER BY R_E_C_N_O_"

	  cQuery := ChangeQuery(cQuery)	  
	  If Select("TMPSBV") > 0 
     	 TMPSBV->(DbCloseArea()) 
	  EndIf 
	  dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TMPSBV",.T.,.T.)
	  
	  DbSelectArea("TMPSBV")

     cQuery2  := "SELECT * FROM "+RetSQLName("SZD")+" WHERE D_E_L_E_T_ = ' ' AND ZD_FILIAL = '"+xFilial("SZD")+"' AND ZD_PRODUTO='"+SubString(SB4->B4_COD,1,15)+"'"

  	  If Select("TMPSZD") > 0 
     	 TMPSZD->(DbCloseArea()) 
	  EndIf 
  	  dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery2),"TMPSZD",.T.,.T.)

	  DbSelectArea("TMPSZD")
  	
While !EOF() .and. Alltrim(TMPSBV->BV_TABELA) == Alltrim(cColuna)
		DbSelectArea("SX3")
		_campo		:= "ZH_TAM"+StrZero(len(aFields)-2,3)
		cZdVerif	:= 0
		
	  	Aadd(aFields,_campo) //TMPSBV->BV_CHAVE)
	  	Aadd(aAlterFields,_campo)

		TMPSZD->(DbGoTop())

		While TMPSZD->(!EOF())
		 	If &("TMPSZD->ZD_TAM"+StrZero(len(aFields)-2,3))=="X"	
				cZdVerif += 1
				
		  		SX3->(DbSetOrder(2))
		    	If SX3->(DbSeek(_campo)) .and. cZdVerif==1
		       	Aadd(aHeaderEx, {alltrim(TMPSBV->BV_DESCRI)+Space(4),SX3->X3_CAMPO,"@!",12,0,"",SX3->X3_USADO,"C","","R","",""})
		 		Endif
		 	Endif 
	 		
	 		TMPSZD->(DbSkip())
	 	EndDo
  	
  		DbSelectArea("TMPSBV")
  		DbSkip()
  	End
  	DbClosearea()
  Else
  	Aadd(aFields,"ZD_TAM001")
  	Aadd(aAlterFields,"ZD_TAM001")

	DbSelectArea("SX3")
  	SX3->(DbSetOrder(2))
    If SX3->(DbSeek("ZD_TAM001"))
       Aadd(aHeaderEx, {AllTrim("Unico"),SX3->X3_CAMPO,"@!",12,0,"",SX3->X3_USADO,"C","","R","",""})
 	Endif 
  Endif
  // Define field values
  _campw := GetMV("MV_HCODBAR")
  
  DbSelectArea("SZD")
  ("SZD")->(DbSetOrder(1))
  DbSeek(xfilial("SZD")+SubString(SB4->B4_COD,1,15))
    		
  While !EOF() .and. AllTrim(SZD->ZD_PRODUTO) = AllTrim(SB4->B4_COD)
  		
  	Aadd(aFieldFill, SZD->ZD_COR)
  	Aadd(aFieldFill, SZD->ZD_COR)
	For nX := 3 to Len(aFields)
		_campo := "ZD_TAM"+StrZero(nX-2,3)
		IF SZD->&_campo == "X"
			_tam := rettam(nx-2,ccoluna,"C")
		  	DbSelectArea("SB1")
		  	DbSetOrder(1)
			DbSeek(xfilial("SB1")+AllTrim(SB4->B4_COD)+SZD->ZD_COR+_tam)
			If Found() .and. alltrim(SB1->B1_CODBAR)<>""
				_campx := SubStr(SB1->B1_CODBAR,1,12)
				Aadd(aFieldFill,_campx) 
			Else
				_campw += 1
				Aadd(aFieldFill,cValToChar(ROUND(_campw, 0))) 
			Endif
		Endif 
  	Next
  	Aadd(aFieldFill, .F.)
  	Aadd(aColsEx, aFieldFill)
  	aFieldFill :={}
  	("SZD")->(DbSkip())
  End  

  oMSGrade := MsNewGetDados():New( 189, 005, 275, 624, GD_INSERT+GD_DELETE+GD_UPDATE, "AllwaysTrue", "AllwaysTrue", "+Field1+Field2", aAlterFields,, 999, "AllwaysTrue", "", "AllwaysTrue", oDlg, aHeaderEx, aColsEx)
    
Return

User Function valacols(_tp, cColuna)
// Rotina para atualizaÁ„o de Acols com base no grupo de tamanhos selecionado na tabela SBV

cColuna	:= UPPER(cColuna)
fMSGrade(_tp, cColuna)
oMSGrade:Refresh()
oDlg:refresh()

Return

Static Function Save(_tp)
// Rotina para saltar a grade de produtos no SB4 e no SB1, Mix de Produto, CÛdigo de Barras e Status do Produto

Local I,W,_w,_i,_iw

If cTipo <> "PA"
	If Empty(cOrigem) .Or. Empty(cPosIPI) .Or. Empty(cArm) .Or. Empty(dDtCad) .Or. Empty(cCodigo) .Or. Empty(cCodigoDesc) .Or. Empty(cUM) .Or.;
	   Empty(cGrupo) .Or. Empty(cSGrupoDesc) .Or. Empty(cLinha) .Or. Empty(cColuna)
		MsgAlert("Campos obrigatÛrios n„o preenchidos.","AtenÁ„o")
		Return
	EndIf
Else
	If Empty(cOrigem) .Or. Empty(cPosIPI) .Or. Empty(cArm) .Or. Empty(dDtCad) .Or. Empty(cCodigo) .Or. Empty(cCodigoDesc) .Or. Empty(cUM) .Or.;
	   Empty(cGrupo) .Or. Empty(cSGrupoDesc) .Or. Empty(cLinha) .Or. Empty(cColuna)
		MsgAlert("Campos obrigatÛrios n„o preenchidos.","AtenÁ„o")
		Return
	EndIf   
EndIf	

If SubString(cValToChar(cBloqueio),1,1)="S" .or. SubString(cValToChar(cBloqueio),1,1)="1"
	cBloqueioBD	:= "1"
Else
	cBloqueioBD	:= "2"
End

If SubString(cValToChar(cRastro),1,1)="L" .or. SubString(cValToChar(cRastro),1,1)="1"
	cRastroBD	:= "L"
ElseIf SubString(cValToChar(cRastro),1,1)="S" .or. SubString(cValToChar(cRastro),1,1)="2"
	cRastroBD	:= "S"
ElseIf SubString(cValToChar(cRastro),1,1)="N" .or. SubString(cValToChar(cRastro),1,1)="3"
	cRastroBD	:= "N"
End


If SubString(cValToChar(cEnd),1,1)="S" .or. SubString(cValToChar(cEnd),1,1)="1"
	cEndBD		:= "S"
ElseIf SubString(cValToChar(cEnd),1,1)="N" .or. SubString(cValToChar(cEnd),1,1)="2"
	cEndBD		:= "N"
End
/*
If cTipo == "PA"
	If SubString(cValToChar(cWeb),1,1)="S" .or. SubString(cValToChar(cWeb),1,1)="1"
		cWebBD		:= "S"
	ElseIf SubString(cValToChar(cWeb),1,1)="N" .or. SubString(cValToChar(cWeb),1,1)="2"
		cWebBD		:= "N"
	End
ElseIf cTipo <> "PA"
	cWebBD		:= "N"
End*/

// Comentado IF abaixo por Marcelo Oliveira - ActualTrend 210621
/*
If c2TpProd = "Amostra"
	c2TpProd := "1"
ElseIf c2TpProd = "Desenvolvimento"
	c2TpProd := "2"
ElseIf c2TpProd = "Normal"
	c2TpProd := "3"
EndIF

*/

If _tp == 1
	If AllTrim(cCodigo)=""
		Alert("Favor preencher o CÛdigo do produto!")
		return(.F.)
	End	
	If 	Len(OMSGrade:ACOLS)<=1 .and. AllTrim(OMSGrade:ACOLS[1,1])==""
		Alert("Favor incluir as cores e tamanhos para produto!")
		return(.F.)
	End	
	RecLock("SB4",.T.)
		Replace B4_FILIAL 		with xfilial("SB4")
		Replace B4_COD			with cCodigo
		Replace B4_TIPO			with cTipo
		Replace B4_YORIGEM		with cOrigem
		Replace B4_ORIGEM		with cOrigem
		Replace B4_YCLASPR		with cClass
		Replace B4_GRUPO		with cGrupo
		Replace B4_DESC			with cCodigoDesc
		Replace B4_UM			with cUM
		Replace B4_YMARCA		with cMarca
		Replace B4_YNOMARC		with cMarcaDesc
		Replace B4_YCICLO		with cCiclo
		Replace B4_YNCICLO		with cCicloDesc
		//Replace B4_YGPRODU		with cGpProd
		//Replace B4_YNGPCOM		with cGpProdDesc
		//Replace B4_XSUBGRU		with cSGrupo // Marcelo - Actual 210623
		//Replace B4_YNSUBGR		with cSGrupoDesc
		Replace B4_XCOLECA		with cColecao
		//Replace B4_YNCOLEC		with cColecaoDesc
		//Replace B4_YSUBCOL		with cSubCol
		//Replace B4_YNSUBCO		with cSubColDesc
		//Replace B4_YTPPROD		with cTpProd
		//Replace B4_YNTPCOM		with cTpProdDesc
		Replace B4_XCATEGO			with cCatProd
		//Replace B4_YNCATEG		with cCatProdDesc
		//Replace B4_YOCASIA		with cOcasiao
		//Replace B4_YTECIDO		with cTecido
//		Replace B4_YMODELO          with cModelo
		Replace B4_XCOORDE			with cCoorden
		Replace B4_LOCPAD			with cArm 
		Replace B4_RASTRO			with cRastroBD
		Replace B4_MSBLQL			with cBloqueioBD
		Replace B4_LOCALIZ			with cEndBD
		Replace B4_LINHA			with cLinha 
		Replace B4_COLUNA			with cColuna 
		Replace B4_PESO				with nPeso 
		Replace B4_POSIPI			with cPosIPI 
		Replace B4_YDATCAD			with dDtCad 
		//Replace B4_DWEB			with cWebBD
//		Replace B4_YTEMPO			with cTempo
		Replace B4_SITTRIB			with cTrib
		Replace B4_YDESCPT			with cDescriPTB
		//Replace B4_YDESCES		with cDescriSPA
		//Replace B4_YDESCIE		with cDescriENG
		Replace B4_YOBS				with cObsProd 
		Replace B4_XOBSIMP			with cObsImp 		
		Replace B4_XCLIENT			with cCodCli 
		Replace B4_XLJCLI			with cLojaCli
	//	Replace B4_XTPPROD			with c2TpProd // 210621 - Marcelo
		//Replace B4_YREFCLI 		with cRefCli
		//Replace B4_YPEDCLI		with cPedCli
		Replace B4_XACAB1          with cAcab1
		Replace B4_XACAB2          with cAcab2
		Replace B4_XACAB3          with cAcab3
		Replace B4_XACAB4          with cAcab4
		Replace B4_XACAB5          with cAcab5
		Replace B4_XACAB6          with cAcab6
		Replace B4_XACAB7          with cAcab7
		Replace B4_XACAB8          with cAcab8
		Replace B4_XACAB9          with cAcab9
		Replace B4_XACABA          with cAcab10
		Replace B4_XACABB          with cAcab11
		Replace B4_XACABC          with cAcab12
		Replace B4_XACABD          with cAcab13
		Replace B4_XACABE          with cAcab14
		Replace B4_XACABF          with cAcab15
		Replace B4_XACABG          with cAcab16
		Replace B4_XACABH          with cAcab17
		Replace B4_XACABI          with cAcab18
		Replace B4_XACABJ          with cAcab19
		Replace B4_XACABK          with cAcab20
		Replace B4_XFORNEC	       with cFornece
		Replace B4_XLARG	       with nLargL
		Replace B4_XGRAM	       with nGramatL
		Replace B4_XLARGES	       with nLargE
		Replace B4_XGRAMES	       with nGramatE
		Replace B4_XREFFOR	       with cRefFor
		Replace B4_YCOLECA	       with "NOVO"
		Replace B4_XCOMP1          with cComp1
		Replace B4_XCOMP2          with cComp2
		Replace B4_XCOMP3          with cComp3
		Replace B4_XGRAU           with cGrau
		Replace B4_XPTOCRI         with cPtoCri
		Replace B4_XFICHA1			with cFicha1
		Replace B4_XFICHA2			with cFicha2
		Replace B4_XFICHA3			with cFicha3
		Replace B4_XFICHA4			with cFicha4
		Replace B4_XFICHA5			with cFicha5
		Replace B4_XCODPRO			with cPrototi
	MsUnLock()
	ConfirmSX8()
	For i := 1 to Len(OMSGrade:ACOLS)
		If OMSGrade:ACOLS[i,len(OMSGrade:AHEADER)+1] == .F. .and. AllTrim(OMSGrade:ACOLS[i,1])<>""
			DbSelectArea("SZD")
			DbSetOrder(1)
			DbSeek(xfilial("SZD")+SubString(cCodigo,1,15)+OMSGrade:ACOLS[i,1])

			If !Found() .and. AllTrim(OMSGrade:ACOLS[i,1])<>""
				RecLock("SZD",.T.)
					Replace ZD_FILIAL	with xfilial("SZD")
					Replace ZD_PRODUTO		with SubString(cCodigo,1,15)
					Replace ZD_COR			with OMSGrade:ACOLS[i,1]
					Replace ZD_DESCRIC		with OMSGrade:ACOLS[i,2]
					Replace ZD_COMPOS			with OMSGrade:ACOLS[i,3]
					Replace ZD_DESCCP2		with OMSGrade:ACOLS[i,4]
					Replace ZD_DESCCOM		with OMSGrade:ACOLS[i,5]
					For w := 6 to len(OMSGrade:aHeader)-2
						_cpo := "ZD_TAM"+StrZero((w-5),3)
						Replace &(_cpo) with OMSGrade:ACOLS[i,w]
					Next
//					Replace ZD_DTLIB			with OMSGrade:ACOLS[i,len(OMSGrade:aHeader)-3]
//					Replace ZD_SITUAC			with OMSGrade:ACOLS[i,len(OMSGrade:aHeader)-2]
					Replace ZD_DESCLAV		with OMSGrade:ACOLS[i,len(OMSGrade:aHeader)-1]
					Replace ZD_LAVAGE			with OMSGrade:ACOLS[i,len(OMSGrade:aHeader)]
				MsUnLock()
			Else
				RecLock("SZD",.F.)
					Replace ZD_DESCRIC		with OMSGrade:ACOLS[i,2]
					Replace ZD_COMPOS			with OMSGrade:ACOLS[i,3]
					Replace ZD_DESCCP2		with OMSGrade:ACOLS[i,4]
					Replace ZD_DESCCOM		with OMSGrade:ACOLS[i,5]
					For w := 6 to len(OMSGrade:aHeader)-2
						_cpo := "ZD_TAM"+StrZero((w-5),3)
						Replace &(_cpo) with OMSGrade:ACOLS[i,w]
					Next
//					Replace ZD_DTLIB			with OMSGrade:ACOLS[i,len(OMSGrade:aHeader)-3]
//					Replace ZD_SITUAC			with OMSGrade:ACOLS[i,len(OMSGrade:aHeader)-2]
					Replace ZD_DESCLAV		with OMSGrade:ACOLS[i,len(OMSGrade:aHeader)-1]
					Replace ZD_LAVAGE			with OMSGrade:ACOLS[i,len(OMSGrade:aHeader)]
				MsUnLock()
			Endif
			
			
			
			
			For w := 6 to len(OMSGrade:aHeader)-2
				// O que estiver com a quantidade marcada com o X, cria o produto
				If OMSGrade:ACOLS[i,w] == "X"
					_tam := rettam(w-5,ccoluna,"C")
					DbSelectArea("SB1")
					DbSetOrder(1)
					DbSeek(xfilial("SB1")+AllTrim(cCodigo)+OMSGrade:ACOLS[i,1]+_tam)
					
					_nmTam := GetAdvFVal("SBV","BV_DESCRI",xFilial("SBV")+cColuna+_tam,1,"")
					
					If !Found()
						RecLock("SB1",.T.)
							Replace B1_FILIAL			with xfilial("SB1")
							Replace B1_COD			with AllTrim(cCodigo)+OMSGrade:ACOLS[i,1]+_tam
							Replace B1_DESC			with AllTrim(cCodigoDesc)+" - "+AllTrim(OMSGrade:ACOLS[i,2])+" - "+_nmTam
							Replace B1_TIPO			with cTipo
							Replace B1_GRUPO			with cGrupo
							Replace B1_UM				with cUM
							Replace B1_LOCPAD			with cArm
							Replace B1_SEGUM			with cUM
							Replace B1_CONV			with 1
							Replace B1_TIPCONV		with "M"
							Replace B1_PESO			with nPeso
							Replace B1_TIPODEC		with "N"
							Replace B1_ORIGEM			with "0"
							Replace B1_POSIPI			with cPosIPI
							Replace B1_GRADE			with "S"
							Replace B1_RASTRO			with cRastroBD
							Replace B1_MSBLQL			with cBloqueioBD
							Replace B1_LOCALIZ		with cEndBD
							Replace B1_VEREAN			with "13"
							Replace B1_TIPOBN			with cTipo
							Replace B1_GARANT			with "N"
							Replace B1_YMARCA			with cMarca
							Replace B1_CUSTD			with nCustSTD
							//Replace B1_YCICLO			with cCiclo
							//Replace B1_YGPRODU		with cGpProd
							//Replace B1_XSUBGRU		with cSGrupo // Marcelo - Actual 210623
							Replace B1_CONTA		with cSGrupoDesc //IIF(ctipo="PA","11205001001",Iif(ctipo="MP","11205001003","11205001002"))
							Replace B1_XCOLECA		with cColecao
							Replace B1_TE			with cTES
							Replace B1_XCATEGO		with cCatProd
						//	Replace B1_XTPPROD		with c2TpProd // Marcelo 210621
							//Replace B1_YOCASIA		with cOcasiao
							//Replace B1_YTECIDO		with cTecido
							Replace B1_YDATCAD		with dDtCad
							//Replace B1_YDWEB			with cWebBD
//							Replace B1_YTEMPO			with cTempo
							Replace B1_YCLASPR		with cClass
							Replace B1_SITTRIB		with cTrib
							Replace B1_YDESCPT		with cDescriPTB
							//Replace B1_YDESCES		with cDescriSPA
							//Replace B1_YDESCIE		with cDescriENG
							Replace B1_YOBS			with cObsProd 
							//Replace B1_XOBSIMP			with cObsImp
//							Replace B1_YDATLIB		with OMSGrade:ACOLS[i,len(OMSGrade:aHeader)-3]
							//Replace B1_YSITUAC		with "PNV" // Na inclusao grava Como produto em desenvolvimento
							Replace B1_YLAVAGE		with OMSGrade:ACOLS[i,len(OMSGrade:aHeader)]
							Replace B1_MODELO		with OMSGrade:ACOLS[i,5]
							//Replace B1_CONTA with  "11205002"
							Replace B1_REVATU		with "001"
						MsUnLock()
/*						
						_area1 := GetArea()

						DbSelectArea("CTD")
						dbSetOrder(1)
						Dbseek(xFilial("CTD")+"P"+SB1->B1_COD)

						If !Found() 
							RecLock("CTD",.T.)
								CTD_FILIAL	:= xFilial("CTD")					//Filial		
								CTD_ITEM	:= "P"+SB1->B1_COD			 		//Item Conta		
								CTD_CLASSE	:= '2'								//Classe				1=Sintetico;2=Analitico
								CTD_NORMAL	:= '1'								//Cond Normal			0=Nenhum;1=Despesa;2=Receita
								CTD_DESC01	:= SB1->B1_DESC						//Desc Moeda 1		
								CTD_BLOQ	:= "2"								//Item Bloq				1=Bloqueado;2=N√£o Bloqueado
								CTD_DTEXIS	:= cToD("01/01/2000")				//Dt Ini Exist		
							MsUnLock()
						Endif
						
						RestArea(_area1)
*/
					Else
						
						_nmTam := GetAdvFVal("SBV","BV_DESCRI",xFilial("SBV")+cColuna+_tam,1,"")
						 
						RecLock("SB1",.F.)
							Replace B1_FILIAL			with xfilial("SB1")
							Replace B1_DESC			with AllTrim(cCodigoDesc)+" - "+AllTrim(OMSGrade:ACOLS[i,2])+" - "+_nmTam
							Replace B1_TIPO			with cTipo
							Replace B1_GRUPO			with cGrupo
							Replace B1_UM				with cUM
							Replace B1_LOCPAD			with cArm
							Replace B1_SEGUM			with cUM
							Replace B1_CONV			with 1
							Replace B1_TIPCONV		with "M"
							Replace B1_PESO			with nPeso
							Replace B1_TIPODEC		with "N"
							Replace B1_ORIGEM			with "0"
							Replace B1_POSIPI			with cPosIPI
							Replace B1_GRADE			with "S"
							Replace B1_RASTRO			with cRastroBD
							Replace B1_MSBLQL			with cBloqueioBD
							Replace B1_LOCALIZ		with cEndBD
							Replace B1_VEREAN			with "13"
							Replace B1_TIPOBN			with cTipo
							Replace B1_GARANT			with "N"
					//		Replace B1_XTPPROD			with c2TpProd // Marcelo 210621
							//Replace B1_YMARCA			with cMarca
							//Replace B1_YCICLO			with cCiclo
							//Replace B1_YGPRODU		with cGpProd
							//Replace B1_XSUBGRU		with cSGrupo // Marcelo - Actual 210623
							Replace B1_CONTA		with cSGrupoDesc //IIF(ctipo="PA","11205001001",Iif(ctipo="MP","11205001003","11205001002"))
							Replace B1_XCOLECA		with cColecao
							//Replace B1_YSUBCOL		with cSubCol
							//Replace B1_YTPPROD		with cTpProd
							Replace B1_XCATEGO		with cCatProd
							//Replace B1_YOCASIA		with cOcasiao
							//Replace B1_YTECIDO		with cTecido
							Replace B1_YDATCAD		with dDtCad
							Replace B1_CUSTD			with nCustSTD
							//Replace B1_YDWEB			with cWebBD
//							Replace B1_YTEMPO			with cTempo
							Replace B1_YCLASPR		with cClass
							Replace B1_SITTRIB		with cTrib
							Replace B1_YDESCPT		with cDescriPTB
//							Replace B1_YDESCES		with cDescriSPA
//							Replace B1_YDESCIE		with cDescriENG
							Replace B1_YOBS			with cObsProd
							//Replace B1_XOBSIMP		with cObsImp
//							Replace B1_YDATLIB		with OMSGrade:ACOLS[i,len(OMSGrade:aHeader)-3]
//							Replace B1_YSITUAC		with OMSGrade:ACOLS[i,len(OMSGrade:aHeader)-2]
							Replace B1_YLAVAGE		with OMSGrade:ACOLS[i,len(OMSGrade:aHeader)]
							Replace B1_MODELO		with OMSGrade:ACOLS[i,5]
						MsUnLock()
					Endif
					
					DbSelectArea("DA1")
					DbSetOrder(1)
					If !DbSeek(xfilial("DA1")+cTabPrc+AllTrim(cCodigo)+OMSGrade:ACOLS[i,1]+_tam)
						cUltItem := ULTITEM()
					
						RecLock("DA1",.T.)
						DA1->DA1_FILIAL := xFilial("DA1")
						DA1->DA1_ITEM   := Soma1(cUltItem,4)
						DA1->DA1_CODTAB := cTabPrc
						DA1->DA1_CODPRO := AllTrim(cCodigo)+OMSGrade:ACOLS[i,1]+_tam
						DA1->DA1_PRCVEN := 999.99
						DA1->DA1_DATVIG := DDATABASE
						MsUnlock()
					EndIf
					
				Endif
			Next
		Endif
	Next
ElseIf _tp == 2
	DbSelectArea("SB4")
	DbSetOrder(1)
	DbSeek(xfilial("SB4")+cCodigo)
	
	If Found()
		RecLock("SB4",.F.)
			Replace B4_FILIAL 		with xfilial("SB4")
			Replace B4_COD			with cCodigo
			Replace B4_DESC			with AllTrim(cCodigoDesc)
			Replace B4_TIPO			with cTipo
			Replace B4_YORIGEM		with cOrigem
			Replace B4_ORIGEM		with cOrigem
			Replace B4_YCLASPR		with cClass
			Replace B4_GRUPO			with cGrupo
			Replace B4_DESC			with cCodigoDesc
			Replace B4_UM				with cUM
			Replace B4_YMARCA			with cMarca
			Replace B4_YNOMARC		with cMarcaDesc
			Replace B4_YCICLO			with cCiclo
			Replace B4_YNCICLO		with cCicloDesc
			//Replace B4_YGPRODU		with cGpProd
			//Replace B4_YNGPCOM		with cGpProdDesc
			//Replace B4_XSUBGRU		with cSGrupo // Marcelo - Actual 210623
			//Replace B4_YNSUBGR		with cSGrupoDesc
			Replace B4_XCOLECA		with cColecao
			//Replace B4_YNCOLEC		with cColecaoDesc
			//Replace B4_YSUBCOL		with cSubCol
			//Replace B4_YNSUBCO		with cSubColDesc
			//Replace B4_YTPPROD		with cTpProd
			//Replace B4_YNTPCOM		with cTpProdDesc
			Replace B4_XCATEGO		with cCatProd
			//Replace B4_YNCATEG		with cCatProdDesc
			//Replace B4_YOCASIA		with cOcasiao
			//Replace B4_YTECIDO		with cTecido
//			Replace B4_YMODELO          with cModelo
			Replace B4_LOCPAD			with cArm 
			Replace B4_RASTRO			with cRastroBD
			Replace B4_MSBLQL			with cBloqueioBD
			Replace B4_LOCALIZ		with cEndBD
			Replace B4_LINHA			with cLinha 
			Replace B4_COLUNA			with cColuna 
			Replace B4_PESO			with nPeso 
			Replace B4_POSIPI			with cPosIPI 
			Replace B4_YDATCAD		with dDtCad 
			//Replace B4_DWEB			with cWebBD
//			Replace B4_YTEMPO			with cTempo
			Replace B4_SITTRIB		with cTrib
			Replace B4_YDESCPT		with cDescriPTB
			//Replace B4_YDESCES		with cDescriSPA
			//Replace B4_YDESCIE		with cDescriENG
			Replace B4_YOBS			with cObsProd
			Replace B4_XOBSIMP			with cObsImp
			Replace B4_XCLIENT		with cCodCli
		//	Replace B4_XTPPROD		with c2TpProd //Marcelo 210621
			Replace B4_XLJCLI			with cLojaCli  
			//Replace B4_YREFCLI		with cRefCli
			//Replace B4_YPEDCLI		with cPedCli
			/*Replace B4_XACAB1          with cAcab1
			Replace B4_XACAB2          with cAcab2
			Replace B4_XACAB3          with cAcab3
			Replace B4_XACAB4          with cAcab4
			Replace B4_XACAB5          with cAcab5
			Replace B4_XACAB6          with cAcab6
			Replace B4_XACAB7          with cAcab7
			Replace B4_XACAB8          with cAcab8
			Replace B4_XACAB9          with cAcab9
			Replace B4_XACABA          with cAcab10
			Replace B4_XACABB          with cAcab11
			Replace B4_XACABC          with cAcab12
			Replace B4_XACABD          with cAcab13
			Replace B4_XACABE          with cAcab14
			Replace B4_XACABF          with cAcab15
			Replace B4_XACABG          with cAcab16
			Replace B4_XACABH          with cAcab17
			Replace B4_XACABI          with cAcab18
			Replace B4_XACABJ          with cAcab19
			Replace B4_XACABK          with cAcab20*/
			Replace B4_XFORNEC	       with cFornece
			Replace B4_XLARG	       with nLargL
			Replace B4_XGRAM	       with nGramatL
			Replace B4_XLARGES	       with nLargE
			Replace B4_XGRAMES	       with nGramatE
			Replace B4_XREFFOR	       with cRefFor
			Replace B4_YCOLECA	       with "NOVO"
			Replace B4_XCOMP1          with cComp1
			Replace B4_XCOMP2          with cComp2
			Replace B4_XCOMP3          with cComp3
			Replace B4_XGRAU          with cGrau
			Replace B4_XPTOCRI         with cPtoCri
			//Replace B4_XFICHA1			with cFicha1
			//Replace B4_XFICHA2			with cFicha2
			//Replace B4_XFICHA3			with cFicha3
			//Replace B4_XFICHA4			with cFicha4
			//Replace B4_XFICHA5			with cFicha5
			Replace B4_XCODPRO			with cPrototi 			
		MsUnLock()
	
		For i := 1 to Len(OMSGrade:ACOLS)
			If OMSGrade:ACOLS[i,len(OMSGrade:AHEADER)+1] == .F. .and. AllTrim(OMSGrade:ACOLS[i,1])<>""
			//If AllTrim(OMSGrade:ACOLS[i,1])<>""
				DbSelectArea("SZD")
				DbSetOrder(1)
				DbSeek(xfilial("SZD")+SubString(cCodigo,1,15)+OMSGrade:ACOLS[i,1])

				If !Found()
					RecLock("SZD",.T.)
						Replace ZD_FILIAL	with xfilial("SZD")
						Replace ZD_PRODUTO		with SubString(cCodigo,1,15)
						Replace ZD_COR			with OMSGrade:ACOLS[i,1]
						Replace ZD_DESCRIC		with OMSGrade:ACOLS[i,2]
						Replace ZD_COMPOS			with OMSGrade:ACOLS[i,3]
						Replace ZD_DESCCP2		with OMSGrade:ACOLS[i,4]
						Replace ZD_DESCCOM		with OMSGrade:ACOLS[i,5]
						For w := 6 to len(OMSGrade:aHeader)-2
							_cpo := "ZD_TAM"+StrZero((w-5),3)
							Replace &(_cpo) with OMSGrade:ACOLS[i,w]
						Next
//						Replace ZD_DTLIB			with OMSGrade:ACOLS[i,len(OMSGrade:aHeader)-3]
//						Replace ZD_SITUAC			with OMSGrade:ACOLS[i,len(OMSGrade:aHeader)-2]
						Replace ZD_DESCLAV		with OMSGrade:ACOLS[i,len(OMSGrade:aHeader)-1]
						Replace ZD_LAVAGE			with OMSGrade:ACOLS[i,len(OMSGrade:aHeader)]
					MsUnLock()
				Else
					RecLock("SZD",.F.)
						Replace ZD_COMPOS			with OMSGrade:ACOLS[i,3]
						Replace ZD_DESCCP2		with OMSGrade:ACOLS[i,4]
						Replace ZD_DESCCOM		with OMSGrade:ACOLS[i,5]
						For w := 6 to len(OMSGrade:aHeader)-2
							_cpo := "ZD_TAM"+StrZero((w-5),3)
							Replace &(_cpo) with OMSGrade:ACOLS[i,w]
						Next
//						Replace ZD_DTLIB			with OMSGrade:ACOLS[i,len(OMSGrade:aHeader)-3]
//						Replace ZD_SITUAC			with OMSGrade:ACOLS[i,len(OMSGrade:aHeader)-2]
						Replace ZD_DESCLAV		with OMSGrade:ACOLS[i,len(OMSGrade:aHeader)-1]
						Replace ZD_LAVAGE			with OMSGrade:ACOLS[i,len(OMSGrade:aHeader)]
					MsUnLock()
				Endif

				For w := 6 to len(OMSGrade:aHeader)-2
					If OMSGrade:ACOLS[i,w] == "X"
						_tam := rettam(w-5,ccoluna,"C")
						DbSelectArea("SB1")
						DbSetOrder(1)
						DbSeek(xfilial("SB1")+AllTrim(cCodigo)+OMSGrade:ACOLS[i,1]+_tam)
	
						If !Found()
							_nmTam := GetAdvFVal("SBV","BV_DESCRI",xFilial("SBV")+cColuna+_tam,1,"")
							RecLock("SB1",.T.)
								Replace B1_FILIAL			with xfilial("SB1")
								Replace B1_COD				with AllTrim(cCodigo)+OMSGrade:ACOLS[i,1]+_tam
								Replace B1_DESC				with AllTrim(cCodigoDesc)+" - "+AllTrim(OMSGrade:ACOLS[i,2])+" - "+_nmTam
								Replace B1_TIPO				with cTipo
								Replace B1_GRUPO			with cGrupo
								Replace B1_UM				with cUM
								Replace B1_LOCPAD			with cArm
								Replace B1_SEGUM			with cUM
								Replace B1_CONV				with 1
								Replace B1_TIPCONV			with "M"
								Replace B1_PESO				with nPeso
								Replace B1_TIPODEC			with "N"
								Replace B1_ORIGEM			with "0"
								Replace B1_POSIPI			with cPosIPI
								Replace B1_GRADE			with "S"
								Replace B1_RASTRO			with cRastroBD
								Replace B1_MSBLQL			with cBloqueioBD
								Replace B1_LOCALIZ			with cEndBD
								Replace B1_CUSTD			with nCustSTD
								Replace B1_VEREAN			with "13"
								Replace B1_TIPOBN			with cTipo
								Replace B1_GARANT			with "N"
							//	Replace	B1_XTPPROD			with c2TpProd //Marcelo - 210621
								//Replace B1_YMARCA			with cMarca
								//Replace B1_YCICLO			with cCiclo
								//Replace B1_YGPRODU		with cGpProd
								//Replace B1_XSUBGRU		with cSGrupo // Marcelo - Actual 210623
								Replace B1_CONTA			with cSGrupoDesc //IIF(ctipo="PA","11205001001",Iif(ctipo="MP","11205001003","11205001002"))
								Replace B1_XCOLECA			with cColecao
								//Replace B1_YSUBCOL		with cSubCol
								//Replace B1_YTPPROD		with cTpProd
								Replace B1_XCATEGO			with cCatProd
								//Replace B1_YOCASIA		with cOcasiao
								//Replace B1_YTECIDO		with cTecido
								Replace B1_YDATCAD			with dDtCad
								//Replace B1_YDWEB			with cWebBD
//								Replace B1_YTEMPO			with cTempo
								//Replace B1_YCLASPR		with cClass
								Replace B1_SITTRIB			with cTrib
								Replace B1_YDESCPT			with cDescriPTB
								//Replace B1_YDESCES		with cDescriSPA
								//Replace B1_YDESCIE		with cDescriENG
								Replace B1_YOBS				with cObsProd
//								Replace B1_YDATLIB			with OMSGrade:ACOLS[i,len(OMSGrade:aHeader)-3]
//								Replace B1_YSITUAC			with  "PNV" // Na inclusao grava Como produto em desenvolvimento
								Replace B1_YLAVAGE			with OMSGrade:ACOLS[i,len(OMSGrade:aHeader)]
								Replace B1_MODELO			with OMSGrade:ACOLS[i,5]
								Replace B1_REVATU			with "001"
								Replace B1_XCOORDE			with cCoorden
							MsUnLock()
/*							
							_area1 := GetArea()
							DbSelectArea("CTD")
							dbSetOrder(1)
							Dbseek(xFilial("CTD")+"P"+SB1->B1_COD)

							If !Found()
								RecLock("CTD",.T.)
									CTD_FILIAL	:= xFilial("CTD")					//Filial		
									CTD_ITEM	:= "P"+SB1->B1_COD			 		//Item Conta		
									CTD_CLASSE	:= '2'								//Classe				1=Sintetico;2=Analitico
									CTD_NORMAL	:= '1'								//Cond Normal			0=Nenhum;1=Despesa;2=Receita
									CTD_DESC01	:= SB1->B1_DESC						//Desc Moeda 1		
									CTD_BLOQ	:= "2"								//Item Bloq				1=Bloqueado;2=N√£o Bloqueado
									CTD_DTEXIS	:= cToD("01/01/2000")				//Dt Ini Exist		
								MsUnLock()
							Endif
							
							RestArea(_area1)
*/
						Else
							_nmTam := GetAdvFVal("SBV","BV_DESCRI",xFilial("SBV")+cColuna+_tam,1,"")
							RecLock("SB1",.F.)
								Replace B1_FILIAL			with xfilial("SB1")
								Replace B1_DESC			with AllTrim(cCodigoDesc)+" - "+AllTrim(OMSGrade:ACOLS[i,2])+" - "+_nmTam
								Replace B1_TIPO			with cTipo
								Replace B1_GRUPO			with cGrupo
								Replace B1_UM				with cUM
								Replace B1_LOCPAD			with cArm
								Replace B1_SEGUM			with cUM
								Replace B1_CONV			with 1
								Replace B1_TIPCONV		with "M"
								Replace B1_PESO			with nPeso
								Replace B1_TIPODEC		with "N"
								Replace B1_ORIGEM			with "0"
								Replace B1_POSIPI			with cPosIPI
								Replace B1_GRADE			with "S"
								Replace B1_RASTRO			with cRastroBD
								Replace B1_MSBLQL			with cBloqueioBD
								Replace B1_LOCALIZ		with cEndBD
								Replace B1_VEREAN			with "13"
								Replace B1_TIPOBN			with cTipo
								Replace B1_GARANT			with "N"
							//	Replace	B1_XTPPROD			with c2TpProd // 210621
								//Replace B1_YMARCA			with cMarca
								//Replace B1_YCICLO			with cCiclo
								//Replace B1_YGPRODU		with cGpProd
								//Replace B1_XSUBGRU		with cSGrupo // Marcelo - Actual 210623
								Replace B1_CONTA		with cSGrupoDesc //IIF(ctipo="PA","11205001001",Iif(ctipo="MP","11205001003","11205001002"))
								Replace B1_XCOLECA		with cColecao
								Replace B1_CUSTD			with nCustSTD
								//Replace B1_YSUBCOL		with cSubCol
								//Replace B1_YTPPROD		with cTpProd
								Replace B1_XCATEGO		with cCatProd
								//Replace B1_YOCASIA		with cOcasiao
								//Replace B1_YTECIDO		with cTecido
								//Replace B1_YDATCAD		with dDtCad
								//Replace B1_YDWEB			with cWebBD
//								Replace B1_YTEMPO			with cTempo
								Replace B1_YCLASPR		with cClass
								Replace B1_SITTRIB		with cTrib
								Replace B1_YDESCPT		with cDescriPTB
//								Replace B1_YDESCES		with cDescriSPA
//								Replace B1_YDESCIE		with cDescriENG
								Replace B1_YOBS			with cObsProd
//								Replace B1_YDATLIB		with OMSGrade:ACOLS[i,len(OMSGrade:aHeader)-3]
//								Replace B1_YSITUAC		with OMSGrade:ACOLS[i,len(OMSGrade:aHeader)-2]
								Replace B1_YLAVAGE		with OMSGrade:ACOLS[i,len(OMSGrade:aHeader)]
								Replace B1_MODELO		with OMSGrade:ACOLS[i,5]
							MsUnLock()
						Endif
						
						DbSelectArea("DA1")
						DbSetOrder(1)
						If !DbSeek(xfilial("DA1")+cTabPrc+AllTrim(cCodigo)+OMSGrade:ACOLS[i,1]+_tam)
							cUltItem := ULTITEM()
						
							RecLock("DA1",.T.)
							DA1->DA1_FILIAL := xFilial("DA1")
							DA1->DA1_ITEM   := Soma1(cUltItem,4)
							DA1->DA1_CODTAB := cTabPrc
							DA1->DA1_CODPRO := AllTrim(cCodigo)+OMSGrade:ACOLS[i,1]+_tam
							DA1->DA1_PRCVEN := 999.99
							DA1->DA1_DATVIG := DDATABASE
							MsUnlock()
						EndIf
					Endif
				Next
			Endif
		Next
	Endif
ElseIf _tp == 7
	cCodBar	:= ""
	cCodBarMV	:= ""
	For i := 1 to Len(OMSGrade:ACOLS)
		If OMSGrade:ACOLS[i,len(OMSGrade:AHEADER)+1] == .F.
			For w := 3 to len(OMSGrade:aHeader)
				If alltrim(OMSGrade:ACOLS[i,w]) <> ""
					_tam := rettam(w-2,ccoluna,"C")
					DbSelectArea("SB1")
					DbSetOrder(1)
					DbSeek(xfilial("SB1")+AllTrim(cCodigo)+OMSGrade:ACOLS[i,1]+_tam)

					_codbar := alltrim(OMSGrade:ACOLS[i,w]) + cValToChar(dig13(alltrim(OMSGrade:ACOLS[i,w])))
					If Found() .and. alltrim(SB1->B1_CODBAR) == ""
						RecLock("SB1",.F.)
							Replace B1_CODBAR		with _codbar
						MsUnLock()
						
						If cCodBarMV < alltrim(OMSGrade:ACOLS[i,w])
							cCodBarMV := alltrim(OMSGrade:ACOLS[i,w])
						End
					Endif
				Endif
			Next
		Endif
	Next
	If cCodBarMV <> ""
		PutMv ("MV_HCODBAR",cCodBarMV)
	End
ElseIf _tp = 8 .or. _tp = 9
	For i := 1 to Len(oMSGrade:ACOLS)
		If oMSGrade:ACOLS[i,len(oMSGrade:AHEADER)+1] == .F.
			DbSelectArea("SZH")
			DbSetOrder(1)
			DbSeek(xfilial("SZH")+SubString(cCodigo,1,15))

			If !Found()
				RecLock("SZH",.T.)
				Replace ZH_FILIAL			with 	xfilial("SZD")
				Replace ZH_PRODUTO		with SubString(cCodigo,1,15)
			Else
				RecLock("SZH",.F.)
			Endif
			For w := 1 to len(oMSGrade:aHeader)
				_cpo := oMSGrade:AHEADER[w,2]
				Replace &(_cpo)		with oMSGrade:ACOLS[i,w]
			Next
			MsUnLock()
		Endif
	Next
ElseIf _tp = 11 .or. _tp = 12
	For i := 1 to Len(oMSGrade:ACOLS)
		//incluido bloco abaixo [Mauro Nagata, Actual Trend, 20190526]
		DbSelectArea("SZN")
		DbSetOrder(2)
		DbSeek(xfilial("SZN")+PADR(cCodigo,15)+oMSGrade:ACOLS[i,1])
		//fim bloco [Mauro Nagata, Actual Trend, 20190526]
		If oMSGrade:ACOLS[i,len(oMSGrade:AHEADER)+1] == .F.
			/*
			//excluido bloco abaixo [Mauro Nagata, Actual Trend, 20190526]
			DbSelectArea("SZN")
			DbSetOrder(2)
			DbSeek(xfilial("SZN")+PADR(cCodigo,15)+oMSGrade:ACOLS[i,1])
			//fim bloco [Mauro Nagata, Actual Trend, 20190526]
			*/

			If !Found()
				RecLock("SZN",.T.)
				Replace ZN_FILIAL		with xfilial("SZN")
				Replace ZN_PRODUTO		with SubString(cCodigo,1,15)
				Replace ZN_NMPARTE		with oMSGrade:ACOLS[i,1]
				Replace ZN_PARTES		with oMSGrade:ACOLS[i,2]
				Replace ZN_TOLERA		with oMSGrade:ACOLS[i,3]
			Else
				RecLock("SZN",.F.)
				Replace ZN_PARTES		with oMSGrade:ACOLS[i,2]
				Replace ZN_TOLERA		with oMSGrade:ACOLS[i,3]
			Endif
			For w := 4 to len(oMSGrade:aHeader)
				_cpo := oMSGrade:AHEADER[w,2]
				Replace &(_cpo)		with oMSGrade:ACOLS[i,w]
			Next
			MsUnLock()
		//incluido bloco abaixo [Mauro Nagata, Actual Trend, 20190526]
		Else
			If Found()
				RecLock("SZN",.F.)
					DbDelete()
				MsUnLock()
			EndIf
		//fim bloco [Mauro Nagata, Actual Trend, 20190526]
		Endif
	Next
ElseIf _tp = 13 .or. _tp = 14
	For i := 1 to Len(oMSGrade:ACOLS)
		If oMSGrade:ACOLS[i,len(oMSGrade:AHEADER)+1] == .F.
			DbSelectArea("SZO")
			DbSetOrder(1)
			DbSeek(xfilial("SZO")+PADR(cCodigo,15)+oMSGrade:ACOLS[i,2])

			If !Found()
				RecLock("SZO",.T.)
				Replace ZO_FILIAL			with xfilial("SZO")
				Replace ZO_PRODUTO		with SubString(cCodigo,1,15)
				Replace ZO_TEMPO			with oMSGrade:ACOLS[i,1]				
				Replace ZO_DESCRI			with oMSGrade:ACOLS[i,2]
				Replace ZO_OBS				with oMSGrade:ACOLS[i,3]
				Replace ZO_OBSMAQ			with oMSGrade:ACOLS[i,4]
			Else
				RecLock("SZO",.F.)
				Replace ZO_TEMPO			with oMSGrade:ACOLS[i,1]
				Replace ZO_DESCRI			with oMSGrade:ACOLS[i,2]
				Replace ZO_OBS				with oMSGrade:ACOLS[i,3]
				Replace ZO_OBSMAQ			with oMSGrade:ACOLS[i,4]
			Endif
			MsUnLock()
			
			DbSelectArea("SB4")
			DbSetOrder(1)
			DbSeek(xfilial("SB4")+cCodigo)

			If Found()
				RecLock("SB4",.F.)
					Replace B4_YTEMPO			with cTempo
				MsUnLock()
			End
			
		Endif
	Next
ElseIf _tp = 10
	For i := 1 to Len(oMSSta:ACOLS)
		If oMSSta:ACOLS[i,len(oMSSta:AHEADER)+1] == .F.
			DbSelectArea("SZL")
			DbSetOrder(1)
			DbSeek(xfilial("SZL")+oMSSta:ACOLS[i,1]+oMSSta:ACOLS[i,2]+oMSSta:ACOLS[i,3])

			If !Found()
				RecLock("SZL",.T.)
					Replace ZL_FILIAL			with xfilial("SB1")
					Replace ZL_PRODUTO		with oMSSta:ACOLS[i,1]
					Replace ZL_COR			with oMSSta:ACOLS[i,2]
					Replace ZL_TAM			with oMSSta:ACOLS[i,3]
					Replace ZL_STATUS			with oMSSta:ACOLS[i,4]
					Replace ZL_DTLIBER		with oMSSta:ACOLS[i,5]
					Replace ZL_DTENCER		with oMSSta:ACOLS[i,6]
			Else
				RecLock("SZL",.F.)
					Replace ZL_STATUS			with oMSSta:ACOLS[i,4]
					Replace ZL_DTLIBER		with oMSSta:ACOLS[i,5]
					Replace ZL_DTENCER		with oMSSta:ACOLS[i,6]
			Endif
			MsUnLock()
			
			DbSelectArea("SB1")
			DbSetOrder(1)
			DbSeek(xfilial("SB1")+oMSSta:ACOLS[i,1]+oMSSta:ACOLS[i,2]+oMSSta:ACOLS[i,3])
			If Found()
				RecLock("SB1",.F.)
					Replace B1_YSITUAC		with oMSSta:ACOLS[i,4]
					Replace B1_YDATLIB		with oMSSta:ACOLS[i,5]
					Replace B1_YDATENC		with oMSSta:ACOLS[i,6]
				MsUnLock()
			End
		End			
	Next
ElseIf _tp = 15
	For _i := 1 to len(oMSSKU:aCols)
		DbSelectArea("SZ7")
		DbSetOrder(1)
		DbSeek(xfilial("SZ7")+SubStr(cCodigo,1,15)+alltrim(oMSSKU:aCols[_i,1]))
		
		_tem := ASCAN( oMSSKU:aCols, {|x| Alltrim(x[1]) == alltrim(oMSSKU:aCols[_i,LEN(oMSSKU:AHEADER)-1])})
		IF Found()
			RecLock("SZ7",.F.)
			For _w := 3 to Len(oMSSKU:aHeader)
				_campo := "SZ7->"+oMSSKU:aheader[_w][2]
				Replace &(_campo) with oMSSKU:ACOLS[_i,_w]
			Next
			MsUnlock()
		 Else
			RecLock("SZ7",.T.)
			Replace Z7_FILIAL	with xfilial("SZ7")
			Replace Z7_PRODUTO 	with cCodigo
			Replace Z7_COR		with oMSSKU:aCols[_i,1]
			Replace Z7_CORCLI	with oMSSKU:aCols[_i,3]
			For _w := 4 to Len(oMSSKU:aHeader)
				_campo := "SZ7->"+oMSSKU:aheader[_w][2]
				Replace &(_campo) with oMSSKU:ACOLS[_i,_w]
			Next
			MsUnlock()
		Endif
	Next

	For _iw := 1 to 25
		_qry := "update "+RetSqlName("SB1")+" set B1_CODCLI = Z7_TAM0"+strzero(_iw,2)+" "
		_qry += "from ( "
		_qry += "Select SZ7.* "
		_qry += ", (Select top 1 BV_CHAVE from (Select top "+strzero(_iw,2)+" BV_CHAVE, R_E_C_N_O_ from "+RetSqlName("SBV")+" SBV where SBV.D_E_L_E_T_ = '' and BV_TABELA = B4_COLUNA order by SBV.R_E_C_N_O_) as T order by T.R_E_C_N_O_ desc) as Tamanho "
		_qry += "from "+RetSqlName("SZ7")+" SZ7 "
		_qry += "left join "+RetSqlName("SB4")+" SB4 on SB4.D_E_L_E_T_ = '' and Z7_PRODUTO = B4_COD "
		_qry += "Where SZ7.D_E_L_E_T_ = '' and Z7_TAM0"+strzero(_iw,2)+" <> '' "
		_qry += "AND B4_XCLIENT = '000004' "
//		_qry += "and Z7_PRODUTO " // = '"+cCodigo+"' "

//		_qry += "in ( "
//		_qry += "Select left(B1_COD,8) from ( "
//		_qry += "Select left(C6_PRODUTO,8) COD from "+RetSqlName("SC6")+" where C6_CLI = '000004' and D_E_L_E_T_ = '' "
//		_qry += "group by left(C6_PRODUTO,8)) as W "
//		_qry += "left join "+RetSqlName("SB1")+" SB1 on SB1.D_E_L_E_T_ = '' and left(B1_COD,8) = W.COD "
//		_qry += "where B1_CODCLI = '' "
//		_qry += "group by Left(B1_COD,8) "
//		_qry += ") "

		_qry += ") as W "
		_qry += "left join "+RetSqlName("SB1")+" SB1 on SB1.D_E_L_E_T_ = '' and B1_COD = ltrim(rtrim(Z7_PRODUTO))+ltrim(rtrim(Z7_COR))+Tamanho "
		_qry += "where B1_CODCLI <> W.Z7_TAM0"+strzero(_iw,2)+" and B1_CODCLI = '' "

		TcSqlExec("_qry")
	Next

ElseIf _tp = 16
	For _i := 1 to len(oMSVAR:aCols)
		DbSelectArea("SZS")
		DbSetOrder(1)
		DbSeek(xfilial("SZS")+SubStr(cCodigo,1,8)+oMSVAR:aCols[_i,1])
		
		_tem := ASCAN( oMSVAR:aCols, {|x| Alltrim(x[1]) == alltrim(oMSVAR:aCols[_i,LEN(oMSVAR:AHEADER)-1])})
		IF Found()
			RecLock("SZS",.F.)
			SZS->ZS_ITEM    := oMSVAR:aCols[_i,1]
			SZS->ZS_VARIANT := oMSVAR:aCols[_i,2]
			SZS->ZS_DESCRI  := oMSVAR:aCols[_i,3]
			MsUnlock()
		 Else
			RecLock("SZS",.T.)
			SZS->ZS_ITEM    := oMSVAR:aCols[_i,1]
			SZS->ZS_VARIANT := oMSVAR:aCols[_i,2]
			SZS->ZS_DESCRI  := oMSVAR:aCols[_i,3]
			MsUnlock()
		Endif
	Next		
Endif

If nCustSTD > 0
	cquery := "update "+RetSqlName("SB1")+" set B1_CUSTD = "+str(nCustSTD)+" where left(B1_COD,8) = '"+SubStr(cCodigo,1,8)+"' "
	TcSqlExec(cQuery)
Endif

oDlg:End()

Return

Static Function ULTITEM()

Local cRet := "0001"
Local cQuery := ""

cQuery := "select MAX(DA1_ITEM) AS DA1_ITEM "
cQuery += CRLF + "from "+RetSqlName("DA1")+" DA1 "
cQuery += CRLF + "where DA1_CODTAB = '"+cTabPrc+"' "
cQuery += CRLF + "and D_E_L_E_T_ = '' "

cQuery := ChangeQuery(cQuery)

dbusearea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TMPDA1",.T.,.T.)

DbSelectArea("TMPDA1")

If TMPDA1->(!EOF())
	cRet := AllTrim(TMPDA1->DA1_ITEM)
EndIf

TMPDA1->(DbCloseArea())

Return cRet

Static Function rettam(ordtam,xcoluna,_tp)
// Rotina para retornar o nome da coluna de Tamanho
// O mesmo n˙mero da coluna È posiÁ„o do SBV.
_BVTAM := ""

cQuery  := "SELECT Top "+str(ordtam)+" BV_FILIAL, BV_TABELA, BV_CHAVE, BV_DESCRI FROM " +RetSQLName("SBV") + " WHERE "
cQuery  += "BV_FILIAL = '" +xFilial("SBV") +"' AND BV_TABELA = '" +xcoluna+ "' AND D_E_L_E_T_ = '' " 
cQuery += "ORDER BY R_E_C_N_O_"

cQuery := ChangeQuery(cQuery)
If Select("TMPSBV") > 0 
   	 TMPSBV->(DbCloseArea()) 
EndIf 
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TMPSBV",.T.,.T.)

DbSelectArea("TMPSBV")
DbGoTop()                                                                                             

While !EOF()
	If _TP == "C"
		_BVTAM := TMPSBV->BV_CHAVE
	Else
		_BVTAM := TMPSBV->BV_DESCRI	
	Endif
	DbSkip()
End

DbCloseArea()

Return(_BVTAM)


Static Function hCompo()
//Criar e Visualizar composiÁ„o

Local oButton1
Local oButton2
Local xopc	:= 0
Local cSoma	:= 0
Local cRet	:= ""
Local cRet2	:= ""
Local nX
Static oDlx

  DEFINE MSDIALOG oDlx TITLE "ComposiÁ„o" FROM 000, 000  TO 350, 700 COLORS 0, 16777215 PIXEL

    fCompo()
    @ 143, 305 BUTTON oButton1 PROMPT "Ok" SIZE 037, 012 ACTION (xopc := 1,oDlx:End()) OF oDlx PIXEL
    @ 143, 263 BUTTON oButton2 PROMPT "Cancelar" SIZE 037, 012 ACTION (xopc := 0,oDlx:End()) OF oDlx PIXEL

  ACTIVATE MSDIALOG oDlx CENTERED

  If xopc == 1
	For nX := 1 to Len(oMSCompo:aCols)
		If OMSCompo:ACOLS[nX,len(OMSCompo:AHEADER)+1] == .F. .and. AllTrim(oMSCompo:aCols[nX,1])<>''
			If nx<>1
				cRet	+= ";" 
				cRet2	+= ";"
			End

			cRet  += oMSCompo:aCols[nX,1]+"-"+strzero(val(oMSCompo:aCols[nX,3]),3)
			cRet2 += AllTrim(oMSCompo:aCols[nX,2])+"-"+strzero(val(oMSCompo:aCols[nX,3]),3)
		Endif
	Next
  ElseIf xopc == 0
  	cRet	:= AllTrim(oMSGrade:aCols[oMSGrade:nat,3])
  	cRet2	:= AllTrim(oMSGrade:aCols[oMSGrade:nat,4])
  Endif

	If AllTrim(cRet) == "-000"
		 cRet	:=""
		 cRet2	:=""
	End

/*	//retirado porque nao deve calcular o valor total da porcentagem
  	cSoma	:= 0	
	For nX := 1 to Len(oMSCompo:aCols)
		cSoma := cSoma + val(oMSCompo:aCols[nX,3])
		If cSoma > 100
			Alert("Revisar percentuais a soma ultrapassa 100%")
			Return(.F.)
		End
	Next
*/

oMSGrade:aCols[oMSGrade:nat,3] := cRet
oMSGrade:aCols[oMSGrade:nat,4] := cRet2
oMsGrade:refresh() 

Return

//------------------------------------------------
Static Function fCompo()
//------------------------------------------------
// Acols para composiÁ„o
// SX5: Z1
// Utiliza estes campos (SF4) para n„o precisar criar uma tabela especÌfica para isso

Local nX
Local aHeaderEx 		:= {}
Local aColsEx 		:= {}
Local aFieldFill 		:= {}
Local aFields 		:= {"F4_CODIGO","F4_TEXTO","F4_CFEXT"}
Local aAlterFields 	:= {"F4_CODIGO","F4_CFEXT"}
Static oMSCompo

  // Define field properties
  DbSelectArea("SX3")
  SX3->(DbSetOrder(2))
  For nX := 1 to Len(aFields)
    If SX3->(DbSeek(aFields[nX]))
	  If nX == 1     
      	Aadd(aHeaderEx, {"CÛdigo",SX3->X3_CAMPO,SX3->X3_PICTURE,/*TAMANHO*/5,SX3->X3_DECIMAL,"U_PESQCOMP(M->F4_CODIGO)",;
                       SX3->X3_USADO,SX3->X3_TIPO,"Z1",SX3->X3_CONTEXT,SX3->X3_CBOX,SX3->X3_RELACAO})
      ElseIf nX == 2
      	Aadd(aHeaderEx, {"DescriÁ„o",SX3->X3_CAMPO,SX3->X3_PICTURE,/*TAMANHO*/50,SX3->X3_DECIMAL,"",;
                       SX3->X3_USADO,SX3->X3_TIPO,"",SX3->X3_CONTEXT,SX3->X3_CBOX,SX3->X3_RELACAO})
      Else
      	Aadd(aHeaderEx, {"Percentual",SX3->X3_CAMPO,SX3->X3_PICTURE,/*TAMANHO*/3,SX3->X3_DECIMAL,"VAL(M->F4_CFEXT) <= 100",;
                       SX3->X3_USADO,SX3->X3_TIPO,SX3->X3_F3,SX3->X3_CONTEXT,SX3->X3_CBOX,SX3->X3_RELACAO})
      Endif
    Endif
  Next nX

  // Define field values
  If oMSGrade:aCols[oMSGrade:nat,3] = ""
  	For nX := 1 to Len(aFields)
    	If DbSeek(aFields[nX])
      		Aadd(aFieldFill, CriaVar(SX3->X3_CAMPO))
    	Endif
  	Next nX
  	Aadd(aFieldFill, .F.)
  	Aadd(aColsEx, aFieldFill)
  Else
  	For nX := 1 to len(alltrim(oMSGrade:aCols[oMSGrade:nat,3]))
  		Aadd(aFieldFill, SubStr(oMSGrade:aCols[oMSGrade:nat,3],nx,5))
  		Aadd(aFieldFill, POSICIONE("SX5",1,xFilial("SX5")+'Z1'+SubStr(oMSGrade:aCols[oMSGrade:nat,3],nx,5),"X5_DESCRI"))
  		Aadd(aFieldFill, Strzero(Val(SubStr(oMSGrade:aCols[oMSGrade:nat,3],nx+6,3)),3))
	  	Aadd(aFieldFill, .F.)

  		Aadd(aColsEx, aFieldFill)
  		aFieldFill := {}
		nX += 9
  	Next
  Endif

  oMSCompo := MsNewGetDados():New( 008, 006, 130, 344, GD_INSERT+GD_DELETE+GD_UPDATE, "AllwaysTrue", "AllwaysTrue", "+Field1+Field2", aAlterFields,, 999, "AllwaysTrue", "", "AllwaysTrue", oDlx, aHeaderEx, aColsEx)

Return

User Function PESQCOMP(cCompo)

Local lRet := .F.

DbselectArea("SX5")
DbSetOrder(1)
If DbSeek(xFilial("SX5")+"Z1"+cCompo)
	oMSCompo:aCols[oMSCompo:nat,2] := SX5->X5_DESCRI
	lRet := .T.
EndIf

Return lRet
						
Static function VldCod()
// Rotina para criaÁ„o de cÛdigo autom·tico do produto
    
//If !Empty(cGrupo)
//	DbSelectArea("SBM")
//	DbSetOrder(1)
//	DbSeek(xfilial("SBM")+cGrupo)
	 
//	_cod := Space(26)
	
//	IF AllTrim(cGrupo)<>""
//		_ini := cTipo+SBM->BM_YCODPRO
//		_ini := cTipo
//	Else
//		_ini := Space(4)
//	End
		
//	IF !SubStr(_ini,1,2) $ "KT|PA|ME|PI|SV|MO|  "
	
//		cQuery := "select Top 1 B4_COD from "+RetSqlName("SB4")+" SB4 "
//		cQuery += "where SB4.D_E_L_E_T_ = '' "
//		cQuery += "and B4_COD like '"+alltrim(_ini)+"%' "
//		cQuery += "order by B4_COD desc "
    
//		cQuery := ChangeQuery(cQuery)

//		If Select("TMP3") > 0                                 
//  		TMP3->(dbclosearea())
//		EndIf
	    
//		DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQuery),"TMP3",.F.,.F.)       
	
//		DbSelectArea("TMP3")
//		DbGoTop()
//		If EOF()
//			_cod := _ini+"0001"
//		Else
//			_cod := _ini+Soma1(SubStr(TMP3->B4_COD,5,4))
//		Endif

//  		TMP3->(dbclosearea())
//  	Endif
   	
   	cGrupoDesc		:= POSICIONE("SBM",1,xFilial("SBM")+cGrupo,"BM_DESC")
//	cCodigo 		:= _cod
//EndIf	

//If Alltrim(cGrupoDesc)=="" 
//	oGrupo:SetFocus()
//End

oDlg:Refresh()	
return()

Static function VldCod2(vCod)
// Rotina para criaÁ„o de cÛdigo autom·tico do produto
    
	If !Empty(vCod)
		//cQuery := "SELECT COUNT(B1_COD) AS COUNT_COD FROM SB1010 WHERE B1_COD LIKE '"+Alltrim(vCod)+"%' "
		//substituida linha acima pela abaixo [Mauro Nagata, Actual Trend, 20180724] 
		cQuery := "SELECT COUNT(B1_COD) AS COUNT_COD FROM SB1"+cFilAnt+"0 WHERE B1_COD LIKE '"+Alltrim(vCod)+"%' and D_E_L_E_T_ = '' "
	
		TCQuery cQuery New Alias "QRY_08"
		DbSelectArea("QRY_08")
		QRY_08->(DbGotop())
		vCodCount	:= QRY_08->COUNT_COD
		QRY_08->(DBCloseArea())
		
		If vCodCount >= 1
			Alert("Este codigo de produto j· foi utilizado, favor alterar")
			oCodigo:SetFocus()
		ElseIf len(AllTrim(vCod)) <> 8
			Alert("Corrigir quantidade de caracteres no codigo Codigo.")
			oCodigo:SetFocus()
		EndIf
    EndIf
    
Return()


Static Function dig13(_codb)
// C·lculo do dÌgito verificador do CÛdigo de Barras EAN13

_dig := ""
_calc := Val(SubStr(_codb,1,1))*1 + Val(SubStr(_codb,2,1))*3 + Val(SubStr(_codb,3,1))*1 + Val(SubStr(_codb,4,1))*3 + Val(SubStr(_codb,5,1))*1 + Val(SubStr(_codb,6,1))*3 + Val(SubStr(_codb,7,1))*1 + Val(SubStr(_codb,8,1))*3 + Val(SubStr(_codb,9,1))*1 + Val(SubStr(_codb,10,1))*3 + Val(SubStr(_codb,11,1))*1 + Val(SubStr(_codb,12,1))*3    
_dig := ((Int(_calc/10)+1)*10)-_calc

iF _dig =10
	_dig :=0
End

Return(_dig)

User Function PrecPro(_tp)
// Rotina para formaÁ„o de preÁo

Local cCabecalho

Local oSay1
Local oSay2
Local oSay3
Local oSay4
Local oSay5
Local oSay6
Local oSay7
Local oSay8

Local oButton1
Local oButton2

Local oCodigo
Local oDesc
Local oTabela
Local odescTab
Local oDtDe
Local oDtAte
Local oVrMP
Local oVrMO
Local oVrMPA
Local oVrMOA
Local _i

Private cCodigo 		:= SubString(SB4->B4_COD,1,15)
Private cDesc 		:= SB4->B4_DESC
Private cTabela		:= Space(03)
Private cdescTab		:= Space(60)
Private cDtDe			:= ddatabase
Private cTipo		:= Space(10)
Private cVrMP			:= 0
Private cVrGeral		:= 0
Private cVrGerAnt		:= 0
Private cVrMO			:= 0
Private cVrMPA		:= 0
Private cVrMOA		:= 0
Private cCusto		:= 0
Private cCusA			:= 0

Private cStatus		:= ""
Private nAjuste 		:= 0
Static oDlg1

If _tp == 1
	AjuSX1("HPRECO")
	Pergunte("HPRECO",.T.)
	For _i:=1 to len(MV_PAR01) step 4
		If SubStr(MV_PAR01,_i,1) <> "*"
			cStatus += "'"+SubStr(MV_PAR01,_i,4)+"',"
		Endif
	Next
	cStatus := SubStr(cStatus,1,len(alltrim(cStatus))-1)
	cCabecalho := "Inclus„o da FormaÁ„o de PreÁo de Produtos"
ElseIf  _tp == 2
	cCabecalho := "AlteraÁ„o da FormaÁ„o de PreÁo de Produtos"
ElseIf  _tp == 3
	cCabecalho := "Visualizar da FormaÁ„o de PreÁo de Produtos"
End

  DEFINE MSDIALOG oDlg1 TITLE cCabecalho FROM 000, 000  TO 550, 1250 COLORS 0, 16777215 PIXEL

    @ 010, 012 SAY oSay1 PROMPT "CÛdigo" 				SIZE 021, 007 OF odlg1 COLORS 0, 16777215 			PIXEL
    @ 008, 043 MSGET oCodigo VAR cCodigo 				SIZE 077, 010 OF odlg1 COLORS 0, 16777215 READONLY 	PIXEL
    @ 010, 135 SAY oSay2 PROMPT "DescriÁ„o" 			SIZE 025, 007 OF odlg1 COLORS 0, 16777215 			PIXEL
    @ 008, 170 MSGET oDesc VAR cDesc 					SIZE 300, 010 OF odlg1 COLORS 0, 16777215 READONLY 	PIXEL
    @ 010, 532 SAY oSay7 PROMPT "Ajuste"				SIZE 025, 007 OF odlg1 COLORS 0, 16777215 			PIXEL
    @ 008, 560 MSGET oAju VAR nAjuste 					SIZE 060, 010 PICTURE "@E 99.9" OF odlg1 COLORS 0, 16777215 		 	PIXEL

    @ 032, 012 SAY oSay3 PROMPT "Tabela" 				SIZE 021, 007 OF odlg1 COLORS 0, 16777215 			PIXEL
    @ 030, 040 MSGET oTabela VAR cTabela 				SIZE 060, 010 OF odlg1 VALID !VAZIO() .AND. valTab(_tp, cTabela) COLORS 0, 16777215 	F3 "DA0" 	PIXEL
        
    @ 032, 115 SAY oSay4 PROMPT "DescriÁ„o Tabela" 	SIZE 050, 007 OF odlg1 COLORS 0, 16777215 			PIXEL
    @ 030, 162 MSGET odescTab VAR cdescTab 			SIZE 242, 010 OF odlg1 COLORS 0, 16777215 READONLY 	PIXEL

    @ 032, 429 SAY oSay5 PROMPT "Data De" 			SIZE 021, 007 OF odlg1 COLORS 0, 16777215 			PIXEL
    @ 030, 457 MSGET oDtDe VAR cDtDe	 				SIZE 060, 010 OF odlg1 VALID !VAZIO() COLORS 0, 16777215 			PIXEL
    @ 032, 532 SAY oSay6 PROMPT "Tipo" 			SIZE 021, 007 OF odlg1 COLORS 0, 16777215 			PIXEL
    @ 030, 560 MSGET oDtAte VAR cTipo 				SIZE 060, 010 OF odlg1 VALID !VAZIO() COLORS 0, 16777215 		 	PIXEL

    fMSPreco(_tp)
    @ 253, 520 BUTTON oButton1 PROMPT "Ok" 			SIZE 045, 012 ACTION (lok:=1,SavePrc(_tp),oDlg1:End()) 		OF oDlg1	PIXEL
    @ 253, 575 BUTTON oButton2 PROMPT "Cancelar" 	SIZE 045, 012 ACTION (lok:=2,oDlg1:End()) 					OF oDlg1 	PIXEL

    @ 235, 012 SAY oSay7 PROMPT "Totais Ant:"			SIZE 050, 007 OF odlg1 COLORS 0, 16777215 			PIXEL
    @ 255, 012 SAY oSay7 PROMPT "Totais Atu:"			SIZE 050, 007 OF odlg1 COLORS 0, 16777215 			PIXEL
    @ 235, 044 SAY oSay8 PROMPT "MP:"					SIZE 050, 007 OF odlg1 COLORS 0, 16777215 			PIXEL

	@ 233, 065 MSGET oVrMPA VAR cVrMPA	 				SIZE 060, 010 PICTURE "@E 999,999.9999" OF odlg1 COLORS 0, 16777215 READONLY 	PIXEL
    @ 253, 065 MSGET oVrMP VAR cVrMP	 				SIZE 060, 010 PICTURE "@E 999,999.9999" OF odlg1 COLORS 0, 16777215 READONLY 	PIXEL
    @ 235, 155 SAY oSay8 PROMPT "MO:"					SIZE 050, 007 OF odlg1 COLORS 0, 16777215 			PIXEL
    @ 233, 166 MSGET oVrMOA VAR cVrMOA 				SIZE 060, 010 PICTURE "@E 999,999.9999" OF odlg1 COLORS 0, 16777215 READONLY 	PIXEL
    @ 253, 166 MSGET oVrMO VAR cVrMO 					SIZE 060, 010 PICTURE "@E 999,999.9999" OF odlg1 COLORS 0, 16777215 READONLY 	PIXEL
    @ 235, 260 SAY oSay9 PROMPT "Ajuste:"				SIZE 050, 007 OF odlg1 COLORS 0, 16777215 			PIXEL

    @ 233, 279 MSGET oCustA VAR cCusA 					SIZE 060, 010 PICTURE "@E 999,999.9999" OF odlg1 COLORS 0, 16777215 READONLY 	PIXEL
    @ 253, 279 MSGET oCusto VAR cCusto 				SIZE 060, 010 PICTURE "@E 999,999.9999" OF odlg1 COLORS 0, 16777215 READONLY 	PIXEL
    
//    @ 255, 279 SAY oSay10 PROMPT "MO:"				SIZE 050, 007 OF odlg1 COLORS 0, 16777215 			PIXEL
    @ 235, 410 SAY oSay11 PROMPT "Total:"				SIZE 050, 007 OF odlg1 COLORS 0, 16777215 			PIXEL
    @ 233, 432 MSGET oVrGerA VAR cVrGerAnt			SIZE 060, 010 PICTURE "@E 999,999.9999" OF odlg1 COLORS 0, 16777215 READONLY 	PIXEL    
    @ 253, 432 MSGET oVrGer VAR cVrGeral				SIZE 060, 010 PICTURE "@E 999,999.9999" OF odlg1 COLORS 0, 16777215 READONLY 	PIXEL

  ACTIVATE MSDIALOG oDlg1 CENTERED
	
Return

//------------------------------------------------
Static Function fMSPreco(_tp)
//------------------------------------------------
// Acols para formaÁ„o de preÁo
// Tabela: SZI

Local nX
Local aHeader1 		:= {}
Local aCols1 			:= {}
Local aFieldFill 	:= {}
Local aFields 		:= {"ZI_COMP","ZI_DESCCOM","ZI_UM","ZI_QTD","ZI_CANT","ZI_CATU","ZI_TOTAL","ZI_TOTANT"}
Local aAlterFields 	:= {"ZI_CATU"}
Local _vrmo  := 0
Local _vrmp  := 0
Local _vrmoa := 0
Local _vrmpa := 0
Local _i
Static oMSPreco

  // Define field properties
  DbSelectArea("SX3")
  SX3->(DbSetOrder(2))
  For nX := 1 to Len(aFields)
    If SX3->(DbSeek(aFields[nX]))
      Aadd(aHeader1, {AllTrim(X3Titulo()),SX3->X3_CAMPO,SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL,SX3->X3_VALID,;
                       SX3->X3_USADO,SX3->X3_TIPO,SX3->X3_F3,SX3->X3_CONTEXT,SX3->X3_CBOX,SX3->X3_RELACAO})
    Else
	    If aFields[nX]=="ZI_DESCCOM" .AND. SX3->(DbSeek("B1_DESC"))
	    		Aadd(aHeader1, {AllTrim(X3Titulo()),SX3->X3_CAMPO,SX3->X3_PICTURE,70,SX3->X3_DECIMAL,"",; 
	    					SX3->X3_USADO,SX3->X3_TIPO,SX3->X3_F3,SX3->X3_CONTEXT,SX3->X3_CBOX,SX3->X3_RELACAO})
	    ElseIf aFields[nX]=="ZI_UM" .AND. SX3->(DbSeek("B1_UM"))
	    		Aadd(aHeader1, {AllTrim(X3Titulo()),SX3->X3_CAMPO,SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL,"",;
	                       SX3->X3_USADO,SX3->X3_TIPO,SX3->X3_F3,SX3->X3_CONTEXT,SX3->X3_CBOX,SX3->X3_RELACAO})
	    ElseIf aFields[nX]=="ZI_QTD" .AND. SX3->(DbSeek("G1_QUANT"))
	    		Aadd(aHeader1, {AllTrim(X3Titulo()),SX3->X3_CAMPO,SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL,"",;
	                       SX3->X3_USADO,SX3->X3_TIPO,SX3->X3_F3,SX3->X3_CONTEXT,SX3->X3_CBOX,SX3->X3_RELACAO})
	    ElseIf aFields[nX]=="ZI_TOTAL" .AND. SX3->(DbSeek("ZI_CANT"))
	    		Aadd(aHeader1, {"Total ",SX3->X3_CAMPO,SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL,"",;
	                       SX3->X3_USADO,SX3->X3_TIPO,SX3->X3_F3,SX3->X3_CONTEXT,SX3->X3_CBOX,SX3->X3_RELACAO})
	    ElseIf aFields[nX]=="ZI_TOTANT" .AND. SX3->(DbSeek("ZI_CANT"))
	    		Aadd(aHeader1, {"Tot Ant",SX3->X3_CAMPO,SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL,"",;
	                       SX3->X3_USADO,SX3->X3_TIPO,SX3->X3_F3,SX3->X3_CONTEXT,SX3->X3_CBOX,SX3->X3_RELACAO})
	    Endif
    Endif
  Next nX
  
  IF _tp = 1
	  // Query para c·lculo de mÈdia de quantidades de MatÈria Prima por grade
	
	If SB4->B4_TIPO = "KT"
		_xcod := "in ('"
		DbSelectArea("SG1")
		DbSetOrder(1)
		DbSeek(xfilial("SG1")+SubStr(SB4->B4_COD,1,8))
		_akit := {}
		While !EOF() .and. SubStr(SG1->G1_COD,1,8) = SubStr(SB4->B4_COD,1,8)
			_tem := ASCAN( _aKit, {|x| x[1] == SubStr(SG1->G1_COMP,1,8)})
			If _tem = 0
				aadd(_akit,{SubStr(SG1->G1_COMP,1,8)})
			Endif
			DbSelectArea("SG1")
			DbSkip()
		End 
		For _i := 1 to len(_akit)
			_xcod += _akit[_i,1]+"','"
		Next
		_xcod := SubStr(_xcod,1,len(_xcod)-2)+")"
	Else
		_xcod := "= '"+SubStr(SB4->B4_COD,1,8)+"'"
	Endif

  	_qry := "Select G1_COMP, TOT, B4_DESC, B4_UM from ( "
  	_qry += "Select left(G1_COMP,8) as G1_COMP, Sum(G1_QUANT) "
  	_qry += "/(Select Count(*) as Tot from ( " 
  	_qry += "Select SG1D.G1_COD from "+RetSqlName("SG1")+" SG1D "
  	_qry += "inner join "+RetSqlName("SB1")+" SB1B on SB1B.D_E_L_E_T_ = '' and SB1B.B1_COD = SG1D.G1_COD and B1_YSITUAC in ("+cStatus+") "
  	_qry += "where lEFT(SG1D.G1_COD,8) "+_xcod+" and SG1D.D_E_L_E_T_ = '' group by SG1D.G1_COD) as X) AS TOT " 
  	_qry += "from "+RetSqlName("SG1")+" SG1A "
  	_qry += "inner join "+RetSqlName("SB1")+" SB1 on SB1.D_E_L_E_T_ = '' and SB1.B1_COD = SG1A.G1_COD and B1_YSITUAC in ("+cStatus+") "
	_qry += "inner join "+RetSqlName("SB1")+" SB1X on SB1X.D_E_L_E_T_ = '' and SB1X.B1_COD = SG1A.G1_COMP "
  	_qry += "where LEFT(G1_COD,8) "+_xcod+" and SG1A.D_E_L_E_T_ = '' and SB1X.B1_TIPO not in ('PI','MI') " 
  	_qry += "Group by left(G1_COMP,8) " 
  	_qry += "union all "
  	_qry += "Select Q.G1_COMP, Sum(TOTAL) as TOT from ( "
  	_qry += "Select Left(X.G1_COD,8) as G1_COD, Left(X.G1_COMP,8) as G1_COMP, Sum(TOT)/Count(*) as TOTAL from ( " 
  	_qry += "Select "
  	_qry += "G1_COD, SG1A.G1_COMP, G1_QUANT * " 
  	_qry += "(Select top 1 SG1C.G1_QUANT from "+RetSqlName("SG1")+" SG1C "
  	_qry += "inner join "+RetSqlName("SB1")+" SB1 on SB1.D_E_L_E_T_ = '' and SB1.B1_COD = SG1C.G1_COD and B1_YSITUAC in ("+cStatus+") "
  	_qry += "where SG1C.D_E_L_E_T_ = '' and SG1C.G1_COMP = SG1A.G1_COD) as TOT " 
  	_qry += "from "+RetSqlName("SG1")+" SG1A where SG1A.G1_COD in ( " 
  	_qry += "Select SG1B.G1_COMP from "+RetSqlName("SG1")+" SG1B "
  	_qry += "inner join "+RetSqlName("SB1")+" SB1 on SB1.D_E_L_E_T_ = '' and SB1.B1_COD = SG1B.G1_COD and B1_YSITUAC in ("+cStatus+") "
  	_qry += "inner join "+RetSqlName("SB1")+" SB1X on SB1X.D_E_L_E_T_ = '' and SB1X.B1_COD = SG1B.G1_COMP "
  	_qry += "where SB1X.B1_TIPO in ('PI','MI') and SG1B.D_E_L_E_T_ = '' and LEFT(SG1B.G1_COD,8) "+_xcod+" group by SG1B.G1_COMP) " 
  	_qry += ") as X "
  	_qry += "group by left(X.G1_COD,8), Left(X.G1_COMP,8) " 
  	_qry += ") as Q group by Q.G1_COMP) as P "
  	_qry += "inner join "+RetSqlName("SB4")+" SB4 on SB4.D_E_L_E_T_ = '' and left(G1_COMP,8) = B4_COD " 
  	_qry += "order by G1_COMP " 

	If Select("TMPSG1") > 0 
     	TMPSG1->(DbCloseArea()) 
	EndIf
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,_Qry),"TMPSG1",.T.,.T.)

  	DbSelectArea("TMPSG1")
  	DbGoTop()

  	While !EOF()

    	_ultprc := pegprg1(ccodigo,TMPSG1->G1_COMP,1,_tp,cDtDe,cTipo)
    	_antprc := pegprg1(ccodigo,TMPSG1->G1_COMP,2,_tp,cDtDe,cTipo)
		If _tp == 1
    		Aadd(aCols1, {TMPSG1->G1_COMP,TMPSG1->B4_DESC,TMPSG1->B4_UM,TMPSG1->TOT,_ultprc,0,0,0,.F.})
    	Else
    		Aadd(aCols1, {TMPSG1->G1_COMP,TMPSG1->B4_DESC,TMPSG1->B4_UM,TMPSG1->TOT,_antprc,_ultprc,TMPSG1->TOT*_ultprc,TMPSG1->TOT*_antprc,.F.})
    	Endif
  
  		DbSelectArea("TMPSG1")
  		DbSkip()
  	End
  	TMPSG1->(dbCloseArea())
  
  Else
  	AjuSX1()
  	Pergunte("HESTC1",.T.)
  	_qry := "Select top 1 * from "+RetSqlName("SZI")+" where D_E_L_E_T_ = '' and ZI_PRODUTO = '"+SB4->B4_COD+"' and ZI_TIPO = '"+MV_PAR01+"' order by ZI_DTDE desc "
	
	If Select("TMPSZI") > 0 
     	 TMPSZI->(DbCloseArea()) 
	EndIf 
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,_Qry),"TMPSZI",.T.,.T.)
  	DbSelectArea("TMPSZI")
  	DbGoTop()

	_dtde := TMPSZI->ZI_DTDE
	DbCloseArea()
	
  	DbSelectArea("SZI")
  	DbSetOrder(1)
  	DbGoTop()
  	DbSeek(xfilial("SZI")+Padr(alltrim(SB4->B4_COD),15)+_dtde+alltrim(MV_PAR01))
  	_tipo := ""
  	_ctab  := ""
  	While !EOF() .and. alltrim(SZI->ZI_PRODUTO) = alltrim(SB4->B4_COD) .and. SZI->ZI_DTDE == stod(_dtde) .and. alltrim(SZI->ZI_TIPO) = alltrim(MV_PAR01)
  		_tipo := SZI->ZI_TIPO
  		_ctab  := SZI->ZI_TABELA
  		DbSelectArea("SB4")
  		_areaB4 := GetArea()
  		DbSetOrder(1)
  		DbSeek(Xfilial("SB4")+alltrim(SZI->ZI_COMP))
  		
 		Aadd(aCols1, {SZI->ZI_COMP,SB4->B4_DESC,SB4->B4_UM,SZI->ZI_QTD,SZI->ZI_CANT,SZI->ZI_CATU,SZI->ZI_QTD*SZI->ZI_CATU,SZI->ZI_QTD*SZI->ZI_CANT,.F.})
  	
		If SB4->B4_TIPO == "MO" .or. SB4->B4_TIPO == "BN"
			_vrmo += SZI->ZI_QTD*SZI->ZI_CATU
			_vrmoa+= SZI->ZI_QTD*SZI->ZI_CANT
		Else
			_vrmp += SZI->ZI_QTD*SZI->ZI_CATU
			_vrmpa+= SZI->ZI_QTD*SZI->ZI_CANT
		Endif 
  		RestArea(_areaB4)
  		DbSelectArea("SZI")
  		DbSkip()
  	End
	cVrMO := _vrmo		//oDlg:cVrMO := str(_vrmo)
	cVrMP := _vrmp		//oDlg:cVrMP := str(_vrmp)
	cVrMOA:= _vrmoa		//oDlg:cVrMO := str(_vrmo)
	cVrMPA:= _vrmpa		//oDlg:cVrMP := str(_vrmp)
	cCusto := (_vrmo*(najuste/100))+(_vrmP*(najuste/100))		//oDlg:cVrMO := str(_vrmo)
	cCusA  := (_vrmoa*(najuste/100))+(_vrmPa*(najuste/100)) 
	cVrGeral:= _vrmo+_vrmp+cCusto
	cVrGerAnt:= cVrMOA+cVrMPA+cCusA  	
	cTabela			:= _ctab
	cdescTab		:= POSICIONE("DA0",1,xFilial("DA0")+_ctab,"DA0_DESCRI")
	cTipo			:= _tipo
	cDtDe			:= stod(_dtde)
	oDlg1:refresh()
  	
  Endif

  oMSPreco := MsNewGetDados():New( 050, 005, 225, 624, GD_INSERT+GD_DELETE+GD_UPDATE, "AllwaysTrue", "AllwaysTrue", "+Field1+Field2", aAlterFields,, 999, "AllwaysTrue", "", "AllwaysTrue", oDlg1, aHeader1, aCols1)
  
Return

Static Function pegprg1(ccodigo,_COMP,_tpprc,_tp,cDtDe,cTipo)
// Busca o PreÁo dos produtos para formaÁ„o de preÁo

  _prc	:= 0
  
  // Pega o ˙ltimo preÁo
  _qry := "Select Top 1 * from  "+RetSqlName("SZI")+" SZI where SZI.D_E_L_E_T_ = '' and "
  _qry += "ZI_COMP = '"+_COMP+"' and ZI_PRODUTO = '"+cCodigo+"' " //and ZI_TABELA = '"+cTabela+"' "
//  If _tp <> 1
//  	_qry += "and ZI_DTDE <= '"+Dtos(Date())+"' and ZI_DTATE >= '"+Dtos(Date())+"' " 
//  Endif
  _qry += "order by R_E_C_N_O_ desc "

  If Select("TMPSZI") > 0 
   	 TMPSZI->(DbCloseArea()) 
  EndIf 

  dbUseArea(.T.,"TOPCONN",TcGenQry(,,_Qry),"TMPSZI",.T.,.T.)
  DbSelectArea("TMPSZI")
  DbGoTop()

  IF _tpprc == 1
  	_prc := TMPSZI->ZI_CATU
  Else
  	_prc := TMPSZI->ZI_CANT
  Endif
  
  TMPSZI->(dbCloseArea())
  
Return(_prc)

Static Function valTab(_tp, cTabela)
// Valida tabela selecionada e atualiza os preÁos

Local _i	:= 0
Local _vrmo	:= 0
Local _vrmp	:= 0
Local _vrmoa:= 0
Local _vrmpa:= 0
Local _i

DbSelectArea("SB4")
DbSetOrder(1)
DbSeek(xfilial("SB4")+SubSt(cCodigo,1,8))

	If SB4->B4_TIPO = "KT"
		_xcod := "in ('"
		DbSelectArea("SG1")
		DbSetOrder(1)
		DbSeek(xfilial("SG1")+SubStr(SB4->B4_COD,1,8))
		_akit := {}
		While !EOF() .and. SubStr(SG1->G1_COD,1,8) = SubStr(SB4->B4_COD,1,8)
			_tem := ASCAN( _aKit, {|x| x[1] == SubStr(SG1->G1_COMP,1,8)})
			If _tem = 0
				aadd(_akit,{SubStr(SG1->G1_COMP,1,8)})
			Endif
			DbSelectArea("SG1")
			DbSkip()
		End 
		For _i := 1 to len(_akit)
			_xcod += _akit[_i,1]+"','"
		Next
		_xcod := SubStr(_xcod,1,len(_xcod)-2)+")"
	Else
		_xcod := "= '"+SubStr(SB4->B4_COD,1,8)+"'"
	Endif

_qry := "Select left(G1_COMP,8) as PRODUTO, Preco2 as PRECO from ( "
_qry += "Select isnull(DA1_PRCVEN,0) as precoa, G1_QUANT, isnull(DA1_PRCVEN,0)*G1_QUANT as Preco, G1_COMP, "
//_qry += "(isnull(DA1_PRCVEN,0)*G1_QUANT) / "
_qry += "(isnull(DA1_PRCVEN,0)) " //
//_qry += "/(Select Count(*) from "+RetSqlName("SB1")+" SB1 WITH (NOLOCK) where SB1.D_E_L_E_T_ = ''  and B1_YSITUAC in ("+cStatus+") and left(B1_COD,8) = Left(G1_COD,8) and (Select top 1 G1_COD from "+RetSqlName("SG1")+" SG1D WITH (NOLOCK) where SG1D.D_E_L_E_T_ = '' and SG1D.G1_COD = B1_COD) is not null) "
_qry += "as Preco2 "
_qry += "from "+RetSqlName("SG1")+" SG1 WITH (NOLOCK) "
_qry += "INNER JOIN "+RetSqlName("SB1")+" SB1X WITH (NOLOCK) ON SB1X.D_E_L_E_T_ = '' AND SG1.G1_COD = SB1X.B1_COD AND SB1X.B1_YSITUAC in ("+cStatus+") "
_qry += "INNER JOIN "+RetSqlName("SB1")+" SB1W WITH (NOLOCK) ON SB1W.D_E_L_E_T_ = '' AND SG1.G1_COMP = SB1W.B1_COD "
_qry += "left join "+RetSqlName("DA1")+" DA1 WITH (NOLOCK) on DA1.D_E_L_E_T_ = '' and DA1_CODTAB = '"+cTabela+"' and DA1_CODPRO = G1_COMP "
_qry += "where SG1.D_E_L_E_T_ = '' and LEFT(G1_COD,8) "+_xcod+" and SB1W.B1_TIPO NOT in ('PI','MI')) as w "
_qry += "group by left(G1_COMP,8), Preco2 "
_qry += "union all "
_qry += "Select left(G1_COMP,8), Preco2 from ( "
//_qry += "Select (isnull(DA1_PRCVEN,0)*Quant)/qtditem as Preco2, "
_qry += "Select (isnull(DA1_PRCVEN,0)) as Preco2, " ///qtditem as Preco2, " 
_qry += "G1_COMP from ( "
_qry += "Select " 
_qry += "(Select Count(*) from "+RetSqlName("SB1")+" SB1 WITH (NOLOCK) where SB1.D_E_L_E_T_ = ''  and B1_YSITUAC in ("+cStatus+") and LEFT(B1_COD,8) "+_xcod+"  and (Select top 1 G1_COD from "+RetSqlName("SG1")+" SG1D WITH (NOLOCK) where SG1D.D_E_L_E_T_ = '' and SG1D.G1_COD = B1_COD) is not null) as qtditem "
_qry += ",G1_COMP, "
_qry += "(Select Top 1 SG1B.G1_QUANT from "+RetSqlName("SG1")+" SG1B WITH (NOLOCK) where SG1B.D_E_L_E_T_ = '' and SG1B.G1_COMP = SG1A.G1_COD ) * G1_QUANT as Quant "
_qry += "from "+RetSqlName("SG1")+" SG1A WITH (NOLOCK) "
_qry += "where SG1A.D_E_L_E_T_ = '' and SG1A.G1_COD in ( "
_qry += "Select G1_COMP "
_qry += "from "+RetSqlName("SG1")+" SG1 WITH (NOLOCK) "
_qry += "INNER JOIN "+RetSqlName("SB1")+" SB1X WITH (NOLOCK) ON SB1X.D_E_L_E_T_ = '' AND SG1.G1_COD = SB1X.B1_COD AND SB1X.B1_YSITUAC in ("+cStatus+") "
_qry += "INNER JOIN "+RetSqlName("SB1")+" SB1W WITH (NOLOCK) ON SB1W.D_E_L_E_T_ = '' AND SG1.G1_COMP = SB1W.B1_COD "
_qry += "where SG1.D_E_L_E_T_ = '' and LEFT(G1_COD,8) "+_xcod+" and SB1W.B1_TIPO in ('PI','MI') )) as w "
_qry += "left join "+RetSqlName("DA1")+" DA1 WITH (NOLOCK) on DA1.D_E_L_E_T_ = '' and DA1_CODTAB = '"+cTabela+"' and DA1_CODPRO = G1_COMP) as t "
_qry += "group by Left(G1_COMP,8), Preco2 order by left(G1_COMP,8) "

cQuery := ChangeQuery(_qry)

If Select("TMPPRC") > 0 
   	 TMPPRC->(DbCloseArea()) 
EndIf 

dbUseArea(.T.,"TOPCONN",TcGenQry(,,_qry),"TMPPRC",.T.,.T.)

cdescTab		:= POSICIONE("DA0",1,xFilial("DA0")+cTabela,"DA0_DESCRI")

DbSelectArea("TMPPRC")
DbGoTop()
While !EOF()

	_i := ASCAN( OMSPreco:ACOLS, {|x| SubStr(x[1],1,8) == SubStr(TMPPRC->PRODUTO,1,8)})
	_prc := 0

	If _i > 0
		IF _tp <> 1
			OMSPreco:ACols[_i,5]	:= pegprg1(ccodigo,OMSPreco:ACOLS[_i,1],1,_tp,Dtos(Date()),Dtos(Date()))
			OMSPreco:ACols[_i,6] := Posicione("DA1",1,xfilial("DA1")+cTabela+OMSPreco:aCols[_i,1],"DA1_PRCVEN")
			OMSPreco:ACols[_i,7] := Posicione("DA1",1,xfilial("DA1")+cTabela+OMSPreco:aCols[_i,1],"DA1_PRCVEN")*OMSPreco:aCols[_i,4]
			OMSPreco:ACols[_i,8] := OMSPreco:ACols[_i,5]*OMSPreco:aCols[_i,4]
		Else
			_prc := TMPPRC->PRECO
			//OMSPreco:ACols[_i,5] := 0
			OMSPreco:ACols[_i,6] := _prc
			OMSPreco:ACols[_i,7] := _prc*OMSPreco:aCols[_i,4]
			OMSPreco:ACols[_i,8] := OMSPreco:aCols[_i,5]*OMSPreco:aCols[_i,4]
		Endif

		DbSelectArea("SB1")
		DbSetOrder(1)
		DbSeek(xfilial("SB1")+OMSPreco:aCols[_i,1])
		
		If SB1->B1_TIPO == "MO" .or. SB1->B1_TIPO == "BN"
			_vrmo += OMSPreco:ACols[_i,7]
		Else
			_vrmp += OMSPreco:ACols[_i,7]
		Endif 
		If SB1->B1_TIPO == "MO" .or. SB1->B1_TIPO == "BN"
			_vrmoa+= OMSPreco:ACols[_i,4]*OMSPreco:ACols[_i,5]
		Else
			_vrmpa+= OMSPreco:ACols[_i,4]*OMSPreco:ACols[_i,5]
		Endif 
	Endif 

	DbSelectArea("TMPPRC")
	DbSkip()
End


DbSelectArea("TMPPRC")
DbCloseArea()

oMSPreco:Refresh()

cVrMO := _vrmo		//oDlg:cVrMO := str(_vrmo)
cVrMP := _vrmp		//oDlg:cVrMP := str(_vrmp)
cVrMOA:= _vrmoa		//oDlg:cVrMO := str(_vrmo)
cVrMPA:= _vrmpa		//oDlg:cVrMP := str(_vrmp)
cCusto := (_vrmo*(najuste/100))+(_vrmP*(najuste/100))		//oDlg:cVrMO := str(_vrmo)
cCusA  := (_vrmoa*(najuste/100))+(_vrmPa*(najuste/100)) 
cVrGeral:= _vrmo+_vrmp+cCusto
cVrGerAnt:= cVrMOA+cVrMPA+cCusA


//cVrMO := _vrmo*(1+(najuste/100))		//oDlg:cVrMO := str(_vrmo)
//cVrMP := _vrmp*(1+(najuste/100))		//oDlg:cVrMP := str(_vrmp)
//cVrMOA:= _vrmoa		//oDlg:cVrMO := str(_vrmo)
//cVrMPA:= _vrmpa		//oDlg:cVrMP := str(_vrmp)
//cVrGeral:= cVrMO+cVrMP
oDlg1:refresh()



Return


Static Function SavePrc(_tp)
// Salva formaÁ„o de preÁo cadastrada

Local I

If Alltrim(cTabela)<>"" .and. (cDtDe <= Date() .and. cDtDe <> ctod("  /  /    ")) 
	_custd := MsgYesNo("Atualiza Custo Standard? ","Atualiza Custo Standard")
	_custo := 0
	If _tp == 1
		For i := 1 to Len(OMSPreco:ACOLS)
			If OMSPreco:ACOLS[i,len(OMSPreco:AHEADER)+1] == .F.
				_custo += OMSPreco:ACOLS[i,4] * OMSPreco:ACOLS[i,6]
				DbSelectArea("SZI")
				DbSetOrder(1)
				DbSeek(xfilial("SZI")+cCodigo+DTOS(cDtDe)+PADR(cTipo,10)+cTabela+OMSPreco:ACOLS[i,1])
	
				If !Found()
					RecLock("SZI",.T.)
						Replace ZI_FILIAL			with xfilial("SZE")
						Replace ZI_PRODUTO		with cCodigo
						Replace ZI_DTDE			with cDtDe
						Replace ZI_TIPO			with cTipo
						Replace ZI_TABELA			with cTabela
						Replace ZI_COMP			with OMSPreco:ACOLS[i,1]
						Replace ZI_QTD			with OMSPreco:ACOLS[i,4]								
						Replace ZI_CANT			with OMSPreco:ACOLS[i,5]
						Replace ZI_CATU			with OMSPreco:ACOLS[i,6]
					MsUnLock()
				Else
					RecLock("SZI",.F.)
						Replace ZI_TIPO			with cTipo
						Replace ZI_QTD			with OMSPreco:ACOLS[i,4]								
						Replace ZI_CANT			with OMSPreco:ACOLS[i,5]
						Replace ZI_CATU			with OMSPreco:ACOLS[i,6]
					MsUnLock()
				Endif
			Endif
		Next
	ElseIf _tp == 2
		For i := 1 to Len(OMSPreco:ACOLS)
			If OMSPreco:ACOLS[i,len(OMSPreco:AHEADER)+1] == .F.
				_custo += OMSPreco:ACOLS[i,4] * OMSPreco:ACOLS[i,6]
				DbSelectArea("SZI")
				DbSetOrder(1)
				DbSeek(xfilial("SZI")+cCodigo+DTOS(cDtDe)+PADR(cTipo,10)+cTabela+OMSPreco:ACOLS[i,1])
	
				If !Found()
					RecLock("SZI",.T.)
						Replace ZI_FILIAL			with xfilial("SZE")
						Replace ZI_PRODUTO		with cCodigo
						Replace ZI_DTDE			with cDtDe
						Replace ZI_TIPO			with ctipo
						Replace ZI_TABELA			with cTabela
						Replace ZI_COMP			with OMSPreco:ACOLS[i,1]
						Replace ZI_QTD				with OMSPreco:ACOLS[i,4]								
						Replace ZI_CANT			with OMSPreco:ACOLS[i,5]
						Replace ZI_CATU			with OMSPreco:ACOLS[i,6]
					MsUnLock()
				Else
					RecLock("SZI",.F.)
						Replace ZI_TIPO			with cTipo
						Replace ZI_QTD			with OMSPreco:ACOLS[i,4]								
						Replace ZI_CANT			with OMSPreco:ACOLS[i,5]
						Replace ZI_CATU			with OMSPreco:ACOLS[i,6]
					MsUnLock()
				Endif
			Endif
		Next
	Endif
	/*
	If _custd
		DbSelectArea("SB1")
		DbSetOrder(1)
		DbSeek(xfilial("SB1")+alltrim(cCodigo))
		
		While !EOF() .and. SubStr(SB1->B1_COD,1,8) == SubStr(cCodigo,1,8)
			RecLock("SB1",.f.)
				Replace B1_CUSTD 	with _custo
			MsUnLock()
			DbSelectArea("SB1")
			DbSkip()
		End	
	Endif
	*/
Else
	If Alltrim(cTabela)==""
		Alert("Favor incluir o codigo da tabela a ser utilizada!")
		return(oDlg1)
	End	
	If 	cDtDe > Date() .or. cDtDe == ctod("  /  /    ") 
		Alert("Data De deve ser inferior a "+ dtoc(Date()) +" !")
		return(oDlg1)
	End	
Endif

Return

User Function EstPro1(_tp)                        
// Cadastro de estrutura de produtos - Controle de vers„o

Local oCancela
Local oCodProd
Local oDescProd
Local cDescProd := SB4->B4_DESC
Local oOk
Local oCopiaMSM
Local oCopiaDIF
Local oSay1
Private cCodProd     := SB4->B4_COD
Private oMSRevisao       
Private aHeaderEx    := {}
Private aColsEx      := {}
Private aFieldFill   := {}
//Local aFields := {"G5_REVISAO","G5_OBS"}
//Local aAlterFields := {"G5_REVISAO","G5_OBS"}
//substituidas 2 linhas acima pelas abaixo [Mauro Nagata, Actual Trend, 20170627]
Private aFields      := {"G5_REVISAO","G5_OBS","G5_STATUS","G5_DATAREV","G5_NUSER"}
Private aAlterFields := {"G5_REVISAO","G5_OBS","G5_STATUS","G5_NUSER"}
Static oDlg

Public cColuna		:= Space(03)
Public cColunx		:= Space(03)	
Public cCor			:= Space(500)
              
cColuna := SB4->B4_COLUNA

DEFINE MSDIALOG oDlg TITLE "Controle de Vers„o" FROM 000, 000  TO 300, 800 COLORS 0, 16777215 PIXEL

//fMSRevisao()
@ 011, 007 SAY oSay1 		PROMPT "Produto" 	SIZE 025, 007 						OF oDlg COLORS 0, 16777215 		 PIXEL
@ 010, 042 MSGET oCodProd 	VAR cCodProd 		SIZE 066, 010 						OF oDlg COLORS 0, 16777215 READONLY PIXEL
@ 010, 113 MSGET oDescProd 	VAR cDescProd 		SIZE 278, 010 						OF oDlg COLORS 0, 16777215 		 PIXEL
@ 124, 332 BUTTON oOk 		PROMPT "Seleciona" 	SIZE 037, 012 ACTION (Salva(),Seleciona(_tp, OMSRevisao:ACOLS[OMSRevisao:nat,1])) OF oDlg PIXEL
@ 124, 007 BUTTON oCopiaMSM PROMPT "Copia Revisao" SIZE 037, 012 ACTION (Salva(),COPMSMPRD(OMSRevisao:ACOLS[OMSRevisao:nat,1])) OF oDlg PIXEL
@ 124, 052 BUTTON oCopiaDIF PROMPT "Copia Produto" SIZE 037, 012 ACTION (Salva(),COPPRDDIF(OMSRevisao:ACOLS[OMSRevisao:nat,1])) OF oDlg PIXEL
@ 124, 289 BUTTON oCancela 	PROMPT "Cancela" 	SIZE 037, 012 ACTION oDlg:End() 		OF oDlg 	PIXEL
@ 124, 246 BUTTON oInclui 	PROMPT "Salva" 	SIZE 037, 012 ACTION Salva() 			OF oDlg 	PIXEL
//inclida linha abaixo [Mauro Nagata, Actual Trend, 20170711]
//@ 124, 190 BUTTON oDisplay 	PROMPT "Imagem Revis„o" SIZE 048, 012 ACTION RotImg("SG5") 		OF oDlg 	PIXEL
fMSRevisao()

ACTIVATE MSDIALOG oDlg CENTERED

Return                           

Static Function COPMSMPRD(_Rev)

DbSelectArea("SZE")
DbSetOrder(1)
If !DbSeek(xfilial("SZE")+PadR(cCodProd,15)+_Rev)
	If Pergunte("COPESTRU1",.T.)
		If MsgYesNo("Confirma cÛpia da revis„o "+mv_par01+" para a revis„o "+_Rev+"?","ConfirmaÁ„o")
			Processa( {|| U_COPESTRU(AllTrim(cCodProd),AllTrim(cCodProd),mv_par01,_Rev) }, "Aguarde...", "Copiando estrutura...",.F.)
			
			MsgInfo("CÛpia concluÌda!","Aviso")
		EndIf
	EndIf
Else
	MsgAlert("Revis„o "+_Rev+" j· possui estrutura cadastrada. N„o È possÌvel efetuar uma cÛpia de outra revis„o.","AtenÁ„o")
EndIf

Return

Static Function COPPRDDIF(_Rev)

DbSelectArea("SZE")
DbSetOrder(1)
If !DbSeek(xfilial("SZE")+PadR(cCodProd,15)+_Rev)
	If Pergunte("COPESTRU2",.T.)
		If MsgYesNo("Confirma cÛpia da revis„o "+mv_par02+" do produto "+mv_par01+" para a revis„o "+_Rev+" do produto "+AllTrim(cCodProd)+"?","ConfirmaÁ„o")
			Processa( {|| U_COPESTRU(AllTrim(mv_par01),AllTrim(cCodProd),mv_par02,_Rev) }, "Aguarde...", "Copiando estrutura...",.F.)
			
			MsgInfo("CÛpia concluÌda!","Aviso")
		EndIf
	EndIf
Else
	MsgAlert("Revis„o "+_Rev+" j· possui estrutura cadastrada. N„o È possÌvel efetuar uma cÛpia de outra revis„o.","AtenÁ„o")
EndIf

Return

Static Function RotImg()       

Local cRevisao       
Local nLinha  := oMsRevisao:nAt  
Local aImagem := {}                                  
Local nTamImg
                     
cRevisao := aColsEx[nLinha][2]   //nome revisao    
/*
DbSelectArea("SZ")                  
If DbSeek(xFilial("SZ")+cRevisao)
   Do While !Eof().and.SZ->REVISAO = cRevisao
      aAdd(aImagem,{SZ->Z_REVISAO,SZ->Z_LOCAL, SZ->Z_ARQIMG})
   	DbSkip()
   EndDo
EndIf   
nTamImg := Len(aImagem)  //quantas imagens da revisao
*/
//DisplayImg("Revisao",cRevisao,cCodProd,1)

Return
  

/*Static Function DisplayImg(pNiv1,pNiv2,pRef,pQtd)   
   
//pNiv1		Nivel 1		                          
//pNiv2		Nivel 2                             
//pRef		Referencia do Produto
//pQtd		Quantidade de Imagem
                                                             
Local nI
Local cImg
Local cDirImg
Local cImgBlq
Local cRot := pNiv1                                                                                
Local cDet := pNiv2                                                                                
Local nImgAtiva

DbSelectArea("SZ?")
DbSeek(xFilial("SZ?")+cRot+cDet+"01")
Do While !Eof().And.Z?_NIV1 = cRot.And.Z?_NIV2 = cDet
	cDirImg := Z?_DIRET	//diretorio onde se localiza a imagem
	cImg    := Z?_IMAGEM	//nome da imagem  
	cImgBlq := Z?_BLOQ	//imagem bloquada 1-Sim, 2-Nao
	If cImgBlq = 1
		aAdd(aImg,cDirImg+"\"+cImg)
   	EndIf
   
	DbSkip()
EndDo



DEFINE DIALOG oDlgDImg TITLE cRot+"-"+cDet FROM 180,180 TO 550,700 PIXEL
     
	//oTBitmap1 := TBitmap():New(01,50,390,270,,"D:\ActualTrend\imagem\LGMID01_old_20160801.PNG",.T.,oDlgDImg,;
   //										{||Alert("")},Nil,.T.,.F.,,,.F.,,.T.,,.F.) 
   
   For nI := 1 To Len(aImg)
		oTBitmap1 := TBitmap():New( 01, 50, 390, 270,, aImg[nI], .T., oDlgDImg, {||Alert("")}, {||}, .T., .F., , , .F., , .T., , .F.)     
		oTBitmap1:lAutoSize := .T.   
	Next
	
	@ 150, 60 BUTTON oOk 		PROMPT "Seleciona" 		SIZE 037, 012 ACTION Seleciona(_tp, OMSRevisao:ACOLS[OMSRevisao:nat,1]) OF oDlgDImg PIXEL
	@ 150,120 BUTTON oCancela 	PROMPT "Salvar" 			SIZE 037, 012 ACTION oDlgDImg:End() 		OF oDlgDImg 			PIXEL 
	@ 150,180 BUTTON oCancela 	PROMPT "Cancelar" 		SIZE 037, 012 ACTION oDlgDImg:End() 		OF oDlgDImg 			PIXEL
 
ACTIVATE DIALOG oDlgDImg CENTERED

Return
       */



//------------------------------------------------ 
Static Function fMSRevisao()
//------------------------------------------------ 
// Acols da Revis„o

Local nX
//Local aHeaderEx    := {}
//Local aColsEx      := {}
//Local aFieldFill   := {}
//Local aFields := {"G5_REVISAO","G5_OBS"}
//Local aAlterFields := {"G5_REVISAO","G5_OBS"}
//substituidas 2 linhas acima pelas abaixo [Mauro Nagata, Actual Trend, 20170627]
//Local aFields      := {"G5_REVISAO","G5_OBS","G5_DATAREV","G5_NUSER"}
//Local aAlterFields := {"G5_REVISAO","G5_OBS","G5_NUSER"}

//Static oMSRevisao

// Define field properties
DbSelectArea("SX3")
SX3->(DbSetOrder(2))
For nX := 1 to Len(aFields)
	If SX3->(DbSeek(aFields[nX]))
      Aadd(aHeaderEx, {AllTrim(X3Titulo()),SX3->X3_CAMPO,SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL,"",;
                       SX3->X3_USADO,SX3->X3_TIPO,SX3->X3_F3,SX3->X3_CONTEXT,SX3->X3_CBOX,SX3->X3_RELACAO})
	Endif
Next nX

// Define field values
DbSelectarea("SG5")
DbSetOrder(1)
DbSeek(xfilial("SG5")+alltrim(SB4->B4_COD))
  
If Found()
	_cod := SG5->G5_PRODUTO
	Do While !EOF() .and. SG5->G5_PRODUTO == _cod
		//Aadd(aColsEx, {SG5->G5_REVISAO, SG5->G5_OBS,.f.}) 
		//substituida linha acima pela abaixo [Mauro Nagata, Actual Trend, 20170627]
		//Aadd(aColsEx, {SG5->G5_REVISAO, SG5->G5_OBS,SG5->G5_DATAREV,SG5->G5_USER,.f.})
		Aadd(aColsEx, {SG5->G5_REVISAO, SG5->G5_OBS,SG5->G5_STATUS,SG5->G5_DATAREV,SG5->G5_NUSER,.f.})

  		DbSelectArea("SG5")
  		DbSkip()
  	EndDo
Else
	//Aadd(aColsEx, {"001","REVISAO INICIAL",.F.})
	//substituida linha acima pela abaixo [Mauro Nagata, Actual Trend, 20170627] 
	//Aadd(aColsEx, {"001","DESENVOLVIMENTO",dDataBase,__cUserId,.F.}) 
	Aadd(aColsEx, {"001","DESENVOLVIMENTO","1",dDataBase,UsrRetName(__cUserId),.F.})
Endif

  oMSRevisao := MsNewGetDados():New( 028, 003, 106, 394, GD_INSERT+GD_DELETE+GD_UPDATE, "AllwaysTrue", "AllwaysTrue", "+Field1+Field2", aAlterFields,, 999, "AllwaysTrue", "", "AllwaysTrue", oDlg, aHeaderEx, aColsEx)

Return



Static Function Salva()
// Salva uma nova revis„o

Local _i 

For _i := 1 to Len(OMSRevisao:ACOLS)
	If OMSRevisao:ACOLS[_i,len(OMSRevisao:AHEADER)+1] == .F.
		DbSelectArea("SB1")
		DbSetOrder(1)
		DbSeek(xfilial("SB1")+SubStr(SB4->B4_COD,1,8))
		
		While !EOF() .and. SubStr(SB1->B1_COD,1,8) == SubStr(SB4->B4_COD,1,8)
/*
				IF OMSRevisao:ACOLS[_i,3] = "1"
					RecLock("SB1",.F.)
						Replace B1_REVATU 	with OMSRevisao:ACOLS[_i,1]
					MsUnLock()
				Endif
*/
			DbSelectArea("SG5")
			DbSetOrder(1)
			DbSeek(xfilial("SG5")+SB1->B1_COD+OMSRevisao:ACOLS[_i,1])
			
			If !Found()

				Reclock("SG5",.T.)
					G5_FILIAL		:= xfilial("SG5")
					G5_PRODUTO		:= SB1->B1_COD
					G5_REVISAO		:= OMSRevisao:ACOLS[_i,1]
					G5_OBS			:= OMSRevisao:ACOLS[_i,2]
					G5_STATUS		:= OMSRevisao:ACOLS[_i,3]
					//incluido bloco abaixo [Mauro Nagata, Actual Trend, 20170627]
					G5_DATAREV     := dDataBase
					G5_USER        := __cUserId           
					G5_NUSER       := UsrRetName(__cUserId)
					//fim bloco [Mauro Nagata, Actual Trend, 20170627]
				MsUnLock()
			Else
				RecLock("SG5",.F.)
					Replace G5_OBS			with OMSRevisao:ACOLS[_i,2]
					Replace G5_STATUS		with OMSRevisao:ACOLS[_i,3]
				MsUnLock()
			Endif
			DbSelectArea("SB1")
			DbSkip()
		End

		DbSelectArea("SB1")
		DbSetOrder(1)
		DbSeek(xfilial("SB1")+SubStr(SB4->B4_COD,1,8))
	
		While !EOF() .and. SubStr(SB1->B1_COD,1,8) == SubStr(SB4->B4_COD,1,8)

			IF OMSRevisao:ACOLS[_i,3] = "1"
				RecLock("SB1",.F.)
					Replace B1_REVATU 	with OMSRevisao:ACOLS[_i,1]
				MsUnLock()
			Endif
			DbSelectArea("SB1")
			DbSkip()
		End

		DbSelectArea("SB1")
		DbSetOrder(1)
		DbSeek(xfilial("SB1")+SubStr(SB4->B4_COD,1,6)+"P1")
	
		While !EOF() .and. SubStr(SB1->B1_COD,1,8) == SubStr(SB4->B4_COD,1,6)+"P1"

			IF OMSRevisao:ACOLS[_i,3] = "1"
				RecLock("SB1",.F.)
					Replace B1_REVATU 	with OMSRevisao:ACOLS[_i,1]
				MsUnLock()
			Endif
			DbSelectArea("SB1")
			DbSkip()
		End

//		DbSelectArea("SB1")
//		DbSetOrder(1)
//		DbSeek(xfilial("SB1")+SubStr(SB4->B4_COD,1,6)+"P2")
	
//		While !EOF() .and. SubStr(SB1->B1_COD,1,8) == SubStr(SB4->B4_COD,1,6)+"P2"
//			IF OMSRevisao:ACOLS[_i,3] = "1"
//				RecLock("SB1",.F.)
//					Replace B1_REVATU 	with OMSRevisao:ACOLS[_i,1]
//				MsUnLock()
//			Endif
//			DbSelectArea("SB1")
//			DbSkip()
//		End

	Endif

Next
Return()

Static Function Seleciona(_tp, _Rev)                        
// Seleciona a revis„o e abre a tela para cadastro de estrutura

Local _w
Local aArea := GetArea()
Local oButton1
Local oCancela
Local oDescProd
Local cDescProd := SB4->B4_DESC
Local oProduto
Local oRevisao
Local oSay1
Local oSay2
Private cProduto := cCodProd
Private cRevisao := _Rev
Private _fecha := .T.
Static oEst

DbSelectArea("SB4")
DbSetOrder(1)
DbSeek(xfilial("SB4")+cProduto)
cDescProd := SB4->B4_DESC
cColuna := SB4->B4_COLUNA

	DbSelectArea("SZE")
	DbSetOrder(1)
	DbSeek(xfilial("SZE")+substr(cProduto,1,15)+cRevisao)
	If Found()
		_qry := "delete "+RetSqlName("ZB0")+" where ZB0_PRODUT = '"+SUBSTR(cProduto,1,8)+"' and ZB0_REVISA = '"+cRevisao+"' "
		nStatus := TcSqlExec(_qry)
		if (nStatus < 0)
			MsgBox(TCSQLError(), "Erro no comando", "Stop") 
		endif
		_qry := "delete "+RetSqlName("ZB1")+" where ZB1_PRODUT = '"+SUBSTR(cProduto,1,8)+"' and ZB1_REVISA = '"+cRevisao+"' " 
		nStatus := TcSqlExec(_qry)
		if (nStatus < 0)
			MsgBox(TCSQLError(), "Erro no comando", "Stop") 
		endif
		_qry := "delete "+RetSqlName("ZB2")+" where ZB2_PRODUT = '"+SUBSTR(cProduto,1,8)+"' and ZB2_REVISA = '"+cRevisao+"' "
		nStatus := TcSqlExec(_qry)
		if (nStatus < 0)
			MsgBox(TCSQLError(), "Erro no comando", "Stop") 
		endif
		_qry := "delete "+RetSqlName("ZB3")+" where ZB3_PRODUT = '"+SUBSTR(cProduto,1,8)+"' and ZB3_REVISA = '"+cRevisao+"' "
		nStatus := TcSqlExec(_qry)
		if (nStatus < 0)
			MsgBox(TCSQLError(), "Erro no comando", "Stop") 
		endif
		DbSelectArea("SZE")
		DbSetOrder(1)
		DbGoTop()
		DbSeek(xfilial("SZE")+substr(cProduto,1,8)+Space(7)+cRevisao)
//melhorar		
		While !EOF() .and. SubStr(SZE->ZE_PRODUTO,1,8) = substr(cProduto,1,8) .and. SZE->ZE_REVISAO = cRevisao
			RecLock("ZB0",.t.)
				Replace ZB0_FILIAL	with SZE->ZE_FILIAL
				Replace ZB0_PRODUT	with SZE->ZE_PRODUTO
				Replace ZB0_DESCPR	with SZE->ZE_DESCPRO
				Replace ZB0_COMP	with SZE->ZE_COMP
				Replace ZB0_DESCCO	with SZE->ZE_DESCCOM
				Replace ZB0_UM		with SZE->ZE_UM
				Replace ZB0_CORTE	with SZE->ZE_CORTE 
				//Replace ZB0_IMP		with SZE->ZE_IMP
				Replace ZB0_REVISA	with SZE->ZE_REVISAO
				Replace ZB0_INDICE	with SZE->ZE_INDICE
			MsUnLock()
			
			DbSelectArea("SZE")
			DbSkip()
		End
		
		DbSelectArea("SZF")
		DbSetOrder(1)
		DbGoTop()
		DbSeek(xfilial("SZF")+substr(cProduto,1,8)+space(7)+cRevisao)
//melhorar		
		While !EOF() .and. SubStr(SZF->ZF_PRODUTO,1,8) = substr(cProduto,1,8) .and. SZF->ZF_REVISAO = cRevisao
			RecLock("ZB1",.t.)
				Replace ZB1_FILIAL	with SZF->ZF_FILIAL
				Replace ZB1_PRODUT	with SZF->ZF_PRODUTO
				Replace ZB1_COMP	with SZF->ZF_COMP
				Replace ZB1_REVISA	with SZF->ZF_REVISAO
				Replace ZB1_INDICE	with SZF->ZF_INDICE
				Replace ZB1_COR		with SZF->ZF_COR
				For _w := 1 to 200
					_campo1 := "ZB1_TAM"+StrZero(_w,3)
					_campo2 := "SZF->ZF_TAM"+StrZero(_w,3)
					Replace &(_campo1) with &(_campo2)
				Next
			MsUnLock()
			
			DbSelectArea("SZF")
			DbSkip()
		End

		DbSelectArea("SZG")
		DbSetOrder(1)
		DbGoTop()
		DbSeek(xfilial("SZG")+substr(cProduto,1,8)+Space(7)+cRevisao)
	//melhorar	
		While !EOF() .and. SubStr(SZG->ZG_PRODUTO,1,8) = substr(cProduto,1,8) .and. SZG->ZG_REVISAO = cRevisao
			RecLock("ZB2",.t.)
				Replace ZB2_FILIAL	with SZG->ZG_FILIAL
				Replace ZB2_PRODUT	with SZG->ZG_PRODUTO
				Replace ZB2_COMP	with SZG->ZG_COMP
				Replace ZB2_REVISA	with SZG->ZG_REVISAO
				Replace ZB2_INDICE	with SZG->ZG_INDICE
				Replace ZB2_COR		with SZG->ZG_COR
				Replace ZB2_CORNV	with SZG->ZG_CORNV 
				Replace ZB2_LOCALI	with SZG->ZG_LOCALIZ
			MsUnLock()
			
			DbSelectArea("SZG")
			DbSkip()
		End

		DbSelectArea("SZK")
		DbSetOrder(1)
		DbGoTop()
		DbSeek(xfilial("SZK")+substr(cProduto,1,8)+space(7)+cRevisao)
//melhorar		
		While !EOF() .and. substr(SZK->ZK_PRODUTO,1,8) = substr(cProduto,1,8) .and. SZK->ZK_REVISAO = cRevisao
			RecLock("ZB3",.t.)
				Replace ZB3_FILIAL	with SZK->ZK_FILIAL
				Replace ZB3_PRODUT	with SZK->ZK_PRODUTO
				Replace ZB3_COMP	with SZK->ZK_COMP
				Replace ZB3_REVISA	with SZK->ZK_REVISAO
				Replace ZB3_INDICE	with SZK->ZK_INDICE
				Replace ZB3_TAM		with SZK->ZK_TAM
				Replace ZB3_TAMNV	with SZK->ZK_TAMNV
			MsUnLock()
			
			DbSelectArea("SZK")
			DbSkip()
		End
  		//MsgBox(_erro,"Erro no comando",  "Stop") 
    Endif
_salva := 0          
//checacor()

		//	DEFINE MSDIALOG oEst TITLE "Estrutura de Produtos" FROM 000, 000  TO 600, 1300 COLORS 0, 16777215 PIXEL
		DEFINE MsDialog oEst From 000,000 To 600,1300 Title "Estrutura de Produtos" Pixel Style DS_MODALFRAME // Cria Dialog sem o bot„o de Fechar.

    @ 007, 012 SAY oSay1 PROMPT "Produto" SIZE 025, 007 OF oEst COLORS 0, 16777215 PIXEL
    @ 005, 045 MSGET oProduto VAR cProduto SIZE 060, 010 OF oEst COLORS 0, 16777215 READONLY PIXEL
    @ 005, 112 MSGET oDescProd VAR cDescProd SIZE 345, 010 OF oEst COLORS 0, 16777215 READONLY PIXEL
    @ 007, 467 SAY oSay2 PROMPT "Revis„o" SIZE 025, 007 OF oEst COLORS 0, 16777215 PIXEL
    @ 005, 495 MSGET oRevisao VAR cRevisao SIZE 029, 010 OF oEst COLORS 0, 16777215 READONLY PIXEL
    fMSProduto(_tp)
    fMSCor()
    fMSQtd()
    fMSTam()
    @ 280, 530 BUTTON oButton1 PROMPT "Ok" 					SIZE 050, 012 ACTION (EstSav(),Iif(_fecha,(oEst:End(),oDlg:End()),Alert("Cores ou Tamanhos n„o cadastrados!"))) OF oEst PIXEL
	@ 280, 590 BUTTON oCancela PROMPT "Cancela" 			SIZE 050, 012 ACTION (Iif(RESBKP(),(oEst:End(),oDlg:End()),Alert("Erro na restauraÁ„o do backup da estrutura. Tente novamente!"))) OF oEst PIXEL
	@ 280, 210 BUTTON oButton7 PROMPT "Limpa Cor"			SIZE 050, 012 ACTION LimpaCor() OF oEst PIXEL
    @ 280, 270 BUTTON oButton3 PROMPT "Repl.Cor"			SIZE 050, 012 ACTION ReplyCor() OF oEst PIXEL
    @ 280, 330 BUTTON oButton4 PROMPT "Repl.Tam"			SIZE 050, 012 ACTION ReplyTam() OF oEst PIXEL    
    @ 280, 390 BUTTON oButton5 PROMPT "Repl.Qtd x Grade"	SIZE 050, 012 ACTION ReplyQtdLn() OF oEst PIXEL     
    @ 280, 450 BUTTON oButton6 PROMPT "Repl.Qtd x Linha"	SIZE 050, 012 ACTION ReplyQtdCl() OF oEst PIXEL         

  	ACTIVATE MSDIALOG oEst CENTERED
  	
RestArea(aArea)

Return

STATIC FUNCTION RESBKP

Local  _w
  		_qry := "UPDATE "+RetSqlName("SZE")+" SET D_E_L_E_T_ = '*' where ZE_PRODUTO = '"+SUBSTR(cProduto,1,8)+"' and ZE_REVISAO = '"+cRevisao+"' "
		nStatus := TcSqlExec(_qry)
	
		if (nStatus < 0)
			MsgBox(TCSQLError(), "Erro no comando", "Stop") 
		endif
  		_qry := "UPDATE "+RetSqlName("SZF")+" SET D_E_L_E_T_ = '*' where ZF_PRODUTO = '"+SUBSTR(cProduto,1,8)+"' and ZF_REVISAO = '"+cRevisao+"' "
		nStatus := TcSqlExec(_qry)
	
		if (nStatus < 0)
			MsgBox(TCSQLError(), "Erro no comando", "Stop") 
		endif
  		_qry := "UPDATE "+RetSqlName("SZG")+" SET D_E_L_E_T_ = '*' where ZG_PRODUTO = '"+SUBSTR(cProduto,1,8)+"' and ZG_REVISAO = '"+cRevisao+"' "
		nStatus := TcSqlExec(_qry)
	
		if (nStatus < 0)
			MsgBox(TCSQLError(), "Erro no comando", "Stop") 
		endif
  		_qry := "UPDATE "+RetSqlName("SZK")+" SET D_E_L_E_T_ = '*' where ZK_PRODUTO = '"+SUBSTR(cProduto,1,8)+"' and ZK_REVISAO = '"+cRevisao+"' "
		nStatus := TcSqlExec(_qry)
	
		if (nStatus < 0)
			MsgBox(TCSQLError(), "Erro no comando", "Stop") 
		endif
  
		DbSelectArea("ZB0")
		DbSetOrder(1)
		DbSeek(xfilial("ZB0")+substr(cProduto,1,15)+cRevisao)
		
		While !EOF() .and. ZB0->ZB0_PRODUT = substr(cProduto,1,15) .and. ZB0->ZB0_REVISA = cRevisao
			RecLock("SZE",.t.)
				Replace ZE_FILIAL	with ZB0->ZB0_FILIAL
				Replace ZE_PRODUTO	with ZB0->ZB0_PRODUT
				Replace ZE_DESCPRO	with ZB0->ZB0_DESCPR
				Replace ZE_COMP		with ZB0->ZB0_COMP
				Replace ZE_DESCCOM	with ZB0->ZB0_DESCCO
				Replace ZE_UM		with ZB0->ZB0_UM
//				Replace ZE_IMP		with ZB0->ZB0_IMP
				Replace ZE_CORTE	with ZB0->ZB0_CORTE
				Replace ZE_REVISAO	with ZB0->ZB0_REVISA
				Replace ZE_INDICE	with ZB0->ZB0_INDICE
			MsUnLock()
			
			DbSelectArea("ZB0")
			DbSkip()
		End
		
		DbSelectArea("ZB1")
		DbSetOrder(1)
		DbSeek(xfilial("ZB1")+substr(cProduto,1,15)+cRevisao)
		
		While !EOF() .and. ZB1->ZB1_PRODUT = substr(cProduto,1,15) .and. ZB1->ZB1_REVISA = cRevisao
			RecLock("SZF",.t.)
				Replace ZF_FILIAL	with ZB1->ZB1_FILIAL
				Replace ZF_PRODUTO	with ZB1->ZB1_PRODUT
				Replace ZF_COMP		with ZB1->ZB1_COMP
				Replace ZF_REVISAO	with ZB1->ZB1_REVISA
				Replace ZF_INDICE	with ZB1->ZB1_INDICE
				Replace ZF_COR		with ZB1->ZB1_COR
				For _w := 1 to 200
					_campo1 := "ZF_TAM"+StrZero(_w,3)
					_campo2 := "ZB1->ZB1_TAM"+StrZero(_w,3)
					Replace &(_campo1) with &(_campo2)
				Next
			MsUnLock()
			
			DbSelectArea("ZB1")
			DbSkip()
		End

		DbSelectArea("ZB2")
		DbSetOrder(1)
		DbSeek(xfilial("ZB2")+substr(cProduto,1,15)+cRevisao)
		
		While !EOF() .and. ZB2->ZB2_PRODUT = substr(cProduto,1,15) .and. ZB2->ZB2_REVISA = cRevisao
			RecLock("SZG",.t.)
				Replace ZG_FILIAL	with ZB2->ZB2_FILIAL
				Replace ZG_PRODUTO	with ZB2->ZB2_PRODUT
				Replace ZG_COMP		with ZB2->ZB2_COMP
				Replace ZG_REVISAO	with ZB2->ZB2_REVISA
				Replace ZG_INDICE	with ZB2->ZB2_INDICE
				Replace ZG_COR		with ZB2->ZB2_COR
				Replace ZG_CORNV	with ZB2->ZB2_CORNV 
				Replace ZG_LOCALIZ	with ZB2->ZB2_LOCALI
			MsUnLock()
			
			DbSelectArea("ZB2")
			DbSkip()
		End

		DbSelectArea("ZB3")
		DbSetOrder(1)
		DbSeek(xfilial("ZB3")+substr(cProduto,1,15)+cRevisao)
		
		While !EOF() .and. ZB3->ZB3_PRODUT = substr(cProduto,1,15) .and. ZB3->ZB3_REVISA = cRevisao
			RecLock("SZK",.t.)
				Replace ZK_FILIAL	with ZB3->ZB3_FILIAL
				Replace ZK_PRODUTO	with ZB3->ZB3_PRODUT
				Replace ZK_COMP		with ZB3->ZB3_COMP
				Replace ZK_REVISAO	with ZB3->ZB3_REVISA
				Replace ZK_INDICE	with ZB3->ZB3_INDICE
				Replace ZK_TAM		with ZB3->ZB3_TAM
				Replace ZK_TAMNV	with ZB3->ZB3_TAMNV
			MsUnLock()
			
			DbSelectArea("ZB3")
			DbSkip()
		End
//  	Else
  		lret1 := .T.
//  	endif
RETURN(lret1)

//------------------------------------------------ 
Static Function fMSProduto(_tp)
//------------------------------------------------ 
// Acols para componentes das estruturas
// Tabela: SZE

Local nX
Local aHeaderEx := {}
Local aColsEx := {}
Local aFieldFill := {}
Local aFields := {"ZE_COMP","ZE_DESCCOM","ZE_UM","ZE_IMP","ZE_CORTE","ZE_INDICE"}
Local aAlterFields := {"ZE_COMP","ZE_IMP","ZE_CORTE"}
Public oMSNewGe1

  // Define field properties
  DbSelectArea("SX3")
  SX3->(DbSetOrder(2))
  If SX3->(DbSeek("ZE_COMP"))
    Aadd(aHeaderEx, {AllTrim(X3Titulo()),SX3->X3_CAMPO,SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL,"ExistCpo('SB4')",;
                          SX3->X3_USADO,SX3->X3_TIPO,SX3->X3_F3,SX3->X3_CONTEXT,SX3->X3_CBOX,SX3->X3_RELACAO})
  Endif
  If SX3->(DbSeek("ZE_DESCCOM"))
    Aadd(aHeaderEx, {AllTrim(X3Titulo()),SX3->X3_CAMPO,SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL,SX3->X3_VALID,;
                          SX3->X3_USADO,SX3->X3_TIPO,SX3->X3_F3,SX3->X3_CONTEXT,SX3->X3_CBOX,SX3->X3_RELACAO})
  Endif
  If SX3->(DbSeek("ZE_UM"))
    Aadd(aHeaderEx, {AllTrim(X3Titulo()),SX3->X3_CAMPO,SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL,SX3->X3_VALID,;
                          SX3->X3_USADO,SX3->X3_TIPO,SX3->X3_F3,SX3->X3_CONTEXT,SX3->X3_CBOX,SX3->X3_RELACAO})
  Endif
  If SX3->(DbSeek("ZE_IMP"))
    Aadd(aHeaderEx, {AllTrim(X3Titulo()),SX3->X3_CAMPO,SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL,SX3->X3_VALID,;
                          SX3->X3_USADO,SX3->X3_TIPO,SX3->X3_F3,SX3->X3_CONTEXT,SX3->X3_CBOX,SX3->X3_RELACAO})
  Endif
  If SX3->(DbSeek("ZE_CORTE"))
    Aadd(aHeaderEx, {AllTrim(X3Titulo()),SX3->X3_CAMPO,SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL,SX3->X3_VALID,;
                          SX3->X3_USADO,SX3->X3_TIPO,SX3->X3_F3,SX3->X3_CONTEXT,SX3->X3_CBOX,SX3->X3_RELACAO})
  Endif
  If SX3->(DbSeek("ZE_INDICE"))
    Aadd(aHeaderEx, {AllTrim(X3Titulo()),SX3->X3_CAMPO,SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL,SX3->X3_VALID,;
                          SX3->X3_USADO,SX3->X3_TIPO,SX3->X3_F3,SX3->X3_CONTEXT,SX3->X3_CBOX,SX3->X3_RELACAO})
  Endif
  
  // Define field values
  DbSelectArea("SZE")
  DbSetOrder(1)
  DbSeek(xfilial("SZE")+substr(cProduto,1,15)+cRevisao)
  	
  If Found()
  	While !EOF() .and. alltrim(SZE->ZE_PRODUTO) == alltrim(cProduto) .and. SZE->ZE_REVISAO == cRevisao
		Aadd(aColsEx, {SZE->ZE_COMP,Posicione("SB4",1,xfilial("SB4")+SZE->ZE_COMP,"B4_DESC"),Posicione("SB4",1,xfilial("SB4")+SZE->ZE_COMP,"B4_UM"),SZE->ZE_IMP,SZE->ZE_CORTE,SZE->ZE_INDICE,.F.})
  		
  		DbSelectArea("SZE")
  		DbSkip()
  	End  
  Else
  	For nX := 1 to Len(aFields)
  		DbSelectArea("SX3")
    	If DbSeek(aFields[nX])
      		Aadd(aFieldFill, CriaVar(SX3->X3_CAMPO))
    	Endif
  	Next nX
  	Aadd(aFieldFill, .F.)
  	Aadd(aColsEx, aFieldFill)
  Endif

  oMSNewGe1 := MsNewGetDados():New( 027, 006, 185, 470, GD_INSERT+GD_DELETE+GD_UPDATE, "AllwaysTrue", "AllwaysTrue", "+Field1+Field2", aAlterFields,, 999, "AllwaysTrue", "", "AllwaysTrue", oEst, aHeaderEx, aColsEx)

  // Chamada de rotina para atualizaÁ„o de demais acols quando da mudanÁa de linha no acols de componentes
  oMSNewGe1:bchange	:= {|| u_AtuAcols() }

Return

//------------------------------------------------ 
Static Function fMSCor()
//------------------------------------------------ 
// Monta acols de Cores
// Tabela: SZG

Local nX
Local aHeaderEx := {}
Local aColsEx := {}
Local aFieldFill := {}
Local aFields := {"ZG_COR","ZG_CORNV","ZG_COMP","ZG_LOCALIZ","ZG_INDICE"}
Local aAlterFields := {"ZG_CORNV","ZG_LOCALIZ"}
Static oMSCor

cCor := ""
// Define field properties
DbSelectArea("SX3")
SX3->(DbSetOrder(2))
For nX := 1 to Len(aFields)
	If aFields[nX] <> "ZG_CORNV"
    	If SX3->(DbSeek(aFields[nX]))
    		Aadd(aHeaderEx, {AllTrim(X3Titulo()),SX3->X3_CAMPO,SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL,SX3->X3_VALID,;
                          SX3->X3_USADO,SX3->X3_TIPO,SX3->X3_F3,SX3->X3_CONTEXT,SX3->X3_CBOX,SX3->X3_RELACAO})
    	Endif
    Else  
    	If SX3->(DbSeek(aFields[nX]))
    		//Aadd(aHeaderEx, {AllTrim(X3Titulo()),SX3->X3_CAMPO,SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL,"U_ExistCod(2,M->ZG_CORNV)",;
            //              SX3->X3_USADO,SX3->X3_TIPO,SX3->X3_F3,SX3->X3_CONTEXT,SX3->X3_CBOX,SX3->X3_RELACAO})
    		Aadd(aHeaderEx, {AllTrim(X3Titulo()),SX3->X3_CAMPO,SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL,SX3->X3_VALID,;
    		                      SX3->X3_USADO,SX3->X3_TIPO,SX3->X3_F3,SX3->X3_CONTEXT,SX3->X3_CBOX,SX3->X3_RELACAO})
    	Endif
    Endif
Next nX

If alltrim(oMSNewGe1:aCols[oMSNewGe1:nAT,1]) <> ""
	DbSelectArea("SZD")
	DbSetOrder(1)
	DbSeek(xfilial("SZD")+alltrim(cProduto))

	While !EOF() .and. alltrim(SZD->ZD_PRODUTO) == alltrim(cProduto)

		DbSelectArea("SZG")
		DbSetOrder(2)
		DbSeek(xfilial("SZG")+SubStr(cProduto,1,15)+cRevisao+PADR(oMSNewGe1:aCols[oMSNewGe1:nAT,1],15)+oMSNewGe1:aCols[oMSNewGe1:nAT,6]+SZD->ZD_COR)
	
		IF Found()
		
//			While !EOF() .and. alltrim(ZG_PRODUTO) == alltrim(cProduto) .and. alltrim(ZG_COMP) == alltrim(oMSNewGe1:aCols[oMSNewGe1:nAT,1]) .and. ZG_REVISAO == cRevisao
			Aadd(aColsEx, {SZG->ZG_COR,SZG->ZG_CORNV,SZG->ZG_COMP,SZG->ZG_LOCALIZ,SZG->ZG_INDICE,.F.})
//				DbSelectArea("SZG")
//				DbSkip()
//			End
		Else
			Aadd(aColsEx, {SZD->ZD_COR,SPACE(5),oMSNewGe1:aCols[oMSNewGe1:nAT,1],SPACE(50),oMSNewGe1:aCols[oMSNewGe1:nAT,6],.F.})
		Endif
/*
	Else
		DbSelectArea("SZD")
		DbSetOrder(1)
		DbSeek(xfilial("SZD")+alltrim(cProduto))

		While !EOF() .and. alltrim(SZD->ZD_PRODUTO) == alltrim(cProduto)
			Aadd(aColsEx, {SZD->ZD_COR,"   ",oMSNewGe1:aCols[oMSNewGe1:nAT,1],.F.})

			DbSelectArea("SZD")
			DbSkip()
		End

	Endif
*/
		DbSelectArea("SZD")
		DbSkip()
	End

Else
	DbSelectArea("SZD")
	DbSetOrder(1)
	DbSeek(xfilial("SZD")+alltrim(cProduto))

	While !EOF() .and. alltrim(SZD->ZD_PRODUTO) == alltrim(cProduto)
		Aadd(aColsEx, {SZD->ZD_COR,Space(5),space(15),space(50),space(3),.F.})

		DbSelectArea("SZD")
		DbSkip()
	End
Endif

  oMSCor := MsNewGetDados():New( 027, 475, 185, 645, GD_UPDATE, "AllwaysTrue", "AllwaysTrue", "+Field1+Field2", aAlterFields,, 999, "AllwaysTrue", "", "AllwaysTrue", oEst, aHeaderEx, aColsEx)

Return

//------------------------------------------------ 
Static Function fMSQtd()
//------------------------------------------------ 
// Acols para Quandidades por tamanho
// Tabela: SZF

Local nX
Local aHeaderEx := {}
Local aColsEx := {}
Local aFieldFill := {}
Local aFields := {"ZF_COR","ZF_COR","ZF_INDICE"}
Local aAlterFields := {}
Local _i
Static oMSQtd

  // Define field properties
  DbSelectArea("SX3")
  SX3->(DbSetOrder(2))
  If SX3->(DbSeek("ZF_COR"))
    Aadd(aHeaderEx, {alltrim(X3Titulo())+Space(4),"ZF_COR","@!",5,0,,SX3->X3_USADO,"C","","R","",""})
    Aadd(aHeaderEx, {"DescriÁ„o"+Space(4),"ZF_COR","@!",10,0,,SX3->X3_USADO,"C","","R","",""})
  Endif

  DbSelectArea("SZD")
  DbSetOrder(1)
  DbSeek(xfilial("SZD")+alltrim(cProduto))
  _XTAM := {}	
  While !EOF() .and. alltrim(SZD->ZD_PRODUTO) == alltrim(cProduto)
  	For _i := 1 to 200
  		_campo := "SZD->ZD_TAM"+StrZero(_i,3)
  		If &_campo == "X"
  			_tem := ASCAN( _xtam, {|x| x == _i})
  			If _tem == 0
  				aadd(_xtam,_i)
  			Endif
  		Endif
  	Next

  	DbSelectarea("SZD")
  	DbSkip()
  End

  aSort(_xtam)
  
  For _i := 1 to len(_xtam)
  	DbSelectArea("SB4")
  	DbSetOrder(1)
  	DbSeek(xfilial("SB4")+alltrim(cproduto))
  	_desc := rettam(_xtam[_i],SB4->B4_COLUNA,"D") 
	DbSelectArea("SX3")
	_campo := "ZF_TAM"+StrZero(_xtam[_i],3)
  	Aadd(aFields,_campo) 
  	Aadd(aAlterFields,_campo)

	SX3->(DbSetOrder(2))
   	If SX3->(DbSeek(_campo))
      	Aadd(aHeaderEx, {alltrim(_desc)+Space(4),SX3->X3_CAMPO,SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL,"",;
                       SX3->X3_USADO,SX3->X3_TIPO,"",SX3->X3_CONTEXT,SX3->X3_CBOX,SX3->X3_RELACAO})
	Endif 
  
  Next

  DbSelectArea("SX3")
  SX3->(DbSetOrder(2))
  If SX3->(DbSeek("ZF_COMP"))
    Aadd(aHeaderEx, {alltrim(X3Titulo())+Space(4),"ZF_COMP","@!",15,0,,SX3->X3_USADO,"C","","R","",""})
  Endif
//  Aadd(aFields,"ZF_COMP") 

  If SX3->(DbSeek("ZF_INDICE"))
    Aadd(aHeaderEx, {AllTrim(X3Titulo()),SX3->X3_CAMPO,SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL,SX3->X3_VALID,;
                          SX3->X3_USADO,SX3->X3_TIPO,SX3->X3_F3,SX3->X3_CONTEXT,SX3->X3_CBOX,SX3->X3_RELACAO})
  Endif
//  Aadd(aFields,"ZF_INDICE")

If alltrim(oMSNewGe1:aCols[oMSNewGe1:nAT,1]) <> ""

	DbSelectArea("SZF")
	DbSetOrder(2)
	DbSeek(xfilial("SZF")+SubStr(cProduto,1,15)+cRevisao+oMSNewGe1:aCols[oMSNewGe1:nAT,1]+oMSNewGe1:aCols[oMSNewGe1:nAT,6])
	
	IF Found()
		
		While !EOF() .and. alltrim(ZF_PRODUTO) == alltrim(cProduto) .and. alltrim(ZF_COMP) == alltrim(oMSNewGe1:aCols[oMSNewGe1:nAT,1]) .and. ZF_REVISAO == cRevisao .AND. ZF_INDICE = oMSNewGe1:aCols[oMSNewGe1:nAT,6]
			aFieldFill := {}
  			Aadd(aFieldFill, SZF->ZF_COR)
			Aadd(aFieldFill,POSICIONE("SBV",1,xFilial("SBV")+'COR'+SZF->ZF_COR,"BV_DESCRI")) 
			For nX := 3 to Len(aHeaderEx)-2
				_campo := "SZF->"+aheaderEx[nX][2]//ZF_TAM"+StrZero(nX,3)
	  			Aadd(aFieldFill,&_campo)
  			Next
  			Aadd(aFieldFill, SZF->ZF_COMP)
  			Aadd(aFieldFill, SZF->ZF_INDICE)
  			Aadd(aFieldFill, .F.)
  			Aadd(aColsEx, aFieldFill)
	
			DbSelectArea("SZF")
			DbSkip()
		End
	Else
		DbSelectArea("SZD")
		DbSetOrder(1)
		DbSeek(xfilial("SZD")+alltrim(cProduto))

		While !EOF() .and. alltrim(SZD->ZD_PRODUTO) == alltrim(cProduto)
			aFieldFill := {}
  			Aadd(aFieldFill, SZD->ZD_COR)
			Aadd(aFieldFill,POSICIONE("SBV",1,xFilial("SBV")+'COR'+SZD->ZD_COR,"BV_DESCRI")) 

			For nX := 3 to Len(aHeaderEx)-2
	  			Aadd(aFieldFill,0)
  			Next
  			Aadd(aFieldFill, oMSNewGe1:aCols[oMSNewGe1:nAT,1])
  			Aadd(aFieldFill, oMSNewGe1:aCols[oMSNewGe1:nAT,6])
  			Aadd(aFieldFill, .F.)
  			Aadd(aColsEx, aFieldFill)

			DbSelectArea("SZD")
			DbSkip()
		End
	Endif
Else
	DbSelectArea("SZD")
	DbSetOrder(1)
	DbSeek(xfilial("SZD")+alltrim(cProduto))

	While !EOF() .and. alltrim(SZD->ZD_PRODUTO) == alltrim(cProduto)
		aFieldFill := {}
		Aadd(aFieldFill, SZD->ZD_COR)
		Aadd(aFieldFill,POSICIONE("SBV",1,xFilial("SBV")+'COR'+SZD->ZD_COR,"BV_DESCRI")) 

		For nX := 3 to Len(aHeaderEx)-2
  			Aadd(aFieldFill,0)
		Next
		Aadd(aFieldFill, oMSNewGe1:aCols[oMSNewGe1:nAT,1])
		Aadd(aFieldFill, oMSNewGe1:aCols[oMSNewGe1:nAT,2])
		Aadd(aFieldFill, .F.)
		Aadd(aColsEx, aFieldFill)

		DbSelectArea("SZD")
		DbSkip()
	End
Endif

  oMSQtd := MsNewGetDados():New( 190, 006, 275, 500, GD_UPDATE, "AllwaysTrue", "AllwaysTrue", "+Field1+Field2", aAlterFields,, 999, "AllwaysTrue", "", "AllwaysTrue", oEst, aHeaderEx, aColsEx)

Return

//------------------------------------------------ 
Static Function fMSTam()
//------------------------------------------------ 
// Acols para Tamanho dos componentes 
// Tabela: SZK

Local nX
Local aHeaderEx := {}
Local aColsEx := {}
Local aFieldFill := {}
Local aFields := {"ZK_TAM","ZK_TAMNV","ZK_COMP","ZK_INDICE"}
Local aAlterFields := {"ZK_TAMNV"}
Static oMSTAM

  // Define field properties
  DbSelectArea("SX3")
  SX3->(DbSetOrder(2))
  For nX := 1 to Len(aFields)
    If aFields[nX] <> "ZK_TAMNV"
	    If SX3->(DbSeek(aFields[nX]))
	    Aadd(aHeaderEx, {AllTrim(X3Titulo()),SX3->X3_CAMPO,SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL,,SX3->X3_VALID,;
	                          SX3->X3_USADO,SX3->X3_TIPO,SX3->X3_F3,SX3->X3_CONTEXT,SX3->X3_CBOX,SX3->X3_RELACAO})
	    Endif
    Else  
	    If SX3->(DbSeek(aFields[nX]))
        //Aadd(aHeaderEx, {AllTrim(X3Titulo()),SX3->X3_CAMPO,SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL,,"U_ExistCod(3,M->ZK_TAMNV)",;
        //                      SX3->X3_USADO,SX3->X3_TIPO,SX3->X3_F3,SX3->X3_CONTEXT,SX3->X3_CBOX,SX3->X3_RELACAO})
        Aadd(aHeaderEx, {AllTrim(X3Titulo()),SX3->X3_CAMPO,SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL,SX3->X3_VALID,;
                              SX3->X3_USADO,SX3->X3_TIPO,SX3->X3_F3,SX3->X3_CONTEXT,SX3->X3_CBOX,SX3->X3_RELACAO})
	    Endif
    Endif
  Next nX

_ac := {}

If alltrim(oMSNewGe1:aCols[oMSNewGe1:nAT,1]) <> ""
	DbSelectArea("SB1")
	DbSetOrder(1)
	DbSeek(xfilial("SB1")+SubStr(cProduto,1,8))

	While !EOF() .and. SubStr(B1_COD,1,8) == SubStr(cProduto,1,8)
		_tem := ASCAN(_aC, {|x| Alltrim(x[2]) == SubStr(SB1->B1_COD,14,2)})
		If _tem == 0
			DbSelectArea("SZK")
			DbSetOrder(2)
			If DbSeek(xfilial("SZK")+SubStr(cProduto,1,15)+cRevisao+padr(oMSNewGe1:aCols[oMSNewGe1:nAT,1],15)+oMSNewGe1:aCols[oMSNewGe1:nAT,6]+SubStr(SB1->B1_COD,14,2))
			//IF Found()
				While !EOF() .and. AllTrim(ZK_INDICE) == AllTrim(oMSNewGe1:aCols[oMSNewGe1:nAT,6]) .and. alltrim(ZK_PRODUTO) == alltrim(cProduto) .and. alltrim(ZK_COMP) == alltrim(oMSNewGe1:aCols[oMSNewGe1:nAT,1]) .and. ZK_REVISAO == cRevisao
					Aadd(_aC, {0,SZK->ZK_TAM,SZK->ZK_TAMNV,oMSNewGe1:aCols[oMSNewGe1:nAT,1],oMSNewGe1:aCols[oMSNewGe1:nAT,6],.F.})
					DbSelectArea("SZK")
					DbSkip()
				End
			Else
				Aadd(_aC, {0,SubStr(SB1->B1_COD,14,2),SPACE(2),oMSNewGe1:aCols[oMSNewGe1:nAT,1],oMSNewGe1:aCols[oMSNewGe1:nAT,6],.F.})
			Endif
		Endif

		DbSelectArea("SB1")
		DbSkip()
	End
Else
	Aadd(aColsEx, {Space(2),Space(2),Space(15),Space(3),.F.})
Endif

if Len(_ac) > 0
	cQuery  := "SELECT BV_FILIAL, BV_TABELA, BV_CHAVE, BV_DESCRI FROM " +RetSQLName("SBV") + " WHERE "
	cQuery  += "BV_FILIAL = '" +xFilial("SBV") +"' AND BV_TABELA = '" +cColuna+ "' AND D_E_L_E_T_ = '' " 
	cQuery += "ORDER BY R_E_C_N_O_"
	
	cQuery := ChangeQuery(cQuery)
	If Select("TMPSBV") > 0 
     	 TMPSBV->(DbCloseArea()) 
	EndIf 
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TMPSBV",.T.,.T.)

	For nX:= 1 to len(_ac)
		DbSelectArea("TMPSBV")
		DbGoTop()
		_w := 0
		While !EOF()
			_w++
			If alltrim(TMPSBV->BV_CHAVE) == alltrim(_ac[nX,2])
				_ac[nX,1] := _w
			Endif		
			DbSkip()
		End
		
	Next
	DbSelectArea("TMPSBV")
	DbCloseArea()
	
	ASORT(_ac, , , { |x,y| x[1] < y[1] } )
	
	For nX:=1 to len(_ac)
		If ASCAN(aColsEx,_ac[nX,2])=0
			Aadd(aColsEx, {_ac[nX,2],_ac[nX,3],_ac[nX,4],_ac[nX,5],.F.})
		End	
	Next	
Endif

  oMSTAM := MsNewGetDados():New( 190, 505, 275, 645, GD_UPDATE, "AllwaysTrue", "AllwaysTrue", "+Field1+Field2", aAlterFields,, 999, "AllwaysTrue", "", "AllwaysTrue", oEst, aHeaderEx, aColsEx)

Return


Static Function estsav()
// Rotina para gerar a estrutura (SG1)
// Primeiro salva as tabelas especÌficas
// Depois gera a estrutura de Produtos

Local _i, _w


_fecha := .T.

For _i := 1 to len(oMSNewGe1:aCols)
	If oMSNewGe1:aCols[_i,len(oMSNewGe1:aHeader)+1] = .F. .and. alltrim(oMSNewGe1:aCols[_i,1]) <> ""
		DbSelectArea("SZE")
		DbSetOrder(2)
		DbSeek(xfilial("SZE")+SubStr(cProduto,1,15)+cRevisao+oMSNewGe1:aCols[_i,6]+oMSNewGe1:aCols[_i,1])
		
		If alltrim(oMSNewGe1:aCols[_i,1]) <> ""
			If !Found()
				RecLock("SZE",.T.)
					Replace ZE_FILIAL		with xfilial("SZE")
					Replace ZE_PRODUTO		with SubStr(cProduto,1,15)
					Replace ZE_COMP			with oMSNewGe1:aCols[_i,1]
					Replace ZE_REVISAO		with cRevisao
					Replace ZE_IMP			with oMSNewGE1:aCols[_i,4]
					Replace ZE_CORTE		with oMSNewGE1:aCols[_i,5]
					Replace ZE_INDICE		with oMSNewGE1:aCols[_i,6]
				MsUnLock()
			Else
					If SZE->ZE_CORTE <> oMSNewGE1:aCols[_i,5]
						u_ajustac(SubStr(cProduto,1,15),cRevisao,oMSNewGe1:aCols[_i,6],oMSNewGe1:aCols[_i,1],SZE->ZE_CORTE)
					Endif
				RecLock("SZE",.F.)
					Replace ZE_IMP			with oMSNewGE1:aCols[_i,4]
					Replace ZE_CORTE		with oMSNewGE1:aCols[_i,5]
				MsUnLock()
			Endif
		Endif
	Else
		DbSelectArea("SZE")
		DbSetOrder(2)
		DbSeek(xfilial("SZE")+SubStr(cProduto,1,15)+cRevisao+oMSNewGe1:aCols[_i,6]+oMSNewGe1:aCols[_i,1])
		
		If Found() //oMSNewGe1:aCols[_i,5]
			RecLock("SZE",.F.)
				DbDelete()
			SZE->(MsUnLock("SZE"))
		Endif
		
//		DbSelectArea("SG1")
//		DbSetOrder(2)
//		DbSeek(xfilial("SG1")+oMSNewGe1:aCols[_i,1])
		
//		While !EOF() .and. SubStr(SG1->G1_COMP,1,8) == alltrim(oMSNewGe1:aCols[_i,1])
//			If SubStr(SG1->G1_COD,1,8) == SubStr(cProduto,1,8)
//				RecLock("SG1",.F.)
//					DbDelete()
//				MsUnLock()
//			Endif
			
//			DbSelectArea("SG1")
//			DbSkip()
//		End
			IF oMSNewGE1:aCols[_i,5] == "S"
				_qry := "update "+RetSqlName("SG1")+" set D_E_L_E_T_ = '*', R_E_C_D_E_L_ = R_E_C_N_O_ where D_E_L_E_T_ = '' and G1_REVINI = '"+cRevisao+"' and SubString(G1_COD,1,8) = '"+SubStr(cProduto,1,6)+"P1' and SubString(G1_COMP,1,8) = '"+alltrim(oMSNewGe1:aCols[_i,1])+"'"
				nStatus := TcSqlExec(_qry)

				_qry := "update "+RetSqlName("SG1")+" set D_E_L_E_T_ = '*', R_E_C_D_E_L_ = R_E_C_N_O_ where D_E_L_E_T_ = '' and G1_REVINI = '"+cRevisao+"' and SubString(G1_COD,1,8) = '"+SubStr(cProduto,1,6)+"P2' and SubString(G1_COMP,1,8) = '"+alltrim(oMSNewGe1:aCols[_i,1])+"'"
				nStatus := TcSqlExec(_qry)

			Else
				_qry := "update "+RetSqlName("SG1")+" set D_E_L_E_T_ = '*', R_E_C_D_E_L_ = R_E_C_N_O_ where D_E_L_E_T_ = '' and G1_REVINI = '"+cRevisao+"' and SubString(G1_COD,1,8) = '"+SubStr(cProduto,1,8)+"' and SubString(G1_COMP,1,8) = '"+alltrim(oMSNewGe1:aCols[_i,1])+"'"
				nStatus := TcSqlExec(_qry)
			Endif
			
			if (nStatus < 0)
  				MsgBox(TCSQLError(), "Erro no comando", "Stop")
	  		endif
	Endif
	
	DbSelectArea("SZE")
	
Next

For _i := 1 to len(oMSCor:aCols)
	DbSelectArea("SZG")
	DbSetOrder(2)
	DbSeek(xfilial("SZG")+SubStr(cProduto,1,15)+cRevisao+oMsCor:aCols[_i,3]+oMSNewGe1:aCols[oMSNewGe1:nAT,6]+oMsCor:aCols[_i,1])

	If alltrim(oMsCor:aCols[_i,3]) <> ""		
		_tem := ASCAN( oMSNewGe1:aCols, {|x| Alltrim(x[1]) == alltrim(oMsCor:aCols[_i,3]) .AND.  Alltrim(x[6]) == alltrim(oMsCor:aCols[_i,5])})

		IF Found()
			If oMSNewGe1:aCols[_tem,len(oMSNewGe1:aHeader)+1] = .F.
				RecLock("SZG",.F.)
					Replace ZG_CORNV	with oMsCor:aCols[_i,2]
					Replace ZG_LOCALIZ	with oMsCor:aCols[_i,4]
				MsUnlock()
			Else
				RecLock("SZG",.F.)
					DbDelete()
				MsUnLock()
			Endif
		Else
			If oMSNewGe1:aCols[_tem,len(oMSNewGe1:aHeader)+1] = .F.
				RecLock("SZG",.T.)
					Replace ZG_FILIAL	with xfilial("SZG")
					Replace ZG_PRODUTO 		with cProduto
					Replace ZG_COMP			with oMsCor:aCols[_i,3]
					Replace ZG_COR			with oMsCor:aCols[_i,1]
					Replace ZG_CORNV			with oMsCor:aCols[_i,2]
					Replace ZG_REVISAO		with cRevisao
					Replace ZG_LOCALIZ		with oMSCor:aCols[_i,4]
					Replace ZG_INDICE			with oMSCor:aCols[_i,5]
				MsUnlock()
			Endif
		Endif
	Endif
Next

For _i := 1 to len(oMSTam:aCols)
	//DbSelectArea("SZK")
	//DbSetOrder(2)
	//DbSeek(xfilial("SZK")+SubStr(cProduto,1,15)+cRevisao+oMsTam:aCols[_i,3]+oMSNewGe1:aCols[oMSNewGe1:nAT,5]+oMsTam:aCols[_i,1])
		
	If alltrim(oMsTam:aCols[_i,3]) <> ""
		_tem := ASCAN( oMSNewGe1:aCols, {|x| Alltrim(x[1]) == alltrim(oMsTam:aCols[_i,3]) .AND. Alltrim(x[6]) == alltrim(oMsTam:aCols[_i,4])})
        
		DbSelectArea("SZK")
		DbSetOrder(2)
		If DbSeek(xfilial("SZK")+SubStr(cProduto,1,15)+cRevisao+oMsTam:aCols[_i,3]+oMSNewGe1:aCols[oMSNewGe1:nAT,6]+oMsTam:aCols[_i,1])
		//IF Found()
			If oMSNewGe1:aCols[_tem,len(oMSNewGe1:aHeader)+1] = .F.
				RecLock("SZK",.F.)
					Replace ZK_TAMNV	with oMsTam:aCols[_i,2]
				MsUnlock()
			Else
				RecLock("SZK",.F.)
					DbDelete()
				MsUnLock()
			Endif
		Else
			If oMSNewGe1:aCols[_tem,len(oMSNewGe1:aHeader)+1] = .F.
				RecLock("SZK",.T.)
					Replace ZK_FILIAL	with xfilial("SZK")
					Replace ZK_PRODUTO 	with cProduto
					Replace ZK_COMP		with oMsTam:aCols[_i,3]
					Replace ZK_TAM		with oMsTam:aCols[_i,1]
					Replace ZK_TAMNV		with oMsTam:aCols[_i,2]
					Replace ZK_REVISAO	with cRevisao
					Replace ZK_INDICE		with oMSTam:aCols[_i,4]
				MsUnlock()
			Endif
		Endif
	Endif
Next

For _i := 1 to len(oMSQtd:aCols)
	DbSelectArea("SZF")
	DbSetOrder(2)
	DbSeek(xfilial("SZF")+SubStr(cProduto,1,15)+cRevisao+SubStr(oMsQtd:aCols[_i,Len(oMsQtd:aHeader)-1],1,15)+oMSNewGe1:aCols[oMSNewGe1:nAT,6]+alltrim(oMsQtd:aCols[_i,1]))

	_tem := ASCAN( oMSNewGe1:aCols, {|x| Alltrim(x[1]) == alltrim(oMsQtd:aCols[_i,len(oMsQtd:aHeader)-1]) .AND. Alltrim(x[6]) == alltrim(oMsQtd:aCols[_i,len(oMsQtd:aHeader)])})

	IF Found()
		If oMSNewGe1:aCols[_tem,len(oMSNewGe1:aHeader)+1] = .F.
			RecLock("SZF",.F.)
			  	For _w := 3 to Len(oMsQtd:aHeader)-2
					_campo := "SZF->"+alltrim(oMsQtd:aheader[_w][2])  //ZF_TAM"+StrZero(_w,3)
					Replace &(_campo) with oMsQtd:ACOLS[_i,_w]
				Next
			MsUnlock()
		Else
			RecLock("SZF",.F.)
				DbDelete()
			MsUnLock()
		Endif
	Else
		If oMSNewGe1:aCols[_tem,len(oMSNewGe1:aHeader)+1] = .F. .and. alltrim(oMsQtd:aCols[_i,len(oMsQtd:aHeader)-1]) <> ""
			RecLock("SZF",.T.)
				Replace ZF_FILIAL	with xfilial("SZF")
				Replace ZF_PRODUTO 	with cProduto
				Replace ZF_COMP		with oMsQtd:aCols[_i,len(oMsQtd:aHeader)-1]
				Replace ZF_COR		with oMsQtd:aCols[_i,1]
				Replace ZF_REVISAO	with cRevisao
				Replace ZF_INDICE		with oMSQtd:aCols[_i,len(oMsQtd:aHeader)]
		  		For _w := 3 to Len(oMsQtd:aHeader)-2
					_campo := "SZF->"+oMsQtd:aheader[_w][2] //ZF_TAM"+StrZero(_w,3)
					Replace &(_campo) with oMsQtd:ACOLS[_i,_w]
				Next
			MsUnlock()
		Endif
	Endif
Next

For _i := 1 to len(oMSNewGe1:aCols)
	If oMSNewGe1:aCols[_i,len(oMSNewGe1:aHeader)+1] = .F.
		DbSelectArea("SZF")
		DbSetOrder(2)
		DbSeek(xfilial("SZF")+SubStr(cProduto,1,15)+cRevisao+SubStr(oMSNewGe1:aCols[_i,1],1,15)+oMSNewGe1:aCols[_i,6])		

		IF found()
			While !EOF() .and. SubStr(cProduto,1,8) == SubStr(SZF->ZF_PRODUTO,1,8) .and. alltrim(cRevisao) == alltrim(SZF->ZF_REVISAO) .and. SubStr(oMSNewGe1:aCols[_i,1],1,8) == SubStr(SZF->ZF_COMP,1,8) .and. _fecha .and. alltrim(SZF->ZF_INDICE) == alltrim(oMSNewGe1:aCols[_i,6]) 
		
				For _w := 3 to len(oMsQtd:aheader)-2
					_campo := "SZF->"+oMsQtd:aheader[_w][2] //ZF_TAM"+StrZero(_w,3)
	  				If &_campo > 0
						DbSelectArea("SZG")
						DbSetOrder(2)
						DbSeek(xfilial("SZG")+SubStr(cProduto,1,15)+cRevisao+SubStr(oMSNewGe1:aCols[_i,1],1,15)+oMSNewGe1:aCols[_i,6]+SZF->ZF_COR)
				
						If !Found() .or. alltrim(SZG->ZG_CORNV) = ""
							_fecha := .F.
						Endif
				
						DbSelectArea("SZK")
						DbSetOrder(2)
						DbSeek(xfilial("SZK")+SubStr(cProduto,1,15)+cRevisao+SubStr(oMsNewGe1:aCols[_i,1],1,15)+oMSNewGe1:aCols[_i,6])

						If Found()
							While !EOF() .and. SubStr(cProduto,1,8) == SubStr(SZK->ZK_PRODUTO,1,8) .and. alltrim(cRevisao) == alltrim(SZK->ZK_REVISAO) .and. SubStr(oMSNewGe1:aCols[_i,1],1,8) == SubStr(SZK->ZK_COMP,1,8) .and. _fecha .and. alltrim(SZK->ZK_INDICE) == alltrim(oMSNewGe1:aCols[_i,6]) 
								If alltrim(SZK->ZK_TAMNV) == ""
									_fecha := .F.
								Endif
								DbSelectArea("SZK")
								DbSkip()
							End
						Else
							_fecha := .F.
						Endif 						
					Endif
				Next
			
				DbSelectArea("SZF")
				DbSkip()
			End
		Else
			_fecha := .F.
		Endif
	Endif
Next

If _fecha
		_qry := "update "+RetSqlName("SG1")+" set D_E_L_E_T_ = '*', R_E_C_D_E_L_ = R_E_C_N_O_ from "+RetSqlName("SG1")+" SG1 " 
		_qry += "where (left(G1_COD,8) = '"+substr(cProduto,1,6)+"P1' or left(G1_COD,8) = '"+substr(cProduto,1,6)+"P2') and SG1.D_E_L_E_T_ = '' and " 
		_qry += "(Select top 1 ZE_COMP from SZE010 SZE where SZE.D_E_L_E_T_ = ''  and ZE_PRODUTO = '"+substr(cProduto,1,8)+"' and " 
		_qry += "left(ZE_COMP,8) = left(G1_COMP,8) and ZE_CORTE = 'S' and ZE_REVISAO = G1_REVINI) is null "

		TcSqlExec(_qry)

		_qry := "SELECT 'update "+RetSqlName("SG1")+" set D_E_L_E_T_ = ''*'', R_E_C_D_E_L_ = R_E_C_N_O_ where R_E_C_N_O_ in ('+ ( "
		_qry += "Select cast(R_E_C_N_O_ as varchar) + ',' AS [text()] "
		_qry += "from "+RetSqlName("SG1")+" SG1A (nolock) "
		_qry += "where SG1A.D_E_L_E_T_ = '' and SG1A.G1_REVINI = '"+cRevisao+"' and G1_COD in "
		_qry += "(Select G1_COMP from "+RetSqlName("SG1")+" SG1 where SG1.D_E_L_E_T_ = '' and " 
		_qry += "left(SG1.G1_COD,8) = '"+substr(cProduto,1,8)+"' and (Substring(SG1.G1_COMP,7,2) = 'P1' or Substring(SG1.G1_COMP,7,2) = 'P2')"
		_qry += "group by G1_COMP) "
		_qry += "FOR XML PATH ('')) as UPD "

		dbUseArea(.T.,"TOPCONN",TcGenQry(,,_qry),"TMPUPD",.T.,.T.)
		DbselectArea("TMPUPD")
		DbGoTop()
		
		_QRY := SUBSTR(TMPUPD->UPD,1,LEN(ALLTRIM(TMPUPD->UPD))-1)+")"

		IF len(alltrim(_qry)) > 10
			nStatus := TcSqlExec(_qry)
		
			if (nStatus < 0)
	  			MsgBox(TCSQLError(), "Erro no comando", "Stop")
	  		endif
		ENDIF
		DbSelectArea("TMPUPD")
		DbCloseArea()
		_qry := "SELECT 'update "+RetSqlName("SG1")+" set D_E_L_E_T_ = ''*'', R_E_C_D_E_L_ = R_E_C_N_O_ where R_E_C_N_O_ in ('+ ( "
		_qry += "Select cast(R_E_C_N_O_ as varchar) + ',' AS [text()] "
		_qry += "from "+RetSqlName("SG1")+" SG1 (nolock) "
		_qry += "where D_E_L_E_T_ = '' and G1_REVINI = '"+cRevisao+"' and left(G1_COD,8) = '"+substr(cProduto,1,8)+"' "
		_qry += "FOR XML PATH ('')) as UPD "

		dbUseArea(.T.,"TOPCONN",TcGenQry(,,_qry),"TMPUPD",.T.,.T.)
		DbselectArea("TMPUPD")
		DbGoTop()
		
		_QRY := SUBSTR(TMPUPD->UPD,1,LEN(ALLTRIM(TMPUPD->UPD))-1)+")"

		IF len(alltrim(_qry)) > 10
			nStatus := TcSqlExec(_qry)
		
			if (nStatus < 0)
	  			MsgBox(TCSQLError(), "Erro no comando", "Stop")
	  		endif
		ENDIF
		DbSelectArea("TMPUPD")
		DbCloseArea()
	DbSelectArea("SZE")
	DbSetOrder(1)
	If DbSeek(xfilial("SZE")+substr(cProduto,1,15)+cRevisao)
  	
	  	_seq1 := SZE->ZE_INDICE
	  	
		While !EOF() .and. alltrim(SZE->ZE_PRODUTO) == ALLTRIM(SubStr(cProduto,1,15)) .and. Alltrim(SZE->ZE_REVISAO) == cRevisao
			DbSelectArea("SB4")
			DbSetOrder(1)
			If !DbSeek(xfilial("SB4")+SubStr(SZE->ZE_COMP,1,8))
		
			//If !Found()
				_seq := 1
				DbSelectArea("SZF")
				DbSetOrder(2)
				If DbSeek(xfilial("SZF")+SubStr(cProduto,1,15)+cRevisao+SZE->ZE_INDICE+SZE->ZE_COMP)
	
					DbSelectArea("SZG")
					DbSetOrder(2)
					If DbSeek(xfilial("SZG")+SubStr(cProduto,1,15)+cRevisao+SZE->ZE_COMP+SZE->ZE_INDICE)
				
					//If Found()
						For _i := 3 to len(oMsQtd:aHeader)-2
					
							_campo := "SZF->"+oMsQtd:aheader[_i][2]//ZF_TAM"+StrZero(_i,3)
						
							If &_campo > 0
								DbSelectArea("SB4")
								DbSetOrder(1)
								DbSeek(xfilial("SB4")+alltrim(SubStr(cProduto,1,15)))
								cColuna	:= SB4->B4_COLUNA
								_comp := SZE->ZE_COMP
								_tam 		:= rettam(Val(SubStr(_campo,12,3)),cColuna,"C")
								_qtd  := &_campo
								_niv := "01"
								_xnv := "99"
							
							IF SZE->ZE_CORTE == "S"
									_niv := "03"
									_xnv := "97"
									_prod := u_cadEst(alltrim(SubStr(cProduto,1,15))+alltrim(SZG->ZG_CORNV)+_tam )
									u_EstSup(PADR(alltrim(SubStr(cProduto,1,15))+alltrim(SZG->ZG_COR)+_tam,15),PADR(_prod,15))
							Else
								_niv := "01"
								_xnv := "99"
									_prod := alltrim(SubStr(cProduto,1,15))+alltrim(SZG->ZG_COR)+_tam 
							Endif
							
		//					If PADR(alltrim(SubStr(cProduto,1,15))+alltrim(SZG->ZG_COR)+_tam,15) <> PADR(alltrim(_prod),15)
		//					Endif
							
								//_seq1 := strzero(_seq,3)
							
								DbSelectArea("SB1")
								DbSetOrder(1)
								If DbSeek(xfilial("SB1")+_prod)
							
								//If Found()
									DbSelectArea("SG1")
									DbSetOrder(6)
									If DbSeek(xfilial("SG1")+PADR(_prod,15)+PADR(_comp,15)+_seq1+cRevisao)
							
									//If !Found()
										If SZE->ZE_CORTE == "S" .and. !(SubStr(_prod,7,2) $ "P1|P2")

										Else									
											RecLock("SG1",.T.)
												Replace G1_FILIAL		with xfilial("SG1")
												Replace G1_COD			with _prod
												Replace G1_COMP			with _comp
												Replace G1_TRT			with _seq1
												Replace G1_QUANT		with _qtd
												Replace G1_INI			with ddatabase
												Replace G1_FIM			with ctod("31/12/2049")
												Replace G1_NIV			with _niv
												Replace G1_NIVINV		with _xnv
												Replace G1_REVINI		with cRevisao
												Replace G1_REVFIM		with cRevisao
											MsUnLock()
										Endif
									Else
										RecLock("SG1",.F.)
											Replace G1_QUANT		with _qtd
										MsUnLock()
									Endif
								Else
									Alert("O produto "+_prod+" n„o est· cadastrado no cadastro de produtos!")
								Endif
							Endif
						Next
					Endif
				EndIf
			Else
				DbSelectArea("SZG")
				DbSetOrder(2)
				DbSeek(xfilial("SZG")+SubStr(cProduto,1,15)+cRevisao+SZE->ZE_COMP+SZE->ZE_INDICE)
				_seq1 := SZE->ZE_INDICE
				_seq := 0
				While !EOF() .and. SZG->ZG_COMP = SZE->ZE_COMP .and. SZG->ZG_PRODUTO = SZE->ZE_PRODUTO .and. SZG->ZG_REVISAO == cRevisao .AND. SZE->ZE_INDICE = SZG->ZG_INDICE
					DbSelectArea("SZF")
					DbSetOrder(2)
					If DbSeek(xfilial("SZF")+SubStr(cProduto,1,15)+cRevisao+SZG->ZG_COMP+SZE->ZE_INDICE+SZG->ZG_COR)
			
					//If Found()
						_seq++
				
						For _i := 3 to len(oMsQtd:aHeader)-2
					
							_campo := "SZF->"+oMsQtd:aheader[_i][2]//ZF_TAM"+StrZero(_i,3)
					
							If &_campo > 0
								DbSelectArea("SB4")
								DbSetOrder(1)
								If DbSeek(xfilial("SB4")+alltrim(SubStr(cProduto,1,15)))
									cColuna	:= SB4->B4_COLUNA
									_tam 		:= rettam(Val(SubStr(_campo,12,3)),cColuna,"C")
									
									DbSelectArea("SZK")
									DbSetOrder(2)
									If DbSeek(xfilial("SZK")+SubStr(cProduto,1,15)+cRevisao+SZG->ZG_COMP+SZE->ZE_INDICE+_tam)
									//If Found()
										_tamcomp := SZK->ZK_TAMNV
									Else
										_tamcomp := ""
									Endif
									_comp := alltrim(SZG->ZG_COMP)+alltrim(SZG->ZG_CORNV)+_tamcomp
									_qtd  := &_campo
									_niv := "01"
									_xnv := "99"
							
									IF SZE->ZE_CORTE == "S"
										_niv := "03"
										_xnv := "97"
										_prod := u_cadEst(alltrim(SubStr(cProduto,1,15))+alltrim(SZG->ZG_COR)+_tam )
									Else
										_niv := "01"
										_xnv := "99"
										_prod := alltrim(SubStr(cProduto,1,15))+alltrim(SZG->ZG_COR)+_tam 
									Endif
								Endif
								If PADR(alltrim(SubStr(cProduto,1,15))+alltrim(SZG->ZG_COR)+_tam,15) <> PADR(alltrim(_prod),15)
									u_EstSup(PADR(alltrim(SubStr(cProduto,1,15))+alltrim(SZG->ZG_COR)+_tam,15),PADR(_prod,15),SZG->ZG_INDICE)
								Endif
							
									//_seq1 := strzero(_seq,3)
							
									DbSelectArea("SB1")
									DbSetOrder(1)
									If DbSeek(xfilial("SB1")+_prod)
							
									//If Found()
										DbSelectArea("SG1")
										DbSetOrder(6)
										If !DbSeek(xfilial("SG1")+PADR(_prod,15)+PADR(_comp,15)+_seq1+cRevisao)
								
										//If !Found()
											If SZE->ZE_CORTE == "S" .and. !(SubStr(_prod,7,2) $ "P1|P2")

											Else
												RecLock("SG1",.T.)
													Replace G1_FILIAL		with xfilial("SG1")
													Replace G1_COD			with _prod
													Replace G1_COMP			with _comp
													Replace G1_TRT			with _seq1
													Replace G1_QUANT		with _qtd
													Replace G1_INI			with ddatabase
													Replace G1_FIM			with ctod("31/12/2049")
													Replace G1_NIV			with _niv
													Replace G1_NIVINV		with _xnv
													Replace G1_REVINI		with cRevisao
													Replace G1_REVFIM		with cRevisao
												MsUnLock()
											Endif
										Else
											RecLock("SG1",.F.)
												Replace G1_QUANT		with _qtd
											MsUnLock()
										Endif
									Else
										Alert("O produto "+_prod+" n„o est· cadastrado no cadastro de produtos!")
									Endif
							Endif
						Next
					Endif
			
					DbSelectArea("SZG")
					DbSkip()
				EndDo
			Endif	
			DbSelectArea("SZE")
			DbSkip()  
		EndDo
	
	EndIf
/*
	
	DbSelectArea("SG1")
	DbSetOrder(1)
	DbGoTop()
	DbSeek(xfilial("SG1")+substr(cProduto,1,8))
	
	While !EOF() .and. SubStr(SG1->G1_COD,1,8) == substr(cProduto,1,8)
		_achou := .T.
		DbSelectArea("SZE")
		DbSetOrder(2)
		DbSeek(xfilial("SZE")+Padr(SubStr(SG1->G1_COD,1,8),15)+SG1->G1_REVINI+SG1->G1_TRT+Padr(SubStr(SG1->G1_COMP,1,8),15))
		If !Found()
			_achou := .f.
		Endif
		
		DbSelectArea("SZG")
		DbSetOrder(2)
		DbSeek(xfilial("SZG")+Padr(SubStr(SG1->G1_COD,1,8),15)+SG1->G1_REVINI+Padr(SubStr(SG1->G1_COMP,1,8),15)+SG1->G1_TRT+SubStr(SG1->G1_COD,9,5))
		If !Found() .or. SZG->ZG_CORNV <> SubStr(SG1->G1_COMP,9,5)
			_achou := .f.
		Endif
			
		DbSelectArea("SZK")
		DbSetOrder(2)
		DbSeek(xfilial("SZK")+Padr(SubStr(SG1->G1_COD,1,8),15)+SG1->G1_REVINI+Padr(SubStr(SG1->G1_COMP,1,8),15)+SG1->G1_TRT+SubStr(SG1->G1_COD,14,2))
		If !Found() .or. SZK->ZK_TAMNV <> SubStr(SG1->G1_COMP,14,2)
			_achou := .f.
		Endif
	
		If !_achou .and. SubStr(SG1->G1_COMP,1,1) <> "B"
			RecLock("SG1",.F.)
				DbDelete()
			MsUnLock()
		Endif
		DbSelectArea("SG1")
		DbSkip()
	End
*/
_qry := "update "+RetSqlName("SG1")+" set D_E_L_E_T_ = '*', R_E_C_D_E_L_ = R_E_C_N_O_ from "+RetSqlName("SG1")+" SG1 "
_qry += "where SG1.D_E_L_E_T_ = '' and Left(G1_COD,8) = '"+substr(cProduto,1,8)+"' "
_qry += "and (Select ZE_COMP from SZE010 SZE where SZE.D_E_L_E_T_ = '' and ZE_FILIAL = '"+xfilial("SZE")+"' and "
_qry += "ZE_PRODUTO = SubString(G1_COD,1,8) and ZE_REVISAO = G1_REVINI and ZE_INDICE = G1_TRT and ZE_COMP = SubString(G1_COMP,1,8)) "
_qry += "is null and SubString(G1_COMP,7,2) <> 'P1' and SubString(G1_COMP,7,2) <> 'P2' "
_QRY += "AND G1_COMP NOT IN ('SERVPRESUN001TT','BENEFCOSTURA')

TcSqlExec(_qry)

_qry := "update "+RetSqlName("SG1")+" set D_E_L_E_T_ = '*', R_E_C_D_E_L_ = R_E_C_N_O_ from "+RetSqlName("SG1")+" SG1 "
_qry += "where SG1.D_E_L_E_T_ = '' and Left(G1_COD,8) = '"+substr(cProduto,1,8)+"' "
_qry += "and (Select TOP 1 ZG_COMP from SZG010 SZG where SZG.D_E_L_E_T_ = '' and ZG_FILIAL = '"+xfilial("SZG")+"' and "
_qry += "ZG_PRODUTO = SubString(G1_COD,1,8) and ZG_REVISAO = G1_REVINI and ZG_INDICE = G1_TRT and ZG_COMP = SubString(G1_COMP,1,8) "
_qry += "and ZG_CORNV = SubString(G1_COMP,9,5)) is null and SubString(G1_COMP,7,2) <> 'P1' and SubString(G1_COMP,7,2) <> 'P2'"
_QRY += "AND G1_COMP NOT IN ('SERVPRESUN001TT','BENEFCOSTURA')

TcSqlExec(_qry)

_qry := "update "+RetSqlName("SG1")+" set D_E_L_E_T_ = '*', R_E_C_D_E_L_ = R_E_C_N_O_ from "+RetSqlName("SG1")+" SG1 "
_qry += "where SG1.D_E_L_E_T_ = '' and Left(G1_COD,8) = '"+substr(cProduto,1,8)+"' "
_qry += "and (Select ZK_COMP from SZK010 SZK where SZK.D_E_L_E_T_ = '' and ZK_FILIAL = '"+xfilial("SZK")+"' and "
_qry += "ZK_PRODUTO = SubString(G1_COD,1,8) and ZK_REVISAO = G1_REVINI and ZK_INDICE = G1_TRT and ZK_COMP = SubString(G1_COMP,1,8) "
_qry += "and ZK_TAMNV = SubString(G1_COMP,14,2)) is null and SubString(G1_COMP,7,2) <> 'P1' and SubString(G1_COMP,7,2) <> 'P2' "
_QRY += "AND G1_COMP NOT IN ('SERVPRESUN001TT','BENEFCOSTURA')

TcSqlExec(_qry)
		
//	If MsgYesNo("Deseja recalcular NÌveis?")
//		MA320Nivel(Nil,.T.,.F.)
//	Endif

/*
			DbSelectArea("SB1")
			DbSetOrder(1)
			DbSeek(xfilial("SB1")+substr(cProduto,1,8))
		
			While !EOF() .and. SubStr(SB1->B1_COD,1,8) == substr(cProduto,1,8)

				RecLock("SB1",.F.)
					Replace B1_REVATU 	with cRevisao
				MsUnLock()
				DbSelectArea("SB1")
				DbSkip()
			End

			DbSelectArea("SB1")
			DbSetOrder(1)
			DbSeek(xfilial("SB1")+substr(cProduto,1,6)+"P1")
		
			While !EOF() .and. SubStr(SB1->B1_COD,1,8) == substr(cProduto,1,6)+"P1"
				RecLock("SB1",.F.)
					Replace B1_REVATU 	with cRevisao
				MsUnLock()
				DbSelectArea("SB1")
				DbSkip()
			End

			DbSelectArea("SB1")
			DbSetOrder(1)
			DbSeek(xfilial("SB1")+substr(cProduto,1,6)+"P2")
		
			While !EOF() .and. SubStr(SB1->B1_COD,1,8) == substr(cProduto,1,6)+"P2"
				RecLock("SB1",.F.)
					Replace B1_REVATU 	with cRevisao
				MsUnLock()
				DbSelectArea("SB1")
				DbSkip()
			End

*/	
Endif

/*
//_mod := {"MOD12512","MOD12513","MOD12514","MOD12531","MOD12532","MOD12533","MOD12521","MOD12522","MOD12541","MOD12542","MOD12543"}
_mod := {"MOD123200","MOD123300","MOD123400","MOD124100","MOD124210","MOD124220","MOD124230",;
		 "MOD125110","MOD125120","MOD125150","MOD125210","MOD125220","MOD125230","MOD125310",;
		 "MOD125320","MOD125330","MOD125340","MOD125350","MOD125410","MOD125420","MOD125440",;
		 "MOD125450","MOD125500","MOD125610","MOD125630","MOD125710","MOD125720","MOD125810",;
		 "MOD125820","MOD125910","MOD125920","MOD131000"}

		 
For _i := 1 to len(_mod)
		_QRY := "Insert into "+RetSqlName("SG1")+" (G1_FILIAL, G1_COD, G1_COMP, G1_TRT, G1_QUANT, G1_INI, G1_FIM, G1_REVINI, G1_REVFIM, G1_NIV, G1_NIVINV, G1_FIXVAR, R_E_C_N_O_) "  
		_QRY += "Select "
		_QRY += "'',X.G1_COD,'"+_mod[_i]+"','',1,'19500101','20491231', X.G1_REVINI,X.G1_REVINI, '01', '99', 'V', "
		_QRY += "(CAST((ROW_NUMBER() OVER (ORDER BY X.G1_COD)+(SELECT max(SG1.R_E_C_N_O_) FROM "+RetSqlName("SG1")+" SG1)) AS VARCHAR)) "
		_QRY += "from ( "
		_QRY += "Select G1_COD, G1_REVINI from "+RetSqlName("SG1")+" SG1B with (nolock) "
		_QRY += "inner join "+RetSqlName("SB1")+" SB1 with (nolock) on SB1.D_E_L_E_T_ = '' and B1_COD = G1_COD "
		_QRY += "where SG1B.D_E_L_E_T_ = '' "
		_QRY += "and (Select top 1 SG1C.G1_COMP from "+RetSqlName("SG1")+" SG1C with (nolock) where SG1C.D_E_L_E_T_ = '' and " 
		_QRY += "SG1C.G1_COD = SG1B.G1_COD and SG1C.G1_COMP = '"+_mod[_i]+"') is null " 
		_QRY += "and B1_TIPO = 'PA' "
		_QRY += "group by SG1B.G1_COD, SG1B.G1_REVINI) as X "

		nStatus := TcSqlExec(_qry)

		if (nStatus < 0)
  			MsgBox(TCSQLError(), "Erro no comando", "Stop") 
  		endif
Next 
*/
Return

User Function AtuAcols()
// Rotina para atualizar acols na mudanÁa de linha de acols de componentes
// Salva cada acol antes de mudar de linha e atualizar

Local _i,_w, nx

For _i := 1 to len(oMSNewGe1:aCols)
	If oMSNewGe1:aCols[_i,len(oMSNewGe1:aHeader)+1] = .F.
		DbSelectArea("SZE")
		DbSetOrder(2)
		DbSeek(xfilial("SZE")+SubStr(cProduto,1,15)+cRevisao+oMSNewGe1:aCols[_i,6]+oMSNewGe1:aCols[_i,1])
		
			If alltrim(oMSNewGe1:aCols[_i,1]) <> "" .and. alltrim(oMSNewGe1:aCols[_i,1]) <> ""
			If !Found()
				RecLock("SZE",.T.)
					Replace ZE_FILIAL		with xfilial("SZE")
					Replace ZE_PRODUTO		with SubStr(cProduto,1,15)
					Replace ZE_COMP			with oMSNewGe1:aCols[_i,1]
					Replace ZE_REVISAO		with cRevisao
					Replace ZE_IMP			with oMSNewGE1:aCols[_i,4]
					Replace ZE_CORTE		with oMSNewGE1:aCols[_i,5]
					Replace ZE_INDICE		with oMSNewGE1:aCols[_i,6]
				MsUnLock()
			Else
					If SZE->ZE_CORTE <> oMSNewGE1:aCols[_i,5]
						u_ajustac(SubStr(cProduto,1,15),cRevisao,oMSNewGe1:aCols[_i,6],oMSNewGe1:aCols[_i,1],SZE->ZE_CORTE)
					Endif
				RecLock("SZE",.F.)
					Replace ZE_IMP			with oMSNewGE1:aCols[_i,4]
					Replace ZE_CORTE		with oMSNewGE1:aCols[_i,5]
				MsUnLock()
			Endif
		Endif
	Else
		DbSelectArea("SZE")
		DbSetOrder(2)
		DbSeek(xfilial("SZE")+SubStr(cProduto,1,15)+cRevisao+oMSNewGe1:aCols[_i,6]+oMSNewGe1:aCols[_i,1])
		
		If Found() //oMSNewGe1:aCols[_i,5]
			RecLock("SZE",.F.)
				DbDelete()
			SZE->(MsUnLock("SZE"))
		Endif
		
		_qry := "update "+RetSqlName("SG1")+" set D_E_L_E_T_ = '*', R_E_C_D_E_L_ = R_E_C_N_O_ where D_E_L_E_T_ = '' and SubString(G1_COD,1,8) = '"+SubStr(cProduto,1,8)+"' and SubString(G1_COMP,1,8) = '"+alltrim(oMSNewGe1:aCols[_i,1])+"'"
		TcSqlExec(_qry)
	Endif
	
	DbSelectArea("SZE")
	
Next

For _i := 1 to len(oMSCor:aCols)
	DbSelectArea("SZG")
	DbSetOrder(2)
	DbSeek(xfilial("SZG")+SubStr(cProduto,1,15)+cRevisao+oMsCor:aCols[_i,3]+oMsCor:aCols[_i,5]+oMsCor:aCols[_i,1])

		If alltrim(oMsCor:aCols[_i,3]) <> "" .and. alltrim(oMsCor:aCols[_i,3]) <> ""
		_tem := ASCAN( oMSNewGe1:aCols, {|x| Alltrim(x[1]) == alltrim(oMsCor:aCols[_i,3]) .AND. Alltrim(x[6]) == alltrim(oMsCor:aCols[_i,5])})

		IF Found()
			If oMSNewGe1:aCols[_tem,len(oMSNewGe1:aHeader)+1] = .F.
				RecLock("SZG",.F.)
					Replace ZG_CORNV	with oMsCor:aCols[_i,2]
					Replace ZG_LOCALIZ	with oMsCor:aCols[_i,4]
				MsUnlock()
			Else                                                                                     	
				Reclock("SZG",.F.)
					DbDelete()
				MsUnLock()
			Endif
		Else
			If _tem > 0
				If oMSNewGe1:aCols[_tem,len(oMSNewGe1:aHeader)+1] = .F.
					RecLock("SZG",.T.)
						Replace ZG_FILIAL	with xfilial("SZG")
						Replace ZG_PRODUTO 	with cProduto
						Replace ZG_COMP		with oMsCor:aCols[_i,3]
						Replace ZG_COR		with oMsCor:aCols[_i,1]
						Replace ZG_CORNV	with oMsCor:aCols[_i,2]
						Replace ZG_REVISAO	with cRevisao
						Replace ZG_LOCALIZ	with oMsCor:aCols[_i,4]
						Replace ZG_INDICE	with oMsCor:aCols[_i,5]
					MsUnlock()
				Endif
			Else
			    MsgAlert("N„o encontrado 3.")
			EndIf
		Endif
	Endif
Next

For _i := 1 to len(oMSTam:aCols)
	//DbSelectArea("SZK")
	//DbSetOrder(2)
	//DbSeek(xfilial("SZK")+SubStr(cProduto,1,15)+cRevisao+oMsTam:aCols[_i,3]+oMsTam:aCols[_i,4]+oMsTam:aCols[_i,1])

	If alltrim(oMsTam:aCols[_i,3]) <> ""
		_tem := ASCAN( oMSNewGe1:aCols, {|x| Alltrim(x[1]) == alltrim(oMsTam:aCols[_i,3]) .AND. Alltrim(x[6]) == alltrim(oMsTam:aCols[_i,4])})
		DbSelectArea("SZK")
		DbSetOrder(2)
		If DbSeek(xfilial("SZK")+SubStr(cProduto,1,15)+cRevisao+oMsTam:aCols[_i,3]+oMsTam:aCols[_i,4]+oMsTam:aCols[_i,1])
		//IF Found()
			If oMSNewGe1:aCols[_tem,len(oMSNewGe1:aHeader)+1] = .F.
				RecLock("SZK",.F.)
					Replace ZK_TAMNV	with oMsTam:aCols[_i,2]
				MsUnlock()
			Else
				RecLock("SZK",.F.)
					DbDelete()
				MsUnLock()
			Endif
		Else
			If _tem > 0
				If oMSNewGe1:aCols[_tem,len(oMSNewGe1:aHeader)+1] = .F.
					RecLock("SZK",.T.)
						Replace ZK_FILIAL	with xfilial("SZG")
						Replace ZK_PRODUTO 	with cProduto
						Replace ZK_COMP		with oMsTam:aCols[_i,3]
						Replace ZK_TAM		with oMsTam:aCols[_i,1]
						Replace ZK_TAMNV	with oMsTam:aCols[_i,2]
						Replace ZK_REVISAO	with cRevisao
						Replace ZK_INDICE	with oMsTam:aCols[_i,4]
					MsUnlock()
				Endif
			EndIf
		Endif
	Endif
Next

For _i := 1 to len(oMSQtd:aCols)
	DbSelectArea("SZF")
	DbSetOrder(2)
	DbSeek(xfilial("SZF")+SubStr(cProduto,1,15)+cRevisao+oMsQtd:aCols[_i,LEN(oMsQtd:aHeader)-1]+SubStr(oMsQtd:aCols[_i,Len(oMsQtd:aHeader)],1,15)+alltrim(oMsQtd:aCols[_i,1]))
	
	If Alltrim(oMsQtd:aCols[_i,len(oMsQtd:aHeader)-1]) <> ""
		_tem := ASCAN( oMSNewGe1:aCols, {|x| Alltrim(x[1]) == alltrim(oMsQtd:aCols[_i,LEN(OMSQTD:AHEADER)-1]) .AND. Alltrim(x[6]) == alltrim(oMsQtd:aCols[_i,Len(oMsQtd:aHeader)])})
		IF Found()
			If oMSNewGe1:aCols[_tem,len(oMSNewGe1:aHeader)+1] = .F.
				RecLock("SZF",.F.)
				  	For _w := 3 to Len(oMsQtd:aHeader)-2
						_campo := "SZF->"+oMsQtd:aheader[_w][2]//ZF_TAM"+StrZero(_w,3)
						Replace &(_campo) with oMsQtd:ACOLS[_i,_w]
					Next
				MsUnlock()
			Else
				RecLock("SZF",.F.)
					DbDelete()
				MsUnLock()
			Endif
		Else         
			If _tem > 0
				If oMSNewGe1:aCols[_tem,len(oMSNewGe1:aHeader)+1] = .F.
					RecLock("SZF",.T.)
						Replace ZF_FILIAL	with xfilial("SZF")
						Replace ZF_PRODUTO 	with cProduto
						Replace ZF_COMP		with oMsQtd:aCols[_i,len(oMsQtd:aHeader)-1]
						Replace ZF_COR		with oMsQtd:aCols[_i,1]
						Replace ZF_REVISAO	with cRevisao
						Replace ZF_INDICE		with oMsQtd:aCols[_i,Len(oMsQtd:aHeader)]
				  		For _w := 3 to Len(oMsQtd:aHeader)-2
							_campo := "SZF->"+oMsQtd:aheader[_w][2]//ZF_TAM"+StrZero(_w,3)
							Replace &(_campo) with oMsQtd:ACOLS[_i,_w]
						Next
					MsUnlock()
				Endif
			Else
				MsgAlert("N„o encontrado 2.")
			EndIf
		Endif
	Endif
Next

If alltrim(oMSNewGe1:aCols[oMSNewGe1:nAT,1]) <> ""
	DbselectArea("SB4")
	DbSetOrder(1)
	DbSeek(xfilial("SB4")+alltrim(oMSNewGe1:aCols[oMSNewGe1:nAT,1]))
	cColunx 		:= SB4->B4_COLUNA
	
	DbSelectArea("SB1")
	DbSetOrder(1)
	DbSeek(xfilial("SB1")+alltrim(SB4->B4_COD))
	
	aCor := {}
	While !EOF() .and. SubStr(B1_COD,1,8) == SubStr(SB4->B4_COD,1,8)
	
		_tem := ASCAN(aCor, {|x| x == SubStr(SB1->B1_COD,9,5)})
		
		If _tem == 0
			aadd(aCor, SubStr(SB1->B1_COD,9,5))
		Endif
		DbSelectArea("SB1")
		DbSkip()
	End
	
	For _w := 1 to len(aCor)
		cCor += aCor[_w]+"|"	
	Next
//	If len(alltrim(ccor)) > 100 
//		cCor := ""			
//	Endif	
Endif

If alltrim(oMSNewGe1:aCols[oMSNewGe1:nAT,1]) <> ""
	oMSCor:aCols := {}
	oMSCor:Refresh()

	DbSelectArea("SZD")
	DbSetOrder(1)
	DbSeek(xfilial("SZD")+alltrim(cProduto))

	While !EOF() .and. alltrim(SZD->ZD_PRODUTO) == alltrim(cProduto)

		DbSelectArea("SZG")
		DbSetOrder(2)
		DbSeek(xfilial("SZG")+SubStr(cProduto,1,15)+cRevisao+PADR(oMSNewGe1:aCols[oMSNewGe1:nAT,1],15)+oMSNewGe1:aCols[oMSNewGe1:nAT,6]+SZD->ZD_COR)
	
		IF Found()
			Aadd(oMSCor:aCols, {SZG->ZG_COR,SZG->ZG_CORNV,SZG->ZG_COMP,SZG->ZG_LOCALIZ,SZG->ZG_INDICE,.F.})
		Else
			Aadd(oMSCor:aCols, {SZD->ZD_COR,SPACE(5),oMSNewGe1:aCols[oMSNewGe1:nAT,1],SPACE(50),oMSNewGe1:aCols[oMSNewGe1:nAT,6],.F.})
		Endif
		DbSelectArea("SZD")
		DbSkip()
	End

	oMSTam:aCols := {}
	oMSTam:Refresh()

	_ac := {}

	DbSelectArea("SB1")
	DbSetOrder(1)
	DbSeek(xfilial("SB1")+SubStr(cProduto,1,8))
	oMSTam:aCols := {}

	While !EOF() .and. SubStr(B1_COD,1,8) == SubStr(cProduto,1,8)
		_tem := ASCAN( oMSTam:aCols, {|x| Alltrim(x[2]) == SubStr(SB1->B1_COD,14,2)})
		If _tem == 0
			DbSelectArea("SZK")
			DbSetOrder(2)
			If DbSeek(xfilial("SZK")+SubStr(cProduto,1,15)+cRevisao+padr(oMSNewGe1:aCols[oMSNewGe1:nAT,1],15)+oMSNewGe1:aCols[oMSNewGe1:nAT,6]+SubStr(SB1->B1_COD,14,2))
			//IF Found()
				While !EOF() .and. AllTrim(ZK_INDICE) == AllTrim(oMSNewGe1:aCols[oMSNewGe1:nAT,6]) .and. alltrim(ZK_PRODUTO) == alltrim(cProduto) .and. alltrim(ZK_COMP) == alltrim(oMSNewGe1:aCols[oMSNewGe1:nAT,1]) .and. alltrim(ZK_REVISAO) == cRevisao
					Aadd(_aC, {0,SZK->ZK_TAM,SZK->ZK_TAMNV,SZK->ZK_COMP,SZK->ZK_INDICE,.F.})
					DbSelectArea("SZK")
					DbSkip()
				End
			Else
				Aadd(_aC, {0,SubStr(SB1->B1_COD,14,2),"    ",oMSNewGe1:aCols[oMSNewGe1:nAT,1],oMSNewGe1:aCols[oMSNewGe1:nAT,6],.F.})
			Endif
		Endif

		DbSelectArea("SB1")
		DbSkip()
	End

	if Len(_ac) > 0
		cQuery  := "SELECT BV_FILIAL, BV_TABELA, BV_CHAVE, BV_DESCRI FROM " +RetSQLName("SBV") + " WHERE "
		cQuery  += "BV_FILIAL = '" +xFilial("SBV") +"' AND BV_TABELA = '" +cColuna+ "' AND D_E_L_E_T_ = '' " 
		cQuery += "ORDER BY R_E_C_N_O_"
		
		cQuery := ChangeQuery(cQuery)
		If Select("TMPSBV") > 0 
     	 	TMPSBV->(DbCloseArea()) 
	 	EndIf 
		dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TMPSBV",.T.,.T.)

		For nX:= 1 to len(_ac)
			DbSelectArea("TMPSBV")
			DbGoTop()
			_w := 0
			While !EOF()
				_w++
				If alltrim(TMPSBV->BV_CHAVE) == alltrim(_ac[nX,2])
					_ac[nX,1] := _w
				Endif		
				DbSkip()
			End
		
		Next
		DbSelectArea("TMPSBV")
		DbCloseArea()
	
		ASORT(_ac, , , { |x,y| x[1] < y[1] } )
	
		For nX:=1 to len(_ac)
			If ASCAN( oMSTam:aCols, {|x| alltrim(x[1]) == alltrim(_ac[nX,2])})=0
				Aadd(oMSTam:aCols, {_ac[nX,2],_ac[nX,3],_ac[nX,4],_ac[nX,5],.F.})
			Endif	
		Next	
	Endif

	oMSQtd:aCols := {}
	oMSQtd:Refresh()
	
	DbSelectArea("SZD")
	DbSetOrder(1)
	DbSeek(xfilial("SZD")+alltrim(cProduto))
	oMSQtd:aCols := {}
	
	While !EOF() .and. alltrim(SZD->ZD_PRODUTO) == alltrim(cProduto)    

		DbSelectArea("SZF")
		DbSetOrder(2)
		DbSeek(xfilial("SZF")+SubStr(cProduto,1,15)+cRevisao+oMSNewGe1:aCols[oMSNewGe1:nAT,1]+oMSNewGe1:aCols[oMSNewGe1:nAT,6]+SZD->ZD_COR)
	
		IF Found()
			aFieldFill := {}
  			Aadd(aFieldFill, SZF->ZF_COR)
			Aadd(aFieldFill,POSICIONE("SBV",1,xFilial("SBV")+'COR'+SZF->ZF_COR,"BV_DESCRI")) 

			For nX := 3 to Len(oMsQtd:aHeader)-2
				_campo := "SZF->"+oMsQtd:aheader[nX][2]//ZF_TAM"+StrZero(nX,3)
	  			Aadd(aFieldFill,&_campo)
  			Next
  			Aadd(aFieldFill, SZF->ZF_COMP)
  			Aadd(aFieldFill, SZF->ZF_INDICE)
  			Aadd(aFieldFill, .F.)
  			Aadd(oMsQtd:aCols, aFieldFill)
		Else
			aFieldFill := {}
  			Aadd(aFieldFill, SZD->ZD_COR)
			Aadd(aFieldFill,POSICIONE("SBV",1,xFilial("SBV")+'COR'+SZD->ZD_COR,"BV_DESCRI"))
			
			For nX := 3 to Len(oMsQtd:aHeader)-2
	  			Aadd(aFieldFill,0)
  			Next
  			Aadd(aFieldFill, oMSNewGe1:aCols[oMSNewGe1:nAT,1])
  			Aadd(aFieldFill, oMSNewGe1:aCols[oMSNewGe1:nAT,6])
  			Aadd(aFieldFill, .F.)
  			Aadd(oMsQtd:aCols, aFieldFill)
		Endif
		
		DbSelectArea("SZD")
		DbSkip()
    End
Else
	oMSCor:aCols := {}
	oMSCor:Refresh()

	DbSelectArea("SZD")
	DbSetOrder(1)
	DbSeek(xfilial("SZD")+alltrim(cProduto))

	While !EOF() .and. alltrim(SZD->ZD_PRODUTO) == alltrim(cProduto)
		Aadd(oMSCor:aCols, {SZD->ZD_COR,"   ",space(15),Space(50),Space(3),,.F.})

		DbSelectArea("SZD")
		DbSkip()
	End
	oMSCor:Refresh()

	oMSTam:aCols := {}
	oMSTam:Refresh()

	DbSelectArea("SB1")
	DbSetOrder(1)
	DbSeek(xfilial("SB1")+SubStr(cProduto,1,8))

	While !EOF() .and. SubStr(B1_COD,1,8) == SubStr(cProduto,1,8)
		_tem := ASCAN( oMSTam:aCols, {|x| Alltrim(x[1]) == SubStr(SB1->B1_COD,14,2)})
		If _tem == 0
			Aadd(oMSTam:aCols, {SubStr(SB1->B1_COD,14,2),"    ",oMSNewGe1:aCols[oMSNewGe1:nAT,1],oMSNewGe1:aCols[oMSNewGe1:nAT,6],.F.})
		Endif

		DbSelectArea("SB1")
		DbSkip()
	End

	oMSTam:Refresh()

	oMSQtd:aCols := {}
	oMSQtd:Refresh()

	DbSelectArea("SZD")
	DbSetOrder(1)
	DbSeek(xfilial("SZD")+alltrim(cProduto))

	While !EOF() .and. alltrim(SZD->ZD_PRODUTO) == alltrim(cProduto)
		aFieldFill := {}
  		Aadd(aFieldFill, SZD->ZD_COR)
		Aadd(aFieldFill,POSICIONE("SBV",1,xFilial("SBV")+'COR'+SZD->ZD_COR,"BV_DESCRI"))
		
		For nX := 3 to Len(oMsQtd:aHeader)-2
			Aadd(aFieldFill,0)
  		Next
  		Aadd(aFieldFill, oMSNewGe1:aCols[oMSNewGe1:nAT,1])
  		Aadd(aFieldFill, oMSNewGe1:aCols[oMSNewGe1:nAT,6])
//  		Aadd(aFieldFill, Space(15))
  		Aadd(aFieldFill, .F.)
  		Aadd(oMsQtd:aCols, aFieldFill)

		DbSelectArea("SZD")
		DbSkip()
	End
	oMSQtd:Refresh()

Endif

oMSCor:Refresh()
oMsQtd:Refresh()
oMsTam:Refresh()
Return


user Function cadEst(_cod)
// Cadastra produto de Corte para usar na estrutura de produtos

	DbSelectArea("SB4")
	DbSetOrder(1)
	DbSeek(xfilial("SB4")+PADR(SubStr(_cod,1,8),15))
	_desc := SB4->B4_DESC
	
	DbSeek(xfilial("SB4")+PADR(SubStr(_cod,1,6)+"P1",15))

	If !Found()
//		EMail(PADR(SubStr(_cod,1,6)+"P1",15))
		RecLock("SB4",.T.)
		Replace B4_FILIAL 		with xfilial("SB4")
		Replace B4_COD			with PADR(SubStr(_cod,1,6)+"P1",15)
		Replace B4_TIPO			with "PI"
		Replace B4_LOCPAD		with "01"
		Replace B4_GRUPO		with "1320"
		Replace B4_DESC			with "P1-"+_desc
		Replace B4_MSBLQL		WITH "2"
		Replace B4_UM			with "UN"
		Replace B4_POSIPI		With "60041092"
		Replace B4_YORIGEM		with "0"
		Replace B4_ORIGEM		with "0"
		Replace B4_CLASFIS		with "00"
		Replace B4_RASTRO		with "N"
		Replace B4_LINHA		with "COR"
		Replace B4_COLUNA		with ccoluna
		MsUnLock()
	Endif

//	DbSelectArea("SB4")
//	DbSetOrder(1)
//	DbSeek(xfilial("SB4")+PADR(SubStr(_cod,1,8),15))
//	DbSeek(xfilial("SB4")+PADR(SubStr(_cod,1,6)+"P2",15))

//	If !Found()
//		EMail(PADR(SubStr(_cod,1,6)+"P2",15))
//		RecLock("SB4",.T.)
//		Replace B4_FILIAL 		with xfilial("SB4")
//		Replace B4_COD			with PADR(SubStr(_cod,1,6)+"P2",15)
//		Replace B4_TIPO			with "MI"
//		Replace B4_LOCPAD		with "01"
//		Replace B4_GRUPO		with "1320"
//		Replace B4_DESC			with "P2-"+_desc
//		Replace B4_UM			with "UN"
//		Replace B4_POSIPI		With "60041092"
//		Replace B4_YORIGEM		with "0"
//		Replace B4_MSBLQL		WITH "2"
//		Replace B4_ORIGEM		with "0"
//		Replace B4_CLASFIS		with "00"
//		Replace B4_RASTRO		with "N"
//		Replace B4_LINHA		with "COR"
//		Replace B4_COLUNA		with ccoluna
//		MsUnLock()
//	Endif


//DbSelectArea("SB1")
//DbSetOrder(1)
//DbSeek(xfilial("SB1")+PADR(SubStr(_cod,1,15),15))
//_desc := SB1->B1_DESC
//DbSeek(xfilial("SB1")+PADR(SubStr(_cod,1,6)+"P2"+Subst(_cod,9,7),15))

//If !Found()
//	RecLock("SB1",.T.)
//		Replace B1_FILIAL		with xfilial("SB1")
//		Replace B1_COD 			with SubStr(_cod,1,6)+"P2"+Subst(_cod,9,7)
//		Replace B1_TIPO			with "PI"
//		Replace B1_LOCPAD		with "01"
//		Replace B1_ORIGEM		with "0"
//		Replace B1_GRUPO		with "1320"
//		Replace B1_DESC			with "P2-"+_desc
//		Replace B1_UM			with "UN"
//		Replace B1_POSIPI		With "60041092"
//		Replace B1_CLASFIS		with "00"
//		Replace B1_RASTRO		with "N"
//		REPLACE B1_MSBLQL		WITH "2"
//		Replace B1_GRADE		with "S"
//		Replace B1_CONTA		with "11205001002"
//		Replace B1_REVATU		with "001"
//	MsUnLock()
/*	
	_area1 := GetArea()
    DbSelectArea("CTD")
	dbSetOrder(1)
	Dbseek(xFilial("CTD")+"P"+SB1->B1_COD)

	If !Found()
		RecLock("CTD",.T.)
			CTD_FILIAL	:= xFilial("CTD")					//Filial		
			CTD_ITEM	:= "P"+SB1->B1_COD			 		//Item Conta		
			CTD_CLASSE	:= '2'								//Classe				1=Sintetico;2=Analitico
			CTD_NORMAL	:= '1'								//Cond Normal			0=Nenhum;1=Despesa;2=Receita
			CTD_DESC01	:= SB1->B1_DESC						//Desc Moeda 1		
			CTD_BLOQ	:= "2"								//Item Bloq				1=Bloqueado;2=N√£o Bloqueado
			CTD_DTEXIS	:= cToD("01/01/2000")				//Dt Ini Exist		
		MsUnLock()
	Endif
	
	RestArea(_area1)
Endif
*/
DbSelectArea("SB1")
DbSetOrder(1)
DbSeek(xfilial("SB1")+PADR(SubStr(_cod,1,6)+"00"+Subst(_cod,9,7),15))
_desc := SB1->B1_DESC

DbSelectArea("SB1")
DbSetOrder(1)
DbSeek(xfilial("SB1")+PADR(SubStr(_cod,1,6)+"P1"+Subst(_cod,9,7),15))

If !Found()
	RecLock("SB1",.T.)
		Replace B1_FILIAL		with xfilial("SB1")
		Replace B1_COD 			with SubStr(_cod,1,6)+"P1"+Subst(_cod,9,7)
		Replace B1_TIPO			with "PI"
		Replace B1_LOCPAD		with "01"
		Replace B1_ORIGEM		with "0"
		Replace B1_GRUPO		with "1320"
		Replace B1_DESC			with "P1-"+_desc
		Replace B1_UM			with "UN"
		Replace B1_POSIPI		With "60041092"
		Replace B1_MSBLQL		with "2"
		Replace B1_CLASFIS		with "00"
		Replace B1_RASTRO		with "N"
		Replace B1_GRADE		with "S"
		Replace B1_CONTA		with "11205001002"
		Replace B1_REVATU		with "001"
	MsUnLock()
/*
	_area1 := GetArea()
    DbSelectArea("CTD")
	dbSetOrder(1)
	Dbseek(xFilial("CTD")+"P"+SB1->B1_COD)

	If !Found()
		RecLock("CTD",.T.)
			CTD_FILIAL	:= xFilial("CTD")					//Filial		
			CTD_ITEM	:= "P"+SB1->B1_COD			 		//Item Conta		
			CTD_CLASSE	:= '2'								//Classe				1=Sintetico;2=Analitico
			CTD_NORMAL	:= '1'								//Cond Normal			0=Nenhum;1=Despesa;2=Receita
			CTD_DESC01	:= SB1->B1_DESC						//Desc Moeda 1		
			CTD_BLOQ	:= "2"								//Item Bloq				1=Bloqueado;2=N√£o Bloqueado
			CTD_DTEXIS	:= cToD("01/01/2000")				//Dt Ini Exist		
		MsUnLock()
	Endif
	
	RestArea(_area1)
*/
Endif


Return(SubStr(_cod,1,6)+"P1"+SubStr(_cod,9,7))


user Function EstSup(_oldprod,_nwprod)
//Cadastra estrutura de produto para produto de Corte

DbSelectArea("SG1")
DbSetOrder(6)
DbSeek(xfilial("SG1")+PADR(_oldprod,15)+PADR(SubStr(_nwprod,1,6)+"P1"+SubStr(_nwprod,9,7),15)+"   "+cRevisao)
					
If !Found()
	RecLock("SG1",.T.)
		Replace G1_FILIAL		with xfilial("SG1")
		Replace G1_COD			with _oldprod
		Replace G1_COMP			with SubStr(_nwprod,1,6)+"P1"+SubStr(_nwprod,9,7)
		Replace G1_QUANT		with 1
		Replace G1_INI			with ddatabase
		Replace G1_FIM			with ctod("31/12/2049")
		Replace G1_NIV			with "01"
		Replace G1_NIVINV		with "99"
		Replace G1_REVINI		with cRevisao
		Replace G1_REVFIM		with cRevisao
	MsUnLock()
Endif

//DbSelectArea("SG1")
//DbSetOrder(6)
//DbSeek(xfilial("SG1")+PADR(SubStr(_nwprod,1,6)+"P2"+SubStr(_nwprod,9,7),15)+PADR(_nwprod,15)+"   "+cRevisao)
					
//If !Found()
//	RecLock("SG1",.T.)
//		Replace G1_FILIAL		with xfilial("SG1")
//		Replace G1_COD			with SubStr(_nwprod,1,6)+"P2"+SubStr(_nwprod,9,7)
//		Replace G1_COMP			with _nwprod
//		Replace G1_QUANT		with 1
//		Replace G1_INI			with ddatabase
//		Replace G1_FIM			with ctod("31/12/2049")
//		Replace G1_NIV			with "02"
//		Replace G1_NIVINV		with "98"
//		Replace G1_REVINI		with cRevisao
//		Replace G1_REVFIM		with cRevisao
//	MsUnLock()
//Endif

DbSelectArea("SG1")
DbSetOrder(6)
//DbSeek(xfilial("SG1")+PADR(SubStr(_nwprod,1,6)+"P1"+SubStr(_nwprod,9,7),15)+PADR("BENEFCOSTURA",15)+"   "+cRevisao)
DbSeek(xfilial("SG1")+PADR(_oldprod,15)+PADR("BENEFCOSTURA",15)+"   "+cRevisao)
					
If !Found()
	RecLock("SG1",.T.)
		Replace G1_FILIAL		with xfilial("SG1")
		//Replace G1_COD			with SubStr(_nwprod,1,6)+"P1"+SubStr(_nwprod,9,7)
		Replace G1_COD			with _oldprod //SubStr(_nwprod,1,8)+SubStr(_nwprod,9,7)
		Replace G1_COMP			with "BENEFCOSTURA"
		Replace G1_QUANT		with 1
		Replace G1_INI			with ddatabase
		Replace G1_FIM			with ctod("31/12/2049")
		Replace G1_NIV			with "02"
		Replace G1_NIVINV		with "98"
		Replace G1_REVINI		with cRevisao
		Replace G1_REVFIM		with cRevisao
	MsUnLock()
Endif

//DbSelectArea("SG1")
//DbSetOrder(6)
//DbSeek(xfilial("SG1")+PADR(_oldprod,15)+PADR("SERVPRESUN001TT",15)+"   "+cRevisao)
					
//If !Found()
//	RecLock("SG1",.T.)
//		Replace G1_FILIAL		with xfilial("SG1")
//		Replace G1_COD			with _oldprod //SubStr(_nwprod,1,8)+SubStr(_nwprod,9,7)
//		Replace G1_COMP			with "SERVPRESUN001TT"
//		Replace G1_QUANT		with 1
//		Replace G1_INI			with ddatabase
//		Replace G1_FIM			with ctod("31/12/2049")
//		Replace G1_NIV			with "02"
//		Replace G1_NIVINV		with "98"
//		Replace G1_REVINI		with cRevisao
//		Replace G1_REVFIM		with cRevisao
//	MsUnLock()
//Endif
   
Return()


Static Function ReplyCor()
// Replica a cor para acols de cor

Local nX
Local nX2

If MsgYesNo("Ser„o replicadas as informaÁıes da Cor: "+oMSCor:aCols[oMSCor:nat,1]+" para as outras cores?")
  	For nX := 1 to len(oMSCor:aCols)
	   If nX <> oMSCor:nat 
   			oMSCor:aCols[nX,2] := oMSCor:aCols[oMSCor:nat,2]
    	Endif
  	Next nX
End

oMsCor:refresh() 

Return

Static Function LimpaCor()
// Replica tamanhos para cols de tamanho

	Local nX
	Local nX2

	If MsgYesNo("Deseja limpar a estrutura da cor "+oMSQtd:aCols[oMSQtd:nat,1]+" para o componente "+oMsQtd:aCols[oMsQtd:nat,len(oMsQtd:aHeader)-1]+"?")


		If oMSNewGE1:aCols[oMSNewGE1:nat,5] <> "S"
			_qry := "update "+RetSqlName("SG1'")+" set D_E_L_E_T_ = '*', R_E_C_D_E_L_ = R_E_C_N_O_ where D_E_L_E_T_ = '' and "
			_qry += "G1_FILIAL = '"+xfilial("SG1")+"' and left(G1_COD,11) = '"+SubStr(CProduto,1,6)+oMsQtd:aCols[oMsQtd:nat,1]+"' and "
			_qry += "left(G1_COMP,8) = '"+alltrim(oMsQtd:aCols[oMsQtd:nat,len(oMsQtd:aHeader)-1])+"' and G1_REVINI = '"+cRevisao+"' "
		Else
			_qry := "update "+RetSqlName("SG1'")+" set D_E_L_E_T_ = '*', R_E_C_D_E_L_ = R_E_C_N_O_ where D_E_L_E_T_ = '' and "
			_qry += "G1_FILIAL = '"+xfilial("SG1")+"' and (left(G1_COD,11) = '"+Substr(SubStr(CProduto,1,6)+"P1"+oMsQtd:aCols[oMsQtd:nat,1],1,11)+"' or left(G1_COD,11) = '"+SubStr(SubStr(CProduto,1,6)+"P2"+oMsQtd:aCols[oMsQtd:nat,1],1,11)+"') and "
			_qry += "left(G1_COMP,8) = '"+alltrim(oMsQtd:aCols[oMsQtd:nat,len(oMsQtd:aHeader)-1])+"' and G1_REVINI = '"+cRevisao+"' "
		Endif
		
		MemoWrite("HESTP001_limpacor.txt",_Qry)
		TcSqlExec(_qry)
		
		If MsgYesNo("Deseja limpar a cor: "+oMSQtd:aCols[oMSQtd:nat,1]+" para TODOS os tamanhos?")
			For nX := 3 to len(oMsQtd:aHeader)-2
				oMSQtd:aCols[oMSQtd:nat,nX] := 0
			Next nX
		End
		oMsQtd:refresh()
	Endif

Return
Static Function ReplyTam()
// Replica tamanhos para cols de tamanho

Local nX
Local nX2

If MsgYesNo("Ser„o replicadas as informaÁıes do Tamanho: "+oMSTam:aCols[oMSTam:nat,1]+" para os outros tamanhos?")
  	For nX := 1 to len(oMSTam:aCols)
	   If nX <> oMSTam:nat 
   			oMSTam:aCols[nX,2] := oMSTam:aCols[oMSTam:nat,2]
    	Endif
  	Next nX
End

oMsTam:refresh() 

Return

Static Function ReplyQtdLn()
// Replica as quantidades por linha

Local nX
Local nX2

If MsgYesNo("Ser„o replicadas as informaÁıes da Cor: "+oMSQtd:aCols[oMSQtd:nat,1]+" para as outras cores?")
  	For nX := 1 to len(oMSQtd:aCols)
  		for nX2 := 3 to len(oMSQtd:aCols[oMSQtd:nat])-1
		   If nX <> oMSQtd:nat .and. !AllTrim(Str(nX2)) $ "1" 
    			oMSQtd:aCols[nX,nX2] := oMSQtd:aCols[oMSQtd:nat,nX2]
	    	Endif
	   Next nX2
  	Next nX
End  

oMsQtd:refresh() 

Return

Static Function ReplyQtdCl()
// Copia as quatidades para as colunas

Local nX
Local nX2

If MsgYesNo("Ser„o replicadas as informaÁıes do Tamanho: "+oMSQtd:aCols[oMSQtd:nat,1]+" para outros Tamanhos?")
	for nX2 := omsqtd:obrowse:colpos+1 to len(oMSQtd:aCols[oMSQtd:nat])-3 //3
	   If nX <> oMSQtd:nat 
   			oMSQtd:aCols[oMSQtd:nat,nX2] := oMSQtd:aCols[oMSQtd:nat,omsqtd:obrowse:colpos] //2
    	Endif
   Next nX2
End  

oMsQtd:refresh() 

Return
/*
Static Function ChecaCor()
// Rotina para cadastro de Estrutura automaticamente com base em cor j· existente

Local i      
	DbSelectArea("SB1")
	DbSetOrder(1)
	DbSeek(xfilial("SB1")+alltrim(cProduto))
	
	While !EOF() .and. SubStr(cProduto,1,8) == SubStr(SB1->B1_COD,1,8)
		DbSelectArea("SZE")
		DbSetOrder(1)
		DbSeek(xfilial("SZE")+SubStr(cProduto,1,15)+cRevisao)
		
		If Found()
			DbSelectArea("SZG")
			DbSetOrder(1)
			DbSeek(xfilial("SZG")+SubStr(cProduto,1,15)+cRevisao+SZG->ZG_COMP+SubStr(SB1->B1_COD,9,3))
		
			If !Found()
				IF MsgYesNo("Cor "+SubStr(SB1->B1_COD,9,3)+" n„o tem estrutura cadastrada. Deseja copiar de outra cor?")
					Pergunte("CORNV",.T.)
					DbSelectArea("SZE")
					DbSetOrder(1)
					DbSeek(xfilial("SZE")+SubStr(cProduto,1,15)+cRevisao)
					While !EOF() .and. SubStr(cProduto,1,8) = SubStr(SZE->ZE_PRODUTO,1,8) .and. SZE->ZE_REVISAO = cRevisao
						DbSelectArea("SZG")
						DbSetOrder(1)
						DbSeek(xfilial("SZG")+SZE->ZE_PRODUTO+cRevisao+SZE->ZE_COMP+MV_PAR01)
						_cor := SZG->ZG_CORNV
						RecLock("SZG",.T.)
							Replace ZG_FILIAL		with xfilial("SZG")
							Replace ZG_PRODUTO		with SZE->ZE_PRODUTO
							Replace ZG_COMP			with SZE->ZE_COMP
							Replace ZG_COR			with SubStr(SB1->B1_COD,9,5)
							Replace ZG_CORNV		with _cor
							Replace ZG_REVISAO		with cRevisao
						MsUnLock()
						
						DbSelectarea("SZF")
						DbSetOrder(1)
						DbSeek(xfilial("SZF")+SZE->ZE_PRODUTO+cRevisao+SZE->ZE_COMP+MV_PAR01)
						_atam := {}
						For i := 1 to 200
							_campo := "SZF->ZF_TAM"+strzero(i,3)
							Aadd(_atam,&_campo)
						Next
						
						RecLock("SZF",.T.)
							Replace ZF_FILIAL	with xfilial("SZF")
							Replace ZF_PRODUTO 	with SZE->ZE_PRODUTO
							Replace ZF_COMP		with SZE->ZE_COM
							Replace ZF_COR		with SubStr(SB1->B1_COD,9,5)
							Replace ZF_REVISAO	with cRevisao
						  	For i := 1 to 200
								_campo := "SZF->ZF_TAM"+StrZero(_w,3)
								Replace &(_campo) with _atam[i]
							Next
						MsUnLock()
						DbSelectArea("SZE")
						DbSkip()
					End
				Endif			
			Endif
		Endif
		
		DbSelectArea("SB1")
		DbSkip()
	End

Return
*/

User Function VldCor(_cor,_n)

Local aAux := aClone(oMSGrade:aCols)
Local lRet := .T.
Local _i

lRet	:= .T.//U_ExistCod(2,_cor)	

For _i:=1 to len(oMSGrade:aCols)
	If alltrim(_cor) == alltrim(oMSGrade:aCols[_i,1]) .and. _i <> _n
		Alert("A COR j· foi incluida no produto, selecione outra COR.")
		lRet := .F.
		Return(lRet)
	Endif
Next
/*
DbSelectArea("SBV")
DbSetOrder(1)
If DbSeek(xFilial("SBV")+"COR"+_cor)
	aAux[_n,2] := SBV->BV_DESCRI
	oMsGrade:SetArray(aAux,.T.) 
	oMsGrade:Refresh()
EndIf
*/
Return(lRet)

User Function ExistCod(nCod,cCod)
// Rotina para preenchimento dos campos de descriÁ„o

If nCod==1   // validaÁ„o do NCM
		
		If !Empty(cCod)
			cQuery  := " SELECT COUNT(R_E_C_N_O_) AS COUNT FROM "+RetSQLName("SYD") 
			cQuery  += " WHERE D_E_L_E_T_ = '' AND YD_TEC='"+Alltrim(cCod)+"'"
			
			If Select("VLDDB") > 0 
	     	 	VLDDB->(DbCloseArea())
		 	EndIf 
			dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"VLDDB",.T.,.T.)
			
			If VLDDB->COUNT==0
				Alert("O Codigo de NCM/POS.IPI Digitado n„o existe no cadastro.")
				oPosIPI:SetFocus()
			End
			
			VLDDB->(DbCloseArea())
        EndIf
ElseIf nCod==2  //validaÁ„o de cor

	lRet 	:= .T.
	If TYPE("cLinha")<>"U" 
		cLinha	:= If (cLinha<>"COR","COR",cLinha)
	Else
		cLinha	:= "COR"
	End
	
	cQuery  := " SELECT COUNT(R_E_C_N_O_) AS COUNT FROM "+RetSQLName("SBV")
	cQuery  += CRLF + " WHERE BV_FILIAL = '"+xFilial("SBV")+"' AND BV_TABELA = '"+cLinha+"' 
	cQuery  += CRLF + " AND D_E_L_E_T_ = '' AND BV_CHAVE='"+cCod+"'"
	
	MemoWrite("TCESTF001_ExistCod_2.txt",cQuery)
		
	If Select("VLDDB") > 0 
	 	VLDDB->(DbCloseArea())
	EndIf 
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"VLDDB",.T.,.T.)
			
	If VLDDB->COUNT==0
		Alert("A COR selecionada n„o existe no cadastro.")
		lRet := .F.
	End
		
	VLDDB->(DbCloseArea())	
	
	Return(lRet)

ElseIf nCod==3  //validaÁ„o de Tamanho

	lRet := .T.
	
	cQuery  := " SELECT COUNT(R_E_C_N_O_) AS COUNT FROM "+RetSQLName("SBV") 
	cQuery  += " WHERE BV_FILIAL = '"+xFilial("SBV")+"' AND BV_TABELA = '"+ccoluna+"' 
	cQuery  += " AND D_E_L_E_T_ = ''  AND BV_CHAVE='"+cCod+"'" 
	
	MemoWrite("TCESTF001_ExistCod_3.txt",cQuery)
	
	If Select("VLDDB") > 0 
	 	VLDDB->(DbCloseArea())
	EndIf 
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"VLDDB",.T.,.T.)
			
	If VLDDB->COUNT==0
		Alert("O Tamanho Selecionado n„o existe no cadastro.")
		lRet := .F.
	End
		
	VLDDB->(DbCloseArea())	
	
	Return(lRet)

ElseIf nCod==4  //Valida Status
	//"U_ExistCod(4,M->ZL_STATUS)"

	lRet := .T.
	
	cQuery  := " SELECT COUNT(R_E_C_N_O_) AS COUNT FROM "+RetSQLName("ZA8")
	cQuery  += " WHERE D_E_L_E_T_ = '' AND ZA8_FILIAL = '"+xFilial("ZA8")+"' AND ZA8_CODIGO='"+cCod+"'" 
			
	If Select("VLDDB") > 0 
	 	VLDDB->(DbCloseArea())
	EndIf 
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"VLDDB",.T.,.T.)
			
	If VLDDB->COUNT==0
		Alert("O codigo selecionado n„o existe no cadastro.")
		lRet := .F.
	End
		
	VLDDB->(DbCloseArea())	
	
	Return(lRet)
		
End

Return

Static Function AjuSX1(cPerg)

Local aAreaAtu	:= GetArea()
Local aAreaSX1	:= SX1->( GetArea() )

PutSx1(cPerg,"01","Status de Produtos","Status de Produtos","Status de Produtos","Mv_ch1","C",99,0,0,"G","U_HE001TP()",   "","","N","Mv_par01","","","","","","","","","","","","","","","","","","","","","","","",{"Selecione os status de produtos.",""},{""},{""},"")
PutSx1("HESTC1","01","Tipo","Tipo","Tipo","Mv_ch1","C",10,0,0,"G","",   "","","N","Mv_par01","","","","","","","","","","","","","","","","","","","","","","","",{"Selecione o Tipo.",""},{""},{""},"")

RestArea( aAreaSX1 )
RestArea( aAreaAtu )

Return(cPerg)

User Function HE001TP(l1Elem,lTipoRet)

Local MvPar
Local aArea  := GetArea()
Local cTitulo := ""                     
Local lRet  := .T.
Local aBox  := {}                        
Local nTam  := 4
Local MvParDef := ""

MvPar:=&(Alltrim(ReadVar()))   // Carrega Nome da Variavel do Get em Questao
mvRet:=Alltrim(ReadVar())    // Iguala Nome da Variavel ao Nome variavel de Retorno

dbSelectArea("ZA8")
DbSetOrder(1)
DbGoTop()
cTitulo := "Status de Produtos"
While !Eof()
   Aadd(aBox,ZA8->ZA8_CODIGO + " - " + Alltrim(ZA8->ZA8_DESCRI))
   MvParDef += SubStr(ZA8->ZA8_CODIGO,1,4)
   dbSkip()
EndDo

If f_Opcoes( @MvPar,;  // uVarRet
      cTitulo,;  // cTitulo
      @aBox,;   // aOpcoes
      MvParDef,;  // cOpcoes
      ,;    // nLin1
      ,;    // nCol1
      ,;    // l1Elem
      nTam,;    // nTam
      Len( aBox ),; // nElemRet
      ,;    // lMultSelect
      ,;    // lComboBox
      ,;    // cCampo
      ,;    // lNotOrdena
      ,;    // NotPesq
      ,;   // ForceRetArr
       )    // F3
       
  	&MvRet := mvpar                                                                          // Devolve Resultado
EndIF

RestArea(aArea)

Return lRet

User Function HE001OC(l1Elem,lTipoRet)

Local MvPar
Local aArea  := GetArea()
Local cTitulo := ""                     
Local lRet  := .T.
Local aBox  := {}                        
Local nTam  := 6
Local MvParDef := ""
Public hocasiao := ""

MvPar:=&(Alltrim(ReadVar()))   // Carrega Nome da Variavel do Get em Questao
mvRet:=Alltrim(ReadVar())    // Iguala Nome da Variavel ao Nome variavel de Retorno

dbSelectArea("ZAD")
DbSetOrder(1)
DbGoTop()
cTitulo := "Ocasiao"
While !Eof()
   Aadd(aBox,ZAD->ZAD_CODIGO + "- " + Alltrim(ZAD->ZAD_DESCRI))
   MvParDef += SubStr(ZAD->ZAD_CODIGO,1,5)+"-"
   dbSkip()
EndDo

If f_Opcoes( @MvPar,;  // uVarRet
      cTitulo,;  // cTitulo
      @aBox,;   // aOpcoes
      MvParDef,;  // cOpcoes
      ,;    // nLin1
      ,;    // nCol1
      ,;    // l1Elem
      nTam,;    // nTam
      Len( aBox ),; // nElemRet
      ,;    // lMultSelect
      ,;    // lComboBox
      ,;    // cCampo
      ,;    // lNotOrdena
      ,;    // NotPesq
      ,;   // ForceRetArr
       )    // F3
       
  	&MvRet := mvpar                                                                          // Devolve Resultado
EndIF

hocasiao := mvpar

RestArea(aArea)

Return lRet


User function buscasb1()

Local oDlgSu9														// Tela
Local oLbx1                                                         // Listbox
Local nPosLbx  := 0                                                 // Posicao do List
Local aItems   := {}                                                // Array com os itens
Local nPos     := 0                                                 // Posicao no array
Local cAssunto := ""                                                // Descricao do Assunto
Local lRet     := .F.                                               // Retorno da funcao

CursorWait()     

Pergunte("DESCSB1",.T.)

	_qry := "Select B1_DESC, B1_COD from "+RetSqlName("SB1")+" SB1 "
	_qry += "where B1_MSBLQL <> '1' and SB1.D_E_L_E_T_ = '' and (B1_DESC like '%"+upper(alltrim(MV_PAR01))+"%' or B1_COD like '%"+upper(alltrim(MV_PAR01))+"%')  "
	
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,_qry),"XXX",.F.,.T.)
	DbSelectArea("XXX")
	DbGoTop()

	While !Eof() 
		Aadd(aItems,{XXX->B1_DESC,XXX->B1_COD})
		DbSkip()
	End       
	DbSelectArea("XXX")
	DbCloseArea()
CursorArrow()
	     
If Len(aItems) <= 0
	Alert("Produto n„o encontrado")
   Return(lRet)
Endif	
	
DEFINE MSDIALOG oDlgSu9 FROM  50,003 TO 260,500 TITLE "Cadastro de Produto" PIXEL  

	@ 03,10 LISTBOX oLbx1 VAR nPosLbx FIELDS HEADER ;
			"DescriÁ„o","CÛdigo";	//"Descricao"
			SIZE 233,80 OF oDlgSu9 PIXEL NOSCROLL //"Descricao","Ocorrencia","Prazo" 
	oLbx1:SetArray(aItems)
    oLbx1:bLine:={||{aItems[oLbx1:nAt,1],;
					 aItems[oLbx1:nAt,2]}}

    oLbx1:BlDblClick := {||(lRet:= .T.,nPos:= oLbx1:nAt, oDlgSu9:End())}
	oLbx1:Refresh()

	_xxcod := ""                                                                                    
	DEFINE SBUTTON FROM 88,105 TYPE 4 ENABLE OF oDlgSu9 ACTION (AxInclui("SB1"))
    DEFINE SBUTTON FROM 88,140 TYPE 15 ENABLE OF oDlgSu9 ACTION (u_cadsB1("V",aItems[oLbx1:nAt][2]))
    DEFINE SBUTTON FROM 88,175 TYPE 1 ENABLE OF oDlgSu9 ACTION (lRet:= .T.,nPos := oLbx1:nAt,oDlgSu9:End())
    DEFINE SBUTTON FROM 88,210 TYPE 2 ENABLE OF oDlgSu9 ACTION (lRet:= .F.,oDlgSu9:End())

ACTIVATE MSDIALOG oDlgSu9 CENTERED

If lRet
   DbSelectarea("SB1")
   DbSetorder(1)
   DbSeek(xFilial("SB1")+aItems[nPos][2])
Endif

Return(lRet) 


user function buscasa1()

Local oDlgSu9														// Tela
Local oLbx1                                                         // Listbox
Local nPosLbx  := 0                                                 // Posicao do List
Local aItems   := {}                                                // Array com os itens
Local nPos     := 0                                                 // Posicao no array
Local cAssunto := ""                                                // Descricao do Assunto
Local lRet     := .F.                                               // Retorno da funcao

CursorWait()     

Pergunte("DESCSA1",.T.)

	_qry := "Select A1_NOME, A1_NREDUZ, A1_COD, A1_CGC from "+RetSqlName("SA1")+" SA1 "
	_qry += "where A1_MSBLQL <> '1' and SA1.D_E_L_E_T_ = '' and (A1_NOME like '%"+upper(alltrim(MV_PAR01))+"%' or A1_COD like '%"+upper(alltrim(MV_PAR01))+"%' or "
	_qry += "A1_NREDUZ like '%"+upper(alltrim(MV_PAR01))+"%' or A1_CGC like '%"+upper(alltrim(MV_PAR01))+"%' ) "
	
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,_qry),"XXX",.F.,.T.)
	DbSelectArea("XXX")
	DbGoTop()

	While !Eof() 
		Aadd(aItems,{XXX->A1_NOME,XXX->A1_NREDUZ,XXX->A1_CGC,XXX->A1_COD})
		DbSkip()
	End       
	DbSelectArea("XXX")
	DbCloseArea()
CursorArrow()
	     
If Len(aItems) <= 0
	Alert("Cliente n„o encontrado")
   Return(lRet)
Endif	
	
DEFINE MSDIALOG oDlgSu9 FROM  50,003 TO 260,500 TITLE "Cadastro de Cliente" PIXEL  

	@ 03,10 LISTBOX oLbx1 VAR nPosLbx FIELDS HEADER ;
			"Raz„o","Fantasia","CNPJ","CÛdigo";	//"Descricao"
			SIZE 233,80 OF oDlgSu9 PIXEL NOSCROLL //"Descricao","Ocorrencia","Prazo" 
	oLbx1:SetArray(aItems)
    oLbx1:bLine:={||{aItems[oLbx1:nAt,1],;
					 aItems[oLbx1:nAt,2],;
					 aItems[oLbx1:nAt,3],;
					 aItems[oLbx1:nAt,4]}}
					 


    oLbx1:BlDblClick := {||(lRet:= .T.,nPos:= oLbx1:nAt, oDlgSu9:End())}
	oLbx1:Refresh()

	_xxcod := ""    
	DEFINE SBUTTON FROM 88,105 TYPE 4 ENABLE OF oDlgSu9 ACTION (AxInclui("SA1"))
    DEFINE SBUTTON FROM 88,140 TYPE 15 ENABLE OF oDlgSu9 ACTION (u_cadsA1("V",aItems[oLbx1:nAt][4]))
//    DEFINE SBUTTON FROM 88,140 TYPE 4 ENABLE OF oDlgSu9 ACTION (u_cadsz1("I","")) //4
    DEFINE SBUTTON FROM 88,175 TYPE 1 ENABLE OF oDlgSu9 ACTION (lRet:= .T.,nPos := oLbx1:nAt,oDlgSu9:End())
    DEFINE SBUTTON FROM 88,210 TYPE 2 ENABLE OF oDlgSu9 ACTION (lRet:= .F.,oDlgSu9:End())

ACTIVATE MSDIALOG oDlgSu9 CENTERED

If lRet
   DbSelectarea("SA1")
   DbSetorder(1)
   DbSeek(xFilial("SA1")+aItems[nPos][4])
Endif

Return(lRet) 

User Function CadSA1(_tp,_cod)

_rarea := Getarea()
DbSelectArea("SA1")
cCadastro := "Cadastro de Cliente"
DbSetOrder(1)
DbSeek(xfilial("SA1")+_cod)
nReg := Recno()
AxVisual("SA1",nReg,4)
RestArea(_rarea)

Return

User Function CadSA2(_tp,_cod)

_rarea := Getarea()
DbSelectArea("SA2")
cCadastro := "Cadastro de Fornecedor"
DbSetOrder(1)
DbSeek(xfilial("SA2")+_cod)
nReg := Recno()
AxVisual("SA2",nReg,4)
RestArea(_rarea)

Return       

User Function CadSB1(_tp,_cod)

_rarea := Getarea()
DbSelectArea("SB1")
cCadastro := "Cadastro de Produto"
DbSetOrder(1)
DbSeek(xfilial("SB1")+_cod)
nReg := Recno()
AxVisual("SB1",nReg,4)
RestArea(_rarea)

Return


user function buscasa2()

Local oDlgSu9														// Tela
Local oLbx1                                                         // Listbox
Local nPosLbx  := 0                                                 // Posicao do List
Local aItems   := {}                                                // Array com os itens
Local nPos     := 0                                                 // Posicao no array
Local cAssunto := ""                                                // Descricao do Assunto
Local lRet     := .F.                                               // Retorno da funcao

CursorWait()     

Pergunte("DESCSA2",.T.)

	_qry := "Select A2_NOME, A2_NREDUZ, A2_COD, A2_CGC from "+RetSqlName("SA2")+" SA2 "
	_qry += "where A2_MSBLQL <> '1' and SA2.D_E_L_E_T_ = '' and (A2_NOME like '%"+upper(alltrim(MV_PAR01))+"%' or A2_COD like '%"+upper(alltrim(MV_PAR01))+"%' or "
	_qry += "A2_NREDUZ like '%"+upper(alltrim(MV_PAR01))+"%' or A2_CGC like '%"+upper(alltrim(MV_PAR01))+"%' ) "
	
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,_qry),"XXX",.F.,.T.)
	DbSelectArea("XXX")
	DbGoTop()

	While !Eof() 
		Aadd(aItems,{XXX->A2_NOME,XXX->A2_NREDUZ,XXX->A2_CGC,XXX->A2_COD})
		DbSkip()
	End       
	DbSelectArea("XXX")
	DbCloseArea()
CursorArrow()
	     
If Len(aItems) <= 0
	Alert("Fornecedor n„o encontrado")
   Return(lRet)
Endif	
	
DEFINE MSDIALOG oDlgSu9 FROM  50,003 TO 260,500 TITLE "Cadastro de Fornecedor" PIXEL  

	@ 03,10 LISTBOX oLbx1 VAR nPosLbx FIELDS HEADER ;
			"Raz„o","Fantasia","CNPJ","CÛdigo";	//"Descricao"
			SIZE 233,80 OF oDlgSu9 PIXEL NOSCROLL //"Descricao","Ocorrencia","Prazo" 
	oLbx1:SetArray(aItems)
    oLbx1:bLine:={||{aItems[oLbx1:nAt,1],;
					 aItems[oLbx1:nAt,2],;
					 aItems[oLbx1:nAt,3],;
					 aItems[oLbx1:nAt,4]}}
					 


    oLbx1:BlDblClick := {||(lRet:= .T.,nPos:= oLbx1:nAt, oDlgSu9:End())}
	oLbx1:Refresh()

	_xxcod := ""  
	DEFINE SBUTTON FROM 88,105 TYPE 4 ENABLE OF oDlgSu9 ACTION (AxInclui("SA2"))
    DEFINE SBUTTON FROM 88,140 TYPE 15 ENABLE OF oDlgSu9 ACTION (u_cadsA2("V",aItems[oLbx1:nAt][4]))
    DEFINE SBUTTON FROM 88,175 TYPE 1 ENABLE OF oDlgSu9 ACTION (lRet:= .T.,nPos := oLbx1:nAt,oDlgSu9:End())
    DEFINE SBUTTON FROM 88,210 TYPE 2 ENABLE OF oDlgSu9 ACTION (lRet:= .F.,oDlgSu9:End())

ACTIVATE MSDIALOG oDlgSu9 CENTERED

If lRet
   DbSelectarea("SA2")
   DbSetorder(1)
   DbSeek(xFilial("SA2")+aItems[nPos][4])
Endif

Return(lRet) 



user function buscased()

Local oDlgSu9														// Tela
Local oLbx1                                                         // Listbox
Local nPosLbx  := 0                                                 // Posicao do List
Local aItems   := {}                                                // Array com os itens
Local nPos     := 0                                                 // Posicao no array
Local cAssunto := ""                                                // Descricao do Assunto
Local lRet     := .F.                                               // Retorno da funcao

CursorWait()     

Pergunte("DESCSED",.T.)

	_qry := "Select ED_DESCRIC, ED_CODIGO from "+RetSqlName("SED")+" SED "
	_qry += "where ED_MSBLQL <> '1' and SED.D_E_L_E_T_ = '' and (ED_DESCRIC like '%"+upper(alltrim(MV_PAR01))+"%' or ED_CODIGO like '%"+upper(alltrim(MV_PAR01))+"%')  "
	
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,_qry),"XXX",.F.,.T.)
	DbSelectArea("XXX")
	DbGoTop()

	While !Eof() 
		Aadd(aItems,{XXX->ED_DESCRIC,XXX->ED_CODIGO})
		DbSkip()
	End       
	DbSelectArea("XXX")
	DbCloseArea()
CursorArrow()
	     
If Len(aItems) <= 0
	Alert("Natureza n„o encontrada")
   Return(lRet)
Endif	
	
DEFINE MSDIALOG oDlgSu9 FROM  50,003 TO 260,500 TITLE "Cadastro de Natureza" PIXEL  

	@ 03,10 LISTBOX oLbx1 VAR nPosLbx FIELDS HEADER ;
			"DescriÁ„o","CÛdigo";	//"Descricao"
			SIZE 233,80 OF oDlgSu9 PIXEL NOSCROLL //"Descricao","Ocorrencia","Prazo" 
	oLbx1:SetArray(aItems)
    oLbx1:bLine:={||{aItems[oLbx1:nAt,1],;
					 aItems[oLbx1:nAt,2]}}

    oLbx1:BlDblClick := {||(lRet:= .T.,nPos:= oLbx1:nAt, oDlgSu9:End())}
	oLbx1:Refresh()

	_xxcod := ""
//    DEFINE SBUTTON FROM 88,140 TYPE 15 ENABLE OF oDlgSu9 ACTION (u_cadsB1("V",aItems[oLbx1:nAt][2]))
    DEFINE SBUTTON FROM 88,175 TYPE 1 ENABLE OF oDlgSu9 ACTION (lRet:= .T.,nPos := oLbx1:nAt,oDlgSu9:End())
    DEFINE SBUTTON FROM 88,210 TYPE 2 ENABLE OF oDlgSu9 ACTION (lRet:= .F.,oDlgSu9:End())

ACTIVATE MSDIALOG oDlgSu9 CENTERED

If lRet
   DbSelectarea("SED")
   DbSetorder(1)
   DbSeek(xFilial("SED")+aItems[nPos][2])
Endif

Return(lRet) 


user function buscacor()

Local oDlgSu9														// Tela
Local oLbx1                                                         // Listbox
Local nPosLbx  := 0                                                 // Posicao do List
Local aItems   := {}                                                // Array com os itens
Local nPos     := 0                                                 // Posicao no array
Local cAssunto := ""                                                // Descricao do Assunto
Local lRet     := .F.                                               // Retorno da funcao

CursorWait()     

	_qry := "Select SubString(B1_COD,9,5) as COD, BV_DESCRI from "+RetSqlName("SB1")+" SB1 "
	_qry += CRLF + "inner join "+RetSqlName("SBV")+" SBV on SBV.D_E_L_E_T_ = '' and BV_TABELA = 'COR' and BV_CHAVE = SubString(B1_COD,9,5) "
	_qry += CRLF + "where SB1.D_E_L_E_T_ = '' and B1_COD like '"+alltrim(oMSNewGe1:aCols[oMSNewGe1:nAT,1])+"%' " 
	_qry += CRLF + "group by SubString(B1_COD,9,5), BV_DESCRI "
	               
	MemoWrite("TCESTF001_buscacor.txt",_qry)
	
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,_qry),"XXX",.F.,.T.)
	DbSelectArea("XXX")
	DbGoTop()

	While !Eof() 
		Aadd(aItems,{XXX->BV_DESCRI,XXX->COD})
		DbSkip()
	End       
	DbSelectArea("XXX")
	DbCloseArea()
CursorArrow()
	     
If Len(aItems) <= 0
	Alert("Cor n„o encontrada")
   Return(lRet)
Endif	
	
DEFINE MSDIALOG oDlgSu9 FROM  50,003 TO 260,500 TITLE "Cadastro de Cores" PIXEL  

	@ 03,10 LISTBOX oLbx1 VAR nPosLbx FIELDS HEADER ;
			"DescriÁ„o","CÛdigo";	//"Descricao"
			SIZE 233,80 OF oDlgSu9 PIXEL NOSCROLL //"Descricao","Ocorrencia","Prazo" 
	oLbx1:SetArray(aItems)
    oLbx1:bLine:={||{aItems[oLbx1:nAt,1],;
					 aItems[oLbx1:nAt,2]}}

    oLbx1:BlDblClick := {||(lRet:= .T.,nPos:= oLbx1:nAt, oDlgSu9:End())}
	oLbx1:Refresh()

	_xxcod := ""
//    DEFINE SBUTTON FROM 88,140 TYPE 15 ENABLE OF oDlgSu9 ACTION (u_cadsB1("V",aItems[oLbx1:nAt][2]))
    DEFINE SBUTTON FROM 88,175 TYPE 1 ENABLE OF oDlgSu9 ACTION (lRet:= .T.,nPos := oLbx1:nAt,oDlgSu9:End())
    DEFINE SBUTTON FROM 88,210 TYPE 2 ENABLE OF oDlgSu9 ACTION (lRet:= .F.,oDlgSu9:End())

ACTIVATE MSDIALOG oDlgSu9 CENTERED

If lRet
   DbSelectarea("SBV")
   DbSetorder(1)
   DbSeek(xFilial("SBV")+"COR"+aItems[nPos][2])
Endif

Return(lRet) 

user function buscatam()

Local oDlgSu9														// Tela
Local oLbx1                                                         // Listbox
Local nPosLbx  := 0                                                 // Posicao do List
Local aItems   := {}                                                // Array com os itens
Local nPos     := 0                                                 // Posicao no array
Local cAssunto := ""                                                // Descricao do Assunto
Local lRet     := .F.                                               // Retorno da funcao

CursorWait()

	DbSelectArea("SB4")
	DbSetOrder(1)     
	DbSeek(xfilial("SB4")+alltrim(oMSNewGe1:aCols[oMSNewGe1:nAT,1]))
	
	_qry := "Select SubString(B1_COD,14,2) as COD, BV_DESCRI from "+RetSqlName("SB1")+" SB1 "
	_qry += "inner join "+RetSqlName("SBV")+" SBV on SBV.D_E_L_E_T_ = '' and BV_TABELA = '"+SB4->B4_COLUNA+"' and BV_CHAVE = SubString(B1_COD,14,2) "
	_qry += "where SB1.D_E_L_E_T_ = '' and B1_COD like '"+alltrim(oMSNewGe1:aCols[oMSNewGe1:nAT,1])+"%' " 
	_qry += "group by SubString(B1_COD,14,2), BV_DESCRI "
	
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,_qry),"XXX",.F.,.T.)
	DbSelectArea("XXX")
	DbGoTop()

	While !Eof() 
		Aadd(aItems,{XXX->BV_DESCRI,XXX->COD})
		DbSkip()
	End       
	DbSelectArea("XXX")
	DbCloseArea()
CursorArrow()
	     
If Len(aItems) <= 0
	Alert("Tamanho n„o encontrada")
   Return(lRet)
Endif	
	
DEFINE MSDIALOG oDlgSu9 FROM  50,003 TO 260,500 TITLE "Cadastro de Tamanhos" PIXEL  

	@ 03,10 LISTBOX oLbx1 VAR nPosLbx FIELDS HEADER ;
			"DescriÁ„o","CÛdigo";	//"Descricao"
			SIZE 233,80 OF oDlgSu9 PIXEL NOSCROLL //"Descricao","Ocorrencia","Prazo" 
	oLbx1:SetArray(aItems)
    oLbx1:bLine:={||{aItems[oLbx1:nAt,1],;
					 aItems[oLbx1:nAt,2]}}

    oLbx1:BlDblClick := {||(lRet:= .T.,nPos:= oLbx1:nAt, oDlgSu9:End())}
	oLbx1:Refresh()

	_xxcod := ""
//    DEFINE SBUTTON FROM 88,140 TYPE 15 ENABLE OF oDlgSu9 ACTION (u_cadsB1("V",aItems[oLbx1:nAt][2]))
    DEFINE SBUTTON FROM 88,175 TYPE 1 ENABLE OF oDlgSu9 ACTION (lRet:= .T.,nPos := oLbx1:nAt,oDlgSu9:End())
    DEFINE SBUTTON FROM 88,210 TYPE 2 ENABLE OF oDlgSu9 ACTION (lRet:= .F.,oDlgSu9:End())

ACTIVATE MSDIALOG oDlgSu9 CENTERED

If lRet
   DbSelectarea("SBV")
   DbSetorder(1)
   DbSeek(xFilial("SBV")+SB4->B4_COLUNA+aItems[nPos][2])
Endif

Return(lRet)
 
/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥Preco     ∫Autor  ≥Bruno Parreira      ∫ Data ≥  31/07/18   ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Desc.     ≥ Abre tela para consulta de preco.                          ∫±±
±±∫          ≥                                                            ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥ TCHRISTINA                                                 ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
User Function Preco()

Local nX,nI,nX
Local cRef  := AllTrim(SB4->B4_COD)
Local cDesc := AllTrim(SB4->B4_DESC)
Local cPerg := "TCESTF001"

Private aDados := {}
Private aHeader := {}
Private aCols   := {}
Private aFields := {"B1_COD","B1_DESC"}
Private aAlterFields := {}

Private oFont12  := TFont():New("Arial",,12,,.f.,,,,,.f.)
Private oFont12n := TFont():New("Arial",,12,,.t.,,,,,.f.)
Private oFont14  := TFont():New("Arial",,14,,.f.,,,,,.f.)
Private oFont14n := TFont():New("Arial",,14,,.t.,,,,,.f.)        
Private oFont16  := TFont():New("Arial",,16,,.f.,,,,,.f.)
Private oFont16n := TFont():New("Arial",,16,,.t.,,,,,.f.)
Private oFont20  := TFont():New("Arial",,20,,.f.,,,,,.f.)
Private oFont20n := TFont():New("Arial",,20,,.t.,,,,,.f.)

DbSelectArea("SZD")
DbSetOrder(1)
If !DbSeek(xFilial("SZD")+cRef)
	MsgAlert("ReferÍncia "+cRef+" n„o possui grade nova cadastrada!","ATEN«√O")
	Return
EndIf

If !Pergunte(cPerg)
	Return
EndIf

DbSelectArea("SB1")
DbSetOrder(1)
If DbSeek(xFilial("SB1")+cRef)
	While SB1->(!EOF()) .And. SubStr(SB1->B1_COD,1,8) = cRef
		If SubStr(SB1->B1_COD,9,5) = alltrim(MV_PAR03)
			aAdd(aDados,{SB1->B1_COD,SB1->B1_DESC,.F.})
		Endif
		SB1->(DbSkip())
	EndDo
EndIf

If Len(aDados) = 0
	MsgAlert("ReferÍncia n„o possui produtos cadadstrados!","ATEN«√O")
	Return
EndIf

DbSelectArea("SX3")
SX3->(DbSetOrder(2))
For nX := 1 to Len(aFields)
	If SX3->(DbSeek(aFields[nX]))
		nTamanho := SX3->X3_TAMANHO
		Do Case     
			Case aFields[nX] = "B1_COD"
				cCampo := "CÛdigo"	  	          
			Otherwise 
	    		cCampo := Trim(X3Titulo())       
		EndCase
		Aadd(aHeader,{cCampo,SX3->X3_CAMPO,SX3->X3_PICTURE,nTamanho,SX3->X3_DECIMAL,SX3->X3_VALID,"",SX3->X3_TIPO,"","" })
	EndIf
Next nX	

Aadd(aCols,Array(Len(aHeader)+1))

For nI := 1 To Len(aHeader)
	/*If aHeader[nI][2] = "C5_NUM"
		aCols[1][nI] := "000001"
	EndIf*/
    aCols[1][nI] := CriaVar(aHeader[nI][2])
Next nI

aCols[1][Len(aHeader)+1] := .F.

DEFINE MSDIALOG oDlg TITLE "Consulta de PreÁo por Produto" FROM 00,00 TO 380,600 PIXEL  
	          
@ 006, 007 Say 'ReferÍncia:' Size 050,010 COLOR CLR_BLACK FONT oFont14n PIXEL OF oDlg
@ 005, 045 Say cRef+" - "+cDesc Size 600,010 COLOR CLR_BLUE FONT oFont20n PIXEL OF oDlg
@ 173, 007 Say 'Selecione o produto e clique no bot„o "Consultar PreÁo"' Size 170,010 COLOR CLR_BLACK FONT oFont14 PIXEL OF oDlg
@ 170, 200 BUTTON oButton1  PROMPT "Consultar PreÁo" SIZE 045,015 OF oDlg ACTION (CONPRECO(@oGetDados:nAt,mv_par01,mv_par02)) PIXEL MESSAGE "Consultar PreÁo"
@ 170, 252 BUTTON oButton2  PROMPT "Sair" SIZE 045,015 OF oDlg ACTION (oDlg:End()) PIXEL MESSAGE "Sair"

oGetDados := MsNewGetDados():New(020,001,165,303,GD_UPDATE,"AllwaysTrue","AllwaysTrue","",aAlterFields,0, 999, "AllwaysTrue", "", "AllwaysTrue",oDlg, aHeader, aDados)

oGetDados:aCols=aDados

N := oGetDados:nAt       

ACTIVATE MSDIALOG oDlg CENTERED 

Return

Static Function CONPRECO(nLinha,cTabPrc,cRevisao)

Local nX, ni
Local aHeadPrc  := {}
Local aFldPrc   := {"G1_COMP","B1_DESC","B1_UM","G1_QUANT","DA1_PRCVEN","C7_TOTAL","DA1_VLRDES","C6_VALOR"}
Local aAlFldPrc := {"DA1_VLRDES"}
Local nPosPrd   := aScan(aHeader,{|x| AllTrim(x[2]) == 'B1_COD'})
Local cProd     := oGetDados:aCols[nLinha][nPosPrd]
Local nPosDesc  := aScan(aHeader,{|x| AllTrim(x[2]) == 'B1_DESC'})
Local cDesc     := oGetDados:aCols[nLinha][nPosDesc]

Private aColsPrc  := {}
Private aDadosPrc := {}
Private oDlgPrc
Private oVlrTotal
Private oVlrAlt

Private nVlrTotal := 0
Private nVlrAlt   := 0
        
//Processa( {|| MontaArray(cProd) }, "Aguarde...", "Carregando campos...",.F.)

aDadosPrc := MontaArray(cProd,cTabPrc,cRevisao)

DbSelectArea("SX3")
SX3->(DbSetOrder(2))
For nX := 1 to Len(aFldPrc)
	If SX3->(DbSeek(aFldPrc[nX]))
		nTamanho := SX3->X3_TAMANHO
		cValid   := SX3->X3_VALID
		Do Case     
			Case aFldPrc[nX] = "G1_COMP"
				cCampo := "Produto"
			Case aFldPrc[nX] = "DA1_PRCVEN"
				cCampo := "PreÁo Unit·rio"	  	          
			Case aFldPrc[nX] = "C7_TOTAL"
				cCampo := "Total"
			Case aFldPrc[nX] = "DA1_VLRDES"
				cCampo := "PreÁo Unit. Alter·vel"
				cValid := "U_CALCPRC(oGetPrc:nAt,M->DA1_VLRDES)"
			Case aFldPrc[nX] = "C6_VALOR"
				cCampo := "Total Alter·vel"
			Otherwise 
	    			cCampo := Trim(X3Titulo())       
		EndCase
		Aadd(aHeadPrc,{cCampo,SX3->X3_CAMPO,SX3->X3_PICTURE,nTamanho,SX3->X3_DECIMAL,cValid,"",SX3->X3_TIPO,"","" })
	EndIf
Next nX	

Aadd(aColsPrc,Array(Len(aHeadPrc)+1))

For nI := 1 To Len(aHeadPrc)
	/*If aHeadPrc[nI][2] = "C5_NUM"
		aColsPrc[1][nI] := "000001"
	EndIf*/
    aColsPrc[1][nI] := CriaVar(aHeadPrc[nI][2])
Next nI

aColsPrc[1][Len(aHeadPrc)+1] := .F.

DEFINE MSDIALOG oDlgPrc TITLE "PreÁo Produto: "+cProd FROM 00,00 TO 460,1400 PIXEL

@ 007,007 Say 'Produto: ' Size 050,010 COLOR CLR_BLACK FONT oFont16n PIXEL OF oDlgPrc
@ 006,040 Say cProd+" - "+cDesc Size 1000,010 COLOR CLR_BLUE FONT oFont20n PIXEL OF oDlgPrc
@ 210,415 Say 'Valor Total: ' Size 070,010 COLOR CLR_BLACK FONT oFont16n PIXEL OF oDlgPrc
@ 209,465 Say oVlrTotal Prompt "R$  "+Transform(nVlrTotal,"@E 999,999.99") Size 200,010 COLOR CLR_BLUE FONT oFont20n PIXEL OF oDlgPrc
//@ 209,465 MSGET oVlrTotal Var nVlrTotal SIZE 120, 010 COLOR CLR_BLACK Picture "@E 999,999.99" PIXEL OF oDlgPrc
@ 210,550 Say 'Total Alter·vel: ' Size 070,010 COLOR CLR_BLACK FONT oFont16n PIXEL OF oDlgPrc
@ 209,600 Say oVlrAlt Prompt "R$  "+Transform(nVlrAlt,"@E 999,999.99") Size 200,010 COLOR CLR_BLUE FONT oFont20n PIXEL OF oDlgPrc
//@ 209,600 MSGET oVlrAlt Var nVlrAlt SIZE 120, 010 COLOR CLR_BLACK Picture "@E 999,999.99" PIXEL OF oDlgPrc
@ 207,007 BUTTON oButton2  PROMPT "Sair" SIZE 045,015 OF oDlgPrc ACTION (oDlgPrc:End()) PIXEL MESSAGE "Sair"
@ 207,107 BUTTON oButton2  PROMPT "Salvar" SIZE 045,015 OF oDlgPrc ACTION (SlvPrc(cProd,cTabPrc,cRevisao)) PIXEL MESSAGE "Sair"

oGetPrc := MsNewGetDados():New(020,001,200,700,GD_UPDATE,"AllwaysTrue","AllwaysTrue","",aAlFldPrc,0, 999, "AllwaysTrue", "", "AllwaysTrue",oDlgPrc, aHeadPrc, aDadosPrc)

oGetPrc:aCols=aDadosPrc

N2 := oGetPrc:nAt

ACTIVATE MSDIALOG oDlgPrc CENTERED

Return

Static Function MontaArray(cSKU,cTabPrc,cRevisao)

Local nX
Local aRet    := {}
Local cQuery  := ""
//Local cTabPrc := AllTrim(SuperGetMV("MV_XTABPRC",.F.,"005"))

cQuery := "select G1_COMP,B1_DESC,B1_UM,G1_QUANT,ISNULL(DA1_PRCVEN,0) AS DA1_PRCVEN,(G1_QUANT*ISNULL(DA1_PRCVEN,0)) AS TOTAL "
cQuery += CRLF + "from "+RetSqlName("SG1")+" SG1 "
cQuery += CRLF + "inner join "+RetSqlName("SB1")+" SB1 "
cQuery += CRLF + "on B1_COD = G1_COMP "
cQuery += CRLF + "and SB1.D_E_L_E_T_ = '' "
cQuery += CRLF + "left join "+RetSqlName("DA1")+" DA1 "
cQuery += CRLF + "on DA1_CODPRO = G1_COMP "
cQuery += CRLF + "and DA1_CODTAB = '"+cTabPrc+"' "
cQuery += CRLF + "and DA1.D_E_L_E_T_ = '' "
cQuery += CRLF + "where SG1.D_E_L_E_T_ = '' "
cQuery += CRLF + "and G1_COD = '"+cSKU+"' "
cQuery += CRLF + "and G1_REVINI = '"+cRevisao+"' "
cQuery += CRLF + "and Substring(G1_COMP,7,2) not in ('P2','P1') "
cQuery += CRLF + "union all "
cQuery += CRLF + "select "
cQuery += CRLF + "G1_COMP,B1_DESC,B1_UM,G1_QUANT,ISNULL(DA1_PRCVEN,0) AS DA1_PRCVEN,(G1_QUANT*ISNULL(DA1_PRCVEN,0)) AS TOTAL " 
cQuery += CRLF + "from "+RetSqlName("SG1")+" SG1 "
cQuery += CRLF + "inner join "+RetSqlName("SB1")+" SB1 on B1_COD = G1_COMP and SB1.D_E_L_E_T_ = '' "
cQuery += CRLF + "left join "+RetSqlName("DA1")+" DA1 on DA1_CODPRO = G1_COMP and DA1_CODTAB = '005' and DA1.D_E_L_E_T_ = '' " 
cQuery += CRLF + "where SG1.D_E_L_E_T_ = '' "
cQuery += CRLF + "and G1_COD = '"+SubStr(cSKU,1,6)+"P2"+SubStr(cSKU,9,7)+"' " 
cQuery += CRLF + "and G1_REVINI = '"+cRevisao+"' "
cQuery += CRLF + "and Substring(G1_COMP,7,2) not in ('P2','P1') "
cQuery += CRLF + "union all "
cQuery += CRLF + "select "
cQuery += CRLF + "G1_COMP,B1_DESC,B1_UM,G1_QUANT,ISNULL(DA1_PRCVEN,0) AS DA1_PRCVEN,(G1_QUANT*ISNULL(DA1_PRCVEN,0)) AS TOTAL " 
cQuery += CRLF + "from "+RetSqlName("SG1")+" SG1 "
cQuery += CRLF + "inner join "+RetSqlName("SB1")+" SB1 on B1_COD = G1_COMP and SB1.D_E_L_E_T_ = '' "
cQuery += CRLF + "left join "+RetSqlName("DA1")+" DA1 on DA1_CODPRO = G1_COMP and DA1_CODTAB = '005' and DA1.D_E_L_E_T_ = '' " 
cQuery += CRLF + "where SG1.D_E_L_E_T_ = '' "
cQuery += CRLF + "and G1_COD = '"+SubStr(cSKU,1,6)+"P1"+SubStr(cSKU,9,7)+"' " 
cQuery += CRLF + "and G1_REVINI = '"+cRevisao+"' "
cQuery += CRLF + "and Substring(G1_COMP,7,2) not in ('P2','P1') "


memowrite("TCESTF001_PRC.txt",cQuery)

cQuery := ChangeQuery(cQuery)

If Select("TMPPRC") > 0
   	 TMPPRC->(DbCloseArea())
EndIf 

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TMPPRC",.T.,.T.)

nVlrTotal := 0
nVlrAlt   := 0

If TMPPRC->(!EOF())
	While TMPPRC->(!EOF())
		aAdd(aRet,{TMPPRC->G1_COMP,TMPPRC->B1_DESC,TMPPRC->B1_UM,TMPPRC->G1_QUANT,TMPPRC->DA1_PRCVEN,TMPPRC->TOTAL,TMPPRC->DA1_PRCVEN,TMPPRC->TOTAL,.F.})
		nVlrTotal += TMPPRC->TOTAL
		nVlrAlt   += TMPPRC->TOTAL
		TMPPRC->(DbSkip())
	EndDo
EndIf

Return aRet

User Function CALCPRC(nLin,nVlrUni)

Local nX
Local lRet    := .T. 
Local nPosQtd := aScan(aHeader,{|x| AllTrim(x[2]) == 'G1_QUANT'})
Local nQuant  := oGetPrc:aCols[nLin][nPosQtd]
Local nPosVlr := aScan(aHeader,{|x| AllTrim(x[2]) == 'DA1_VLRDES'})
//Local nVlrUni := oGetPrc:aCols[nLin][nPosVlr]
Local nPosTot := aScan(aHeader,{|x| AllTrim(x[2]) == 'C6_VALOR'})

If nVlrUni > 0
	oGetPrc:aCols[nLin][nPosTot] := nQuant * nVlrUni
	
	nVlrAlt := 0
	For nx := 1 to Len(oGetPrc:aCols)
		nVlrAlt += oGetPrc:aCols[nx][nPosTot]
		oVlrAlt:CtrlRefresh()
	Next
	
	oGetPrc:Refresh()
Else
	lRet := .F.
	MsgAlert("N„o È possÌvel deixar o valor zerado!","ATEN«√O")
EndIf

Return lRet

User Function ajustac(_Produto,_Revisao,_indice,_compon,_corte)
	
	Local cEOL  := CHR(13)+CHR(10)
	
	IF _corte = 'S'
		_qry := "update "+RetSqlName("SG1")+" set D_E_L_E_T_ = '*', R_E_C_D_E_L_ = R_E_C_N_O_ "+cEOL
		_qry += "where D_E_L_E_T_ = '' and G1_REVINI = '"+_Revisao+"' and (SubString(G1_COD,1,8) = '"+SubStr(_Produto,1,6)+"P1' or SubString(G1_COD,1,8) = '"+SubStr(_Produto,1,6)+"P2') "+cEOL 
		_qry += "		and SubString(G1_COMP,1,8) = '"+alltrim(SubStr(_compon,1,8))+"' "+cEOL
	Else		
		_qry := "update "+RetSqlName("SG1")+" set D_E_L_E_T_ = '*', R_E_C_D_E_L_ = R_E_C_N_O_ "+cEOL
		_qry += "where D_E_L_E_T_ = '' and G1_REVINI = '"+_revisao+"' and Left(G1_COD,8) = '"+SubStr(_Produto,1,8)+"' "+cEOL
		_qry += "		and left(G1_COMP,8) = '"+SubStr(_compon,1,8)+"' and G1_TRT = '"+_indice+"' "+cEOL
	Endif
	
	nStatus := TcSqlExec(_qry)
	
	if (nStatus < 0)
 		MsgBox(TCSQLError(), "Erro no comando", "Stop")
  	endif
Return

Static Function SlvPrc(cProd,cTabPrc,cRevisao)

Local _i

Pergunte("CONSPRC",.T.)

For _i := 1 to len(aDadosPrc)

	RecLock("ZB4",.T.)
		Replace ZB4_FILIAL	with xfilial("ZB4")
		Replace ZB4_NOME	with MV_PAR01
		Replace ZB4_DATA	with ddatabase
		Replace ZB4_PROD	with cProd
		Replace ZB4_TABELA	with cTabPrc
		Replace ZB4_REVISA	with cRevisao  
		Replace ZB4_COMP 	with aDadosPrc[_i,1]
		Replace ZB4_DESCC	with aDadosPrc[_i,2]
		Replace ZB4_UM		with aDadosPrc[_i,3]
		Replace ZB4_QTD		with aDadosPrc[_i,4]
		Replace ZB4_PRCTB	with aDadosPrc[_i,5]
		Replace ZB4_TOTTB	with aDadosPrc[_i,6]
		Replace ZB4_PRCAL	with aDadosPrc[_i,7]
		Replace ZB4_TOTAL	with aDadosPrc[_i,8]
	MsUnLock()

Next

Return

user Function CriaRot()

pergunte("QROT",.T.)

DbSelectarea("SG2")
DbSetOrder(7)
Dbseek(xfilial("SG2")+padr(SB4->B4_COD,26)+ALLTRIM(MV_PAR01))

If !Found()

	DbSelectArea("SG2")
	DbSetOrder(1)
	DbSeek(xfilial("SG2")+padr(".CADASTROOPERAC",15)+alltrim(MV_PAR01))
		
	While !EOF() .and. SG2->G2_CODIGO = alltrim(MV_PAR01) .AND. SG2->G2_PRODUTO = ".CADASTROOPERAC"
		_areaG2 := GetArea()

		_OPERAC := SG2->G2_OPERAC
		_RECURS := SG2->G2_RECURSO
		_DESCRI := SG2->G2_DESCRI
		_MAOOBR := SG2->G2_MAOOBRA
		_LOTEPA := SG2->G2_LOTEPAD
		_TEMPAD := SG2->G2_TEMPAD
		_CTRAB  := SG2->G2_CTRAB
			
		RecLock("SG2",.t.)
			Replace G2_FILIAL	with xfilial("SG2")
			Replace G2_REFGRD	WITH SB4->B4_COD
			Replace G2_CODIGO	WITH ALLTRIM(MV_PAR01)
			Replace G2_OPERAC	WITH _OPERAC
			REPLACE G2_RECURSO	WITH _RECURS
			REPLACE G2_DESCRI	WITH _DESCRI
			REPLACE G2_MAOOBRA 	WITH _MAOOBR
			REPLACE G2_LOTEPAD	WITH _LOTEPA
			REPLACE G2_TEMPAD	WITH _TEMPAD
			REPLACE G2_CTRAB	WITH _CTRAB
		MsUnLock()
			
		RestArea(_areaG2)
			
		dbSkip()
	end
	ALERT("OPERA«√O CADASTRADA COM SUCESSO!")
ELSE
    ALERT("OPERA«√O J¡ CADASTRADA!")
endif

Return
