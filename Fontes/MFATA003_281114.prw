#INCLUDE "TOPCONN.CH"
#include "rwmake.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMFATA003  บAutor  ณMarcelo Pagliotto   บ Data ณ  09/15/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณBrowse para realizar a entrega de materiais na expedicao    บฑฑ
ฑฑบ          ณmostras as notas e pedidos(pm) a serem entregues.           บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณEspecifico MULTLOCK.                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function MFATA003()

Local cQuery  := ""
Local aAreaC5 := SC5->(GetArea())
Private cCusMed			:= GetMv("MV_CUSMED")
Private aRegSD3  		:= {}

cQuery := "SELECT       SC5.C5_NUM, SC6.C6_NUM , SC6.C6_CLI, SC6.C6_LOJA, SD2.D2_DOC, SD2.D2_SERIE, SC9.C9_LOCAL,"
cQuery += "             SC5.C5_TRANSP, SC5.C5_XTTPPED, SC5.C5_XORIGEM, SC5.C5_XFATURA, SC5.R_E_C_N_O_ AS RECSC5  "
cQuery += "FROM         "+RetSqlName("SC5")+" SC5 "
cQuery += "inner join	"+RetSqlName("SC6")+" SC6 "
cQuery += "on			SC6.C6_NUM     = SC5.C5_NUM "
cQuery += "AND			SC6.C6_CLI     = SC5.C5_CLIENTE "
cQuery += "AND			SC6.C6_LOJA    = SC5.C5_LOJACLI "
cQuery += "AND          SC6.D_E_L_E_T_ = ' ' "
cQuery += "inner join	"+RetSqlName("SC9")+" SC9 "
cQuery += "on           SC9.C9_PEDIDO  = SC6.C6_NUM "
cQuery += "AND			SC9.C9_PRODUTO = SC6.C6_PRODUTO "
cQuery += "AND			SC9.C9_CLIENTE = SC6.C6_CLI "
cQuery += "AND			SC9.C9_LOJA    = SC6.C6_LOJA "
cQuery += "AND        (SC9.C9_BLCRED = '  ' OR SC9.C9_BLCRED = '10' OR SC9.C9_BLCRED = 'ZZ') "
cQuery += "AND        (SC9.C9_BLEST  = '  ' OR SC9.C9_BLEST  = '10' OR SC9.C9_BLEST  = 'ZZ') "
cQuery += "AND         SC9.D_E_L_E_T_ = ' ' "
cQuery += "full join	"+RetSqlName("SD2")+" SD2 "
cQuery += "ON			SD2.D2_PEDIDO  = SC6.C6_NUM "
cQuery += "AND			SD2.D2_ITEMPV  = SC6.C6_ITEM "
cQuery += "AND			SD2.D_E_L_E_T_ = ' ' "
cQuery += "WHERE       SC5.C5_XORIGEM = 'A' "
cQuery += "AND         SC5.C5_XFATURA = 'N' "
cQuery += "AND         SC5.C5_XTTPPED = 'S' "
cQuery += "AND         SC5.C5_XSITPM  IN (' ','A','S') "
cQuery += "AND         SC5.D_E_L_E_T_ = ' ' "
//cQuery += "AND         SC5.C5_NUM    >= '000785' "
cQuery += "ORDER BY    SC6.C6_NUM, SD2.D2_DOC DESC "

cQuery := " select     C9_PEDIDO as C5_NUM, C9_CLIENTE as C6_CLI, C9_LOJA as C6_LOJA, C9_NFISCAL as D2_DOC, C9_SERIENF as D2_SERIE, SC9.C9_LOCAL,"
cQuery += "            max(C9_BLCRED) as C9_BLCRED, max(C9_BLEST) as C9_BLEST, C9_XPM, C9_XFATURA, C5_XTTPPED"
cQuery += " from       "+RetSqlName("SC9")+" SC9 "
cQuery += " inner join "+RetSqlName("SC5")+" SC5 "
cQuery += " on         C5_NUM = C9_PEDIDO"
cQuery += " and        C5_XTTPPED = 'S'"
cQuery += " and        SC5.D_E_L_E_T_ <> '*'"
cQuery += " where      SC9.D_E_L_E_T_ <> '*' "
cQuery += " and        C9_BLEST = ' '"
cQuery += " and        C9_BLCRED = ' '"
cQuery += " and        C9_PEDIDO in (select Z2_PEDIDO from "+RetSqlName("SZ2")+" where D_E_L_E_T_ <> '*')"
cQuery += " group by   C9_PEDIDO, C9_CLIENTE, C9_LOJA, C9_NFISCAL, C9_SERIENF, C9_LOCAL, C9_PEDIDO, C9_XPM, C9_XFATURA, C5_XTTPPED"
cQuery += " order by   C9_PEDIDO "
cQuery := ChangeQuery(cQuery)
cAliasA:= GetNextAlias()
nTotReg:= 0

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasA)
aEval(SC5->(dbStruct()),{|x| If(x[2]!="C", TcSetField(cAliasA,AllTrim(x[1]),x[2],x[3],x[4]),Nil)})
aEval(SC6->(dbStruct()),{|x| If(x[2]!="C", TcSetField(cAliasA,AllTrim(x[1]),x[2],x[3],x[4]),Nil)})
aEval(SC9->(dbStruct()),{|x| If(x[2]!="C", TcSetField(cAliasA,AllTrim(x[1]),x[2],x[3],x[4]),Nil)})

