#include "Rwmake.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMFATR010  บAutor  ณJean Cavalcante     บ Data ณ  03/10/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑบDesc.     ณ Este relatorio imprimi os valores faturados por represen-  บฑฑ
ฑฑบ          ณ tante de venda mes a mes.                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Especifico NYTRON  -   www.actualtrend.com.br              บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function MFATR010()

Local cDesc1  	  := "Este relatorio ira imprimir os valores faturados"          
Local cDesc2  	  := "por segmento/loja de venda m๊s a m๊s"                      
Local cDesc3  	  := ""
Private cString  := "SH6"
Private Tamanho  := "G"
Private aReturn  := { "Zebrado",1,"Administracao",2,2,1,"",1 }
Private wnrel    := "MFATR010"
Private NomeProg := "MFATR010"
Private nLastKey := 0
Private Limite   := 220
Private cPerg    := "MFATR010b"
Private nTipo    := 0
Private cbCont   := 0
Private cbTxt    := "registro(s) lido(s)"
Private Li       := 80
Private m_pag    := 1
Private aOrd     := {} 
Private cabec1   :="SEGMENTO            CODIG/LOJA NOME                 UF PRACA              JANEIRO  FEVEREIRO     MARCO       ABRIL       MAIO      JUNHO      JULHO     AGOSTO   SETEMBRO    OUTUBRO   NOVEMBRO   DEZEMBRO   TOTAL (ANO)"
Private Cabec2   :="DE VENDA            CLIENTE    REDUZIDO                CIDADE" 		 	 		 
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

aAdd(a_cmps,{"SEGMENTO"	,"C",30,0})    
aAdd(a_cmps,{"CODIGO"	   	,"C",06,0})    
aAdd(a_cmps,{"LOJA"		    ,"C",02,0})
aAdd(a_cmps,{"RAZAO_SOC"	,"C",50,0})
aAdd(a_cmps,{"NOMEREDUZ"	,"C",30,0})
aAdd(a_cmps,{"ESTADO"	    ,"C",02,0})
aAdd(a_cmps,{"CIDADE"	    ,"C",35,0})
aAdd(a_cmps,{"JAN"			,"N",12,2})
aAdd(a_cmps,{"FEV"			,"N",12,2})
aAdd(a_cmps,{"MAR"	  		,"N",12,2})
aAdd(a_cmps,{"ABR"	  		,"N",12,2})
aAdd(a_cmps,{"MAI" 		 	,"N",12,2})
aAdd(a_cmps,{"JUN"			,"N",12,2})
aAdd(a_cmps,{"JUL"			,"N",12,2})
aAdd(a_cmps,{"AGO"			,"N",12,2})
aAdd(a_cmps,{"SET"			,"N",12,2})
aAdd(a_cmps,{"OUT"			,"N",12,2})
aAdd(a_cmps,{"NOV"			,"N",12,2})
aAdd(a_cmps,{"DEZ"			,"N",12,2})
aAdd(a_cmps,{"TOTAL_MERC"	,"N",12,2}) 
aAdd(a_cmps,{"JAN_IMPO"		,"N",12,2})
aAdd(a_cmps,{"FEV_IMPO"		,"N",12,2})
aAdd(a_cmps,{"MAR_IMPO"	  	,"N",12,2})
aAdd(a_cmps,{"ABR_IMPO"	  	,"N",12,2})
aAdd(a_cmps,{"MAI_IMPO" 	,"N",12,2})
aAdd(a_cmps,{"JUN_IMPO"		,"N",12,2})
aAdd(a_cmps,{"JUL_IMPO"		,"N",12,2})
aAdd(a_cmps,{"AGO_IMPO"		,"N",12,2})
aAdd(a_cmps,{"SET_IMPO"		,"N",12,2})
aAdd(a_cmps,{"OUT_IMPO"		,"N",12,2})
aAdd(a_cmps,{"NOV_IMPO"		,"N",12,2})
aAdd(a_cmps,{"DEZ_IMPO"		,"N",12,2})
aAdd(a_cmps,{"TOTAL_IMPO"	,"N",12,2}) 

