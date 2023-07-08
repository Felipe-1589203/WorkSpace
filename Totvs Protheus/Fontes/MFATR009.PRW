#include "Rwmake.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMFATR009  บAutor  ณMauricio Nasser     บ Data ณ  31/08/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑบDesc.     ณ Este relatorio imprimi os valores faturados por cliente.   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Especifico MULTLOCK  -   www.actualtrend.com.br            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function MFATR009()

Local cDesc1  	  := "Este relatorio ira imprimir os valores faturados por cliente"          
Local cDesc2  	  := ""                      
Local cDesc3  	  := ""
Private cString  := "SH6"
Private Tamanho  := "G"
Private aReturn  := { "Zebrado",1,"Administracao",2,2,1,"",1 }
Private wnrel    := "MFATR009"
Private NomeProg := "MFATR009"
Private nLastKey := 0
Private Limite   := 220
Private cPerg    := "MFATR009b"
Private nTipo    := 0
Private cbCont   := 0
Private cbTxt    := "registro(s) lido(s)"
Private Cabec1   := ""
Private Cabec2   := ""
Private Li       := 80
Private m_pag    := 1
Private aOrd     := {}
Private cabec1   := "" //"NOME DO                                                                     PRODUTO                                                 QUANTIDADE      VALOR          "       
Private Cabec2   := "" //"CLIENTE                                                           LOJA                                                                                             "  
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

Private Titulo   := "Rela็ใo de Faturamento por Cliente no periodo de " +Dtoc(MV_PAR01)+ " a "+Dtoc(MV_PAR02)+" - Filial: " +cFilant+ ""
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
Local cQry          := ""
Local aCol      	:= {}
Local aSubTotal	:= {}
Local cOldSeg   :=""
Local cOldClient:=""
Local nTotalCli := 0
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
local nFlag     := 0
local nAuto     := 0
local nCorp     := 0
local nVarj     := 0
local nMcet     := 0
local nAsTc     := 0
local nInd      := 0 
local nCons     := 0  //inseri 
local nOtr      := 0
local nTotalSeg := 0


Local cQuebra,cCampo,cMens
Local cIndex
Local nqtdtotal		:= 0
Local nQtdPerda		:= 0
Local nRPNC			:= 0

Private _aSaldoIni:={}
Private Titulo   	:= "Relat๓rio de faturamento por Cliente no periodo de " +Dtoc(MV_PAR01)+ " a "+Dtoc(MV_PAR02)+" - Filial: " +cFilant+ ""
//  +---------------------------+
//  | Query Relatorio Analitico |
//  +---------------------------+

cQuery:= "SELECT D2_CLIENTE 'Cliente', D2_LOJA 'Loja', C5_XORIGEM 'Segmento', D2_COD 'Produto', D2_DOC, D2_SERIE, SUM(D2_QUANT) 'Quantidade', SUM(D2_TOTAL) 'Total'" 
cQuery+= " FROM SD2010 SD2 JOIN SF4010 SF4 ON SD2.D2_TES = SF4.F4_CODIGO"
cQuery+= " JOIN SC5010 SC5 ON SC5.C5_NUM = SD2.D2_PEDIDO"
cQuery+= " WHERE D2_EMISSAO >= '"+DTOS(mv_par01)+"' AND D2_EMISSAO <= '"+DTOS(mv_par02)+"'"
cQuery+= " AND F4_DUPLIC = 'S' AND SD2.D_E_L_E_T_ <> '*' AND SF4.D_E_L_E_T_ <> '*' AND SC5.D_E_L_E_T_ <> '*'"
cQuery+= " AND (SD2.D2_TIPO = 'N' OR SD2.D2_TIPO = 'C') AND"
cQuery+= " D2_CLIENTE >= '"+mv_par04+"' AND D2_CLIENTE <= '"+mv_par05+"' AND"
cQuery+= " D2_COD >= '"+mv_par06+"' AND D2_COD <= '"+mv_par07+"' AND"
cQuery+= " C5_XORIGEM >='"+mv_par08+"' AND C5_XORIGEM <='"+mv_par09+"'"
cQuery+= " GROUP BY D2_CLIENTE, D2_LOJA, D2_COD, D2_DOC, D2_SERIE, C5_XORIGEM ORDER BY D2_CLIENTE;"

