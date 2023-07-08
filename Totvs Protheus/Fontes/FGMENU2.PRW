#include "TOPCONN.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ                              
ฑฑบPrograma  ณ FGMENU2  บ Autor ณ Douglas V. Franca  บ Data ณ  05/12/05   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Relatorio do Menu dos usuarios.                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Generico.                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ                 
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function FGMENU2()

	If !(alltrim(cusername) == 'csantos' .or. alltrim(cusername) == 'amartins'.or. alltrim(cusername) == 'caquino')
		msgAlert("Acesso restrito!!!", "A T E N ว ร O")
		Return
	EndIf
                                                    
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Declaracao de Variaveis                                             ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	//Parametro MV_XTPMENU onde 0=Por Usuแrio ou 1=Por Grupo (Default)
	Private l_GrpMenu	:= (GetMV("MV_XTPMENU", ,"1") == "1")
	Private CbTxt		:= ""
	Private cDesc1      := "Relacao das liberacoes de acessos atraves do menu"
	Private cDesc2      := ""
	Private cDesc3      := "Ult. Rev.: 29/05/06"
	Private Cabec1 		:= ""
	Private Cabec2   	:= ""
	Private cPict       := ""
	Private lEnd      	:= .F.
	Private lAbortPrint	:= .F.
	Private limite    	:= 132
	Private tamanho	    := "M"
	Private nomeprog	:= "FGMENU2" // Coloque aqui o nome do programa para impressao no cabecalho
	Private nTipo		:= 18
	Private aReturn		:= { "Especifico", 1,"Faturamento", 1, 2, 1, "",1 }
	Private nLastKey	:= 0
	Private titulo 		:= "Relacao de acessos atrav้s do menu"
	Private nLin   		:= 80
	Private cbcont     	:= 00
	Private CONTFL     	:= 01
	Private m_pag      	:= 01
	Private imprime 	:= .T.
	Private wnrel      	:= "FGMENU2" // Coloque aqui o nome do arquivo usado para impressao em disco
	Private n_TotReg	:= 0
	Private c_Perg		:= IIF(l_GrpMenu, "MYXNU70000", "MYXNU40000")
	Private cString 	:= "ZZS"
	Private a_Ordem		:= {}

	If l_GrpMenu
		a_Ordem	:= {"Grupo + M๓dulo + Chave",;
					"M๓dulo + Fun็ใo + Grupo",;
					"Fun็ใo + Grupo + M๓dulo",;
					"Grupo + M๓dulo + Fun็ใo",;
					"M๓dulo + Grupo + Chave"}
	
	Else
		a_Ordem	:= {"Usuแrio + M๓dulo + Chave",;
					"M๓dulo + Fun็ใo + Usuแrio",;
					"Fun็ใo + Usuแrio + M๓dulo",;
					"Usuแrio + M๓dulo + Fun็ใo",;
					"M๓dulo + User + Chave"}
	Endif

	ValidPerg()

	Pergunte(c_Perg,.F.)

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Monta a interface padrao com o usuario...                           ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	wnrel := SetPrint(cString,NomeProg,c_Perg,@titulo,cDesc1,cDesc2,cDesc3,.F.,a_Ordem,.F.,Tamanho,,.F.)

	If nLastKey == 27
		Return
	Endif

	SetDefault(aReturn, cString, .F.)

	If nLastKey == 27
		Return Nil
	Endif

	nTipo := If(aReturn[4]==1, 15, 18)

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Processamento. RPTSTATUS monta janela com a regua de processamento. ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	RptStatus({|| RunOcorre(Cabec1,Cabec2,Titulo,nLin) },Titulo)