While (cAliasA)->(!Eof())
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณAtualiza Status do pedido.                                          ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	SC5->(DbSetOrder(1)) //C5_FILIAL, C5_NUM, R_E_C_N_O_, D_E_L_E_T_
	//	SC5->(DbGoTo( (cAliasA)->RECSC5))
	SC5->(DbSeek( (cAliasA)->C5_NUM))
	If SC5->C5_XTTPPED = 'S' .and. Empty(SC5->C5_XSITPM)
		//	If SC5->C5_XTTPPED = 'S'
		RecLock("SC5", .F.)
		SC5->C5_XSITPM := 'A'
		MsUnLock()
	EndIf
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณVerifica se os itens a faturar estao com as infomacoes atualizadas. ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	DbSelectArea("SC9")
	DbSetOrder(2)//C9_FILIAL, C9_CLIENTE, C9_LOJA, C9_PEDIDO, C9_ITEM, R_E_C_N_O_, D_E_L_E_T_
	If DbSeek(xFilial("SC9")+SC5->C5_CLIENTE+SC5->C5_LOJACLI+SC5->C5_NUM)
		While SC9->C9_FILIAL == xFilial("SC9") .And. SC9->C9_CLIENTE == SC5->C5_CLIENTE .And. SC9->C9_LOJA ==  SC5->C5_LOJACLI .And. SC9->C9_PEDIDO == SC5->C5_NUM .And. SC9->(!Eof())
			RecLock("SC9", .F.)
			SC9->C9_XORIGEM	:= SC5->C5_XORIGEM
			SC9->C9_XFATURA	:= SC5->C5_XFATURA
			//			SC9->C9_XPM		:= SC5->C5_XTTPPED
			SC9->C9_XPM		:= "S"
			MsUnLock()                      
			SC9->(DbSkip())
		End-While                                              
	EndIf
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณCintia Aquino - Caso pedido seja dos armazens cadastros em MV_ARMSZ2, sendo inicial com armazem 15 nao criar tabela SZ2 ณ
	//ณ              - Solicitado por Andre Couto em 04/10/10 chamado 000813                                                                ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	cArmazem := GetMv("MV_ARMSZ2",,"15")
	If !( (cAliasA)->C9_LOCAL $ cArmazem )
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณVerifica se a nota ja foi liberada em credito e estoque.ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		//	If (cAliasA)->C5_XTTPPED = 'S' .or. !Empty((cAliasA)->D2_DOC)
		DbSelectArea("SZ2")
		DbSetOrder(1) //Z2_FILIAL, Z2_PEDIDO, Z2_DOC, Z2_SERIE, R_E_C_N_O_, D_E_L_E_T_
		If !DbSeek(xFilial("SZ2")+(cAliasA)->(C5_NUM+D2_DOC+D2_SERIE))
			RecLock("SZ2", .T.)
			SZ2->Z2_FILIAL	:= xFilial("SZ2")                    
			SZ2->Z2_PEDIDO	:= (cAliasA)->C5_NUM                      
			SZ2->Z2_DOC		:= (cAliasA)->D2_DOC                
			SZ2->Z2_SERIE	:= (cAliasA)->D2_SERIE
			SZ2->Z2_CLIENTE	:= (cAliasA)->C6_CLI
			SZ2->Z2_LOJA	:= (cAliasA)->C6_LOJA
			SZ2->Z2_NOMECLI	:= GetAdvFval("SA1", "A1_NOME", xFilial("SA1")+(cAliasA)->(C6_CLI+C6_LOJA), 1, ' ')
			SZ2->Z2_TRANSP 	:= SC5->C5_TRANSP
			SZ2->Z2_DESCTRA	:= GetAdvFval("SA4", "A4_NOME", xFilial("SA4")+SC5->(C5_TRANSP), 1, ' ')
			SZ2->Z2_STATUS	:= 'P'
			MsUnLock()
		Else                                                            
			RecLock("SZ2", .F.)
			SZ2->Z2_DOC		:= (cAliasA)->D2_DOC
			SZ2->Z2_SERIE	:= (cAliasA)->D2_SERIE                          
			MsUnLock()                                                             
		EndIf
		//	EndIf
	EndIf
	
	(cAliasA)->(DbSkip())
End-While
(cAliasA)->(DbCloseArea())

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณVerifica os pedidos que sofreram alteracao e exclui do browse    ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
cQuery := " select     Z2_DOC, '' as Z2_PEDIDO, R_E_C_N_O_ as RECZ2 "
cQuery += " from       SZ2010 "
cQuery += " where      Z2_DOC <> '' "
cQuery += " and        Z2_DOC not in (select F2_DOC from SF2010 where D_E_L_E_T_ <> '*')"
cQuery += " and        D_E_L_E_T_ <> '*'"
cQuery += " union all"
cQuery += " select     '' as Z2_DOC, Z2_PEDIDO, R_E_C_N_O_ as RECZ2"
cQuery += " from       SZ2010 "
cQuery += " where      Z2_PEDIDO <> '' "
cQuery += " and        Z2_PEDIDO not in (select distinct C9_PEDIDO from SC9010 where D_E_L_E_T_ <> '*')"
cQuery += " and        D_E_L_E_T_ <> '*'"
cQuery += " union all"
cQuery += " select     '' as Z2_DOC, C9_PEDIDO as Z2_PEDIDO, 0 as RECSZ2"
cQuery += " from       SC9010 SC9"
cQuery += " where      C9_XPM = 'S'"
cQuery += " and        C9_XFATURA = 'S'"
cQuery += " and        SC9.D_E_L_E_T_ <> '*' "
cQuery += " and       (C9_BLEST = '02' or C9_BLCRED = '02')"
cQuery += " and        C9_PEDIDO in (select Z2_PEDIDO from SZ2010 where D_E_L_E_T_ <> '*')"
cQuery += " group by C9_PEDIDO, C9_XPM, C9_XFATURA"

cQuery := ChangeQuery(cQuery)
cAliasB:= GetNextAlias()
nTotReg:= 0

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasB)

