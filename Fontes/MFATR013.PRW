#Include "RwMake.ch"
#Include "Protheus.ch"
#Include "Topconn.ch"  

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMFATR013  บ Autor ณ Bruno Parreira     บ Data ณ  02/07/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Relatorio Media de faturamento - Sint้tico                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออหออออออออออหออออออออออออออออออออออออออออออออนฑฑ
ฑฑบAlteracoesณ                บ 17/04/12 บ                                บฑฑ
ฑฑฬออออออออออุออออออออออออออออสออออออออออสออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Especifico NYTRON                                          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
                                                 
User Function MFATR013()

Local cDesc1       	:= "Este programa tem como objetivo imprimir relatorio "
Local cDesc2       	:= "de acordo com os parametros informados pelo usuario."
Local cDesc3       	:= "Media de Faturamento - Sint้tico"
Local cPict        	:= ""
Local titulo       	:= "Media de Faturamento - Sint้tico"
Local nLin         	:= 80
					  //          1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1         2
					  //01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
Local Cabec1       	:= "Produto      Descricao                                     Qtd. Total        Valor Total        Qtd. M้dia       Valor M้dio     "
Local Cabec2       	:= ""

Local imprime      	:= .T.
Local aOrd         	:= {}
Local lPerg        	:= .F.
                     //  1    2   3   4   5   6   7   8
Private aCol       	:= {000,013,061,078,098,114,077,111}
Private lEnd       	:= .F.
Private lAbortPrint	:= .F.
Private CbTxt      	:= ""
Private limite     	:= 132
Private tamanho    	:= "M"
Private nomeprog   	:= "MFATR013"
Private nTipo      	:= 15
Private aReturn    	:= { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey   	:= 0
Private cbtxt      	:= Space(10)
Private cbcont     	:= 00
Private CONTFL     	:= 01
Private m_pag      	:= 01
Private wnrel      	:= "MFATR013"
Private cPerg      	:= "MFATR013"
Private cString    	:= "SD2"  
Private cArqTMP        
Private cSegmento   := ""
          
lCont := .F.          
                
MR013PERG(cPerg)

While !lCont
	lPerg := Pergunte(cPerg)
	If Empty(MV_PAR03)
		If lPerg
			lCont := .F. 
			MsgAlert("Insira a letra referente ao segmento conforme help. Para todos segmentos insira a letra T.")	 
		else
			lCont := .T.	
		EndIf  	 
	else
		If !(MV_PAR03 $ "TACMVIB")
			lCont := .F.
			MsgAlert("Letra nใo corresponde a nenhum segmento existente. Insira apenas letras conforme orienta็ใo do help.")
		else	
			lCont := .T.
		EndIf	
	EndIf
EndDo 

If MV_PAR03 = "T"
	titulo += " - Segmento: Todos"
ElseIf MV_PAR03 = "M"
	titulo += " - Segmento: Multlockcenter"	 
ElseIf MV_PAR03 = "A"
	titulo += " - Segmento: Automotivo"	
ElseIf MV_PAR03 = "B"
	titulo += " - Segmento: Construtora"	
ElseIf MV_PAR03 = "V"
	titulo += " - Segmento: Varejo"	
ElseIf MV_PAR03 = "C"
	titulo += " - Segmento: Corporativo"
ElseIf MV_PAR03 = "I"
	titulo += " - Segmento: Industrial"
EndIf	
	
If lPerg
	wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.F.)
	
	If nLastKey == 27
		Return
	Endif
	
	SetDefault(aReturn,cString)
	
	If nLastKey == 27
		Return
	Endif
	
	nTipo := If(aReturn[4]==1,15,18)
	
	RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
Endif

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณRunReport บ Autor ณ Bruno Parreira     บ Data ณ  02/07/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Busca registros no banco e gera relatorio                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Especifico Lisonda Engenharia e Construcoes Ltda.          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

