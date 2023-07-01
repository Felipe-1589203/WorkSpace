#include "Rwmake.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMFATR006  บAutor  ณMauricio Nasser     บ Data ณ  30/08/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑบDesc.     ณ Este relatorio imprimi os valores faturados por segmento   บฑฑ
ฑฑบ          ณ de venda.                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Especifico MULTLOCK  -   www.actualtrend.com.br            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function MFATR006()

Local cDesc1  	  := "Este relatorio ira imprimir os valores faturados"          
Local cDesc2  	  := "por segmento de venda m๊s a m๊s"                      
Local cDesc3  	  := ""
Private cString  := "SH6"
Private Tamanho  := "G"
Private aReturn  := { "Zebrado",1,"Administracao",2,2,1,"",1 }
Private wnrel    := "MFATR006"
Private NomeProg := "MFATR006"
Private nLastKey := 0
Private Limite   := 220
Private cPerg    := "MFATR006b"
Private nTipo    := 0
Private cbCont   := 0
Private cbTxt    := "registro(s) lido(s)"
Private Li       := 80
Private m_pag    := 1
Private aOrd     := {} 
Private cabec1   :="SEGMENTO             ANO DE         JANEIRO      FEVEREIRO         MARCO         ABRIL          MAIO         JUNHO          JULHO        AGOSTO       SETEMBRO        OUTUBRO       NOVEMBRO       DEZEMBRO    TOTAL ANUAL "   
Private Cabec2   :="DE VENDA             APURACAO"   
Private nTotDias := 0
Private nNumInd  := 0
Private nMedia   := 0
Private nNecReal := 0
Private nNecPla  := 0 
Private nVlrNec  := 0
Private nSldNec  := 0
Private cDescOP  := " " 
Private cDescMot := " "
Private a_cmps   := {}
Private a_dados  := {}

aAdd(a_cmps,{"Segmento"			,"C",20,0})    
aAdd(a_cmps,{"Ano"	      		,"C",04,0})    
aAdd(a_cmps,{"Janerio"			,"N",12,2})
aAdd(a_cmps,{"Fevereiro"		,"N",12,2})
aAdd(a_cmps,{"Marco"	  		,"N",12,2})
aAdd(a_cmps,{"Abril"	  		,"N",12,2})
aAdd(a_cmps,{"Maio" 		 	,"N",12,2})
aAdd(a_cmps,{"Junho"			,"N",12,2})
aAdd(a_cmps,{"Julho"			,"N",12,2})
aAdd(a_cmps,{"Agosto"			,"N",12,2})
aAdd(a_cmps,{"Setembro"			,"N",12,2})
aAdd(a_cmps,{"Outubro"			,"N",12,2})
aAdd(a_cmps,{"Novembro"			,"N",12,2})
aAdd(a_cmps,{"Dezembro"			,"N",12,2})
aAdd(a_cmps,{"Total"			,"N",12,2}) //acrescentei esta linha

//aAdd(aOrd, "Recurso")
//aAdd(aOrd, "C.Custo/OP")

#IFNDEF TOP
   MsgInfo("Nใo ้ possํvel executar este programa, estแ base de dados nใo ้ TopConnect")
   RETURN
#ENDIF

ValidPerg()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Variaveis utilizadas para parametros                         ณ
//ณ mv_par01              Data Producao De                       ณ
//ณ mv_par02              Data Producao At้                      ณ
//ณ mv_par03              Produto De ?                           ณ
//ณ mv_par04              Produto Ate ?                          ณ
//ณ mv_par05              OP De		 ?             			     ณ
//ณ mv_par06              OP Ate     ?		  				     ณ
//ณ mv_par07              C.Custo De ?          	             ณ
//ณ mv_par08              C.Custo Ate ?	                         ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

//+-------------------------------------------------------------------------------+
//| Solicita ao usuario a parametrizacao do relatorio.                            |
//+-------------------------------------------------------------------------------+
Pergunte(cPerg,.F.)