//  +---------------------------+
//  | Query Relatorio Sintetico |
//  +---------------------------+

cQry:="SELECT D2_CLIENTE 'Cliente', D2_LOJA 'Loja', C5_XORIGEM 'Segmento', D2_DOC, D2_SERIE, SUM(D2_TOTAL) 'Total' "
cQry+=" FROM SD2010 SD2 JOIN SF4010 SF4 ON SD2.D2_TES = SF4.F4_CODIGO"
cQry+=" JOIN SC5010 SC5 ON SC5.C5_NUM = SD2.D2_PEDIDO"
cQry+=" WHERE D2_EMISSAO >= '"+DTOS(mv_par01)+"' AND D2_EMISSAO <= '"+DTOS(mv_par02)+"'"
cQry+=" AND F4_DUPLIC = 'S' AND SD2.D_E_L_E_T_ <> '*' AND SF4.D_E_L_E_T_ <> '*' AND SC5.D_E_L_E_T_ <> '*'"
cQry+=" AND (SD2.D2_TIPO = 'N' OR SD2.D2_TIPO = 'C') AND"
cQry+=" D2_CLIENTE >= '"+mv_par04+"' AND D2_CLIENTE <= '"+mv_par05+"' AND"
cQry+=" D2_COD >= '"+mv_par06+"' AND D2_COD <= '"+mv_par07+"' AND"
cQry+=" C5_XORIGEM >='"+mv_par08+"' AND C5_XORIGEM <='"+mv_par09+"'"
cQry+=" GROUP BY D2_CLIENTE, D2_LOJA, C5_XORIGEM,D2_DOC, D2_SERIE ORDER BY C5_XORIGEM, D2_CLIENTE;"
      
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

dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "TRC", .T., .F. )
dbSelectArea("TRC")
dbGoTop()
SetRegua( RecCount() )


dbUseArea( .T., "TOPCONN", TcGenQry(,,cQry), "QRR", .T., .F. )
dbSelectArea("QRR")
dbGoTop()
SetRegua( RecCount() )


//+-----------+
//  Analatico |
//+-----------+

//"NOME DO CLIENTE                                                               SEGMENTO                 COD - PRODUTO                                                    QUANTIDADE             VALOR      "  
//"    
// XXXXXX/XX - xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx      XXXXXXXXXXXXXXXXXXX      xxxxxx - xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx      9,999,999.99    9,999,999.99
// 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
//           1         2         3         4         5         6         7         8         9        10        11         12        13        14        15        16        17        18        19        20        21        22


//+-----------+
//  Sintetico |                                       XXXXXXXXXXXXXXXXXXX
//+-----------+
//"SEGMENTO                  NOME DO CLIENTE                                                  CODIGO\LOJA       TOTAL FATURADO"  
//"                                                                  
// XXXXXXXXXXXXXXXXXXX       xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx       XXXXXX/XX         9,999,999.99
// 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
//           1         2         3         4         5         6         7         8         9        10        11         12        13        14        15        16        17        18        19        20        21        22


//+---------------------+
//| Coluna de impressao |  
//+---------------------+
aAdd( aCol, 001 ) // CLIENTE
aAdd( aCol, 078 ) // SEGMENTO
aAdd( aCol, 103 ) // PRODUTO
aAdd( aCol, 168 ) // QUANTIDADE
aAdd( aCol, 184 ) // VALOR

While !Eof() .And. !lEnd 
   
nqtdprod := 0
nqtdperd := 0


if MV_PAR03 == 1
   Cabec1   := ""
   Cabec2   := ""  
   
   aAdd(a_cmps,{"Cliente"			,"C",40,0})    
   aAdd(a_cmps,{"Loja"	      		,"C",04,0})    
   aAdd(a_cmps,{"Produto"			,"C",40,0})
   aAdd(a_cmps,{"Quantidade"		,"N",10,0})
   aAdd(a_cmps,{"Total"	  	     	,"N",12,2})
                               
