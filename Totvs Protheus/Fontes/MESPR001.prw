#INCLUDE "PROTHEUS.CH"

#define STR0001 "Emide pedido de compras"
#define STR0002 "registrados y que aun no se imprimieron"   
#define STR0003 "Emision de los Pedidos de Compras o Autorizaciones de Entrega"
#define STR0004 "A Rayas"
#define STR0005 "Administracion"
#define STR0006 "ANULADO POR EL OPERADOR"
#define STR0007 "D E S C U E N T O S ->"
#define STR0008 "Local de Entrega  : "
#define STR0009 "CP :"
#define STR0010 "Local de Cobranza:"             
#define STR0011 "Condicion de pago "
#define STR0012 "| Fecha emision |"
#define STR0013 "Total de las mercaderias:"
#define STR0014 "Reajuste :"
#define STR0015 "| I V A: "
#define STR0016 "| Observaciones"
#define STR0017 "| Grupo :"
#define STR0018 "| Total general:"
#define STR0019 "|           Aprobacion del pedido"
#define STR0020 "| Obs. del flete:"
#define STR0021 "Comprador"
#define STR0022 "Gerencia"
#define STR0023 "Directoria"
#define STR0024 "|   NOTA: Solo aceptaremos la mercaderia si en su Factura consta el numero de nuestro Pedido de Compras."
#define STR0025 "| Observaciones"
#define STR0026 "| Comprador    "
#define STR0027 "| Gerencia     "
#define STR0028 "| Directoria   "
#define STR0029 "|   NOTA: Solo aceptaremos la mercaderia si en su Factura consta el numero de la Autorizacion de Entrega."
#define STR0030 "Continua ..."
#define STR0031 "| P E D I D O  D E  C O M P R A S"
#define STR0032 "| A U T.   D E   E N T R E G A   "
#define STR0033 " - continuacion"
#define STR0034 "a.Emision "
#define STR0035 "a.Cop"
#define STR0036 "I.E.:"
#define STR0037 "TEL:  "
#define STR0038 "Fax:  "
#define STR0039 "Num.Contrib.: "
#define STR0040 "Num.Contrib.: "
#define STR0041 "IE :"
#define STR0042 "TEL.: "
#define STR0043 "Item|"
#define STR0044 "Codigo      "
#define STR0045 "|Descripcion del Material"
#define STR0046 "|UM|  Cant."
#define STR0047 "|Valor Unitario|IVA  |  Valor Total   | Entrega  |  CCOSTO            | S.C. |"
#define STR0048 "|Valor Unitario|  Valor Total   | Entrega  | Numero de la OP o CC "
#define STR0049 "| Flete :"
#define STR0050 "      P E D I D O   A P R O B A D O"
#define STR0051 "     P E D I D O   B L O Q U E A D O "
#define STR0052 "Comprador Responsable :"
#define STR0053 "Compradores Alternativos :"
#define STR0054 "Aprobador(es) :"
#define STR0055 "|Valor Unitario|IVA  |  Valor Total   | Entrega  |  CCOSTO | S.C. |"
#define STR0056 "|Valor Unitario|      Valor Total     | Entrega  |  CCOSTO            | S.C. |"
#define STR0057 "|Valor Unitario|      Valor Total     | Entrega  |  CCOSTO | S.C. |"
#define STR0058 "| COSTOS :"
#define STR0059 "| SEGURO :"
#define STR0060 "BLQ:Bloqueado"
#define STR0061 "Ok:Aprobado"
#define STR0062 "??:Esper.Lib"
#define STR0063 "Total de los Impuestos:"
#define STR0064 "Total com Impuestos:"
#define STR0065 "OP "
#define STR0066 "CC "
#define STR0067 "##:Nivel Lib"
#define STR0068 "P E D I D O  D E  C O M P R A S"
#define STR0069 "A U T O R I Z A C A O  D E  E N T R E G A"
#define STR0070 "Data de Emissao"
#define STR0071 "IPI      :"
#define STR0072 "ICMS     :"
#define STR0073 "Frete    :"
#define STR0074 "Despesas :"
#define STR0075 "Grupo    :"
#define STR0076 "SEGURO   :"
#define STR0077 "Observacoes "
#define STR0078 "Total Geral :"
#define STR0079 "Liberacao do Pedido"
#define STR0080 "Obs. do Frete: "
#define STR0081 "NOTA: So aceitaremos a mercadoria se na sua Nota Fiscal constar o numero do nosso Pedido de Compras."
#define STR0082 "Legendas da Aprovacao : "
#define STR0083 "NOTA: So aceitaremos a mercadoria se na sua Nota Fiscal constar o numero da Autorizacao de Entrega."
#define STR0084 "Liber. Autorizacao "
#define STR0085 "AUTORIZACAO DE ENTREGA LIBERADA    "
#define STR0086 "AUTORIZACAO DE ENTREGA BLOQUEADA   "
#define STR0087 "Empresa   "
#define STR0088 "Endereco  "
#define STR0089 "CEP       "
#define STR0090 "Cidade    "
#define STR0091 "UF        "
#define STR0092 "TEL       "
#define STR0093 "FAX       "
#define STR0094 "FONE"
#define STR0095 "Ins. Estad."
#define STR0096 "CNPJ/CPF  "
#define STR0097 "Descricao"
#define STR0098 "Valor Unitario"
#define STR0099 "Valor Total"
#define STR0100 "Numero da OP ou CC"
#define STR0101 "Continua na Proxima Pagina .... "

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ MESPR001 ³ Autor ³ Marco Aurelio- Actual ³ Data ³16/06/2009³±±
±±³Fun‡…o ORI³ MTR110V  ³ Autor ³ Valdemir Miranda      ³ Data ³06/09/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Pedido de Compras / Autorizacao de Entrega                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ MESPR001(void)                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Especifico MULTLOCK                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MESPR001( cAlias, nReg, nOpcx )
Local oReport  
PRIVATE lAuto := (nReg!=Nil)  
Private li    := 0

*...     
Public whora:=substr(time(),1,2)+substr(time(),4,2)+RIGHT(time(),2)
Private oFont09N,oFont09,oFont22N,oFont22,oFont20N,oFont20,oFont18N,oFont18,oFont16N,oFont16,oFont14N,oFont12N,oFont10N,oFont14,oFont12,oFont10,oFont08
Private nMargem   := -28    
Private xObservacao := ""
Public NCW:=0  
 

oFont22N	:= TFont():New("Times New Roman",22,22,,.T.,,,,.T.,.F.)
oFont22 	:= TFont():New("Times New Roman",22,22,,.F.,,,,.T.,.F.)
oFont20N	:= TFont():New("Times New Roman",20,20,,.T.,,,,.T.,.F.)
oFont20 	:= TFont():New("Times New Roman",20,20,,.F.,,,,.T.,.F.)
oFont18N	:= TFont():New("Times New Roman",18,18,,.T.,,,,.T.,.F.)
oFont18 	:= TFont():New("Times New Roman",18,18,,.F.,,,,.T.,.F.)
oFont16N	:= TFont():New("Times New Roman",14,14,,.T.,,,,.T.,.F.)
oFont16 	:= TFont():New("Times New Roman",14,14,,.F.,,,,.T.,.F.)
oFont14N	:= TFont():New("Times New Roman",12,12,,.T.,,,,.T.,.F.)
oFont14 	:= TFont():New("Times New Roman",12,12,,.F.,,,,.T.,.F.)
oFont12	    := TFont():New("Times New Roman",12,12,,.F.,,,,.T.,.F.)
oFont12N	:= TFont():New("Times New Roman",12,12,,.T.,,,,.T.,.F.)
oFont10	    := TFont():New("Times New Roman",10,10,,.F.,,,,.T.,.F.)
oFont10N	:= TFont():New("Times New Roman",10,10,,.T.,,,,.T.,.F.)
oFont09N	:= TFont():New("Times New Roman",09,09,,.T.,,,,.T.,.F.)
oFont09 	:= TFont():New("Times New Roman",09,09,,.F.,,,,.T.,.F.)
oFont08	    := TFont():New("Times New Roman",08,08,,.T.,,,,.T.,.F.)
oFont06	    := TFont():New("Times New Roman",07,07,,.T.,,,,.T.,.F.)  

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Interface de impressao                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//If FindFunction("TRepInUse") .And. TRepInUse()
//	oReport:= RxMONTRL(nReg, nOpcx)
//	oReport:PrintDialog()
//Else
	RCBCP3( cAlias, nReg, nOpcx )
//EndIf

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ RxMontrl ³Autor  ³Valdemir Miranda       ³Data  ³13/10/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Pedido de Compras / Autorizacao de Entrega                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ nExp01: nReg = Registro posicionado do SC7 apartir Browse  ³±±
±±³          ³ nExp02: nOpcx= 1 - PC / 2 - AE                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ oExpO1: Objeto do relatorio                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function RxMontrl(nReg,nOpcx)

Local cTitle   := STR0003 // "Emissao dos Pedidos de Compras ou Autorizacoes de Entrega"
Local oReport
Local oSection1
Local oSection2

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01               Do Pedido                             ³
//³ mv_par02               Ate o Pedido                          ³
//³ mv_par03               A partir da data de emissao           ³
//³ mv_par04               Ate a data de emissao                 ³
//³ mv_par05               Somente os Novos                      ³
//³ mv_par06               Campo Descricao do Produto    	     ³
//³ mv_par07               Unidade de Medida:Primaria ou Secund. ³
//³ mv_par08               Imprime ? Pedido Compra ou Aut. Entreg³
//³ mv_par09               Numero de vias                        ³
//³ mv_par10               Pedidos ? Liberados Bloqueados Ambos  ³
//³ mv_par11               Impr. SC's Firmes, Previstas ou Ambas ³
//³ mv_par12               Qual a Moeda ?                        ³
//³ mv_par13               Endereco de Entrega                   ³
//³ mv_par14               todas ou em aberto ou atendidos       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
xMontax1()
Pergunte("MTR110",.F.)

//oReport:= TReport():New("MATR110",cTitle,"MTR110", {|oReport| RRELPCO(oReport,nReg,nOpcx)},STR0001+" "+STR0002)
oReport:= TReport():New("MESPA001",cTitle,"MTR110", {|oReport| RRELPCO(oReport,nReg,nOpcx)},STR0001+" "+STR0002)
oReport:SetPortrait()
oReport:HideParamPage()
oReport:HideHeader()
oReport:HideFooter()
oReport:SetTotalInLine(.F.)
oSection1:= TRSection():New(oReport,STR0031,{"SC7","SM0","SA2"},/*aOrdem*/) //"| P E D I D O  D E  C O M P R A S"
oSection1:SetLineStyle()
oSection1:SetReadOnly()
 //************  Dados do Cabecalho
TRCell():New(oSection1,"M0_NOMECOM","SM0",STR0087      ,/*Picture*/,47,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"A2_NOME"   ,"SA2",/*Titulo*/   ,/*Picture*/,40,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"A2_COD"    ,"SA2",/*Titulo*/   ,/*Picture*/,20,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"A2_LOJA"   ,"SA2",/*Titulo*/   ,/*Picture*/,04,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"M0_ENDENT" ,"SM0",STR0088      ,/*Picture*/,46,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"A2_END"    ,"SA2",/*Titulo*/   ,/*Picture*/,40,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"A2_BAIRRO" ,"SA2",/*Titulo*/   ,/*Picture*/,20,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"M0_CEPENT" ,"SM0",STR0089      ,/*Picture*/,10,/*lPixel*/,{|| Trans(SM0->M0_CEPENT,PesqPict("SA2","A2_CEP")) })
TRCell():New(oSection1,"M0_CIDENT" ,"SM0",STR0090      ,/*Picture*/,20,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"M0_ESTENT" ,"SM0",STR0091      ,/*Picture*/,07,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"A2_MUN"    ,"SA2",/*Titulo*/   ,/*Picture*/,15,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"A2_EST"    ,"SA2",/*Titulo*/   ,/*Picture*/,02,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"A2_CEP"    ,"SA2",/*Titulo*/   ,/*Picture*/,08,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"A2_CGC"    ,"SA2",/*Titulo*/   ,/*Picture*/,14,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"M0_TEL"    ,"SM0",STR0092      ,/*Picture*/,14,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"M0_FAX"    ,"SM0",STR0093      ,/*Picture*/,31,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"FONE"      ,"   ",STR0094      ,/*Picture*/,25,/*lPixel*/,{|| "("+Substr(SA2->A2_DDD,1,3)+") "+Substr(SA2->A2_TEL,1,15)})
TRCell():New(oSection1,"FAX"       ,"   ","FAX"        ,/*Picture*/,25,/*lPixel*/,{|| "("+Substr(SA2->A2_DDD,1,3)+") "+SubStr(SA2->A2_FAX,1,15)})
TRCell():New(oSection1,"INSCR"     ,"   ",If( cPaisLoc$"ARG|POR|EUA",space(11) , STR0095 ),/*Picture*/,18,/*lPixel*/,{|| If( cPaisLoc$"ARG|POR|EUA",space(18), SA2->A2_INSCR ) })
TRCell():New(oSection1,"M0_CGC"    ,"SM0",STR0096      ,/*Picture*/,18,/*lPixel*/,{|| Transform(SM0->M0_CGC,PesqPict("SA2","A2_CGC")) })

If cPaisLoc == "BRA"
	TRCell():New(oSection1,"M0IE"  ,"   ",STR0041      ,/*Picture*/,18,/*lPixel*/,{|| InscrEst()})
EndIf

oSection1:Cell("A2_BAIRRO"):SetCellBreak()
oSection1:Cell("A2_CGC"   ):SetCellBreak()
oSection1:Cell("INSCR"    ):SetCellBreak()

oSection2:= TRSection():New(oSection1,cTitle,{"SC7","SB1"},/*aOrdem*/)

oSection2:SetCellBorder("ALL",,,.T.)
oSection2:SetCellBorder("RIGHT")
oSection2:SetCellBorder("LEFT")   

