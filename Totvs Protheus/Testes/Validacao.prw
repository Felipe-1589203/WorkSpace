#INCLUDE 'TOTVS.CH'
#INCLUDE 'RWMAKE.CH'

User Function EEE()
	AxCadastro("SB1","Exercicio","ExecBlock('val')",".F.")

Return

User Function val()

	Local cArea := Alias(), cRec := Recno(), cInd := IndexOrd()
	Local cCod := SB1->B1_COD, lDel := .T.

	MsgBox("Verificando amarração do produto "+AllTrim(cCod)+", por favor aguarde...","Atenção")
	DbSelectArea("SC4")

	If DbSeek(Xfilial("SC4")+cCod)
		MsgBox("O Produto "+AllTrim(cCod)+" não pode ser excluido!!! Pois tem amarração a previsão de venda")
		lDel := .F.
	EndIf

	DbSelectArea(cArea)
	DbSetOrder(cInd)
	DbGoTo(cRec)


Return (lDel)