else

   Cabec1   :="SEGMENTO                  NOME DO CLIENTE                                                  CODIGO\LOJA       TOTAL FATURADO          NOTA FISCAL"  
   Cabec2   := ""
   Tamanho  := "M"
   aAdd(a_cmps,{"Segmento"			,"C",4,0})    
   aAdd(a_cmps,{"Cliente"	   		,"C",40,0})    
   aAdd(a_cmps,{"Codigo"			,"C",40,0})
   aAdd(a_cmps,{"Loja"				,"C",40,0})
   aAdd(a_cmps,{"Valor"		        ,"N",12,2})
   
endif	

   If Li > 55
      Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
   Endif

   DbSelectArea("TRC")
   
  // cQuebra:=&(cCampo)
   
  // lEnd - aborta o relat๓rio atraves da tecla ESC
  
  
   While !Eof() .And. !lEnd  //&(cCampo) == cQuebra .And. !lEnd 

      IncRegua()
                     
      If Li > 55
         Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
      Endif
      
      if MV_PAR03 == 2
      //--------------+
      //   Sintetico  |
      //--------------+
            if nFlag == 0
               dbSelectArea("QRR")
               dbGoTop()
               SetRegua( RecCount() )
            endIf 
            if cOldSeg <> QRR->Segmento .and. nFlag == 1
              @ Li, 000 PSay Replicate("-",Limite)
               Li++                        
               @ Li, 000 Psay " TOTAL"
               @ Li, 111 PSAY RTrim(Transform(nTotalSeg, "@E 9,999,999.99"))
               Li++
               @ Li, 000 PSay Replicate("-",Limite)
               Li++
               
               Do Case
            Case cOldSeg =  'A' 
               nAuto     := nTotalSeg
               nTotalSeg:=0 
             Case cOldSeg = 'C' 
               nCorp     := nTotalSeg
               nTotalSeg:=0
             Case cOldSeg = 'V'
               nVarj     := nTotalSeg
               nTotalSeg:=0 
             Case cOldSeg = 'M' 
               nMcet     := nTotalSeg
               nTotalSeg:=0
             Case cOldSeg = 'T' 
               nAsTc     := nTotalSeg
               nTotalSeg:=0 
             Case cOldSeg = 'I' 
               nInd     := nTotalSeg
               nTotalSeg:=0    
             Case cOldSeg = 'B'      //INSERI
               nCons     := nTotalSeg 
               nTotalSeg:=0          //fim---
             OtherWise
               nOtr     := nTotalSeg
               nTotalSeg:=0           
         EndCase
      
               
            endIf
            
           Do Case
            Case QRR->Segmento =  'A' 
               @ Li,000 PSAY ' AUTOMOTIVO'
               @ Li,026 PSAY Posicione("SA1",1,xFilial("SA1")+QRR->Cliente,"A1_NOME")
               @ Li,093 PSAY QRR->Cliente+'/'+QRR->Loja
               @ Li,111 PSAY RTrim(Transform(QRR->Total, "@E 9,999,999.99")) 
               @ Li,133 PSAY QRR->D2_DOC+'/'+QRR->D2_SERIE

             Case QRR->Segmento = 'C' 
               @ Li,000 PSAY ' CORPORATIVO'
               @ Li,026 PSAY Posicione("SA1",1,xFilial("SA1")+QRR->Cliente,"A1_NOME")
               @ Li,093 PSAY QRR->Cliente+'/'+QRR->Loja
               @ Li,111 PSAY RTrim(Transform(QRR->Total, "@E 9,999,999.99"))
               @ Li,133 PSAY QRR->D2_DOC+'/'+QRR->D2_SERIE
             Case QRR->Segmento = 'V'
               @ Li,000 PSAY ' VAREJO'
               @ Li,026 PSAY Posicione("SA1",1,xFilial("SA1")+QRR->Cliente,"A1_NOME")
               @ Li,093 PSAY QRR->Cliente+'/'+QRR->Loja
               @ Li,111 PSAY RTrim(Transform(QRR->Total, "@E 9,999,999.99")) 
               @ Li,133 PSAY QRR->D2_DOC+'/'+QRR->D2_SERIE
             Case QRR->Segmento = 'M' 
               @ Li,000 PSAY ' MULTLOCK CENTER'
               @ Li,026 PSAY Posicione("SA1",1,xFilial("SA1")+QRR->Cliente,"A1_NOME")
               @ Li,093 PSAY QRR->Cliente+'/'+QRR->Loja
               @ Li,111 PSAY RTrim(Transform(QRR->Total, "@E 9,999,999.99"))
               @ Li,133 PSAY QRR->D2_DOC+'/'+QRR->D2_SERIE
             Case QRR->Segmento = 'T' 
               @ Li,000 PSAY ' ASSISTENCIA TECNICA'
               @ Li,026 PSAY Posicione("SA1",1,xFilial("SA1")+QRR->Cliente,"A1_NOME")
               @ Li,093 PSAY QRR->Cliente+'/'+QRR->Loja
               @ Li,111 PSAY RTrim(Transform(QRR->Total, "@E 9,999,999.99")) 
               @ Li,133 PSAY QRR->D2_DOC+'/'+QRR->D2_SERIE
             Case QRR->Segmento = 'I' 
               @ Li,000 PSAY ' INDUSTRIAL'
               @ Li,026 PSAY Posicione("SA1",1,xFilial("SA1")+QRR->Cliente,"A1_NOME")
               @ Li,093 PSAY QRR->Cliente+'/'+QRR->Loja
               @ Li,111 PSAY RTrim(Transform(QRR->Total, "@E 9,999,999.99"))
               @ Li,133 PSAY QRR->D2_DOC+'/'+QRR->D2_SERIE  
             Case QRR->Segmento = 'B'      //	INSERI O SEGMENTO CONSTRUTORA ANDRE
               @ Li,000 PSAY ' CONSTRUTORA'
               @ Li,026 PSAY Posicione("SA1",1,xFilial("SA1")+QRR->Cliente,"A1_NOME")
               @ Li,093 PSAY QRR->Cliente+'/'+QRR->Loja
               @ Li,111 PSAY RTrim(Transform(QRR->Total, "@E 9,999,999.99"))
               @ Li,133 PSAY QRR->D2_DOC+'/'+QRR->D2_SERIE //fim--------------------
             OtherWise
               @ Li,000 PSAY ' OUTROS'
               @ Li,026 PSAY Posicione("SA1",1,xFilial("SA1")+QRR->Cliente,"A1_NOME")
               @ Li,093 PSAY QRR->Cliente+'/'+QRR->Loja
               @ Li,111 PSAY RTrim(Transform(QRR->Total, "@E 9,999,999.99"))           
               @ Li,133 PSAY QRR->D2_DOC+'/'+QRR->D2_SERIE
             EndCase
             Li++
               
         nFlag:=1
         cOldSeg:= QRR->Segmento
         nTotalSeg+=QRR->Total 
         
         Aadd(a_dados, {QRR->Segmento,Posicione("SA1",1,xFilial("SA1")+QRR->Cliente,"A1_NOME"),QRR->Cliente, QRR->Loja,QRR->Total})           
      
        dbskip()
        
