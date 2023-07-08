#INCLUDE "rwmake.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AxCadSZA  º Autor ³ AP6 IDE            º Data ³  29/07/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Cadastro dos borderos gerados para desconto de duplicatas  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Multlock                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function AxCadSZA()


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Private cCadastro := "Desconto de Duplicatas"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta um aRotina proprio                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Private aRotina := {	{"Pesquisar"	,"AxPesqui"		,0,1} ,;
             			{"Visualizar"	,"AxVisual"		,0,2} ,;
             			{"Incluir"		,"AxInclui"		,0,3} ,;
             			{"Alterar"		,"U_ZaAltera"	,0,4} ,;
             			{"Excluir"		,"AxDeleta"		,0,5} }

Private cDelFunc := ".T." // Validacao para a exclusao. Pode-se utilizar ExecBlock

Private cString := "SZA"

dbSelectArea("SZA")
dbSetOrder(1)

dbSelectArea(cString)
mBrowse( 6,1,22,75,cString,,"ZA_BLOQUEI")

Return
Return


             

//==============================================|
//Alteracao dos valores. Se Houve alteracao     |
//chama rotina de recalculo de saldo bancario   |
//==============================================|

User Function ZaAltera()

nFinal	:= SZA->ZA_LIQUIDO

AxAltera("SZA",recno(),4)

nDiferenca	:= nFinal - SZA->ZA_LIQUIDO

If nDiferenca <> 0
	AtuSZASE5(SZA->ZA_NUMBOR, SZA->ZA_LIQUIDO)
	Fina210()                        
Endif


Return 
               

//==============================================|
//Altera valor original da movimentacao no SE5  |
//==============================================|

Static Function AtuSZASE5(cNumBor, nLiquido)

Local aArea	:= GetArea()
DbSelectArea("SE5")
dbSetOrder(10)
dbSeek(xFilial("SE5")+cNumBor)

While alltrim(SE5->E5_DOCUMEN) == cNumBor
	If SE5->E5_RECPAG == "R"  
		RecLock("SE5",.F.)
		Replace SE5->E5_VALOR WITH nLiquido
		MsUnlock()
	Endif

	DbSkip()

EndDo

Return



/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
  ³Função Gatilho para calculo         ³
  ³do novo valor liquido apos alteração³
  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
*/

User Function GatSza1()

Local aArea 	:= GetArea()

nLiquido  		:= SZA->ZA_LIQUIDO
nOutOrig		:= SZA->ZA_OUTROS

nOutroNew		:= M->ZA_OUTROS

nLiqNew			:= nLiquido - ( nOutroNew - nOutOrig )

M->ZA_LIQUIDO	:= nLiqNew

RestArea(aArea)

Return nLiqNew





/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
  ³Função Gatilho para calculo         ³
  ³do novo valor liquido apos alteração³
  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
*/

User Function GatSza2()

Local aArea 	:= GetArea()

nLiquido  		:= SZA->ZA_LIQUIDO
nRecompra		:= SZA->ZA_RECOMPR 

nOutOrig		:= SZA->ZA_OUTROS
nOutroNew		:= M->ZA_OUTROS

nRecNew			:= M->ZA_RECOMPR

nLiqNew			:= nLiquido - (nOutroNew - nOutOrig) - ( nRecNew - nRecompra)

M->ZA_LIQUIDO	:= nLiqNew

RestArea(aArea)

Return nLiqNew