Local cQuery     := ""
Local nTotreg    := 0
Local nTotMeses  := 0 
Local nTotVlr 	 := 0
Local nTotVlrMed := 0
Local nMedVlr	 := 0
Local nMedQtd	 := 0  
Local nContar	 := 0     
Local cSegmento  := ""     

cSegmento := MV_PAR03

cQuery :=        "  SELECT SD2.D2_COD, SB1.B1_DESC, SUM(SD2.D2_QUANT) AS D2_QUANT, SUM(SD2.D2_TOTAL+SD2.D2_VALIPI+SD2.D2_ICMSRET) AS TOTAL "
cQuery += CRLF + "   FROM "+RetSqlName("SD2")+" SD2 "
cQuery += CRLF + "    JOIN "+RetSqlName("SA1")+" AS SA1 "
cQuery += CRLF + "     ON  SA1.A1_COD = SD2.D2_CLIENTE "
cQuery += CRLF + "     AND SA1.A1_LOJA = SD2.D2_LOJA "
cQuery += CRLF + "     AND SA1.D_E_L_E_T_ = ' ' "
cQuery += CRLF + "    JOIN "+RetSqlName("SF4")+" AS SF4 "
cQuery += CRLF + "     ON  SF4.F4_FILIAL = SD2.D2_FILIAL "
cQuery += CRLF + "     AND SF4.F4_CODIGO = SD2.D2_TES "
cQuery += CRLF + "     AND SF4.F4_FILIAL = '"+xFilial("SF4")+"' "
cQuery += CRLF + "     AND SF4.D_E_L_E_T_ = ' ' "  
cQuery += CRLF + "    JOIN "+RetSqlName("SB1")+" AS SB1 "
cQuery += CRLF + "     ON  SB1.B1_COD = SD2.D2_COD "
cQuery += CRLF + "     AND SB1.D_E_L_E_T_ = ' ' "         
If MV_PAR03 <> "T"
	cQuery += CRLF + "    JOIN "+RetSqlName("SC5")+" AS SC5 "
	cQuery += CRLF + "     ON  SC5.C5_FILIAL = SD2.D2_FILIAL "
	cQuery += CRLF + "     AND SC5.C5_NUM    = SD2.D2_PEDIDO "
	cQuery += CRLF + "     AND SC5.C5_XORIGEM = '"+cSegmento+"' "
	cQuery += CRLF + "     AND SC5.D_E_L_E_T_ = ' ' "  
EndIf	
cQuery += CRLF + "   WHERE SD2.D2_EMISSAO BETWEEN '"+DtoS(MV_PAR01)+"' AND '"+DtoS(MV_PAR02)+"' "
cQuery += CRLF + "    AND SD2.D2_FILIAL = '"+xFilial("SD2")+"' "
cQuery += CRLF + "    AND (SD2.D2_TIPO = 'N' OR SD2.D2_TIPO = 'C') "
cQuery += CRLF + "    AND (SD2.D2_CF = '5101' OR SD2.D2_CF = '6101' OR SD2.D2_CF = '5118' OR SD2.D2_CF = '6118' OR "
cQuery += CRLF + "    SD2.D2_CF = '5401' OR SD2.D2_CF = '6401' OR SD2.D2_CF = '5922' OR SD2.D2_CF = '6922' OR "
cQuery += CRLF + "    SD2.D2_CF = '6107' OR SD2.D2_CF = '6108' OR SD2.D2_CF = '6109') "
cQuery += CRLF + "    AND SD2.D_E_L_E_T_ <> '*' "
cQuery += CRLF + "   GROUP BY SD2.D2_COD, SB1.B1_DESC "
cQuery += CRLF + "   ORDER BY SD2.D2_COD "

MemoWrite("MFATR013.txt",cQuery)

cAliasA := GetNextAlias()
cQuery  := ChangeQuery(cQuery)

DbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cAliasA , .F., .T.)
aEval( SD2->(DbStruct()),{|x| If(x[2] != "C", TcSetField(cAliasA, AllTrim(x[1]), x[2], x[3], x[4]),Nil)})
aEval( SB1->(DbStruct()),{|x| If(x[2] != "C", TcSetField(cAliasA, AllTrim(x[1]), x[2], x[3], x[4]),Nil)})

// ************************ Monta Estrutura do Temporario Excel
_aStruct := {} 
aAdd(_aStruct,{"PRODUTO"  ,"C",TAMSX3( "D2_COD"   )[1],TAMSX3( "D2_COD"   )[2]})	// Cod. Produto
aAdd(_aStruct,{"DESCRICAO","C",TAMSX3( "B1_DESC"  )[1],TAMSX3( "B1_DESC"  )[2]})	// Descricao
aAdd(_aStruct,{"QTD_TOTAL","N",TAMSX3( "D2_QUANT" )[1],TAMSX3( "D2_QUANT" )[2]})	// Quantidade Total
aAdd(_aStruct,{"VLR_TOTAL","N",TAMSX3( "D2_TOTAL" )[1],TAMSX3( "D2_TOTAL" )[2]})	// Valor Total
aAdd(_aStruct,{"QTD_MEDIA","N",TAMSX3( "D2_QUANT" )[1],TAMSX3( "D2_QUANT" )[2]})	// Quantidade Media
aAdd(_aStruct,{"VLR_MEDIO","N",TAMSX3( "D2_TOTAL" )[1],TAMSX3( "D2_TOTAL" )[2]})	// Valor Medio

cArqTMP	:= CriaTrab(_aStruct)   

dbUseArea( .T.,, cArqTmp, "TMP", if(.F. .OR. .F., !.F., NIL), .F. )          //__LocalDriver

DbSelectArea( cAliasA )
(cAliasA)->( DbEval( { || nTotReg++ },,{ || !Eof() } ) )
(cAliasA)->( DbGoTop() )

nTotMeses := Round(((MV_PAR02 - MV_PAR01)/30),0)

If (cAliasA)->( !Eof() )
	ProcRegua( nTotReg )
	While (cAliasA)->( !Eof() )
		IncProc("Gerando relatorio, regs : "+StrZero(++nContar,6)+" de "+StrZero(nTotReg,6))
		
		If lAbortPrint
			@ nLin,000 PSAY "*** CANCELADO PELO OPERADOR ***"
			Exit
		Endif
		
		If nLin > 79
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin := 8
		Endif     
		
		nMedQtd := ((cAliasA)->D2_QUANT/nTotMeses)       
		//nMedVlr := ((cAliasA)->TOTAL/nTotMeses)
		//Substituida linha acima pela linha abaixo a pedido do Eneas [Bruno Parreira, Actual Trend, 06/07/2012] 
		nMedVlr := ((cAliasA)->TOTAL/(cAliasA)->D2_QUANT)
		
		@ nLin, aCol[01] PSay Left((cAliasA)->D2_COD,12)
		@ nLin, aCol[02] PSay Left((cAliasA)->B1_DESC,45)
		@ nLin, aCol[03] PSay Transform((cAliasA)->D2_QUANT, "@E 99,999")
		@ nLin, aCol[04] PSay Transform((cAliasA)->TOTAL, "@E 9,999,999.99")
		@ nLin, aCol[05] PSay Transform( nMedQtd , "@E 99,999")
		@ nLin, aCol[06] PSay Transform( nMedVlr , "@E 9,999,999.99")
		
		nLin++
		
		nTotVlr    += (cAliasA)->TOTAL
		nTotVlrMed += nMedVlr
		    
 		RecLock("TMP",.T.)
 		TMP->PRODUTO	:= (cAliasA)->D2_COD  
 		TMP->DESCRICAO	:= (cAliasA)->B1_DESC
 		TMP->QTD_TOTAL	:= (cAliasA)->D2_QUANT
 		TMP->VLR_TOTAL	:= (cAliasA)->TOTAL
 		TMP->QTD_MEDIA	:= nMedQtd
 		TMP->VLR_MEDIO	:= nMedVlr
 		MsUnlock()
		
		(cAliasA)->( DbSkip() )
	End-While
	
 	@ nLin,000 PSay __PrtThinLine()
 	nLin++
 	@ nLin, aCol[01]  PSay "TOTAL: " 
	@ nLin, aCol[07]  PSay Transform( nTotVlr    , "@E 99,999,999.99" )
   //	@ nLin, aCol[08]  PSay Transform( nTotVlrMed , "@E 99,999,999.99" )
	nLin += 2
	
	nTotGeral := 0
		
	Roda(cbcont,cbtxt,tamanho)
