#include "Rwmake.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMFATR008  บAutor  ณJean Cavalcante     บ Data ณ  30/08/10   บฑฑ
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

User Function MFATR008()

Local cDesc1  	  := "Este relatorio ira imprimir os valores faturados"          
Local cDesc2  	  := "por segmento de venda m๊s a m๊s"                      
Local cDesc3  	  := ""
Private cString  := "SH6"
Private Tamanho  := "G"
Private aReturn  := { "Zebrado",1,"Administracao",2,2,1,"",1 }
Private wnrel    := "MFATR008"
Private NomeProg := "MFATR008"
Private nLastKey := 0
Private Limite   := 220
Private cPerg    := "MFATR008b"
Private nTipo    := 0
Private cbCont   := 0
Private cbTxt    := "registro(s) lido(s)"
Private Li       := 80
Private m_pag    := 1
Private aOrd     := {}
Private cabec1   := "SEGMENTO                Dia-01     Dia-02      Dia-03      Dia-04      Dia-05      Dia-06      Dia-07      Dia-08      Dia-09      Dia-10      Dia-11      Dia-12      Dia-13      Dia-14      Dia-15      Dia-16   "           
Private Cabec2   := ""
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

aAdd(a_cmps,{"Segmento"			,"C",05,0})    
aAdd(a_cmps,{"Ano"	      		,"C",04,0})    
aAdd(a_cmps,{"Janerio"			,"N",10,2})
aAdd(a_cmps,{"Fevereiro"		,"N",10,2})
aAdd(a_cmps,{"Marco"	  		,"N",10,2})
aAdd(a_cmps,{"Abril"	  		,"N",10,2})
aAdd(a_cmps,{"Maio" 		 	,"N",10,2})
aAdd(a_cmps,{"Junho"			,"N",10,2})
aAdd(a_cmps,{"Julho"			,"N",10,2})
aAdd(a_cmps,{"Agosto"			,"N",10,2})
aAdd(a_cmps,{"Setembro"			,"N",10,2})
aAdd(a_cmps,{"Outubro"			,"N",10,2})
aAdd(a_cmps,{"Novembro"			,"N",10,2})
aAdd(a_cmps,{"Dezembro"			,"N",10,2})

#IFNDEF TOP
   MsgInfo("Nใo ้ possํvel executar este programa, estแ base de dados nใo ้ TopConnect")
   RETURN
#ENDIF

ValidPerg()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Variaveis utilizadas para parametros                         ณ
//ณ mv_par01              Data Producao De                       ณ
//ณ mv_par02              Data Producao At้                      ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

//+-------------------------------------------------------------------------------+
//| Solicita ao usuario a parametrizacao do relatorio.                            |
//+-------------------------------------------------------------------------------+
Pergunte(cPerg,.F.)

Private Titulo   := "RELAวรO DE FATURAMENTO POR SEGMENTO NO PERIODO DE " +Dtoc(MV_PAR01)+ " A "+Dtoc(MV_PAR02)+" - FILIAL: " +cFilant+ ""
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
Local cQuery2    	:= ""
Local aCol      	:= {}
Local aSubTotal	:= {}
Local cQuebra,cCampo,cMens
Local cIndex
Local ndia01		:= 0
Local ndia02		:= 0
Local ndia03		:= 0
Local ndia04		:= 0
Local ndia05		:= 0
Local ndia06		:= 0
Local ndia07		:= 0
Local ndia08		:= 0
Local ndia09		:= 0
Local ndia10		:= 0
Local ndia11		:= 0
Local ndia12		:= 0
Local ndia13		:= 0
Local ndia14		:= 0
Local ndia15		:= 0
Local ndia16		:= 0
Local ndia17		:= 0
Local ndia18		:= 0
Local ndia19		:= 0
Local ndia20		:= 0
Local ndia21		:= 0
Local ndia22		:= 0
Local ndia23		:= 0
Local ndia24		:= 0
Local ndia25		:= 0
Local ndia26		:= 0
Local ndia27		:= 0
Local ndia28		:= 0
Local ndia29		:= 0
Local ndia30		:= 0
Local ndia31		:= 0
Private _aSaldoIni:={}

