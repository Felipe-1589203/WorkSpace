#include "Rwmake.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAFAT004   บAUTOR  ณMARCO AURELIO       บ Data ณ  27/02/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบ          ณ Gera Planilha - Pedidos Nao Entregues                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Desenvolvido para atender necessidade NYTRON	              บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function MFATR003()

Local cDesc1  	:= "Esta rotina gera planilha de Pedidos Nao Entregues"         
Local cDesc2  	:= "conforme parametros informado pelo usuario."
Local cDesc3  	:= ""
Private cString := "SC6"
Private cPerg   := "AFAT004REL"

Private a_dados  := {}
Private a_cmps   := {}         	
    
Aadd(a_cmps,{"Cliente"	 		,"C",06,0})    
Aadd(a_cmps,{"Loja"				,"C",02,0})
Aadd(a_cmps,{"Nome"				,"C",40,0})
Aadd(a_cmps,{"Numero"			,"C",06,0})
Aadd(a_cmps,{"Ped_Client"		,"C",10,0})
Aadd(a_cmps,{"Item"	 			,"C",02,0})
Aadd(a_cmps,{"Emissao"			,"C",10,0})
Aadd(a_cmps,{"Produto"			,"C",15,0})
Aadd(a_cmps,{"Descricao"		,"C",40,0})
Aadd(a_cmps,{"Entrega"			,"C",10,0})
Aadd(a_cmps,{"Qtd_Vend"			,"N",05,0})

Aadd(a_cmps,{"Vlr_Vend"			,"N",16,4})
Aadd(a_cmps,{"Qtd_Entr"			,"N",05,0})
Aadd(a_cmps,{"Vlr_Entr"			,"N",16,4})
Aadd(a_cmps,{"Pendente"			,"N",05,0})
Aadd(a_cmps,{"Vlr_Pend"			,"N",16,4})

Aadd(a_cmps,{"Estoq_Disp"  		,"N",16,0})
Aadd(a_cmps,{"CodVend"			,"C",06,0})
Aadd(a_cmps,{"Nome_Vend"		,"C",30,0})
Aadd(a_cmps,{"Mes"				,"C",10,0})
Aadd(a_cmps,{"PED_ESP"			,"C",10,0})
    

#IFNDEF TOP
   MsgInfo("Nใo ้ possํvel executar este programa, estแ base de dados nใo ้ TopConnect")
   RETURN
#ENDIF
	ValidPerg()
	Pergunte(cPerg,.T.)
	
	If msgYesNo("Confirma a Exporta็ใo para o Excel ?")
	   Processa({|lEnd| GeraPlan(cString) }, "Gravando os dados, aguarde...")
	EndIf


Return


//+-------------------------------------------------------------------------------
//| funcao que processa os dados
//+-------------------------------------------------------------------------------
Static Function GeraPlan(cString)

Local cFilSF1   := xFilial(cString)
Local cQuery    := ""
Local c_origem	:= ''


If MV_PAR13 = 1
	c_origem := 'A'
ElseIf MV_PAR13 = 2
	c_origem := 'C'
ElseIf MV_PAR13 = 3
	c_origem := 'V'  
ElseIf MV_PAR13 = 4
	c_origem := 'M'
ElseIf MV_PAR13 = 5
	c_origem := 'B' 
Else
    c_origem := 'I' 	
EndIf

cQuery := 	"SELECT C6_CLI, C6_LOJA, A1_NOME, C6_NUM, C6_ITEM, C5_EMISSAO, C6_PRODUTO, C6_ENTREG, C6_PRCVEN, C6_QTDVEN,  (C6_PRCVEN * C6_QTDVEN) AS 'VLR_VEND',C6_QTDENT, (C6_PRCVEN*C6_QTDENT) AS 'VLR_ENT', (C6_QTDVEN - C6_QTDENT) AS 'PENDENTE',(C6_PRCVEN * (C6_QTDVEN - C6_QTDENT)) AS 'VLR_PEND',C5_VEND1,A3_NOME, C5_XTTPPED "
cQuery +=   "FROM " + RetSqlName("SC6") + " SC6, " + RetSqlName("SC5") + " SC5, "+ RetSqlName("SA1") + " SA1, " + RetSqlName("SA3") + " SA3 "
If MV_PAR17 <> 3
	cQuery +=   ", "+RetSqlName("SC9")+" SC9 "
