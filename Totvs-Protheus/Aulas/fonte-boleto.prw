#Include "Protheus.ch"
#include "TOTVS.CH"
#INCLUDE "topconn.ch"
#include "rwmake.ch"
#INCLUDE "RPTDEF.CH"
#INCLUDE "FWPrintSetup.ch"

#define DS_MODALFRAME   128

//=================================================================================
/*/{Protheus.doc} VVFIN001
Rotina para geração de Boletos (341-Itau)
@type       function
@author     Daniel R. Melo (Vila Velha / Actual Trend)
@since      08/11/2021
@version    1.0
/*/
//=================================================================================
User Function VVFIN001()

	Local aCores		:= {}
	Local oButton1
	Local oButton2
	Local oFont1		:= TFont():New("MS Sans Serif",,014,,.T.,,,,,.F.,.F.)
//	Local oFont2		:= TFont():New("MS Sans Serif",,010,,.T.,,,,,.F.,.F.)
	Local oSay1
	Local aCpoBro		:= {}
	Local oGet1
	Local aCoords		:= FWGetDialogSize()	//{ 0, 0, 580, 1000 }		//FWGetDialogSize()		//nTop, nLeft, nBottom, nRight

	Private cArquivo	:= ""
	Private lInverte	:= .F.
	Private cMark		:= GetMark()
	Private oMark
	Private oSay2
	//Private oSay3
	Private nQtdN		:= 0
	Private _cPerg		:= "VVFIN001"
	Private cGMailAdm	:= Space(200)
	Private cMailHomol	:= "daniel.melo@actualtrend.com.br"
	Private oTempTable

	Private cDir		:= Alltrim(GetMv("AT_LOCPDF"))
	Private cLocSend	:= Alltrim(GetMv("AT_LOCSND"))
	Private cMailCC		:= Alltrim(GetMv("AT_MAILCCB"))
	Private nQtdBol		:= 10 							//quantidade maxima de anexos por e-mail

	Static oDlg1

	If !Pergunte(_cPerg,.T.)
		Return
	EndIf

	/*
	X1_ORDEM	X1_VARIAVL	X1_VAR01		X1_PERGUNT
	01			mv_ch1		mv_par01		Banco
	02			mv_ch2		mv_par02		Agencia
	03			mv_ch3		mv_par03		Conta
	04			mv_ch4		mv_par04		SubConta
	05			mv_ch5		mv_par05		Emissao de
	06			mv_ch6		mv_par06		Emissao ate
	07			mv_ch7		mv_par07		Prefixo de
	08			mv_ch8		mv_par08		Prefixo ate
	09			mv_ch9		mv_par09		Numero de 
	10			mv_chA		mv_par10		Numero ate
	11			mv_chB		mv_par11		Vencimento de
	12			mv_chC		mv_par12		Vencimento ate 
	13			mv_chD		mv_par13		Tipo de 
	14			mv_chE		mv_par14		Tipo ate
	15			mv_chF		mv_par15		Cliente de
	16			mv_chG		mv_par16		Cliente ate
	17			mv_chH		mv_par17		Loja de 
	18			mv_chI		mv_par18		Loja ate
	19			mv_chJ		mv_par19		Bordero de
	20			mv_chK		mv_par20		Bordero ate 
	21			mv_chL		mv_par21		Administradora
	22			mv_chM		mv_par22		Email unico Administradora    
	23			mv_chN		mv_par23		Visualiza Impressao
	24			mv_chO		mv_par24		Envia Email 
	25			mv_chP		mv_par25		Envia copia para
	26			mv_chQ		mv_par26		Env. em Homologacao
	27			mv_chR		mv_par27		Arquivo Unico
	28			mv_chS		mv_par28		Anexa Nota Fiscal             
	*/

	If(Select("TBOL") <> 0)
		dbSelectArea("TBOL")
		TBOL->(DbCloseArea())
	EndIf

	If MV_PAR01 $ '341'
		Processa( {|| cArquivo  := VVFIN01A() }, "Atenção", "Gerando Tabela Temporaria...", .F.)
	Else
		MsgInfo("O processo não pode será executado para o Banco selecionado.","Atenção")
		Return(Nil)
	EndIf

	dbSelectArea("TBOL")
	dbGoTop()

	If Select("TBOL") == 0
		MsgInfo("Não Existem titulos para geração de boleto.","Atenção")
		Return(Nil)
	EndIf

	aCpoBro	:= {	{ "OK"				,,"   " 				,"@!"						},;
					{ "PREFIXO"			,,"Prefixo"				,"@!"						},;
					{ "NUMERO"			,,"Numero"				,"@!"						},;
					{ "PARCELA"			,,"Parcela"				,"@!"						},;
					{ "TIPO"			,,"Tipo"				,"@!"						},;
					{ "EMISSAO"			,,"Emissao"				,"@D 99/99/9999"			},;
					{ "CLIENTE"			,,"Cod. Cliente"		,"@!"						},;
					{ "LOJA"			,,"Loja"				,"@!"						},;
					{ "NOME"			,,"Nome Cliente"		,"@!"						},;
					{ "ADMIN"			,,"Cod. Admin"			,"@!"						},;
					{ "NADMIN"			,,"Nome Administradora"	,"@!"						},;
					{ "CODCADM"			,,"Cod. Cli Adm"		,"@!"						},;
					{ "EMAIL"			,,"E-mail Cliente"		,"@!"						},;
					{ "VALOR"			,,"Valor"				,"@E 9,999,999,999,999.99"	},;
					{ "PCC"				,,"PCC"					,"@E 999,999.99"			},;
					{ "IRRF"			,,"IRRF"				,"@E 999,999.99"			},;
					{ "RETISS"			,,"ISS Retido"			,"@E 999,999.99"			},;
					{ "VENCTO"			,,"Vencimento"			,"@D 99/99/9999"			},;
					{ "VENCREA"			,,"Venc. Real"			,"@D 99/99/9999"			},;
					{ "BANCO"			,,"Banco"				,"@!"						},;
					{ "AGENCIA"			,,"Agencia"				,"@!"						},;
					{ "CONTA"			,,"Conta"				,"@!"						},;
					{ "NUMBCO"			,,"Nosso Numero"		,"@!"						},;
					{ "NUMBOR"			,,"Bordero"				,"@!"						}}

	DEFINE MSDIALOG oDlg1 TITLE "Gerador de Boletos - Impressão" FROM aCoords[1], aCoords[2]  TO aCoords[3], aCoords[4] COLORS 0, 16777215 PIXEL Style DS_MODALFRAME
	If !empty(MV_PAR21)
		@ aCoords[1]+5 , aCoords[2]+5 SAY oSay1 PROMPT "Lista de Titulos Geração de Boletos/Impressão : Administradora "+AllTrim(MV_PAR21) +" - "+AllTrim(TBOL->NADMIN) SIZE 330, 007 OF oDlg1 FONT oFont1 COLORS CLR_RED PIXEL
	Else
		@ aCoords[1]+5 , aCoords[2]+5 SAY oSay1 PROMPT "Lista de Titulos Geração de Boletos/Impressão :" SIZE 230, 007 OF oDlg1 FONT oFont1 COLORS CLR_RED PIXEL
	EndIf
	oMark := MsSelect():New("TBOL","OK","",aCpoBro,@lInverte,@cMark,{aCoords[1]+20 , aCoords[2]+5, (aCoords[3]/2)-25, (aCoords[4]/2)-5},,,,,aCores)
	oMark:bMark := {| | VVFIN01C()}
	@ (aCoords[3]/2)-21 , (aCoords[2]/2)+5   BUTTON oButton1 PROMPT "Inverte Seleção"		SIZE 050, 013 OF oDlg1 ACTION VVFIN01D()	    			PIXEL
	//@ 272, 065 SAY oSay2 PROMPT "Titulos Selecionados :"	SIZE 064, 007 OF oDlg1 FONT oFont2 COLORS 0, 16777215		PIXEL
	//@ 272, 140 SAY oSay3 PROMPT Alltrim(Str(nQtdN))			SIZE 025, 007 OF oDlg1 FONT oFont2 COLORS CLR_RED    	PIXEL
	If !empty(MV_PAR21)
		If MV_PAR26 == 1
			cGMailAdm := cMailHomol
		Else
			cGMailAdm := TBOL->MAILADM
		EndIf
		@ (aCoords[3]/2)-18 , (aCoords[2]/2)+160 SAY oSay2 PROMPT "E-mail Administradora :"	SIZE 080, 007 OF oDlg1 COLORS 0, 16777215				PIXEL
		@ (aCoords[3]/2)-21 , (aCoords[2]/2)+250 MSGET oGet1 VAR cGMailAdm					SIZE 350, 010 OF oDlg1 COLORS 0, 16777215 				PIXEL
	EndIf
	@ (aCoords[3]/2)-21 , (aCoords[4]/2)-110 BUTTON oButton1 PROMPT "Imprime Boleto"		SIZE 040, 013 OF oDlg1 ACTION VVFIN01E()    				PIXEL
	@ (aCoords[3]/2)-21 , (aCoords[4]/2)-55  BUTTON oButton2 PROMPT "Fechar"     			SIZE 040, 013 OF oDlg1 ACTION VVFIN01B(cArquivo, oDlg1) 	PIXEL

	ACTIVATE MSDIALOG oDlg1 CENTERED

	If(Select("TBOL") <> 0)
		dbSelectArea("TBOL")
		TBOL->(DbCloseArea())
	EndIf

Return(Nil)