Private Titulo   := "RELAวรO DE FATURAMENTO POR SEGMENTO NO PERIODO DE " +Dtoc(MV_PAR01)+ " A "+Dtoc(MV_PAR02)+" - FILIAL: " +cFilant+ ""
//  +------------------------+
//  | Cria filtro temporario |
//  +------------------------+

cQuery:= "SELECT  SC5.C5_XORIGEM, SubString(SD2.D2_EMISSAO,1,4) as ANO "
cQuery+= "         , [D01]	= Isnull(sum(case when SubString(SD2.D2_EMISSAO,7,2)=01 then SD2.D2_TOTAL end),0) "
cQuery+= "         , [D02]	= Isnull(sum(case when SubString(SD2.D2_EMISSAO,7,2)=02 then SD2.D2_TOTAL end),0) " 
cQuery+= "         , [D03]	= Isnull(sum(case when SubString(SD2.D2_EMISSAO,7,2)=03 then SD2.D2_TOTAL end),0) " 
cQuery+= "         , [D04]	= Isnull(sum(case when SubString(SD2.D2_EMISSAO,7,2)=04 then SD2.D2_TOTAL end),0) "
cQuery+= "         , [D05]	= Isnull(sum(case when SubString(SD2.D2_EMISSAO,7,2)=05 then SD2.D2_TOTAL end),0) "
cQuery+= "         , [D06]	= Isnull(sum(case when SubString(SD2.D2_EMISSAO,7,2)=06 then SD2.D2_TOTAL end),0) "
cQuery+= "         , [D07]	= Isnull(sum(case when SubString(SD2.D2_EMISSAO,7,2)=07 then SD2.D2_TOTAL end),0) "
cQuery+= "         , [D08]	= Isnull(sum(case when SubString(SD2.D2_EMISSAO,7,2)=08 then SD2.D2_TOTAL end),0) " 
cQuery+= "         , [D09]	= Isnull(sum(case when SubString(SD2.D2_EMISSAO,7,2)=09 then SD2.D2_TOTAL end),0) "
cQuery+= "         , [D10]	= Isnull(sum(case when SubString(SD2.D2_EMISSAO,7,2)=10 then SD2.D2_TOTAL end),0) "
cQuery+= "         , [D11]	= Isnull(sum(case when SubString(SD2.D2_EMISSAO,7,2)=11 then SD2.D2_TOTAL end),0) "
cQuery+= "         , [D12]	= Isnull(sum(case when SubString(SD2.D2_EMISSAO,7,2)=12 then SD2.D2_TOTAL end),0) "
cQuery+= "         , [D13]	= Isnull(sum(case when SubString(SD2.D2_EMISSAO,7,2)=13 then SD2.D2_TOTAL end),0) "
cQuery+= "         , [D14]	= Isnull(sum(case when SubString(SD2.D2_EMISSAO,7,2)=14 then SD2.D2_TOTAL end),0) "
cQuery+= "         , [D15]	= Isnull(sum(case when SubString(SD2.D2_EMISSAO,7,2)=15 then SD2.D2_TOTAL end),0) "
cQuery+= "         , [D16]	= Isnull(sum(case when SubString(SD2.D2_EMISSAO,7,2)=16 then SD2.D2_TOTAL end),0) "
cQuery+= "FROM SD2010 AS SD2 "
cQuery+= "JOIN SC5010 AS SC5 "
cQuery+= "ON  SD2.D2_FILIAL = SC5.C5_FILIAL "
cQuery+= "AND SD2.D2_PEDIDO = SC5.C5_NUM "
cQuery+= "JOIN SF4010 AS SF4 " 
cQuery+= "ON SD2.D2_FILIAL = SF4.F4_FILIAL "
cQuery+= "AND SD2.D2_TES = SF4.F4_CODIGO " 
cQuery+= "WHERE SF4.F4_DUPLIC = 'S' " 
cQuery+= "AND SD2.D2_EMISSAO >= '"+DTOS(mv_par01)+"' "
cQuery+= "AND SD2.D2_EMISSAO <= '"+DTOS(mv_par02)+"' "    
cQuery+= "AND SD2.D2_CF <> '5116' AND SD2.D2_CF <> '6116' "
cQuery+= "AND (SD2.D2_TIPO = 'N' OR SD2.D2_TIPO = 'C') "
cQuery+= "AND SC5.D_E_L_E_T_ <> '*' "   
cQuery+= "AND SD2.D_E_L_E_T_ <> '*' "
cQuery+= "AND SF4.D_E_L_E_T_ <> '*' "
cQuery+= "GROUP BY C5_XORIGEM, SubString(SD2.D2_EMISSAO,1,4) "
cQuery+= "ORDER BY C5_XORIGEM, SubString(SD2.D2_EMISSAO,1,4) "  