While (cAliasB)->(!Eof())
	If (cAliasB)->RECZ2 <> 0
		SZ2->(DbGoTo((cAliasB)->RECZ2))
		RecLock("SZ2",.F.)
		DbDelete()
		MsUnlock()
	Else
		SZ2->(DbSetOrder(1)) //Z2_FILIAL, Z2_PEDIDO, Z2_DOC, Z2_SERIE, R_E_C_N_O_, D_E_L_E_T_
		If SZ2->(DbSeek(xFilial("SZ2")+(cAliasB)->Z2_PEDIDO))
			RecLock("SZ2",.F.)
			DbDelete()
			MsUnlock()
		EndIf
	EndIf
	(cAliasB)->(DbSkip())
EndDo

RestArea(aAreaC5)

MFATA03f()

Return()

Static Function MFATA03f()
Private aRotina			:= {}
Private cCadastro		:= "Expedi็ใo PM"
Private l_TERMO			:= .F.
Private l_CANCEL		:= .F.
Private c_EOL			:= chr(13)+chr(10)
Private c_alias1		:= "SZ2"
Private c_alias2		:= "SC6"
Private c_cpoitem		:= "C6_ITEM"     //ITENS DO P.V.
Private c_chave1		:= {"Z2_PEDIDO"}   // CHAVES DO P.V.
Private c_chave2		:= {"C6_NUM"}
Private c_cpofil1		:= ''
Private c_cpofil2		:= ''
Private a_Index         := {}
Private aCores 			:= {}
Private bFiltraBrw

AAdd(aRotina, {"Pesquisar"	    , "AxPesqui"  	, 0, 1})
AAdd(aRotina, {"Visualizar"		, "U_MFATA02a"	, 0, 2})
AAdd(aRotina, {"Legenda"		, "U_MFATA03a"	, 0, 3})
AAdd(aRotina, {"Imprimir"		, "U_MFATA03b"	, 0, 4})
AAdd(aRotina, {"Separar"    	, "U_MFATA03c"	, 0, 5})
AAdd(aRotina, {"Estorno Separar", "U_MFATA03f"	, 0, 5})
AAdd(aRotina, {"Pesagem"		, "U_MFATA03e"	, 0, 6})
AAdd(aRotina, {"Entrega"		, "U_MFATA03d"	, 0, 6})

aCores := {	{"Z2_STATUS== 'P'",'BR_VERDE'   },;	//Pendente
{"Z2_STATUS== 'I'",'BR_AZUL' },;	//Impresso
{"Z2_STATUS== 'S'",'BR_AMARELO' },;	//Separado
{"Z2_STATUS== 'F'",'BR_VERMELHO'}} //Entregue


dbSelectArea(c_alias1)
DbSetOrder (1)

mBrowse( 6, 1,22,75,c_alias1,,,,,,aCores)

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณLegenda   บAutor  ณMarcelo Pagliotto   บ Data ณ  07/28/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  Legenda dos itens do Pedido de Vendas para pedidos        บฑฑ
ฑฑบ          ณ    especiais (Controle de Pedidos de Materiais)            บฑฑ
ฑฑฬออออออออออุ'ออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function MFATA03a() // Legenda()

Local aCores := {}

aAdd(aCores,{"BR_VERDE"		,"Pendente" })
aAdd(aCores,{"BR_AZUL" 		,"Impresso" })
aAdd(aCores,{"BR_AMARELO"	,"Separado" })
aAdd(aCores,{"BR_VERMELHO"	,"Entregue" })
BrwLegenda(cCadastro,"Legenda",aCores)

Return .T.
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMFATA003  บAutor  ณMicrosiga           บ Data ณ  09/15/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณImprime o pick do pedido.                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function MFATA03b()



U_MFATR002(SZ2->Z2_PEDIDO)

If SZ2->Z2_STATUS = 'P'
	RecLock("SZ2", .F.)
	SZ2->Z2_STATUS = 'I'
	MsUnLock()
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMFATA02a  บAutor  ณAlexandre Sousa     บ Data ณ  26/06/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณChamada das funcoes responsaveis.                           บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function MFATA02a(cAlias, nRecno, nOpc)

Manutcon(cAlias, nRecno, nOpc)

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณManutcon  บAutor  ณAlexandre Sousa     บ Data ณ  26/06/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณChamada das rotinas e chamada da Mod 2.                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Manutcon(cAlias, nRecno, nOpc, c_item2alias)

Local cLinOK   := "AllwaysTrue"
Local cTudoOK  := "AllwaysTrue"
Local nOpcE    := nOpc
Local nOpcG    := nOpc
Local cFieldOK := "AllwaysTrue"
Local lVirtual := .T.
Local nLinhas  := 99
Local nFreeze  := 0
Local lRet     := .T.
Local oCt_Item := "+"+c_cpoitem
Local aButtons :={}

Private aAlter  		:= {}
Private aCols			:= {}
Private aHeader			:= {}
Private aCpoEnchoice	:= {}
Private aAltEnchoice	:= {}
Private aAlt			:= {}
Private c_Alterados		:= ''



RegToMemory(c_alias1, (nOpc==3))
RegToMemory(c_alias2, (nOpc==3))

If nOpc == 3
	l_INCLUI := .T.
	M->&(c_chave1[1]) := U_FGEN003(c_alias1, c_chave1[1])
ElseIf nOpc == 4
	l_ALTERA := .T.
ElseIf nOpc == 5
	l_EXCLUI := .T.
EndIf

CriaHeader()
CriaCols(nOpc,oCt_Item)

lRet := FGEN004(cCadastro,c_alias1,c_alias2,aCpoEnchoice,cLinOk,cTudoOk,nOpcE,nOpcG,cFieldOk,lVirtual,nLinhas,aAltEnchoice,nFreeze,aAlter,oCt_Item, aButtons)

