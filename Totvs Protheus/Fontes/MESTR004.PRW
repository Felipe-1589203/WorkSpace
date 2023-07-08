#include "Rwmake.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMESTR004  บJean   ณTI-MULT-LOCK        บ Data ณ  12/10/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบ          ณ Anal. Jean Cavalcante - Ult. Alt. Em: 12/10/2009           บฑฑ
ฑฑบDesc.     ณ Este relatorio imprimi a lista de produtos com os saldos   บฑฑ
ฑฑบ          ณ dos armazens parte da tabela SB2 e rastreia o SB8, SBF.    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Especifico MULTLOCK - www.actualtrend.com.br               บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function MESTR004()

Local cDesc1  := "Este relatorio imprimi a lista de produtos com os saldos"          
Local cDesc2  := "dos armazens parte da tabela SB2 e rastreia o SB8, SBF."                      
Local cDesc3  := "Deve ser utilizado para checar divergencias entre saldo, e saldo lote X endereco."
Private cString  := "SB2"
Private Tamanho  := "G"
Private aReturn  := { "Zebrado",1,"Administracao",2,2,1,"",1 }
Private wnrel    := "MESTR004"
Private NomeProg := "MESTR004"
Private nLastKey := 0
Private Limite   := 220
Private cPerg    := "MESTR004"
Private nTipo    := 0
Private cbCont   := 0
Private cbTxt    := "registro(s) lido(s)"
Private Cabec1   := ""
Private Cabec2   := ""
Private Li       := 80
Private m_pag    := 1
Private aOrd     := {}
Private nTotDias := 0
Private nNumInd  := 0
Private nMedia   := 0
Private nNecReal := 0
Private nNecPla  := 0 
Private nVlrNec  := 0
Private nSldNec  := 0
Private nSaldo_pv 	:= 0 
Private nEstoq_Sol	:= 0
Private nSaldo_Lote	:= 0 	
Private nSaldo_End	:= 0
Private	nSaldo_EMP:= 0
Private nqtd_cons := 0
Private	nNecess   := 0
Private a_cmps	  := {}
Private a_dados	  := {}
	
#IFNDEF TOP
   MsgInfo("Nใo ้ possํvel executar este programa, estแ base de dados nใo ้ TopConnect")
   RETURN
#ENDIF

ValidPerg()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Variaveis utilizadas para parametros                         ณ
//ณ mv_par01              Produto de ?                           ณ
//ณ mv_par02              Produto Ate ?                          ณ
//ณ mv_par03              Armazem de Estoque de ?                ณ
//ณ mv_par04              Armazem de Estoque Ate ?               ณ
//ณ mv_par05              Tipo Produto de ?   		             ณ
//ณ mv_par06              Tipo Produto Ate ?        		     ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

//+-------------------------------------------------------------------------------
//| Solicita ao usuario a parametrizacao do relatorio.
//+-------------------------------------------------------------------------------
Pergunte(cPerg,.F.)

Private cabec1   := "CODIGO           DESCRICAO                       TIPO     UM   CONTROLE    CONTROLE   ARMAZEM     ESTOQUE        SALDO TOTAL   SALDO TOTAL      "  
Private Cabec2   := "PRODUTO          PRODUTO                         PRODUTO  MED  ENDERECO    LOTE       PRODUTO     ATUAL (SB2)    LOTE (SB8)    ENDERECO (SBF)   "  
	
aAdd(a_cmps,{"CODIGO"			,"C",15,0})    
aAdd(a_cmps,{"DESCRI"			,"C",30,0})    
aAdd(a_cmps,{"TIPO"	  			,"C",04,0})
aAdd(a_cmps,{"UNID"				,"C",04,0})
aAdd(a_cmps,{"ENDERE"			,"C",04,0})
aAdd(a_cmps,{"LOTE"				,"C",04,0})
aAdd(a_cmps,{"LOCAL"			,"C",04,0})
aAdd(a_cmps,{"SALDO"	  		,"N",15,2})
aAdd(a_cmps,{"TOT_LOTE"	  		,"N",15,2})
aAdd(a_cmps,{"TOT_END" 		 	,"N",15,2})


