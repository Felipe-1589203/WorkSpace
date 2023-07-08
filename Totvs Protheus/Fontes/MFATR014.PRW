#Include "RwMake.ch"
#Include "Protheus.ch"
#Include "Topconn.ch"  

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MFATR014  º Autor ³ Bruno Parreira     º Data ³  03/06/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatorio Media de faturamento Analitico                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAlteracoes³                º 17/04/12 º                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Especifico MULTLOCK                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function MFATR014()

Local cDesc1       	:= "Este programa tem como objetivo imprimir relatorio "
Local cDesc2       	:= "de acordo com os parametros informados pelo usuario."
Local cDesc3       	:= "Media de Faturamento - Analítico"
Local cPict        	:= ""
Local titulo       	:= "Media de Faturamento - Analítico"
Local nLin         	:= 80
					  //          1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1         2
					  //01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
Local Cabec1       	:= "PRODUTO DESCRICAO                                  TIPO  ANO     JANEIRO   FEVEREIRO   MARCO     ABRIL       MAIO      JUNHO       JULHO      AGOSTO    SETEMBRO   OUTUBRO   NOVEMBRO  DEZEMBRO       TOTAL        MEDIA    "
Local Cabec2       	:= "                                                                                                                                                                                                                            "

Local imprime      	:= .T.
Local aOrd         	:= {}
Local lPerg        	:= .T.
                     //  1    2   3   4   5   6   7   8   9   10  11  12  13   14  15  16  17  18  