l_INCLUI	:= .F.
l_EXCLUI	:= .F.
l_ALTERA	:= .F.

Return lRet
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCriaHeaderบAutor  ณAlexandre Sousa     บ Data ณ  26/06/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCarrega array para Mod2                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CriaHeader()

aHeader      := {}
aCpoEnchoice := {}
aAltEnchoice := {}

dbSelectArea("SX3")
dbSetOrder(1)
dbSeek(c_alias2)

c_cpofil2 := SX3->X3_Campo

While !SX3->(EOF()) .And. SX3->X3_Arquivo == c_alias2
	
	If X3Uso(SX3->X3_Usado)    .And.;
		cNivel >= SX3->X3_Nivel
		
		AAdd(aHeader, {Trim(SX3->X3_Titulo),;
		SX3->X3_Campo       ,;
		SX3->X3_Picture     ,;
		SX3->X3_Tamanho     ,;
		SX3->X3_Decimal     ,;
		SX3->X3_Valid       ,;
		SX3->X3_Usado       ,;
		SX3->X3_Tipo        ,;
		SX3->X3_Arquivo     ,;
		SX3->X3_Context})
		Aadd(aAlter, SX3->X3_Campo)
	EndIf
	SX3->(dbSkip())
	
End

dbSelectArea("SX3")
dbSetOrder(1)
dbSeek(c_alias1)

c_cpofil1 := SX3->X3_Campo

While !SX3->(EOF()) .And. SX3->X3_Arquivo == c_alias1
	If X3Uso(SX3->X3_Usado) .And. cNivel >= SX3->X3_Nivel
		// Campos da Enchoice.
		AAdd(aCpoEnchoice, X3_Campo)
		// Campos da Enchoice que podem ser editadas.
		// Se tiver algum campo que nao deve ser editado, nao incluir aqui.
		AAdd(aAltEnchoice, X3_Campo)
	EndIf
	SX3->(dbSkip())
End

Return Nil
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAGCS701   บAutor  ณAlexandre Sousa     บ Data ณ  26/06/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCria um array para o Modelo2.                               บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CriaCols(nOpc,oTpItem)

Local nQtdCpo := 0
Local i       := 0
Local nCols   := 0
Local cCpoItem:= Alltrim(Substr(oTpItem,2,10))
Local cItem   := ''

Local c_chv1 := ''
Local c_chv2 := ''

aeval(c_chave1, {|x| c_chv1+=AllTrim(x)+"+"})
aeval(c_chave2, {|x| c_chv2+=AllTrim(x)+"+"})

c_chv1 := SubStr(c_chv1, 1, len(c_chv1)-1)
c_chv2 := SubStr(c_chv2, 1, len(c_chv2)-1)

nQtdCpo := Len(aHeader)
aCols   := {}
aAlt    := {}

If nOpc == 3       // Inclusao.
	
	AAdd(aCols, Array(nQtdCpo+1))
	
	For i := 1 To nQtdCpo
		aCols[1][i] := CriaVar(aHeader[i][2])
	Next
	aCols[1][nQtdCpo+1] := .F.
Else
	
	dbSelectArea(c_alias2)
	DbSetOrder(1)
	dbSeek(xFilial(c_alias2) + (c_alias1)->&(c_chv1))
	
	While !EOF() .And. (c_alias1)->&(c_cpofil1) == xFilial(c_alias2) .And. (c_alias2)->&(c_chv2) == (c_alias1)->&(c_chv1)
		
		AAdd(aCols, Array(nQtdCpo+1))
		nCols++
		
		For i := 1 To nQtdCpo
			If aHeader[i][10] <> "V"
				aCols[nCols][i] := FieldGet(FieldPos(aHeader[i][2]))
			Else
				aCols[nCols][i] := CriaVar(aHeader[i][2], .T.)
			EndIf
		Next
		
		aCols[nCols][nQtdCpo+1] := .F.
		
		AAdd(aAlt, Recno())
		
		dbSelectArea(c_alias2)
		dbSkip()
		
	End
	
EndIf

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFGEN004   บAutor  ณAlexandre Martins   บ Data ณ  03/24/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao Generica Modelo3, com inclusao de mais parametros.   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณEspecifico OmniLink.                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FGEN004(cTitulo,cAlias1       ,cAlias2   ,aMyEncho    ,cLinOk,cTudoOk,nOpcE,nOpcG,cFieldOk,lVirtual,nLinhas,aAltEnchoice,nFreeze,aAlter,c_item, aButtons)

Local aPosObj    	:= {}
Local aObjects   	:= {}
Local aSize      	:= MsAdvSize()
Local lRet, nOpca 	:= 0,cSaveMenuh,nReg:=(cAlias1)->(Recno())
local oDlg

Private Altera:=.t.,Inclui:=.t.,lRefresh:=.t.,aTELA:=Array(0,0),aGets:=Array(0),;
bCampo:={|nCPO|Field(nCPO)},nPosAnt:=9999,nColAnt:=9999
Private cSavScrVT,cSavScrVP,cSavScrHT,cSavScrHP,CurLen,nPosAtu:=0

c_item := If(c_item==Nil,"", c_item)
nOpcE := If(nOpcE==Nil,3,nOpcE)
nOpcG := If(nOpcG==Nil,3,nOpcG)
lVirtual := Iif(lVirtual==Nil,.F.,lVirtual)
nLinhas:=Iif(nLinhas==Nil,99,nLinhas)

oDlg := TDialog():New(aSize[7],00,aSize[6]+aSize[7],aSize[5],OemToAnsi(cTitulo),,,,,,,,oMainWnd,.T.)

aObjects := {}
AAdd( aObjects, { 100, 060, .T., .F. } )
AAdd( aObjects, { 100, 100, .T., .T. } )

