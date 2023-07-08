#include "rwmake.ch"        

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MESTA001  ºAutor  ³Jean Cavalcante     º Data ³  26/08/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Esta rotina atualiza os dados do custo medio do produto    º±±
±±º          ³ no sb2 para itens com custo 0,00                           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Especifico MUL-T-LOCK - www.actualtrend.com.br             º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/


User Function MESTA001()                             

cOpcao:="ALTERAR"
nOpcE:=2
nOpcG:=3
cCadastro := "Atualizacao de Custo Medio"

aRotina := {{ "Pesquisa"		,"AxPesqui"    				  , 0 , 1},;
			{ "Visualiza" 		,'u_MESTA01a("Visualizar")' 	  , 0 , 2},;
			{ "Alterar Custo"	,'u_MESTA01a("Expedição")'	  , 0 , 4, 20 }}

MBrowse(01,01,30,70,"SB2")
Return
                     

/*BEGINDOC
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Rotina utilizada para alterar os dados da expedicao da nota fiscal de saida³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ENDDOC*/

User Function MESTA01a()
Local   _aAlias        		:= Alias()
Private _cCodigo         	:= SB2->B2_COD
Private _cDescri           	:= GetAdvFval("SB1","B1_DESC",XFILIAL("SB2")+_cCodigo,1,"")                                                                
Private _cArm            	:= SB2->B2_LOCAL
Private _nQuant          	:= SB2->B2_QATU
Private _nVatual			:= SB2->B2_VATU1
Private _nMedio  			:= SB2->B2_CM1

DbSelectarea("SB2")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Criacao da Interface                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
@ 156,367 To 488,884 Dialog mkwdlg Title OemToAnsi("Atualiza Custo Medio")
@ 13,13  Say OemToAnsi("Produto.......:") Size 44,12
@ 34,13  Say OemToAnsi("Descricao.....:") Size 45,13
@ 55,13  Say OemToAnsi("Armazem.......:") Size 42,13
@ 76,13  Say OemToAnsi("Quantidade....:") Size 41,13
@ 96,13  Say OemToAnsi("Valor Total...:") Size 44,14
@ 118,13 Say OemToAnsi("Custo Medio...:") Size 41,14
@ 15,63 say SB2->B2_COD Size 76,10
@ 35,63 Say _cDescri pict "@!" //F3 "SA4" Size 76,10
@ 54,63 Say _cArm Picture "@!" Size 76,10
@ 76,63 Say _nQuant  Picture "99999.99" Size 76,10
@ 98,63 Say _nVatual Picture "99999.99" Size 76,10
@ 120,63 Get _nMedio Picture "99999.9999" Size 76,21
@ 144,9 Button OemToAnsi("_Salvar") Size 36,16 Action MESTA01b()
@ 144,55 Button OemToAnsi("_Cancelar") Size 36,16 Action CLOSE(mkwdlg)
Activate Dialog mkwdlg CENTERED 

DbSelectArea(_aAlias)

Return()

                        
/*BEGINDOC
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Atualiza dados de expedicao da NF.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ENDDOC*/

Static Function MESTA01b()

Local _Alias := Alias()
DbSelectarea("SB2")

RecLock("SB2",.F.)
//If SB2->B2_CM1 <= 0
	SB2->B2_CM1		:=	_nMedio
	MSUNLOCK()
//Else
//	Alert("Impossivel alterar!!")
//Endif	

DbSelectArea(_Alias)
CLOSE(mkwdlg)

Return()