Private aCol       	:= {000,008,051,056,062,073,084,095,106,117,128,139,150,161,172,183,195,208}
Private lEnd       	:= .F.
Private lAbortPrint	:= .F.
Private CbTxt      	:= ""
Private limite     	:= 220
Private tamanho    	:= "G"
Private nomeprog   	:= "MFATR014"
Private nTipo      	:= 15
Private aReturn    	:= { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey   	:= 0
Private cbtxt      	:= Space(10)
Private cbcont     	:= 00
Private CONTFL     	:= 01
Private m_pag      	:= 01
Private wnrel      	:= "MFATR014"
Private cPerg      	:= "MFATR014"
Private cString    	:= "SD2"  
Private cArqTMP  
                    
Private cSegmento   := ""
          
lCont := .F.          
                
MR014PERG(cPerg)

While !lCont
	lPerg := Pergunte(cPerg)
	If Empty(MV_PAR04)
		If lPerg
			lCont := .F. 
			MsgAlert("Insira a letra referente ao segmento conforme help. Para todos segmentos insira a letra T.")
		else
			lCont := .T.	
		EndIf  	 
	else
		If !(MV_PAR04 $ "TACMVIB")
			lCont := .F.
			MsgAlert("Letra não corresponde a nenhum segmento existente. Insira apenas letras conforme orientação do help.")
		else	
			lCont := .T.
		EndIf	
	EndIf
EndDo 

If MV_PAR04 = "T"
	titulo += " - Segmento: Todos"
ElseIf MV_PAR04 = "M"
	titulo += " - Segmento: Multlockcenter"	 
ElseIf MV_PAR04 = "A"
	titulo += " - Segmento: Automotivo"	
ElseIf MV_PAR04 = "B"
	titulo += " - Segmento: Construtora"	
ElseIf MV_PAR04 = "V"
	titulo += " - Segmento: Varejo"	
ElseIf MV_PAR04 = "C"
	titulo += " - Segmento: Corporativo"
ElseIf MV_PAR04 = "I"
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
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³RunReport º Autor ³ Bruno Parreira     º Data ³  03/06/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Busca registros no banco e gera relatorio                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Especifico Lisonda Engenharia e Construcoes Ltda.          º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

Local cQuery     := ""
Local nTotreg    := 0
Local nTotMeses  := 0 
Local nTotVlr 	 := 0
Local nTotVlrMed := 0
Local nMedVlr	 := 0
Local nMedQtd	 := 0  
Local nContar	 := 0   

cSegmento := MV_PAR04

cQuery :=        "  SELECT SD2.D2_COD, SB1.B1_DESC, SubString(SD2.D2_EMISSAO,1,4) as ANO "
cQuery += CRLF + "  , [JAN_QTD]  = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=01 then (SD2.D2_QUANT)end),0) "
cQuery += CRLF + "  , [JAN_VLR]  = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=01 then (SD2.D2_TOTAL+SD2.D2_VALIPI+SD2.D2_ICMSRET)end),0) "
cQuery += CRLF + "  , [FEV_QTD]  = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=02 then (SD2.D2_QUANT)end),0) "
cQuery += CRLF + "  , [FEV_VLR]  = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=02 then (SD2.D2_TOTAL+SD2.D2_VALIPI+SD2.D2_ICMSRET)end),0) "
cQuery += CRLF + "  , [MAR_QTD]  = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=03 then (SD2.D2_QUANT)end),0) "
cQuery += CRLF + "  , [MAR_VLR]  = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=03 then (SD2.D2_TOTAL+SD2.D2_VALIPI+SD2.D2_ICMSRET)end),0) "
cQuery += CRLF + "  , [ABR_QTD]  = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=04 then (SD2.D2_QUANT)end),0) "
cQuery += CRLF + "  , [ABR_VLR]  = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=04 then (SD2.D2_TOTAL+SD2.D2_VALIPI+SD2.D2_ICMSRET)end),0) "
cQuery += CRLF + "  , [MAI_QTD]  = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=05 then (SD2.D2_QUANT)end),0) "
cQuery += CRLF + "  , [MAI_VLR]  = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=05 then (SD2.D2_TOTAL+SD2.D2_VALIPI+SD2.D2_ICMSRET)end),0) "
cQuery += CRLF + "  , [JUN_QTD]  = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=06 then (SD2.D2_QUANT)end),0) "
cQuery += CRLF + "  , [JUN_VLR]  = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=06 then (SD2.D2_TOTAL+SD2.D2_VALIPI+SD2.D2_ICMSRET)end),0) "
cQuery += CRLF + "  , [JUL_QTD]  = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=07 then (SD2.D2_QUANT)end),0) "
cQuery += CRLF + "  , [JUL_VLR]  = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=07 then (SD2.D2_TOTAL+SD2.D2_VALIPI+SD2.D2_ICMSRET)end),0) "
cQuery += CRLF + "  , [AGO_QTD]  = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=08 then (SD2.D2_QUANT)end),0) "
cQuery += CRLF + "  , [AGO_VLR]  = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=08 then (SD2.D2_TOTAL+SD2.D2_VALIPI+SD2.D2_ICMSRET)end),0) "
cQuery += CRLF + "  , [SET_QTD]  = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=09 then (SD2.D2_QUANT)end),0) "
cQuery += CRLF + "  , [SET_VLR]  = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=09 then (SD2.D2_TOTAL+SD2.D2_VALIPI+SD2.D2_ICMSRET)end),0) "
cQuery += CRLF + "  , [OUT_QTD]  = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=10 then (SD2.D2_QUANT)end),0) "
cQuery += CRLF + "  , [OUT_VLR]  = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=10 then (SD2.D2_TOTAL+SD2.D2_VALIPI+SD2.D2_ICMSRET)end),0) "
cQuery += CRLF + "  , [NOV_QTD]  = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=11 then (SD2.D2_QUANT)end),0) "
cQuery += CRLF + "  , [NOV_VLR]  = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=11 then (SD2.D2_TOTAL+SD2.D2_VALIPI+SD2.D2_ICMSRET)end),0) "
cQuery += CRLF + "  , [DEZ_QTD]  = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=12 then (SD2.D2_QUANT)end),0) "
cQuery += CRLF + "  , [DEZ_VLR]  = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=12 then (SD2.D2_TOTAL+SD2.D2_VALIPI+SD2.D2_ICMSRET)end),0) "
cQuery += CRLF + "  , SUM(SD2.D2_QUANT) AS D2_QUANT, SUM(SD2.D2_TOTAL+SD2.D2_VALIPI+SD2.D2_ICMSRET) AS TOTAL, "    
cQuery += CRLF + "  case "
cQuery += CRLF + "    when SubString(SD2.D2_EMISSAO,1,4)='"+StrZero(Year(MV_PAR01),4)+"' "
cQuery += CRLF + "      then DATEDIFF(MONTH,'"+DtoS(MV_PAR01)+"','"+StrZero(Year(MV_PAR01),4)+"1231')+1 "
cQuery += CRLF + "    when SubString(SD2.D2_EMISSAO,1,4)>'"+StrZero(Year(MV_PAR01),4)+"' and SubString(SD2.D2_EMISSAO,1,4)<'"+StrZero(Year(MV_PAR02),4)+"' "
cQuery += CRLF + "      then '12' "
cQuery += CRLF + "    else "
cQuery += CRLF + "      DATEDIFF(MONTH,'"+StrZero(Year(MV_PAR02),4)+"0101','"+DtoS(MV_PAR02)+"')+1 "
cQuery += CRLF + "  end As NUM_MES "  
cQuery += CRLF + "   FROM "+RetSqlName("SD2")+" SD2 "
cQuery += CRLF + "    JOIN "+RetSqlName("SA1")+" AS SA1 "
cQuery += CRLF + "     ON  SA1.A1_COD = SD2.D2_CLIENTE "
cQuery += CRLF + "     AND SA1.A1_LOJA = SD2.D2_LOJA "
cQuery += CRLF + "     AND SA1.D_E_L_E_T_ = ' ' "  
If MV_PAR04 <> "T"
	cQuery += CRLF + "    JOIN "+RetSqlName("SC5")+" AS SC5 "
	cQuery += CRLF + "     ON  SC5.C5_FILIAL = SD2.D2_FILIAL "
	cQuery += CRLF + "     AND SC5.C5_NUM    = SD2.D2_PEDIDO "
	cQuery += CRLF + "     AND SC5.C5_XORIGEM = '"+cSegmento+"' "
	cQuery += CRLF + "     AND SC5.D_E_L_E_T_ = ' ' "  
EndIf	
cQuery += CRLF + "    JOIN "+RetSqlName("SF4")+" AS SF4 "
cQuery += CRLF + "     ON  SF4.F4_FILIAL = SD2.D2_FILIAL "
cQuery += CRLF + "     AND SF4.F4_CODIGO = SD2.D2_TES "
cQuery += CRLF + "     AND SF4.F4_FILIAL = '"+xFilial("SF4")+"' "
cQuery += CRLF + "     AND SF4.D_E_L_E_T_ = ' ' "  
cQuery += CRLF + "    JOIN "+RetSqlName("SB1")+" AS SB1 "
cQuery += CRLF + "     ON  SB1.B1_COD = SD2.D2_COD "
cQuery += CRLF + "     AND SB1.D_E_L_E_T_ = ' ' "
cQuery += CRLF + "   WHERE SD2.D2_EMISSAO BETWEEN '"+DtoS(MV_PAR01)+"' AND '"+DtoS(MV_PAR02)+"' "
cQuery += CRLF + "    AND SD2.D2_FILIAL = '"+xFilial("SD2")+"' "
cQuery += CRLF + "    AND (SD2.D2_TIPO = 'N' OR SD2.D2_TIPO = 'C') "
cQuery += CRLF + "    AND (SD2.D2_CF = '5101' OR SD2.D2_CF = '6101' OR SD2.D2_CF = '5118' OR SD2.D2_CF = '6118' OR "
cQuery += CRLF + "    SD2.D2_CF = '5401' OR SD2.D2_CF = '6401' OR SD2.D2_CF = '5922' OR SD2.D2_CF = '6922' OR "
cQuery += CRLF + "    SD2.D2_CF = '6107' OR SD2.D2_CF = '6108' OR SD2.D2_CF = '6109') "
cQuery += CRLF + "    AND SD2.D_E_L_E_T_ <> '*' "
cQuery += CRLF + "   GROUP BY SD2.D2_COD, SB1.B1_DESC, SubString(SD2.D2_EMISSAO,1,4) "
cQuery += CRLF + "   ORDER BY SD2.D2_COD, SubString(SD2.D2_EMISSAO,1,4) "

MemoWrite("MFATR014.txt",cQuery)

cAliasA := GetNextAlias()
cQuery  := ChangeQuery(cQuery)

DbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cAliasA , .F., .T.)
aEval( SD2->(DbStruct()),{|x| If(x[2] != "C", TcSetField(cAliasA, AllTrim(x[1]), x[2], x[3], x[4]),Nil)})
aEval( SB1->(DbStruct()),{|x| If(x[2] != "C", TcSetField(cAliasA, AllTrim(x[1]), x[2], x[3], x[4]),Nil)})