// ********** impressao dos Itens
TRCell():New(oSection2,"C7_ITEM"    ,"SC7",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"C7_PRODUTO" ,"SC7",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"DESCPROD"   ,"   ",STR0097   ,/*Picture*/,33,/*lPixel*/, {|| cDescPro })
TRCell():New(oSection2,"C7_UM"      ,"SC7",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"C7_SEGUM"   ,"SC7",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"C7_QUANT"   ,"SC7",/*Titulo*/,PesqPictQt("C7_QUANT",13),/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"C7_QTSEGUM" ,"SC7",/*Titulo*/,PesqPictQt("C7_QUANT",13),/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"PRECO"      ,"   ",STR0098   ,PesqPict("SC7","C7_PRECO",14),/*Tamanho*/,/*lPixel*/,{|| nVlUnitSC7 })
TRCell():New(oSection2,"C7_IPI"     ,"SC7",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"TOTAL"      ,"   ",STR0099   ,PesqPict("SC7","C7_TOTAL",16),/*Tamanho*/,/*lPixel*/,{|| nValTotSC7 })
TRCell():New(oSection2,"C7_DATPRF"  ,"SC7",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"C7_CC"      ,"SC7",/*Titulo*/,PesqPict("SC7","C7_CC",20),IIf(cPaisLoc <> "BRA" ,24,Nil)/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"C7_NUMSC"   ,"SC7",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"OPCC"       ,"   ",STR0100   ,/*Picture*/,IIf(cPaisLoc <> "BRA",38,37),/*lPixel*/,{|| cOPCC })

oSection2:Cell("DESCPROD"):SetLineBreak()

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³RRELPCO         ³ Autor ³Valdemir Miranda ³Data  ³06/09/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Emissao do Pedido de Compras / Autorizacao de Entrega      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ RRELPCO(ExpO1,ExpN1,ExpN2)                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oReport                                     ³±±
±±³          ³ ExpN1 = Numero do Recno posicionado do SC7 impressao Menu  ³±±
±±³          ³ ExpN2 = Numero da opcao para impressao via menu do PC      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function RRELPCO(oReport,nReg,nOpcX)

Local oSection1   := oReport:Section(1)
Local oSection2   := oReport:Section(1):Section(1)

Local aRecnoSave  := {}
Local aPedido     := {}
Local aPedMail    := {}
Local aValIVA     := {}

Local cNumSC7     := Len(SC7->C7_NUM)
Local cCondicao   := ""
Local cFiltro     := ""
Local cComprador  := ""
LOcal cAlter	  := ""
Local cAprov	  := ""
Local cTipoSC7    := ""
Local cCondBus    := ""
Local cMensagem   := ""
Local cObs01      := ""
Local cObs02      := ""
Local cObs03      := ""
Local cObs04      := ""
Local cObs05      := ""
Local cVar        := ""

Local lNewAlc	  := .F.
Local lLiber      := .F.

Local nRecnoSC7   := 0
Local nRecnoSM0   := 0
Local nX          := 0
Local nY          := 0
Local nVias       := 0
Local nTxMoeda    := 0
Local nPrinted    := 0
Local nValIVA     := 0
Local nTotIpi	  := 0
Local nTotIcms	  := 0
Local nTotDesp	  := 0
Local nTotFrete	  := 0
Local nTotalNF	  := 0
Local nTotSeguro  := 0
Local nLinObs     := 0
Local nDescProd   := 0
Local nTotal      := 0
Local nTotMerc    := 0
Local nPagina     := 0
Local nOrder      := 1

Private cDescPro  := ""
Private cOPCC     := ""
Private	nVlUnitSC7:= 0
Private nValTotSC7:= 0

dbSelectArea("SM0")
dbSetOrder(1)
dbSeek(Subs(cNumEmp,1,2) + cFilial ,.T.)

dbSelectArea("SC7")

If lAuto
	dbSelectArea("SC7")
	dbGoto(nReg)
	mv_par01 := SC7->C7_NUM
	mv_par02 := SC7->C7_NUM
	mv_par03 := SC7->C7_EMISSAO
	mv_par04 := SC7->C7_EMISSAO
	mv_par05 := 2
	mv_par08 := SC7->C7_TIPO
	mv_par09 := 1
	mv_par10 := 3
	mv_par11 := 3
	mv_par14 := 1
Else
	MakeAdvplExpr(oReport:uParam)
	
	cCondicao := 'C7_FILIAL=="'       + xFilial("SC7") + '".And.'
	cCondicao += 'C7_NUM>="'          + mv_par01       + '".And.C7_NUM<="'          + mv_par02 + '".And.'
	cCondicao += 'Dtos(C7_EMISSAO)>="'+ Dtos(mv_par03) +'".And.Dtos(C7_EMISSAO)<="' + Dtos(mv_par04) + '"'
	
	oReport:Section(1):SetFilter(cCondicao,IndexKey())
EndIf

If SC7->C7_TIPO == 1
	If ( cPaisLoc$"ARG|POR|EUA" )
		cCondBus := "1"+StrZero(Val(mv_par01),6)
		nOrder	 := 10
	Else
		cCondBus := mv_par01
		nOrder	 := 1
	EndIf
Else
	cCondBus := "2"+StrZero(Val(mv_par01),6)
	nOrder	 := 10
EndIf

If mv_par14 == 2
	cFiltro := "SC7->C7_QUANT-SC7->C7_QUJE <= 0 .Or. !EMPTY(SC7->C7_RESIDUO)"
Elseif mv_par14 == 3
	cFiltro := "SC7->C7_QUANT > SC7->C7_QUJE"
EndIf

TRPosition():New(oSection2,"SB1",1,{ || xFilial("SB1") + SC7->C7_PRODUTO })
TRPosition():New(oSection2,"SB5",1,{ || xFilial("SB5") + SC7->C7_PRODUTO })

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Executa o CodeBlock com o PrintLine da Sessao 1 toda vez que rodar o oSection1:Init()   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:onPageBreak( { || nPagina++ , nPrinted := 0 , RCABPVO1(oReport,oSection1,nVias,nPagina) })

oReport:SetMeter(SC7->(LastRec()))
dbSelectArea("SC7")
dbSetOrder(nOrder)
dbSeek(xFilial("SC7")+cCondBus,.T.)

oSection2:Init()

cNumSC7 := SC7->C7_NUM

While !oReport:Cancel() .And. !SC7->(Eof()) .And. SC7->C7_FILIAL == xFilial("SC7") .And. SC7->C7_NUM >= mv_par01 .And. SC7->C7_NUM <= mv_par02
	
	If (SC7->C7_CONAPRO == "B" .And. mv_par10 == 1) .Or.;
		(SC7->C7_CONAPRO <> "B" .And. mv_par10 == 2) .Or.;
		(SC7->C7_EMITIDO == "S" .And. mv_par05 == 1) .Or.;
		((SC7->C7_EMISSAO < mv_par03) .Or. (SC7->C7_EMISSAO > mv_par04)) .Or.;
		(SC7->C7_TIPO == 1 .And. mv_par08 == 2) .Or.;
		(SC7->C7_TIPO == 2 .And. mv_par08 == 1) .Or. !MtrAValOP(mv_par11, "SC7") .Or.;
		(SC7->C7_QUANT > SC7->C7_QUJE .And. mv_par14 == 3) .Or.;
		((SC7->C7_QUANT - SC7->C7_QUJE <= 0 .Or. !Empty(SC7->C7_RESIDUO)) .And. mv_par14 == 2 )
		
		dbSelectArea("SC7")
		dbSkip()
		Loop
	Endif
	
	If oReport:Cancel()
		Exit
	EndIf
	
	MaFisEnd()
	MaFisIniPC(SC7->C7_NUM,,,cFiltro)
	
	cObs01    := " "
	cObs02    := " "
	cObs03    := " "
	cObs04    := " "
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Roda a impressao conforme o numero de vias informado no mv_par09 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For nVias := 1 to mv_par09
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Dispara a cabec especifica do relatorio.                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oReport:EndPage()
		
		nPagina  := 0
		nPrinted := 0
		nTotal   := 0
		nTotMerc := 0
		nDescProd:= 0
		nLinObs  := 0  
		NCW      := nVias
		nRecnoSC7:= SC7->(Recno())
		cNumSC7  := SC7->C7_NUM
		aPedido  := {SC7->C7_FILIAL,SC7->C7_NUM,SC7->C7_EMISSAO,SC7->C7_FORNECE,SC7->C7_LOJA,SC7->C7_TIPO}
		
		While !oReport:Cancel() .And. !SC7->(Eof()) .And. SC7->C7_FILIAL == xFilial("SC7") .And. SC7->C7_NUM == cNumSC7
			
			If (SC7->C7_CONAPRO == "B" .And. mv_par10 == 1) .Or.;
				(SC7->C7_CONAPRO <> "B" .And. mv_par10 == 2) .Or.;
				(SC7->C7_EMITIDO == "S" .And. mv_par05 == 1) .Or.;
				((SC7->C7_EMISSAO < mv_par03) .Or. (SC7->C7_EMISSAO > mv_par04)) .Or.;
				(SC7->C7_TIPO == 1 .And. mv_par08 == 2) .Or.;
				(SC7->C7_TIPO == 2 .And. mv_par08 == 1) .Or. !MtrAValOP(mv_par11, "SC7") .Or.;
				(SC7->C7_QUANT > SC7->C7_QUJE .And. mv_par14 == 3) .Or.;
				((SC7->C7_QUANT - SC7->C7_QUJE <= 0 .Or. !Empty(SC7->C7_RESIDUO)) .And. mv_par14 == 2 )
				dbSelectArea("SC7")
				dbSkip()
				Loop
			Endif
			
			If oReport:Cancel()
				Exit
			EndIf
			
			oReport:IncMeter()
			
			If oReport:Row() > oReport:LineHeight() * 100
				oReport:Box( oReport:Row(),010,oReport:Row() + oReport:LineHeight() * 3, 2290 )
				oReport:SkipLine()
				oReport:PrintText(STR0101,, 050 ) // Continua na Proxima pagina ....
				oReport:EndPage()
			EndIf
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Salva os Recnos do SC7 no aRecnoSave para marcar reimpressao.³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If Ascan(aRecnoSave,SC7->(Recno())) == 0
				AADD(aRecnoSave,SC7->(Recno()))
			Endif
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Inicializa o descricao do Produto conf. parametro digitado.³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			cDescPro :=  ""
			If Empty(mv_par06)
				mv_par06 := "B1_DESC"
			EndIf
			
			If AllTrim(mv_par06) == "B1_DESC"
				SB1->(dbSetOrder(1))
				SB1->(dbSeek( xFilial("SB1") + SC7->C7_PRODUTO ))
				cDescPro := SB1->B1_DESC
			ElseIf AllTrim(mv_par06) == "B5_CEME"
				SB5->(dbSetOrder(1))
				If SB5->(dbSeek( xFilial("SB5") + SC7->C7_PRODUTO ))
					cDescPro := SB5->B5_CEME
				EndIf
			ElseIf AllTrim(mv_par06) == "C7_DESCRI"
				cDescPro := SC7->C7_DESCRI
			EndIf
			
			If Empty(cDescPro)
				SB1->(dbSetOrder(1))
				SB1->(dbSeek( xFilial("SB1") + SC7->C7_PRODUTO ))
				cDescPro := SB1->B1_DESC
			EndIf
			
			SA5->(dbSetOrder(1))
			If SA5->(dbSeek(xFilial("SA5")+SC7->C7_FORNECE+SC7->C7_LOJA+SC7->C7_PRODUTO)) .And. !Empty(SA5->A5_CODPRF)
				cDescPro := cDescPro + " ("+Alltrim(SA5->A5_CODPRF)+")"
			EndIf
			
			If SC7->C7_DESC1 != 0 .Or. SC7->C7_DESC2 != 0 .Or. SC7->C7_DESC3 != 0
				nDescProd+= CalcDesc(SC7->C7_TOTAL,SC7->C7_DESC1,SC7->C7_DESC2,SC7->C7_DESC3)
			Else
				nDescProd+=SC7->C7_VLDESC
			Endif
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Inicializacao da Observacao do Pedido.                       ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If !Empty(SC7->C7_OBS) .And. nLinObs < 5
				nLinObs++
				cVar:="cObs"+StrZero(nLinObs,2)
				Eval(MemVarBlock(cVar),SC7->C7_OBS)
			Endif
			
			nTxMoeda   := IIF(SC7->C7_TXMOEDA > 0,SC7->C7_TXMOEDA,Nil)
			nValTotSC7 := xMoeda(SC7->C7_TOTAL,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,,nTxMoeda)
			
			nTotal     := nTotal + SC7->C7_TOTAL
			nTotMerc   := MaFisRet(,"NF_TOTAL")
			
			If MV_PAR07 == 2 .And. !Empty(SC7->C7_QTSEGUM) .And. !Empty(SC7->C7_SEGUM)
				oSection2:Cell("C7_SEGUM"  ):Enable()
				oSection2:Cell("C7_QTSEGUM"):Enable()
				oSection2:Cell("C7_UM"     ):Disable()
				oSection2:Cell("C7_QUANT"  ):Disable()
				nVlUnitSC7 := xMoeda((SC7->C7_TOTAL/SC7->C7_QTSEGUM),SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,,nTxMoeda)
			Else
				oSection2:Cell("C7_SEGUM"  ):Disable()
				oSection2:Cell("C7_QTSEGUM"):Disable()
				oSection2:Cell("C7_UM"     ):Enable()
				oSection2:Cell("C7_QUANT"  ):Enable()
				nVlUnitSC7 := xMoeda(SC7->C7_PRECO,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,,nTxMoeda)
			EndIf
			
			If cPaisLoc <> "BRA" .Or. mv_par08 == 2
				oSection2:Cell("C7_IPI" ):Disable()
			EndIf
			
			If mv_par08 == 1
				oSection2:Cell("OPCC"):Disable()
			Else
				oSection2:Cell("C7_CC"):Disable()
				oSection2:Cell("C7_NUMSC"):Disable()
				If !Empty(SC7->C7_OP)
					cOPCC := STR0065 + " " + SC7->C7_OP
				ElseIf !Empty(SC7->C7_CC)
					cOPCC := STR0066 + " " + SC7->C7_CC
				EndIf
			EndIf
			
			oSection2:PrintLine()
			
			nPrinted ++
			
			dbSelectArea("SC7")
			dbSkip()
			
		EndDo
		
		SC7->(dbGoto(nRecnoSC7))
		
		If oReport:Row() > oReport:LineHeight() * 70
			
			oReport:Box( oReport:Row(),010,oReport:Row() + oReport:LineHeight() * 3, 2290 )
			oReport:SkipLine()
			oReport:PrintText(STR0101,, 050 ) // Continua na Proxima pagina ....
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Dispara a cabec especifica do relatorio.                     ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			oReport:EndPage()
			oReport:PrintText(" ",1992 , 010 ) // Necessario para posicionar Row() para a impressao do Rodape
			
			oReport:Box( 280,010,oReport:Row() + oReport:LineHeight() * ( 93 - nPrinted ) , 2290 )
			
		Else
			oReport:Box( oReport:Row(),oReport:Col(),oReport:Row() + oReport:LineHeight() * ( 93 - nPrinted ) , 2290 )
		EndIf
		
		oReport:Box( 1990 ,010,oReport:Row() + oReport:LineHeight() * ( 93 - nPrinted ) , 2290 )
		oReport:Box( 2080 ,010,oReport:Row() + oReport:LineHeight() * ( 93 - nPrinted ) , 2290 )
		oReport:Box( 2200 ,010,oReport:Row() + oReport:LineHeight() * ( 93 - nPrinted ) , 2290 )
		oReport:Box( 2320 ,010,oReport:Row() + oReport:LineHeight() * ( 93 - nPrinted ) , 2290 )
		
		oReport:Box( 2200 , 1080 , 2320 , 1400 ) // Box da Data de Emissao
		oReport:Box( 2320 ,  010 , 2406 , 1220 ) // Box do Reajuste
		oReport:Box( 2320 , 1220 , 2460 , 1750 ) // Box do IPI e do Frete
		oReport:Box( 2320 , 1750 , 2460 , 2290 ) // Box do ICMS Despesas e Seguro
		oReport:Box( 2406 ,  010 , 2700 , 1220 ) // Box das Observacoes
		
		cMensagem:= Formula(C7_MSG)
		If !Empty(cMensagem)
			oReport:SkipLine()
			oReport:PrintText(PadR(cMensagem,129), , oSection2:Cell("DESCPROD"):ColPos() )
		Endif
		
		oReport:PrintText( STR0007 /*"D E S C O N T O S -->"*/ + " " + ;
		TransForm(SC7->C7_DESC1,"999.99" ) + " %    " + ;
		TransForm(SC7->C7_DESC2,"999.99" ) + " %    " + ;
		TransForm(SC7->C7_DESC3,"999.99" ) + " %    " + ;
		TransForm(xMoeda(nDescProd,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,,nTxMoeda) , PesqPict("SC7","C7_VLDESC",14, mv_par12) ),;
		2022 , 050 )
		
		oReport:SkipLine()
		oReport:SkipLine()
		oReport:SkipLine()
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Posiciona o Arquivo de Empresa SM0.                          ³
		//³ Imprime endereco de entrega do SM0 somente se o MV_PAR13 =" "³
		//³ e o Local de Cobranca :                                      ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		SM0->(dbSetOrder(1))
		nRecnoSM0 := SM0->(Recno())
		SM0->(dbSeek(SUBS(cNumEmp,1,2)+SC7->C7_FILENT))
		
		If Empty(MV_PAR13) //"Local de Entrega  : "
			oReport:PrintText(STR0008 + SM0->M0_ENDENT+"  "+SM0->M0_CIDENT+"  - "+SM0->M0_ESTENT+" - "+STR0009+" "+Trans(Alltrim(SM0->M0_CEPENT),PesqPict("SA2","A2_CEP")),, 050 )
		Else
			oReport:PrintText(STR0008 + mv_par13,, 050 ) //"Local de Entrega  : " imprime o endereco digitado na pergunte
		Endif
		SM0->(dbGoto(nRecnoSM0))
		oReport:PrintText(STR0010 + SM0->M0_ENDCOB+"  "+SM0->M0_CIDCOB+"  - "+SM0->M0_ESTCOB+" - "+STR0009+" "+Trans(Alltrim(SM0->M0_CEPCOB),PesqPict("SA2","A2_CEP")),, 050 )
		
		oReport:SkipLine()
		oReport:SkipLine()
		