Return Nil
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณ RunOcorreบ Autor ณ AP5 IDE            บ Data ณ  25/06/01   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS บฑฑ
ฑฑบ          ณ monta a janela com a regua de processamento.               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function RunOcorre(Cabec1,Cabec2,Titulo,nLin)

	Local c_Query		:= ""
	Local c_QryCnt		:= ""
	Local c_Access		:= ""
	Local c_Quebra		:= ""
	Local c_AuxQuebra	:= ""
	Local n_Ordem		:= aReturn[8]

	c_Query := "SELECT *  "+Chr(13)
	c_Query += "FROM "+RetSqlName("ZZS")+" "+Chr(13)
	c_Query += "WHERE ZZS_FILIAL = '  ' "+Chr(13)
	c_Query += "AND ZZS_USER BETWEEN '"+MV_PAR01+"' AND '"+MV_PAR02+"' "+Chr(13)
	c_Query += "AND ZZS_FUNCAO BETWEEN '"+MV_PAR03+"' AND '"+MV_PAR04+"' "+Chr(13)
	c_Query += "AND ZZS_MODULO BETWEEN '"+MV_PAR05+"' AND '"+MV_PAR06+"' "+Chr(13)
	If MV_PAR07 <> 4 //Todos
		If MV_PAR07 == 1 //Habilitados
			c_Query += "AND ZZS_STATUS IN ('H') "+Chr(13)
		ElseIf MV_PAR07 == 2 //Inibidos
			c_Query += "AND ZZS_STATUS IN ('I') "+Chr(13)
		ElseIf MV_PAR07 == 3 //Desabilitados
			c_Query += "AND ZZS_STATUS IN ('D') "+Chr(13)
		Endif
	Endif
	c_Query += "AND D_E_L_E_T_ = ' ' "+Chr(13)

	If Select("TRB") > 0
		TRB->(DbCloseArea())
	Endif

	c_QryCnt := "SELECT COUNT(*) AS QTDREG FROM ("+c_Query+") AS RESULT "
	
	TCQUERY c_QryCnt NEW ALIAS "TRB"
	
	SetRegua(TRB->QTDREG)
	
	If Select("TRB") > 0
		TRB->(DbCloseArea())
	Endif
	
	If n_Ordem == 1
		c_Query += "ORDER BY ZZS_FILIAL, ZZS_USER, ZZS_MODULO, ZZS_CHAVE "+Chr(13)
		c_Quebra := "ZZS_USER"
	ElseIf n_Ordem == 2
		c_Query += "ORDER BY ZZS_FILIAL, ZZS_MODULO, ZZS_FUNCAO, ZZS_USER "+Chr(13)
		c_Quebra := "ZZS_MODULO"
	ElseIf n_Ordem == 3
		c_Query += "ORDER BY ZZS_FILIAL, ZZS_FUNCAO, ZZS_USER, ZZS_MODULO "+Chr(13)
		c_Quebra := "ZZS_FUNCAO"
	ElseIf n_Ordem == 4
		c_Query += "ORDER BY ZZS_FILIAL, ZZS_USER, ZZS_MODULO, ZZS_FUNCAO "+Chr(13)
		c_Quebra := "ZZS_USER"
	ElseIf n_Ordem == 4
		c_Query += "ORDER BY ZZS_FILIAL, ZZS_MODULO, ZZS_USER, ZZS_CHAVE "+Chr(13)
		c_Quebra := "ZZS_USER"
	Endif
	
	TCQUERY c_Query NEW ALIAS "TRB"
	
	If l_GrpMenu
		c_CabTit := "GRUPO   "
	Else
		c_CabTit := "USUมRIO "
	Endif
	Cabec1 := c_CabTit+"         MำDULO       FUNวรO       TอTULO                           CHAVE        ACESSOS                Status"
	Cabec2 := "                                                                                          1 2 3 4 5 6 7 8 9 10                  "
	//         XXXXXXXXXXXXXXX   XXXXXXXXXX   XXXXXXXXXX   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX   X.XX.XX.XX   X X X X X X X X X X    XXXXXXXXXXXXXXX
	//         012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
	//         0         1         2         3         4         5         6         7         8         9        10        11        12        13 
	
	a_Cols := {0, 18, 31, 44, 77, 90, 113}

	While TRB->(!EOF())
		
		IncRegua()
		
		If lAbortPrint
			@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
			Exit
		Endif
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Impressao do cabecalho do relatorio. . .                            ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If nLin > 60 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
			nLin := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin++
		Endif
		
		c_Access := SubStr(TRB->ZZS_ACESSO, 1, 1) + " " + SubStr(TRB->ZZS_ACESSO, 2, 1) + " " + SubStr(TRB->ZZS_ACESSO, 3, 1) + " "
		c_Access += SubStr(TRB->ZZS_ACESSO, 4, 1) + " " + SubStr(TRB->ZZS_ACESSO, 5, 1) + " " + SubStr(TRB->ZZS_ACESSO, 6, 1) + " "
		c_Access += SubStr(TRB->ZZS_ACESSO, 7, 1) + " " + SubStr(TRB->ZZS_ACESSO, 8, 1) + " " + SubStr(TRB->ZZS_ACESSO, 9, 1) + " "
		c_Access += Right(TRB->ZZS_ACESSO, 1)
		
		@ nLin, a_Cols[01] PSAY TRB->ZZS_USER
		@ nLin, a_Cols[02] PSAY TRB->ZZS_MODULO
		@ nLin, a_Cols[03] PSAY TRB->ZZS_FUNCAO
		@ nLin, a_Cols[04] PSAY Left(TRB->ZZS_TITULO, 30)
		@ nLin, a_Cols[05] PSAY Left(TRB->ZZS_CHAVE, 10)
		@ nLin, a_Cols[06] PSAY c_Access
		@ nLin, a_Cols[07] PSAY IIF(TRB->ZZS_STATUS == "H", "Habilitado", IIF(TRB->ZZS_STATUS == "I", "Inibido", "Desabilitado"))
		nLin++
		
		c_AuxQuebra := &c_Quebra
		
		TRB->(DbSkip())
		
		If &c_Quebra <> c_AuxQuebra
			nLin++
			@ nLin, 000 PSAY __PrtThinLine()
			nLin++
		Endif
		
	Enddo
	
	nLin++
	@ nLin, 000 PSAY __PrtThinLine()
	nLin++
	
	@ nLin, 000 PSAY ""
	
	If lEnd
		@PROW(),00 PSAY "*** CANCELADO PELO OPERADOR!! ***"
	Endif
	
	Set Device To Screen
	
	If aReturn[5] == 1
		Set Printer TO
		dbcommitAll()
		ourspool(wnrel)
	Endif
	
	MS_FLUSH()
	
	TRB->(DbCloseArea())
	