// ************************ Monta Estrutura do Temporario Excel
_aStruct := {} 
aAdd(_aStruct,{"PRODUTO"  ,"C",TAMSX3( "D2_COD"   )[1],TAMSX3( "D2_COD"   )[2]})	// Cod. Produto
aAdd(_aStruct,{"DESCRICAO","C",TAMSX3( "B1_DESC"  )[1],TAMSX3( "B1_DESC"  )[2]})	// Descricao
aAdd(_aStruct,{"ANO"      ,"C",4                       ,0                      })	// Ano
aAdd(_aStruct,{"JAN_QTD"  ,"N",TAMSX3( "D2_QUANT" )[1],TAMSX3( "D2_QUANT" )[2]})	// Quantidade
aAdd(_aStruct,{"JAN_VLR"  ,"N",TAMSX3( "D2_QUANT" )[1],TAMSX3( "D2_QUANT" )[2]})	// Valor           
aAdd(_aStruct,{"FEV_QTD"  ,"N",TAMSX3( "D2_QUANT" )[1],TAMSX3( "D2_QUANT" )[2]})	// Quantidade
aAdd(_aStruct,{"FEV_VLR"  ,"N",TAMSX3( "D2_QUANT" )[1],TAMSX3( "D2_QUANT" )[2]})	// Valor
aAdd(_aStruct,{"MAR_QTD"  ,"N",TAMSX3( "D2_QUANT" )[1],TAMSX3( "D2_QUANT" )[2]})	// Quantidade
aAdd(_aStruct,{"MAR_VLR"  ,"N",TAMSX3( "D2_QUANT" )[1],TAMSX3( "D2_QUANT" )[2]})	// Valor
aAdd(_aStruct,{"ABR_QTD"  ,"N",TAMSX3( "D2_QUANT" )[1],TAMSX3( "D2_QUANT" )[2]})	// Quantidade
aAdd(_aStruct,{"ABR_VLR"  ,"N",TAMSX3( "D2_QUANT" )[1],TAMSX3( "D2_QUANT" )[2]})	// Valor
aAdd(_aStruct,{"MAI_QTD"  ,"N",TAMSX3( "D2_QUANT" )[1],TAMSX3( "D2_QUANT" )[2]})	// Quantidade
aAdd(_aStruct,{"MAI_VLR"  ,"N",TAMSX3( "D2_QUANT" )[1],TAMSX3( "D2_QUANT" )[2]})	// Valor
aAdd(_aStruct,{"JUN_QTD"  ,"N",TAMSX3( "D2_QUANT" )[1],TAMSX3( "D2_QUANT" )[2]})	// Quantidade
aAdd(_aStruct,{"JUN_VLR"  ,"N",TAMSX3( "D2_QUANT" )[1],TAMSX3( "D2_QUANT" )[2]})	// Valor
aAdd(_aStruct,{"JUL_QTD"  ,"N",TAMSX3( "D2_QUANT" )[1],TAMSX3( "D2_QUANT" )[2]})	// Quantidade
aAdd(_aStruct,{"JUL_VLR"  ,"N",TAMSX3( "D2_QUANT" )[1],TAMSX3( "D2_QUANT" )[2]})	// Valor
aAdd(_aStruct,{"AGO_QTD"  ,"N",TAMSX3( "D2_QUANT" )[1],TAMSX3( "D2_QUANT" )[2]})	// Quantidade
aAdd(_aStruct,{"AGO_VLR"  ,"N",TAMSX3( "D2_QUANT" )[1],TAMSX3( "D2_QUANT" )[2]})	// Valor
aAdd(_aStruct,{"SET_QTD"  ,"N",TAMSX3( "D2_QUANT" )[1],TAMSX3( "D2_QUANT" )[2]})	// Quantidade
aAdd(_aStruct,{"SET_VLR"  ,"N",TAMSX3( "D2_QUANT" )[1],TAMSX3( "D2_QUANT" )[2]})	// Valor
aAdd(_aStruct,{"OUT_QTD"  ,"N",TAMSX3( "D2_QUANT" )[1],TAMSX3( "D2_QUANT" )[2]})	// Quantidade
aAdd(_aStruct,{"OUT_VLR"  ,"N",TAMSX3( "D2_QUANT" )[1],TAMSX3( "D2_QUANT" )[2]})	// Valor
aAdd(_aStruct,{"NOV_QTD"  ,"N",TAMSX3( "D2_QUANT" )[1],TAMSX3( "D2_QUANT" )[2]})	// Quantidade
aAdd(_aStruct,{"NOV_VLR"  ,"N",TAMSX3( "D2_QUANT" )[1],TAMSX3( "D2_QUANT" )[2]})	// Valor
aAdd(_aStruct,{"DEZ_QTD"  ,"N",TAMSX3( "D2_QUANT" )[1],TAMSX3( "D2_QUANT" )[2]})	// Quantidade
aAdd(_aStruct,{"DEZ_VLR"  ,"N",TAMSX3( "D2_QUANT" )[1],TAMSX3( "D2_QUANT" )[2]})	// Valor
aAdd(_aStruct,{"QTD_TOTAL","N",TAMSX3( "D2_QUANT" )[1],TAMSX3( "D2_QUANT" )[2]})	// Quantidade Total
aAdd(_aStruct,{"VLR_TOTAL","N",TAMSX3( "D2_TOTAL" )[1],TAMSX3( "D2_TOTAL" )[2]})	// Valor Total
aAdd(_aStruct,{"QTD_MEDIA","N",TAMSX3( "D2_QUANT" )[1],TAMSX3( "D2_QUANT" )[2]})	// Quantidade Media
aAdd(_aStruct,{"VLR_MEDIO","N",TAMSX3( "D2_TOTAL" )[1],TAMSX3( "D2_TOTAL" )[2]})	// Valor Medio 