//aAdd(aOrd, "Recurso")
//aAdd(aOrd, "C.Custo/OP")

#IFNDEF TOP
   MsgInfo("Nใo ้ possํvel executar este programa, estแ base de dados nใo ้ TopConnect")
   RETURN
#ENDIF

ValidPerg()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Variaveis utilizadas para parametros                         ณ
//ณ mv_par01              Data Vendas De    	                 ณ
//ณ mv_par02              Data Vendas At้       	             ณ
//ณ mv_par03              Cliente De ?                           ณ
//ณ mv_par04              Cliente Ate ?                          ณ
//ณ mv_par05              Representante	De ?      			     ณ
//ณ mv_par06              Representante Ate ?				     ณ
//ณ mv_par07              Estado De ?           	             ณ
//ณ mv_par08              Estado Ate ?	                         ณ
//ณ mv_par09              Apurar Valor ?	                     ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

//+-------------------------------------------------------------------------------+
//| Solicita ao usuario a parametrizacao do relatorio.                            |
//+-------------------------------------------------------------------------------+
Pergunte(cPerg,.F.)

Private Titulo   := "Rela็ใo de Faturamento por representante no periodo de " +Dtoc(MV_PAR01)+ " a "+Dtoc(MV_PAR02)+" - Filial: " +cFilant+ ""
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
local Total		:= 0      

local nTotlJanI := 0
local nTotlFevI := 0
local nTotlMarI := 0
local nTotlAbrI := 0
local nTotlMaiI := 0
local nTotlJunI := 0
local nTotlJulI := 0
local nTotlAgoI := 0
local nTotlSetI := 0
local nTotlOutI := 0
local nTotlNovI := 0
local nTotlDezI := 0   
local nTotlMesI := 0  
local nTotlGerI := 0   
local Total		:= 0      


Local cQuebra,cCampo,cMens
Local cIndex
Local nqtdtotal		:= 0

Private _aSaldoIni:={}
Private Titulo   	:= "Relat๓rio de faturamento por representante no periodo de " +Dtoc(MV_PAR01)+ " a "+Dtoc(MV_PAR02)+" - Filial: " +cFilant+ ""
//  +------------------------+
//  | Cria filtro temporario |
//  +------------------------+