/*--------------------------------------------------------------------------------*/
Static Function VVFIN01A()

	Local cQrySe1	:= ""
	Local cEOL		:= Chr(13) + Chr(10)

	aCampos		:= {{ "OK"				,"C" ,02 ,0},;
					{ "FILIAL"			,GetSx3Cache("E1_FILIAL","X3_TIPO")		,GetSx3Cache("E1_FILIAL","X3_TAMANHO")	,GetSx3Cache("E1_FILIAL","X3_DECIMAL")	},;
					{ "PREFIXO"			,GetSx3Cache("E1_PREFIXO","X3_TIPO")	,GetSx3Cache("E1_PREFIXO","X3_TAMANHO")	,GetSx3Cache("E1_PREFIXO","X3_DECIMAL")	},;
					{ "NUMERO"			,GetSx3Cache("E1_NUM","X3_TIPO")		,GetSx3Cache("E1_NUM","X3_TAMANHO")		,GetSx3Cache("E1_NUM","X3_DECIMAL")		},;
					{ "PARCELA"			,GetSx3Cache("E1_PARCELA","X3_TIPO")	,GetSx3Cache("E1_PARCELA","X3_TAMANHO")	,GetSx3Cache("E1_PARCELA","X3_DECIMAL")	},;
					{ "TIPO"			,GetSx3Cache("E1_TIPO","X3_TIPO")		,GetSx3Cache("E1_TIPO","X3_TAMANHO")	,GetSx3Cache("E1_TIPO","X3_DECIMAL")	},;
					{ "CLIENTE"			,GetSx3Cache("E1_CLIENTE","X3_TIPO")	,GetSx3Cache("E1_CLIENTE","X3_TAMANHO")	,GetSx3Cache("E1_CLIENTE","X3_DECIMAL")	},;
					{ "LOJA"			,GetSx3Cache("E1_LOJA","X3_TIPO")		,GetSx3Cache("E1_LOJA","X3_TAMANHO")	,GetSx3Cache("E1_LOJA","X3_DECIMAL")	},;
					{ "ADMIN"			,GetSx3Cache("A1_XCODADM","X3_TIPO")	,GetSx3Cache("A1_XCODADM","X3_TAMANHO")	,GetSx3Cache("A1_XCODADM","X3_DECIMAL")	},;
					{ "NADMIN"			,GetSx3Cache("A1_XNOMADM","X3_TIPO")	,GetSx3Cache("A1_XNOMADM","X3_TAMANHO")	,GetSx3Cache("A1_XNOMADM","X3_DECIMAL")	},;
					{ "MAILADM"			,GetSx3Cache("A1_XMAILAD","X3_TIPO")	,GetSx3Cache("A1_XMAILAD","X3_TAMANHO")	,GetSx3Cache("A1_XMAILAD","X3_DECIMAL")	},;
					{ "CODCADM"			,GetSx3Cache("A1_XCDCADM","X3_TIPO")	,GetSx3Cache("A1_XCDCADM","X3_TAMANHO")	,GetSx3Cache("A1_XCDCADM","X3_DECIMAL")	},;
					{ "BANCO"			,GetSx3Cache("E1_PORTADO","X3_TIPO")	,GetSx3Cache("E1_PORTADO","X3_TAMANHO")	,GetSx3Cache("E1_PORTADO","X3_DECIMAL")	},;
					{ "AGENCIA"			,GetSx3Cache("E1_AGEDEP","X3_TIPO")		,GetSx3Cache("E1_AGEDEP","X3_TAMANHO")	,GetSx3Cache("E1_AGEDEP","X3_DECIMAL")	},;
					{ "CONTA"			,GetSx3Cache("E1_CONTA","X3_TIPO")		,GetSx3Cache("E1_CONTA","X3_TAMANHO")	,GetSx3Cache("E1_CONTA","X3_DECIMAL")	},;
					{ "EMISSAO"			,GetSx3Cache("E1_EMISSAO","X3_TIPO")	,GetSx3Cache("E1_EMISSAO","X3_TAMANHO")	,GetSx3Cache("E1_EMISSAO","X3_DECIMAL")	},;
					{ "VENCTO"			,GetSx3Cache("E1_VENCTO","X3_TIPO")		,GetSx3Cache("E1_VENCTO","X3_TAMANHO")	,GetSx3Cache("E1_VENCTO","X3_DECIMAL")	},;
					{ "VENCREA"			,GetSx3Cache("E1_VENCREA","X3_TIPO")	,GetSx3Cache("E1_VENCREA","X3_TAMANHO")	,GetSx3Cache("E1_VENCREA","X3_DECIMAL")	},;
					{ "VLCRUZ"			,GetSx3Cache("E1_VLCRUZ","X3_TIPO")		,GetSx3Cache("E1_VLCRUZ","X3_TAMANHO")	,GetSx3Cache("E1_VLCRUZ","X3_DECIMAL")	},;
					{ "SALDO"			,GetSx3Cache("E1_SALDO","X3_TIPO")		,GetSx3Cache("E1_SALDO","X3_TAMANHO")	,GetSx3Cache("E1_SALDO","X3_DECIMAL")	},;
					{ "PCC"				,GetSx3Cache("E1_SALDO","X3_TIPO")		,GetSx3Cache("E1_SALDO","X3_TAMANHO")	,GetSx3Cache("E1_SALDO","X3_DECIMAL")	},;
					{ "IRRF"			,GetSx3Cache("E1_IRRF","X3_TIPO")		,GetSx3Cache("E1_IRRF","X3_TAMANHO")	,GetSx3Cache("E1_IRRF","X3_DECIMAL")	},;
					{ "RETISS"			,GetSx3Cache("E1_VRETISS","X3_TIPO")	,GetSx3Cache("E1_VRETISS","X3_TAMANHO")	,GetSx3Cache("E1_VRETISS","X3_DECIMAL")	},;
					{ "CODBAR"			,GetSx3Cache("E1_CODBAR","X3_TIPO")		,GetSx3Cache("E1_CODBAR","X3_TAMANHO")	,GetSx3Cache("E1_CODBAR","X3_DECIMAL")	},;	//codigo de barras
					{ "CODDIG"			,GetSx3Cache("E1_CODDIG","X3_TIPO")		,GetSx3Cache("E1_CODDIG","X3_TAMANHO")	,GetSx3Cache("E1_CODDIG","X3_DECIMAL")	},;  //linha digitável
					{ "VALOR"			,GetSx3Cache("E1_VALOR","X3_TIPO")		,GetSx3Cache("E1_VALOR","X3_TAMANHO")	,GetSx3Cache("E1_VALOR","X3_DECIMAL")	},;
					{ "NUMBCO"			,GetSx3Cache("E1_NUMBCO","X3_TIPO")		,GetSx3Cache("EE_FAXATU","X3_TAMANHO")	,GetSx3Cache("E1_NUMBCO","X3_DECIMAL")	},;
					{ "NUMBOR" 			,GetSx3Cache("E1_NUMBOR","X3_TIPO")		,GetSx3Cache("E1_NUMBOR","X3_TAMANHO")	,GetSx3Cache("E1_NUMBOR","X3_DECIMAL")	},;
					{ "SITUACA"			,GetSx3Cache("E1_SITUACA","X3_TIPO")	,GetSx3Cache("E1_SITUACA","X3_TAMANHO")	,GetSx3Cache("E1_SITUACA","X3_DECIMAL")	},;
					{ "IDCNAB"			,GetSx3Cache("E1_IDCNAB","X3_TIPO")		,GetSx3Cache("E1_IDCNAB","X3_TAMANHO")	,GetSx3Cache("E1_IDCNAB","X3_DECIMAL")	},;
					{ "NOME"			,GetSx3Cache("A1_NOME","X3_TIPO")		,GetSx3Cache("A1_NOME","X3_TAMANHO")	,GetSx3Cache("A1_NOME","X3_DECIMAL")	},;
					{ "ENDCOB"			,GetSx3Cache("A1_ENDCOB","X3_TIPO")		,GetSx3Cache("A1_ENDCOB","X3_TAMANHO")	,GetSx3Cache("A1_ENDCOB","X3_DECIMAL")	},;
					{ "ENDFIS"			,GetSx3Cache("A1_END","X3_TIPO")		,GetSx3Cache("A1_END","X3_TAMANHO")		,GetSx3Cache("A1_END","X3_DECIMAL")		},;
					{ "BAIRROC"			,GetSx3Cache("A1_BAIRROC","X3_TIPO")	,GetSx3Cache("A1_BAIRROC","X3_TAMANHO")	,GetSx3Cache("A1_BAIRROC","X3_DECIMAL")	},;
					{ "BAIRRO"			,GetSx3Cache("A1_BAIRRO","X3_TIPO")		,GetSx3Cache("A1_BAIRRO","X3_TAMANHO")	,GetSx3Cache("A1_BAIRRO","X3_DECIMAL")	},;
					{ "CEPC"			,GetSx3Cache("A1_CEPC","X3_TIPO")		,GetSx3Cache("A1_CEPC","X3_TAMANHO")	,GetSx3Cache("A1_CEPC","X3_DECIMAL")	},;
					{ "CEP"				,GetSx3Cache("A1_CEP","X3_TIPO")		,GetSx3Cache("A1_CEP","X3_TAMANHO")		,GetSx3Cache("A1_CEP","X3_DECIMAL")		},;
					{ "MUNC"			,GetSx3Cache("A1_MUNC","X3_TIPO")		,GetSx3Cache("A1_MUNC","X3_TAMANHO")	,GetSx3Cache("A1_MUNC","X3_DECIMAL")	},;
					{ "MUN"				,GetSx3Cache("A1_MUN","X3_TIPO")		,GetSx3Cache("A1_MUN","X3_TAMANHO")		,GetSx3Cache("A1_MUN","X3_DECIMAL")		},;
					{ "ESTC"			,GetSx3Cache("A1_ESTC","X3_TIPO")		,GetSx3Cache("A1_ESTC","X3_TAMANHO")	,GetSx3Cache("A1_ESTC","X3_DECIMAL")	},;
					{ "EST"				,GetSx3Cache("A1_EST","X3_TIPO")		,GetSx3Cache("A1_EST","X3_TAMANHO")		,GetSx3Cache("A1_EST","X3_DECIMAL")		},;
					{ "CGC"				,GetSx3Cache("A1_CGC","X3_TIPO")		,GetSx3Cache("A1_CGC","X3_TAMANHO")		,GetSx3Cache("A1_CGC","X3_DECIMAL")		},;
					{ "INSCR"			,GetSx3Cache("A1_INSCR","X3_TIPO")		,GetSx3Cache("A1_INSCR","X3_TAMANHO")	,GetSx3Cache("A1_INSCR","X3_DECIMAL")	},;
					{ "EMAIL"			,GetSx3Cache("A1_EMAIL","X3_TIPO")		,GetSx3Cache("A1_EMAIL","X3_TAMANHO")	,GetSx3Cache("A1_EMAIL","X3_DECIMAL")	},;
					{ "HIST"			,GetSx3Cache("E1_HIST","X3_TIPO")		,GetSx3Cache("E1_HIST","X3_TAMANHO")	,GetSx3Cache("E1_HIST","X3_DECIMAL")	},;
					{ "ACRESC"			,GetSx3Cache("E1_ACRESC","X3_TIPO")		,GetSx3Cache("E1_ACRESC","X3_TAMANHO")	,GetSx3Cache("E1_ACRESC","X3_DECIMAL")	},;
					{ "DECRESC"			,GetSx3Cache("E1_DECRESC","X3_TIPO")	,GetSx3Cache("E1_DECRESC","X3_TAMANHO")	,GetSx3Cache("E1_DECRESC","X3_DECIMAL")	},;		//{ "ZZSUBCO"			,"C" ,03 ,0},;
					{ "REGISTRO"		,"C" ,15 ,0},;
					{ "STATS"			,"C" ,01 ,0}}

	oTempTable := FWTemporaryTable():New( "TBOL" )

	oTemptable:SetFields( aCampos )
	oTempTable:AddIndex("indice1", {"NUMERO","PARCELA"} )
	oTempTable:Create()

	cQrySe1 := "SELECT	SE1.E1_FILIAL, SE1.E1_PREFIXO, SE1.E1_NUM, SE1.E1_PARCELA, SE1.E1_TIPO, SE1.E1_CLIENTE, SE1.E1_LOJA, "+cEOL
	cQrySe1 += "		SA1.A1_XCODADM, SA1.A1_XNOMADM, SA1.A1_XMAILAD, SA1.A1_XCDCADM, SE1.E1_HIST , "+cEOL
	cQrySe1 += "		(CASE 	WHEN SE1.E1_PORTADO = '356' THEN '033' ELSE SE1.E1_PORTADO END) [E1_PORTADO], SE1.E1_NUMBOR, "+cEOL
	cQrySe1 += "		SE1.E1_AGEDEP, SE1.E1_CONTA, SE1.E1_EMISSAO, SE1.E1_VENCTO, SE1.E1_VENCREA, SE1.E1_VLCRUZ, SE1.E1_SALDO, "+cEOL
	cQrySe1 += "		(SE1.E1_PIS + SE1.E1_COFINS + SE1.E1_CSLL) AS PCC, E1_IRRF, E1_VRETISS, "+cEOL
	cQrySe1 += "		SE1.E1_CODBAR, SE1.E1_CODDIG, SE1.E1_VALOR, SE1.E1_NUMBCO, SE1.E1_SITUACA, SE1.E1_IDCNAB, SA1.A1_NOME, "+cEOL
	cQrySe1 += "		SA1.A1_ENDCOB, SA1.A1_END AS ENDFIS, SA1.A1_BAIRROC, SA1.A1_BAIRRO, SA1.A1_CEPC, SA1.A1_CEP, SA1.A1_MUNC, SA1.A1_MUN, "+cEOL
	cQrySe1 += "		SA1.A1_ESTC, SA1.A1_EST, SA1.A1_CGC, SA1.A1_INSCR, SA1.A1_EMAIL, SE1.E1_ACRESC, SE1.E1_DECRESC, "+cEOL	//SE1.E1_ZZSUBCO,
	cQrySe1 += "		LTRIM(RTRIM(CONVERT(NCHAR,SE1.R_E_C_N_O_))) AS RECNO, STATS='0' "+cEOL
	cQrySe1 += "FROM 	" + RetSqlName("SE1") + " SE1 WITH(NOLOCK) "+cEOL
	cQrySe1 += "		INNER JOIN 	" + RetSqlName("SA1") + " SA1 WITH(NOLOCK) ON SA1.A1_FILIAL=SE1.E1_FILIAL AND SA1.A1_COD = SE1.E1_CLIENTE "+cEOL
	cQrySe1 += "												AND SA1.A1_LOJA = SE1.E1_LOJA AND SA1.D_E_L_E_T_<>'*' "+cEOL
	cQrySe1 += "WHERE SE1.D_E_L_E_T_ = '' "+cEOL
	cQrySe1 += "	AND SE1.E1_FILIAL = '" + xFilial("SE1") + "' "+cEOL
	cQrySe1 += "	AND E1_TIPO NOT IN ('IR-','IS-','CF-','CS-','PI-') "+cEOL
	cQrySe1 += "	AND SE1.E1_BAIXA = '' "+cEOL
	cQrySe1 += "	AND SE1.E1_EMISSAO BETWEEN '" + Dtos(MV_PAR05) + "' AND '" + Dtos(MV_PAR06) + "' "+cEOL
	cQrySe1 += "	AND SE1.E1_PREFIXO BETWEEN '" + MV_PAR07 + "' AND '" + MV_PAR08 + "' "+cEOL
	cQrySe1 += "	AND SE1.E1_NUM BETWEEN '" + MV_PAR09 + "' AND '" + MV_PAR10 + "' "+cEOL
	cQrySe1 += "	AND SE1.E1_VENCTO BETWEEN '" + Dtos(MV_PAR11) + "' AND '" + Dtos(MV_PAR12) + "' "+cEOL
	cQrySe1 += "	AND SE1.E1_TIPO BETWEEN '" + MV_PAR13 + "' AND '" + MV_PAR14 + "' "+cEOL
	cQrySe1 += "	AND SE1.E1_CLIENTE BETWEEN '" + MV_PAR15 + "' AND '" + MV_PAR16 + "' "+cEOL
	cQrySe1 += "	AND SE1.E1_LOJA BETWEEN '" + MV_PAR17 + "' AND '" + MV_PAR18+ "' "+cEOL
	cQrySe1 += "	AND SE1.E1_NUMBOR BETWEEN '" + MV_PAR19 + "' AND '" + MV_PAR20 + "' "+cEOL
	If !empty(MV_PAR21)
		cQrySe1 += "	AND SUBSTRING(SA1.A1_XNOMADM,1,99) like '" + AllTrim(MV_PAR21) + "%' "+cEOL
	Else
		//cQrySe1 += "	AND SA1.A1_XNOMADM = '' "+cEOL
	EndIf
	cQrySe1 += "ORDER BY SE1.E1_FILIAL , SE1.E1_PREFIXO , SE1.E1_NUM , SE1.E1_PARCELA , SE1.E1_TIPO "+cEOL

	If Select("TRI") > 0
		dbSelectArea("TRI")
		TRI->(DbCloseArea())
	EndIf

	dbUseArea(.T.,"TOPCONN", TcGenQry(,,cQrySe1), "TRI", .F., .T.)
	TRI->(dbGoTop())

	While !TRI->(Eof())

		TBOL->(RecLock("TBOL",.T.))
		TBOL->OK			:= Space(2)
		TBOL->FILIAL		:= TRI->E1_FILIAL
		TBOL->PREFIXO		:= TRI->E1_PREFIXO
		TBOL->NUMERO		:= TRI->E1_NUM
		TBOL->PARCELA		:= TRI->E1_PARCELA
		TBOL->TIPO			:= TRI->E1_TIPO
		TBOL->CLIENTE		:= TRI->E1_CLIENTE
		TBOL->LOJA			:= TRI->E1_LOJA
		TBOL->ADMIN			:= TRI->A1_XCODADM
		TBOL->NADMIN		:= TRI->A1_XNOMADM
		TBOL->MAILADM		:= TRI->A1_XMAILAD
		TBOL->CODCADM		:= TRI->A1_XCDCADM
		TBOL->BANCO			:= TRI->E1_PORTADO
		TBOL->AGENCIA		:= TRI->E1_AGEDEP
		TBOL->CONTA			:= TRI->E1_CONTA
		TBOL->EMISSAO		:= STOD(TRI->E1_EMISSAO)
		TBOL->VENCTO		:= STOD(TRI->E1_VENCTO)
		TBOL->VENCREA		:= STOD(TRI->E1_VENCREA)
		TBOL->VLCRUZ		:= Round(TRI->E1_VLCRUZ,2)
		TBOL->SALDO			:= Round(TRI->E1_SALDO,2)
		TBOL->PCC			:= Round(TRI->PCC,2)
		TBOL->IRRF			:= Round(TRI->E1_IRRF,2)
		TBOL->RETISS		:= Round(TRI->E1_VRETISS,2)
		TBOL->CODBAR		:= TRI->E1_CODBAR
		TBOL->CODDIG		:= TRI->E1_CODDIG
		TBOL->VALOR			:= Round(TRI->E1_VALOR,2)
		TBOL->NUMBCO		:= right(allTrim(TRI->E1_NUMBCO),GetSx3Cache("EE_FAXATU","X3_TAMANHO"))
		TBOL->NUMBOR		:= TRI->E1_NUMBOR
		TBOL->SITUACA		:= TRI->E1_SITUACA
		TBOL->IDCNAB		:= TRI->E1_IDCNAB
		TBOL->NOME			:= TRI->A1_NOME
		TBOL->ENDCOB		:= TRI->A1_ENDCOB
		TBOL->ENDFIS		:= TRI->ENDFIS
		TBOL->BAIRROC		:= TRI->A1_BAIRROC
		TBOL->BAIRRO		:= TRI->A1_BAIRRO
		TBOL->CEPC			:= TRI->A1_CEPC
		TBOL->CEP			:= TRI->A1_CEP
		TBOL->MUNC			:= TRI->A1_MUNC
		TBOL->MUN			:= TRI->A1_MUN
		TBOL->ESTC			:= TRI->A1_ESTC
		TBOL->EST			:= TRI->A1_EST
		TBOL->CGC			:= TRI->A1_CGC
		TBOL->INSCR			:= TRI->A1_INSCR
		TBOL->EMAIL			:= TRI->A1_EMAIL
		TBOL->HIST			:= TRI->E1_HIST
		TBOL->ACRESC		:= Round(TRI->E1_ACRESC,2)
		TBOL->DECRESC		:= Round(TRI->E1_DECRESC,2)
		TBOL->REGISTRO		:= TRI->RECNO
		TBOL->STATS			:= TRI->STATS
		TBOL->(MsUnLock())

		TRI->(dbSkip())

	EndDo

	TRI->(dbCloseArea())

	If (Select("TRI") <> 0)
		dbSelectArea("TRI")
		TRI->(DbCloseArea())
	EndIf