EndIf
cQuery +=   "WHERE C6_FILIAL = '01' "
cQuery +=   "		AND C6_NUM >= '"+MV_PAR01+"' AND C6_NUM <= '"+MV_PAR02+"' "
cQuery +=   "		AND C6_PRODUTO >= '"+MV_PAR03+"' AND C6_PRODUTO <= '"+MV_PAR04+"' "
cQuery +=   "		AND C6_CLI >= '"+MV_PAR05+"' AND C6_CLI <= '"+MV_PAR07+"' "
cQuery +=   "		AND C6_LOJA >= '"+MV_PAR06+"' AND C6_LOJA <= '"+MV_PAR08+"' "
cQuery +=   "		AND C5_EMISSAO >= '"+DTOS(MV_PAR09)+"' AND C5_EMISSAO <= '"+DTOS(MV_PAR10)+"' "
cQuery +=   "		AND C6_ENTREG >= '"+DTOS(MV_PAR11)+"' AND C6_ENTREG <= '"+DTOS(MV_PAR12)+"' "
cQuery +=   "		AND C6_CLI+C6_LOJA = A1_COD+A1_LOJA "
cQuery +=   "		AND C6_FILIAL+C6_NUM = C5_FILIAL+C5_NUM "  
cQuery +=   "		AND C6_BLQ = '' "
cQuery +=   "		AND C6_TES <> '901' "
cQuery +=   "		AND C5_VEND1 = A3_COD "
cQuery +=   "		AND C5_XORIGEM = '"+c_origem+"'"
cQuery +=   "		AND C5_TIPO = 'N'"
If MV_PAR14 = 1
	cQuery +=   "		AND C5_NOTA <> ''"
ElseIf MV_PAR14 = 2
	cQuery +=   "		AND C5_NOTA = ''"
	cQuery +=   "		AND C6_QTDVEN <> C6_QTDENT "
EndIf
If MV_PAR15 = 1
	cQuery +=   "		AND C5_XTTPPED = 'S'"
ElseIf MV_PAR15 = 2
	cQuery +=   "		AND C5_XTTPPED = 'N'"
EndIf
If MV_PAR16 = 1
	cQuery +=   "		AND C5_XFATURA = 'S'"
ElseIf MV_PAR16 = 2
	cQuery +=   "		AND C5_XFATURA = 'N'"
EndIf
cQuery +=   "        AND SC5.D_E_L_E_T_ = '' "
cQuery +=   "        AND SC6.D_E_L_E_T_ = '' "
cQuery +=   "        AND SA1.D_E_L_E_T_ = '' "

If MV_PAR17 = 1
	cQuery +=   "        and      C9_PEDIDO = C6_NUM
	cQuery +=   "        and      C9_ITEM   = C6_ITEM
	cQuery +=   "        and      SC9.D_E_L_E_T_ <> '*'
	cQuery +=   "        and      C9_BLCRED not in ('09', '01')
ElseIf MV_PAR17 = 2
	cQuery +=   "        and      C9_PEDIDO = C6_NUM
	cQuery +=   "        and      C9_ITEM   = C6_ITEM
	cQuery +=   "        and      SC9.D_E_L_E_T_ <> '*'
	cQuery +=   "        and      C9_BLCRED in ('09', '01')
EndIf


cQuery +=   "	ORDER BY C6_CLI,C6_LOJA,C6_NUM,C6_ITEM,C6_PRODUTO "
	

memowrite("MFATR003.sql", cQuery)

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


While !Eof()

	_vCliente 	:= _vLoja		:=	_vNome		:=_vNumero	:= 	_vPed_Client	:=	_vItem		:= _vMes	:=	""
	_vProduto	:= _vCodVend	:= _vNomeVend	:=_vEmissao	:=	_vEntrega	:=  _vDescProd	:=	 ""
	_vQtdVend	:= _vVlrVend	:= _vQtdVend	:= _vVlrEnt	:=	_vPendente	:=	_vVlrPend	:= _vEstoque	:= 0
	c_pedesp	:= ''

	_vCliente 	:=	TRB->C6_CLI
	_vLoja		:=	TRB->C6_LOJA
	_vNome		:=	TRB->A1_NOME
	_vNumero	:=	TRB->C6_NUM
//	_vPed_Client:=	TRB->C5_XPEDCLI
	_vItem		:=	TRB->C6_ITEM
	_vEmissao	:=	Substr(TRB->C5_EMISSAO,7,2)+"/"+substr(TRB->C5_EMISSAO,5,2)+"/"+substr(TRB->C5_EMISSAO,1,4)
	_vProduto	:=	TRB->C6_PRODUTO
	_vDescProd  :=  GetAdvFval('SB1', 'B1_DESC', xFilial("SB1")+TRB->C6_PRODUTO, 1, '')
	_vEntrega	:=	Substr(TRB->C6_ENTREG,7,2)+"/"+substr(TRB->C6_ENTREG,5,2)+"/"+substr(TRB->C6_ENTREG,1,4)
	_vCodVend	:=	TRB->C5_VEND1
	_vNomeVend	:=	TRB->A3_NOME
	c_pedesp	:= Iif(TRB->C5_XTTPPED = 'S', 'SIM', 'NAO')

	_vQtdVend	:= TRB->C6_QTDVEN
	_vVlrVend	:= TRB->VLR_VEND
	
	_vQtdEnt	:= TRB->C6_QTDENT
	_vVlrEnt	:= TRB->VLR_ENT

	_vPendente	:= TRB->PENDENTE
	_vVlrPend	:= TRB->VLR_PEND      
	
	_vMes		:= "01/"+substr(TRB->C6_ENTREG,5,2)+"/"+substr(TRB->C6_ENTREG,1,4)


	_vEstoque	:=	0


	dbSelectArea("SB2")
	DbSetOrder(1) //B2_FILIAL, B2_COD, B2_LOCAL, R_E_C_N_O_, D_E_L_E_T_
	if dbseek(xfilial("SB2")+_vProduto+'01')
		_vEstoque	:=	B2_QATU-(B2_RESERVA+B2_QEMP)
	else
		_vEstoque	:=	0
	endif
	
	_vEstoque := Iif(_vEstoque < 0, 0 , _vEstoque)
	
	dbSelectArea("TRB")


     Aadd(a_dados, {_vCliente, _vLoja, _vNome, _vNumero, _vPed_Client,		_vItem,_vEmissao, _vProduto, _vDescProd, _vEntrega, _vQtdVend,;
     				_vVlrVend, _vQtdEnt, _vVlrEnt, _vPendente, _vVlrPend, 	_vEstoque, _vCodVend, _vNomeVend, _vMes, c_pedesp } )
     
	dbSelectArea("TRB")
    dbSkip()

