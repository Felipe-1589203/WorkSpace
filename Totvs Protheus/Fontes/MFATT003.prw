#include "Rwmake.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AFAT004   ºAUTOR  ³MARCO AURELIO       º Data ³  27/02/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º          ³ Gera Planilha - Pedidos Nao Entregues                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Desenvolvido para atender necessidade NYTRON	              º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MFATT003()

Local cDesc1  	:= "Esta rotina gera planilha de Pedidos Nao Entregues"         
Local cDesc2  	:= "conforme parametros informado pelo usuario."
Local cDesc3  	:= ""
Private cString := "SF2"
Private cPerg   := "AFAT004REL"

Private a_dados  := {}
Private a_cmps   := {}         	
      
Aadd(a_cmps,{"Numero"			,"C",06,0})
Aadd(a_cmps,{"Cliente"		,"C",10,0})
Aadd(a_cmps,{"Emissao"			,"C",10,0})
Aadd(a_cmps,{"Saida"			,"C",15,0})
Aadd(a_cmps,{"Previsao"		,"C",40,0})





#IFNDEF TOP
   MsgInfo("Não é possível executar este programa, está base de dados não é TopConnect")
   RETURN
#ENDIF
	ValidPerg()
	Pergunte(cPerg,.T.)
	
	If msgYesNo("Confirma a Exportação para o Excel ?")
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

cQuery := 	"SELECT F2_DOC,F2_CLIENTE,F2_EMISSAO,F2_XDTENT,F2_DTENTR "
cQuery +=   "FROM " + RetSqlName("SF2") + " SF2, "

cQuery +=   "		AND F2_DOC >= '"+MV_PAR01+"' AND F2_DOC <= '"+MV_PAR02+"' "
cQuery +=   "		AND F2_CLIENTE >= '"+MV_PAR05+"' AND F2_CLIENTE <= '"+MV_PAR07+"' "
cQuery +=   "		AND F2_EMISSAO >= '"+DTOS(MV_PAR09)+"' AND F2_EMISSAO <= '"+DTOS(MV_PAR10)+"' "
cQuery +=   "		AND F2_XDTENT >= '"+DTOS(MV_PAR11)+"' AND F2_XDTENT <= '"+DTOS(MV_PAR12)+"' "
cQuery +=   "		AND F2_DTENTR >= '"+DTOS(MV_PAR11)+"' AND F2_DTENTR <= '"+DTOS(MV_PAR12)+"' "
cQuery +=   "        AND SA1.D_E_L_E_T_ = '' "

memowrite("MFATT003.sql", cQuery)

//+-------------------------
//| Cria uma view no banco
//+-------------------------

//If Select("TRB") > 0
  //	DbSelectArea("TRB")
//	DbCloseArea()/ /
//EndIf


//dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "TRB", .T., .F. )


//dbSelectArea("TRB")
//dbGoTop()


While !Eof()

	_vNumero 	:=	_vCliente 	:=_vEmissao	:=	_vSaida	:=  _vPrevisao	:=	 ""



	_vNumero	:=	TRB->F2_DOC
	_vCliente 	:=	TRB->F2_CLIENTE
	_vEmissao	:=	Substr(TRB->F2_EMISSAO,7,2)+"/"+substr(TRB->F2_EMISSAO,5,2)+"/"+substr(TRB->F2_EMISSAO,1,4)     
	_vSaida	:=	Substr(TRB->F2_XDTENT,7,2)+"/"+substr(TRB->F2_XDTENT,5,2)+"/"+substr(TRB->F2_XDTENT,1,4)
	_vPrevisao	:=	Substr(TRB->F2_DTENTR,7,2)+"/"+substr(TRB->F2_DTENTR,5,2)+"/"+substr(TRB->F2_DTENTR,1,4)

EndDo

Return
	Static Function ValidPerg()

	Local _sAlias := Alias()
	Local aRegs := {}
	Local i,j
	
	dbSelectArea("SX1")
	dbSetOrder(1)
	cPerg := PADR(cPerg,10)
	
	//           Grupo/Ordem/Pergunta        /Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
	aAdd(aRegs,{cPerg,"01","Pedido de        ? ","","","MV_CH1","C",09,0,0,"G","","MV_PAR01","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{cPerg,"02","Pedido Até       ? ","","","MV_CH2","C",09,0,0,"G","","MV_PAR02","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{cPerg,"05","Cliente de       ? ","","","MV_CH5","C",06,0,0,"G","","MV_PAR05","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{cPerg,"07","Cliente Até      ? ","","","MV_CH7","C",06,0,0,"G","","MV_PAR07","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{cPerg,"09","Emissao de       ? ","","","MV_CH9","D",08,0,0,"G","","MV_PAR09","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{cPerg,"10","Emissao Até      ? ","","","MV_CHA","D",08,0,0,"G","","MV_PAR10","","","","","","","","","","","","","","","","","","","","","","","","",""})		



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

