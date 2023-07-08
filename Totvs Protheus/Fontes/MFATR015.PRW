#Include "RwMake.ch"
#Include "Protheus.ch"
#Include "Topconn.ch"  

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMFATR015  บ Autor ณ Bruno Parreira     บ Data ณ  13/07/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Vendas por Segmento / Vendedor                             บฑฑ
ฑฑฬออออออออออุออออออออออออออออหออออออออออหออออออออออออออออออออออออออออออออนฑฑ
ฑฑบAlteracoesณ                บ 17/04/12 บ                                บฑฑ
ฑฑฬออออออออออุออออออออออออออออสออออออออออสออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Especifico NYTRON                                          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
                                                                                                                            
User Function MFATR015()

Local cDesc1       	:= "Este programa tem como objetivo imprimir relatorio "
Local cDesc2       	:= "de acordo com os parametros informados pelo usuario."
Local cDesc3       	:= "Vendas por Segmento / Vendedor"
Local cPict        	:= ""
Local titulo       	:= "Vendas por Segmento / Vendedor"
Local nLin         	:= 80
					  //         1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1         2
					  //1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
Local Cabec1       	:= "Segmento           Vendedor  Nome                           Emissao   Cliente  Loja  Nome                            Estado   Vlr. Total    Num. Doct.   No. do Ped."
Local Cabec2       	:= ""

Local imprime      	:= .T.
Local aOrd         	:= {}
Local lPerg        	:= .T.
                     //  1    2   3   4   5   6   7   8   9   10  11
