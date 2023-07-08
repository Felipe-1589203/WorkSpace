#include "Rwmake.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMFIN001   บAUTOR  ณMARCO AURELIO       บ Data ณ  19/08/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบ          ณ Gera Planilha - Cheques Recebidos                          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Desenvolvido para atender necessidade MULTLOCK             บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function MFIN001()

Local cDesc1  	:= "Esta rotina gera planilha de Cheques Recebidos"         
Local cDesc2  	:= "conforme parametros informado pelo usuario."                      
Local cDesc3  	:= ""
Private cString := "SE1"
Private cPerg   := "MFIN001"
Private a_dados := {}
Private a_cmps  := {}         	
    
Aadd(a_cmps,{"Emissao" 			,"C",10,0})    
Aadd(a_cmps,{"Tipo"				,"C",02,0})
Aadd(a_cmps,{"Prefixo"			,"C",03,0})
Aadd(a_cmps,{"Titulo"			,"C",09,0})
Aadd(a_cmps,{"Parcela"			,"C",02,0}) 
Aadd(a_cmps,{"Vencimento" 		,"C",10,0})    
Aadd(a_cmps,{"Banco" 			,"C",03,0})    
Aadd(a_cmps,{"Agencia"			,"C",05,0})
Aadd(a_cmps,{"Conta"			,"C",10,0})
Aadd(a_cmps,{"Emitente"			,"C",40,0})
Aadd(a_cmps,{"Valor"			,"N",14,2})

#IFNDEF TOP
   MsgInfo("Nใo ้ possํvel executar este programa, estแ base de dados nใo ้ TopConnect")
   RETURN
#ENDIF

	Validperg()
	Pergunte(cPerg,.T.)
	
	If msgYesNo("Confirma a Exporta็ใo para o Excel ?")
	   Processa({|lEnd| GeraPlan(cString) }, "Gravando os dados, aguarde...")
	EndIf


Return


//+-------------------------------------------------------------------------------
//| funcao que processa os dados
//+-------------------------------------------------------------------------------
Static Function GeraPlan(cString)

Local cFilSE1   := xFilial(cString)
Local cQuery    := ""

cQuery := 	"SELECT E1_PREFIXO,E1_NUM,E1_PARCELA,E1_TIPO,E1_CLIENTE,E1_LOJA,E1_EMISSAO,E1_VENCREA,E1_VALOR,E1_BCOCHQ,E1_AGECHQ,E1_CTACHQ,E1_NUMLIQ,E1_EMITCHQ "
cQuery +=   "FROM " + RetSqlName("SE1") + " SE1 "
cQuery +=   "WHERE E1_TIPO = 'CH' " 
cQuery +=   "	AND E1_EMISSAO BETWEEN '"+dtos(mv_par01)+"' AND '"+dtos(mv_par02)+"' "
cQuery +=   "	AND SE1.D_E_L_E_T_ = '' "
cQuery +=   "ORDER BY E1_EMISSAO,E1_TIPO,E1_CLIENTE "


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


	_Dt_Emissao	:= _Tipo:= _Prefixo	:= _Titulo := _Parcela := _Dt_Vencto	:= _Banco := _Agencia	:= _Conta := _Emitente :=  ""
	_Valor		:=	0

	_Dt_Emissao	:= Substr(TRB->E1_EMISSAO,7,2)+"/"+substr(TRB->E1_EMISSAO,5,2)+"/"+substr(TRB->E1_EMISSAO,1,4)
	_Tipo		:= Substr(TRB->E1_TIPO,1,2)
	_Prefixo	:= Substr(TRB->E1_PREFIXO,1,3)
	_Titulo		:= Substr(TRB->E1_NUM,1,9)
	_Parcela	:= Substr(TRB->E1_PARCELA,1,2)
	_Dt_Vencto	:= Substr(TRB->E1_VENCREA,7,2)+"/"+substr(TRB->E1_VENCREA,5,2)+"/"+substr(TRB->E1_VENCREA,1,4)
	_Banco		:= Substr(TRB->E1_BCOCHQ,1,3)
	_Agencia	:= Substr(TRB->E1_AGECHQ,1,5)
	_Conta		:= Substr(TRB->E1_CTACHQ,1,10)
	_Emitente	:= Substr(TRB->E1_EMITCHQ,1,40)
	_Valor		:= TRB->E1_VALOR

     Aadd(a_dados, {_Dt_Emissao,_Tipo, _Prefixo, _Titulo , _Parcela, _Dt_Vencto, _Banco , _Agencia, _Conta, _Emitente ,_Valor } )
     
	dbSelectArea("TRB")
    dbSkip()

EndDo

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
	
	// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
	aAdd(aRegs,{cPerg,"01","Emissao de       ? ","","","MV_CH1","D",08,0,0,"G","","MV_PAR01","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{cPerg,"02","Emissao At้      ? ","","","MV_CH2","D",08,0,0,"G","","MV_PAR02","","","","","","","","","","","","","","","","","","","","","","","","",""})
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