cQuery:= "SELECT  SA1.A1_XORIGEM, SA1.A1_VEND, SD2.D2_CLIENTE,SD2.D2_LOJA, SA1.A1_NREDUZ, SA1.A1_MUN, SA1.A1_EST, SubString(SD2.D2_EMISSAO,1,4) as ANO "
cQuery+= "         , [JANEIRO]    = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=01 then SD2.D2_TOTAL end),0) " 
cQuery+= "         , [FEVEREIRO]  = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=02 then SD2.D2_TOTAL end),0) " 
cQuery+= "         , [MARCO]      = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=03 then SD2.D2_TOTAL end),0) " 
cQuery+= "         , [ABRIL]      = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=04 then SD2.D2_TOTAL end),0) " 
cQuery+= "         , [MAIO]       = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=05 then SD2.D2_TOTAL end),0) " 
cQuery+= "         , [JUNHO]      = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=06 then SD2.D2_TOTAL end),0) " 
cQuery+= "         , [JULHO]      = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=07 then SD2.D2_TOTAL end),0) " 
cQuery+= "         , [AGOSTO]     = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=08 then SD2.D2_TOTAL end),0) " 
cQuery+= "         , [SETEMBRO]   = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=09 then SD2.D2_TOTAL end),0) " 
cQuery+= "         , [OUTUBRO]    = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=10 then SD2.D2_TOTAL end),0) " 
cQuery+= "         , [NOVEMBRO]   = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=11 then SD2.D2_TOTAL end),0) " 
cQuery+= "         , [DEZEMBRO]   = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=12 then SD2.D2_TOTAL end),0) "
cQuery+= "         , [JANEIRO_IMP]    = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=01 then (SD2.D2_TOTAL+SD2.D2_VALIPI+SD2.D2_ICMSRET)end),0) " 
cQuery+= "         , [FEVEREIRO_IMP]  = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=02 then (SD2.D2_TOTAL+SD2.D2_VALIPI+SD2.D2_ICMSRET)end),0) "
cQuery+= "         , [MARCO_IMP]      = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=03 then (SD2.D2_TOTAL+SD2.D2_VALIPI+SD2.D2_ICMSRET)end),0) "
cQuery+= "         , [ABRIL_IMP]      = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=04 then (SD2.D2_TOTAL+SD2.D2_VALIPI+SD2.D2_ICMSRET)end),0) "
cQuery+= "         , [MAIO_IMP]       = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=05 then (SD2.D2_TOTAL+SD2.D2_VALIPI+SD2.D2_ICMSRET)end),0) "
cQuery+= "         , [JUNHO_IMP]      = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=06 then (SD2.D2_TOTAL+SD2.D2_VALIPI+SD2.D2_ICMSRET)end),0) "
cQuery+= "         , [JULHO_IMP]      = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=07 then (SD2.D2_TOTAL+SD2.D2_VALIPI+SD2.D2_ICMSRET)end),0) "
cQuery+= "         , [AGOSTO_IMP]     = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=08 then (SD2.D2_TOTAL+SD2.D2_VALIPI+SD2.D2_ICMSRET)end),0) "
cQuery+= "         , [SETEMBRO_IMP]   = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=09 then (SD2.D2_TOTAL+SD2.D2_VALIPI+SD2.D2_ICMSRET)end),0) "
cQuery+= "         , [OUTUBRO_IMP]    = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=10 then (SD2.D2_TOTAL+SD2.D2_VALIPI+SD2.D2_ICMSRET)end),0) "
cQuery+= "         , [NOVEMBRO_IMP]   = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=11 then (SD2.D2_TOTAL+SD2.D2_VALIPI+SD2.D2_ICMSRET)end),0) "
cQuery+= "         , [DEZEMBRO_IMP]   = Isnull(sum(case when SubString(SD2.D2_EMISSAO,5,2)=12 then (SD2.D2_TOTAL+SD2.D2_VALIPI+SD2.D2_ICMSRET)end),0) "
cQuery+= "FROM SD2010 AS SD2 " 
cQuery+= "JOIN SA1010 AS SA1 " 
cQuery+= "ON  SD2.D2_CLIENTE = SA1.A1_COD "
cQuery+= "AND SD2.D2_LOJA	 = SA1.A1_LOJA "
cQuery+= "JOIN SF4010 AS SF4 " 
cQuery+= "ON SD2.D2_FILIAL = SF4.F4_FILIAL "
cQuery+= "AND SD2.D2_TES = SF4.F4_CODIGO " 
cQuery+= "WHERE SF4.F4_DUPLIC = 'S' " 
cQuery+= "AND SF4.F4_FILIAL = '01' "
cQuery+= "AND SD2.D2_EMISSAO >= '"+DTOS(mv_par01)+"' "
cQuery+= "AND SD2.D2_EMISSAO <= '"+DTOS(mv_par02)+"' " 
cQuery+= "AND SD2.D2_FILIAL = '01' "
cQuery+= "AND SD2.D2_CLIENTE >= '"+mv_par03+"' "
cQuery+= "AND SD2.D2_CLIENTE <= '"+mv_par04+"' " 
cQuery+= "AND SA1.A1_VEND >= '"+mv_par05+"' "
cQuery+= "AND SA1.A1_VEND <= '"+mv_par06+"' " 
cQuery+= "AND SA1.A1_EST >= '"+mv_par07+"' "
cQuery+= "AND SA1.A1_EST <= '"+mv_par08+"' " 
cQuery+= "AND (SD2.D2_TIPO = 'N' OR SD2.D2_TIPO = 'C') "
cQuery+= "AND SA1.D_E_L_E_T_ <> '*' "   
cQuery+= "AND SD2.D_E_L_E_T_ <> '*' "
cQuery+= "AND SF4.D_E_L_E_T_ <> '*' "
cQuery+= "GROUP BY SA1.A1_XORIGEM, SA1.A1_VEND, SD2.D2_CLIENTE,SD2.D2_LOJA, SA1.A1_NREDUZ, SA1.A1_MUN, SA1.A1_EST, SubString(SD2.D2_EMISSAO,1,4) " 
cQuery+= "ORDER BY SD2.D2_CLIENTE, SD2.D2_LOJA "
      
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