Memowrite("MFATR008_1.TXT",cQuery)
      
//+-----------------------
//| Cria indice temporario
//+-----------------------

cQuery2:= "SELECT  SC5.C5_XORIGEM, SubString(SD2.D2_EMISSAO,1,4) as ANO "
cQuery2+= "         , [D17]	= Isnull(sum(case when SubString(SD2.D2_EMISSAO,7,2)=17 then SD2.D2_TOTAL end),0) " 
cQuery2+= "         , [D18]	= Isnull(sum(case when SubString(SD2.D2_EMISSAO,7,2)=18 then SD2.D2_TOTAL end),0) " 
cQuery2+= "         , [D19]	= Isnull(sum(case when SubString(SD2.D2_EMISSAO,7,2)=19 then SD2.D2_TOTAL end),0) "
cQuery2+= "         , [D20]	= Isnull(sum(case when SubString(SD2.D2_EMISSAO,7,2)=20 then SD2.D2_TOTAL end),0) "
cQuery2+= "         , [D21]	= Isnull(sum(case when SubString(SD2.D2_EMISSAO,7,2)=21 then SD2.D2_TOTAL end),0) "
cQuery2+= "         , [D22]	= Isnull(sum(case when SubString(SD2.D2_EMISSAO,7,2)=22 then SD2.D2_TOTAL end),0) "
cQuery2+= "         , [D23]	= Isnull(sum(case when SubString(SD2.D2_EMISSAO,7,2)=23 then SD2.D2_TOTAL end),0) " 
cQuery2+= "         , [D24]	= Isnull(sum(case when SubString(SD2.D2_EMISSAO,7,2)=24 then SD2.D2_TOTAL end),0) "
cQuery2+= "         , [D25]	= Isnull(sum(case when SubString(SD2.D2_EMISSAO,7,2)=25 then SD2.D2_TOTAL end),0) "
cQuery2+= "         , [D26]	= Isnull(sum(case when SubString(SD2.D2_EMISSAO,7,2)=26 then SD2.D2_TOTAL end),0) "
cQuery2+= "         , [D27]	= Isnull(sum(case when SubString(SD2.D2_EMISSAO,7,2)=27 then SD2.D2_TOTAL end),0) "
cQuery2+= "         , [D28]	= Isnull(sum(case when SubString(SD2.D2_EMISSAO,7,2)=28 then SD2.D2_TOTAL end),0) "
cQuery2+= "         , [D29]	= Isnull(sum(case when SubString(SD2.D2_EMISSAO,7,2)=29 then SD2.D2_TOTAL end),0) "
cQuery2+= "         , [D30]	= Isnull(sum(case when SubString(SD2.D2_EMISSAO,7,2)=30 then SD2.D2_TOTAL end),0) "
cQuery2+= "         , [D31]	= Isnull(sum(case when SubString(SD2.D2_EMISSAO,7,2)=31 then SD2.D2_TOTAL end),0) "
cQuery2+= "FROM SD2010 AS SD2 "
cQuery2+= "JOIN SC5010 AS SC5 "
cQuery2+= "ON  SD2.D2_FILIAL = SC5.C5_FILIAL "
cQuery2+= "AND SD2.D2_PEDIDO = SC5.C5_NUM "
cQuery2+= "JOIN SF4010 AS SF4 " 
cQuery2+= "ON SD2.D2_FILIAL = SF4.F4_FILIAL "
cQuery2+= "AND SD2.D2_TES = SF4.F4_CODIGO " 
cQuery2+= "WHERE SF4.F4_DUPLIC = 'S' " 
cQuery2+= "AND SD2.D2_EMISSAO >= '"+DTOS(mv_par01)+"' "
cQuery2+= "AND SD2.D2_EMISSAO <= '"+DTOS(mv_par02)+"' " 
cQuery2+= "AND SD2.D2_CF <> '5116' AND SD2.D2_CF <> '6116' "
cQuery2+= "AND (SD2.D2_TIPO = 'N' OR SD2.D2_TIPO = 'C') "
cQuery2+= "AND SC5.D_E_L_E_T_ <> '*' "   
cQuery2+= "AND SD2.D_E_L_E_T_ <> '*' "
cQuery2+= "AND SF4.D_E_L_E_T_ <> '*' "
cQuery2+= "GROUP BY C5_XORIGEM, SubString(SD2.D2_EMISSAO,1,4) "
cQuery2+= "ORDER BY C5_XORIGEM, SubString(SD2.D2_EMISSAO,1,4) "
           