Private Titulo   := "Rela็ใo de Faturamento por segmento no periodo de " +Dtoc(MV_PAR01)+ " a "+Dtoc(MV_PAR02)+" - Filial: " +cFilant+ ""
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
Local cFilSD4   	:= xFilial(cString)
Local cQuery    	:= ""
Local aCol      	:= {}
Local aSubTotal	:= {}
local nTotalJan := 0
local nTotalFev := 0
local nTotalMar := 0
local nTotalAbr := 0
local nTotalMai := 0
local nTotalJun := 0
local nTotalJul := 0
local nTotalAgo := 0
local nTotalSet := 0
local nTotalOut := 0
local nTotalNov := 0
local nTotalDez := 0   
local nTotalMes := 0  
local nTotalGer := 0   
local Total		:= 0     //inseri

Local cQuebra,cCampo,cMens
Local cIndex
Local nqtdtotal		:= 0
Local nQtdPerda		:= 0
Local nRPNC			:= 0

Private _aSaldoIni:={}
Private Titulo   	:= "Relat๓rio de faturamento por segmento no periodo de " +Dtoc(MV_PAR01)+ " a "+Dtoc(MV_PAR02)+" - Filial: " +cFilant+ ""
//  +------------------------+
//  | Cria filtro temporario |
//  +------------------------+

cQuery:= "SELECT  SC5.C5_XORIGEM, SubString(SD2.D2_EMISSAO,1,4) as ANO"
cQuery+= "        , [Janeiro]    = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=01 then SD2.D2_TOTAL end),0)" 
cQuery+= "        , [Fevereiro]  = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=02 then SD2.D2_TOTAL end),0)" 
cQuery+= "        , [Marco]      = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=03 then SD2.D2_TOTAL end),0)" 
cQuery+= "        , [Abril]      = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=04 then SD2.D2_TOTAL end),0)" 
cQuery+= "        , [Maio]       = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=05 then SD2.D2_TOTAL end),0)" 
cQuery+= "        , [Junho]      = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=06 then SD2.D2_TOTAL end),0)" 
cQuery+= "        , [Julho]      = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=07 then SD2.D2_TOTAL end),0)" 
cQuery+= "        , [Agosto]     = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=08 then SD2.D2_TOTAL end),0)" 
cQuery+= "        , [Setembro]   = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=09 then SD2.D2_TOTAL end),0)" 
cQuery+= "        , [Outubro]    = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=10 then SD2.D2_TOTAL end),0)" 
cQuery+= "        , [Novembro]   = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=11 then SD2.D2_TOTAL end),0)" 
cQuery+= "        , [Dezembro]   = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=12 then SD2.D2_TOTAL end),0)"         
cQuery+= " FROM SD2010 AS SD2" 
cQuery+= " JOIN SC5010 AS SC5" 
cQuery+= " ON  SD2.D2_FILIAL = SC5.C5_FILIAL"
cQuery+= " AND SD2.D2_PEDIDO = SC5.C5_NUM"
cQuery+= " JOIN SF4010 AS SF4" 
cQuery+= " ON SD2.D2_FILIAL = SF4.F4_FILIAL"
cQuery+= " AND SD2.D2_TES = SF4.F4_CODIGO" 
cQuery+= " WHERE SF4.F4_DUPLIC = 'S'" 
cQuery+= " AND SD2.D2_EMISSAO >= '"+DTOS(mv_par01)+"'"
cQuery+= " AND SD2.D2_EMISSAO <= '"+DTOS(mv_par02)+"'"
cQuery+= " AND (SD2.D2_TIPO = 'N' OR SD2.D2_TIPO = 'C')"
cQuery+= " AND SC5.D_E_L_E_T_ <> '*'"   
cQuery+= " AND SD2.D_E_L_E_T_ <> '*'"
cQuery+= " AND SF4.D_E_L_E_T_ <> '*'"
cQuery+= " GROUP BY C5_XORIGEM,SubString(SD2.D2_EMISSAO,1,4)"
cQuery+= " ORDER BY C5_XORIGEM,SubString(SD2.D2_EMISSAO,1,4)"
      
//+-----------------------
//| Cria indice temporario
//+-----------------------

// Com isso vc pode escolher a opcao do order by