//--------------+
//   Analitico  |
//--------------+    

      else 
        
         if cOldClient <> Posicione("SA1",1,xFilial("SA1")+TRC->Cliente,"A1_NOME") 
            Li++
            @ Li, 000 PSay Replicate("-",Limite)
            Li++      
            @ Li, aCol[01] PSAY 'NF: '+TRC->D2_DOC+'/'+TRC->D2_SERIE+' Cliente: '+TRC->Cliente+'/'+TRC->Loja+ '-'+Substr(Posicione("SA1",1,xFilial("SA1")+TRC->Cliente,"A1_NOME"),1,30)
            @ Li, aCol[02] PSAY "Segmento "
            @ Li, aCol[03] PSAY "Cod - Produto"
            @ Li, aCol[04] PSAY "  Quantidade"
            @ Li, aCol[05] PSAY "       Valor"
            Li++
            @ Li, 000 PSay Replicate("-",Limite)
            Li++
         endif
      
         nTotalCli+=TRC->Total
         @ Li, aCol[03] PSAY RTrim(TRC->Produto)+' - '+Posicione("SB1",1,xFilial("SB1")+TRC->Produto,"B1_DESC")
         @ Li, aCol[04] PSAY RTrim(Transform(TRC->Quantidade, "@E 9,999,999.99"))
         @ Li, aCol[05] PSAY RTrim(Transform(TRC->Total, "@E 9,999,999.99"))
         
         Do Case
            Case TRC->Segmento =  'A' 
               @ Li,aCol[02] PSAY ' AUTOMOTIVO' 
             Case TRC->Segmento = 'C' 
               @ Li,aCol[02] PSAY ' CORPORATIVO'
             Case TRC->Segmento = 'V'
               @ Li,aCol[02] PSAY ' VAREJO' 
             Case TRC->Segmento = 'M' 
               @ Li,aCol[02] PSAY ' MULTLOCK CENTER'
             Case TRC->Segmento = 'T' 
               @ Li,aCol[02] PSAY ' ASSISTENCIA TECNICA' 
             Case TRC->Segmento = 'I' 
               @ Li,aCol[02] PSAY ' INDUSTRIAL'  
             Case TRC->Segmento = 'B'           //INSERI
               @ Li,aCol[02] PSAY ' CONSTRUTORA' //------
             OtherWise
               @ Li,aCol[02] PSAY ' OUTROS'           
         EndCase
      
      
         Li++
         cOldClient:= Posicione("SA1",1,xFilial("SA1")+TRC->Cliente,"A1_NOME")
      
         Aadd(a_dados, {Posicione("SA1",1,xFilial("SA1")+TRC->Cliente,"A1_NOME"), TRC->Loja, Posicione("SB1",1,xFilial("SB1")+TRC->Produto,"B1_DESC"), TRC->Quantidade, TRC->Total})      
      
        dbskip()       
 
        if cOldClient <> Posicione("SA1",1,xFilial("SA1")+TRC->Cliente,"A1_NOME")
         Li++
         @ Li, aCol[05] PSAY "----------------------"
         Li++
         @ Li, aCol[05] PSAY "  "+"TOTAL "+Transform(nTotalCli, "@E 9,999,999.99")
         nTotalCli:=0
         Li++
       endif
     endif
   Enddo
  
   if nFlag == 1
   Li++
   @ Li, 000 PSay Replicate("-",Limite)
   Li++
   @ Li, 000 Psay " TOTAL"
   @ Li, 111 PSAY RTrim(Transform(nTotalSeg, "@E 9,999,999.99"))
   Li++
   @ Li, 000 PSay Replicate("-",Limite)
   Li++
     
   Do Case
            Case cOldSeg =  'A' 
               nAuto     := nTotalSeg
               nTotalSeg:=0 
             Case cOldSeg = 'C' 
               nCorp     := nTotalSeg
               nTotalSeg:=0
             Case cOldSeg = 'V'
               nVarj     := nTotalSeg
               nTotalSeg:=0 
             Case cOldSeg = 'M' 
               nMcet     := nTotalSeg
               nTotalSeg:=0
             Case cOldSeg = 'T' 
               nAsTc     := nTotalSeg
               nTotalSeg:=0 
             Case cOldSeg = 'I' 
               nInd     := nTotalSeg
               nTotalSeg:=0  
             Case cOldSeg = 'B'      //INSERI
               nCons     := nTotalSeg
               nTotalSeg:=0        //--------
             OtherWise
               nOtr     := nTotalSeg
               nTotalSeg:=0           
         EndCase
     
   Li++
   @ Li, 000 PSay Replicate("-",Limite)
   Li++
   @ Li, 051 PSAY "RESUMO DO RELATำRIO"
                    
   Li++
   @ Li, 000 PSay Replicate("-",Limite)
   Li++ 
   @ Li, 000 Psay "SEGMENTO"
   @ Li, 111 PSAY "      VALOR"
   Li++
   @ Li, 000 PSay Replicate("-",Limite)
   Li++
   @ Li, 000 Psay "AUTOMOTIVO"
   @ Li, 111 PSAY RTrim(Transform(nAuto, "@E 9,999,999.99"))
   Li++
   @ Li, 000 Psay "CORPORATIVO"
   @ Li, 111 PSAY RTrim(Transform(nCorp, "@E 9,999,999.99"))
   Li++
   @ Li, 000 Psay "VAREJO"
   @ Li, 111 PSAY RTrim(Transform(nVarj, "@E 9,999,999.99"))
   Li++
   @ Li, 000 Psay "MUL-T-LOCK CENTER"
   @ Li, 111 PSAY RTrim(Transform(nMcet, "@E 9,999,999.99"))
   Li++
   @ Li, 000 Psay "ASSISTENCIA TECNICA"
   @ Li, 111 PSAY RTrim(Transform(nAsTc, "@E 9,999,999.99"))
   Li++
   @ Li, 000 Psay "INDUSTRIAL"
   @ Li, 111 PSAY RTrim(Transform(nInd, "@E 9,999,999.99"))
   Li++ 
   @ Li, 000 Psay "CONSTRUTORA" //INSERI
   @ Li, 111 PSAY RTrim(Transform(nInd, "@E 9,999,999.99"))
   Li++       //FIM---------------------
   @ Li, 000 Psay "OUTROS"
   @ Li, 111 PSAY RTrim(Transform(nOtr, "@E 9,999,999.99"))
   Li++
    @ Li, 000 PSay Replicate("-",Limite)
   Li++
    @ Li, 000 Psay "TOTAL GERAL"
    @ Li, 111 PSAY RTrim(Transform(nAuto+nCorp+nVarj+nMcet+nAsTc+nInd+nCons+nOtr, "@E 9,999,999.99"))
    Li++
    @ Li, 000 PSAY Replicate("-",Limite)                              
   endIf