Memowrite("MFATR008_2.TXT",cQuery2)

//+------------------------+
//| Cria uma view no banco |
//+------------------------+

dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "TRB", .T., .F. )
dbSelectArea("TRB")
dbGoTop()
SetRegua( RecCount() )


dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery2), "TRD", .T., .F. )
dbSelectArea("TRD")
dbGoTop()
SetRegua( RecCount() )

                                             
//"SEGMENTO                Dia-01      Dia-02      Dia-03      Dia-04      Dia-05      Dia-06      Dia-07      Dia-08      Dia-09      Dia-10      Dia-11      Dia-12      Dia-13      Dia-14      Dia-15      Dia-16   "      
// XXXXXXXXXXXXXXX    9999,999.99 9999,999.99 9999,999.99 9999,999.
//99 9999,999.99 9999,999.99 9999,999.99 9999,999.99 9999,999.99 9999,999.99 9999,999.99 9999,999.99 9999,999.99 9999,999.99 9999,999.99 9999,999.99   "
// 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
//           1         2         3         4         5         6         7         8         9        10        11         12        13        14        15        16        17        18        19        20        21        22

//+---------------------+
//| Coluna de impressao |  
//+---------------------+
aAdd( aCol, 001 ) // 01
aAdd( aCol, 019 ) // 02
aAdd( aCol, 031 ) // 03
aAdd( aCol, 043 ) // 04
aAdd( aCol, 055 ) // 05
aAdd( aCol, 067 ) // 06
aAdd( aCol, 079 ) // 07
aAdd( aCol, 091 ) // 08
aAdd( aCol, 103 ) // 09
aAdd( aCol, 115 ) // 10
aAdd( aCol, 127 ) // 11
aAdd( aCol, 139 ) // 12
aAdd( aCol, 151 ) // 13
aAdd( aCol, 163 ) // 14
aAdd( aCol, 175 ) // 15
aAdd( aCol, 187 ) // 16
aAdd( aCol, 199 ) // 17

