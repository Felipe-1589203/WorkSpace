#include "Rwmake.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMTECA002  บAUTOR  ณMARCO AURELIO       บ Data ณ  21/05/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ    
ฑฑบ          ณ Alimenta Base Instalada - Carga Inicial                    บฑฑ   
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Desenvolvido para atender necessidade MULTLOCK             บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function MTECA002()

Local cDesc1  	:= "Esta rotina gera Base Instalada na Multlock"         
Local cDesc2  	:= "conforme parametros informado pelo usuario."                      
Local cDesc3  	:= ""
Private cString := "SD2"
Private cPerg   := "MTECA002"


#IFNDEF TOP
   MsgInfo("Nใo ้ possํvel executar este programa, estแ base de dados nใo ้ TopConnect")
   RETURN
#ENDIF
	
	If msgYesNo("Confirma a Gera็ใo de Base Instalada a partir das Notas de Saida ?")
	   Processa({|lEnd| GeraBase(cString) }, "Gravando os dados, aguarde...")
	EndIf

Return

//+-------------------------------------------------------------------------------
//| funcao que processa os dados
//+-------------------------------------------------------------------------------
Static Function GeraBase(cString)

Local cFilSD2   := xFilial(cString)
Local cQuery    := ""

cQuery := 	"SELECT DISTINCT  "
cQuery +=   "	D2_CLIENTE,D2_LOJA,D2_EMISSAO,D2_COD,D2_TES,D2_DOC,D2_ITEM,D2_QUANT,D2_CLIENTE+D2_LOJA+D2_DOC+D2_ITEM AS NUM_SERIE, D2_PEDIDO, C5_NUM, SD2.R_E_C_N_O_  as D2_RECNO "
cQuery +=   "FROM " + RetSqlName("SD2") + " SD2 , "+ RetSqlName("SF4") + " SF4, " + RetSqlName("SC5") + " SC5 "
cQuery +=   "WHERE  "
cQuery +=   "       SD2.D2_FILIAL+SD2.D2_TES = SF4.F4_FILIAL+SF4.F4_CODIGO " 
cQuery +=   "       AND SF4.F4_XATUTEC = 'S' " 
cQuery +=   "       AND SD2.D2_FILIAL+SD2.D2_PEDIDO = SC5.C5_FILIAL+SC5.C5_NUM " 
cQuery +=   "       AND SD2.D2_XFIELD <> 'S'  " 
cQuery +=   "       AND SC5.C5_XORIGEM IN ('C','V','M','T','I') " 
cQuery +=   "  		AND SD2.D2_FILIAL = '"+xFilial("SD2")+"' "
cQuery +=   "  		AND SD2.D_E_L_E_T_ = '' "
cQuery +=   "  		AND SF4.D_E_L_E_T_ = '' "
cQuery +=   "  		AND SC5.D_E_L_E_T_ = '' "
cQuery +=   "ORDER BY D2_CLIENTE,D2_LOJA,D2_DOC "


//+-------------------------
//| Cria uma view no banco
//+-------------------------
If Select("TRB") > 0
	DbSelectArea("TRB")
	DbCloseArea()
EndIf

dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "TRB", .T., .F. )

dbSelectArea("TRB")
dbGoTop()

                            
ProcRegua(RecCount())
While !Eof()

	_vCodCli := _vLojCli := _vProduto := _vNumSer :=  ""
	_vDtVend := _vDtInst := _vDtGar := ctod("  /  /  ")

	_vCodCli :=	TRB->D2_CLIENTE
	_vLojCli :=	TRB->D2_LOJA
	_vProduto:=	TRB->D2_COD
	_vDescprd:= GetAdvFval("SB1", "B1_DESC",xFilial("SB1")+_vProduto)
	_vNumSer := TRB->(D2_DOC+D2_ITEM)	
	_vDtVend :=	stod(TRB->D2_EMISSAO)
	_vDtInst :=	stod(TRB->D2_EMISSAO)
	_vDtGar  :=	stod(TRB->D2_EMISSAO) + val(GETMV("MV_XGARANT"))
	_vrecno	 := TRB->D2_RECNO

	// Pesquisa Base Instalada no AA3. Se nao existir, grava	
	dbSelectArea("AA3")
	dbsetorder(1)

	if !dbseek(xfilial("AA3")+_vCodCli+_vLojCli+_vProduto+_vNumSer)	
		
		RecLock("AA3", .T.)
			AA3->AA3_CODCLI	:=	_vCodCli
			AA3->AA3_LOJA	:=	_vLojCli
			AA3->AA3_CODPRO	:=	_vProduto
			AA3->AA3_XDESCP	:=  _vDescprd
			AA3->AA3_NUMSER	:=	_vNumSer 
			AA3->AA3_DTVEND	:=	_vDtVend
			AA3->AA3_DTINST	:=	_vDtInst
			AA3->AA3_DTGAR	:=	_vDtGar
		MsUnLock()
	
    endif
   
	dbSelectArea("SD2")
	dbGoto(_vrecno)
	RecLock("SD2",.F.)
	SD2->D2_XFIELD := "S"
	MsUnLock()
	
	dbSelectArea("TRB")
    dbSkip()

	incproc()

EndDo

							
Return