Private Titulo   := "Relacao de produtos SB2 --> SB8 X SBF" //+Dtoc(MV_PAR02)+ " a "+Dtoc(MV_PAR03)+" - Filial: " +mv_par01+ ""
wnrel := SetPrint(cString,wnrel,cPerg,@Titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,.F.,.F.)

If nLastKey == 27
   Return
Endif

SetDefault(aReturn,cString)

nTipo := Iif(aReturn[4] == 1, 15, 18)

If nLastKey == 27
   Return
Endif

//+-------------------------------------------------------------------------------
//| Chama funcao que processa os dados
//+-------------------------------------------------------------------------------
RptStatus({|lEnd| RelPROCImp(@lEnd, wnrel, cString) }, "Aguarde...", "Processando registros...", .T. )

Return

//+-------------------------------------------------------------------------------
//| funcao que processa os dados
//+-------------------------------------------------------------------------------
Static Function RelPROCImp(lEnd,wnrel,cString)
Local cFilSD4   := xFilial(cString)
Local cQuery    := ""
Local aCol      := {}
Private _aSaldoIni:={}

Private Titulo   := "Relacao de produtos SB2 --> SB8 X SBF"

// Private Titulo   := "Materiais com media de consumo no periodo de " +Dtoc(MV_PAR02)+ " a "+Dtoc(MV_PAR03)+" - Filial: " +mv_par01+ ""

//+-----------------------
//| Cria filtro temporario
//+-----------------------


cQuery := "SELECT SB2.B2_FILIAL, SB2.B2_COD, SB1.B1_TIPO, SB1.B1_UM, SB2.B2_QATU, SB2.B2_LOCAL, SB1.B1_LOCALIZ, SB1.B1_RASTRO "
cQuery += "FROM SB2010 AS SB2, SB1010 AS SB1 "
cQuery += "WHERE SB2.B2_COD = SB1.B1_COD "
cQuery += "AND SB2.B2_FILIAL >= '"+cFilAnt+"' "
cQuery += "AND SB2.B2_FILIAL <= '"+cFilAnt+"' "
cQuery += "AND SB2.B2_LOCAL >= '"+mv_par03+"' "
cQuery += "AND SB2.B2_LOCAL <= '"+mv_par04+"' "
cQuery += "AND SB2.B2_COD >= '"+mv_par01+"' "     
cQuery += "AND SB2.B2_COD <= '"+mv_par02+"' "     
cQuery += "AND SB1.B1_TIPO >= '"+mv_par05+"' "
cQuery += "AND SB1.B1_TIPO <= '"+mv_par06+"' "
cQuery += "AND SB2.D_E_L_E_T_ <> '*' "
cQuery += "AND SB1.D_E_L_E_T_ <> '*' "
cQuery += "ORDER BY 2 "

Alert(CQuery)

//+-------------------------
//| Cria uma view no banco
//+-------------------------
dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "TRB", .T., .F. )
dbSelectArea("TRB")
dbGoTop()
SetRegua( RecCount() )

//"CODIGO           DESCRICAO                       TIPO     UM   CONTROLE    CONTROLE   ARMAZEM     ESTOQUE        SALDO TOTAL   SALDO TOTAL      "  
//"PRODUTO          PRODUTO                         PRODUTO  MED  ENDERECO    LOTE	     PRODUTO     ATUAL (SB2)    LOTE (SB8)    ENDERECO (SBF)   "  
// XXXXXXXXXXXXXXX  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  XX       XX   XXX		  XXX		 XX			 9,999,999.99   9,999,999.99  9,999,999.99     "  
// 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//           1         2         3         4         5         6         7         8         9        10        11         12        13        14        15