dbSelectArea("TRB")
While !Eof() .And. !lEnd 
   
  IncRegua()

   If Li > 55
      Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
   Endif

   DbSelectArea("TRB")
   
 	  Do Case
	     Case TRB->C5_XORIGEM = 'A' 
	            @ Li,aCol[01] PSAY 'AUTOMOTIVO' 
	     Case TRB->C5_XORIGEM = 'C' 
	            @ Li,aCol[01] PSAY 'CORPORATIVO'
	     Case TRB->C5_XORIGEM = 'V'
	            @ Li,aCol[01] PSAY 'VAREJO' 
	     Case TRB->C5_XORIGEM = 'M' 
	            @ Li,aCol[01] PSAY 'MULTLOCK CENTER'
	     Case TRB->C5_XORIGEM = 'T' 
	            @ Li,aCol[01] PSAY 'ASSISTENCIA TEC.' 
	     Case TRB->C5_XORIGEM = 'I' 
	            @ Li,aCol[01] PSAY 'INDUSTRIAL'  
	     Case TRB->C5_XORIGEM = 'B'            // INSERI O SEGMENTO CONSTRUTORA
	            @ Li,aCol[01] PSAY 'CONSTRUTORA'
	                 // BRUNO DATA 23-02-12 -----FIM.....
	     OtherWise
	            @ Li,aCol[01] PSAY 'OUTROS'           
	  EndCase
      @ Li, aCol[02] PSAY Transform(TRB->D01, "@E 9999,999.99")
      @ Li, aCol[03] PSAY Transform(TRB->D02, "@E 9999,999.99")
      @ Li, aCol[04] PSAY Transform(TRB->D03, "@E 9999,999.99")
      @ Li, aCol[05] PSAY Transform(TRB->D04, "@E 9999,999.99")
      @ Li, aCol[06] PSAY Transform(TRB->D05, "@E 9999,999.99")
      @ Li, aCol[07] PSAY Transform(TRB->D06, "@E 9999,999.99")
      @ Li, aCol[08] PSAY Transform(TRB->D07, "@E 9999,999.99")
      @ Li, aCol[09] PSAY Transform(TRB->D08, "@E 9999,999.99")
      @ Li, aCol[10] PSAY Transform(TRB->D09, "@E 9999,999.99")
      @ Li, aCol[11] PSAY Transform(TRB->D10, "@E 9999,999.99")
      @ Li, aCol[12] PSAY Transform(TRB->D11, "@E 9999,999.99")
      @ Li, aCol[13] PSAY Transform(TRB->D12, "@E 9999,999.99")
      @ Li, aCol[14] PSAY Transform(TRB->D13, "@E 9999,999.99")
      @ Li, aCol[15] PSAY Transform(TRB->D14, "@E 9999,999.99")
      @ Li, aCol[16] PSAY Transform(TRB->D15, "@E 9999,999.99")
      @ Li, aCol[17] PSAY Transform(TRB->D16, "@E 9999,999.99")
	  Li++

	  ndia01 += TRB->D01
	  ndia02 += TRB->D02
	  ndia03 += TRB->D03
	  ndia04 += TRB->D04
	  ndia05 += TRB->D05
	  ndia06 += TRB->D06
	  ndia07 += TRB->D07
	  ndia08 += TRB->D08
	  ndia09 += TRB->D09
	  ndia10 += TRB->D10
	  ndia11 += TRB->D11
	  ndia12 += TRB->D12
	  ndia13 += TRB->D13
	  ndia14 += TRB->D14
	  ndia15 += TRB->D15
	  ndia16 += TRB->D16
	  
	  DbSelectArea("TRB")
      dbskip()
        
 Enddo  

   Li++
   @ Li, 000 PSay Replicate("-",Limite)
   Li++
   @ Li, aCol[01] PSAY  "Total Diario ->"

   @ Li, aCol[02] PSAY Transform(ndia01, "@E 9999,999.99")
   @ Li, aCol[03] PSAY Transform(ndia02, "@E 9999,999.99")
   @ Li, aCol[04] PSAY Transform(ndia03, "@E 9999,999.99")
   @ Li, aCol[05] PSAY Transform(ndia04, "@E 9999,999.99")
   @ Li, aCol[06] PSAY Transform(ndia05, "@E 9999,999.99")
   @ Li, aCol[07] PSAY Transform(ndia06, "@E 9999,999.99")
   @ Li, aCol[08] PSAY Transform(ndia07, "@E 9999,999.99")
   @ Li, aCol[09] PSAY Transform(ndia08, "@E 9999,999.99")
   @ Li, aCol[10] PSAY Transform(ndia09, "@E 9999,999.99")
   @ Li, aCol[11] PSAY Transform(ndia10, "@E 9999,999.99")
   @ Li, aCol[12] PSAY Transform(ndia11, "@E 9999,999.99")
   @ Li, aCol[13] PSAY Transform(ndia12, "@E 9999,999.99")
   @ Li, aCol[14] PSAY Transform(ndia13, "@E 9999,999.99")                                                      
   @ Li, aCol[15] PSAY Transform(ndia14, "@E 9999,999.99")                                                      
   @ Li, aCol[16] PSAY Transform(ndia15, "@E 9999,999.99")                                                      
   @ Li, aCol[17] PSAY Transform(ndia16, "@E 9999,999.99")                                                      

   Li++
   @ Li, 000 PSay Replicate("-",Limite)
   Li++

 LI++
 LI++
 LI++
  // lEnd - aborta o relat๓rio atraves da tecla ESC
  DbSelectArea("TRD")
   Li++
   @ Li, 000 PSay Replicate("-",Limite)
   Li++
   @ Li,aCol[01] PSAY		"SEGMENTO                Dia-17     Dia-18      Dia-19      Dia-20      Dia-21      Dia-22      Dia-23      Dia-24      Dia-25      Dia-26      Dia-27      Dia-28      Dia-29      Dia-30      Dia-31"           
   LI++
   @ Li, 000 PSay Replicate("-",Limite)
   Li++
    While !Eof() .And. !lEnd  //&(cCampo) == cQuebra .And. !lEnd 

	  IncRegua()

   If Li > 55
      Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
   Endif

   DbSelectArea("TRD")

   
 	  Do Case
	     Case TRD->C5_XORIGEM = 'A' 
	            @ Li,aCol[01] PSAY 'AUTOMOTIVO' 
	     Case TRD->C5_XORIGEM = 'C' 
	            @ Li,aCol[01] PSAY 'CORPORATIVO'
	     Case TRD->C5_XORIGEM = 'V'
	            @ Li,aCol[01] PSAY 'VAREJO' 
	     Case TRD->C5_XORIGEM = 'M' 
	            @ Li,aCol[01] PSAY 'MULTLOCK CENTER'
	     Case TRD->C5_XORIGEM = 'T' 
	            @ Li,aCol[01] PSAY 'ASSISTENCIA TEC.' 
	     Case TRD->C5_XORIGEM = 'I' 
	            @ Li,aCol[01] PSAY 'INDUSTRIAL' 
	     Case TRD->C5_XORIGEM = 'B'          //INSERI O SEGMENTO CONSTRUTORA
	            @ Li,aCol[01] PSAY 'CONSTRUTORA'
	               // FIM --- 23-08-11-------------
	     OtherWise
	            @ Li,aCol[01] PSAY 'OUTROS'           
	  EndCase
    
      @ Li, aCol[02] PSAY Transform(TRD->D17, "@E 9999,999.99")
      @ Li, aCol[03] PSAY Transform(TRD->D18, "@E 9999,999.99")
      @ Li, aCol[04] PSAY Transform(TRD->D19, "@E 9999,999.99")
      @ Li, aCol[05] PSAY Transform(TRD->D20, "@E 9999,999.99")
      @ Li, aCol[06] PSAY Transform(TRD->D21, "@E 9999,999.99")
      @ Li, aCol[07] PSAY Transform(TRD->D22, "@E 9999,999.99")
      @ Li, aCol[08] PSAY Transform(TRD->D23, "@E 9999,999.99")
      @ Li, aCol[09] PSAY Transform(TRD->D24, "@E 9999,999.99")
      @ Li, aCol[10] PSAY Transform(TRD->D25, "@E 9999,999.99")
      @ Li, aCol[11] PSAY Transform(TRD->D26, "@E 9999,999.99")
      @ Li, aCol[12] PSAY Transform(TRD->D27, "@E 9999,999.99")
      @ Li, aCol[13] PSAY Transform(TRD->D28, "@E 9999,999.99")
      @ Li, aCol[14] PSAY Transform(TRD->D29, "@E 9999,999.99")
      @ Li, aCol[15] PSAY Transform(TRD->D30, "@E 9999,999.99")
      @ Li, aCol[16] PSAY Transform(TRD->D31, "@E 9999,999.99")
	  Li++
	  ndia17 += TRD->D17
	  ndia18 += TRD->D18
	  ndia19 += TRD->D19
	  ndia20 += TRD->D20
	  ndia21 += TRD->D21
	  ndia22 += TRD->D22
	  ndia23 += TRD->D23
	  ndia24 += TRD->D24
	  ndia25 += TRD->D25
	  ndia26 += TRD->D26
	  ndia27 += TRD->D27
	  ndia28 += TRD->D28
	  ndia29 += TRD->D29
	  ndia30 += TRD->D30
	  ndia31 += TRD->D31

	  DbSelectArea("TRD")
      dbskip()