Private aCol       	:= {000,019,029,060,070,079,085,117,126,140,153}
Private lEnd       	:= .F.
Private lAbortPrint	:= .F.
Private CbTxt      	:= ""
Private limite     	:= 220
Private tamanho    	:= "G"
Private nomeprog   	:= "MFATR015"
Private nTipo      	:= 15
Private aReturn    	:= { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey   	:= 0
Private cbtxt      	:= Space(10)
Private cbcont     	:= 00
Private CONTFL     	:= 01
Private m_pag      	:= 01
Private wnrel      	:= "MFATR015"
Private cPerg      	:= "MFATR015"
Private cString    	:= "SD2"  
Private cArqTMP  

MR015PERG(cPerg)
lPerg := Pergunte(cPerg)

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
Local nContar	 := 0

Local cVend		 := ""
Local cNomVend   := ""
Local nTotVlr    := 0
Local nTotVend   := 0 
Local nTotSeg    := 0

cQuery :=        "  SELECT (CASE WHEN C5_XORIGEM = 'A' "
cQuery += CRLF + "               THEN 'AUTOMOTIVO'  " 
cQuery += CRLF + "               ELSE CASE WHEN C5_XORIGEM = 'C' "
cQuery += CRLF + "                         THEN 'CORPORATIVO' "
cQuery += CRLF + "                         ELSE CASE WHEN C5_XORIGEM = 'T' "
cQuery += CRLF + "                                   THEN 'ASSIST.TECNICA'  "
cQuery += CRLF + "                                   ELSE CASE WHEN C5_XORIGEM = 'V' "
cQuery += CRLF + "                                             THEN 'VAREJO' "
cQuery += CRLF + "                                             ELSE CASE WHEN C5_XORIGEM = 'M' "
cQuery += CRLF + "                                                       THEN 'MUL-T-LOCK CENTER' "
cQuery += CRLF + "                                                       ELSE 'NAO DEFINIDO'  "
cQuery += CRLF + "                                                  END "
cQuery += CRLF + "                                        END "
cQuery += CRLF + "                              END "
cQuery += CRLF + "                    END "
cQuery += CRLF + "          END) AS SEGMENTO, "
cQuery += CRLF + "          D2_EMISSAO AS EMISSAO, C5_VEND1 AS VENDEDOR, A3_NOME AS NOMEVEND, D2_CLIENTE AS CLIENTE,D2_LOJA AS LOJA, A1_NREDUZ AS RAZSOC, "
cQuery += CRLF + "          A1_MUN AS CIDADE, A1_EST AS ESTADO, D2_DOC AS DOC, C5_NUM AS PEDIDO, IsNull(Sum(D2_TOTAL),0) TOTAL, "
cQuery += CRLF + "          IsNull(Sum((Case When SF4.F4_AGREG <> 'H' Then D2_TOTAL+D2_VALIPI+D2_ICMSRET Else D2_ICMSRET End)),0) TOT_IMP "
cQuery += CRLF + "   FROM "+RetSqlName("SD2")+" SD2 "
cQuery += CRLF + "      JOIN "+RetSqlName("SA1")+" AS SA1 "
cQuery += CRLF + "         ON  SA1.A1_COD     = SD2.D2_CLIENTE "
cQuery += CRLF + "         AND SA1.A1_LOJA    = SD2.D2_LOJA "
cQuery += CRLF + "         AND SA1.D_E_L_E_T_ = ' ' "
cQuery += CRLF + "      JOIN "+RetSqlName("SF4")+" AS SF4 "
cQuery += CRLF + "         ON  SF4.F4_FILIAL  = SD2.D2_FILIAL "
cQuery += CRLF + "         AND SF4.F4_CODIGO  = SD2.D2_TES "
cQuery += CRLF + "         AND SF4.F4_DUPLIC  = 'S' "
cQuery += CRLF + "         AND SF4.D_E_L_E_T_ = ' ' "  
cQuery += CRLF + "      JOIN "+RetSqlName("SC5")+" AS SC5 "
cQuery += CRLF + "         ON  SC5.C5_FILIAL  = SD2.D2_FILIAL "
cQuery += CRLF + "         AND SD2.D2_PEDIDO  = SC5.C5_NUM "
cQuery += CRLF + "         AND (('"+AllTrim(MV_PAR10)+"' <> '     ' AND (SC5.C5_XORIGEM IN ('"+AllTrim(MV_PAR10)+"'))) OR '"+AllTrim(MV_PAR10)+"' = '     ' ) "
cQuery += CRLF + "         AND SC5.D_E_L_E_T_ = ' ' "
cQuery += CRLF + "      JOIN "+RetSqlName("SA3")+" AS SA3 "
cQuery += CRLF + "         ON  SA3.A3_COD     = SC5.C5_VEND1 "
cQuery += CRLF + "         AND SA3.D_E_L_E_T_ = ' ' "
cQuery += CRLF + "   WHERE SD2.D2_EMISSAO BETWEEN '"+DtoS(MV_PAR01)+"' AND '"+DtoS(MV_PAR02)+"' "
cQuery += CRLF + "     AND SD2.D2_FILIAL   = '"+xFilial("SD2")+"' "
cQuery += CRLF + "     AND (SD2.D2_CF = '5101' OR SD2.D2_CF = '6101' OR SD2.D2_CF = '5118' OR SD2.D2_CF = '6118' OR "
cQuery += CRLF + "          SD2.D2_CF = '5401' OR SD2.D2_CF = '6401' OR SD2.D2_CF = '5922' OR SD2.D2_CF = '6922' OR "
cQuery += CRLF + "          SD2.D2_CF = '6107' OR SD2.D2_CF = '6108' OR SD2.D2_CF = '6109') "
cQuery += CRLF + "     AND SD2.D2_CLIENTE BETWEEN '"+MV_PAR03+"' AND '"+MV_PAR04+"' "
cQuery += CRLF + "     AND SA1.A1_VEND    BETWEEN '"+MV_PAR05+"' AND '"+MV_PAR06+"' "
cQuery += CRLF + "     AND SA1.A1_EST     BETWEEN '"+MV_PAR07+"' AND '"+MV_PAR08+"' "
cQuery += CRLF + "     AND (SD2.D2_TIPO = 'N' OR SD2.D2_TIPO = 'C') "
cQuery += CRLF + "     AND SD2.D_E_L_E_T_ <> '*' "
cQuery += CRLF + "   GROUP BY C5_XORIGEM, D2_EMISSAO, C5_VEND1, A3_NOME, D2_CLIENTE, D2_LOJA, A1_NREDUZ, A1_MUN, A1_EST, D2_DOC, C5_NUM"
cQuery += CRLF + "   ORDER BY C5_XORIGEM, A3_NOME, D2_DOC "

MemoWrite("MFATR015.txt",cQuery)

cAliasA := GetNextAlias()
cQuery  := ChangeQuery(cQuery)

DbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cAliasA , .F., .T.)
aEval( SD2->(DbStruct()),{|x| If(x[2] != "C", TcSetField(cAliasA, AllTrim(x[1]), x[2], x[3], x[4]),Nil)})
aEval( SC5->(DbStruct()),{|x| If(x[2] != "C", TcSetField(cAliasA, AllTrim(x[1]), x[2], x[3], x[4]),Nil)})
aEval( SA3->(DbStruct()),{|x| If(x[2] != "C", TcSetField(cAliasA, AllTrim(x[1]), x[2], x[3], x[4]),Nil)})
aEval( SA1->(DbStruct()),{|x| If(x[2] != "C", TcSetField(cAliasA, AllTrim(x[1]), x[2], x[3], x[4]),Nil)})