//+--------------------
//| Coluna de impressao
//+--------------------
aAdd( aCol, 001 ) // Codigo do Produto
aAdd( aCol, 017 ) // Descricao do Produto
aAdd( aCol, 049 ) // Tipo do Produto
aAdd( aCol, 058 ) // Unidade de Medida 
aAdd( aCol, 063 ) // Controle de Endereco
aAdd( aCol, 075 ) // Controle Lote
aAdd( aCol, 086 ) // Armazem do Produto
aAdd( aCol, 097 ) // Estoque Atual (SB2)
aAdd( aCol, 112 ) // Saldo Total Lote (SB8)
aAdd( aCol, 126 ) // Saldo Total Endere็o (SBF)

While !Eof() .And. !lEnd 
   
   If Li > 65
      Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
   Endif

   DbSelectArea("TRB")
   
   nTotQuant  	:= 0
   nTotCmedio 	:= 0
   nTotValor  	:= 0
   nMedia     	:= 0
   nCUSTO	  	:= 0
   nQuantTotal  := 0
   nMediaTotal	:= 0
   nTotConsumo	:= 0
   nTotAtual	:= 0
   nSldAtual	:= 0
   nsaldo       := 0
  
   While !Eof() .And. !lEnd 

      IncRegua()
      
      If Li > 65
         Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)

      Endif

      @ Li, aCol[01] PSay TRB->B2_COD

      DbSelectArea("SB1")
      DbsetOrder(1)
      Dbseek(xfilial("SB1")+TRB->B2_COD) 
      @ Li, aCol[02] PSay Substr(SB1->B1_DESC,1,30)

      DbSelectArea("TRB")
      @ Li, aCol[03] PSay TRB->B1_TIPO
      @ Li, aCol[04] PSay TRB->B1_UM

      @ Li, aCol[05] PSay TRB->B1_LOCALIZ Picture "!!!"
      @ Li, aCol[06] PSay TRB->B1_RASTRO Picture "!!!" 

      @ Li, aCol[07] PSay TRB->B2_LOCAL Picture "!!"
      @ Li, aCol[08] PSay TRB->B2_QATU Picture "@E 9,999,999.99"

	  		
      nSaldo_Lote := SALDO_LOTE(TRB->B2_COD, TRB->B2_LOCAL)
      @ li, aCol[09] PSay nSaldo_Lote PicTure "@E 9,999,999.99"

      nSaldo_End := SALDO_END(TRB->B2_COD, TRB->B2_LOCAL)
      @ li, aCol[10] PSay nSaldo_End PicTure "@E 9,999,999.99"


      DbSelectArea("TRB")
      Li++
      dbSkip()

   Enddo

/*
   Li++
   @ Li, 000 PSay Replicate("-",Limite)
   Li++
   @ Li, aCol[05] PSay nQuantTotal Picture "@E 9,999,999.99"
   @ Li, aCol[06] PSay nTotConsumo Picture "@E 9,999,999.99"
   @ Li, aCol[07] PSay nMediaTotal Picture "@E 9,999,999.99"
   @ Li, aCol[08] PSay nTotAtual   Picture "@E 9,999,999.99"

   Li++
   @ Li, 000 PSay Replicate("-",Limite)
   Li++
   Li++
   @ Li, 000 PSay "Consumo e media calculada considerando os ultimos -> "+ALLTRIM(STR(Round(nNumInd,0)))+" <- meses."
   Li++
*/

Enddo

If lEnd
   @ Li, aCol[1] PSay cCancel
   Return
Endif
   
If Li <> 80
   Roda(cbCont,cbTxt,Tamanho)
Endif

dbSelectArea("TRB")
dbCloseArea()

If aReturn[5] == 1
   Set Printer TO
   dbCommitAll()
   Ourspool(wnrel)
EndIf

Ms_Flush()

/*
If msgYesNo("Deseja exportar para o excel?")
	FGEN002(a_cmps, a_dados)
EndIf
*/

Return


/*
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
*/
Static Function ValidPerg()

	Local _sAlias := Alias()
	Local aRegs := {}
	Local i,j
	
	dbSelectArea("SX1")
	dbSetOrder(1)
	cPerg := PADR(cPerg,10)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Variaveis utilizadas para parametros                         ณ