/*
   	  Aadd(a_dados, {TRB->C5_XORIGEM, TRB->ANO, TRB->Janeiro, TRB->Fevereiro, TRB->Marco, TRB->Abril,;
  	  TRB->Maio, TRB->Junho, TRB->Julho, TRB->Agosto, TRB->Setembro, TRB->Outubro, TRB->Novembro,;
	  TRB->Dezembro})

	  DbSelectArea("TRB")
      dbskip()
  */      
	   
   Enddo
 
   Li++
   @ Li, 000 PSay Replicate("-",Limite)
   Li++
   @ Li, aCol[01] PSAY  "Total Diario ->"

   @ Li, aCol[02] PSAY Transform(ndia17, "@E 9999,999.99")
   @ Li, aCol[03] PSAY Transform(ndia18, "@E 9999,999.99")
   @ Li, aCol[04] PSAY Transform(ndia19, "@E 9999,999.99")
   @ Li, aCol[05] PSAY Transform(ndia20, "@E 9999,999.99")
   @ Li, aCol[06] PSAY Transform(ndia21, "@E 9999,999.99")
   @ Li, aCol[07] PSAY Transform(ndia22, "@E 9999,999.99")
   @ Li, aCol[08] PSAY Transform(ndia23, "@E 9999,999.99")
   @ Li, aCol[09] PSAY Transform(ndia24, "@E 9999,999.99")
   @ Li, aCol[10] PSAY Transform(ndia25, "@E 9999,999.99")
   @ Li, aCol[11] PSAY Transform(ndia26, "@E 9999,999.99")
   @ Li, aCol[12] PSAY Transform(ndia27, "@E 9999,999.99")
   @ Li, aCol[13] PSAY Transform(ndia28, "@E 9999,999.99")
   @ Li, aCol[14] PSAY Transform(ndia29, "@E 9999,999.99")                                                      
   @ Li, aCol[15] PSAY Transform(ndia30, "@E 9999,999.99")                                                      
   @ Li, aCol[16] PSAY Transform(ndia31, "@E 9999,999.99")                                                      

   Li++
   @ Li, 000 PSay Replicate("-",Limite)
   Li++

If lEnd
   @ Li, aCol[1] PSay cCancel
   Return
Endif
   
If Li <> 80
   Roda(cbCont,cbTxt,Tamanho)
Endif

dbSelectArea("TRB")
dbCloseArea()

dbSelectArea("TRD")
dbCloseArea()

If aReturn[5] == 1
   Set Printer TO
   dbCommitAll()
   Ourspool(wnrel)
EndIf

Ms_Flush()

//If msgYesNo("Deseja exportar para o excel?")
//	FGEN002(a_cmps, a_dados)
//EndIf

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
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	
	// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
	aAdd(aRegs,{cPerg,"01","Data Vendas de      ? ","","","MV_CH1","D",08,0,0,"G","","MV_PAR01","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{cPerg,"02","Data Vendas Ate     ? ","","","MV_CH2","D",08,0,0,"G","","MV_PAR02","","","","","","","","","","","","","","","","","","","","","","","","",""})

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