Return(oTempTable)


/*--------------------------------------------------------------------------------*/
Static Function VVFIN01B(cArq, oDlg1)

	oDlg1:End()

	If(Select("TBOL") <> 0)
		dbSelectArea("TBOL")
		dbCloseArea()
	EndIf

	oTempTable:Delete()

Return(Nil)


/*--------------------------------------------------------------------------------*/
Static Function VVFIN01C()

	RecLock("TBOL",.F.)
	If Marked("OK")
		TBOL->OK := cMark
		nQtdN++
	Else
		TBOL->OK := Space(1)
		nQtdN--
	EndIf
	MSUNLOCK()

	oMark:oBrowse:Refresh()
	//oSay3:Refresh()

Return(Nil)


/*--------------------------------------------------------------------------------*/
Static Function VVFIN01D()

	dbSelectArea("TBOL")
	TBOL->(dbGoTop())
	While TBOL->(!Eof())

		RecLock("TBOL",.F.)
		If(TBOL->OK <> cMark)
			TBOL->OK := cMark
			nQtdN++
		Else
			TBOL->OK := Space(1)
			nQtdN--
		EndIf
		MSUNLOCK()

		TBOL->(DBSKIP())
	EndDo

	dbSelectArea("TBOL")
	TBOL->(dbGoTop())

	oMark:oBrowse:Refresh()
	//oSay3:Refresh()