// Alterado -- Jean

		DbSelectarea("SE4")
        DbSetOrder(1)
		DbGotop()
		dbSeek(xFilial("SE4")+SC7->C7_COND)

//		SE4->(dbSetOrder(1))
//		SE4->(dbSeek(xFilial("SE4")+SC7->C7_COND))
		
		oReport:PrintText(STR0011+SubStr(SE4->E4_COND,1,40)+ space(20) + STR0070 + space(20)+STR0013 + " " + ;
		Transform(xMoeda(nTotal,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,,nTxMoeda) , tm(nTotal,14,MsDecimais(MV_PAR12)) ) ,, 050 )
		
		If cPaisLoc<>"BRA"
			aValIVA := MaFisRet(,"NF_VALIMP")
			nValIVA :=0
			If !Empty(aValIVA)
				For nY:=1 to Len(aValIVA)
					nValIVA+=aValIVA[nY]
				Next nY
			EndIf
			oReport:PrintText(SubStr(SE4->E4_DESCRI,1,34)+space(63)+dtoc(SC7->C7_EMISSAO) + space(27) + STR0063 + "   " + ;
			Transform(xMoeda(nValIVA,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,,nTxMoeda) , tm(nValIVA,14,MsDecimais(MV_PAR12)) ),, 050 )
		Else
			oReport:PrintText(SubStr(SE4->E4_DESCRI,1,34)+space(63)+dtoc(SC7->C7_EMISSAO) + space(27) + STR0064 + "  " + ;
			Transform(xMoeda(nTotMerc,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,,nTxMoeda) , tm(nTotMerc,14,MsDecimais(MV_PAR12)) ),, 050 )
		Endif
		
		nTotIpi	  := MaFisRet(,'NF_VALIPI')
		nTotIcms  := MaFisRet(,'NF_VALICM')
		nTotDesp  := MaFisRet(,'NF_DESPESA')
		nTotFrete := MaFisRet(,'NF_FRETE')
		nTotSeguro:= MaFisRet(,'NF_SEGURO')
		nTotalNF  := MaFisRet(,'NF_TOTAL')
		
		oReport:SkipLine()
		oReport:SkipLine()
		
		SM4->(dbSetOrder(1))
		SM4->(dbSeek(xFilial("SM4")+SC7->C7_REAJUST))
		If cPaisLoc == "BRA"
			oReport:PrintText( IIf(SM4->(dbSeek(xFilial("SM4")+SC7->C7_REAJUST)) , STR0014 + " " + SC7->C7_REAJUST + " " + SM4->M4_DESCR + Space(44) , Space(89) ) + ;
			STR0071 + Transform(xMoeda(nTotIPI ,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,,nTxMoeda) , tm(nTotIpi ,14,MsDecimais(MV_PAR12))) + Space(15) + ;
			STR0072 + Transform(xMoeda(nTotIcms,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,,nTxMoeda) , tm(nTotIcms,14,MsDecimais(MV_PAR12))) ,, 050 )
		Else
			oReport:PrintText( IIf(SM4->(dbSeek(xFilial("SM4")+SC7->C7_REAJUST)) , STR0014 + " " + SC7->C7_REAJUST + " " + SM4->M4_DESCR + " " , Space(46) ) , , 050 )
		EndIf
		
		oReport:PrintText( Space(89) + STR0073 + Transform(xMoeda(nTotFrete,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,,nTxMoeda) , tm(nTotFrete,14,MsDecimais(MV_PAR12))) + Space(15) + ;
		STR0074 + Transform(xMoeda(nTotDesp,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,,nTxMoeda) , tm(nTotDesp,14,MsDecimais(MV_PAR12))) , , 050 )
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Inicializar campos de Observacoes.                           ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If Empty(cObs02)
			If Len(cObs01) > 50
				cObs := cObs01
				cObs01 := Substr(cObs,1,50)
				For nX := 2 To 4
					cVar  := "cObs"+StrZero(nX,2)
					&cVar := Substr(cObs,(50*(nX-1))+1,50)
				Next nX
			EndIf
		Else
			cObs01:= Substr(cObs01,1,IIf(Len(cObs01)<50,Len(cObs01),50))
			cObs02:= Substr(cObs02,1,IIf(Len(cObs02)<50,Len(cObs01),50))
			cObs03:= Substr(cObs03,1,IIf(Len(cObs03)<50,Len(cObs01),50))
			cObs04:= Substr(cObs04,1,IIf(Len(cObs04)<50,Len(cObs01),50))
		EndIf
		
		cComprador:= ""
		cAlter	  := ""
		cAprov	  := ""
		lNewAlc	  := .F.
		lLiber 	  := .F.
		
		dbSelectArea("SC7")
		If !Empty(SC7->C7_APROV)
			
			cTipoSC7:= IIF(SC7->C7_TIPO == 1,"PC","AE")
			lNewAlc := .T.
			cComprador := UsrFullName(SC7->C7_USER)
			If SC7->C7_CONAPRO != "B"
				lLiber := .T.
			EndIf
			dbSelectArea("SCR")
			dbSetOrder(1)
			dbSeek(xFilial("SCR")+cTipoSC7+SC7->C7_NUM)
			While !Eof() .And. SCR->CR_FILIAL+Alltrim(SCR->CR_NUM) == xFilial("SCR")+SC7->C7_NUM .And. SCR->CR_TIPO == cTipoSC7
				cAprov += AllTrim(UsrFullName(SCR->CR_USER))+" ["
				Do Case
					Case SCR->CR_STATUS=="03" //Liberado
						cAprov += "Ok"
					Case SCR->CR_STATUS=="04" //Bloqueado
						cAprov += "BLQ"
					Case SCR->CR_STATUS=="05" //Nivel Liberado
						cAprov += "##"
					OtherWise                 //Aguar.Lib
						cAprov += "??"
				EndCase
				cAprov += "] - "
				dbSelectArea("SCR")
				dbSkip()
			Enddo
			If !Empty(SC7->C7_GRUPCOM)
				dbSelectArea("SAJ")
				dbSetOrder(1)
				dbSeek(xFilial("SAJ")+SC7->C7_GRUPCOM)
				While !Eof() .And. SAJ->AJ_FILIAL+SAJ->AJ_GRCOM == xFilial("SAJ")+SC7->C7_GRUPCOM
					If SAJ->AJ_USER != SC7->C7_USER
						cAlter += AllTrim(UsrFullName(SAJ->AJ_USER))+"/"
					EndIf
					dbSelectArea("SAJ")
					dbSkip()
				EndDo
			EndIf
		EndIf
		
		oReport:PrintText(STR0077 + Space(116) + STR0076 + Transform(xMoeda(nTotSeguro,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,,nTxMoeda) , tm(nTotSeguro,14,MsDecimais(MV_PAR12))) , , 050 )
		
		oReport:PrintText(cObs01,,050 )
		oReport:PrintText(cObs02,,050 )
		
		If !lNewAlc
			oReport:PrintText(IIf(Empty(cObs03),Space(30),cObs03) + Space(95) + STR0078 + Transform(xMoeda(nTotalNF,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,,nTxMoeda) , tm(nTotalNF,14,MsDecimais(MV_PAR12))) , , 050 )
		Else
			If lLiber
				oReport:PrintText(IIf(Empty(cObs03),Space(30),cObs03) + Space(95) + STR0078 + Transform(xMoeda(nTotalNF,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,,nTxMoeda) , tm(nTotalNF,14,MsDecimais(MV_PAR12))) , , 050 )
			Else
				oReport:PrintText(cObs03 + Space(95) + STR0078 + IIF(SC7->C7_TIPO == 1,STR0051,STR0086) , , 050 )
			EndIf
		EndIf
		
		oReport:PrintText(cObs04,,050 )
		
		If !lNewAlc
			
			oReport:Box( 2700 , 0010 , 3020 , 0400 )
			oReport:Box( 2700 , 0400 , 3020 , 0800 )
			oReport:Box( 2700 , 0800 , 3020 , 1220 )
			oReport:Box( 2600 , 1220 , 3020 , 1770 )
			oReport:Box( 2600 , 1770 , 3020 , 2290 )
			
			oReport:SkipLine()
			oReport:SkipLine()
			oReport:SkipLine()
			oReport:PrintText( Space(89) + IIF(SC7->C7_TIPO == 1,STR0079,STR0084) + Space(20) + STR0080 + IF( SC7->C7_TPFRETE $ "F","FOB",IF(SC7->C7_TPFRETE $ "C","CIF"," " )) ,,050 )
			oReport:SkipLine()
			oReport:SkipLine()
			oReport:PrintText(STR0021 + Space(20) + STR0022 + Space(21) + STR0023 ,,050 )
			oReport:SkipLine()
			oReport:SkipLine()
			oReport:SkipLine()
			oReport:PrintText("_______________________" + Space(6) + "_______________________" + Space(6) + "_______________________" + Space(08) + "_______________________________" ,,050 )
			oReport:SkipLine()
			oReport:SkipLine()
			oReport:SkipLine()
			oReport:SkipLine()
			oReport:SkipLine()
			If SC7->C7_TIPO == 1
				oReport:PrintText(STR0081,,050 ) //"NOTA: So aceitaremos a mercadoria se na sua Nota Fiscal constar o numero do nosso Pedido de Compras."
			Else
				oReport:PrintText(STR0083,,050 ) //"NOTA: So aceitaremos a mercadoria se na sua Nota Fiscal constar o numero da Autorizacao de Entrega."
			EndIf
			cObs01    := " "
			cObs02    := " "
			cObs03    := " "
			cObs04    := " "

			
		Else
			
			oReport:Box( 2570 , 1220 , 2700 , 1850 )
			oReport:Box( 2570 , 1850 , 2700 , 2290 )
			oReport:Box( 2700 , 0010 , 3020 , 2290 )
			oReport:Box( 2970 , 0010 , 3020 , 1340 )
			
			oReport:SkipLine()
			oReport:SkipLine()
			oReport:PrintText( IIF(SC7->C7_TIPO == 1, IIF( lLiber , STR0050 , STR0051 ) , IIF( lLiber , STR0085 , STR0086 ) )  + Space(10) + STR0080 + " " + IIF( SC7->C7_TPFRETE $ "F","FOB",IF(SC7->C7_TPFRETE $ "C","CIF"," " )),,1290 ) //"     P E D I D O   L I B E R A D O"#"|     P E D I D O   B L O Q U E A D O !!!"
			oReport:SkipLine()
			oReport:SkipLine()
			oReport:SkipLine()
			oReport:PrintText(STR0052+" "+Substr(cComprador,1,60),,050 ) 	//"Comprador Responsavel :" //"BLQ:Bloqueado"
			oReport:SkipLine()
			oReport:PrintText(STR0053+" "+IIF( Len(cAlter) > 0 , Substr(cAlter,001,130) , " " ),,050 ) //"Compradores Alternativos :"
			oReport:PrintText(Space(27) + IIF( Len(cAlter) > 0 , Substr(cAlter,131,130) , " " ),,050 ) //"Compradores Alternativos :"
			oReport:SkipLine()
			oReport:PrintText(STR0054+" "+IIF( Len(cAprov) > 0 , Substr(cAprov,001,140) , " " ),,050 ) //"Compradores Alternativos :"
			oReport:PrintText(Space(16) + IIF( Len(cAprov) > 0 , Substr(cAprov,141,140) , " " ),,050 ) //"Compradores Alternativos :"
			oReport:SkipLine()
			oReport:PrintText(STR0082+" "+STR0060+"  |  "+STR0061+"  |  "+STR0062+"  |   "+STR0067,,050 ) 	//"Legendas da Aprovacao : //"BLQ:Bloqueado"
			oReport:SkipLine()
			If SC7->C7_TIPO == 1
				oReport:PrintText(STR0081,,050 ) //"NOTA: So aceitaremos a mercadoria se na sua Nota Fiscal constar o numero do nosso Pedido de Compras."
			Else
				oReport:PrintText(STR0083,,050 ) //"NOTA: So aceitaremos a mercadoria se na sua Nota Fiscal constar o numero da Autorizacao de Entrega."
			EndIf 
				cObs01    := " "
				cObs02    := " "
				cObs03    := " "
				cObs04    := " "

		EndIf
		
	Next nVias
	
	MaFisEnd()
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Grava no SC7 as Reemissoes e atualiza o Flag de impressao.   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("SC7")
	If Len(aRecnoSave) > 0
		For nX :=1 to Len(aRecnoSave)
			dbGoto(aRecnoSave[nX])
			RecLock("SC7",.F.)
			SC7->C7_QTDREEM := (SC7->C7_QTDREEM + 1)
			SC7->C7_EMITIDO := "S"
			MsUnLock()
		Next nX
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Reposiciona o SC7 com base no ultimo elemento do aRecnoSave. ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbGoto(aRecnoSave[Len(aRecnoSave)])
	Endif
	
	Aadd(aPedMail,aPedido)
	
	aRecnoSave := {}
	
	dbSelectArea("SC7")
	dbSkip()
	