aInfo := { aSize[ 1 ], aSize[ 2 ], aSize[ 3 ], aSize[ 4 ], 3, 3 }
aPosObj := MsObjSize( aInfo, aObjects )

EnChoice(cAlias1,nReg,nOpcE,,,,aMyEncho,{aPosObj[1,1],aPosObj[1,2],aPosObj[1,3],aPosObj[1,4]},aAltEnchoice,3,,,,,,lVirtual)
oGetDados := MsGetDados():New(aPosObj[2,1],aPosObj[2,2],aPosObj[2,3],aPosObj[2,4],nOpcG,cLinOk,cTudoOk,"+"+c_item,.T.,aAlter,,,nLinhas,cFieldOk)

If !Empty(c_item) .and. nOpcE == 3
	a_Area := SX3->(GetArea())
	DbSelectArea("SX3")
	DbSetOrder(2)
	DbSeek(SubStr(c_item,2,10))
	aCols[01,01] := Replicate("0", SX3->X3_TAMANHO-1)+"1"
	RestArea(a_Area)
EndIf

ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,{||nOpca:=1,If(oGetDados:TudoOk(),If(!obrigatorio(aGets,aTela),nOpca := 0,oDlg:End()),nOpca := 0)},{||oDlg:End()},,aButtons)

//    If nOpca==1
//	    MsgAlert("aki ้ a baixa de estoque")
//    endif

lRet:=(nOpca==1)

Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMFATA003  บAutor  ณAlexandre Sousa     บ Data ณ  09/24/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณConfirma a separacao do material.                           บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function MFATA03c(cAlias, nRecno, nOpc)

If SZ2->Z2_STATUS <> 'I'
	msgAlert("Nใo ้ possํvel realizar essa opera็ใo nesse momento!", "A T E N ว ร O")
	Return
EndIf

If Manutcon(cAlias, nRecno, nOpc)
	If msgYesNo("Confirma a separa็ใo do material", "A T E N ว ร O")
		RecLock("SZ2", .F.)
		SZ2->Z2_STATUS := 'S'
		MsUnLock()
		Entrega()
	EndIf
EndIf

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMFATA003  บAutor  ณAlexandre Sousa     บ Data ณ  09/24/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณEstorno da separacao do material.                           บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function MFATA03f(cAlias, nRecno, nOpc)

If !(SZ2->Z2_STATUS $ 'S/I')
	msgAlert("Nใo ้ possํvel realizar essa opera็ใo nesse momento!", "A T E N ว ร O")
	Return
EndIf

If Manutcon(cAlias, nRecno, nOpc)
	If msgYesNo("Confirma o estorno da separa็ใo/impressใo do material", "A T E N ว ร O")
		RecLock("SZ2", .F.)
		SZ2->Z2_STATUS := 'P'
		MsUnLock()
		Entrega()
	EndIf
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMFATA03d  บAutor  ณAlexandre Sousa     บ Data ณ  09/25/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFaz a entrega do produto ao cliente.                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function MFATA03d()

If SZ2->Z2_STATUS <> 'S'
	msgAlert("Esse pedido nใo pode ser entregue nesse momento!", "A T E N ว ร O")
	Return
EndIf

Entrega(1)

Return


Static Function Entrega(n_fecha)

Local   _aAlias        		:= Alias()
Private _nFiscal         	:= SF2->F2_DOC
Private _cTransportadora 	:= SF2->F2_TRANSP
Private _cData           	:= SF2->F2_EMISSAO //F2_XDTEXP
Private _xTamdt          	:= PesqPict("SF2","F2_EMISSAO",8)
Private nPesoBruto			:= SF2->F2_PBRUTO
Private nPesoLiq			:= SF2->F2_PLIQUI
Private cVolume				:= SF2->F2_VOLUME1
Private cCombo 				:= SF2->F2_ESPECI1 //"Pallet" // Caixa

l_fecha := Iif(n_fecha = nil, .F., n_fecha = 1)

DbSelectArea("SF2")
DbSetOrder(1) //F2_FILIAL, F2_DOC, F2_SERIE, F2_CLIENTE, F2_LOJA, F2_FORMUL, R_E_C_N_O_, D_E_L_E_T_
If DbSeek(xFilial("SF2")+SZ2->(Z2_DOC+Z2_SERIE))
	_nFiscal         	:= SF2->F2_DOC
	_cTransportadora 	:= SF2->F2_TRANSP
	_cData           	:= SF2->F2_EMISSAO //F2_XDTEXP
	_xTamdt          	:= PesqPict("SF2","F2_EMISSAO",8)
	nPesoBruto			:= SF2->F2_PBRUTO
	nPesoLiq			:= SF2->F2_PLIQUI
	cVolume				:= SF2->F2_VOLUME1
	cCombo 				:= SF2->F2_ESPECI1 //"Pallet" // Caixa
Else
	DbSelectArea("SC5")
	DbSetOrder(1)
	DbSeek(xFilial("SC5")+SZ2->Z2_PEDIDO)
	
	_nFiscal         	:= 'Ped.Especial' //SF2->F2_DOC
	_cTransportadora 	:= SC5->C5_TRANSP
	_cData           	:= SC5->C5_EMISSAO //F2_XDTEXP
	_xTamdt          	:= PesqPict("SC5","C5_EMISSAO",8)
	nPesoBruto			:= SC5->C5_PBRUTO
	nPesoLiq			:= SC5->C5_PESOL
	cVolume				:= SC5->C5_VOLUME1
	cCombo 				:= SC5->C5_ESPECI1 //"Pallet" // Caixa        
EndIf

Private aCombo				:= {"Caixa","Pallet", "Pacote","Volume"}