Return(Nil)


/*--------------------------------------------------------------------------------*/
Static Function VVFIN01E()

	Private lEnd		:= .F.
	Private Titulo		:= "Boleto bancario"
	Private nLin		:= 80
	Private Cabec1		:= ""
	Private Cabec2		:= ""
	private oPrint
	Private aDados		:= {}
	Private nTempo		:= 800000 //Tempo de execução
	Private cMsgErro	:= ""
	Private cMsgErro2	:= ""
	Private oProcesso	:= Nil

	SetPrvt("_vBoletos")

	If !empty(MV_PAR21)
		If Empty(cGMailAdm)
			ApMsgAlert("Favor preencher o e-mail da Administradora para envio dos boletos.","Atenção")
			Return
		EndIf
	EndIf

	If(nQtdN <= 0)

		ApMsgAlert("Selecione os titulos para geração de boletos.","Atenção")

	Else

		oProcesso := MsNewProcess():New({|lEnd| RunReport(Cabec1,Cabec2,Titulo,nLin) },"Enviando Boletos ...")//Funcao de leitura do arquivo que transforma o conteudo lido em Array
		oProcesso:Activate()

		dbSelectArea("TBOL")
		TBOL->(dbGoTop())
		nQtdN     := 0
		oMark:oBrowse:Refresh()
		oDlg1:refresh()

	Endif

Return(Nil)


/*-----------------------------------------------------------------------------*/
Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

	Local lSetup		:= .T.
	Local lRet			:= .T.
	Local nXY			:= 1
	Local _N1			:= 0
	Local nI			:= 0
	Local aBoleto		:= {}
	Local aBolAdm		:= {}
	Local cEOL			:= Chr(13) + Chr(10)
	Local cQuery		:= ""

	Private cFilePrtx	:= "Boletos_dia_" + dToS(Date()) + "-" + Replace(Time(),":","")
	Private nDevice		:= IMP_PDF
	Private lAdjToLeg	:= .T.
	Private lDisabSet	:= .T. //lSetup
	Private lViewPDF	:= IiF(MV_PAR23==1, .T., .F.)
	Private oPrint

	If !ExistDir(cDir)
		MakeDir(cDir)
	Else
		aFileDel := {}
		aFileDel := directory(cDir+"*.pdf*", "D")
		For _N1 := 1 To Len(aFileDel)
			If aFileDel[_N1][3] < date()-10    //apaga arquivos com mais de 10 dias
				cFileDel     := cDir + aFileDel[_N1][1]
				fErase(cFileDel)
			EndIf
		Next _N1
	EndIf

	oProcesso:SetRegua1(nQtdN)

	If MV_PAR27 == 1 .or. MV_PAR22 == 1
		oPrint := FWMSPrinter():New(cFilePrtx, nDevice, lAdjToLeg, cDir, lDisabSet, , , , , , .F., lViewPDF)
		oPrint:SetPortrait()
	EndIf

	dbSelectArea("TBOL")
	TBOL->(dbGoTop())

	While TBOL->(!Eof())

		If(TBOL->OK == cMark)

			dbSelectArea("SE1")
			//SE1->(DbSetOrder(1))	//E1_FILIAL, E1_PREFIXO, E1_NUM, E1_PARCELA, E1_TIPO
			//Dbseek(xFilial("SE1")+TBOL->PREFIXO+TBOL->NUMERO+TBOL->PARCELA+TBOL->TIPO+TBOL->CLIENTE+TBOL->LOJA)
			SE1->(DbSetOrder(2))	//E1_FILIAL, E1_CLIENTE, E1_LOJA, E1_PREFIXO, E1_NUM, E1_PARCELA, E1_TIPO
			Dbseek(xFilial("SE1")+TBOL->CLIENTE+TBOL->LOJA+TBOL->PREFIXO+TBOL->NUMERO+TBOL->PARCELA+TBOL->TIPO)

			If Empty(TBOL->NUMBCO)

				If AllTrim(TBOL->REGISTRO) == cValToChar(SE1->(RECNO()))

					dbSelectArea("SEE")
					SEE->(DbSetOrder(1))	//EE_FILIAL, EE_CODIGO, EE_AGENCIA, EE_CONTA, EE_SUBCTA
					If Dbseek(xFilial("SEE")+MV_PAR01+MV_PAR02+MV_PAR03+MV_PAR04)

						lGeraNum	:= .T.
						cNNum	:= StrZero(VAL(SEE->EE_FAXATU),GetSx3Cache("EE_FAXATU","X3_TAMANHO"))
						While lGeraNum

							If Select("TMP") > 0
								TMP->(dbclosearea())
							EndIf

							cQuery := "SELECT COUNT(*) AS QTDNUM "+cEOL
							cQuery += "FROM " + RetSqlName("SE1") + " AS SE1 WITH(NOLOCK) "+cEOL
							cQuery += "WHERE D_E_L_E_T_<> '*'  "+cEOL
							cQuery += "		AND E1_FILIAL = '" + xFilial("SE1") + "'  "+cEOL
							cQuery += "		AND (E1_PORTADO = '"+MV_PAR01+"' OR E1_PORTADO = '') "+cEOL
							cQuery += "		AND E1_NUMBCO <> '' "+cEOL
							cQuery += "		AND CONVERT(BIGINT, LTRIM(RTRIM(E1_NUMBCO))) = "+AllTrim(str(VAL(cNNum)))+" "+cEOL

							TCQUERY cQuery NEW ALIAS "TMP"
							DbSelectarea("TCQ")

							If TMP->QTDNUM == 0
								lGeraNum := .F.
							Else
								cNNum := SOMA1(StrZero(VAL(cNNum),GetSx3Cache("EE_FAXATU","X3_TAMANHO")))
							EndIf

						EndDo

						RecLock("SE1",.F.)
						SE1->E1_NUMBCO		:= cNNum
						MsUnLock()

						RecLock("TBOL",.F.)
						TBOL->NUMBCO		:= cNNum
						MsUnLock()

						RecLock("SEE",.F.)
						SEE->EE_FAXATU		:= SOMA1(StrZero(VAL(cNNum),GetSx3Cache("EE_FAXATU","X3_TAMANHO")))
						MsUnLock()

					Else

						ApMsgAlert("Não encontrado banco informado nos parametros para a empresa.","Favor iniciar os procesos no Banco/Empresa corretos.")
						Return

					EndIf

				EndIf
			EndIf

			If empty(SE1->E1_PORTADO)

				RecLock("SE1",.F.)
				SE1->E1_PORTADO		:= MV_PAR01
				SE1->E1_AGEDEP		:= MV_PAR02
				SE1->E1_CONTA		:= MV_PAR03
				//SE1->E1_ZZSUBCO	:= MV_PAR04
				MsUnLock()

				RecLock("TBOL",.F.)
				TBOL->BANCO			:= MV_PAR01
				TBOL->AGENCIA		:= MV_PAR02
				TBOL->CONTA			:= MV_PAR03
				//TBOL->ZZSUBCO		:= MV_PAR04
				MsUnLock()

			EndIf

			oProcesso:IncRegua1("Enviando Boleto: "+AllTrim(str(nXY))+" de "+AllTrim(str(nQtdN)))
			oProcesso:IncRegua2("Processando Boleto: " + TBOL->NUMERO + " -  Parcela : " + AllTrim(TBOL->PARCELA))

			aDados	:= {}
			lRet	:= .T.
			LeArqIni()
			aBoleto := _fBoleto(lSetup)

			If !empty(mv_par21)
				aAdd(aBolAdm,aBoleto)
			EndIf

			If AllTrim(cMsgErro) <> ""
				cMsgErro2 += cMsgErro + CHR(13)+CHR(10)
			EndIf

			dbSelectArea("TBOL")
			TBOL->(dbGoTop())

			nXY++

		EndIf

		TBOL->(DBSKIP())

	EndDo

	If MV_PAR27 == 1

		cFilePrint := cDir+cFilePrtx
		File2Printer( cFilePrint, "PDF" )
		oPrint:cPathPDF:= cDir
		oPrint:Preview()

		While !(FILE(cDir+cFilePrtx+".pdf"))
			If _N1 < nTempo
				_N1++
			Else
				If MsgYesNo("Erro na geração do arquivo PDF., Continua a aguardar")
					_N1 := 1
				Else
					Return
				End
			EndIf
		EndDo

	Else

		If MV_PAR22 == 1

			cFilePrint := cDir+cFilePrtx
			File2Printer( cFilePrint, "PDF" )
			oPrint:cPathPDF:= cDir
			oPrint:Preview()

			While !(FILE(cDir+cFilePrtx+".pdf"))
				If _N1 < nTempo
					_N1++
				Else
					If MsgYesNo("Erro na geração do arquivo PDF., Continua a aguardar")
						_N1 := 1
					Else
						Return
					End
				EndIf
			EndDo

			cBoleto	:= cFilePrtx

		Else 
			cBoleto := ""
		EndIf

		If !empty(mv_par21)

			lEnvMail := IIF(MV_PAR24 == 1,.T.,.F.)

			If lEnvMail
				aBolSepA := {}
				aBolSepB := {}
				nCount	:= 0
				For nI := 1 to Len(aBolAdm)
					aAdd(aBolSepA,aBolAdm[nI])
					nCount++
					If nCount == nQtdBol .and. Empty(cBoleto)
						aAdd(aBolSepB,aBolSepA)
						aBolSepA := {}
						nCount := 0
					EndIf
				next nI

				If (nCount > 0 .and. nCount <= nQtdBol) .or. !Empty(cBoleto)
					aAdd(aBolSepB,aBolSepA)
				EndIf
				
				For nI := 1 to len(aBolSepB)
					EnvEmail(Alltrim(cGMailAdm), AllTrim(MV_PAR25), aBolSepB[nI], Len(aBolAdm), AllTrim(Str(nI))+" de "+AllTrim(Str(len(aBolSepB))) , cBoleto)
				Next nI

			EndIf

		EndIf
	
	EndIf

	If AllTrim(cMsgErro2) <> ""

		DEFINE FONT oFont6 NAME "Courier New" SIZE 6,20

		DEFINE MSDIALOG oErroMsg FROM 0,0 TO 330,420 PIXEL TITLE "Boletos com erro de envio."
		@ 005,005 GET oMemo VAR cMsgErro2 MEMO SIZE 200,135 FONT oFont6 PIXEL OF oErroMsg
		@ 150,005 BUTTON "Finalizar" SIZE 55,10 ACTION (lsaida:=.T.,oErroMsg:end())
		ACTIVATE MSDIALOG oErroMsg CENTER

	EndIf

