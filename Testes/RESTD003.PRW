#INCLUDE "rwmake.ch"
#include "TOPCONN.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัอออออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRESTD003  บ Autor ณ Ricardo A. Batagella  บ Data ณ  23/09/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯอออออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Relatorio de vendas em quantidade / valor por mes em formato  บฑฑ
ฑฑบ          ณ de meses do ano                                               บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Higietopp                                                     บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

User Function RESTD003


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Local c_Titulo := "Exporta Faturamento Mes"
Local c_Desc1  := "Higietopp"
Local c_Desc2  := "Este programa tem como fun็ใo gerar planilha em excel "
Local c_Desc3  := "com o faturamento NEG mes a mes"
Local a_Say    := {}
Local a_Button := {}
Local n_Opc

Private cPerg			:= "RESTD003"
Private nCount			:= 0
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Variaveis utilizadas para parametros                         ณ
//ณ mv_par01              Da Data ?                              ณ
//ณ mv_par02              Ate a Data                             ณ
//ณ mv_par03              Cliente De ?                           ณ
//ณ mv_par04              Cliente Ate ?                          ณ
//ณ mv_par05              Vendedor De ?                          ณ
//ณ mv_par06              Vendedor Ate ?                         ณ
//ณ mv_par07              Estado (UF) de ?                       ณ
//ณ mv_par08              Estado (UF) ate ?                      ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
CriaSx1(cPerg)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//| Solicita ao usuario a parametrizacao do relatorio.                  |
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Pergunte(cPerg,.F.)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta a interface padrao com o usuario...                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

aAdd( a_Say, c_Desc1 )
aAdd( a_Say, c_Desc2 ) 
aAdd( a_Say, c_Desc3 )

aAdd( a_Button, { 1, .T., {|x| n_Opc := 1, oDlg:End() }} ) //Ok
aAdd( a_Button, { 2, .T., {|x| n_Opc := 2, oDlg:End() }} ) //Cancelar
aAdd( a_Button, { 5, .T., {|x| Pergunte(cPerg,.T.) }} )    //Parametros

FormBatch( c_Titulo, a_Say, a_Button )

If( n_Opc <> 1 )
	Return nil
Else
	Processa({|| RunCont() }," Processando...")
EndIf	
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณRUNCont   บ Autor ณ AP6 IDE            บ Data ณ  23/09/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS บฑฑ
ฑฑบ          ณ monta a janela com a regua de processamento.               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

Static Function RunCont(Cabec1,Cabec2,Titulo,nLin)

Local aStru	:= {}
Local cArqExp	:= CriaTrab(,.F.)
Local cPath		:= AllTrim(GetTempPath())
LOCAL cDirDocs	:= MsDocPath()

aAdd(aStru,{"D2COD",	"C",15,0})
aAdd(aStru,{"B1DESC",	"C",55,0})
aAdd(aStru,{"D2GRUPO",	"C",04,0})
aAdd(aStru,{"BMDESC",	"C",20,0})
aAdd(aStru,{"D2UM",		"C",02,0})
aAdd(aStru,{"ANO",		"C",04,0})
aAdd(aStru,{"JANQTD",	"N",08,3})
aAdd(aStru,{"JANVLR",	"N",10,2})
aAdd(aStru,{"FEVQTD",	"N",08,3})
aAdd(aStru,{"FEVVLR",	"N",10,2})
aAdd(aStru,{"MARQTD",	"N",08,3})
aAdd(aStru,{"MARVLR",	"N",10,2})
aAdd(aStru,{"ABRQTD",	"N",08,3})
aAdd(aStru,{"ABRVLR",	"N",10,2})
aAdd(aStru,{"MAIQTD",	"N",08,3})
aAdd(aStru,{"MAIVLR",	"N",10,2})
aAdd(aStru,{"JUNQTD",	"N",08,3})
aAdd(aStru,{"JUNVLR",	"N",10,2})
aAdd(aStru,{"JULQTD",	"N",08,3})
aAdd(aStru,{"JULVLR",	"N",10,2})
aAdd(aStru,{"AGOQTD",	"N",08,3})
aAdd(aStru,{"AGOVLR",	"N",10,2})
aAdd(aStru,{"SETQTD",	"N",08,3})
aAdd(aStru,{"SETVLR",	"N",10,2})
aAdd(aStru,{"OUTQTD",	"N",08,3})
aAdd(aStru,{"OUTVLR",	"N",10,2})
aAdd(aStru,{"NOVQTD",	"N",08,3})
aAdd(aStru,{"NOVVLR",	"N",10,2})
aAdd(aStru,{"DEZQTD",	"N",08,3})
aAdd(aStru,{"DEZVLR",	"N",10,2})
                          