//ณ mv_par01              Produto de ?                           ณ
//ณ mv_par02              Produto Ate ?                          ณ
//ณ mv_par03              Armazem de Estoque de ?                ณ
//ณ mv_par04              Armazem de Estoque Ate ?               ณ
//ณ mv_par05              Tipo Produto de ?   		             ณ
//ณ mv_par06              Tipo Produto Ate ?        		     ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	


	// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
	aAdd(aRegs,{cPerg,"01","Produto De               ? ","","","MV_CH1","C",15,0,0,"G","","MV_PAR01","","","","","","","","","","","","","","","","","","","","","","","","","SB1"})
	aAdd(aRegs,{cPerg,"02","Produto At้              ? ","","","MV_CH2","C",15,0,0,"G","","MV_PAR02","","","","","","","","","","","","","","","","","","","","","","","","","SB1"})
	aAdd(aRegs,{cPerg,"03","Armazem de Estoque De    ? ","","","MV_CH3","C",02,0,0,"G","","MV_PAR03","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{cPerg,"04","Armazem de Estoque At้   ? ","","","MV_CH4","C",02,0,0,"G","","MV_PAR04","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{cPerg,"05","Tipo de Produto De       ? ","","","MV_CH5","C",02,0,0,"G","","MV_PAR05","","","","","","","","","","","","","","","","","","","","","","","","","02"})
	aAdd(aRegs,{cPerg,"06","Tipo de Produto Ate      ? ","","","MV_CH6","C",02,0,0,"G","","MV_PAR06","","","","","","","","","","","","","","","","","","","","","","","","","02"})

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


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Busca saldo em estoque dos produtos que tem LOTE             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Static Function SALDO_LOTE(Cprod,cLocal)
Local cQuery	:= ""
Local _sAlias	:= Alias()
nSaldo_LOTE	:= 0
cProduto	:= Cprod
cLoc		:= cLocal		

cQuery := "SELECT SB8.B8_FILIAL, SB8.B8_PRODUTO, SB8.B8_LOCAL, SUM(SB8.B8_SALDO) AS SALDO_LOTE "
cQuery += "FROM SB8010 as SB8 "
cQuery += "WHERE  SB8.B8_FILIAL >= '"+cFilAnt+"' "
cQuery += "AND SB8.B8_FILIAL <= '"+cFilAnt+"' "
cQuery += "AND SB8.B8_PRODUTO >= '"+cProduto+"' "
cQuery += "AND SB8.B8_PRODUTO <= '"+cProduto+"' "
cQuery += "AND SB8.B8_LOCAL >= '"+cLoc+"' "
cQuery += "AND SB8.B8_LOCAL <= '"+cLoc+"' "
cQuery += "AND SB8.D_E_L_E_T_ = ' ' "
cQuery += "GROUP BY SB8.B8_FILIAL, SB8.B8_PRODUTO, SB8.B8_LOCAL "
cQuery += "ORDER BY 2 "

dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "TRD", .T., .F. )
dbSelectArea("TRD")

While !Eof() 
	nSaldo_Lote := TRD->SALDO_LOTE
    dbSkip()
EndDo

dbSelectArea("TRD")
dbCloseArea()
dbSelectArea(_sAlias)

Return(nSaldo_Lote) 



//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Busca saldo em estoque dos produtos que tem ENDERECO         ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Static Function SALDO_END(Cprod,cLocal)
Local cQuery	:= ""
Local _sAlias	:= Alias()
nSaldo_End	:= 0
cProduto	:= Cprod
cLoc		:= cLocal		