DbSelectarea("SF2")
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Criacao da Interface                                                ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
@ 156,367 To 488,884 Dialog mkwdlg Title OemToAnsi("Expedi็ใo de Nota Fiscal")
@ 13,13  Say OemToAnsi("Nota Fiscal...:") Size 44,12
@ 34,13  Say OemToAnsi("Transportadora:") Size 45,13
@ 55,13  Say OemToAnsi("Peso Bruto....:") Size 42,13
@ 76,13  Say OemToAnsi("Peso Liquido..:") Size 41,13
@ 96,13  Say OemToAnsi("Volume........:") Size 44,14
@ 118,13 Say OemToAnsi("Especie.......:") Size 41,14
@ 15,63 say _nFiscal Size 76,10
@ 35,63 Get _cTransportadora pict "@!" F3 "SA4" Size 76,10
@ 54,63 Get nPesoBruto Picture "99999.99" Size 76,10
@ 76,63 Get nPesoLiq  Picture "99999.99" Size 76,10
@ 98,63 Get cVolume Picture "999999" Size 76,10
@ 120,63 ComboBox cCombo Items aCombo Size 76,21
If l_fecha
	@ 144,9 Button OemToAnsi("_Entregar") Size 36,16 Action AEXP003(n_fecha)
Else
	@ 144,9 Button OemToAnsi("_Salvar") Size 36,16 Action AEXP003(n_fecha)
EndIf
@ 144,55 Button OemToAnsi("_Cancelar") Size 36,16 Action CLOSE(mkwdlg)
Activate Dialog mkwdlg CENTERED

DbSelectArea(_aAlias)

Return()
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAEXP003   บAutor  ณAlexandre Sousa     บ Data ณ  09/25/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFaz a gravacao na tabela correspondente.                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AEXP003(n_fecha)

Local _Alias          := Alias()

l_fecha := Iif(n_fecha = nil, .F., n_fecha == 1)

DbSelectArea("SF2")
DbSetOrder(1) //F2_FILIAL, F2_DOC, F2_SERIE, F2_CLIENTE, F2_LOJA, F2_FORMUL, R_E_C_N_O_, D_E_L_E_T_
If DbSeek(xFilial("SF2")+SZ2->(Z2_DOC+Z2_SERIE))
	RecLock("SF2",.F.)
	SF2->F2_TRANSP 		:= 	_cTransportadora
	SF2->F2_PBRUTO		:=	nPesoBruto
	SF2->F2_PLIQUI		:=	nPesoLiq
	SF2->F2_VOLUME1		:=	cVolume
	SF2->F2_ESPECI1		:=	cCombo
	MSUNLOCK()
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณVerifica o caso em que o pedido saiu com a TES 901                         ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If l_fecha
		AjustaNF()
	EndIf
	
Else
	DbSelectArea("SC5")
	DbSetOrder(1)
	DbSeek(xFilial("SC5")+SZ2->Z2_PEDIDO)
	
	RecLock("SC5",.F.)
	SC5->C5_TRANSP		:= 	_cTransportadora
	SC5->C5_PBRUTO		:=	nPesoBruto
	SC5->C5_PESOL		:=	nPesoLiq
	SC5->C5_VOLUME1		:=	cVolume
	SC5->C5_ESPECI1		:=	cCombo
	MSUNLOCK()
	If l_fecha
		RecLock("SC5",.F.)
		If SC5->C5_XTTPPED = 'S'
			
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณAcerta o SC5 para fechar o pedido de vendas                                ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			If Empty(SC5->C5_NOTA)
				SC5->C5_NOTA   := "999999999"    //FECHA PV
				SC5->C5_SERIE  := "999"          //FECHA PV
				SC5->C5_LIBEROK:= 'S'
			EndIf
			SC5->C5_XSITPM := "E"            //ENCERRA PM
			SC5->C5_XENTRPM:= dDataBase
			MSUNLOCK()
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณAcerta o SC6 para fechar o pedido de vendas                                ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			SC6->(DbSetOrder(1)) //C6_FILIAL, C6_NUM, C6_ITEM, C6_PRODUTO, R_E_C_N_O_, D_E_L_E_T_
			If SC6->(DbSeek(xFilial("SC6")+SC5->C5_NUM))
				While SC6->(!EOF()) .and. SC6->C6_NUM == SC5->C5_NUM
					RecLock("SC6", .F.)
					SC6->C6_QTDENT	:= SC6->C6_QTDVEN
					SC6->C6_NOTA	:= '999999999'
					SC6->C6_SERIE	:= '999'
					SC6->C6_BLQ		:= 'R'
					SC6->C6_DATFAT	:= dDataBase
					MsUnLock()
					SC6->(DbSkip())
				EndDo
			EndIf
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณAcerta o SC9 para fechar o pedido de vendas                                ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			SC9->(DbSetOrder(1)) //C9_FILIAL, C9_PEDIDO, C9_ITEM, C9_SEQUEN, C9_PRODUTO, R_E_C_N_O_, D_E_L_E_T_
			If SC9->(DbSeek(xFilial("SC9")+SC5->C5_NUM))
				While SC9->(!EOF()) .and. SC9->C9_PEDIDO == SC5->C5_NUM
					RecLock("SC9", .F.)
					SC9->C9_NFISCAL	:= '999999999'
					SC9->C9_SERIENF	:= '999'
					SC9->C9_BLEST	:= '10'
					SC9->C9_BLCRED	:= '10'
					MsUnLock()
					SC9->(DbSkip())
				EndDo
			EndIf
		EndIf
	EndIf
	
	If l_fecha
		ImpRec()
	EndIf
	
EndIf

If l_fecha
	DbSelectArea("SZ2")
	RecLock("SZ2", .F.)
	SZ2->Z2_STATUS := 'F'
	MsUnLock()
EndIf

