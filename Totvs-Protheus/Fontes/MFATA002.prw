 #include "rwmake.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MFATA002  ºAutor  ³Microsiga           º Data ³  13/08/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Esta rotina atualiza os dados da expedicao da nota fiscal  º±±
±±º          ³ ex: peso liquido, volume, transportadora..                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Especifico Multlock - www.actualtrend.com.br               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MFATA002()

cOpcao:="ALTERAR"
nOpcE:=2
nOpcG:=3
cCadastro := "Saida de Produtos na Expedicao"

aRotina := {{ "Pesquisa"		,"AxPesqui"    				  , 0 , 1},;
			{ "Visualiza" 		,'u_AEXP002("Visualizar")' 	  , 0 , 2},;
			{ "Expedição NF"	,'u_AEXP002("Expedição")'	  , 0 , 4, 20 }}

MBrowse(01,01,30,70,"SF2")
Return
                     

/*BEGINDOC
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Rotina utilizada para alterar os dados da expedicao da nota fiscal de saida³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ENDDOC*/

User Function AEXP002()
Local   _aAlias        		:= Alias()
Private _nFiscal         	:= SF2->F2_DOC
Private _cTransportadora 	:= SF2->F2_TRANSP
Private _cData           	:= SF2->F2_EMISSAO //F2_XDTEXP
Private _xTamdt          	:= PesqPict("SF2","F2_EMISSAO",8)
Private nPesoBruto			:= SF2->F2_PBRUTO
Private nPesoLiq			:= SF2->F2_PLIQUI
//Private cVolume				:= SF2->F2_VOLUME1
Private nVolume				:= SF2->F2_VOLUME1 //Altera o tipo de variavel para numerica
Private cCombo 				:= SF2->F2_ESPECI1 //"Pallet" // Caixa
Private aCombo				:= {"Caixa","Pallet"}

DbSelectarea("SF2")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Criacao da Interface                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
@ 156,367 To 488,884 Dialog mkwdlg Title OemToAnsi("Expedição de Nota Fiscal")
@ 13,13  Say OemToAnsi("Nota Fiscal...:") Size 44,12
@ 34,13  Say OemToAnsi("Transportadora:") Size 45,13
@ 55,13  Say OemToAnsi("Peso Bruto....:") Size 42,13
@ 76,13  Say OemToAnsi("Peso Liquido..:") Size 41,13
@ 96,13  Say OemToAnsi("Volume........:") Size 44,14
@ 118,13 Say OemToAnsi("Especie.......:") Size 41,14
@ 15,63 say SF2->F2_DOC Size 76,10
@ 35,63 Get _cTransportadora pict "@!" F3 "SA4" Size 76,10
@ 54,63 Get nPesoBruto Picture "99999.99" Size 76,10
@ 76,63 Get nPesoLiq  Picture "99999.99" Size 76,10
//@ 98,63 Get cVolume Picture "999999" Size 76,10
@ 98,63 Get nVolume Picture "9999.99" Size 76,10
@ 120,63 ComboBox cCombo Items aCombo Size 76,21
@ 144,9 Button OemToAnsi("_Salvar") Size 36,16 Action AEXP003()
@ 144,55 Button OemToAnsi("_Cancelar") Size 36,16 Action CLOSE(mkwdlg)
Activate Dialog mkwdlg CENTERED 

DbSelectArea(_aAlias)

Return()

                        
/*BEGINDOC
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Atualiza dados de expedicao da NF.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ENDDOC*/

Static Function AEXP003()
Local _Alias          := Alias()

DbSelectarea("SF2")

RecLock("SF2",.F.)
SF2->F2_TRANSP 		:= 	_cTransportadora
SF2->F2_EMISSAO 	:= 	_cData
//SF2->F2_XDTEXP  	:= 	ddatabase
SF2->F2_PBRUTO		:=	nPesoBruto		
SF2->F2_PLIQUI		:=	nPesoLiq		
//SF2->F2_VOLUME1		:=	cVolume
SF2->F2_VOLUME1		:=	nVolume
SF2->F2_ESPECI1		:=	cCombo 
MSUNLOCK()

DbSelectArea(_Alias)
CLOSE(mkwdlg)

Return()