// ************************ Monta Estrutura do Temporario Excel

_aStruct := {} 
aAdd(_aStruct,{"SEGMENTO" ,"C",20                        ,0                        })	// Segmento
aAdd(_aStruct,{"VENDEDOR" ,"C",TAMSX3( "C5_VEND1"   )[1],TAMSX3( "C5_VEND1"   )[2]})	// Cod. Vendedor
aAdd(_aStruct,{"NOMEVEND" ,"C",TAMSX3( "A3_NOME"    )[1],TAMSX3( "A3_NOME"    )[2]})	// Nome Vendedor
aAdd(_aStruct,{"EMISSAO"  ,"C",8                         ,0                        })	// Data Emissao
aAdd(_aStruct,{"CLIENTE"  ,"C",TAMSX3( "D2_CLIENTE" )[1],TAMSX3( "D2_CLIENTE" )[2]})	// Cod. Cliente
aAdd(_aStruct,{"LOJA"     ,"C",TAMSX3( "D2_LOJA"    )[1],TAMSX3( "D2_LOJA"    )[2]})	// Loja Cliente
aAdd(_aStruct,{"RAZSOC"   ,"C",TAMSX3( "A1_NREDUZ"  )[1],TAMSX3( "A1_NREDUZ"  )[2]})	// Nome Cliente
aAdd(_aStruct,{"ESTADO"   ,"C",TAMSX3( "A1_EST"     )[1],TAMSX3( "A1_EST"     )[2]})	// UF Cliente
aAdd(_aStruct,{"TOTAL"    ,"N",TAMSX3( "D2_TOTAL"   )[1],TAMSX3( "D2_TOTAL"   )[2]})	// Valor Total
aAdd(_aStruct,{"DOC"      ,"C",TAMSX3( "D2_DOC"     )[1],TAMSX3( "D2_DOC"     )[2]})	// Num. Nota
aAdd(_aStruct,{"PEDIDO"   ,"C",TAMSX3( "C5_NUM"     )[1],TAMSX3( "C5_NUM"     )[2]})	// Num. Pedido

cArqTMP	:= CriaTrab(_aStruct)   

dbUseArea( .T.,, cArqTmp, "TMP", if(.F. .OR. .F., !.F., NIL), .F. )          //__LocalDriver

DbSelectArea( cAliasA )
(cAliasA)->( DbEval( { || nTotReg++ },,{ || !Eof() } ) )
(cAliasA)->( DbGoTop() )