DbSelectArea(_Alias)
CLOSE(mkwdlg)

Return()
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAjustaNF  บAutor  ณAlexandre Sousa     บ Data ณ  09/25/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณVerifica e ajusta o caso da nota 901.                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AjustaNF()

Local l_Ret := .T.

DbSelectArea("SD2")
DbSetOrder(3) //D2_FILIAL, D2_DOC, D2_SERIE, D2_CLIENTE, D2_LOJA, D2_COD, D2_ITEM, R_E_C_N_O_, D_E_L_E_T_
If DbSeek(xFilial("SD2")+SF2->F2_DOC)
	While SD2->(!EOF()) .and. SD2->D2_DOC == SF2->F2_DOC
		If SD2->D2_TES = '901'
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณBaixa o estoque na quantida acertada                  ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			_vEstoque	:=	0
			dbSelectArea("SB2")
			DbSetOrder(1) //B2_FILIAL, B2_COD, B2_LOCAL, R_E_C_N_O_, D_E_L_E_T_
			if dbseek(xfilial("SB2")+SD2->D2_COD+'01')
				_vEstoque	:=	B2_QATU-(B2_RESERVA+B2_QEMP)
			else
				_vEstoque	:=	0
			endif
			
			If _vEstoque < SD2->D2_QUANT
				l_Ret := .F.
				Exit
			EndIf
			
			RecLock("SB2", .F.)
			SB2->B2_QATU -= SD2->D2_QUANT
			MsUnLock()
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณAltera a TES da nota para possivel reprocessamento.   ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			RecLock("SD2", .F.)
			SD2->D2_TES := '501'
			MsUnLock()
		EndIf
		SD2->(DbSkip())
	EndDo
EndIf

Return l_Ret


User Function MFATA03e()

Entrega()

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ ImpRec   บAutor  ณMarcelo Pagliotto   บ Data ณ  08/04/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  Baixa estoque dos PV para controle de PM atraves do       บฑฑ
ฑฑบ          ณ     botao "encerra PM"                                     บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Especifico MultLock                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ImpRec()

Local aRotAuto		:= {}
Local c_Query		:= ''
Local _proce		:= 0
Local _MostSn		:= .T.
Local nOpc			:= 3
Local cNumDoc		:= ""
Local cNumpv		:= ""
Local c_CC			:= SuperGetMV("MV_XCCPM") //Centro de  to
Local c_locdest		:= SuperGetMV("MV_XARMTR") //'77'
Local cCodD			:= ''
Local c_Baixa		:= ''
Local l_erro		:= .F.

Private c_locdest	:= '77'
Private lMsErroAuto:= .F.

cNumpv  := SC5->C5_NUM
cNumseq	:= ProxNum()
cNumDoc := NextNumero("SD3",2,"D3_DOC",.T.)//BUSCA NUMERACAO DO SD3 //"CPM" + cNumpv //Numero do Documento no Internos

c_Query := " select      C6_FILIAL, C6_ITEM, C6_PRODUTO, C6_QTDVEN, C6_DTVALID, C6_LOCAL, C6_LOCALIZ, C6_NUM, C6_NUMSERI, C6_POTENCI, C6_LOTECTL"
c_Query += " from        "+RetSqlName("SC6")+" SC6 "
c_Query += " Where       SC6.D_E_L_E_T_ <> '*' "
c_Query += " and         C6_NUM = '"+(cNumpv)+"' "
c_Query += " and         C6_FILIAL = '"+xFilial("SC6")+"'  "

If Select("QRY") > 0
	DbSelectArea("QRY")
	DbCloseArea()
EndIf

TcQuery c_Query New Alias "QRY"
TcSetField("QRY","C6_DTVALID","D")

IncProc("Importando")

_Proce ++
lMsErroAuto:= .F.

