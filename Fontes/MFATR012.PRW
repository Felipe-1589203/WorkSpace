#INCLUDE "PROTHEUS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MFATR012  ºAutor  ³Mauro Nagata        º Data ³  23/12/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º          ³                                                            º±±
±±ºDesc.     ³ Este relatorio imprimi os valores faturados por segmento/  º±±
±±º          ³ vendedor.                                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Especifico Mul-T-Lock - www.actualtrend.com.br             º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function MFATR012()     

Local oReport
Private cPerg := "MFATR012"

oReport := ReportDef()
oReport:PrintDialog()

Return



/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Mauro Nagata          ³ Data ³ 23/12/11 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function ReportDef()

Local oReport
Local oEmissao
Local oDigit
Local oDocum
Local oFornec
Local cWhere	:= ""
Local cQueryAdd := ""
Local cAliasQry := GetNextAlias()


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao                                      ³
//³                                                                        ³
//³TReport():New                                                           ³
//³ExpC1 : Nome do relatorio                                               ³
//³ExpC2 : Titulo                                                          ³
//³ExpC3 : Pergunte                                                        ³
//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
//³ExpC5 : Descricao                                                       ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := TReport():New("MFATR012","Faturamento por Segmento/Vendedor",cPerg, {|oReport| ReportPrint(oReport,cAliasQry,oEmissao,oDigit,oDocum,oFornec)},"Faturamento por Segmento/Vendedor")
//oReport:SetLandscape()
oReport:SetPortrait()
oReport:SetTotalInLine(.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da secao utilizada pelo relatorio                               ³
//³                                                                        ³
//³TRSection():New                                                         ³
//³ExpO1 : Objeto TReport que a secao pertence                             ³
//³ExpC2 : Descricao da seçao                                              ³
//³ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   ³
//³        sera considerada como principal para a seção.                   ³
//³ExpA4 : Array com as Ordens do relatório                                ³
//³ExpL5 : Carrega campos do SX3 como celulas                              ³
//³        Default : False                                                 ³
//³ExpL6 : Carrega ordens do Sindex                                        ³
//³        Default : False                                                 ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oSegmento := TRSection():New(oReport,"Faturamento por Segmento/Vendedor",{"TRB","SA3","SA1","SD2","SC5"},{"Por Segmento/Vendedor"},/*Campos do SX3*/,/*Campos do SIX*/)
oSegmento:SetTotalInLine(.F.)
TRCell():New(oSegmento,"SEGMENTO"	,"TRB",RetTitle("C5_XORIGEM"),PesqPict("SC5","C5_XORIGEM"),TamSx3("C5_XORIGEM"	)[1],/*lPixel*/,{|| TRB->SEGMENTO})
TRCell():New(oSegmento,"VENDEDOR"	,"TRB",RetTitle("C5_VEND1")  ,PesqPict("SC5","C5_VEND1")  ,TamSx3("C5_VEND1"	)[1],/*lPixel*/,{|| TRB->VENDEDOR})
TRCell():New(oSegmento,"NOMEVEND"	,"TRB",RetTitle("A3_NOME")   ,PesqPict("SA3","A3_NOME")   ,TamSx3("A3_NOME"    )[1],/*lPixel*/,{|| TRB->NOMEVEND})
TRCell():New(oSegmento,"EMISSAO"	,"TRB",RetTitle("D2_EMISSAO"),PesqPict("SD2","D2_EMISSAO"),TamSx3("D2_EMISSAO"	)[1],/*lPixel*/,{|| TRB->EMISSAO})
TRCell():New(oSegmento,"CLIENTE"	,"TRB",RetTitle("D2_CLIENTE"),PesqPict("SD2","D2_CLIENTE"),TamSx3("D2_CLIENTE"	)[1],/*lPixel*/,{|| TRB->CLIENTE})
TRCell():New(oSegmento,"LOJA"	    ,"TRB",RetTitle("D2_LOJA")   ,PesqPict("SD2","D2_LOJA")   ,TamSx3("D2_LOJA"	)[1],/*lPixel*/,{|| TRB->LOJA})
TRCell():New(oSegmento,"NOMECLI"	,"TRB",RetTitle("A1_NOME")   ,PesqPict("SA1","A1_NOME")   ,TamSx3("A1_NOME"	)[1],/*lPixel*/,{|| TRB->RAZSOC})
TRCell():New(oSegmento,"TOTAL"   	,"TRB",RetTitle("D2_TOTAL")  ,PesqPict("SD2","D2_TOTAL")  ,TamSx3("D2_TOTAL"	)[1],/*lPixel*/,{|| If(MV_PAR09=1,TRB->TOTAL,TRB->TOTALIMP)})
TRCell():New(oSegmento,"DOC"	    ,"TRB",RetTitle("D2_DOC")    ,PesqPict("SD2","D2_DOC")    ,TamSx3("D2_DOC"	    )[1],/*lPixel*/,{|| TRB->DOC})
TRCell():New(oSegmento,"PEDIDO"	    ,"TRB",RetTitle("D2_PEDIDO") ,PesqPict("SD2","D2_PEDIDO") ,TamSx3("D2_PEDIDO"	)[1],/*lPixel*/,{|| TRB->PEDIDO})

oBreakVend:= TRBreak():New(oSegmento,{ || TRB->VENDEDOR },"Vendedor",.F.,,.F.)
oBreakSegm:= TRBreak():New(oSegmento,{ || TRB->SEGMENTO },"Segmento",.F.,,.T.)     
                                                                                             
//TRFunction():New(oColuna:Cell(/*cCampo*/),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,/*lEndReport*/,/*lEndPage*/,oRefer)
TRFunction():New(oSegmento:Cell('TOTAL'),, 'SUM',oBreakVend ,"Vendedor",,,.F.,.T.,.F.)
TRFunction():New(oSegmento:Cell('TOTAL'),, 'SUM',oBreakSegm ,"Segmento",,,.T.,.T.,.T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas  		    	                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AjustaSX1()
Pergunte(oReport:uParam,.F.)

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³ Mauro Nagata          ³ Data ³ 05/11/11 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatorio                           ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function ReportPrint(oReport,cAliasQry,oSegmento)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis   										     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cQuebra	:= ""
Local nSection  := oReport:Section(1):GetOrder()
Local oSecao    := oReport:Section(nSection)


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao do Cabecalho no top da pagina                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSecao:SetHeaderPage()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Transforma parametros Range em expressao SQL                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam)


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Gera Tabela Temporaria para impressao                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Processa({|| RF012Trab(oReport,cAliasQry,nSection,oSecao)},"Gerando Tabela de Trabalho. Aguarde...")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao do Relatorio                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DbSelectArea("TRB")
DbGoTop()
oReport:SetMeter(RecCount())		// Total de elementos da regua

lIp := .T.
oSecao:Init()

Do While !oReport:Cancel() .And. !Eof()
	
	oSecao:Cell("SEGMENTO" ):Show()
	oSecao:Cell("VENDEDOR" ):Show()
	oSecao:Cell("NOMEVEND" ):Show()
	oSecao:Cell("EMISSAO"  ):Show()		
	oSecao:Cell("CLIENTE"  ):Show()
	oSecao:Cell("LOJA"	   ):Show()
	oSecao:Cell("NOMECLI"  ):Show()
	oSecao:Cell("TOTAL"    ):Show() 
	oSecao:Cell("DOC"      ):Show()
	oSecao:Cell("PEDIDO"   ):Show()
	
	oSecao:PrintLine()
	
	DbSelectArea("TRB")
	DbSkip()
	oReport:IncMeter()     
	
	DbSelectArea("TRB")
	
EndDo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza Relatorio                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSecao:SetPageBreak()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fecha tabela de trabalho                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DbSelectArea("TRB")
DbCloseArea()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Restaura Tabelas                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

DbSelectArea(cAliasQry)
DbClosearea()

Return



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³RF012Trab ³ Autor ³ Mauro Nagata          ³ Data ³ 23/12/11 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Cria Arquivo de Trabalho                             	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³      													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function RF012Trab(oReport,cAliasQry,nSection,oSecao)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aCampos   := {}
Local aTam      := ""
Local nX        := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define array para arquivo de trabalho                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aTam:=TamSX3("C5_XORIGEM")
AADD(aCampos,{ "SEGMENTO"  ,"C",aTam[1],aTam[2] } )

aTam:=TamSX3("C5_VEND1")
AADD(aCampos,{ "VENDEDOR"  ,"C",aTam[1],aTam[2] } )

aTam:=TamSX3("A3_NOME")
AADD(aCampos,{ "NOMEVEND"  ,"C",aTam[1],aTam[2] } ) 

aTam:=TamSX3("D2_EMISSAO")
AADD(aCampos,{ "EMISSAO"   ,"D",aTam[1],aTam[2] } )
                        
aTam:=TamSX3("D2_CLIENTE")
AADD(aCampos,{ "CLIENTE"   ,"C",aTam[1],aTam[2] } )

aTam:=TamSX3("D2_LOJA")
AADD(aCampos,{ "LOJA"      ,"C",aTam[1],aTam[2] } )

aTam:=TamSX3("A1_NOME")
AADD(aCampos,{ "RAZSOC"    ,"C",aTam[1],aTam[2] } )
                          
aTam:=TamSX3("D2_TOTAL")
AADD(aCampos,{ "TOTAL"     ,"N",aTam[1],aTam[2] } )
                           
aTam:=TamSX3("D2_TOTAL")
AADD(aCampos,{ "TOTALIMP" ,"N",aTam[1],aTam[2] } )

aTam:=TamSX3("D2_DOC")
AADD(aCampos,{ "DOC"       ,"C",aTam[1],aTam[2] } )

aTam:=TamSX3("D2_PEDIDO")
AADD(aCampos,{ "PEDIDO"    ,"C",aTam[1],aTam[2] } )


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria arquivo de Trabalho                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cArqTrab := CriaTrab(aCampos,.T.)
DbUseArea(.T.,,cArqTrab,"TRB",.T.,.F.)

DbSelectArea("TRB")
IndRegua("TRB",cArqTrab,"SEGMENTO+NOMEVEND+Dtos(EMISSAO)",,,"Selecionando Registros...")

DbSelectArea("TRB")
DbSetOrder(1)
DbGoTop()
    
cSegm    := AllTrim(MV_PAR10)                        
nSegm    := Len(cSegm)
cSegm_IN := "("
For nI := 1 To nSegm
    cSegm_IN += Substr(cSegm,nI,1)+")"+If(nI=nSegm,")",",")
Next
cMv_Par01 := Dtos(mv_par01)
cMv_Par02 := Dtos(mv_par02)

aStruSD2  := SD2->(dbStruct())
oSecao:BeginQuery()
BeginSql Alias cAliasQry
	                     
SELECT (CASE WHEN C5_XORIGEM = 'A' 
              THEN 'AUTOMOTIVO' 
              ELSE CASE WHEN C5_XORIGEM = 'C' 
                        THEN 'CORPORATIVO' 
                        ELSE CASE WHEN C5_XORIGEM = 'T' 
                                  THEN 'ASSIST.TECNICA' 
                                  ELSE CASE WHEN C5_XORIGEM = 'V' 
                                            THEN 'VAREJO' 
                                            ELSE CASE WHEN C5_XORIGEM = 'M' 
                                                      THEN 'MUL-T-LOCK CENTER' 
                                                      ELSE 'NAO DEFINIDO' 
                                                 END 
                                       END 
                             END 
                    END 
        END) 
        AS SEGMENTO, 
        D2_EMISSAO AS EMISSAO, 
        C5_VEND1 AS VENDEDOR, 
        A3_NOME AS NOMEVEND, 
        D2_CLIENTE AS CLIENTE,D2_LOJA AS LOJA, A1_NREDUZ AS RAZSOC, 
        A1_MUN AS CIDADE, A1_EST AS ESTADO, 
        D2_DOC AS DOC, 
        C5_NUM AS PEDIDO, 
        IsNull(Sum(D2_TOTAL),0) TOTAL, 
        IsNull(Sum((Case When SF4.F4_AGREG <> 'H' Then D2_TOTAL+D2_VALIPI+D2_ICMSRET Else D2_ICMSRET End)),0) TOT_IMP 
 FROM %Table:SD2% SD2 
      JOIN %Table:SA1% AS SA1 
           ON SD2.D2_CLIENTE    = SA1.A1_COD 
              AND SD2.D2_LOJA	= SA1.A1_LOJA 
              AND SA1.%notdel%
      JOIN %Table:SF4% AS SF4 
           ON SD2.D2_FILIAL     = SF4.F4_FILIAL 
              AND SD2.D2_TES    = SF4.F4_CODIGO 
              AND SF4.F4_DUPLIC = 'S' 
              AND SF4.%notdel%
      JOIN %Table:SC5% AS SC5 
           ON SD2.D2_FILIAL     = SC5.C5_FILIAL 
              AND SD2.D2_PEDIDO = SC5.C5_NUM 
              AND ((%Exp:cSegm% <> '     ' AND (SC5.C5_XORIGEM IN (%Exp:cSegm%))) OR %Exp:cSegm% = '     ' ) 
              AND SC5.%notdel%
      JOIN %Table:SA3% AS SA3 
           ON SA3.A3_COD = SC5.C5_VEND1 
              AND SA3.%notdel%
 WHERE     SD2.D2_EMISSAO >= %Exp:cMv_Par01%
       AND SD2.D2_EMISSAO <= %Exp:cMv_Par02%
       AND SD2.D2_FILIAL   = '01' 
       AND SD2.D2_CLIENTE >= %Exp:mv_par03%
       AND SD2.D2_CLIENTE <= %Exp:mv_par04%
       AND SA1.A1_VEND    >= %Exp:mv_par05%
       AND SA1.A1_VEND    <= %Exp:mv_par06%
       AND SA1.A1_EST     >= %Exp:mv_par07%
       AND SA1.A1_EST     <= %Exp:mv_par08%
       AND (SD2.D2_TIPO = 'N' OR SD2.D2_TIPO = 'C') 
       AND SD2.%notdel%
 GROUP BY C5_XORIGEM,  D2_EMISSAO, C5_VEND1, A3_NOME, D2_CLIENTE, D2_LOJA, A1_NREDUZ, A1_MUN, A1_EST, D2_DOC, C5_NUM 
EndSql
oSecao:EndQuery()


DbSelectArea(cAliasQry)
DbGoTop()
oReport:SetMeter(RecCount())     // Total de Elementos da Regua
Do While !oReport:Cancel() .And. !Eof() //.And. (cAliasQry)->FILIAL == xFilial("SD2")
	DbSelectArea("TRB")
	RecLock("TRB",.T.)

	TRB->SEGMENTO  := (cAliasQry)->SEGMENTO
	TRB->VENDEDOR  := (cAliasQry)->VENDEDOR
	TRB->NOMEVEND  := (cAliasQry)->NOMEVEND
	TRB->EMISSAO   := Ctod(Substr((cAliasQry)->EMISSAO,7,2)+"/"+Substr((cAliasQry)->EMISSAO,5,2)+"/"+Substr((cAliasQry)->EMISSAO,1,4))
	TRB->CLIENTE   := (cAliasQry)->CLIENTE
	TRB->LOJA      := (cAliasQry)->LOJA
	TRB->RAZSOC    := (cAliasQry)->RAZSOC
	TRB->TOTAL     := (cAliasQry)->TOTAL
//	TRB->TOTALIMP  := (cAliasQry)->TOTALIMP	
	TRB->DOC       := (cAliasQry)->DOC      
	TRB->PEDIDO    := (cAliasQry)->PEDIDO
	
	DbSelectArea(cAliasQry)
	DbSkip()
	oReport:IncMeter()
	
EndDo

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ AjustaSX1    ³Autor ³  Mauro Nagata        ³Data³ 05/11/11 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Ajusta perguntas do SX1                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function AjustaSX1()

Local cAlias := Alias()
Local aRegs  := {}
Local nI,nJ

DbSelectArea("SX1")
DbSetOrder(1)
cPerg := PADR(cPerg,10)

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
aAdd(aRegs,{cPerg,"10","Segm[ACMVT]bco=todos? ","","","MV_CHA","C",05,0,1,"G","","MV_PAR10","","","","","","","","","","","","","","","","","","","","","","","","",""})

For nI := 1 to Len(aRegs)
	If !dbSeek(cPerg+aRegs[nI,2])
		RecLock("SX1",.T.)
		For nJ := 1 To FCount()
			If nJ <= Len(aRegs[nI])
				FieldPut(nJ,aRegs[nI,nJ])
			EndIf
		Next
		MsUnlock()
	EndIf
Next

DbSelectArea(cAlias)

Return Nil