EndDo

oSection2:Finish()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Executa o ponto de entrada M110MAIL quando a impressao for   ³
//³ enviada por email, fornecendo um Array para o usuario conten ³
//³ do os pedidos enviados para possivel manipulacao.            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ExistBlock("M110MAIL")
	lEnvMail := HasEmail(,,,,.F.)
	If lEnvMail
		Execblock("M110MAIL",.F.,.F.,{aPedMail})
	EndIf
EndIf

dbSelectArea("SC7")
dbClearFilter()
dbSetOrder(1)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³RCABPVO1 Autor ³Valdemir Miranda          ³Data  ³13/10/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Emissao do Pedido de Compras / Autorizacao de Entrega      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ RCABPVO1(ExpO1,ExpO2,ExpN1,ExpN2)                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oReport                      	          ³±±
±±³          ³ ExpO2 = Objeto da sessao1 com o cabec                      ³±±
±±³          ³ ExpN1 = Numero de Vias                                     ³±±
±±³          ³ ExpN2 = Numero de Pagina                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function RCABPVO1(oReport,oSection1,nVias,nPagina)

Local cMoeda := IIf( mv_par12 < 10 , Str(mv_par12,1) , Str(mv_par12,2) )

TRPosition():New(oSection1,"SA2",1,{ || xFilial("SA2") + SC7->C7_FORNECE + SC7->C7_LOJA })

oSection1:Init()

oReport:Box( 010 , 010 , 260 , 0790 )
oReport:Box( 010 , 800 , 260 , 2288 )

oReport:PrintText( IIf(nPagina > 1,(STR0033)," "),,oSection1:Cell("M0_NOMECOM"):ColPos())

oReport:PrintText( IIf( mv_par08 == 1 , (STR0068), (STR0069) ) + " - " + GetMV("MV_MOEDA"+cMoeda) + Space(10) + ;
IIf( mv_par08 == 1 , Space(17) + SC7->C7_NUM ,SC7->C7_NUMSC + "/" + SC7->C7_NUM ) + " " + "/"+Str(nPagina,1) + Space(10) + ;
IIf( SC7->C7_QTDREEM > 0 , Str(SC7->C7_QTDREEM+1,2) , "1" ) + STR0034 + Str(nVias,2) + STR0035 ,,810)

oReport:SkipLine()
oSection1:PrintLine()
oSection1:Finish()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ RCBCP3³ Autor ³ Valdemir Miranda         ³ Data ³13/10/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Emissao do Pedido de Compras                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³        ³      ³                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Descri‡ao ³ PLANO DE MELHORIA CONTINUA        ³Programa: MATR110R3.PRX ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ITEM PMC  ³ Responsavel              ³ Data          |BOPS             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function RCBCP3(cAlias,nReg,nOpcx)

LOCAL wnrel		:= "MESPR001"
LOCAL cDesc1	:= STR0001	//"Emissao dos pedidos de compras ou autorizacoes de entrega"
LOCAL cDesc2	:= STR0002	//"cadastradados e que ainda nao foram impressos"
LOCAL cDesc3	:= " "
LOCAL cString	:= "SC7"
Local lComp		:= .T.	// Ativado habilita escolher modo RETRATO / PAISAGEM