Return


/*--------------------------------------------------------------------------------*/
Static Function LeArqIni()

	Local cQrySa6	:= ""
	Local cEOL		:= Chr(13) + Chr(10)
	Local nPcc		:= 0 

	If TBOL->PCC >= 10
		nPcc := TBOL->PCC
	EndIf

	If MV_PAR01 == '341'		//Banco Itaú

		aAdd(aDados,{"Logotipo da Empresa"			,"\Boletos\Configuracao\logo_itau2.bmp"									}) //01
		aAdd(aDados,{"Nome do Banco"				,"BANCO ITAU S.A."														}) //02
		aAdd(aDados,{"Codigo do Banco"				,TBOL->BANCO															}) //03
		aAdd(aDados,{"Digito do Banco"				,"7"																	}) //04
		aAdd(aDados,{"Linha Digitavel"				,TBOL->CODDIG															}) //05
		aAdd(aDados,{"Texto do Local de Pagamento"	,"EM QUALQUER BANCO OU CORRESP. NAO BANCARIO"							}) //06
		aAdd(aDados,{"Data de Vencimento"			,TBOL->VENCTO															}) //07
		aAdd(aDados,{"Cedente"						,Upper(AllTrim(SM0->M0_NOMECOM))										}) //08
		aAdd(aDados,{"Agencia"						,TBOL->AGENCIA															}) //09
		aAdd(aDados,{"Codigo do Cedente"			,TBOL->CONTA															}) //10
		aAdd(aDados,{"Data do Documento"			,TBOL->EMISSAO															}) //11
		aAdd(aDados,{"Numero do Documento"			,TBOL->(AllTrim(PREFIXO)+NUMERO+AllTrim(PARCELA))						}) //12
		aAdd(aDados,{"Especie do Documento"			,"DSI"																	}) //13		//(DM) DUPLICATA MERCANTIL - (NP) NOTA PROMISSÓRIA - (NS) NOTA DE SEGURO - (RC) RECIBO - (DS) DUPLICATA DE SERVIÇOS.
		aAdd(aDados,{"Aceite"						,"N"																	}) //14
		aAdd(aDados,{"Data do Processamento"		,TBOL->EMISSAO															}) //15
		aAdd(aDados,{"Nosso Numero"					,Right(Alltrim(TBOL->NUMBCO),8)											}) //16
		aAdd(aDados,{"Uso do Banco"					,""																		}) //17
		aAdd(aDados,{"Carteira"						,"109"																	}) //18
		aAdd(aDados,{"Especie"						,"R$"																	}) //19
		aAdd(aDados,{"Quantidade"					,""																		}) //20
		aAdd(aDados,{"Valor"						,""																		}) //21
		aAdd(aDados,{"Valor do Documento"			,TBOL->VALOR - ( nPcc + TBOL->IRRF + TBOL->RETISS )						}) //22
		aAdd(aDados,{"Instrucao Fixa"				,"Instruções de responsabilidade do BENEFICIÁRIO. Qualquer dúvida sobre este boleto contate o beneficiário."									}) //23
		aAdd(aDados,{"Instrucao 1"					,"É vetado o pagamento do valor deste título por meio de depósito ou transferência bancária."													}) //24
		If GETMV('AT_TMITAU') == 0
			aAdd(aDados,{"Instrucao 2"					,""																																				}) //25
		Else
			aAdd(aDados,{"Instrucao 2"					,"Cobrar multa de R$ "+ALLTRIM(TRANSFORM(((TBOL->VALOR-TBOL->PCC)*(GETMV('AT_TMITAU')/100)),PESQPICT("SE1","E1_VALOR")))+" apos o vencimento"	}) //25
		EndIf
		If GETMV('AT_TJITAU') == 0
			aAdd(aDados,{"Instrucao 3"					,""																																				}) //26
		Else
			aAdd(aDados,{"Instrucao 3"					,"Apos o Vencimento cobrar juros de R$ "+ALLTRIM(TRANSFORM(((TBOL->VALOR-TBOL->PCC)*(GETMV('AT_TJITAU')/100))/30,PESQPICT("SE1","E1_VALOR")))+ " ao dia"	}) //26
		EndIf
		aAdd(aDados,{"Sacado"						,Upper(AllTrim(TBOL->NOME))												}) //27
		aAdd(aDados,{"Enderecao do Sacado"			,Upper(AllTrim(TBOL->ENDFIS))											}) //28
		aAdd(aDados,{"Bairro do Sacado"				,Upper(AllTrim(TBOL->BAIRRO))											}) //29
		aAdd(aDados,{"Cep do Sacado"				,TBOL->CEP																}) //30
		aAdd(aDados,{"Municipio do Sacado"			,Upper(AllTrim(TBOL->MUN))												}) //31
		aAdd(aDados,{"Estado do Sacado"				,Upper(AllTrim(TBOL->EST))												}) //32
		aAdd(aDados,{"CNPJ do Sacado"				,TBOL->CGC																}) //33
		aAdd(aDados,{"Inscricao Estadual do Sacado"	,TBOL->INSCR															}) //34
		aAdd(aDados,{"Convenio"						,""																		}) //35
		AADD(aDados,{"Acrescimo"					,TBOL->ACRESC															}) //36
		AADD(aDados,{"Decrescimo"					,TBOL->DECRESC															}) //37
		AADD(aDados,{"Tipo Cobrança"				,"2"																	}) //38
		AADD(aDados,{"Moeda"						,"9"																	}) //39
		aAdd(aDados,{"CGC"							,Transform(SM0->M0_CGC,"@R 99.999.999/9999-99")							}) //40

		If Select("TCQ") > 0
			TCQ->(dbclosearea())
		EndIf

		cQrySa6 := "SELECT A6_DVAGE, A6_DVCTA FROM " + RetSqlName("SA6") + " SA6 "+cEOL
		cQrySa6 += "WHERE D_E_L_E_T_<>'*' "+cEOL
		cQrySa6 += "	AND A6_FILIAL= '" + xFilial("SA6") + "' "+cEOL
		cQrySa6 += "	AND A6_COD='"+TBOL->BANCO+"' "+cEOL
		cQrySa6 += "	AND A6_AGENCIA='"+TBOL->AGENCIA+"' "+cEOL
		cQrySa6 += "	AND A6_NUMCON='"+TBOL->CONTA+"' "+cEOL

		TCQUERY cQrySa6 NEW ALIAS "TCQ"
		DbSelectarea("TCQ")

		If AllTrim(TCQ->A6_DVAGE) <>""
			aAdd(aDados,{"Dig. Agencia"					,AllTrim(TCQ->A6_DVAGE)												}) //41
		Else
			aAdd(aDados,{"Dig. Agencia"					,""																	}) //41
		End

		If AllTrim(TCQ->A6_DVCTA) <>""
			aAdd(aDados,{"Dig. Conta"					,AllTrim(TCQ->A6_DVCTA)												}) //42
		Else
			aAdd(aDados,{"Dig. Conta"					,""																	}) //42
		End

		aAdd(aDados,{"Endereço Beneficiário"			,AllTrim(SM0->M0_ENDCOB) + " - " + AllTrim(SM0->M0_BAIRCOB) + " - " + ;
			AllTrim(SM0->M0_CIDCOB) + "/" + AllTrim(SM0->M0_ESTCOB) + ;
			" - CEP:" + SUBSTR(SM0->M0_CEPCOB,1,5) + "-" + SUBSTR(SM0->M0_CEPCOB,6,3)										}) //43

		aAdd(aDados,{"Instrucao 1b"					,"Nessa hipótese o título permanecerá em aberto junto ao banco."	}) //44

		If !empty(TBOL->HIST) .or. TBOL->PREFIXO <> 'RPS'
			aAdd(aDados,{"Instrucao 1c"					,"Competência: "+AllTrim(TBOL->HIST)									}) //45
		Else
			DbSelectArea("SC5")
			DbSetOrder(11)		//C5_FILIAL, C5_SERIE, C5_NOTA
			DbSeek(xfilial("SC5")+TBOL->PREFIXO+TBOL->NUMERO)
			aAdd(aDados,{"Instrucao 1c"					,AllTrim(SC5->C5_MENNOTA)												}) //45
		EndIf
		
	EndIf

Return