//If	aReturn[8] == 1        // Centro de Custo / Produto
//   	cQuery 	+= "H6_RECURSO, H6_PRODUTO"
//	cCampo	:= "H6_FILIAL+H6_RECURSO"

//Elseif aReturn[8] == 2        // Centro de Custo / OP
//   	cQuery 	+= "H1_CCUSTO, H6_OP"
//		cCampo	:= "H6_FILIAL+H6_OP"

//Endif

//+------------------------+
//| Cria uma view no banco |
//+------------------------+

dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "TRB", .T., .F. )
dbSelectArea("TRB")
dbGoTop()
SetRegua( RecCount() )

//"SEGMENTO             ANO DE         JANEIRO      FEVEREIRO         MARCO         ABRIL          MAIO         JUNHO          JULHO        AGOSTO       SETEMBRO        OUTUBRO       NOVEMBRO       DEZEMBRO    Total Anual "   
//"DE VENDA             APURACAO   9,999,999.99
// XXXXXXXXXXXXXXXXXXX  xxxx       9,999,999.99  9,999,999.99  9,999,999.99  9,999,999.99  9,999,999.99  9,999,999.99   9,999,999.99   9,999,999.99  9,999,999.99   9,999,999.99   9,999,999.99   9,999,999.99  99,999,999.99
// 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
//           1         2         3         4         5         6         7         8         9        10        11         12        13        14        15        16        17        18        19        20        21        22

//+---------------------+
//| Coluna de impressao |  
//+---------------------+
aAdd( aCol, 001 ) // Segmento de Venda
aAdd( aCol, 021 ) // Ano de Apuracao
aAdd( aCol, 031 ) // Janeiro
aAdd( aCol, 046 ) // Fevereiro 47
aAdd( aCol, 060 ) // Marco     63
aAdd( aCol, 074 ) // Abril     79
aAdd( aCol, 088 ) // Maio      95
aAdd( aCol, 102 ) // Junho    113
aAdd( aCol, 117 ) // Julho    127
aAdd( aCol, 132 ) // Agosto   141
aAdd( aCol, 146 ) // Setembro  159
aAdd( aCol, 161 ) // Outubro  175
aAdd( aCol, 176 ) // Novembro 191
aAdd( aCol, 191 ) // Dezembro 207
aAdd( aCol, 206 ) // Total Anual


While !Eof() .And. !lEnd 
   