EndDo

							
	/*
	ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
	ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
	ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
	ฑฑบ   Classifica o Array e Exporta para o Excel com funcao Generica   บฑฑ
	ฑฑศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
	ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
	฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
	*/

// a_dados := Asort( a_dados,,,{ |x,y| ( (substr(x[1],7,4)+substr(x[1],4,2)+substr(x[1],1,2))+x[4]+x[3]) < ( (substr(y[1],7,4)+substr(y[1],4,2)+substr(y[1],1,2))+y[4]+y[3]) } )

U_FGEN002(a_cmps, a_dados)   
	

Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณVALIDPERG บ Autor ณ AP5 IDE            บ Data ณ  25/06/01   บฑฑ
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
	cPerg := PADR(cPerg,10)
	
	//           Grupo/Ordem/Pergunta        /Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
	aAdd(aRegs,{cPerg,"01","Pedido de        ? ","","","MV_CH1","C",09,0,0,"G","","MV_PAR01","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{cPerg,"02","Pedido At้       ? ","","","MV_CH2","C",09,0,0,"G","","MV_PAR02","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{cPerg,"03","Produto de       ? ","","","MV_CH3","C",15,0,0,"G","","MV_PAR03","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{cPerg,"04","Produto At้      ? ","","","MV_CH4","C",15,0,0,"G","","MV_PAR04","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{cPerg,"05","Cliente de       ? ","","","MV_CH5","C",06,0,0,"G","","MV_PAR05","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{cPerg,"06","Loja de          ? ","","","MV_CH6","C",02,0,0,"G","","MV_PAR06","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{cPerg,"07","Cliente At้      ? ","","","MV_CH7","C",06,0,0,"G","","MV_PAR07","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{cPerg,"08","Loja At้         ? ","","","MV_CH8","C",02,0,0,"G","","MV_PAR08","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{cPerg,"09","Emissao de       ? ","","","MV_CH9","D",08,0,0,"G","","MV_PAR09","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{cPerg,"10","Emissao At้      ? ","","","MV_CHA","D",08,0,0,"G","","MV_PAR10","","","","","","","","","","","","","","","","","","","","","","","","",""})		
	aAdd(aRegs,{cPerg,"11","Dt Entrega de    ? ","","","MV_CHB","D",08,0,0,"G","","MV_PAR11","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{cPerg,"12","Dt Entrega At้   ? ","","","MV_CHC","D",08,0,0,"G","","MV_PAR12","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{cPerg,"13","Segmento         ? ","","","MV_CHD","C",01,0,0,"C","","MV_PAR13","Automotivo","","","","","Corporativo","","","","","Varejo","","","","","MultLockCenter","","","","","","Construtora","","c","","","","",""})
	aAdd(aRegs,{cPerg,"14","Faturados        ? ","","","MV_CHE","C",01,0,0,"C","","MV_PAR14","Faturados","","","","","Pendentes","","","","","Todos","","","","","","","","","","","","","",""})
	aAdd(aRegs,{cPerg,"15","Pedido Especial  ? ","","","MV_CHF","C",01,0,0,"C","","MV_PAR15","Sim","","","","","Nao","","","","","Ambos","","","","","","","","","","","","","",""})
	aAdd(aRegs,{cPerg,"16","Ok para NF       ? ","","","MV_CHG","C",01,0,0,"C","","MV_PAR16","Sim","","","","","Nao","","","","","Ambos","","","","","","","","","","","","","",""})
	aAdd(aRegs,{cPerg,"17","Lib.Financeira   ? ","","","MV_CHH","C",01,0,0,"C","","MV_PAR17","Sim","","","","","Nao","","","","","Ambos","","","","","","","","","","","","","",""})


	For i:=1 to Len(aRegs)
		If !dbSeek(cPerg+aRegs[i,2])
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