/*-----------------------------------------------------------------------------*/
Static Function _fBoleto(lSetup)

	Local lUnderLine:= .F.
	Local _N1
	Local ArialN11  := TFont():New("Arial"          ,,11,,.F.,,,,,lUnderLine)
	Local ArialN13  := TFont():New("Arial"          ,,13,,.F.,,,,,lUnderLine)
	Local ArialN15  := TFont():New("Arial"          ,,15,,.F.,,,,,lUnderLine)
	Local ArialN17B := TFont():New("Arial"          ,,17,,.T.,,,,,lUnderLine)
	Local ArialN20B := TFont():New("Arial"          ,,20,,.T.,,,,,lUnderLine)
	Local _cBcoLogo := ""
	Local lCliente  := .T.
	Local cLinhaDg1	:= ""
	Local cLinhaDg2	:= ""
	Local cLinhaDg3	:= ""
	Local cLinhaDg4	:= ""
	Local nDigVer	:= ""
	Local cDAC		:= ""
	Local cCodBarP1	:= ""
	Local cCodBarP2:= ""
	Local cFilePrt	:= ""
	Local aBoleto	:= {}

	Private cLinhaDig	:= ""
	Private cLinhaCb	:= ""

	If empty(mv_par21)  //Administradora
		cFilePrt	:= "Boleto_"+"_"+AllTrim(aDados[12][2])
	Else
		cFilePrt	:= "Boleto_"+AllTrim(TBOL->CODCADM)+" BAPS "+ Substring(Dtos((aDados[7][2])),1,6) + " " + AllTrim(aDados[12][2])
	EndIf

	If !(MV_PAR27 == 1 .or. MV_PAR22 == 1)
		oPrint := FWMSPrinter():New(cFilePrt, nDevice, lAdjToLeg, cDir, lDisabSet, , , , , , .F., lViewPDF)
		oPrint:SetPortrait()
	EndIf

	oPrint:StartPage()

	cLinhaDig	:= ""

	If MV_PAR01 == '341'		//Banco Itau

		// Calculo do DAC do Nosso Numero
		cAgencia	:= Alltrim(aDados[9][2])
		cConta		:= Alltrim(aDados[10][2])
		cCarteira	:= aDados[18][2]
		cNNumero	:= aDados[16][2]

		cLinha		:= cAgencia + cConta + cCarteira + cNNumero
		nDigVer		:= calcLinha(cLinha, .F.)
		cDacNNum	:= Alltrim(Str(nDigVer))

		// Calculo do Grupo 01
		cBanco		:= aDados[3][2]
		cMoeda		:= aDados[39][2]
		cNNumero1	:= Substring(cNNumero,1,2)

		cLinha		:= cBanco + cMoeda + cCarteira + cNNumero1
		nDigVer		:= calcLinha(cLinha, .F.)
		cLinhaDg1 	:= cLinha + Alltrim(Str(nDigVer))

		// Calculo do Grupo 02
		cNNumero2	:= Substring(cNNumero,3,6)
		cAgencia1	:= Substring(cAgencia,1,3)

		cLinha 		:= cNNumero2 + cDacNNum + cAgencia1
		nDigVer		:= calcLinha(cLinha, .F.)
		cLinhaDg2	:= cLinha + Alltrim(Str(nDigVer))

		// Calculo do Grupo 03
		cAgencia2	:= Substring(cAgencia,4,1)
		cDigConta	:= aDados[42][2]
		cZeros		:= "000"

		cLinha		:= cAgencia2 + cConta + cDigConta + cZeros
		nDigVer		:= calcLinha(cLinha, .F.)
		cLinhaDg3 	:= cLinha + Alltrim(Str(nDigVer))

		// Calculo do Grupo 04
		nDias		:= AllTrim(Str((aDados[7][2]) - cTod("07/10/97")))
		nValor		:= StrZero(((aDados[22][2])*100),10)

		cLinhaDg4	:= nDias + nValor

		// Calculo do DAC
		cCodBarP1	:= cBanco + cMoeda
		cCodBarP2	:= nDias + nValor + cCarteira + cNNumero + cDacNNum + cAgencia + cConta + cDigConta + cZeros

		cLinha		:= cCodBarP1 + cCodBarP2
		cDAC		:= calcLinha(cLinha, .T.)

		// Linha Codigo de Barras
		cLinhaCb	:= cCodBarP1 + Alltrim(Str(cDAC)) + cCodBarP2

		// Linha Codigo de Barras
		cLinhaDig	:= cLinhaDg1 + cLinhaDg2 + cLinhaDg3 + Alltrim(Str(cDAC)) + cLinhaDg4

		For _N1 := 1 to 2

			If !lCliente
				_cBcoLogo 	:= aDados[1][2]
				_cNomeBanco := aDados[2][2]
				_cDigBanco	:= aDados[4][2]
			Else
				_cBcoLogo 	:= aDados[1][2]
				_cNomeBanco := aDados[2][2]
				_cDigBanco	:= aDados[4][2]
				nLinha 		:= 0095
			Endif

			oPrint:SayBitMap(nLinha-57,0100,_cBcoLogo,085,085)

			oPrint:Say(nLinha,0200,_cNomeBanco,ArialN20B,100)

			cTexto := Substr(cLinhaDig,1,5) + "." + Substr(cLinhaDig,6,5) + " " + Substr(cLinhaDig,11,5) + "." + Substr(cLinhaDig,16,6) + " " + Substr(cLinhaDig,22,5) + "." + Substr(cLinhaDig,27,6) + " " + Substr(cLinhaDig,33,1) + " " + Substr(cLinhaDig,34,14)

			If !Empty(aDados[4][2])
				oPrint:Say(nLinha,00718,"|"+(aDados[3][2])+"-"+aDados[4][2]+"|",ArialN20B,100)
			Else
				oPrint:Say(nLinha,00718,"|"+(aDados[3][2])+"|",ArialN20B,100)
			Endif

			// Imprime a Linha Digitavel
			oPrint:Say(nLinha,0990,cTexto,ArialN17B,100)
			nLinha += 30

			oPrint:Box(nLinha,0100,nLinha+95,1800)
			oPrint:Box(nLinha,1800,nLinha+95,2300)

			nLinha += 30

			oPrint:Say(nLinha,0110,"Local de Pagamento"																,ArialN13,100)
			oPrint:Say(nLinha,1810,"Vencimento"																		,ArialN13,100)

			oPrint:Say(nLinha+37,0120,StrTran(aDados[6][2],'"',"")													,ArialN15,100)
			oPrint:Say(nLinha+37,1820,Dtoc((aDados[7][2]))															,ArialN15,100)

			nLinha += 60

			oPrint:Box(nLinha,0100,nLinha+95,1800)
			oPrint:Box(nLinha,1800,nLinha+95,2300)

			nLinha += 30

			oPrint:Say(nLinha,0110,"Beneficiário"																	,ArialN13,100)
			oPrint:Say(nLinha,1810,"Agência / Código Beneficiário"													,ArialN13,100)

			oPrint:Say(nLinha+37,0120,AllTrim(aDados[8][2]) + "  -  CNPJ : " + (aDados[40][2]) 						,ArialN15,100)
			oPrint:Say(nLinha+37,1820,AllTrim(aDados[9][2]) + " / " + AllTrim(aDados[10][2]) + '-' + (aDados[42][2])	,ArialN15,100)

			nLinha += 60

			oPrint:Box(nLinha,0100,nLinha+95,1800)
			oPrint:Box(nLinha,1800,nLinha+95,2300)

			nLinha += 30

			oPrint:Say(nLinha,0110,"Endereço Beneficiário / Sacador Avalista"										,ArialN13,100)
			oPrint:Say(nLinha,1810,""																				,ArialN13,100)

			oPrint:Say(nLinha+37,0120,(aDados[43][2])																,ArialN15,100)
			oPrint:Say(nLinha+37,1820,""																				,ArialN15,100)

			nLinha += 60

			oPrint:Box(nLinha,0100,nLinha+95,0410)
			oPrint:Box(nLinha,0410,nLinha+95,0790)
			oPrint:Box(nLinha,0790,nLinha+95,1170)
			oPrint:Box(nLinha,1170,nLinha+95,1320)
			oPrint:Box(nLinha,1320,nLinha+95,1800)
			oPrint:Box(nLinha,1800,nLinha+95,2300)

			nLinha += 30

			oPrint:Say(nLinha,0110,"Data do Documento"																,ArialN13,100)
			oPrint:Say(nLinha,0420,"Número do Documento"																,ArialN13,100)
			oPrint:Say(nLinha,0800,"Espécie do Documento"															,ArialN13,100)
			oPrint:Say(nLinha,1180,"Aceite"																			,ArialN13,100)
			oPrint:Say(nLinha,1330,"Data do Processamento"															,ArialN13,100)
			oPrint:Say(nLinha,1810,"Nosso Número"																	,ArialN13,100)

			oPrint:Say(nLinha+37,0120,Dtoc((aDados[11][2]))															,ArialN15,100)
			oPrint:Say(nLinha+37,0430,(aDados[12][2])																,ArialN15,100)
			oPrint:Say(nLinha+37,0810,StrTran(aDados[13][2],'"',"") 													,ArialN15,100)
			oPrint:Say(nLinha+37,1190,StrTran(aDados[14][2],'"',"") 													,ArialN15,100)
			oPrint:Say(nLinha+37,1340,Dtoc((aDados[15][2]))															,ArialN15,100)
			oPrint:Say(nLinha+37,1820,aDados[18][2] + "/" + aDados[16][2] + "-" + cDacNNum					,ArialN15,100)

			nLinha += 60

			oPrint:Box(nLinha,0100,nLinha+95,0410)
			oPrint:Box(nLinha,0410,nLinha+95,1630)
			oPrint:Box(nLinha,0630,nLinha+95,0810)
			oPrint:Box(nLinha,0810,nLinha+95,1320)
			oPrint:Box(nLinha,1320,nLinha+95,1800)
			oPrint:Box(nLinha,1800,nLinha+95,2300)

			nLinha += 30

			oPrint:Say(nLinha,0110,"Uso do Banco"												,ArialN13,100)
			oPrint:Say(nLinha,0420,"Carteira"													,ArialN13,100)
			oPrint:Say(nLinha,0640,"Especie"														,ArialN13,100)
			oPrint:Say(nLinha,0820,"Quantidade"													,ArialN13,100)
			oPrint:Say(nLinha,1320,"Valor"														,ArialN13,100)
			oPrint:Say(nLinha,1810,"(=) Valor do Documento"										,ArialN13,100)

			oPrint:Say(nLinha+37,0120,aDados[17][2]												,ArialN15,100)
			oPrint:Say(nLinha+37,0430,aDados[18][2]												,ArialN15,100)
			oPrint:Say(nLinha+37,0650,StrTran(aDados[19][2],'"',"")								,ArialN15,100)
			oPrint:Say(nLinha+37,0830,aDados[20][2]												,ArialN15,100)
			oPrint:Say(nLinha+37,1330,aDados[21][2]												,ArialN15,100)
			oPrint:Say(nLinha+39,1820,Alltrim(Transform((aDados[22][2]),"@E 99,999,999.99"))		,ArialN15,100)
			nValor := (aDados[22][2])

			nLinha += 60

			oPrint:Box(nLinha,0100,nLinha+470,1800)
			oPrint:Box(nLinha,1800,nLinha+95,2300)

			oPrint:Say(nLinha+30 ,0110,StrTran(aDados[23][2],'"',"")								,ArialN13,100)
			oPrint:Say(nLinha+30 ,1820,"(-) Desconto/Abatimento"									,ArialN13,100)
			oPrint:Say(nLinha+80 ,0120,StrTran(aDados[24][2],'"',"")								,ArialN15,100)
			oPrint:Say(nLinha+130,0120,StrTran(aDados[44][2],'"',"")								,ArialN15,100)