//"SEGMENTO            CODIG/LOJA NOME                 UF PRACA              JANEIRO  FEVEREIRO     MARCO       ABRIL       MAIO      JUNHO      JULHO     AGOSTO   SETEMBRO    OUTUBRO   NOVEMBRO   DEZEMBRO   TOTAL (ANO)"   
//"DE VENDA            CLIENTE    REDUZIDO                CIDADE 		 	 		 
// XXXXXXXXXXXXXXXXXXX XXXXXX/XX  XXXXXXXXXXXXXXXXXXXX XX XXXXXXXXXXXXXXX 999,999.99 999,999.99 999,999.99 999,999.99 999,999.99 999,999.99 999,999.99 999,999.99 999,999.99 999,999.99 999,999.99 999,999.99  9,999,999.99
// 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
//           1         2         3         4         5         6         7         8         9        10        11         12        13        14        15        16        17        18        19        20        21        22

//+---------------------+
//| Coluna de impressao |  
//+---------------------+
aAdd( aCol, 001 ) // Representante 19
aAdd( aCol, 020 ) // Codigo/Loja   09
aAdd( aCol, 031 ) // Nome Reduzido 20
aAdd( aCol, 052 ) // Estado        02
aAdd( aCol, 055 ) // Cidade        15
aAdd( aCol, 071 ) // Janeiro   082
aAdd( aCol, 082 ) // Fevereiro 093
aAdd( aCol, 093 ) // Marco     63
aAdd( aCol, 104 ) // Abril     79
aAdd( aCol, 115 ) // Maio      95
aAdd( aCol, 126 ) // Junho    113
aAdd( aCol, 137 ) // Julho    127
aAdd( aCol, 148 ) // Agosto   141
aAdd( aCol, 159 ) // Setembro  159
aAdd( aCol, 170 ) // Outubro  175
aAdd( aCol, 181 ) // Novembro 191
aAdd( aCol, 192 ) // Dezembro 207
aAdd( aCol, 204 ) // Total Anual


While !Eof() .And. !lEnd 
   
