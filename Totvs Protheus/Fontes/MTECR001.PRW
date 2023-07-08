#include "Ap5Mail.ch"
#include "rwmake.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMTECR001  บAutor  ณAndre Couto         บ Data ณ  23/07/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFormulario de Atendimento - HTML                            บฑฑ       
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณEspecifico     Especifico MULTLOCK.                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function MTECR001()

	Private cPerg			:= "MTECR001"
	Private nOpcA			:= 0
	Private oProcess,oDlg


	Private _cEmissao,_cData,_cNomCli
	Private cQuery, _cItens, _cItem
	Private oWord  
	lperg 			:= ValidPerg(cPerg)
	Iperg 			:= pergunte(cPerg,.T.)

	@ 96,012 TO 250,400 DIALOG oDlg TITLE OemToAnsi("Impressao da OS - Integracao HTML ")
	@ 08,005 TO 048,190
	@ 18,010 SAY OemToAnsi("Esta rotina ira imprimir a Ordem de Servico ") Size 170,008 
	@ 26,010 SAY OemToAnsi("atraves de HTML, conforme os parametros solicitados") Size 170,008 

	@ 56,100 BMPBUTTON TYPE 5 ACTION Pergunte("MTECR001",.T.)      
    @ 56,130 BMPBUTTON TYPE 1 ACTION ImprOS()
    @ 56,160 BMPBUTTON TYPE 2 ACTION Close(oDlg)
	ACTIVATE DIALOG oDlg CENTERED
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณImprOS    บAutor  ณAndre Couto         บ Data ณ  23/07/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณImpressa da Ordem de Servico - HTML                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ImprOS()

   //	Private c_Cliente := ''
	
   //	Private c_descfhe := ''
   //	Private c_kitabpf := ''
  //	Private c_desckta := ''
   //	Private c_molaaer := ''
   //	Private c_descmla := ''
   //	Private c_altfdp  := ''
   //	Private c_htmbat  := ''
  //	Private c_cmdint := ''

	// Fecha o arquivos temporarios, caso este estejam abertos
	If Select("TRBAB6") <> 0
		 TRBAB6->(dbCloseArea())

	EndIf

	If Select("TRBAB7") <> 0
		TRBAB7->(dbCloseArea())
	EndIf

	If Select("TRBAB4") <> 0
		TRBAB4->(dbCloseArea())
	EndIf

	If Select("TRBAB3") <> 0
		TRBAB3->(dbCloseArea())
	EndIf

	If Select("TRBAB1") <> 0
		TRBAB1->(dbCloseArea())
	EndIf

	If Select("TRBAB2") <> 0
		TRBAB2->(dbCloseArea())
	EndIf

	If Select("TRBSA1") <> 0
		TRBSA1->(dbCloseArea())
	EndIf

	If Select("TRBABB") <> 0
     	TRBABB->(dbCloseArea())
	EndIf


// Posiciona na Ordem de Servico
	
	// Cabecalho - AB6
	cQuery := " SELECT * FROM "+RetSqlName("AB6")+ " AB6 WHERE AB6.AB6_NUMOS = '"+mv_par01+"' AND AB6.D_E_L_E_T_ = '' "
	cQuery := ChangeQuery(cQuery)
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TRBAB6",.T.,.T.)	

	// Itens - AB7
	cQuery := " SELECT * FROM "+RetSqlName("AB7")+" AB7 WHERE AB7.AB7_NUMOS = '"+mv_par01+"' AND AB7.D_E_L_E_T_ = '' ORDER BY AB7.AB7_ITEM"
	cQuery := ChangeQuery(cQuery)
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TRBAB7",.T.,.T.)		


// Posiciona no Orcamento - AB3/AB4	
	// Itens - AB4
	cQuery := " SELECT * FROM "+RetSqlName("AB4")+" AB4 WHERE AB4.AB4_NUMOS = '"+TRBAB6->AB6_NUMOS+"' AND AB4.D_E_L_E_T_ = '' "
	cQuery := ChangeQuery(cQuery)
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TRBAB4",.T.,.T.)	

	// Cabecalho - AB3
	cQuery := " SELECT * FROM "+RetSqlName("AB3")+" AB3 WHERE AB3.AB3_NUMORC = '"+TRBAB4->AB4_NUMORC+"' AND AB3.D_E_L_E_T_ = '' "
	cQuery := ChangeQuery(cQuery)
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TRBAB3",.T.,.T.)		
	