//			oPrint:Say(nLinha+180,0120,StrTran(aDados[25][2],'"',"")								,ArialN15,100)
			oPrint:Say(nLinha+180,0120,StrTran(aDados[45][2],'"',"")								,ArialN15,100)
			oPrint:Say(nLinha+230,0120,StrTran(aDados[26][2],'"',"")								,ArialN15,100)
			If aDados[37][2] > 0
				oPrint:Say(nLinha+230,0120,"Conceder abatimento de R$ "+Transform(aDados[37][2],"@E 99,999,999.99")	,ArialN15,100)
			EndIf
			If aDados[36][2] > 0
				oPrint:Say(nLinha+280,0120,"Acrescer o valor de R$ "+Transform(aDados[36][2],"@E 99,999,999.99")		,ArialN15,100)
			EndIf

			nLinha += 90

			oPrint:Box(nLinha,1800,nLinha+95,2300)
			oPrint:Say(nLinha+30,1810,""															,ArialN13,100)

			nLinha += 90

			oPrint:Box(nLinha,1800,nLinha+95,2300)
			oPrint:Say(nLinha+30,1810,"(+) Mora/Multa"											,ArialN13,100)

			nLinha += 90

			oPrint:Box(nLinha,1800,nLinha+95,2300)
			oPrint:Say(nLinha+30,1810,""															,ArialN13,100)

			nLinha += 90

			oPrint:Box(nLinha,1800,nLinha+95,2300)
			oPrint:Say(nLinha+30,1810,"(=) Valor Cobrado"										,ArialN13,100)

			nLinha += 90

			oPrint:Box(nLinha,0100,nLinha+210,2300)
			oPrint:Say(nLinha+40,0110,"Pagador: ",ArialN11,100)
			oPrint:Say(nLinha+40,0260,ALLTRIM(aDados[27][2]) + IF(LEN(ALLTRIM((aDados[33][2])))<12,"   -   RG: ","   -   CNPJ: ") + Transform((aDados[33][2]),IF(LEN(ALLTRIM((aDados[33][2])))<12,"@R 999.999.999-99","@R 99.999.999/9999-99")) + If(ALLTRIM(aDados[34][2])="","","   -   IE: " + Transform((aDados[34][2]),"@R 999.999.999.999")),ArialN15,100)
			oPrint:Say(nLinha+90,0260,ALLTRIM(aDados[28][2]) + "   -   " + ALLTRIM(aDados[29][2]),ArialN15,100)
			oPrint:Say(nLinha+140,0260,"CEP: "+Transform((aDados[30][2]),"@R 99999-999") + "   -   " + ALLTRIM(aDados[31][2]) + "   -   " + ALLTRIM(aDados[32][2]),ArialN15,100)

			oPrint:Say(nLinha+190,0110,"Sacador /Avalista",ArialN11,100)

			If !lCliente

				nRow	:= 61.2
				nCol	:= 2.05
				nWidth	:= 0.02
				nHeigth	:= 1.2
				oPrint:FWMSBAR("INT25" /*cTypeBar*/,nRow ,nCol, cLinhaCb/*cCode*/,oPrint/*oPrint*/,.F./*lCheck*/,/*Color*/,.T./*lHorz*/,nWidth,nHeigth,.F./*lBanner*/,"Arial"/*cFont*/,NIL/*cMode*/,.F./*lPrint*/,2/*nPFWidth*/,2/*nPFHeigth*/,.F./*lCmtr2Pix*/)

				nLinha += 260
				oPrint:Say(nLinha   ,1910,"Autenticação Mecânica",ArialN11,100)
				oPrint:Say(nLinha+35,1880,"FICHA DE COMPENSAÇÃO",ArialN11,100)

			Else

				nLinha += 260
				oPrint:Say(nLinha   ,1910,"Autenticação Mecânica",ArialN11,100)
				oPrint:Say(nLinha+35,1905,"RECIBO DO PAGADOR",ArialN11,100)

				nLinha += 200
				oPrint:Say(nLinha,0010,replicate(".",390),ArialN11,100)

				nLinha += 70
			Endif

			lCliente := .F.

		Next _N1

	EndIf

	oPrint:EndPage()

	//imprime Nota Fiscal
	If MV_PAR28 == 1 .and. TBOL->PREFIXO == "RPS"

		//Posiciona o titulo
		dbSelectArea("SF2")
		DbSetOrder(1)		//F2_FILIAL, F2_DOC, F2_SERIE, F2_CLIENTE, F2_LOJA, F2_FORMUL, F2_TIPO
		DbSeek(xfilial("SF2")+TBOL->NUMERO+TBOL->PREFIXO+TBOL->CLIENTE+TBOL->LOJA)

		Private lPrintLt	:= .T.
		U_RFATR001(lPrintLt)

	EndIf

	//Grava a linha digitável e a linha do codigo de barras
	dbSelectArea("SE1")
	SE1->(DbSetOrder(1))
	Dbseek(xFilial("SE1")+TBOL->PREFIXO+TBOL->NUMERO+TBOL->PARCELA+TBOL->TIPO+TBOL->CLIENTE+TBOL->LOJA)

	If AllTrim(TBOL->REGISTRO) == cValToChar(SE1->(RECNO()))

		RecLock("SE1",.F.)
		SE1->E1_CODBAR		:= cLinhaCb
		SE1->E1_CODDIG		:= cLinhaDig
		MsUnLock()

		RecLock("TBOL",.F.)
		TBOL->CODBAR		:= cLinhaCb
		TBOL->CODDIG		:= cLinhaDig
		MsUnLock()

	EndIf

	If MV_PAR27 <> 1

		If MV_PAR22 <> 1 .or. empty(mv_par21)
		
			cFilePrint := cDir+cFilePrt
			File2Printer( cFilePrint, "PDF" )
			oPrint:cPathPDF:= cDir
			oPrint:Preview()

			While !(FILE(cDir+cFilePrt+".pdf"))

				If _N1 < nTempo
					_N1++
				Else
					If MsgYesNo("Titulo " + TBOL->NUMERO + " -  Parcela : " + AllTrim(TBOL->PARCELA) + " Erro na geração do arquivo PDF., Continua a aguardar")
						_N1 := 1
					Else
						Return
					End
				EndIf

			EndDo
				
		EndIf

		aAdd(aBoleto,{"ADMINISTRA"		, TBOL->ADMIN					})
		aAdd(aBoleto,{"CLIENTE"			, TBOL->CLIENTE					})
		aAdd(aBoleto,{"PREFIXO"			, TBOL->PREFIXO					})
		aAdd(aBoleto,{"NUMERO"			, TBOL->NUMERO					})
		aAdd(aBoleto,{"PARCELA"			, TBOL->PARCELA					})
		aAdd(aBoleto,{"E1_NUMBCO"		, TBOL->NUMBCO					})
		aAdd(aBoleto,{"LINDIGT"			, cTexto						})
		aAdd(aBoleto,{"EMITIDOPOR"		, Alltrim(SM0->M0_NOMECOM)		})
		aAdd(aBoleto,{"EMISSAO"			, Dtoc(TBOL->EMISSAO)			})
		aAdd(aBoleto,{"VENCIMENTO"		, Dtoc(TBOL->VENCTO)			})
		aAdd(aBoleto,{"NOMEEMP"   		, Alltrim(TBOL->NOME)			})
		If MV_PAR22 == 1
			aAdd(aBoleto,{"ARQUIVO"   		, cFilePrtx						})
		Else
			aAdd(aBoleto,{"ARQUIVO"   		, cFilePrt						})
		EndIf
	
		If empty(mv_par21)  //Administradora

			aBolSimp	:= {}
			aAdd(aBolSimp,aBoleto)

			lEnvMail := IIF(MV_PAR24 == 1,.T.,.F.)
			
			If lEnvMail
				EnvEmail(Alltrim(TBOL->EMAIL), AllTrim(MV_PAR25), aBolSimp, 1 ,"1/1", "")
			EndIf

		EndIf

	EndIf

	RecLock("TBOL",.F.)
	TBOL->OK := Space(1)
	MsUnLock()

return (aBoleto)


/*--------------------------------------------------------------------------------*/
Static Function calcLinha(cLinha, DAC)

	Local nY

	If !DAC

		nLinha		:= Len(cLinha)
		nValor		:= 0
		nCounter	:= 0

		While nLinha > 0

			If nCounter == 0
				nCounter := 2
			Else
				nCounter := 1
			Endif

			If (Val(Substr(cLinha,nLinha,1)) * nCounter) <= 9
				nValor   += Val(Substr(cLinha,nLinha,1)) * nCounter
			Else
				nResul := Alltrim(Str(Val(Substr(cLinha,nLinha,1)) * nCounter))
				nConta := Val(Substr(nResul,1,1)) + Val(Substr(nResul,2,1))
				nValor += nConta
			Endif

			nCounter -= 1

			nLinha -= 1

		Enddo

		nResto := (nValor%10)

		If nResto > 0
			nResto := 10 - nResto
		Endif

	Else

		nCounter	:= 4
		nValor		:= 0
		nValorDac	:= 0
		cVerific	:= ""

		For nY := 1 To Len(cLinha)

			nValor		:= Val(Substr(cLinha,nY,1)) * nCounter
			nValorDac	+= nValor
			cVerific	+= AllTrim(Str(nCounter))

			nCounter -= 1
			If nCounter < 2
				nCounter	:= 9
			EndIf

		Next nY

		nResto := Mod(nValorDac,11)

		If nResto == 0 .or. nResto == 1 .or. nResto == 10
			nResto := 1
		Else
			nResto := 11 - nResto
		Endif

	EndIf

Return (nResto)