cArqTMP	:= CriaTrab(_aStruct)   

dbUseArea( .T.,, cArqTmp, "TMP", if(.F. .OR. .F., !.F., NIL), .F. )          //__LocalDriver

DbSelectArea( cAliasA )
(cAliasA)->( DbEval( { || nTotReg++ },,{ || !Eof() } ) )
(cAliasA)->( DbGoTop() )

//nTotMeses := Round(((MV_PAR02 - MV_PAR01)/30),0)

If (cAliasA)->( !Eof() )
	ProcRegua( nTotReg )
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
	
		nMedQtd := ((cAliasA)->D2_QUANT/(cAliasA)->NUM_MES)       
		//nMedVlr := ((cAliasA)->TOTAL/(cAliasA)->NUM_MES)
		//Substituida linha acima pela linha abaixo a pedido do Eneas [Bruno Parreira, Actual Trend, 06/07/2012] 
		nMedVlr := ((cAliasA)->TOTAL/(cAliasA)->D2_QUANT)
		 
		If MV_PAR03 == 1
		
			@ nLin, aCol[01] PSay Left((cAliasA)->D2_COD,12)
			@ nLin, aCol[02] PSay Left((cAliasA)->B1_DESC,40)
			@ nLin, aCol[03] PSay "QTD"
			@ nLin, aCol[04] PSay (cAliasA)->ANO
			                                                                 
			@ nLin, (aCol[05]-1) PSay "|"                                        
			@ nLin, (aCol[06]-1) PSay "|"
			@ nLin, (aCol[07]-1) PSay "|"
			@ nLin, (aCol[08]-1) PSay "|"
			@ nLin, (aCol[09]-1) PSay "|"
			@ nLin, (aCol[10]-1) PSay "|"
			@ nLin, (aCol[11]-1) PSay "|"
			@ nLin, (aCol[12]-1) PSay "|"
			@ nLin, (aCol[13]-1) PSay "|"
			@ nLin, (aCol[14]-1) PSay "|"
			@ nLin, (aCol[15]-1) PSay "|"
			@ nLin, (aCol[16]-1) PSay "|" 
			@ nLin, (aCol[17]-1) PSay "|"
			@ nLin, (aCol[18]-1) PSay "|"
			
			@ nLin, aCol[05] PSay Transform((cAliasA)->JAN_QTD, "@E 99,999")
			@ nLin, aCol[06] PSay Transform((cAliasA)->FEV_QTD, "@E 99,999")
			@ nLin, aCol[07] PSay Transform((cAliasA)->MAR_QTD, "@E 99,999")
			@ nLin, aCol[08] PSay Transform((cAliasA)->ABR_QTD, "@E 99,999")
			@ nLin, aCol[09] PSay Transform((cAliasA)->MAI_QTD, "@E 99,999")
			@ nLin, aCol[10] PSay Transform((cAliasA)->JUN_QTD, "@E 99,999")
			@ nLin, aCol[11] PSay Transform((cAliasA)->JUL_QTD, "@E 99,999")
			@ nLin, aCol[12] PSay Transform((cAliasA)->AGO_QTD, "@E 99,999")
			@ nLin, aCol[13] PSay Transform((cAliasA)->SET_QTD, "@E 99,999")
			@ nLin, aCol[14] PSay Transform((cAliasA)->OUT_QTD, "@E 99,999")
			@ nLin, aCol[15] PSay Transform((cAliasA)->NOV_QTD, "@E 99,999")
			@ nLin, aCol[16] PSay Transform((cAliasA)->DEZ_QTD, "@E 99,999")
			
			@ nLin, aCol[17] PSay Transform((cAliasA)->D2_QUANT, "@E 99,999")
			@ nLin, aCol[18] PSay Transform( nMedQtd , "@E 99,999")
			
		ElseIf MV_PAR03 == 2
		
			@ nLin, aCol[01] PSay Left((cAliasA)->D2_COD,12)
			@ nLin, aCol[02] PSay Left((cAliasA)->B1_DESC,40)
			@ nLin, aCol[03] PSay "VLR"          
			@ nLin, aCol[04] PSay (cAliasA)->ANO        
			
			@ nLin, (aCol[05]-1) PSay "|"                                        
			@ nLin, (aCol[06]-1) PSay "|"
			@ nLin, (aCol[07]-1) PSay "|"
			@ nLin, (aCol[08]-1) PSay "|"
			@ nLin, (aCol[09]-1) PSay "|"
			@ nLin, (aCol[10]-1) PSay "|"
			@ nLin, (aCol[11]-1) PSay "|"
			@ nLin, (aCol[12]-1) PSay "|"
			@ nLin, (aCol[13]-1) PSay "|"
			@ nLin, (aCol[14]-1) PSay "|"
			@ nLin, (aCol[15]-1) PSay "|"
			@ nLin, (aCol[16]-1) PSay "|"   
			@ nLin, (aCol[17]-1) PSay "|"
			@ nLin, (aCol[18]-1) PSay "|"         
			
			@ nLin, aCol[05] PSay Transform((cAliasA)->JAN_VLR, "@E 999,999.99")
			@ nLin, aCol[06] PSay Transform((cAliasA)->FEV_VLR, "@E 999,999.99")
			@ nLin, aCol[07] PSay Transform((cAliasA)->MAR_VLR, "@E 999,999.99")
			@ nLin, aCol[08] PSay Transform((cAliasA)->ABR_VLR, "@E 999,999.99")
			@ nLin, aCol[09] PSay Transform((cAliasA)->MAI_VLR, "@E 999,999.99")
			@ nLin, aCol[10] PSay Transform((cAliasA)->JUN_VLR, "@E 999,999.99")
			@ nLin, aCol[11] PSay Transform((cAliasA)->JUL_VLR, "@E 999,999.99")
			@ nLin, aCol[12] PSay Transform((cAliasA)->AGO_VLR, "@E 999,999.99")
			@ nLin, aCol[13] PSay Transform((cAliasA)->SET_VLR, "@E 999,999.99")
			@ nLin, aCol[14] PSay Transform((cAliasA)->OUT_VLR, "@E 999,999.99")
			@ nLin, aCol[15] PSay Transform((cAliasA)->NOV_VLR, "@E 999,999.99")
			@ nLin, aCol[16] PSay Transform((cAliasA)->DEZ_VLR, "@E 999,999.99")
			              
			@ nLin, aCol[17] PSay Transform((cAliasA)->TOTAL, "@E 9,999,999.99")
			@ nLin, aCol[18] PSay Transform( nMedVlr , "@E 9,999,999.99")  
			
		Else
			
			@ nLin, aCol[01] PSay Left((cAliasA)->D2_COD,12)
			@ nLin, aCol[02] PSay Left((cAliasA)->B1_DESC,40)
			@ nLin, aCol[03] PSay "QTD"         
			@ nLin, aCol[04] PSay (cAliasA)->ANO   
			
			@ nLin, (aCol[05]-1) PSay "|"                                        
			@ nLin, (aCol[06]-1) PSay "|"
			@ nLin, (aCol[07]-1) PSay "|"
			@ nLin, (aCol[08]-1) PSay "|"
			@ nLin, (aCol[09]-1) PSay "|"
			@ nLin, (aCol[10]-1) PSay "|"
			@ nLin, (aCol[11]-1) PSay "|"
			@ nLin, (aCol[12]-1) PSay "|"
			@ nLin, (aCol[13]-1) PSay "|"
			@ nLin, (aCol[14]-1) PSay "|"
			@ nLin, (aCol[15]-1) PSay "|"
			@ nLin, (aCol[16]-1) PSay "|"
			@ nLin, (aCol[17]-1) PSay "|"
			@ nLin, (aCol[18]-1) PSay "|"
			
			@ nLin, aCol[05] PSay Transform((cAliasA)->JAN_QTD, "@E 99,999")
			@ nLin, aCol[06] PSay Transform((cAliasA)->FEV_QTD, "@E 99,999")
			@ nLin, aCol[07] PSay Transform((cAliasA)->MAR_QTD, "@E 99,999")
			@ nLin, aCol[08] PSay Transform((cAliasA)->ABR_QTD, "@E 99,999")
			@ nLin, aCol[09] PSay Transform((cAliasA)->MAI_QTD, "@E 99,999")
			@ nLin, aCol[10] PSay Transform((cAliasA)->JUN_QTD, "@E 99,999")
			@ nLin, aCol[11] PSay Transform((cAliasA)->JUL_QTD, "@E 99,999")
			@ nLin, aCol[12] PSay Transform((cAliasA)->AGO_QTD, "@E 99,999")
			@ nLin, aCol[13] PSay Transform((cAliasA)->SET_QTD, "@E 99,999")
			@ nLin, aCol[14] PSay Transform((cAliasA)->OUT_QTD, "@E 99,999")
			@ nLin, aCol[15] PSay Transform((cAliasA)->NOV_QTD, "@E 99,999")
			@ nLin, aCol[16] PSay Transform((cAliasA)->DEZ_QTD, "@E 99,999")
			
			@ nLin, aCol[17] PSay Transform((cAliasA)->D2_QUANT, "@E 99,999")
			@ nLin, aCol[18] PSay Transform( nMedQtd , "@E 99,999")        
		    
			nLin++
			
			@ nLin, aCol[01] PSay Left((cAliasA)->D2_COD,12)
			@ nLin, aCol[02] PSay Left((cAliasA)->B1_DESC,40)
			@ nLin, aCol[03] PSay "VLR"                                
			@ nLin, aCol[04] PSay (cAliasA)->ANO   
			
			@ nLin, (aCol[05]-1) PSay "|"                                        
			@ nLin, (aCol[06]-1) PSay "|"
			@ nLin, (aCol[07]-1) PSay "|"
			@ nLin, (aCol[08]-1) PSay "|"
			@ nLin, (aCol[09]-1) PSay "|"
			@ nLin, (aCol[10]-1) PSay "|"
			@ nLin, (aCol[11]-1) PSay "|"
			@ nLin, (aCol[12]-1) PSay "|"
			@ nLin, (aCol[13]-1) PSay "|"
			@ nLin, (aCol[14]-1) PSay "|"
			@ nLin, (aCol[15]-1) PSay "|"
			@ nLin, (aCol[16]-1) PSay "|"
			@ nLin, (aCol[17]-1) PSay "|"
			@ nLin, (aCol[18]-1) PSay "|"
			
			@ nLin, aCol[05] PSay Transform((cAliasA)->JAN_VLR, "@E 999,999.99")
			@ nLin, aCol[06] PSay Transform((cAliasA)->FEV_VLR, "@E 999,999.99")
			@ nLin, aCol[07] PSay Transform((cAliasA)->MAR_VLR, "@E 999,999.99")
			@ nLin, aCol[08] PSay Transform((cAliasA)->ABR_VLR, "@E 999,999.99")
			@ nLin, aCol[09] PSay Transform((cAliasA)->MAI_VLR, "@E 999,999.99")
			@ nLin, aCol[10] PSay Transform((cAliasA)->JUN_VLR, "@E 999,999.99")
			@ nLin, aCol[11] PSay Transform((cAliasA)->JUL_VLR, "@E 999,999.99")
			@ nLin, aCol[12] PSay Transform((cAliasA)->AGO_VLR, "@E 999,999.99")
			@ nLin, aCol[13] PSay Transform((cAliasA)->SET_VLR, "@E 999,999.99")
			@ nLin, aCol[14] PSay Transform((cAliasA)->OUT_VLR, "@E 999,999.99")
			@ nLin, aCol[15] PSay Transform((cAliasA)->NOV_VLR, "@E 999,999.99")
			@ nLin, aCol[16] PSay Transform((cAliasA)->DEZ_VLR, "@E 999,999.99")
			
			@ nLin, aCol[17] PSay Transform((cAliasA)->TOTAL, "@E 9,999,999.99")
			@ nLin, aCol[18] PSay Transform( nMedVlr , "@E 9,999,999.99")   
			
		EndIf				
				
		nLin++
		
		nTotVlr    += (cAliasA)->TOTAL
		//nTotVlrMed += nMedVlr
		    
 		RecLock("TMP",.T.)
 		TMP->PRODUTO	:= (cAliasA)->D2_COD  
 		TMP->DESCRICAO	:= (cAliasA)->B1_DESC 
 		TMP->ANO    	:= (cAliasA)->ANO
 		TMP->JAN_QTD	:= (cAliasA)->JAN_QTD
 		TMP->JAN_VLR	:= (cAliasA)->JAN_VLR 
 		TMP->FEV_QTD	:= (cAliasA)->FEV_QTD
 		TMP->FEV_VLR	:= (cAliasA)->FEV_VLR
 		TMP->MAR_QTD	:= (cAliasA)->MAR_QTD
 		TMP->MAR_VLR	:= (cAliasA)->MAR_VLR
 		TMP->ABR_QTD	:= (cAliasA)->ABR_QTD
 		TMP->ABR_VLR	:= (cAliasA)->ABR_VLR
 		TMP->MAI_QTD	:= (cAliasA)->MAI_QTD
 		TMP->MAI_VLR	:= (cAliasA)->MAI_VLR
 		TMP->JUN_QTD	:= (cAliasA)->JUN_QTD
 		TMP->JUN_VLR	:= (cAliasA)->JUN_VLR
 		TMP->JUL_QTD	:= (cAliasA)->JUL_QTD
 		TMP->JUL_VLR	:= (cAliasA)->JUL_VLR
 		TMP->AGO_QTD	:= (cAliasA)->AGO_QTD
 		TMP->AGO_VLR	:= (cAliasA)->AGO_VLR
 		TMP->SET_QTD	:= (cAliasA)->SET_QTD
 		TMP->SET_VLR	:= (cAliasA)->SET_VLR
 		TMP->OUT_QTD	:= (cAliasA)->OUT_QTD
 		TMP->OUT_VLR	:= (cAliasA)->OUT_VLR
 		TMP->NOV_QTD	:= (cAliasA)->NOV_QTD
 		TMP->NOV_VLR	:= (cAliasA)->NOV_VLR
 		TMP->DEZ_QTD	:= (cAliasA)->DEZ_QTD
 		TMP->DEZ_VLR	:= (cAliasA)->DEZ_VLR
 		TMP->QTD_TOTAL	:= (cAliasA)->D2_QUANT
 		TMP->VLR_TOTAL	:= (cAliasA)->TOTAL
 		TMP->QTD_MEDIA	:= nMedQtd
 		TMP->VLR_MEDIO	:= nMedVlr
 		MsUnlock()
		
		(cAliasA)->( DbSkip() )
	End-While
	
 	@ nLin,000 PSay __PrtThinLine()
 	nLin++
 	@ nLin, aCol[01]  PSay "VALOR TOTAL: " 
	@ nLin, aCol[17]  PSay Transform( nTotVlr    , "@E 99,999,999.99" )
	//@ nLin, aCol[08]  PSay Transform( nTotVlrMed , "@E 99,999,999.99" )
	nLin += 2
		
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
	
		cExcel :=  AllTrim(GetTempPath())+"MEDIA_FATURAMENTO_ANALITICO"+StrTran(Dtoc(dDatabase),"/","")+".XLS"
		
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
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³MR014PERG º Autor ³ Bruno Parreira     º Data ³  03/06/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Cria parametros da rotina                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Especifico Lisonda Engenharia e Construcoes Ltda.          º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function MR014PERG(cPerg)