nqtdprod := 0
nqtdperd := 0	

   If Li > 55
      Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
   Endif

   DbSelectArea("TRB")
   
  // cQuebra:=&(cCampo)
   
  // lEnd - aborta o relat๓rio atraves da tecla ESC
   While !Eof() .And. !lEnd  //&(cCampo) == cQuebra .And. !lEnd 
   nTotalmes := 0


      IncRegua()
      
      If Li > 55
         Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
      Endif

	 Do Case
	     Case TRB->C5_XORIGEM = 'A' 
	            @ Li,aCol[01] PSAY 'AUTOMOTIVO'
	            cOrigem:='AUTOMOTIVO' 
	     Case TRB->C5_XORIGEM = 'C' 
	            @ Li,aCol[01] PSAY 'CORPORATIVO'
	            cOrigem:='CORPORATIVO'
	     Case TRB->C5_XORIGEM = 'V'
	            @ Li,aCol[01] PSAY 'VAREJO' 
	            cOrigem:='VAREJO'
	     Case TRB->C5_XORIGEM = 'M' 
	            @ Li,aCol[01] PSAY 'MULTLOCK CENTER'
	            cOrigem:='MULTLOCK CENTER'
	     Case TRB->C5_XORIGEM = 'T' 
	            @ Li,aCol[01] PSAY 'ASSIST. TECNICA'
	             cOrigem:='ASSIST. TECNICA'
	     Case TRB->C5_XORIGEM = 'I' 
	            @ Li,aCol[01] PSAY 'INDUSTRIAL'
	            cOrigem:='INDUSTRIAL'    
	     Case TRB->C5_XORIGEM = 'B'      //INSERI SEGMENTO CONSTRUTORA
	            @ Li,aCol[01] PSAY 'CONSTRUTORA'
	            cOrigem:='CONSTRUTORA' //-----------FIM---------- ANDRE 23-08-11------
	     OtherWise
	            @ Li,aCol[01] PSAY 'OUTROS' 
	            cOrigem:= 'OUTROS'         
     EndCase
     
      @ Li, aCol[02] PSAY  TRB->ANO
      @ Li, aCol[03] PSAY Transform(TRB->Janeiro, "@E 9,999,999.99")
      @ Li, aCol[04] PSAY Transform(TRB->Fevereiro, "@E 9,999,999.99")
      @ Li, aCol[05] PSAY Transform(TRB->Marco, "@E 9,999,999.99")
      @ Li, aCol[06] PSAY Transform(TRB->Abril, "@E 9,999,999.99")
      @ Li, aCol[07] PSAY Transform(TRB->Maio, "@E 9,999,999.99")
      @ Li, aCol[08] PSAY Transform(TRB->Junho, "@E 9,999,999.99")
      @ Li, aCol[09] PSAY Transform(TRB->Julho, "@E 9,999,999.99")
      @ Li, aCol[10] PSAY Transform(TRB->Agosto, "@E 9,999,999.99")
      @ Li, aCol[11] PSAY Transform(TRB->Setembro, "@E 9,999,999.99")
      @ Li, aCol[12] PSAY Transform(TRB->Outubro, "@E 9,999,999.99")
      @ Li, aCol[13] PSAY Transform(TRB->Novembro, "@E 9,999,999.99")
      @ Li, aCol[14] PSAY Transform(TRB->Dezembro, "@E 9,999,999.99")

      nTotalJan += TRB->Janeiro  
      nTotalFev += TRB->Fevereiro  
      nTotalMar += TRB->Marco   
      nTotalAbr += TRB->Abril   
      nTotalMai += TRB->Maio    
      nTotalJun += TRB->Junho    
      nTotalJul += TRB->Julho   
      nTotalAgo += TRB->Agosto   
      nTotalSet += TRB->Setembro 
      nTotalOut += TRB->Outubro 
      nTotalNov += TRB->Novembro
      nTotalDez += TRB->Dezembro 
      
      
	  nTotalmes := (TRB->Janeiro+TRB->Fevereiro+TRB->Marco+TRB->Abril +TRB->Maio+TRB->Junho+TRB->Julho+TRB->Agosto+TRB->Setembro+TRB->Outubro+TRB->Novembro+TRB->Dezembro)
      nTotalGer += nTotalmes 
      
	  @ Li, aCol[15] PSAY Transform(nTotalmes, "@E 99,999,999.99")     
	  

      Li++

   	  Aadd(a_dados, {cOrigem, TRB->ANO, TRB->Janeiro, TRB->Fevereiro, TRB->Marco, TRB->Abril,;
  	  TRB->Maio, TRB->Junho, TRB->Julho, TRB->Agosto, TRB->Setembro, TRB->Outubro, TRB->Novembro,;
	  TRB->Dezembro,nTotalmes}) //inseri TRB->Total
                                                     
      
	  DbSelectArea("TRB")
      dbskip()
        
	  
   Enddo

   Li++
   @ Li, 000 PSay Replicate("-",Limite)
   Li++
   @ Li, aCol[01] PSAY  'TOTAL'
   @ Li, aCol[03] PSAY Transform(nTotalJan, "@E 9,999,999.99")
   @ Li, aCol[04] PSAY Transform(nTotalFev, "@E 9,999,999.99")
   @ Li, aCol[05] PSAY Transform(nTotalMar, "@E 9,999,999.99")
   @ Li, aCol[06] PSAY Transform(nTotalAbr, "@E 9,999,999.99")
   @ Li, aCol[07] PSAY Transform(nTotalMai, "@E 9,999,999.99")
   @ Li, aCol[08] PSAY Transform(nTotalJun, "@E 9,999,999.99")
   @ Li, aCol[09] PSAY Transform(nTotalJul, "@E 9,999,999.99")
   @ Li, aCol[10] PSAY Transform(nTotalAgo, "@E 9,999,999.99")
   @ Li, aCol[11] PSAY Transform(nTotalSet, "@E 9,999,999.99")
   @ Li, aCol[12] PSAY Transform(nTotalOut, "@E 9,999,999.99")
   @ Li, aCol[13] PSAY Transform(nTotalNov, "@E 9,999,999.99")
   @ Li, aCol[14] PSAY Transform(nTotalDez, "@E 9,999,999.99") 
   @ Li, aCol[15] PSAY Transform(nTotalGer, "@E 99,999,999.99")   //inseri                                                  