/*--------------------------------------------------------------------------------*/
Static Function EnvEmail(_cDest, _cCC, aFilePrt, nQdtTot, cEnvParc, cBoleto)

	Local nX
	Local cTexto  := ""
	Local cTxtUrl := ""
	Local cTpArqMail  := 1

	If MV_PAR26 == 1
		_cDest := cMailHomol
	Else
		If !Empty(_cCC)
			_cCC   := _cCC +";"+ cMailCC
		else
			_cCC   := cMailCC
		EndIf
	Endif

	oProcess:=TWFProcess():New("00001",OemToAnsi("Envio de Boleto por Email!"))
	If AllTrim(cFilAnt) == "03"
		oProcess:NewTask("000001","\Boletos\Configuracao\Boleto_03_VVAR.html")
		cTpArqMail := 1
	ElseIf AllTrim(cFilAnt) == "06"
		If nQdtTot == 1
			oProcess:NewTask("000001","\Boletos\Configuracao\Boleto_06_VVSAP.html")
			cTpArqMail := 2
		Else
			oProcess:NewTask("000001","\Boletos\Configuracao\Boleto_06_VVSAP_Adm.html")
		EndIf
	Else
		oProcess:NewTask("000001","\Boletos\Configuracao\Boleto_00.html")
		cTpArqMail := 1
	EndIf
	oHtml:=oProcess:oHtml

	oProcess:cTo      := Alltrim(_cDest)		//Para
	//oProcess:cCc      := Alltrim(_cCC)		//Copia
	oProcess:cBCC      := Alltrim(_cCC)			//Copia Oculta

	If (nQdtTot == 1 .or. !empty(cBoleto))
		oProcess:cSubject := Alltrim(SM0->M0_NOMECOM) + " - Envio de Boleto Bancário"
	Else
		oProcess:cSubject := Alltrim(SM0->M0_NOMECOM) + " - Envio de Boleto Bancário "+cEnvParc
	EndIF
	oProcess:UserSiga := "000000"

	If nQdtTot == 1

		If FILE(cDir + aFilePrt[1,12,2] + ".pdf")

			cFile := cDir + aFilePrt[1,12,2] + ".pdf"
			If !(CpyT2S( cDir + aFilePrt[1,12,2] + ".pdf",cLocSend,.F.))
				cMsgErro := Alltrim(aFilePrt[1,4,2])
				If !empty(aFilePrt[1,5,2])
					cMsgErro := " - Parcela : " + AllTrim(aFilePrt[1,5,2])
				EndIf
				cMsgErro := " - Arquivo não pode ser copiado para o Servidor [" + cLocSend + "]"
			EndIf

		Else

				cMsgErro := Alltrim(aFilePrt[1,4,2])
				If !empty(aFilePrt[1,5,2])
					cMsgErro := " - Parcela : " + AllTrim(aFilePrt[1,5,2])
				EndIf
				cMsgErro := " Arquivo Impresso não Encontrado"

		Endif
		
		dbSelectArea("SF2")
		SF2->(DbSetOrder(1))	//F2_FILIAL, F2_DOC, F2_SERIE, F2_CLIENTE, F2_LOJA, F2_FORMUL, F2_TIPO
		Dbseek(xFilial("SF2")+aFilePrt[1,4,2]+aFilePrt[1,3,2]+aFilePrt[1,2,2])
		If !empty(SF2->F2_NFELETR)
			cTxtUrl := "https://nfe.prefeitura.sp.gov.br/nfe.aspx?"
			cTxtUrl += "ccm="+StrZero(val(SM0->M0_INSCM),8)
			cTxtUrl += "&nf="+AllTrim(SF2->F2_NFELETR)
			cTxtUrl += "&cod="+AllTrim(SF2->F2_CODNFE)
		EndIf

		If cTpArqMail == 1

			oProcess:oHtml:ValByName("NUMERO"		, aFilePrt[1,4,2]													)
			oProcess:oHtml:ValByName("NFISCAL"		, AllTrim(SF2->F2_NFELETR)											)
			oProcess:oHtml:ValByName("EMISSAO"		, aFilePrt[1,9,2]													)
			oProcess:oHtml:ValByName("VENCIMENTO"	, aFilePrt[1,10,2]													)
			oProcess:oHtml:ValByName("NOMEEMP"   	, Alltrim(aFilePrt[1,11,2])											)
			If AllTrim(cFilAnt) == "03"
				oProcess:oHtml:ValByName("TPSERV" 	    , If(empty(F2_MENNOTA),"TESTE ADIANTAMENTO",AllTrim(F2_MENNOTA))	)
			Else
				oProcess:oHtml:ValByName("TPSERV" 	    , AllTrim(F2_MENNOTA)												)
			EndIf
			oProcess:oHtml:ValByName("LINDIGT"		, aFilePrt[1,7,2]													)
			oProcess:oHtml:ValByName("LINK"			, cTxtUrl															)
		
		ElseIf cTpArqMail == 2

			oProcess:oHtml:ValByName("PREFIXO"		, aFilePrt[1,3,2]				)
			oProcess:oHtml:ValByName("NUMERO"		, aFilePrt[1,4,2]				)
			oProcess:oHtml:ValByName("NFISCAL"		, AllTrim(SF2->F2_NFELETR)		)
			oProcess:oHtml:ValByName("EMISSAO"		, aFilePrt[1,9,2]				)
			oProcess:oHtml:ValByName("VENCIMENTO"	, aFilePrt[1,10,2]				)
			oProcess:oHtml:ValByName("NOMEEMP"   	, Alltrim(aFilePrt[1,11,2])		)
			oProcess:oHtml:ValByName("COMPETENCIA" 	, AllTrim(F2_MENNOTA)			)
			oProcess:oHtml:ValByName("LINDIGT"		, aFilePrt[1,7,2]				)
			oProcess:oHtml:ValByName("LINK"			, cTxtUrl						)

		EndIf

		If File(cLocSend + aFilePrt[1,12,2] + ".pdf") .and. AllTrim(cMsgErro)==""
			oProcess:AttachFile(cLocSend + aFilePrt[1,12,2] + ".pdf")
		Endif

	Else

		c_StyleTd := '"width:50pt; border:solid #EA5726 1.0pt; mso-border-themecolor:accent1; border-top:none;' 
		c_StyleTd += 'mso-border-top-alt:solid #EA5726 1.0pt; mso-border-top-themecolor:accent1;' 
		c_StyleTd += 'padding:0cm 5.4pt 0cm 5.4pt; height:12.4pt"'
		c_Style1  := "text-align:Center;margin-bottom:0cm;margin-bottom:.0001pt;line-height:normal;mso-yfti-cnfc:64"

		For nX := 1 to Len(aFilePrt)

			If empty(cBoleto)
			
				If FILE(cDir + aFilePrt[nX,12,2] + ".pdf")

					cFile := cDir + aFilePrt[nX,12,2] + ".pdf"
					If !(CpyT2S( cDir + aFilePrt[nX,12,2] + ".pdf",cLocSend,.F.))
						cMsgErro := Alltrim(aFilePrt[nX,4,2])
						If !empty(aFilePrt[nX,5,2])
							cMsgErro := " - Parcela : " + AllTrim(aFilePrt[nX,5,2])
						EndIf
						cMsgErro := " - Arquivo não pode ser copiado para o Servidor [" + cLocSend + "]"
					EndIf

				Else
						cMsgErro := Alltrim(aFilePrt[nX,4,2])
						If !empty(aFilePrt[nX,5,2])
							cMsgErro := " - Parcela : " + AllTrim(aFilePrt[nX,5,2])
						EndIf
						cMsgErro := " Arquivo Impresso não Encontrado"
				Endif

				If File(cLocSend + aFilePrt[nX,12,2] + ".pdf") .and. AllTrim(cMsgErro)==""
					oProcess:AttachFile(cLocSend + aFilePrt[nX,12,2] + ".pdf")
				Endif
			
			Else

				If nX == 1
					If FILE(cDir + cBoleto + ".pdf")
						cFile := cDir + cBoleto + ".pdf"
						If !(CpyT2S( cDir + cBoleto + ".pdf",cLocSend,.F.))
							cMsgErro := " - Arquivo "+cBoleto+".pdf não pode ser copiado para o Servidor [" + cLocSend + "]"
						EndIf
					Else
						cMsgErro := " Arquivo "+cBoleto+".pdf impresso não encontrado"
					Endif
					
					If File(cLocSend + cBoleto + ".pdf") .and. AllTrim(cMsgErro)==""
						oProcess:AttachFile(cLocSend + cBoleto + ".pdf")
					Endif
				EndIf

			EndIf

			dbSelectArea("SF2")
			SF2->(DbSetOrder(1))	//F2_FILIAL, F2_DOC, F2_SERIE, F2_CLIENTE, F2_LOJA, F2_FORMUL, F2_TIPO
			Dbseek(xFilial("SF2")+aFilePrt[nX,4,2]+aFilePrt[nX,3,2]+aFilePrt[nX,2,2])
			cTxtUrl := "https://nfe.prefeitura.sp.gov.br/nfe.aspx?"
			cTxtUrl += "ccm="+StrZero(val(SM0->M0_INSCM),8)
			cTxtUrl += "&nf="+AllTrim(SF2->F2_NFELETR)
			cTxtUrl += "&cod="+AllTrim(SF2->F2_CODNFE)

			cTexto += '<tr style="mso-yfti-irow:0;height:12.4pt">'
			cTexto += '  <td width=40 valign=top style='+c_StyleTd+'>'	//PREFIXO
			cTexto += '    <p class=MsoNormal style='+c_Style1+'>'+aFilePrt[nX,3,2]+'</p>'
			cTexto += '  </td>'
			cTexto += '  <td width=60 valign=top style='+c_StyleTd+'>'	//NUMERO
			cTexto += '    <p class=MsoNormal style='+c_Style1+'>'+aFilePrt[nX,4,2]+'</p>'
			cTexto += '  </td>'
			cTexto += '  <td width=40 valign=top style='+c_StyleTd+'>'	//NFISCAL
			cTexto += '    <p class=MsoNormal style='+c_Style1+'>'+AllTrim(SF2->F2_NFELETR)+'</p>'
			cTexto += '  </td>'
			cTexto += '  <td width=70 valign=top style='+c_StyleTd+'>'	//EMISSAO
			cTexto += '    <p class=MsoNormal style='+c_Style1+'>'+aFilePrt[nX,9,2]+'</p>'
			cTexto += '  </td>'
			cTexto += '  <td width=70 valign=top style='+c_StyleTd+'>'	//VENCIMENTO
			cTexto += '    <p class=MsoNormal style='+c_Style1+'>'+aFilePrt[nX,10,2]+'</p>'
			cTexto += '  </td>'
			cTexto += '  <td width=120 valign=top style='+c_StyleTd+'>'	//NOMEEMP
			cTexto += '    <p class=MsoNormal style='+c_Style1+'>'+Alltrim(aFilePrt[nX,11,2])+'</p>'
			cTexto += '  </td>'
			cTexto += '  <td width=150 valign=top style='+c_StyleTd+'>'	//COMPETENCIA
			cTexto += '    <p class=MsoNormal style='+c_Style1+'>'+AllTrim(F2_MENNOTA)+'</p>'
			cTexto += '  </td>'
			cTexto += '  <td width=150 valign=top style='+c_StyleTd+'>'	//LINDIGT
			cTexto += '    <p class=MsoNormal style='+c_Style1+'>'+aFilePrt[nX,7,2]+'</p>'
			cTexto += '  </td>'
			cTexto += '  <td width=150 valign=top style='+c_StyleTd+'>'	//LINK
			cTexto += '    <p class=MsoNormal style='+c_Style1+'>'+cTxtUrl+'</p>'
			cTexto += '  </td>'
			cTexto += ' </tr>'
				
		Next nX
	
		oProcess:oHtml:ValByName("c_linha"		, cTexto				)

	EndIf

	oProcess:Start()
	oProcess:Finish()
	WfSendMail()

	apMsgInfo("Boletos enviados com sucesso.", "Boletos Enviados.")

Return