dbSelectArea("QRY") //carrega Array para Gerar Internos
dbGoTop()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณFaz a saida do produto do armazem oficial                     ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
While QRY->(!EOF())
	
	
	//		a260Processa(cCodOrig,			cLocOrig,		nQuant260,		cDocto,		dEmis260,	nQuant260D,		cNumLote,	cLoteDigi,	dDtValid,			cNumSerie,			cLoclzOrig,			cCodDest,			cLocDest,	cLocLzDest	,.F.,		Nil,		Nil,		"MATA260",	Nil,	Nil,	 Nil,	 Nil,		Nil,	  Nil,		Nil,	Nil,		Nil,	Nil,	Nil,	 Nil,	 Nil,	 Nil,	  Nil,	 	nPotencia,cLoteDigiD,dDtVldDest)
	//			a260Processa(cCodOrig,			cLocOrig,		nQuant260,		cDocto,		dEmis260,	nQuant260D,		cNumLote,	cLoteDigi,	dDtValid,			cNumSerie,			cLoclzOrig,			cCodDest,			cLocDest,	cLocLzDest,	lEstorno,	nRecOrig,	nRecDest,	cPrograma,	cEstFis,cServico,cTarefa,cAtividade,cAnomalia,cEstDest,	cEndDest,cHrInicio,	cAtuEst,cCarga,	cUnitiza,cOrdTar,cOrdAti,cRHumano,cRFisico,	nPotencia,		cLoteDest,	dDtVldDest)
	If !a260Processa(QRY->C6_PRODUTO,	QRY->C6_LOCAL,	QRY->C6_QTDVEN,	cNumDoc,	dDataBase,	QRY->C6_QTDVEN,	"",			"",			QRY->C6_DTVALID,	QRY->C6_NUMSERI,	QRY->C6_LOCALIZ,	QRY->C6_PRODUTO,	c_locdest,	'00',		.F.,		Nil,		Nil,		"MFATA001",	Nil,	Nil,	 Nil,	 Nil, 		Nil,	  Nil,		Nil,	 Nil,		Nil,	Nil,	Nil,	 Nil,	 Nil,	 Nil,	  Nil,		QRY->C6_POTENCI,"",			QRY->C6_DTVALID)
		MsgAlert("Houveram problemas ao baixar a quantidade de um dos itens do estoque. Contate a แrea de TI", "A T E N ว ร O")
		l_erro := .T.
		Exit
	Else
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณFaz reserva dos produtos no estoque.                          ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
/*
		DbSelectArea("SB2")
		DbSetOrder(1) //B2_FILIAL, B2_COD, B2_LOCAL, R_E_C_N_O_, D_E_L_E_T_
		If DbSeek(xFilial('SB2')+QRY->C6_PRODUTO+c_locdest)
			RecLock("SB2", .F.)
			SB2->B2_RESERVA += QRY->C6_QTDVEN
			MsUnLock()
		EndIf
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณFaz reserva dos produtos no estoque por lote.                 ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		DbSelectArea("SB8")
		DbSetOrder(3)//B8_FILIAL, B8_PRODUTO, B8_LOCAL, B8_LOTECTL, B8_NUMLOTE, B8_DTVALID, R_E_C_N_O_, D_E_L_E_T_
		If DbSeek(xFilial("SB8")+QRY->C6_PRODUTO+c_locdest+SD3->D3_LOTECTL)
			RecLock('SB8', .F.)
			SB8->B8_EMPENHO += QRY->C6_QTDVEN
			MsUnLock()
		EndIf
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณFaz reserva dos produtos no estoque por endereco.             ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		DbSelectArea("SBF")
		DbSetOrder(1) //BF_FILIAL, BF_LOCAL, BF_LOCALIZ, BF_PRODUTO, BF_NUMSERI, BF_LOTECTL, BF_NUMLOTE, R_E_C_N_O_, D_E_L_E_T_
		If DbSeek(xFilial("SBF")+c_locdest+'00'+QRY->C6_PRODUTO+QRY->C6_NUMSERI)
			RecLock("SBF", .F.)
			SBF->BF_EMPENHO += QRY->C6_QTDVEN
			MsUnLock()
		EndIf
*/		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณLibera a  reserva do pedido anterior.                         ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		DbSelectArea("SB2")
		DbSetOrder(1) //B2_FILIAL, B2_COD, B2_LOCAL, R_E_C_N_O_, D_E_L_E_T_
		If DbSeek(xFilial('SB2')+QRY->(C6_PRODUTO+C6_LOCAL))
			RecLock("SB2", .F.)
			SB2->B2_RESERVA -= QRY->C6_QTDVEN
			MsUnLock()
		EndIf
		DbSelectArea("SB8")
		DbSetOrder(3)//B8_FILIAL, B8_PRODUTO, B8_LOCAL, B8_LOTECTL, B8_NUMLOTE, B8_DTVALID, R_E_C_N_O_, D_E_L_E_T_
		If DbSeek(xFilial("SB8")+QRY->(C6_PRODUTO+C6_LOCAL+C6_LOTECTL))
			RecLock('SB8', .F.)
			SB8->B8_EMPENHO -= QRY->C6_QTDVEN
			MsUnLock()
		EndIf
		DbSelectArea("SBF")
		DbSetOrder(1) //BF_FILIAL, BF_LOCAL, BF_LOCALIZ, BF_PRODUTO, BF_NUMSERI, BF_LOTECTL, BF_NUMLOTE, R_E_C_N_O_, D_E_L_E_T_
		If DbSeek(xFilial("SBF")+QRY->(C6_LOCAL+C6_LOCALIZ+C6_PRODUTO+QRY->C6_NUMSERI))
			RecLock("SBF", .F.)
			SBF->BF_EMPENHO -= QRY->C6_QTDVEN
			MsUnLock()
		EndIf
		
	EndIf
	
	QRY->(dbSkip())
EndDo

If !l_erro
	
	DbSelectArea("SC5")
	DbSetOrder(1)
	Reclock("SC5",.F.)
	SC5->C5_NOTA   := "999999999"    //FECHA PV
	SC5->C5_SERIE  := "999"          //FECHA PV
	SC5->C5_XSITPM := "E"            //ENCERRA PM
	SC5->C5_XENTRPM:= dDataBase
	MSUNLOCK()
	
	DbSelectArea("SC9")
	DbSetOrder(1) //C9_FILIAL, C9_PEDIDO, C9_ITEM, C9_SEQUEN, C9_PRODUTO, R_E_C_N_O_, D_E_L_E_T_
	If DbSeek(xFilial("SC9")+SC5->C5_NUM)
		While SC9->(!EOF()) .and. SC5->C5_NUM = SC9->C9_PEDIDO
			Reclock("SC9",.F.)
			SC9->C9_NFISCAL		:= "999999999"    //FECHA PV
			SC9->C9_SERIENF		:= "999"          //FECHA PV
			SC9->C9_BLCRED		:= "10"            //ENCERRA PM
			SC9->C9_BLEST		:= "10"
			MSUNLOCK()
			SC9->(DbSkip())
		EndDo
	EndIf
	
	DbSelectArea("SD3")
	DbSetOrder(2) //D3_FILIAL, D3_DOC, D3_COD, R_E_C_N_O_, D_E_L_E_T_
	If DbSeek(xFilial("SD3")+cNumDoc)
		While SD3->(!EOF()) .and. SD3->D3_DOC = cNumDoc
			RecLock("SD3", .F.)
			SD3->D3_XPEDESP := SC5->C5_NUM
			MsUnLock()
			SD3->(DbSkip())
		EndDo
	EndIf
	
	MsgInfo("Baixa Gerada com Sucesso!!!")
EndIf

dbSelectArea("QRY")
dbclosearea()

Return  