If (cAliasA)->( !Eof() )
	ProcRegua( nTotReg ) 
	
	cVend    := AllTrim((cAliasA)->VENDEDOR)
	cNomVend := AllTrim((cAliasA)->NOMEVEND) 
	cSegment := AllTrim((cAliasA)->SEGMENTO)  
	While (cAliasA)->( !Eof() )
		IncProc("Gerando relatorio, regs : "+StrZero(++nContar,6)+" de "+StrZero(nTotReg,6))
		
		If lAbortPrint
			@ nLin,000 PSAY "*** CANCELADO PELO OPERADOR ***"
			Exit
		Endif
		
		If nLin > 67
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin := 8
		Endif                                
		
		If cVend <> AllTrim((cAliasA)->VENDEDOR)
			@ nLin,000 PSay __PrtThinLine()
		 	nLin++
		 	@ nLin, aCol[01]  PSay "Total do Vendedor: " + cNomVend 
			@ nLin, aCol[09]  PSay Transform( nTotVend , "@E 9,999,999.99" )
			nLin += 2 
			
			nTotVend := 0		
			cVend    := AllTrim((cAliasA)->VENDEDOR)
   			cNomVend := AllTrim((cAliasA)->NOMEVEND)
		EndIf 
		
		If cSegment <> AllTrim((cAliasA)->SEGMENTO)
			If nLin > 67
				Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
				nLin := 8
			Endif                                                  
			
			nLin--
			@ nLin,000 PSay __PrtThinLine()
		 	nLin++
		 	@ nLin, aCol[01]  PSay "Total do Segmento: " + cSegment
			@ nLin, aCol[09]  PSay Transform( nTotSeg , "@E 9,999,999.99" )
			nLin += 2
			
			nTotSeg  := 0
			cSegment := AllTrim((cAliasA)->SEGMENTO)
		EndIf
			
		@ nLin, aCol[01] PSay Left((cAliasA)->SEGMENTO,17)
		@ nLin, aCol[02] PSay (cAliasA)->VENDEDOR
		@ nLin, aCol[03] PSay Left((cAliasA)->NOMEVEND,30)
		@ nLin, aCol[04] PSay DtoC(StoD((cAliasA)->EMISSAO))
		@ nLin, aCol[05] PSay (cAliasA)->CLIENTE
		@ nLin, aCol[06] PSay (cAliasA)->LOJA
		@ nLin, aCol[07] PSay Left((cAliasA)->RAZSOC,30)
		@ nLin, aCol[08] PSay (cAliasA)->ESTADO
		@ nLin, aCol[09] PSay Transform(If(MV_PAR09=1,(cAliasA)->TOTAL,(cAliasA)->TOTALIMP), "@E 9,999,999.99")
		@ nLin, aCol[10] PSay (cAliasA)->DOC
		@ nLin, aCol[11] PSay (cAliasA)->PEDIDO
		
		nLin++
		
		nTotVend += (cAliasA)->TOTAL   
		nTotVlr  += (cAliasA)->TOTAL 
		nTotSeg  += (cAliasA)->TOTAL   
		    
 		RecLock("TMP",.T.)
 		TMP->SEGMENTO	:= (cAliasA)->SEGMENTO
 		TMP->VENDEDOR	:= (cAliasA)->VENDEDOR
 		TMP->NOMEVEND	:= (cAliasA)->NOMEVEND
 		TMP->EMISSAO	:= DtoC(StoD((cAliasA)->EMISSAO))
 		TMP->CLIENTE	:= (cAliasA)->CLIENTE
 		TMP->LOJA   	:= (cAliasA)->LOJA
 		TMP->RAZSOC 	:= (cAliasA)->RAZSOC
 		TMP->ESTADO 	:= (cAliasA)->ESTADO
 		TMP->TOTAL   	:= (cAliasA)->TOTAL
 		TMP->DOC    	:= (cAliasA)->DOC
 		TMP->PEDIDO 	:= (cAliasA)->PEDIDO
 		MsUnlock()
 				
		(cAliasA)->( DbSkip() )
	End-While  
	
	@ nLin,000 PSay __PrtThinLine()
 	nLin++
 	@ nLin, aCol[01]  PSay "Total do Vendedor: " + cNomVend 
	@ nLin, aCol[09]  PSay Transform( nTotVend , "@E 9,999,999.99" )
	nLin ++  
	
	If Empty(MV_PAR10)
		@ nLin,000 PSay __PrtThinLine()
	 	nLin++
	 	@ nLin, aCol[01]  PSay "Total do Segmento: " + cSegment
		@ nLin, aCol[09]  PSay Transform( nTotSeg , "@E 9,999,999.99" )
		nLin ++ 	
	EndIf	

 	@ nLin,000 PSay __PrtThinLine()
 	nLin++
 	@ nLin, aCol[01]  PSay "Total Geral: " 
	@ nLin, aCol[09]  PSay Transform( nTotVlr  , "@E 9,999,999.99" )

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
	
		cExcel :=  AllTrim(GetTempPath())+"VENDAS_SEGMENTO_VENDEDOR"+StrTran(Dtoc(dDatabase),"/","")+".XLS"
		
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
ฑฑบFuncao    ณMR015PERG บ Autor ณ Bruno Parreira     บ Data ณ  02/07/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Cria parametros da rotina                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Especifico Lisonda Engenharia e Construcoes Ltda.          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