Enddo


    

If lEnd
   @ Li, aCol[1] PSay cCancel
   Return
Endif
   
If Li <> 80
   Roda(cbCont,cbTxt,Tamanho)
Endif

dbSelectArea("TRC")
dbCloseArea()

dbSelectArea("QRR")
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
//ณ mv_par05              OP De		 ?                           ณ 
//ณ mv_par06              OP Ate     ?		  				     ณ
//ณ mv_par07              C.Custo De ?          	             ณ
//ณ mv_par08              C.Custo Ate ?	                         ณ 
//ณ mv_par09              Recurso De ?          	             ณ
//ณ mv_par10              Recurso Ate ?	                         ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	
	// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
	aAdd(aRegs,{cPerg,"01","Data Vendas de      ? ","","","MV_CH1","D",08,0,0,"G","","MV_PAR01","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{cPerg,"02","Data Vendas Ate     ? ","","","MV_CH2","D",08,0,0,"G","","MV_PAR02","","","","","","","","","","","","","","","","","","","","","","","","",""})
    aAdd(aRegs,{cPerg,"03","Tipo de Relat๓rio   ? ","","","MV_CH3","N",01,0,0,"C","","MV_PAR03","Analํtico","","","","","Sint้tico","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{cPerg,"04","Cliente  De         ? ","","","MV_CH4","C",06,0,0,"G","","MV_PAR04","","","","","","","","","","","","","","","","","","","","","","","","","SA1"})
	aAdd(aRegs,{cPerg,"05","Cliente  Ate        ? ","","","MV_CH5","C",06,0,0,"G","","MV_PAR05","","","","","","","","","","","","","","","","","","","","","","","","","SA1"})
	aAdd(aRegs,{cPerg,"06","Produto De          ? ","","","MV_CH6","C",06,0,0,"G","","MV_PAR06","","","","","","","","","","","","","","","","","","","","","","","","","SB1"})
	aAdd(aRegs,{cPerg,"07","Produt Ate          ? ","","","MV_CH7","C",06,0,0,"G","","MV_PAR07","","","","","","","","","","","","","","","","","","","","","","","","","SB1"})
	aAdd(aRegs,{cPerg,"08","Segmento  De        ? ","","","MV_CH8","C",01,0,0,"G","","MV_PAR08","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{cPerg,"09","Segmento  Ate       ? ","","","MV_CH9","C",01,0,0,"G","","MV_PAR09","","","","","","","","","","","","","","","","","","","","","","","","",""})
//  aAdd(aRegs,{cPerg,"01","Status de             ? ","","","MV_CH1","N",01,0,0,"C","","MV_PAR01","Abertos","","","","","Em Andamento","","","","","Encerrado","","","","","Cancelados","","","","","","","","",""})
//  aAdd(aRegs,{cPerg,"02","Status At้            ? ","","","MV_CH2","N",01,0,0,"C","","MV_PAR02","Abertos","","","","","Em Andamento","","","","","Encerrado","","","","","Cancelados","","","","","","","","",""})   


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
