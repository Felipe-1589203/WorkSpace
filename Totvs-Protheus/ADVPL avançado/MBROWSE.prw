#INCLUDE 'Protheus.ch'
#INCLUDE 'Rwmake.ch'
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMBrwSZ1    Autor ณ Felipe Souza      บ Data ณ  22/03/2023   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ cadastro SZ1 COM MBRWOSE                                   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/


User Function mbrowse()
	Local cAlias  := "SA3"
	Local aCores  := {}
	Local cFiltra := ""

	Private cCadastro  := "Cadastro de Vendedor"
	Private aRotina    := {}
	Private aIndexSA3   := {}
	Private bFiltraBrw := {||}


	AADD(aRotina,{"Pesquisar" ,"PesqBrw"    ,0,1}) 
	AADD(aRotina,{"Visualizar","AxVisual"   ,0,2})
	AADD(aRotina,{"Incluir"   ,"U_Binclui"  ,0,3}) 
	AADD(aRotina,{"Alterar"   ,"U_Baltera"  ,0,4}) 
	AADD(aRotina,{"Excluir"   ,"U_Bdeleta"  ,0,5}) 
	AADD(aRotina,{"Legenda"   ,"U_Blegenda" ,0,3})

	//If RetCodUsr() # "000000"
		AADD(aRotina,{"Processa" ,"U_PBMsgRun()",0,6})
//	EndIf
	AADD(aCores,{"A3_TIPO == 'I'","BR_VERDE"})
	AADD(aCores,{"A3_TIPO == 'E'", "BR_VERMELHO"})
	AADD(aCores,{"A3_TIPO == 'P'", "BR_AMARELO"})

	dbSelectArea("SA3")
	dbSetOrder(1)

	
	bFiltraBrw := {|| FilBrowse(cAlias,@aIndexSA3,@cFiltra)}
	Eval(bFiltraBrw)
	dbSelectArea(cAlias)
	dbGoTop()
	mBrowse(6,1,22,75,cAlias,,,,,,aCores)

	EndFilBrw(cAlias,aIndexSA3)
Return Nil

User Function BInclui(cAlias,nReg,nOpc)
	Local nOpcao := 0

	If nOpcao == 1
		MsgInfo("Inclusใo efetudada com sucesso!")
	Else
		MsgInfo("Nใo ้ permitida a inclusao de um novo vendedor!")
	EndIf

Return Nil

User Function BAltera(cAlias,nReg,nOpc)
	Local nOpcao := 0
	nOpcao := AxAltera(cAlias,nReg,nOpc)
	If nOpcao == 1
		MsgInfo("Alter็ใo efetuada com sucesso!")
	Else
		MsgInfo("Altera็ใo cancelada!")
	EndIf

Return Nil

User Function BDeleta(cAlias,nReg,nOpc)
	Local nOpcao := 0
	nOpcao := AxDeleta(cAlias,nReg,nOpc)
	If nOpcao == 1
		MsgInfo("Exclusใo efetuada com sucesso!")
	Else
		MsgInfo("Exclusใo cancelada!")
	EndIf
Return Nil


User Function BLegenda()
	Local aLegenda := {}

	AADD(aLegenda,{"BR_VERDE","Interno"})
	AADD(aLegenda,{"BR_VERMELHO","Externo"})
	AADD(aLegenda,{"BR_AMARELO" ,"Parcerio"})
	BrwLegenda("Legenda","Legenda",aLegenda)
Return Nil