PRIVATE lAuto		:= (nReg!=Nil)
PRIVATE Tamanho		:= "G"
PRIVATE titulo	 	:=STR0003										//"Emissao dos Pedidos de Compras ou Autorizacoes de Entrega"
PRIVATE aReturn 	:= {STR0004, 1,STR0005, 1, 2, 1, "",0 }		//"Zebrado"###"Administracao"
PRIVATE nomeprog	:="MESPR001"
PRIVATE nLastKey	:= 0
PRIVATE nBegin		:= 0
PRIVATE nDifColCC   := 0
PRIVATE aLinha		:= {}
PRIVATE aSenhas		:= {}
PRIVATE aUsuarios	:= {}
PRIVATE M_PAG		:= 1
If Type("lPedido") != "L"
	lPedido := .F.
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01               Do Pedido                             ³
//³ mv_par02               Ate o Pedido                          ³
//³ mv_par03               A partir da data de emissao           ³
//³ mv_par04               Ate a data de emissao                 ³
//³ mv_par05               Somente os Novos                      ³
//³ mv_par06               Campo Descricao do Produto    	     ³
//³ mv_par07               Unidade de Medida:Primaria ou Secund. ³
//³ mv_par08               Imprime ? Pedido Compra ou Aut. Entreg³
//³ mv_par09               Numero de vias                        ³
//³ mv_par10               Pedidos ? Liberados Bloqueados Ambos  ³
//³ mv_par11               Impr. SC's Firmes, Previstas ou Ambas ³
//³ mv_par12               Qual a Moeda ?                        ³
//³ mv_par13               Endereco de Entrega                   ³
//³ mv_par14               todas ou em aberto ou atendidos       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
xMontax1()
Pergunte("MTR110",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se no SX3 o C7_CC esta com tamanho 9 (Default) se igual a 9 muda o tamanho do relatorio           ³
//³ para Medio possibilitando a impressao em modo Paisagem ou retrato atraves da reducao na variavel nDifColCC ³
//³ se o tamanho do C7_CC no SX3 estiver > que 9 o relatorio sera impresso comprrimido com espaco para o campo ³
//³ C7_CC centro de custo para ate 20 posicoes,Obs.desabilitando a selecao do modo de impresso retrato/paisagem³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SX3")
dbSetOrder(2)
If dbSeek("C7_CC")
	If SX3->X3_TAMANHO == 9
		nDifColCC := 11
		Tamanho   := "M"
	Else
		lComp	  := .F.   // C.Custo c/ tamanho maior que 9, sempre PAISAGEM
	Endif
Endif

wnrel:=SetPrint(cString,wnrel,If(lAuto,Nil,"MTR110"),@Titulo,cDesc1,cDesc2,cDesc3,.F.,,lComp,Tamanho,,!lAuto)

If nLastKey <> 27

	SetDefault(aReturn,cString)

	If lAuto
		mv_par08 := SC7->C7_TIPO
	EndIf
	
	If lPedido
		mv_par12 := MAX(SC7->C7_MOEDA,1)
	Endif
	
	If mv_par08 == 1
		RptStatus({|lEnd| RPCREL0(@lEnd,wnRel,cString,nReg)},titulo)
	Else
		RptStatus({|lEnd| RPCREL1(@lEnd,wnRel,cString,nReg)},titulo)
	EndIf

	lPedido := .F.
	
Else 
	dbClearFilter()
EndIf

Return .T.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ RPCREL0  ³ Autor ³ Valdemir Miranda     ³ Data ³ 13/10/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Chamada do Relatorio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MTR110			                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function RPCREL0(lEnd,WnRel,cString,nReg)
Local nReem
Local nOrder
Local cCondBus
Local nSavRec
Local aPedido := {}
Local aPedMail:= {}
Local aSavRec := {}
Local nLinObs := 0
Local i       := 0
Local cFiltro := ""

Private cCGCPict, cCepPict
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Definir as pictures                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cCepPict:=PesqPict("SA2","A2_CEP")
cCGCPict:=PesqPict("SA2","A2_CGC")

If nDifColCC < 11
	limite   := 139
Else
	limite   := 129
Endif

li       := 80
nDescProd:= 0
nTotal   := 0
nTotMerc := 0
NumPed   := Space(6)

If lAuto
	dbSelectArea("SC7")
	dbGoto(nReg)
	SetRegua(1)
	mv_par01 := C7_NUM
	mv_par02 := C7_NUM
	mv_par03 := C7_EMISSAO
	mv_par04 := C7_EMISSAO
	mv_par05 := 2
	mv_par08 := C7_TIPO
	mv_par09 := 1
	mv_par10 := 3
	mv_par11 := 3
	mv_par14 := 1
EndIf

If ( cPaisLoc$"ARG|POR|EUA" )
	cCondBus	:=	"1"+strzero(val(mv_par01),6)
	nOrder	:=	10
	nTipo		:= 1
Else
	cCondBus	:=mv_par01
	nOrder	:=	1
EndIf

If mv_par14 == 2
	cFiltro := "SC7->C7_QUANT-SC7->C7_QUJE <= 0 .Or. !EMPTY(SC7->C7_RESIDUO)"
Elseif mv_par14 == 3
	cFiltro := "SC7->C7_QUANT > SC7->C7_QUJE"
EndIf

dbSelectArea("SC7")
dbSetOrder(nOrder)
SetRegua(RecCount())
dbSeek(xFilial("SC7")+cCondBus,.T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Faz manualmente porque nao chama a funcao Cabec()                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
@ 0,0 PSay AvalImp(Iif(nDifColCC < 11,220,132))

While !Eof() .And. C7_FILIAL = xFilial("SC7") .And. C7_NUM >= mv_par01 .And. ;
		C7_NUM <= mv_par02

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Cria as variaveis para armazenar os valores do pedido        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nOrdem   := 1
	nReem    := 0
	cObs01   := " "
	cObs02   := " "
	cObs03   := " "
	cObs04   := " "

	If	C7_EMITIDO == "S" .And. mv_par05 == 1
		dbSkip()
		Loop
	Endif
	If	(C7_CONAPRO == "B" .And. mv_par10 == 1) .Or.;
		(C7_CONAPRO != "B" .And. mv_par10 == 2)
		dbSkip()
		Loop
	Endif
	If	(C7_EMISSAO < mv_par03) .Or. (C7_EMISSAO > mv_par04)
		dbSkip()
		Loop
	Endif
	If	C7_TIPO == 2
		dbSkip()
		Loop
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste este item. EM ABERTO                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par14 == 2
		If SC7->C7_QUANT-SC7->C7_QUJE <= 0 .Or. !EMPTY(SC7->C7_RESIDUO)
			dbSelectArea("SC7")
			dbSkip()
			Loop
		Endif
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste este item. ATENDIDOS                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par14 == 3
		If SC7->C7_QUANT > SC7->C7_QUJE
			dbSelectArea("SC7")
			dbSkip()
			Loop
		Endif
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Filtra Tipo de SCs Firmes ou Previstas                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !MtrAValOP(mv_par11, 'SC7')
		dbSkip()
		Loop
	EndIf

	MaFisEnd()
	MaFisIniPC(SC7->C7_NUM,,,cFiltro)

	For ncw := 1 To mv_par09		// Imprime o numero de vias informadas

		RCABECP()
	Next
	MaFisEnd()

	If Len(aSavRec)>0
		For i:=1 to Len(aSavRec)
			dbGoto(aSavRec[i])
			RecLock("SC7",.F.)  //Atualizacao do flag de Impressao
			Replace C7_QTDREEM With (C7_QTDREEM+1)
			Replace C7_EMITIDO With "S"
			MsUnLock()
		Next
		dbGoto(aSavRec[Len(aSavRec)])		// Posiciona no ultimo elemento e limpa array
	Endif

	Aadd(aPedMail,aPedido)

	aSavRec := {}

	dbSkip()
EndDo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Executa o ponto de entrada M110MAIL quando a impressao for   ³
//³ enviada por email, fornecendo um Array para o usuario conten ³
//³ do os pedidos enviados para possivel manipulacao.            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ExistBlock("M110MAIL")
	lEnvMail := HasEmail(,,,,.F.)
	If lEnvMail
		Execblock("M110MAIL",.F.,.F.,{aPedMail})
	EndIf
EndIf

dbSelectArea("SC7")
dbClearFilter()
dbSetOrder(1)

dbSelectArea("SX3")
dbSetOrder(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se em disco, desvia para Spool                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If aReturn[5] == 1    // Se Saida para disco, ativa SPOOL
	Set Printer TO
	dbCommitAll()
	ourspool(wnrel)
Endif

MS_FLUSH()

Return .T.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ RPCREL1   ³ Autor ³ vALDEMIR MIRANDA    ³ Data ³13/10/2006 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Chamada do Relatorio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MTR110		                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function RPCREL1(lEnd,WnRel,cString,nReg)
Local nReem
Local nSavRec,aSavRec := {}
Local aPedido := {}
Local aPedMail:= {}
Local nLinObs := 0
Local i       := 0
Local cFiltro := ""

Private cCGCPict, cCepPict
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Definir as pictures                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cCepPict:=PesqPict("SA2","A2_CEP")
cCGCPict:=PesqPict("SA2","A2_CGC")

If nDifColCC < 11
	limite   := 139
Else
	limite   := 129
Endif

li       := 80
nDescProd:= 0
nTotal   := 0
nTotMerc := 0
NumPed   := Space(6)

If !lAuto
	dbSelectArea("SC7")
	dbSetOrder(10)
	dbSeek(xFilial("SC7")+"2"+mv_par01,.T.)
Else
	dbSelectArea("SC7")
	dbGoto(nReg)
	mv_par01 := C7_NUM
	mv_par02 := C7_NUM
	mv_par03 := C7_EMISSAO
	mv_par04 := C7_EMISSAO
	mv_par05 := 2
	mv_par08 := C7_TIPO
	mv_par09 := 1
	mv_par10 := 3
	mv_par11 := 3
	dbSelectArea("SC7")
	dbSetOrder(10)
	dbSeek(xFilial("SC7")+"2"+mv_par01,.T.)
EndIf

If mv_par14 == 2
	cFiltro := "SC7->C7_QUANT-SC7->C7_QUJE <= 0 .Or. !EMPTY(SC7->C7_RESIDUO)"
Elseif mv_par14 == 3
	cFiltro := "SC7->C7_QUANT > SC7->C7_QUJE"
EndIf

SetRegua(Reccount())
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Faz manualmente porque nao chama a funcao Cabec()                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
@ 0,0 PSay AvalImp(Iif(nDifColCC < 11,220,132))  

dbSelectArea("SC7")
dbSetOrder(10)
dbSeek(xFilial("SC7")+"2"+mv_par01,.T.)

While !Eof().And.C7_FILIAL = xFilial("SC7") .And. C7_NUM <= mv_par02  // C7_NUM >= mv_par01 .And. C7_NUM <= mv_par02
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Cria as variaveis para armazenar os valores do pedido        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nOrdem   := 1
	nReem    := 0
	cObs01   := " "
	cObs02   := " "
	cObs03   := " "
	cObs04   := " "

	If	C7_EMITIDO == "S" .And. mv_par05 == 1
		dbSelectArea("SC7")
		dbSkip()
		Loop
	Endif
	If	(C7_CONAPRO == "B" .And. mv_par10 == 1) .Or.;
		(C7_CONAPRO != "B" .And. mv_par10 == 2)
		dbSelectArea("SC7")
		dbSkip()
		Loop
	Endif
	If	(SC7->C7_EMISSAO < mv_par03) .Or. (SC7->C7_EMISSAO > mv_par04)
		dbSelectArea("SC7")
		dbSkip()
		Loop
	Endif
	If	SC7->C7_TIPO != 2
		dbSelectArea("SC7")
		dbSkip()
		Loop
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste este item. EM ABERTO                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par14 == 2
		If SC7->C7_QUANT-SC7->C7_QUJE <= 0 .Or. !EMPTY(SC7->C7_RESIDUO)
			dbSelectArea("SC7")
			dbSkip()
			Loop
		Endif
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste este item. ATENDIDOS                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par14 == 3
		If SC7->C7_QUANT > SC7->C7_QUJE
			dbSelectArea("SC7")
			dbSkip()
			Loop
		Endif
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Filtra Tipo de SCs Firmes ou Previstas                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !MtrAValOP(mv_par11, 'SC7')
		dbSelectArea("SC7")
		dbSkip()
		Loop
	EndIf

	MaFisEnd()
	MaFisIniPC(SC7->C7_NUM,,,cFiltro)

	For ncw := 1 To mv_par09		// Imprime o numero de vias informadas
		dbGoto(nSavRec)
		rcabecp()
	Next

	MaFisEnd()

	If Len(aSavRec)>0
		dbGoto(aSavRec[Len(aSavRec)])
		For i:=1 to Len(aSavRec)
			dbGoto(aSavRec[i])
			RecLock("SC7",.F.)  //Atualizacao do flag de Impressao
			Replace C7_EMITIDO With "S"
			Replace C7_QTDREEM With (C7_QTDREEM+1)
			MsUnLock()
		Next
	Endif

	Aadd(aPedMail,aPedido)

	aSavRec := {}

	dbSelectArea("SC7")
	dbSkip()
End

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Executa o ponto de entrada M110MAIL quando a impressao for   ³
//³ enviada por email, fornecendo um Array para o usuario conten ³
//³ do os pedidos enviados para possivel manipulacao.            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ExistBlock("M110MAIL")
	lEnvMail := HasEmail(,,,,.F.)
	If lEnvMail
		Execblock("M110MAIL",.F.,.F.,{aPedMail})
	EndIf
EndIf

dbSelectArea("SC7")
dbClearFilter()
dbSetOrder(1)

dbSelectArea("SX3")
dbSetOrder(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se em disco, desvia para Spool                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If aReturn[5] == 1    // Se Saida para disco, ativa SPOOL
	Set Printer TO
	Commit
	ourspool(wnrel)
Endif

MS_FLUSH()

Return .T.


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³xMontax1  ºAutor  ³Valdemir Miranda    º Data ³ 13/10/2006  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ MATR110                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function xMontax1()

Local aHelpPor	:= {}
Local aHelpEng	:= {}
Local aHelpSpa	:= {}

Aadd( aHelpPor, "Filtra os itens do PC a serem impressos " )
Aadd( aHelpPor, "Todos,somente os abertos ou Atendidos.  " )

Aadd( aHelpEng, "                                        " )
Aadd( aHelpEng, "                                        " )

Aadd( aHelpSpa, "                                        " )
Aadd( aHelpSpa, "                                        " )

PutSx1("MTR110","14","Lista quais ?       ","Cuales Lista ?      ","List which ?        ","mv_che","N",1,0,1,"C","","","","","mv_par14",;
"Todos ","Todos ","All ","","Em Aberto ","En abierto ","Open ","Atendidos ","Atendidos ","Serviced ","","","","","","","","","","")
PutSX1Help("P.MTR11014.",aHelpPor,aHelpEng,aHelpSpa)

Return            

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ RCABECP  ³ Autor ³ Valdemir Miranda      ³ Data ³04/10/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ LAY-OUT do Pedido de Compras / Autorizacao de Entrega      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ MATR110(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico SIGACOM                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function RCABECP() 
Local oDlg                    
LOCAL nBegin := 0, cDescri := "", nLinha:=0
Local	nTamDesc := 26, aColuna := Array(8)
Local nk		:= 1,nG
Local nX		:= 0
Local nQuebra	:= 0
Local nTotDesc	:= nDescProd
Local lNewAlc	:= .F.
Local lLiber 	:= .F.
Local lImpLeg	:= .T.
Local lImpLeg2	:= .F.
Local cComprador:=""
LOcal cAlter	:=""
Local cAprov	:=""
Local nTotIpi	:= MaFisRet(,'NF_VALIPI')
Local nTotIcms	:= MaFisRet(,'NF_VALICM')
Local nTotDesp	:= MaFisRet(,'NF_DESPESA')
Local nTotFrete	:= MaFisRet(,'NF_FRETE')
Local nTotalNF	:= MaFisRet(,'NF_TOTAL')
Local nTotSeguro:= MaFisRet(,'NF_SEGURO')
Local aValIVA   := MaFisRet(,"NF_VALIMP")
Local nValIVA   :=0
Local aColuna   := Array(8), nTotLinhas
Local nTxMoeda  := IIF(SC7->C7_TXMOEDA > 0,SC7->C7_TXMOEDA,Nil)
Local aSavRec := {}    
Local dt_emissao := Ctod("  /  /    ")  
Local c_Lidos := 0  
Local cVar    := ""
Private oFont09N,oFont09,oFont22N,oFont22,oFont20N,oFont20,oFont18N,oFont18,oFont16N,oFont16,oFont14N,oFont12N,oFont10N,oFont14,oFont12,oFont10,oFont08
Private nMargem   := -28   
Private oPrint
Private c_TotalPag     := 0
Private c_Resultado    := 0   
Private c_pagina       := 1

oFont22N	:= TFont():New("Times New Roman",22,22,,.T.,,,,.T.,.F.)
oFont22 	:= TFont():New("Times New Roman",22,22,,.F.,,,,.T.,.F.)
oFont20N	:= TFont():New("Times New Roman",20,20,,.T.,,,,.T.,.F.)
oFont20 	:= TFont():New("Times New Roman",20,20,,.F.,,,,.T.,.F.)
oFont18N	:= TFont():New("Times New Roman",18,18,,.T.,,,,.T.,.F.)
oFont18 	:= TFont():New("Times New Roman",18,18,,.F.,,,,.T.,.F.)
oFont16N	:= TFont():New("Times New Roman",16,16,,.T.,,,,.T.,.F.)
oFont16 	:= TFont():New("Times New Roman",16,16,,.F.,,,,.T.,.F.)
oFont14N	:= TFont():New("Times New Roman",14,14,,.T.,,,,.T.,.F.)
oFont14 	:= TFont():New("Times New Roman",14,14,,.F.,,,,.T.,.F.)
oFont12	    := TFont():New("Times New Roman",12,12,,.F.,,,,.T.,.F.)
oFont12N	:= TFont():New("Times New Roman",12,12,,.T.,,,,.T.,.F.)
oFont10	    := TFont():New("Times New Roman",10,10,,.F.,,,,.T.,.F.)
oFont10N	:= TFont():New("Times New Roman",10,10,,.T.,,,,.T.,.F.)
oFont09N	:= TFont():New("Times New Roman",09,09,,.T.,,,,.T.,.F.)
oFont09 	:= TFont():New("Times New Roman",09,09,,.F.,,,,.T.,.F.)
oFont08	    := TFont():New("Times New Roman",08,08,,.F.,,,,.T.,.F.)  
oFont08N    := TFont():New("Times New Roman",08,08,,.T.,,,,.T.,.F.)   
oFont07	    := TFont():New("Times New Roman",07,07,,.F.,,,,.T.,.F.)  
oFont07N    := TFont():New("Times New Roman",07,07,,.T.,,,,.T.,.F.)
oFont06	    := TFont():New("Times New Roman",06,06,,.T.,,,,.T.,.F.) 
                 
Public cFig := GetSrvProfString("StartPath","")
Public cfig2:= GetSrvProfString("StartPath","")
xObservacao := ""
oPrint    	:= TMSPrinter():New("PEDIDO DE COMPRAS")
oPrint      :Setup()   
// ... Inicia uma nova pagina ... //
oPrint:StartPage() 	

        
// ... Define Nome do Arquivo do Logotipo e seu Caminho ... //
cFig :=cFig+"LOGOMTL.BMP" 

// ... Copia Arquivo da Pasta Logotipo para a Pasta System ... //  
cFig2:=cfig2+"LOGOTIPO\LOGOMTL.BMP"  

If File(cFig)
   	__CopyFile(Substr(cFig,1,Len(cFig)-4)+".BKP",Substr(cFig,1,Len(cFig)-4)+".bmp") 
Endif

Set Century On
       
// ... Desenha Quadro Principal ... //
ImpBox(oPrint,90,60, 3130, 2300,4) 
oPrint:Line(90,650,350,650)
oPrint:Line(90,2000,350,2000)   

oPrint:Line(350,90,350,2300)
oPrint:Line(350,1170,610,1170) 

// ... Box da Razao Social da Empresa e do Cliente ... //
oPrint:Line(350,60,350,2300) 
oPrint:Line(610,1150,610,1150)

// ...   
oPrint:Line(610,60,610,2300) 
oPrint:Line(670,60,670,2300) 
oPrint:Line(2000,60,2000,2300)
oPrint:Line(610,180,2000,180)
oPrint:Line(610,380,2000,380) 

oPrint:Line(610,980,2000,980)
oPrint:Line(610,1080,2000,1080)

oPrint:Line(610,1280,2080,1280)
oPrint:Line(610,1530,2000,1530)

oPrint:Line(610,1680,2000,1680)
oPrint:Line(610,1880,2000,1880) 

oPrint:Line(610,2030,2000,2030)
oPrint:Line(610,2140,2000,2140)
oPrint:Line(610,2300,2000,2300)


// ... Imprime Logotipo ... //
oPrint:SayBitmap(100,70,cFig,500,200)

// ... Captura Variaveis do Cabecalho ... //
cMoeda := Iif(mv_par12<10,Str(mv_par12,1),Str(mv_par12,2))

If mv_par08 == 1
	wmoeda:= GetMV("MV_MOEDA"+cMoeda) 	
Else
	wmoeda:=GetMV("MV_MOEDA"+cMoeda)  
EndIf

If ( Mv_PAR08==2 )
    wpedido:= SC7->C7_NUMSC + "/" + SC7->C7_NUM  	
Else
    wpedido:= SC7->C7_NUM+"/"+Str(ncw,2)
EndIf
dt_emissao := SC7->C7_EMISSAO
wvia:= IIf(SC7->C7_QTDREEM>0,Str(SC7->C7_QTDREEM+1,2)+STR0034," ")		//"a.Emissao "###"a.VIA"

// ... Imprime Cabecalho ... // 
//oPrint:Say(150,860,"PEDIDO DE COMPRAS - "+wmoeda, oFont20N)
oPrint:Say(150,1000,"PEDIDO DE COMPRAS", oFont22N)
oPrint:Say(180,2040,dtoc(dt_emissao) , oFont16N) 

oPrint:Say(210,1180,wpedido , oFont20N) 

//oPrint:Say(210,2030,wvia , oFont14N) 
//oPrint:Say(270,2030,Str(ncw,2)+STR0035 , oFont14N)   

// ... Imprime Razao Social da Mult-Lock ... //

/*
oPrint:Say(380,110,SM0->M0_NOMECOM , oFont12N)
oPrint:Say(430,110,SM0->M0_ENDCOB , oFont10N)      
oPrint:Say(470,110,SM0->M0_CIDCOB+" - "+SM0->M0_ESTCOB+" Cep: "+LEFT(SM0->M0_CEPCOB,5)+"."+SUBSTR(SM0->M0_CEPCOB,6,3), oFont10N)        
oPrint:Say(510,110,"Telefone: "+SM0->M0_TEL+" Fax: "+SM0->M0_FAX , oFont10N) 

WCNPJ:=SUBSTR(SM0->M0_CGC,1,2)+"."+SUBSTR(SM0->M0_CGC,3,3)+"."+SUBSTR(SM0->M0_CGC,6,3)+"/"+SUBSTR(SM0->M0_CGC,9,4)+"-"+SUBSTR(SM0->M0_CGC,13,2)
oPrint:Say(550,110,"CNPJ    : "+WCNPJ+"    Insc.Est.: "+SM0->M0_INSC, oFont10N)
*/

oPrint:Say(380,110,"MUL-T-LOCK DO BRASIL IND.COM.LTDA" , oFont12N)
oPrint:Say(430,110,"PCA. PAULO GIANOTTI, 17" , oFont10N)      
oPrint:Say(470,110,"SAO PAULO - SP    Cep: 01127-050", oFont10N)        
oPrint:Say(510,110,"Telefone: (11) 3351-7777   Fax: (11) 3351-7776", oFont10N) 
oPrint:Say(550,110,"CNPJ  : 58.609.553/0001-26 Insc.Est.: 149.778.344.115", oFont10N)

// ... Imprime Razao Social do Fornecedor ... //   
wpesq:=XFILIAL("SA2")+SC7->C7_FORNECE+SC7->C7_LOJA
DbSelectArea("SA2")
DbSetOrder(1)
IF DbSeek(xFilial("SA2")+SC7->C7_FORNECE+SC7->C7_LOJA,.T.)
   WCODIGO   :=A2_COD
   wnome     :=A2_NOME
   wendereco :=A2_END+', '+A2_XNUM
   wbairro   :=A2_BAIRRO
   WCIDADE   :=A2_MUN
   WESTADO   :=A2_EST
   WCEP      :=A2_CEP
   WCGC      :=A2_CGC
   WCONTATO  :=A2_CONTATO
   WFONE     :=A2_TEL
   WFAX      :=A2_FAX
else
   WCODIGO   :=SC7->C7_FORNECE+SC7->C7_LOJA
   wnome     :=""
   wendereco :=""
   wbairro   :=""
   WCIDADE   :=""
   WESTADO   :=""
   WCEP      :=""
   WCGC      :=""
   WCONTATO  :=""
   WFONE     :=""
   WFAX      :=""
endif

// ...
oPrint:Say(380,1190,WCODIGO+" - "+wnome , oFont12)
oPrint:Say(430,1190,WENDERECO , oFont10)      
oPrint:Say(470,1190,WBAIRRO+" - "+WCIDADE+" - "+WESTADO+" Cep: "+LEFT(WCEP,5)+"."+SUBSTR(WCEP,6,3), oFont10)        

WCNPJ:=SUBSTR(WCGC,1,2)+"."+SUBSTR(WCGC,3,3)+"."+SUBSTR(WCGC,6,3)+"/"+SUBSTR(WCGC,9,4)+"-"+SUBSTR(WCGC,13,2)
oPrint:Say(510,1190,"CNPJ   : "+WCNPJ+"  Fone: "+WFONE, oFont08) 

oPrint:Say(550,1190,"Contato: "+wcontato , oFont10) 

// ... Captura Status de Liberacao do Pedido ... //
dbSelectArea("SC7")
If !Empty(C7_APROV)
	lNewAlc := .T.
	cComprador := UsrFullName(SC7->C7_USER)
	If C7_CONAPRO != "B"
		lLiber := .T.
	EndIf

	dbSelectArea("SCR")
	dbSetOrder(1)
	dbSeek(xFilial("SCR")+"PC"+SC7->C7_NUM)
	While !Eof() .And. SCR->CR_FILIAL+Alltrim(SCR->CR_NUM)==xFilial("SCR")+SC7->C7_NUM .And. SCR->CR_TIPO == "PC"
		cAprov += AllTrim(UsrFullName(SCR->CR_USER))+" ["
        Do Case
        	Case SCR->CR_STATUS=="03" //Liberado
        		cAprov += "Ok"
        	Case SCR->CR_STATUS=="04" //Bloqueado
        		cAprov += "BLQ"
			Case SCR->CR_STATUS=="05" //Nivel Liberado
				cAprov += "##"
			OtherWise                 //Aguar.Lib
				cAprov += "??"
		EndCase
		cAprov += "] - "
		dbSelectArea("SCR")
		dbSkip()
	Enddo    
	
	If !Empty(SC7->C7_GRUPCOM)
		dbSelectArea("SAJ")
		dbSetOrder(1)
		dbSeek(xFilial("SAJ")+SC7->C7_GRUPCOM)
		While !Eof() .And. SAJ->AJ_FILIAL+SAJ->AJ_GRCOM == xFilial("SAJ")+SC7->C7_GRUPCOM
			If SAJ->AJ_USER != SC7->C7_USER
				cAlter += AllTrim(UsrFullName(SAJ->AJ_USER))+"/"
			EndIf
			dbSelectArea("SAJ")
			dbSkip()
		EndDo
	EndIf
EndIf
// ... Imprime Cabecalho dos Itens do Pedido ... //  
oPrint:Say(630,110,"Item" , oFont09N) 
oPrint:Say(630,200,"Codigo" , oFont09N) 
oPrint:Say(630,400,"Descricao" , oFont09N)
oPrint:Say(630,1000,"Unid." , oFont09N)
oPrint:Say(630,1100,"Quant." , oFont09N)
oPrint:Say(630,1300,"Valor Unitario" , oFont09N)
oPrint:Say(630,1550,"IPI" , oFont09N)
oPrint:Say(630,1700,"Valor Total" , oFont09N)
oPrint:Say(630,1900,"Entrega" , oFont09N)
oPrint:Say(630,2050,"CC" , oFont09N)
//oPrint:Say(630,2150,"S.C" , oFont09N)   
oPrint:Say(630,2175,"S.C" , oFont09N)   

// ... Imprime Itens do Pedido ... //   
dbSelectArea("SC7")
cAlias := Alias()
oNumFolha := FCtaPed(SC7->C7_NUM)                       
If	oNumFolha 	>	13
		// Calcula total de paginas da Nota Fiscal.
		c_TotalPag:= oNumFolha/13   
		c_Resultado := c_TotalPag - INT(c_TotalPag)
		If	c_Resultado	> 	0
			c_TotalPag:= ( c_TotalPag + (Round((oNumFolha/13),0)))
		EndIf
EndIf

nDescProd:= 0
nReem    := SC7->C7_QTDREEM + 1
nSavRec  := SC7->(Recno())
NumPed   := SC7->C7_NUM
nLinObs := 0
aPedido  := {SC7->C7_FILIAL,SC7->C7_NUM,SC7->C7_EMISSAO,SC7->C7_FORNECE,SC7->C7_LOJA,SC7->C7_TIPO}

li:=680             

While !Eof() .And. C7_FILIAL = xFilial("SC7") .And. C7_NUM == NumPed

	  //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	  //³ Consiste este item. EM ABERTO                                ³
	  //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	  If mv_par14 == 2
		 If SC7->C7_QUANT-SC7->C7_QUJE <= 0 .Or. !EMPTY(SC7->C7_RESIDUO)
			dbSelectArea("SC7")
			dbSkip()
			Loop
		Endif
      Endif

	  //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	  //³ Consiste este item. ATENDIDOS                                ³
	  //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	  If mv_par14 == 3
	     If SC7->C7_QUANT > SC7->C7_QUJE
			dbSelectArea("SC7")
			dbSkip()
			Loop
		 Endif
      Endif

	  If Ascan(aSavRec,Recno()) == 0		// Guardo recno p/gravacao
	     AADD(aSavRec,Recno())
      Endif

/*
	  If lEnd
	     @PROW()+1,001 PSAY STR0006		//"CANCELADO PELO OPERADOR"
		 Goto Bottom
		 Exit
      Endif
*/

	  IncRegua()

	  If Empty(mv_par06)
		 mv_par06 := "B1_DESC"
	  EndIf

	  //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	  //³ Impressao da descricao generica do Produto.                  ³
	  //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	  If AllTrim(mv_par06) == "B1_DESC"
		 dbSelectArea("SB1")
		 dbSetOrder(1)
		 dbSeek( xFilial("SB1")+SC7->C7_PRODUTO )
		 cDescri := Alltrim(SB1->B1_DESC)
		 dbSelectArea("SC7")
	  EndIf  
	  
	  //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
      //³ Impressao da descricao cientifica do Produto.                ³
	  //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	  If AllTrim(mv_par06) == "B5_CEME"
		 dbSelectArea("SB5")
		 dbSetOrder(1)
		 If dbSeek( xFilial("SB5")+SC7->C7_PRODUTO )
			cDescri := Alltrim(B5_CEME)
		 EndIf
		 dbSelectArea("SC7")
	  EndIf

	  dbSelectArea("SC7")
	  If AllTrim(mv_par06) == "C7_DESCRI"
		 cDescri := Alltrim(SC7->C7_DESCRI)
	  EndIf

	  If Empty(cDescri)
		 dbSelectArea("SB1")
		 dbSetOrder(1)
		 MsSeek( xFilial("SB1")+SC7->C7_PRODUTO )
		 cDescri := alltrim(SB1->B1_DESC)
		 dbSelectArea("SC7")
	  EndIf

	  dbSelectArea("SA5")
	  dbSetOrder(1)
	  If dbSeek(xFilial("SA5")+SC7->C7_FORNECE+SC7->C7_LOJA+SC7->C7_PRODUTO).And. !Empty(SA5->A5_CODPRF)
		 cDescri := cDescri + " ("+Alltrim(A5_CODPRF)+")"
	  EndIf 
	     
	  If MV_PAR07 == 2 .And. !Empty(SC7->C7_SEGUM)
	     wunidade:=Transform(SC7->C7_SEGUM,PesqPict("SC7","C7_UM"))
      Else
	     wunidade:=Transform(SC7->C7_UM,PesqPict("SC7","C7_UM"))
      EndIf

      If MV_PAR07 == 2 .And. !Empty(SC7->C7_QTSEGUM)
	     wquant:=Transform(SC7->C7_QTSEGUM,PesqPictQt("C7_QUANT",13))
      Else
	     wquant:=Transform(SC7->C7_QUANT,PesqPictQt("C7_QUANT",13))
      EndIf

      If MV_PAR07 == 2 .And. !Empty(SC7->C7_QTSEGUM)
	     wvlUnitar:=Transform(xMoeda((SC7->C7_TOTAL/SC7->C7_QTSEGUM),SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,,nTxMoeda),PesqPict("SC7","C7_PRECO",14, mv_par12))
      Else
	     wvlUnitar:=Transform(xMoeda(SC7->C7_PRECO,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,,nTxMoeda),PesqPict("SC7","C7_PRECO",14,mv_par12))
      EndIf
      
	  wnulsol:=""
      If mv_par08 == 1
	     If cPaisLoc == "BRA"
		    wvipi:=Transform(SC7->C7_IPI,"@E 99.99")
	     Else
		    wvipi:= "  "
         EndIf
      
	     wvaltot:=Transform(xMoeda(SC7->C7_TOTAL,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,,nTxMoeda),"@E 999,999,999.99")
         wdarf  :=Transform(SC7->C7_DATPRF,PesqPict("SC7","C7_DATPRF"))
	     wccust :=Transform(SC7->C7_CC,PesqPict("SC7","C7_CC",20))
         wnulsol:=SC7->C7_NUMSC
      Else
         wvaltot:=Transform(xMoeda(SC7->C7_TOTAL,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,,nTxMoeda),"@E 999,999,999.99")
         wdarf  :=Transform(SC7->C7_DATPRF,"@E 999,999,999.99")

    	// Tenta imprimir OP
	    If !Empty(SC7->C7_OP)
		   wccust :=STR0065
		   wccust :=SC7->C7_OP
	      // Caso Op esteja vazia imprime Centro de Custos
    	ElseIf !Empty(SC7->C7_CC)
	       wccust :=STR0066
	       wccust :=Transform(SC7->C7_CC,PesqPict("SC7","C7_CC",20))
	    EndIf
      EndIf

      nTotal  :=nTotal+SC7->C7_TOTAL
      nTotMerc:=MaFisRet(,"NF_TOTAL") 
      
      wqtd:=len(cDescri)
      wdescri2:=" "
      if wqtd > 27
         wdescri2:=substr(cDescri,28,(wqtd-27))
         wdescri:=substr(cDescri,1,(27))
      endif
      
      if li > 1880
         QuebraRoda()  
         RCABECP() //QuebraCab()
      endif
      
      oPrint:Say(li,110,transform(SC7->C7_ITEM,PesqPict("SC7","C7_ITEM")) , oFont08) 
	  oPrint:Say(li,200,Transform(SC7->C7_PRODUTO,PesqPict("SC7","C7_PRODUTO")) , oFont08) 
	  oPrint:Say(li,400,left(cDescri,27), oFont08)
	  oPrint:Say(li,1000,wunidade, oFont08)
	  oPrint:Say(li,1100,wquant, oFont08)
	  oPrint:Say(li,1300,wvlUnitar, oFont08)
	  oPrint:Say(li,1550,wvipi, oFont08)
	  oPrint:Say(li,1700,wvaltot, oFont08)
	  oPrint:Say(li,1900,wdarf, oFont07)
	  oPrint:Say(li,2040,wccust, oFont08)
	  oPrint:Say(li,2170,wnulsol, oFont08)  
	  
	  if !empty(wdescri2) 
	     li:=li+50
	     oPrint:Say(li,500,wdescri2, oFont08)
	  endif
	  
      li:=li+50
	  If SC7->C7_DESC1 != 0 .or. SC7->C7_DESC2 != 0 .or. SC7->C7_DESC3 != 0
	     nDescProd+= CalcDesc(SC7->C7_TOTAL,SC7->C7_DESC1,SC7->C7_DESC2,SC7->C7_DESC3)
	  Else
	 	nDescProd+=SC7->C7_VLDESC
	  Endif  

	  cCond := SC7->C7_COND

	  If !EMPTY(SC7->C7_OBS) .And. nLinObs < 5
//	     nLinObs++
		 cVar:="cObs"+Strzero(val(SC7->C7_ITEM),2) //StrZero(nLinObs,2)
		 Eval(MemVarBlock(cVar),SC7->C7_OBS)
	  Endif  
	  
	  IF !Empty(SC7->C7_OBS)      
	      c_Obs := "cObs"+Strzero(val(SC7->C7_ITEM),2)
	      if !empty(&c_Obs)  
	        c_Lidos := c_Lidos + 1
	        xObservacao := xObservacao + alltrim(&c_Obs) + " / "   
	      endif  
	  endif   
	     
	  dbSelectArea("SC7")
	  dbSkip()
EndDo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializacao da Observacao do Pedido.                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ     

If !EMPTY(xObservacao) 
   oPrint:Say(2410,90,"Observacoes", oFont09N)             
   nLin := 2450 
   nPos := 1
   nAte := 80                           
   FOR A:=1 TO c_Lidos
    	if !empty(Substr(xObservacao,nPos,nAte))  
      		oPrint:Say(nLin,90,Substr(xObservacao,nPos,nAte), oFont08)
     		nLin := nLin + 40
     		nPos := nAte + 1
   		endif
   next		
   c_Lidos := 0                
endif
 
If cPaisLoc <> "BRA" .And. !Empty(aValIVA)
   For nG:=1 to Len(aValIVA)
       nValIVA+=aValIVA[nG]
   Next
Endif

cMensagem:= Formula(C7_MSG)

If !Empty(cMensagem)
    li:=li+50
	oPrint:Say(li,500,Padc(cMensagem,129), oFont09N)
Endif
//dbGoto(nRegistro)
dbSelectArea( cAlias )

// ... Linha de Descontos ... //
oPrint:Say(2040,90,"DESCONTOS : " , oFont09N)  
oPrint:Say(2040,350,Transform(SC7->C7_DESC1,"999.99"), oFont09) 
oPrint:Say(2040,500," - "+Transform(SC7->C7_DESC2,"999.99"), oFont09)
oPrint:Say(2040,600," - "+Transform(SC7->C7_DESC3,"999.99"), oFont09) 

oPrint:Say(2040,690," - "+Transform(xMoeda(nTotDesc,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,,nTxMoeda),"@E 999,999,999.99"), oFont09)
//oPrint:Say(2030,1300,"Data de Emissao do Pedido: "+dtoc(dt_emissao) , oFont10)

oPrint:Line(2080,60,2080,2300)  

// ... Local de Entrega e Cobranca ... // 
cAlias := Alias()
dbSelectArea("SM0")
dbSetOrder(1)   // forca o indice na ordem certa
nRegistro := Recno()
dbSeek(SUBS(cNumEmp,1,2)+SC7->C7_FILENT) 

oPrint:Say(2110,90,"Endereco de Entrega " , oFont09N) 
If Empty(MV_PAR13)
//	oPrint:Say(2110,430,": "+SM0->M0_ENDENT+" - "+SM0->M0_CIDENT+" - "+SM0->M0_ESTENT+" Cep: "+LEFT(SM0->M0_CEPENT,5)+"-"+SUBSTR(SM0->M0_CEPENT,6,3), oFont09) 
	oPrint:Say(2110,430,": Pca. Paulo Gianotti, 17 -  Sao Paulo-SP   Cep: 01127-050", oFont09) 
Else  
    oPrint:Say(2110,430,": "+MV_PAR13, oFont09) 
Endif


oPrint:Say(2150,90,"Endereco de Cobranca", oFont09N)
//oPrint:Say(2150,430,": "+SM0->M0_ENDCOB+" - "+SM0->M0_CIDCOB+" - "+SM0->M0_ESTCOB+" Cep: "+LEFT(SM0->M0_CEPCOB,5)+"-"+SUBSTR(SM0->M0_CEPCOB,6,3), oFont09)
oPrint:Say(2150,430,": Pca. Paulo Gianotti, 17 -  Sao Paulo-SP   Cep: 01127-050", oFont09)
oPrint:Line(2190,60,2190,2300) 

//dbGoto(nRegistro) 

dbSelectArea( cAlias )

AreaSC7 := GetArea()

dbSetOrder(1)
dbSeek(xFilial("SC7")+mv_par01,.T.)

cCond := SC7->C7_COND

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Grade - Condicao de Pagamento   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oPrint:Line(2190,0830,2310,0830)
oPrint:Line(2190,1630,2310,1630)


oPrint:Line(2310,60,2310,2300)
 
dbSelectArea("SE4")
dbSetOrder(1)    
DbGotop()

DbSeek(xFilial("SE4")+cCond,.T.) 
oPrint:Say(2230,90,"Condicao de Pagamento: "+ cCond, oFont09N)
oPrint:Say(2270,90,Posicione("SE4",1,xFilial("SE4")+cCond,"SE4->E4_DESCRI"), oFont09)
restArea(AreaSC7)
    
dbSelectArea("SC7")                               
If cPaisLoc<>"BRA"
   aValIVA := MaFisRet(,"NF_VALIMP")
   nValIVA :=0
   If !Empty(aValIVA)
      For nY:=1 to Len(aValIVA)
	      nValIVA+=aValIVA[nY]
      Next nY
   EndIf
   wtotsimp:=xMoeda(nValIVA,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,,nTxMoeda) 
Else
   wtotsimp:=xMoeda(nTotMerc,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,,nTxMoeda)
Endif
		
nTotIpi	  := MaFisRet(,'NF_VALIPI')
nTotIcms  := MaFisRet(,'NF_VALICM')
nTotDesp  := MaFisRet(,'NF_DESPESA')
nTotFrete := MaFisRet(,'NF_FRETE')
nTotSeguro:= MaFisRet(,'NF_SEGURO')
nTotalNF  := MaFisRet(,'NF_TOTAL')

// ... Totais da Mercadoria ... //
wtotcimp:=xMoeda(nTotMerc,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,,nTxMoeda)

wfrete   :=xMoeda(nTotFrete,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,,nTxMoeda)  
wseguro  :=xMoeda(nTotSeguro,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,,nTxMoeda) 
wicms    :=0.00
wipi     :=0.00  
wdespesas:=xMoeda(nTotDesp,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,,nTxMoeda)
wgrupo   :=""
wobsfrete:=""  
wcomprador:=cComprador
wgerencia :=""
wdiretoria:=""   

If cPaisLoc == "BRA"
	wipi     :=xMoeda(nTotIPI,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,,nTxMoeda)
	wicms    :=xMoeda(nTotIcms,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,,nTxMoeda)
	
	wtotcimp :=xMoeda((nTotMerc+wipi),SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,,nTxMoeda)	
EndIf

If !lNewAlc
	wtotalf:=xMoeda(nTotalNF,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,,nTxMoeda)
    wobsfrete:=IF( SC7->C7_TPFRETE $ "F","FOB",IF(SC7->C7_TPFRETE $ "C","CIF"," " ))  
    wlibPedido:=IF(lLiber,STR0050,STR0051)
Else
	If lLiber
		wtotalf:=xMoeda(nTotalNF,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF,,nTxMoeda)
	Else
		wtotalf:=(STR0051)
	EndIf 

	cLiberador:= "mmmXXXmmmxxx"			// MAS - TRAZER NOME DO LIBERADOR
	
	wobsfrete :=IF( SC7->C7_TPFRETE $ "F","FOB",IF(SC7->C7_TPFRETE $ "C","CIF"," " ))
    wlibPedido:=(Space((30-Len(AllTrim(cLiberador)))/2)+AllTrim(cLiberador) )
    wcomprador:=Substr(cComprador,1,60) 
    wdiretoria:=STR0060 
    
    nAuxLin := Len(cAlter)
	While nAuxLin > 0 .Or. lImpLeg

		wcomprador:=Substr(cAlter,Len(cAlter)-nAuxLin+1,60)
		If lImpLeg
			wdiretoria:=STR0061   //"Ok:Liberado"
			lImpLeg := .F.
		EndIf
		nAuxLin -= 60
		li++
	EndDo 
	
	nAuxLin := Len(cAprov)
	lImpLeg := .T.
	While nAuxLin > 0	.Or. lImpLeg
		If lImpLeg  // Imprimir soh a 1a vez
			wcomprador:=STR0054		//"Aprovador(es) :"
		EndIf
		wcomprador:=Substr(cAprov,Len(cAprov)-nAuxLin+1,70)
		If lImpLeg2  // Imprimir soh a 2a vez
			wdiretoria:=STR0067 //"##:Nivel.Lib"
			lImpLeg2 := .F.
		EndIf
		If lImpLeg   // Imprimir soh a 1a vez
			wdiretoria:=STR0062  //"??:Aguar.Lib"
			lImpLeg  := .F.
			lImpLeg2 := .T.
		EndIf
		nAuxLin -=70
	EndDo
    
    If lImpLeg2
		lImpLeg2 := .F.
		wdiretoria:=STR0067 //"##:Nivel Lib"
	EndIf
    
EndIf


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime - Total de Mercadorias  /  Centro de Custo  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

/*
oPrint:Say(2230,1200,"Total das Mercadorias" , oFont09N)
oPrint:Say(2230,1530,": "+Transform(wtotsimp,"@E 999,999,999.99") , oFont09)
oPrint:Say(2270,1200,"Total Com Impostos", oFont09N)
oPrint:Say(2270,1500,": "+Transform(wtotcimp,"@E 999,999,999.99") , oFont09) 
*/

oPrint:Say(2230,0850,"Total das Mercadorias" , oFont09N)
oPrint:Say(2230,1150,": "+Transform(wtotsimp,"@E 999,999,999.99") , oFont09)
oPrint:Say(2270,0850,"Total Com Impostos", oFont09N)
oPrint:Say(2270,1150,": "+Transform(wtotcimp,"@E 999,999,999.99") , oFont09) 

/*
oPrint:Say(2230,1650,"Centro de Custo" , oFont09N)
//oPrint:Say(2230,1150,": "+Transform(wtotsimp,"@E 999,999,999.99") , oFont09)
oPrint:Say(2270,1700,"Codigo CC  +  Descricao", oFont09N)
//oPrint:Say(2270,1150,": "+Transform(wtotcimp,"@E 999,999,999.99") , oFont09) 
*/


oPrint:Line(2310,280,2390,280)
oPrint:Line(2310,580,2390,580)
oPrint:Line(2310,830,2390,830) 
oPrint:Line(2310,1130,2390,1130)
oPrint:Line(2310,1380,2390,1380)
oPrint:Line(2310,1630,2390,1630)
oPrint:Line(2310,1880,2390,1880) 
oPrint:Line(2390,60,2390,2300)

oPrint:Say(2340,90,"Frete " , oFont09N)
oPrint:Say(2340,150,": "+Transform(wfrete,"@E 999,999.99") , oFont09) 

oPrint:Say(2340,300,"Seguro " , oFont09N)
oPrint:Say(2340,400,": "+Transform(wseguro,"@E 999,999.99") , oFont09)  

oPrint:Say(2340,600,"ICMS " , oFont09N)
oPrint:Say(2340,680,": "+Transform(wicms,"@E 999,999.99") , oFont09) 

oPrint:Say(2340,850,"IPI " , oFont09N)
oPrint:Say(2340,950,": "+Transform(wipi,"@E 999,999.99") , oFont09) 

oPrint:Say(2340,1150,"Despesas " , oFont09N)
oPrint:Say(2340,1250,": "+Transform(wdespesas,"@E 999,999.99") , oFont09) 

oPrint:Say(2340,1400,"Grupo " , oFont09N)
oPrint:Say(2340,1500,": "+wgrupo , oFont09)  
 
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa Total Geral do Pedido.                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oPrint:Say(2340,1900,"Total Geral : " , oFont09N)
oPrint:Say(2330,2050,": "+Transform(wtotalf,"@E 999,999,999.99") , oFont09)  

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa Valor do Reajuste.                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SM4")
dbSetOrder(1)
dbSeek(xFilial("SM4")+SC7->C7_REAJUST)
dbSelectArea("SC7")

wreajuste:=SC7->C7_REAJUST
wobsReajust:=SM4->M4_DESCR 
oPrint:Line(2390,1390,2750,1390)
oPrint:Say(2450,1400,"Reajuste " , oFont09N)
oPrint:Say(2450,1500,": "+SC7->C7_REAJUST, oFont09) 
oPrint:Say(2490,1400,wobsReajust , oFont09)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa campos de Observacoes.                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//If Empty(cObs02)
//	If Len(cObs01) > 50
//		cObs 	:= cObs01
//		cObs01:= Substr(cObs,1,50)
//		For nX := 2 To 4
//			cVar  := "cObs"+StrZero(nX,2)
//			&cVar := Substr(cObs,(50*(nX-1))+1,50)
//		Next
//	EndIf
//Else
//	cObs01:= Substr(cObs01,1,IIf(Len(cObs01)<50,Len(cObs01),50))
//	cObs02:= Substr(cObs02,1,IIf(Len(cObs02)<50,Len(cObs01),50))
//	cObs03:= Substr(cObs03,1,IIf(Len(cObs03)<50,Len(cObs01),50))
//	cObs04:= Substr(cObs04,1,IIf(Len(cObs04)<50,Len(cObs01),50))
//EndIf

//oPrint:Say(2450,90,"Observacoes : " , oFont09N)  
//oPrint:Say(2490,90,cObs01, oFont09)
//oPrint:Say(2540,90,cObs02, oFont09)
//oPrint:Say(2590,90,cObs03, oFont09)
//oPrint:Say(26400,90,cObs04, oFont09)
  
oPrint:Say(2450,1930,"Obs. Frete : " + wobsfrete, oFont09N)

oPrint:Line(2390,1880,2750,1880)
oPrint:Line(2750,60,2750,2300)  

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializar campos de Autorizacao de Compras                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

dbSelectArea("SC7")
//dbSetOrder(1)
//dbSeek(xFilial("SC7")+cNumSC7,.T.)

csolicita  := alltrim(UsrFullName(GetAdvFval("SC1", "C1_USER", xFilial("SC1")+SC7->(C7_NUMSC+C7_ITEMSC), 1, 0)))
cComprador := alltrim(UsrFullName(SC7->C7_USER))
cAprovador := alltrim(UsrFullName(SC7->C7_APROV))

oPrint:Say(2790,90,"Solicitante: " + csolicita, oFont09N)
oPrint:Say(2790,800,"Comprador: " + cComprador, oFont09N) 
oPrint:Say(2790,1700,"Aprovador: " + cAprovador, oFont09N) 



oPrint:Line(2750,780,2840,780)
oPrint:Line(2750,1680,2840,1680)
oPrint:Line(2840,60,2840,2300)

//oPrint:Say(2880,900,"LIBERACAO DO PEDIDO", oFont14N) 
//oPrint:Say(2950,880,"__________________________" , oFont14N)

//oPrint:Say(2950,880, wlibPedido, oFont10N)
oPrint:Line(3010,60,3010,2300)
oPrint:Say(3050,90,"NOTA: So' aceitaremos a mercadoria se na sua NOTA FISCAL constar o Numero de Nosso Pedido de Compras.", oFont09N)

oPrint:EndPage()   
oPrint:Preview() 

RETURN      
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
/*/
Static Function QuebraRoda() 
oPrint:Say(2040,90,"DESCONTOS : " , oFont09N)  

oPrint:Say(2030,1300,"Data de Emissao do Pedido: ", oFont10N)

oPrint:Line(2080,60,2080,2300)  

// ... Local de Entrega e Cobranca ... // 
oPrint:Say(2110,90,"Endereco de Entrega " , oFont09N) 
oPrint:Say(2150,90,"Endereco de Cobranca", oFont09N)
oPrint:Line(2190,60,2190,2300) 
oPrint:Line(2190,1150,2310,1150)
oPrint:Line(2310,60,2310,2300)

oPrint:Say(2230,90,"Condicao de Pagamento: " , oFont09N)
oPrint:Say(2230,1200,"Total das Mercadorias" , oFont09N)
oPrint:Say(2270,1200,"Total Com Impostos", oFont09N)


oPrint:Line(2310,280,2390,280)
oPrint:Line(2310,580,2390,580)
oPrint:Line(2310,830,2390,830) 
oPrint:Line(2310,1130,2390,1130)
oPrint:Line(2310,1380,2390,1380)
oPrint:Line(2310,1630,2390,1630)
oPrint:Line(2310,1880,2390,1880) 
oPrint:Line(2390,60,2390,2300)

oPrint:Say(2340,90,"Frete " , oFont09N)

oPrint:Say(2340,300,"Seguro " , oFont09N)

oPrint:Say(2340,600,"ICMS " , oFont09N)

oPrint:Say(2340,850,"IPI " , oFont09N)

oPrint:Say(2340,1150,"Despesas " , oFont09N)

oPrint:Say(2340,1400,"Grupo " , oFont09N)
 
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa Total Geral do Pedido.                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oPrint:Say(2340,1900,"Total Geral : " , oFont09N)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa Valor do Reajuste.                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oPrint:Say(2450,1400,"Reajuste " , oFont09N)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa campos de Observacoes.                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oPrint:Say(2450,90,"Observacoes : " , oFont09N)  
//oPrint:Say(2490,90,"Continua na Proxima Folha", oFont09N)
//oPrint:Say(2540,90,cObs02, oFont09N)
  
oPrint:Say(2450,1930,"Obs. Frete : ", oFont09N)

oPrint:Line(2390,1880,2750,1880)
oPrint:Line(2750,60,2750,2300)  

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializar campos de Autorizacao de Compras                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oPrint:Say(2790,90,"Comprador: " , oFont09N)
oPrint:Say(2790,800,"Gerencia: " , oFont09N) 
oPrint:Say(2790,1700,"Diretoria: ", oFont09N) 

oPrint:Line(2750,780,2840,780)
oPrint:Line(2750,1680,2840,1680)
oPrint:Line(2840,60,2840,2300)

oPrint:Say(2880,900,"Continua na proxima folha... "+StrZero(c_pagina,2)+"  ate  : "+Strzero(c_TotalPag,2), oFont14N) 
c_pagina := c_pagina + 1
oPrint:Line(3010,60,3010,2300)
oPrint:Say(3050,90,"NOTA: So' aceitaremos a mercadoria se na sua NOTA FISCAL constar o Numero de Nosso Pedido de Compras.", oFont09N)

oPrint:EndPage()   
oPrint:Preview() 

Return 
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
/*/

Static Function QuebraCab()
oPrint    	:= TMSPrinter():New("PEDIDO DE COMPRAS")
oPrint      :Setup()   
oPrint		:StartPage() 	 
cFig 		:= GetSrvProfString("StartPath","")
cfig2		:= GetSrvProfString("StartPath","")

cFig 		:=cFig+"LOGOMTL.BMP" 
cFig2		:=cfig2+"LOGOTIPO\LOGOMTL.BMP"  

If File(cFig)
   	__CopyFile(Substr(cFig,1,Len(cFig)-4)+".BKP",Substr(cFig,1,Len(cFig)-4)+".bmp") 
Endif

Set Century On

ImpBox(oPrint,90,60, 3130, 2300,4) 
oPrint:Line(90,650,350,650)
oPrint:Line(90,2000,350,2000)   

oPrint:Line(350,90,350,2300)
oPrint:Line(350,1170,610,1170) 

// ... Box da Razao Social da Empresa e do Cliente ... //
oPrint:Line(350,60,350,2300) 
oPrint:Line(610,1150,610,1150)

// ...   
oPrint:Line(610,60,610,2300) 
oPrint:Line(670,60,670,2300) 
oPrint:Line(2000,60,2000,2300)
oPrint:Line(610,180,2000,180)
oPrint:Line(610,480,2000,480) 

oPrint:Line(610,980,2000,980)
oPrint:Line(610,1080,2000,1080)

oPrint:Line(610,1280,2080,1280)
oPrint:Line(610,1530,2000,1530)

oPrint:Line(610,1680,2000,1680)
oPrint:Line(610,1880,2000,1880) 

oPrint:Line(610,2030,2000,2030)
oPrint:Line(610,2130,2000,2130)
oPrint:Line(610,2300,2000,2300)


// ... Imprime Logotipo ... //
oPrint:SayBitmap(100,70,cFig,500,200)

// ... Captura Variaveis do Cabecalho ... //
cMoeda := Iif(mv_par12<10,Str(mv_par12,1),Str(mv_par12,2))

If mv_par08 == 1
	wmoeda:= GetMV("MV_MOEDA"+cMoeda) 	
Else
	wmoeda:=GetMV("MV_MOEDA"+cMoeda)  
EndIf

If ( Mv_PAR08==2 )
    wpedido:= SC7->C7_NUMSC + "/" + SC7->C7_NUM  	
Else
    wpedido:= SC7->C7_NUM+"/"+Str(ncw,2)
EndIf

wvia:= IIf(SC7->C7_QTDREEM>0,Str(SC7->C7_QTDREEM+1,2)+STR0034," ")		//"a.Emissao "###"a.VIA"

// ... Imprime Cabecalho ... // 
//oPrint:Say(150,860,"PEDIDO DE COMPRAS - "+wmoeda, oFont20N)
oPrint:Say(150,860,"PEDIDO DE COMPRAS", oFont20N)
oPrint:Say(150,2040,wpedido , oFont16N) 
oPrint:Say(210,860,"*** CONTINUANDO ***", oFont14N)
oPrint:Say(210,2030,wvia , oFont14N) 
oPrint:Say(270,2030,Str(ncw,2)+STR0035 , oFont14N)   

// ... Imprime Razao Social da Mult-Lock ... //
oPrint:Say(380,110,SM0->M0_NOMECOM , oFont12N)
oPrint:Say(430,110,SM0->M0_ENDCOB , oFont10N)      
oPrint:Say(470,110,SM0->M0_CIDCOB+" - "+SM0->M0_ESTCOB+" Cep: "+LEFT(SM0->M0_CEPCOB,5)+"."+SUBSTR(SM0->M0_CEPCOB,6,3), oFont10N)        

oPrint:Say(510,110,"Telefone: "+SM0->M0_TEL+" Fax: "+SM0->M0_FAX , oFont10N) 

WCNPJ:=SUBSTR(SM0->M0_CGC,1,2)+"."+SUBSTR(SM0->M0_CGC,3,3)+"."+SUBSTR(SM0->M0_CGC,6,3)+"/"+SUBSTR(SM0->M0_CGC,9,4)+"-"+SUBSTR(SM0->M0_CGC,13,2)
oPrint:Say(550,110,"CNPJ    : "+WCNPJ+"    Insc.Est.: "+SM0->M0_INSC, oFont10N)

// ... Imprime Razao Social do Fornecedor ... //   
wpesq:=XFILIAL("SA2")+SC7->C7_FORNECE+SC7->C7_LOJA
DBSELECTAREA("SA2")
DBSETORDER(1)
DBSEEK(WPESQ,.T.)
if .not. eof()   
   WCODIGO   :=A2_COD
   wnome     :=A2_NOME
   wendereco :=A2_END+', '+A2_XNUM
   wbairro   :=A2_BAIRRO
   WCIDADE   :=A2_MUN
   WESTADO   :=A2_EST
   WCEP      :=A2_CEP
   WCGC      :=A2_CGC
   WCONTATO  :=A2_CONTATO
   WFONE     :=A2_tel
   WFAX      :=a2_fax
else
   WCODIGO   :=A2_COD
   wnome     :=""
   wendereco :=""
   wbairro   :=""
   WCIDADE   :=""
   WESTADO   :=""
   WCEP      :=""
   WCGC      :=""
   WCONTATO  :=""
   WFONE     :=""
   WFAX      :=""
endif

// ...
oPrint:Say(380,1190,WCODIGO+" - "+wnome , oFont12N)
oPrint:Say(430,1190,WENDERECO , oFont10N)      
oPrint:Say(470,1190,WBAIRRO+" - "+WCIDADE+" - "+WESTADO+" Cep: "+LEFT(WCEP,5)+"."+SUBSTR(WCEP,6,3), oFont10N)        

WCNPJ:=SUBSTR(WCGC,1,2)+"."+SUBSTR(WCGC,3,3)+"."+SUBSTR(WCGC,6,3)+"/"+SUBSTR(WCGC,9,4)+"-"+SUBSTR(WCGC,13,2)
oPrint:Say(510,1190,"CNPJ   : "+WCNPJ+"  Fone: "+WFONE, oFont08N) 

oPrint:Say(550,1190,"Contato: "+wcontato , oFont10N) 

// ... Captura Status de Liberacao do Pedido ... //
dbSelectArea("SC7")
If !Empty(C7_APROV)
	lNewAlc := .T.
	cComprador := UsrFullName(SC7->C7_USER)
	If C7_CONAPRO != "B"
		lLiber := .T.
	EndIf

	dbSelectArea("SCR")
	dbSetOrder(1)
	dbSeek(xFilial("SCR")+"PC"+SC7->C7_NUM)
	While !Eof() .And. SCR->CR_FILIAL+Alltrim(SCR->CR_NUM)==xFilial("SCR")+SC7->C7_NUM .And. SCR->CR_TIPO == "PC"
		cAprov += AllTrim(UsrFullName(SCR->CR_USER))+" ["
        Do Case
        	Case SCR->CR_STATUS=="03" //Liberado
        		cAprov += "Ok"
        	Case SCR->CR_STATUS=="04" //Bloqueado
        		cAprov += "BLQ"
			Case SCR->CR_STATUS=="05" //Nivel Liberado
				cAprov += "##"
			OtherWise                 //Aguar.Lib
				cAprov += "??"
		EndCase
		cAprov += "] - "
		dbSelectArea("SCR")
		dbSkip()
	Enddo    
	
	If !Empty(SC7->C7_GRUPCOM)
		dbSelectArea("SAJ")
		 (1)
		dbSeek(xFilial("SAJ")+SC7->C7_GRUPCOM)
		While !Eof() .And. SAJ->AJ_FILIAL+SAJ->AJ_GRCOM == xFilial("SAJ")+SC7->C7_GRUPCOM
			If SAJ->AJ_USER != SC7->C7_USER
				cAlter += AllTrim(UsrFullName(SAJ->AJ_USER))+"/"
			EndIf
			dbSelectArea("SAJ")
			dbSkip()
		EndDo
	EndIf
EndIf


// ... Imprime Cabecalho dos Itens do Pedido ... //  
dbSelectArea("SC7")         
oPrint:Say(630,110,"Item" , oFont09N) 
oPrint:Say(630,200,"Codigo" , oFont09N) 
oPrint:Say(630,500,"Descricao" , oFont09N)
oPrint:Say(630,1000,"Unid." , oFont09N)
oPrint:Say(630,1100,"Quant." , oFont09N)
oPrint:Say(630,1300,"Valor Unitario" , oFont09N)
oPrint:Say(630,1550,"IPI" , oFont09N)
oPrint:Say(630,1700,"Valor Total" , oFont09N)
oPrint:Say(630,1900,"Entrega" , oFont09N)
oPrint:Say(630,2050,"CC" , oFont09N)
oPrint:Say(630,2150,"S.C" , oFont09N)   

// ... Imprime Itens do Pedido ... //
cAlias := Alias()

nDescProd:= 0
nReem    := SC7->C7_QTDREEM + 1
nSavRec  := SC7->(Recno())
NumPed   := SC7->C7_NUM
nLinObs := 0
aPedido  := {SC7->C7_FILIAL,SC7->C7_NUM,SC7->C7_EMISSAO,SC7->C7_FORNECE,SC7->C7_LOJA,SC7->C7_TIPO}

li:=680             

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ImpBox    ºAutor  ³Valdemir Miranda    º Data ³ 04/10/2006  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Imprime um box simulando o negrito                          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ ARS                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function ImpBox(oObj,nLin,nCol,nLinF,nColF,nPixel)
Local nwnk 
For nwnk := 1 to nPixel
	oObj:Box(nLin,nCol,nLinF,nColF)
	nLin++
	nCol++
	nLinF--
	nColF--
Next

Return
  
Static Function FCtaPed(oNumero)
Local oAlias := Alias()
Local oRecno := Recno()  
Local oCtaLidos := 0
DbSelectArea("SC7")
DbSetOrder(1)
DbSeek(xFilial("SC7")+oNumero,.T.)
While !Eof() .and. SC7->(C7_FILIAL+C7_NUM) == xFilial("SC7")+oNumero  
       oCtaLidos := oCtaLidos + 1
       DbSkip()
end
DbSelectArea(oAlias)
DbGoto(oRecno)
Return(oCtaLidos)