Return Nil
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณVALIDPERG บ Autor ณ AP5 IDE            บ Data ณ  16/01/01   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Verifica a existencia das perguntas criando-as caso seja   บฑฑ
ฑฑบ          ณ necessario (caso nao existam).                             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function ValidPerg()

Local _sAlias := Alias()
Local aRegs := {}
Local i,j

dbSelectArea("SX1")
dbSetOrder(1)
c_Perg := PADR(c_Perg,10)
aRegs:={}

If c_Perg == "MYXNU40000"
	// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
	aAdd(aRegs,{c_Perg,"01","Usuแrio de        ","","","mv_ch1","C",15,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","US2"})
	aAdd(aRegs,{c_Perg,"02","Usuแrio At้       ","","","mv_ch2","C",15,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","US1"})
	aAdd(aRegs,{c_Perg,"03","Fun็ใo de         ","","","mv_ch3","C",10,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{c_Perg,"04","Fun็ใo At้        ","","","mv_ch4","C",10,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{c_Perg,"05","M๓dulo de         ","","","mv_ch5","C",10,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{c_Perg,"06","M๓dulo At้        ","","","mv_ch6","C",10,0,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{c_Perg,"07","Status            ","","","mv_ch7","N",01,0,1,"C","","mv_par07","Habilitado","","","","","Inibido","","","","","Desabilitado","","","","","Todos","","","","","","","","",""})
ElseIf c_Perg == "MYXNU70000"
	// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
	aAdd(aRegs,{c_Perg,"01","Grupo de          ","","","mv_ch1","C",15,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","US2"})
	aAdd(aRegs,{c_Perg,"02","Grupo at้         ","","","mv_ch2","C",15,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","US1"})
	aAdd(aRegs,{c_Perg,"03","Fun็ใo de         ","","","mv_ch3","C",10,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{c_Perg,"04","Fun็ใo At้        ","","","mv_ch4","C",10,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{c_Perg,"05","M๓dulo de         ","","","mv_ch5","C",10,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{c_Perg,"06","M๓dulo At้        ","","","mv_ch6","C",10,0,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{c_Perg,"07","Status            ","","","mv_ch7","N",01,0,1,"C","","mv_par07","Habilitado","","","","","Inibido","","","","","Desabilitado","","","","","Todos","","","","","","","","",""})
Endif

For i:=1 to Len(aRegs)
	If !dbSeek(c_Perg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to FCount()
			If j <= Len(aRegs[i])
				FieldPut(j,aRegs[i,j])
			Endif
		Next
		MsUnlock()
	Endif
Next
DbSelectArea(_sAlias)

Return Nil