nqtdprod := 0
nqtdperd := 0	

   If Li > 63
      Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
   Endif

   DbSelectArea("TRB")
   
  // cQuebra:=&(cCampo)
   
  // lEnd - aborta o relat๓rio atraves da tecla ESC
   While !Eof() .And. !lEnd  //&(cCampo) == cQuebra .And. !lEnd 
   nTotalmes := 0
   nTotalmeI := 0

      IncRegua()
      
      If Li > 63
         Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
      Endif

   	 Do Case
		Case TRB->A1_XORIGEM =  'A' 
			@ Li, aCol[01] PSAY "AUTOMOTIVO"
			cOrigem := "AUTOMOTIVO" 	
		Case TRB->A1_XORIGEM = 'C' 
			@ Li, aCol[01] PSAY "CORPORATIVO"
			cOrigem := "CORPORATIVO" 	
		Case TRB->A1_XORIGEM = 'V'
			@ Li, aCol[01] PSAY "VAREJO"
			cOrigem := "VAREJO" 	
		Case TRB->A1_XORIGEM = 'M' 
			@ Li, aCol[01] PSAY "MULTLOCK CENTER"
			cOrigem := "MULTLOCK CENTER" 	
		Case TRB->A1_XORIGEM = 'T' 
			@ Li, aCol[01] PSAY "ASSIST. TECNICA"
			cOrigem := "ASSIST. TECNICA" 	
		Case TRB->A1_XORIGEM = 'I' 
			@ Li, aCol[01] PSAY "INDUSTRIAL"
			cOrigem := 	"INDUSTRIAL"
		OtherWise
			@ Li, aCol[01] PSAY "SEM SEGMENTO"
			cOrigem := "SEM SEGMENTO" 	
	 EndCase

	  @ Li, aCol[02] PSAY TRB->D2_CLIENTE +"/"+TRB->D2_LOJA
	  @ Li, aCol[03] PSAY SUBSTR(TRB->A1_NREDUZ,1,20)
	  @ Li, aCol[04] PSAY TRB->A1_EST
	  @ Li, aCol[05] PSAY SUBSTR(TRB->A1_MUN,1,15)    
      @ Li, aCol[06] PSAY IIF(MV_PAR09 = 1,Transform(TRB->JANEIRO,		"@E 999,999.99"), Transform(TRB->JANEIRO_IMP,	"@E 999,999.99"))
      @ Li, aCol[07] PSAY IIF(MV_PAR09 = 1,Transform(TRB->FEVEREIRO,	"@E 999,999.99"), Transform(TRB->FEVEREIRO_IMP,	"@E 999,999.99"))
      @ Li, aCol[08] PSAY IIF(MV_PAR09 = 1,Transform(TRB->MARCO, 		"@E 999,999.99"), Transform(TRB->MARCO_IMP, 	"@E 999,999.99"))
      @ Li, aCol[09] PSAY IIF(MV_PAR09 = 1,Transform(TRB->ABRIL, 		"@E 999,999.99"), Transform(TRB->ABRIL_IMP, 	"@E 999,999.99"))
      @ Li, aCol[10] PSAY IIF(MV_PAR09 = 1,Transform(TRB->MAIO, 		"@E 999,999.99"), Transform(TRB->MAIO_IMP, 		"@E 999,999.99"))
      @ Li, aCol[11] PSAY IIF(MV_PAR09 = 1,Transform(TRB->JUNHO, 		"@E 999,999.99"), Transform(TRB->JUNHO_IMP, 	"@E 999,999.99"))
      @ Li, aCol[12] PSAY IIF(MV_PAR09 = 1,Transform(TRB->JULHO, 		"@E 999,999.99"), Transform(TRB->JULHO_IMP, 	"@E 999,999.99"))
      @ Li, aCol[13] PSAY IIF(MV_PAR09 = 1,Transform(TRB->AGOSTO, 		"@E 999,999.99"), Transform(TRB->AGOSTO_IMP, 	"@E 999,999.99"))
      @ Li, aCol[14] PSAY IIF(MV_PAR09 = 1,Transform(TRB->SETEMBRO, 	"@E 999,999.99"), Transform(TRB->SETEMBRO_IMP, 	"@E 999,999.99"))
      @ Li, aCol[15] PSAY IIF(MV_PAR09 = 1,Transform(TRB->OUTUBRO,		"@E 999,999.99"), Transform(TRB->OUTUBRO_IMP,	"@E 999,999.99"))
      @ Li, aCol[16] PSAY IIF(MV_PAR09 = 1,Transform(TRB->NOVEMBRO, 	"@E 999,999.99"), Transform(TRB->NOVEMBRO_IMP,	"@E 999,999.99"))
      @ Li, aCol[17] PSAY IIF(MV_PAR09 = 1,Transform(TRB->DEZEMBRO, 	"@E 999,999.99"), Transform(TRB->DEZEMBRO_IMP, 	"@E 999,999.99"))

      nTotalJan += TRB->JANEIRO  
      nTotalFev += TRB->FEVEREIRO  
      nTotalMar += TRB->MARCO   
      nTotalAbr += TRB->ABRIL   
      nTotalMai += TRB->MAIO    
      nTotalJun += TRB->JUNHO    
      nTotalJul += TRB->JULHO   
      nTotalAgo += TRB->AGOSTO   
      nTotalSet += TRB->SETEMBRO 
      nTotalOut += TRB->OUTUBRO 
      nTotalNov += TRB->NOVEMBRO
      nTotalDez += TRB->DEZEMBRO 
      
      nTotlJanI += TRB->JANEIRO_IMP  
      nTotlFevI += TRB->FEVEREIRO_IMP  
      nTotlMarI += TRB->MARCO_IMP   
      nTotlAbrI += TRB->ABRIL_IMP   
      nTotlMaiI += TRB->MAIO_IMP    
      nTotlJunI += TRB->JUNHO_IMP    
      nTotlJulI += TRB->JULHO_IMP   
      nTotlAgoI += TRB->AGOSTO_IMP   
      nTotlSetI += TRB->SETEMBRO_IMP 
      nTotlOutI += TRB->OUTUBRO_IMP 
      nTotlNovI += TRB->NOVEMBRO_IMP
      nTotlDezI += TRB->DEZEMBRO_IMP 

      
	  nTotalmes := (TRB->Janeiro+TRB->Fevereiro+TRB->Marco+TRB->Abril +TRB->Maio+TRB->Junho+TRB->Julho+TRB->Agosto+TRB->Setembro+TRB->Outubro+TRB->Novembro+TRB->Dezembro)
	  nTotalmesI := (TRB->Janeiro_IMP+TRB->Fevereiro_IMP+TRB->Marco_IMP+TRB->Abril_IMP+TRB->Maio_IMP+TRB->Junho_IMP+TRB->Julho_IMP+TRB->Agosto_IMP+;
	  				 TRB->Setembro_IMP+TRB->Outubro_IMP+TRB->Novembro_IMP+TRB->Dezembro_IMP)

      nTotalGer += nTotalmes 
      
	  @ Li, aCol[18] PSAY Transform(nTotalmes, "@E 9,999,999.99")     
	  

      Li++

   	  Aadd(a_dados, {cOrigem, TRB->D2_CLIENTE,TRB->D2_LOJA, GetAdvFval("SA1", "A1_NOME", xFilial("SA1")+TRB->D2_CLIENTE+TRB->D2_LOJA,1,"NAO/LOCALIZADO"),TRB->A1_NREDUZ, TRB->A1_EST,; 
					TRB->A1_MUN, TRB->Janeiro, TRB->Fevereiro, TRB->Marco, TRB->Abril, TRB->Maio, TRB->Junho, TRB->Julho, TRB->Agosto, TRB->Setembro, TRB->Outubro, TRB->Novembro,TRB->Dezembro,nTotalmes,;
               	    TRB->Janeiro_IMP, TRB->Fevereiro_IMP, TRB->Marco_IMP, TRB->Abril_IMP, TRB->Maio_IMP, TRB->Junho_IMP, TRB->Julho_IMP, TRB->Agosto_IMP,;
                	TRB->Setembro_IMP, TRB->Outubro_IMP, TRB->Novembro_IMP,TRB->Dezembro_IMP,nTotalmesI}) //inseri TRB->Total
                                                     
      
	  DbSelectArea("TRB")
      dbskip()
	  
   Enddo

   Li++
   @ Li, 000 PSay Replicate("-",Limite)
   Li++
   @ Li, aCol[01] PSAY "Total Janeiro..: " + Transform(nTotalJan, "@E 9,999,999.99")
   Li++
   @ Li, aCol[01] PSAY "Total Fevereiro: " + Transform(nTotalFev, "@E 9,999,999.99")
   Li++
   @ Li, aCol[01] PSAY "Total Marco....: " + Transform(nTotalMar, "@E 9,999,999.99")
   Li++
   @ Li, aCol[01] PSAY "Total Abril....: " + Transform(nTotalAbr, "@E 9,999,999.99")
   Li++
   @ Li, aCol[01] PSAY "Total Maio.....: " + Transform(nTotalMai, "@E 9,999,999.99")
   Li++
   @ Li, aCol[01] PSAY "Total Junho....: " + Transform(nTotalJun, "@E 9,999,999.99")
   Li++
   @ Li, aCol[01] PSAY "Total Julho....: " + Transform(nTotalJul, "@E 9,999,999.99")
   Li++
   @ Li, aCol[01] PSAY "Total Agosto...: " + Transform(nTotalAgo, "@E 9,999,999.99")
   Li++
   @ Li, aCol[01] PSAY "Total Setembro.: " + Transform(nTotalSet, "@E 9,999,999.99")
   Li++
   @ Li, aCol[01] PSAY "Total Outubro..: " + Transform(nTotalOut, "@E 9,999,999.99")
   Li++
   @ Li, aCol[01] PSAY "Total Novembro.: " + Transform(nTotalNov, "@E 9,999,999.99")
   Li++
   @ Li, aCol[01] PSAY "Total Dezembro.: " + Transform(nTotalDez, "@E 9,999,999.99") 
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
//ณ mv_par01              Data Vendas De    	                 ณ
//ณ mv_par02              Data Vendas At้       	             ณ
//ณ mv_par03              Cliente De ?                           ณ
//ณ mv_par04              Cliente Ate ?                          ณ
//ณ mv_par05              Representante	De ?      			     ณ
//ณ mv_par06              Representante Ate ?				     ณ
//ณ mv_par07              Estado De ?           	             ณ
//ณ mv_par08              Estado Ate ?	                         ณ
//ณ mv_par09              Apurar Valor ?	                     ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	
	// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
	aAdd(aRegs,{cPerg,"01","Data Vendas de      ? ","","","MV_CH1","D",08,0,0,"G","","MV_PAR01","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{cPerg,"02","Data Vendas Ate     ? ","","","MV_CH2","D",08,0,0,"G","","MV_PAR02","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{cPerg,"03","Cliente de          ? ","","","MV_CH3","C",06,0,0,"G","","MV_PAR03","","","","","","","","","","","","","","","","","","","","","","","","","SA1"})
	aAdd(aRegs,{cPerg,"04","Cliente Ate         ? ","","","MV_CH4","C",06,0,0,"G","","MV_PAR04","","","","","","","","","","","","","","","","","","","","","","","","","SA1"})
	aAdd(aRegs,{cPerg,"05","Representante De    ? ","","","MV_CH5","C",06,0,0,"G","","MV_PAR05","","","","","","","","","","","","","","","","","","","","","","","","","SA3"})
	aAdd(aRegs,{cPerg,"06","Representante Ate   ? ","","","MV_CH6","C",06,0,0,"G","","MV_PAR06","","","","","","","","","","","","","","","","","","","","","","","","","SA3"})
	aAdd(aRegs,{cPerg,"07","Estado De           ? ","","","MV_CH7","C",02,0,0,"G","","MV_PAR07","","","","","","","","","","","","","","","","","","","","","","","","","12"})
	aAdd(aRegs,{cPerg,"08","Estado Ate          ? ","","","MV_CH8","C",02,0,0,"G","","MV_PAR08","","","","","","","","","","","","","","","","","","","","","","","","","12"})
	aAdd(aRegs,{cPerg,"09","Apurar Valor        ? ","","","MV_CH9","N",01,0,1,"C","","MV_PAR09","Mercadoria","","","","","Impostos","","","","","","","","","","","","","","","","","","",""})

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