cQuery := "SELECT SBF.BF_FILIAL, SBF.BF_PRODUTO, SBF.BF_LOCAL, SUM(SBF.BF_QUANT) AS SALDO_END "
cQuery += "FROM SBF010 as SBF "
cQuery += "WHERE  SBF.BF_FILIAL >= '"+cFilAnt+"' "
cQuery += "AND SBF.BF_FILIAL <= '"+cFilAnt+"' "
cQuery += "AND SBF.BF_PRODUTO >= '"+cProduto+"' "
cQuery += "AND SBF.BF_PRODUTO <= '"+cProduto+"' "
cQuery += "AND SBF.BF_LOCAL >= '"+cLoc+"' "
cQuery += "AND SBF.BF_LOCAL <= '"+cLoc+"' "
cQuery += "AND SBF.D_E_L_E_T_ = ' ' "
cQuery += "GROUP BY SBF.BF_FILIAL, SBF.BF_PRODUTO, SBF.BF_LOCAL "
cQuery += "ORDER BY 2 "

dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "TRD", .T., .F. )
dbSelectArea("TRD")

While !Eof() 
	nSaldo_End := TRD->SALDO_END
    dbSkip()
EndDo

dbSelectArea("TRD")
dbCloseArea()
dbSelectArea(_sAlias)

Return(nSaldo_End) 



//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Busca saldo dos empenhos dos produtos na filial solano       ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Static Function SALDO_EMP(Cprod)
Local cQuery    := ""
Local _sAlias := Alias()
nSaldo_EMP :=0
cProduto := Cprod

cQuery := "SELECT SD4.D4_FILIAL, SD4.D4_COD, SUM(SD4.D4_QTDEORI) AS EMP_TOTAL, SUM(SD4.D4_QUANT) AS EMP_SLD "
cQuery += "FROM SD4010 AS SD4 "
cQuery += "WHERE SD4.D4_COD >= '"+cProduto+"' "
cQuery += "AND SD4.D4_COD <= '"+cProduto+"' "
cQuery += "AND SD4.D_E_L_E_T_ <> '*' "
cQuery += "GROUP BY SD4.D4_FILIAL, SD4.D4_COD "
cQuery += "ORDER BY 2 "

dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "TRD", .T., .F. )
dbSelectArea("TRD")

While !Eof() 
	nSaldo_EMP := TRD->EMP_SLD
    dbSkip()
EndDo

dbSelectArea("TRD")
dbCloseArea()
dbSelectArea(_sAlias)

Return(nSaldo_EMP) 


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Busca quantidade do consumo no periodo de acordo com a filialณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู


Static Function QConsumo(Cprod)
Local cQuery    := ""
Local _sAlias := Alias()
nQtd_Cons :=0
cProduto  := Cprod

cQuery := "SELECT CODIGO,SUM(QUANT)AS QUANT ,SUM(CUSTO) AS CUSTO  FROM ( "
cQuery += "SELECT D2_COD AS CODIGO,SUM(D2_QUANT)AS QUANT ,SUM(D2_CUSTO1) AS CUSTO "
cQuery += "FROM SD2010 AS SD2 , SF4010 AS SF4 "
cQuery += "WHERE SD2.D2_FILIAL >='"+mv_par01+"'  AND "
cQuery += "SD2.D2_FILIAL <='"+mv_par01+"'  AND "
cQuery += "SD2.D2_COD >= '"+cProduto+"' AND "
cQuery += "SD2.D2_COD <= '"+cProduto+"' AND "
cQuery += "SD2.D2_EMISSAO >= '"+DTOS(mv_par02)+"'  AND "
cQuery += "SD2.D2_EMISSAO <= '"+DTOS(mv_par03)+"' AND "
cQuery += "SD2.D2_LOCAL >= '"+mv_par07+"'  AND "
cQuery += "SD2.D2_LOCAL <= '"+mv_par08+"'  AND "
cQuery += "SD2.D2_TES    = SF4.F4_CODIGO AND "
cQuery += "SF4.F4_FILIAL = '"+mv_par01+"' AND "
cQuery += "SF4.F4_CODIGO >= '500'  AND "
cQuery += "SF4.F4_CODIGO <= '999'  AND "
cQuery += "SF4.F4_ESTOQUE='S' AND "
cQuery += "SD2.D_E_L_E_T_=' ' AND SF4.D_E_L_E_T_=' ' "
cQuery += "GROUP BY D2_COD "
cQuery += "UNION ALL "
cQuery += "SELECT D3_COD ,SUM(D3_QUANT) ,SUM(D3_CUSTO1) "
cQuery += "FROM SD3010 AS SD3 "
cQuery += "WHERE SD3.D3_FILIAL>='"+mv_par01+"'  AND "
cQuery += "SD3.D3_FILIAL<='"+mv_par01+"'  AND "
cQuery += "SD3.D3_COD >= '"+cProduto+"' AND "
cQuery += "SD3.D3_COD <= '"+cProduto+"' AND "
cQuery += "SD3.D3_EMISSAO >= '"+DTOS(mv_par02)+"'  AND "
cQuery += "SD3.D3_EMISSAO <= '"+DTOS(mv_par03)+"'  AND "
cQuery += "SD3.D3_LOCAL >= '"+mv_par07+"'  AND "
cQuery += "SD3.D3_LOCAL <= '"+mv_par08+"'  AND "
If MV_PAR01 == '01'
	cQuery += "SD3.D3_TM = '501' AND "