Local aAreaAtu	:= GetArea()
Local aAreaSX1	:= SX1->( GetArea() )

PutSx1(	cPerg, "01", "Data Emissao de        ? ", "" , "", "Mv_ch1", TAMSX3( "F2_EMISSAO" )[3], TAMSX3( "F2_EMISSAO" )[1], TAMSX3( "F2_EMISSAO" )[2], 0,"G","","","","N","Mv_par01","","","","","","","","","","","","","","","","",{"Digite a data de emissão inicial",""},{""},{""},"")
PutSx1(	cPerg, "02", "Data Emissao ate       ? ", "" , "", "Mv_ch2", TAMSX3( "F2_EMISSAO" )[3], TAMSX3( "F2_EMISSAO" )[1], TAMSX3( "F2_EMISSAO" )[2], 0,"G","","","","N","Mv_par02","","","","","","","","","","","","","","","","",{"Digite a data de emissão final  ",""},{""},{""},"")
PutSx1(	cPerg, "03", "Considera Qtd/Vlr      ? ", "" , "", "Mv_ch3", "N"                       , 01                       , 0                         , 1,"C","","","","N","Mv_par03","Quantidade","","","","Valor","","","Ambos","","","","","","","","",{"Considera Valor ou Quantidade ? ",""},{""},{""},"")
PutSx1(	cPerg, "04", "Segmento[TACMVIB]      ? ", "" , "", "Mv_ch4", TAMSX3( "C5_XORIGEM" )[3], TAMSX3( "C5_XORIGEM" )[1], TAMSX3( "C5_XORIGEM" )[2], 0,"G","","","","N","Mv_par04","","","","","","","","","","","","","","","","",{"T=Todos; A=Automotivo; C=Corporativo;","M=MultlockCenter; B=Construtora;","V=Varejo;I=Industrial"},{""},{""},"")

RestArea( aAreaSX1 )
RestArea( aAreaAtu )

Return(cPerg)