//   @ Li, 001 PSay "Total Por Recurso (Maquina) ---->"
//   @ Li, 117 PSay nQtdprod Picture "@E 999,999.99"
//   @ Li, 128 PSay nQtdperd Picture "@E 999,999.99"
   Li++
   @ Li, 000 PSay Replicate("-",Limite)
   Li++

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

If msgYesNo("Deseja exportar para o excel?")
	FGEN002(a_cmps, a_dados)
EndIf

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
//ณ mv_par01              Data Producao De                       ณ
//ณ mv_par02              Data Producao At้                      ณ
//ณ mv_par03              Produto De ?                           ณ
//ณ mv_par04              Produto Ate ?                          ณ
//ณ mv_par05              OP De		 ?             			     ณ
//ณ mv_par06              OP Ate     ?		  				     ณ
//ณ mv_par07              C.Custo De ?          	             ณ
//ณ mv_par08              C.Custo Ate ?	                         ณ
//ณ mv_par09              Recurso De ?          	             ณ
//ณ mv_par10              Recurso Ate ?	                         ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	
	// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
	aAdd(aRegs,{cPerg,"01","Data Vendas de      ? ","","","MV_CH1","D",08,0,0,"G","","MV_PAR01","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{cPerg,"02","Data Vendas Ate     ? ","","","MV_CH2","D",08,0,0,"G","","MV_PAR02","","","","","","","","","","","","","","","","","","","","","","","","",""})
//	aAdd(aRegs,{cPerg,"03","Produto de            ? ","","","MV_CH3","C",15,0,0,"G","","MV_PAR03","","","","","","","","","","","","","","","","","","","","","","","","","SB1"})
//	aAdd(aRegs,{cPerg,"04","Produto Ate           ? ","","","MV_CH4","C",15,0,0,"G","","MV_PAR04","","","","","","","","","","","","","","","","","","","","","","","","","SB1"})
//	aAdd(aRegs,{cPerg,"05","OP Solano  De         ? ","","","MV_CH5","C",13,0,0,"G","","MV_PAR05","","","","","","","","","","","","","","","","","","","","","","","","","SC2"})
//	aAdd(aRegs,{cPerg,"06","OP Solano  Ate        ? ","","","MV_CH6","C",13,0,0,"G","","MV_PAR06","","","","","","","","","","","","","","","","","","","","","","","","","SC2"})
//	aAdd(aRegs,{cPerg,"07","Centro de Custo De    ? ","","","MV_CH7","C",09,0,0,"G","","MV_PAR07","","","","","","","","","","","","","","","","","","","","","","","","","CTT"})
//	aAdd(aRegs,{cPerg,"08","Centro de Custo Ate   ? ","","","MV_CH8","C",09,0,0,"G","","MV_PAR08","","","","","","","","","","","","","","","","","","","","","","","","","CTT"})
//	aAdd(aRegs,{cPerg,"09","Recurso  De           ? ","","","MV_CH9","C",06,0,0,"G","","MV_PAR09","","","","","","","","","","","","","","","","","","","","","","","","","SH1"})
//	aAdd(aRegs,{cPerg,"10","Recurso  Ate          ? ","","","MV_CHA","C",06,0,0,"G","","MV_PAR10","","","","","","","","","","","","","","","","","","","","","","","","","SH1"})

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
 MsgStop( 'MsExcel nao instalado' ) //
 Return
EndIf

oExcelApp := MsExcel():New()
oExcelApp:WorkBooks:Open( cPath+cArquivo+".DBF" ) // Abre uma planilha
oExcelApp:SetVisible(.T.)

Return