// Posiciona no Chamado Tecnico  -  AB1/AB2	
	// Cabecalho - AB1
	cQuery := " SELECT * FROM "+RetSqlName("AB1")+" AB1 WHERE AB1.AB1_NRCHAM = '"+substr(TRBAB4->AB4_NRCHAM,1,8)+"' AND AB1.D_E_L_E_T_ = '' "
	cQuery := ChangeQuery(cQuery)
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TRBAB1",.T.,.T.)	

	// Itens - AB2
	cQuery := " SELECT * FROM "+RetSqlName("AB2")+" AB2 WHERE AB2.AB2_NRCHAM = '"+TRBAB1->AB1_NRCHAM+"' AND AB2.D_E_L_E_T_ = '' "
	cQuery := ChangeQuery(cQuery)
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TRBAB2",.T.,.T.)	
                                                                                                            //1
// Posiciona no Cliente - SA1
	cQuery := " SELECT * FROM "+RetSqlName("SA1")+" SA1 WHERE SA1.A1_COD+SA1.A1_LOJA = '"+TRBAB1->AB1_CODCLI+TRBAB1->AB1_LOJA +"' AND SA1.D_E_L_E_T_ = '' "
	cQuery := ChangeQuery(cQuery)
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TRBSA1",.T.,.T.)	

// Posiciona no Agendamento
	cQuery := " SELECT * FROM "+RetSqlName("ABB")+" ABB WHERE ABB.ABB_NUMOS = '"+mv_par01+"' AND ABB.D_E_L_E_T_ = '' "
	cQuery := ChangeQuery(cQuery)
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TRBABB",.T.,.T.)	


	
		cPath := AllTrim(GetTempPath())
   		U_FGEN009("\html\OS.html",cPath+"OS.HTML")//C:\SIGA.html

//	EndIf     
		
Return ()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma    ณ fArq      ณ Funcao para gravacao buffer arquivo HTML.                    บฑฑ
ฑฑฬออออออออออออุอออออออออออฯอออออออออออออออออออออออออออออออออออออออออออัออออออัอออออออออออนฑฑ
ฑฑบAutor       ณ Actual Trend                                          ณ Data ณ  21/09/09 บฑฑ
ฑฑศออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function fArq(c_FileOrig, c_FileDest)

Local l_Ret 	:= .T.
Local c_Buffer	:= ""
Local n_Posicao	:= 0
Local n_QtdReg	:= 0
Local n_RegAtu	:= 0

If !File(c_FileOrig)
	l_Ret := .F.
	MsgStop("Arquivo [ "+c_FileOrig+" ] nใo localizado.", "Nใo localizou")
Else
	
	Ft_fuse( c_FileOrig ) 		// Abre o arquivo
	Ft_FGoTop()
	n_QtdReg := Ft_fLastRec()
	nHandle	:= MSFCREATE( c_FileDest )
	
	///////////////////////////////////
	// Carregar o array com os itens //
	///////////////////////////////////
	While !ft_fEof() .And. l_Ret
		c_Buffer := ft_fReadln()
		
		FWrite(nHandle, &("'" + c_Buffer + "'"))
		c_texto += &("'" + c_Buffer + "'")
		ft_fSkip()
	Enddo
	FClose(nHandle)
EndIf

Return l_Ret             
     

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณValidPerg บAutor  ณ                    บ Data ณ  29/07/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Cria Pergunta                                              บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ValidPerg(c_Perg)

	c_Alias := Alias()
	
	DbSelectArea("SX1")
	DbSetOrder(1)
	
	c_Perg 	:= PADR(c_Perg, 10)
	aRegs	:= {}
	
  	aAdd(aRegs,{cPerg,"01","Num OS     ?      " ,"Num OS    ?   " ,"Num OS     ?  ","mv_ch1","C",6,0,0,"G","","MV_PAR01","","","","","","","","","","","","","","","","","","","","","","","","","AB6",""})
	
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