If Select("TRE") > 0 
   DbselectArea("TRE")
   TRE->(dbCloseArea())
Endif


MsCreate(cDirDocs+"\"+cArqExp,aStru,"TOPCONN")
dbUseArea(.T.,"TOPCONN",cDirDocs+"\"+cArqExp,"TRE",.F.,.F.)




nCount := MontaQry()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ SETREGUA -> Indica quantos registros serao processados para a regua ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
// SetRegua( nCount )// Numero de registros a processar
ProcRegua(nCount)
//
// Processamento dos registro do arquivo principal
//

TRB->(DbGoTop())
While ! TRB->(Eof())

   //ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
   //ณ Verifica o cancelamento pelo usuario...                             ณ
   //ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

   If Lastkey()=27
      Exit
   Endif

   RecLock("TRE", .T.)
		TRE->D2COD	:=	TRB->D2_COD
		TRE->B1DESC	:=	TRB->B1_DESC
		TRE->D2GRUPO:=	TRB->D2_GRUPO
		TRE->BMDESC	:=	TRB->BM_DESC
		TRE->D2UM 	:=	TRB->D2_UM
		TRE->ANO		:=	TRB->ANO
		TRE->JANQTD	:=	TRB->JAN_QTD
		TRE->JANVLR	:=	TRB->JAN_VLR
		TRE->FEVQTD	:=	TRB->FEV_QTD
		TRE->FEVVLR	:=	TRB->FEV_VLR
		TRE->MARQTD	:=	TRB->MAR_QTD
		TRE->MARVLR	:=	TRB->MAR_VLR
		TRE->ABRQTD	:=	TRB->ABR_QTD
		TRE->ABRVLR	:=	TRB->ABR_VLR
		TRE->MAIQTD	:=	TRB->MAI_QTD
		TRE->MAIVLR	:=	TRB->MAI_VLR
		TRE->JUNQTD	:=	TRB->JUN_QTD	
		TRE->JUNVLR	:=	TRB->JUN_VLR
		TRE->JULQTD	:=	TRB->JUL_QTD
		TRE->JULVLR	:=	TRB->JUL_VLR
		TRE->AGOQTD	:=	TRB->AGO_QTD
		TRE->AGOVLR	:=	TRB->AGO_VLR
		TRE->SETQTD	:=	TRB->SET_QTD
		TRE->SETVLR	:=	TRB->SET_VLR
		TRE->OUTQTD	:=	TRB->OUT_QTD
		TRE->OUTVLR	:=	TRB->OUT_VLR
		TRE->NOVQTD	:=	TRB->NOV_QTD
		TRE->NOVVLR	:=	TRB->NOV_VLR
		TRE->DEZQTD	:=	TRB->DEZ_QTD
		TRE->DEZVLR	:=	TRB->DEZ_VLR
	MsUnLock()
   TRB->(dbSkip()) // Avanca o ponteiro do registro no arquivo
EndDo

ExpExcel()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัอออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณ MontaQry บ Autor ณ Ricardo A. Batagellaบ Data ณ  23/09/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯอออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Gera a query com as informacoes necessarias ao relatorio    บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Higietopp                                                   บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function MontaQry()
Local cQuery
Private cEOL    := "CHR(13)+CHR(10)"
cEOL := &cEOL

cQuery := "SELECT  SD2.D2_COD, SB1.B1_DESC, SD2.D2_GRUPO,SBM.BM_DESC, SubString(SD2.D2_EMISSAO,1,4) as ANO, SD2.D2_UM "+cEol
cQuery += "         , [JAN_QTD]  = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=01 then (SD2.D2_QUANT)end),0) "+cEol
cQuery += "         , [JAN_VLR]  = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=01 then (SD2.D2_TOTAL+SD2.D2_VALIPI+SD2.D2_ICMSRET)end),0) "+cEol
cQuery += "         , [FEV_QTD]  = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=02 then (SD2.D2_QUANT)end),0) "+cEol
cQuery += "         , [FEV_VLR]  = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=02 then (SD2.D2_TOTAL+SD2.D2_VALIPI+SD2.D2_ICMSRET)end),0)"+cEol
cQuery += "         , [MAR_QTD]  = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=03 then (SD2.D2_QUANT)end),0) "+cEol
cQuery += "         , [MAR_VLR]  = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=03 then (SD2.D2_TOTAL+SD2.D2_VALIPI+SD2.D2_ICMSRET)end),0) "+cEol
cQuery += "         , [ABR_QTD]  = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=04 then (SD2.D2_QUANT)end),0) "+cEol
cQuery += "         , [ABR_VLR]  = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=04 then (SD2.D2_TOTAL+SD2.D2_VALIPI+SD2.D2_ICMSRET)end),0) "+cEol
cQuery += "         , [MAI_QTD]  = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=05 then (SD2.D2_QUANT)end),0) "+cEol
cQuery += "         , [MAI_VLR]  = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=05 then (SD2.D2_TOTAL+SD2.D2_VALIPI+SD2.D2_ICMSRET)end),0) "+cEol
cQuery += "         , [JUN_QTD]  = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=06 then (SD2.D2_QUANT)end),0) "+cEol
cQuery += "         , [JUN_VLR]  = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=06 then (SD2.D2_TOTAL+SD2.D2_VALIPI+SD2.D2_ICMSRET)end),0) "+cEol
cQuery += "         , [JUL_QTD]  = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=07 then (SD2.D2_QUANT)end),0) "+cEol
cQuery += "         , [JUL_VLR]  = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=07 then (SD2.D2_TOTAL+SD2.D2_VALIPI+SD2.D2_ICMSRET)end),0) "+cEol
cQuery += "         , [AGO_QTD]  = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=08 then (SD2.D2_QUANT)end),0) "+cEol
cQuery += "         , [AGO_VLR]  = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=08 then (SD2.D2_TOTAL+SD2.D2_VALIPI+SD2.D2_ICMSRET)end),0) "+cEol
cQuery += "         , [SET_QTD]  = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=09 then (SD2.D2_QUANT)end),0) "+cEol
cQuery += "         , [SET_VLR]  = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=09 then (SD2.D2_TOTAL+SD2.D2_VALIPI+SD2.D2_ICMSRET)end),0) "+cEol
cQuery += "         , [OUT_QTD]  = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=10 then (SD2.D2_QUANT)end),0) "+cEol
cQuery += "         , [OUT_VLR]  = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=10 then (SD2.D2_TOTAL+SD2.D2_VALIPI+SD2.D2_ICMSRET)end),0) "+cEol
cQuery += "         , [NOV_QTD]  = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=11 then (SD2.D2_QUANT)end),0) "+cEol
cQuery += "         , [NOV_VLR]  = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=11 then (SD2.D2_TOTAL+SD2.D2_VALIPI+SD2.D2_ICMSRET)end),0) "+cEol
cQuery += "         , [DEZ_QTD]  = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=12 then (SD2.D2_QUANT)end),0) "+cEol
cQuery += "         , [DEZ_VLR]  = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=12 then (SD2.D2_TOTAL+SD2.D2_VALIPI+SD2.D2_ICMSRET)end),0) "+cEol
cQuery += "FROM "+RetSqlName("SD2")+" AS SD2 "+cEol
cQuery += "JOIN "+RetSqlName("SA1")+" AS SA1 "+cEol 
cQuery += "ON  SD2.D2_CLIENTE = SA1.A1_COD "+cEol
cQuery += "AND SD2.D2_LOJA	 = SA1.A1_LOJA "+cEol
cQuery += "JOIN "+RetSqlName("SF4")+" AS SF4 "+cEol
cQuery += "ON SD2.D2_FILIAL = SF4.F4_FILIAL "+cEol
cQuery += "AND SD2.D2_TES = SF4.F4_CODIGO "+cEol
cQuery += "JOIN "+RetSqlName("SBM")+" AS SBM "+cEol
cQuery += "ON SD2.D2_GRUPO = SBM.BM_GRUPO "+cEol
cQuery += "JOIN "+RetSqlName("SB1")+" AS SB1 "+cEol
cQuery += "ON SD2.D2_COD = SB1.B1_COD "+cEol
cQuery += "WHERE SF4.F4_DUPLIC = 'S' "+cEol
cQuery += "AND SF4.F4_FILIAL = '01' "+cEol
cQuery += "AND SD2.D2_EMISSAO >= '"+DtoS(mv_par01)+"' "+cEol
cQuery += "AND SD2.D2_EMISSAO <= '"+DtoS(mv_par02)+"' "+cEol
cQuery += "AND SD2.D2_FILIAL = '01' "+cEol
cQuery += "AND SD2.D2_CLIENTE >= '"+mv_par03+"' "+cEol
cQuery += "AND SD2.D2_CLIENTE <= '"+mv_par04+"' "+cEol
cQuery += "AND SD2.D2_SERIE = 'NEG' "+cEol
cQuery += "AND SA1.A1_VEND >= '"+mv_par05+"' "+cEol
cQuery += "AND SA1.A1_VEND <= '"+mv_par06+"' "+cEol
cQuery += "AND SA1.A1_EST >= '"+mv_par07+"' "+cEol
cQuery += "AND SA1.A1_EST <= '"+mv_par08+"' "+cEol
cQuery += "AND (SD2.D2_TIPO = 'N' OR SD2.D2_TIPO = 'C') "+cEol
cQuery += "AND SA1.D_E_L_E_T_ <> '*' "+cEol
cQuery += "AND SD2.D_E_L_E_T_ <> '*' "+cEol
cQuery += "AND SF4.D_E_L_E_T_ <> '*' "+cEol
cQuery += "AND SB1.D_E_L_E_T_ <> '*' "+cEol
cQuery += "AND SBM.D_E_L_E_T_ <> '*' "+cEol
cQuery += "GROUP BY SD2.D2_COD, SB1.B1_DESC, SD2.D2_GRUPO, SBM.BM_DESC, SubString(SD2.D2_EMISSAO,1,4), D2_UM "+cEol
cQuery += "ORDER BY SD2.D2_GRUPO, SD2.D2_COD "+cEol

memowrite('c:\teste\RESTD003.SQL', cQuery)
cQuery := ChangeQuery(cQuery)

If Select("TRB") > 0 
   DbselectArea("TRB")
   TRB->(dbCloseArea())
Endif

TCQUERY cQuery Alias TRB New
// TCSetField("TRB","D2_EMISSAO" ,"D")

DbSelectArea("TRB")
TRB->(DbGoTop())
nCount  := 0
DbeVal({||nCount++})

Return nCount

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัอออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณ CriaSx1  บ Autor ณ Ricardo A. Batagellaบ Data ณ  23/09/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯอออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Cria็ใo do arquivo de Perguntas                             บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Higietopp                                                   บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Variaveis utilizadas para parametros                         ณ
//ณ mv_par01              Da Data ?                              ณ
//ณ mv_par02              Ate a Data                             ณ
//ณ mv_par03              Cliente De ?                           ณ
//ณ mv_par04              Cliente Ate ?                          ณ
//ณ mv_par05              Vendedor De ?                          ณ
//ณ mv_par06              Vendedor Ate ?                         ณ
//ณ mv_par07              Estado (UF) de ?                       ณ
//ณ mv_par08              Estado (UF) ate ?                      ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู


Static Function CriaSx1(cPerg)
Local aHelpPor
Local aHelpEsp
Local aHelpIng
Local cStringP   := ""  // texto em portugues
Local cStringE   := ""	// texto em espanhol
Local cStringI   := ""  // texto em ingles

// MV_PAR01 --------------------------------------------------------------------------------------
aHelpPor :={}           
aHelpIng :={} 
aHelpEsp :={}                                           
               //         1         2         3         4
               //1234567890123456789012345678901234567890
Aadd( aHelpPor, "Informe a data inicial das vendas       ")
aHelpIng := aClone(aHelpPor)
aHelpEsp := aClone(aHelpPor)

cStringP := "Da Data de faturamento ?"
cStringE := cStringP
cStringI := cStringP

PutSx1(cPerg,"01",cStringP,cStringE,cStringI,;
		"mv_ch1","D",8,	0,;
		0,"G",;
		"naovazio","","",;
		"","mv_par01",;
		""	,""	,"","",;
		""	,"","",;
		""	,""	,"",;
		""	,"","",;
		"","","",;
		aHelpPor,aHelpIng,aHelpEsp)

// MV_PAR02 --------------------------------------------------------------------------------------
aHelpPor :={}           
aHelpIng :={} 
aHelpEsp :={}                                           
               //         1         2         3         4
               //1234567890123456789012345678901234567890
Aadd( aHelpPor, "Informe a data final das vendas       ")
aHelpIng := aClone(aHelpPor)
aHelpEsp := aClone(aHelpPor)

cStringP := "Ate a Data de faturamento ?"
cStringE := cStringP
cStringI := cStringP

PutSx1(cPerg,"02",cStringP,cStringE,cStringI,;
		"mv_ch2","D",8,	0,;
		0,"G",;
		"naovazio","","",;
		"","mv_par02",;
		""	,""	,"","",;
		""	,"","",;
		""	,""	,"",;
		""	,"","",;
		"","","",;
		aHelpPor,aHelpIng,aHelpEsp)

// MV_PAR03 --------------------------------------------------------------------------------------
aHelpPor :={}           
aHelpIng :={} 
aHelpEsp :={}                                           
               //         1         2         3         4
               //1234567890123456789012345678901234567890
Aadd( aHelpPor, "Informe o cliente inicial               ")
aHelpIng := aClone(aHelpPor)
aHelpEsp := aClone(aHelpPor)

cStringP := "Do Cliente ?"
cStringE := cStringP
cStringI := cStringP

PutSx1(cPerg,"03",cStringP,cStringE,cStringI,;
		"mv_ch3","C",6,	0,;
		0,"G",;
		"","","",;
		"","mv_par03",;
		""	,""	,"","",;
		""	,"","",;
		""	,""	,"",;
		""	,"","",;
		"","","",;
		aHelpPor,aHelpIng,aHelpEsp)

// MV_PAR04 --------------------------------------------------------------------------------------
aHelpPor :={}           
aHelpIng :={} 
aHelpEsp :={}                                           
               //         1         2         3         4
               //1234567890123456789012345678901234567890
Aadd( aHelpPor, "Informe o cliente final               ")
aHelpIng := aClone(aHelpPor)
aHelpEsp := aClone(aHelpPor)

cStringP := "Ate o cliente ?"
cStringE := cStringP
cStringI := cStringP

PutSx1(cPerg,"04",cStringP,cStringE,cStringI,;
		"mv_ch4","C",6,	0,;
		0,"G",;
		"naovazio","","",;
		"","mv_par04",;
		""	,""	,"","",;
		""	,"","",;
		""	,""	,"",;
		""	,"","",;
		"","","",;
		aHelpPor,aHelpIng,aHelpEsp)

          
// MV_PAR05 --------------------------------------------------------------------------------------
aHelpPor :={}           
aHelpIng :={} 
aHelpEsp :={}                                           
               //         1         2         3         4
               //1234567890123456789012345678901234567890
Aadd( aHelpPor, "Informe o vendedor inicial              ")
aHelpIng := aClone(aHelpPor)
aHelpEsp := aClone(aHelpPor)

cStringP := "Do vendedor ?"
cStringE := cStringP
cStringI := cStringP

PutSx1(cPerg,"05",cStringP,cStringE,cStringI,;
		"mv_ch5","C",6,	0,;
		0,"G",;
		"","SA3","",;
		"","mv_par05",;
		""	,""	,"","",;
		""	,"","",;
		""	,""	,"",;
		""	,"","",;
		"","","",;
		aHelpPor,aHelpIng,aHelpEsp)

// MV_PAR06 --------------------------------------------------------------------------------------
aHelpPor :={}           
aHelpIng :={} 
aHelpEsp :={}                                           
               //         1         2         3         4
               //1234567890123456789012345678901234567890
Aadd( aHelpPor, "Informe o vendedor final              ")
aHelpIng := aClone(aHelpPor)
aHelpEsp := aClone(aHelpPor)

cStringP := "Ate o vendedor ?"
cStringE := cStringP
cStringI := cStringP

PutSx1(cPerg,"06",cStringP,cStringE,cStringI,;
		"mv_ch6","C",6,	0,;
		0,"G",;
		"naovazio","SA3","",;
		"","mv_par06",;
		""	,""	,"","",;
		""	,"","",;
		""	,""	,"",;
		""	,"","",;
		"","","",;
		aHelpPor,aHelpIng,aHelpEsp)

// MV_PAR07 --------------------------------------------------------------------------------------
aHelpPor :={}           
aHelpIng :={} 
aHelpEsp :={}                                           
               //         1         2         3         4
               //1234567890123456789012345678901234567890
Aadd( aHelpPor, "Informe o Estado (UF) inicial           ")
aHelpIng := aClone(aHelpPor)
aHelpEsp := aClone(aHelpPor)

cStringP := "Da UF ?"
cStringE := cStringP
cStringI := cStringP

PutSx1(cPerg,"07",cStringP,cStringE,cStringI,;
		"mv_ch7","C",2,	0,;
		0,"G",;
		"","12","",;
		"","mv_par07",;
		""	,""	,"","",;
		""	,"","",;
		""	,""	,"",;
		""	,"","",;
		"","","",;
		aHelpPor,aHelpIng,aHelpEsp)

// MV_PAR08 --------------------------------------------------------------------------------------
aHelpPor :={}           
aHelpIng :={} 
aHelpEsp :={}                                           
               //         1         2         3         4
               //1234567890123456789012345678901234567890
Aadd( aHelpPor, "Informe o Estado (UF) final             ")
aHelpIng := aClone(aHelpPor)
aHelpEsp := aClone(aHelpPor)

cStringP := "Ate a UF ?"
cStringE := cStringP
cStringI := cStringP

PutSx1(cPerg,"08",cStringP,cStringE,cStringI,;
		"mv_ch8","C",2,	0,;
		0,"G",;
		"naovazio","12","",;
		"","mv_par08",;
		""	,""	,"","",;
		""	,"","",;
		""	,""	,"",;
		""	,"","",;
		"","","",;
		aHelpPor,aHelpIng,aHelpEsp)

Return

/*****
 *
 * Rotina de processamento, geratpo do arquivo e abretura do Ms-Excel.
 *
 */
Static Function ExpExcel(cArqExp)
Local oFwMsEx := NIL
Local cArq := ""
Local cDir := GetSrvProfString("Startpath","")
Local cWorkSheet := ""
Local cTable := ""
Local cDirTmp := GetTempPath()
TRE->(DbGoTop())
cTable     := "Planilha de: "+AllTrim(TRE->ANO)
cWorkSheet := AllTrim(TRE->ANO)
oFwMsEx := FWMsExcel():New()
ProcRegua(TRE->(RecCount()))

cTable     := AllTrim(TRE->ANO)
oFwMsEx:AddWorkSheet( cWorkSheet )
oFwMsEx:AddTable( cWorkSheet, cTable )	

oFwMsEx:AddColumn( cWorkSheet, cTable , "Cod Produto",	1,1)
oFwMsEx:AddColumn( cWorkSheet, cTable , "Descricao",		1,1)
oFwMsEx:AddColumn( cWorkSheet, cTable , "Cod Grupo",		1,1)
oFwMsEx:AddColumn( cWorkSheet, cTable , "Desc Grupo",		1,1)
oFwMsEx:AddColumn( cWorkSheet, cTable , "Ano",				1,1)
oFwMsEx:AddColumn( cWorkSheet, cTable , "Unidade",			1,1)

oFwMsEx:AddColumn( cWorkSheet, cTable , "Qtde Jan",  3,2)
oFwMsEx:AddColumn( cWorkSheet, cTable , "Valor Jan", 3,3)

oFwMsEx:AddColumn( cWorkSheet, cTable , "Qtde Fev",  3,2)
oFwMsEx:AddColumn( cWorkSheet, cTable , "Valor Fev", 3,3)

oFwMsEx:AddColumn( cWorkSheet, cTable , "Qtde Mar",  3,2)
oFwMsEx:AddColumn( cWorkSheet, cTable , "Valor Mar", 3,3)

oFwMsEx:AddColumn( cWorkSheet, cTable , "Qtde Abr",  3,2)
oFwMsEx:AddColumn( cWorkSheet, cTable , "Valor Abr", 3,3)

oFwMsEx:AddColumn( cWorkSheet, cTable , "Qtde Mai",  3,2)
oFwMsEx:AddColumn( cWorkSheet, cTable , "Valor Mai", 3,3)

oFwMsEx:AddColumn( cWorkSheet, cTable , "Qtde Jun",  3,2)
oFwMsEx:AddColumn( cWorkSheet, cTable , "Valor Jun", 3,3)

oFwMsEx:AddColumn( cWorkSheet, cTable , "Qtde Jul",  3,2)
oFwMsEx:AddColumn( cWorkSheet, cTable , "Valor Jul", 3,3)

oFwMsEx:AddColumn( cWorkSheet, cTable , "Qtde Ago",  3,2)
oFwMsEx:AddColumn( cWorkSheet, cTable , "Valor Ago", 3,3)

oFwMsEx:AddColumn( cWorkSheet, cTable , "Qtde Set",  3,2)
oFwMsEx:AddColumn( cWorkSheet, cTable , "Valor Set", 3,3)

oFwMsEx:AddColumn( cWorkSheet, cTable , "Qtde Out",  3,2)
oFwMsEx:AddColumn( cWorkSheet, cTable , "Valor Out", 3,3)

oFwMsEx:AddColumn( cWorkSheet, cTable , "Qtde Nov",  3,2)
oFwMsEx:AddColumn( cWorkSheet, cTable , "Valor Nov", 3,3)

oFwMsEx:AddColumn( cWorkSheet, cTable , "Qtde Dez",  3,2)
oFwMsEx:AddColumn( cWorkSheet, cTable , "Valor Dez", 3,3)


While ! TRE->( EOF() ) 
	IncProc()
	oFwMsEx:AddRow( cWorkSheet, cTable, { 	TRE->D2COD,TRE->B1DESC,TRE->D2GRUPO,TRE->BMDESC,TRE->ANO, TRE->D2UM,;
														TRE->JANQTD, TRE->JANVLR, TRE->FEVQTD, TRE->FEVVLR, TRE->MARQTD, TRE->MARVLR, TRE->ABRQTD,;
														TRE->ABRVLR, TRE->MAIQTD,	TRE->MAIVLR, TRE->JUNQTD, TRE->JUNVLR, TRE->JULQTD, TRE->JULVLR,;
														TRE->AGOQTD, TRE->AGOVLR,	TRE->SETQTD, TRE->SETVLR, TRE->OUTQTD, TRE->OUTVLR, TRE->NOVQTD,;
														TRE->NOVVLR, TRE->DEZQTD,	TRE->DEZVLR	})
	TRE->( dbSkip () )
EndDo
oFwMsEx:Activate()
cArq := CriaTrab( NIL, .F. ) + ".xml"
LjMsgRun( "Gerando o arquivo, aguarde...", "Fat por Mes", {|| oFwMsEx:GetXMLFile( cArq ) } )
If __CopyFile( cArq, cDirTmp + cArq )
	oExcelApp := MsExcel():New()
	oExcelApp:WorkBooks:Open( cDirTmp + cArq )
	oExcelApp:SetVisible(.T.)
Else
	MsgInfo( "Arquivo nใo copiado para temporแrio do usuแrio." )
Endif
Return