EndIf

(cAliasA)->( DbCloseArea() )

SET DEVICE TO SCREEN
If aReturn[5]==1
	dbCommitAll()
	SET PRINTER TO
	OurSpool(wnrel)
Endif

MS_FLUSH()         

If Select("TMP") > 0                                                                                                                                               	
	TMP->(DbCloseArea())
 
	If MsgYesNo("Deseja gerar planilha excel ?")
	
		cExcel :=  AllTrim(GetTempPath())+"MEDIA_FATURAMENTO_SINTETICO"+StrTran(Dtoc(dDatabase),"/","")+".XLS"
		
		fErase(cExcel)
		__CopyFile(cArqTMP+".DBF",cExcel)
		fErase(cArqTMP+".*")
		
		oExcelApp:= MsExcel():New()                        	
		oExcelApp:WorkBooks:Open(cExcel)
		oExcelApp:SetVisible(.T.)                                                                          
		lExcel := .T.
		Return
	EndIf  
EndIf

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณMR013PERG บ Autor ณ Bruno Parreira     บ Data ณ  02/07/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Cria parametros da rotina                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Especifico Lisonda Engenharia e Construcoes Ltda.          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

Static Function MR013PERG(cPerg)

Local aAreaAtu	:= GetArea()
Local aAreaSX1	:= SX1->( GetArea() )

PutSx1(	cPerg, "01", "Data Emissao de        ? ", "" , "", "Mv_ch1", TAMSX3( "F2_EMISSAO" )[3], TAMSX3( "F2_EMISSAO" )[1], TAMSX3( "F2_EMISSAO" )[2], 0,"G","","","","N","Mv_par01","","","","","","","","","","","","","","","","",{"Digite a data de emissใo inicial    ",""},{""},{""},"")
PutSx1(	cPerg, "02", "Data Emissao ate       ? ", "" , "", "Mv_ch2", TAMSX3( "F2_EMISSAO" )[3], TAMSX3( "F2_EMISSAO" )[1], TAMSX3( "F2_EMISSAO" )[2], 0,"G","","","","N","Mv_par02","","","","","","","","","","","","","","","","",{"Digite a data de emissใo final      ",""},{""},{""},"")
PutSx1(	cPerg, "03", "Segmento[TACMVIB]      ? ", "" , "", "Mv_ch3", TAMSX3( "C5_XORIGEM" )[3], TAMSX3( "C5_XORIGEM" )[1], TAMSX3( "C5_XORIGEM" )[2], 0,"G","","","","N","Mv_par03","","","","","","","","","","","","","","","","",{"T=Todos; A=Automotivo; C=Corporativo;","M=MultlockCenter; B=Construtora;","V=Varejo;I=Industrial"},{""},{""},"")
//PutSx1(	cPerg, "03", "Segmento             ? ", "" , "", "Mv_ch3", "N"                       ,                          ,                           , 2,"C","","","","N","Mv_par03","Todos","Todos","Todos","","Corporativo","Corporativo","Corporativo","Multlock Center","Multlock Center","Multlock Center","Automotivo","Automotivo","Automotivo","Varejo","Varejo","Varejo",{"Selecione o segmento.     ",""},{""},{""},"")

RestArea( aAreaSX1 )
RestArea( aAreaAtu )

Return(cPerg)