Else
	cQuery += "SD3.D3_TM >= '500'  AND "
	cQuery += "SD3.D3_TM <= '997'  AND "
Endif
cQuery += "SD3.D3_ESTORNO <> 'S'  AND "
cQuery += "SD3.D_E_L_E_T_=' ' "
cQuery += "GROUP BY D3_COD "
cQuery += ") RESULTADO "
cQuery += "GROUP BY CODIGO "
cQuery += "ORDER BY CODIGO "

dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "TRD", .T., .F. )
dbSelectArea("TRD")

While !Eof() 
	nQtd_Cons := TRD->QUANT
    dbSkip()
EndDo

dbSelectArea("TRD")
dbCloseArea()
dbSelectArea(_sAlias)

Return(nQtd_Cons) 



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFGEN002   บAutor  ณAlexandre Martins   บ Data ณ  03/17/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao generica para exportacao de dados para o Excel.      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณEspecifico OmniLink.                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FGEN002(a_Header, a_cols)

	Processa({||ExpExcel(a_Header, a_cols)}, "Exportando Dados")

Return

Static Function ExpExcel(a_Header, a_cols)

LOCAL cDirDocs   := MsDocPath() 
Local aStru		:= {}
Local cArquivo := CriaTrab(,.F.)
Local cPath		:= AllTrim(GetTempPath())
Local oExcelApp
Local nX := 0

n_QtdReg := len(a_cols)
n_RegAtu := 0
ProcRegua(n_QtdReg)

For n_x := 1 to len(a_Header)
	Aadd(aStru, {a_Header[n_x,1]	, a_Header[n_x,2], a_Header[n_x, 3], a_Header[n_x, 4]})
Next


dbCreate(cDirDocs+"\"+cArquivo,aStru)
dbUseArea(.T.,,cDirDocs+"\"+cArquivo,cArquivo,.F.,.F.)

For nX := 1 to Len(a_cols)
	RecLock(cArquivo, .T.)
	IncProc("Concluindo ..."+AllTrim(Str((n_RegAtu/n_QtdReg)*100, 5))+" %")
	n_RegAtu++
	For n_y := 1 to len(a_Header)
		(cArquivo)->&(a_Header[n_y, 1])	:= a_cols[nX,n_y]
	Next
Next

dbSelectArea(cArquivo)
dbCloseArea()

CpyS2T( cDirDocs+"\"+cArquivo+".DBF" , cPath, .T. )

If ! ApOleClient( 'MsExcel' ) 
 MsgStop( 'MsExcel nao instalado' ) 
 Return
EndIf

oExcelApp := MsExcel():New()
oExcelApp:WorkBooks:Open( cPath+cArquivo+".DBF" ) 
oExcelApp:SetVisible(.T.)

Return