Static Function MR015PERG(cPerg)

Local cAlias := Alias()
Local aRegs  := {}
Local nI,nJ

DbSelectArea("SX1")
DbSetOrder(1)
cPerg := PADR(cPerg,10)

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
aAdd(aRegs,{cPerg,"01","Data Vendas de      ? ","","","MV_CH1","D",08,0,0,"G","","MV_PAR01","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"02","Data Vendas Ate     ? ","","","MV_CH2","D",08,0,0,"G","","MV_PAR02","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"03","Cliente de          ? ","","","MV_CH3","C",06,0,0,"G","","MV_PAR03","","","","","","","","","","","","","","","","","","","","","","","","","SA1"})
aAdd(aRegs,{cPerg,"04","Cliente Ate         ? ","","","MV_CH4","C",06,0,0,"G","","MV_PAR04","","","","","","","","","","","","","","","","","","","","","","","","","SA1"})
aAdd(aRegs,{cPerg,"05","Representante De    ? ","","","MV_CH5","C",06,0,0,"G","","MV_PAR05","","","","","","","","","","","","","","","","","","","","","","","","","SA3"})
aAdd(aRegs,{cPerg,"06","Representante Ate   ? ","","","MV_CH6","C",06,0,0,"G","","MV_PAR06","","","","","","","","","","","","","","","","","","","","","","","","","SA3"})
aAdd(aRegs,{cPerg,"07","Estado De           ? ","","","MV_CH7","C",02,0,0,"G","","MV_PAR07","","","","","","","","","","","","","","","","","","","","","","","","","12"})
aAdd(aRegs,{cPerg,"08","Estado Ate          ? ","","","MV_CH8","C",02,0,0,"G","","MV_PAR08","","","","","","","","","","","","","","","","","","","","","","","","","12"})
aAdd(aRegs,{cPerg,"09","Apurar Valor        ? ","","","MV_CH9","N",01,0,1,"C","","MV_PAR09","Mercadoria","","","","","Impostos","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"10","Segm[ACMVT]bco=todos? ","","","MV_CHA","C",05,0,1,"G","","MV_PAR10","","","","","","","","","","","","","","","","","","","","","","","","",""})

For nI := 1 to Len(aRegs)
	If !dbSeek(cPerg+aRegs[nI,2])
		RecLock("SX1",.T.)
		For nJ := 1 To FCount()
			If nJ <= Len(aRegs[nI])
				FieldPut(nJ,aRegs[nI,nJ])
			EndIf
		Next
		MsUnlock()
	EndIf
Next

DbSelectArea(cAlias)

Return Nil