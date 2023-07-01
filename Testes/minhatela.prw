#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TOTVS.CH'

User Function MinhaTela()

	Local oDlg
	Local oBtnOk
	Local oBtnCanc
	Local aButtons
	Local oSayConj
	Local oGetConj
	Local oSayCivil, oSaySal
	Local cSayCivil, cSaySal
	Local oRadio    
	Local nRadio := 0
	Local oChk
	Local lChk
	Local cNome  := Space(40)
	Local cConj  := Space(40)
	Local cEnd   := Space(50)
	Local cCivil := Space(1)
	Local oFont
	Local oFolder

	DEFINE FONT oFont NAME "ARIAL" SIZE 0,-12 BOLD

	aButtons := {{"BMPERG",{||MsgInfo("Pergunte",)},"Pergunte...",},;
		         {"BMPCALEN",{||MsgInfo("Calendário",)},"Calendário..."}}

	DEFINE MsDialog oDlg TITLE "Minha Tela" FROM 000,000 TO 600,600 PIXEL

	@72,10 SAY "Nome:" PIXEL OF oDlg
	@70,42 GET cNome SIZE 80,10 PIXEL OF oDlg

	@87,10 SAY "Estado Civil:" PIXEL OF oDlg
	@85,42 GET cCivil SIZE 10,10 PICTURE "@!" VALID cCivil $ "S|C|D" .AND. VldCivil(cCivil,oSayConj,oGetConj,oSayCivil) PIXEL OF oDlg
	@88,58 SAY oSayCivil  VAR cSayCivil SIZE 20,15 PIXEL OF oDlg

	@103,10 SAY oSayConj   VAR "Conjuguê:" PIXEL OF oDlg
	@100,42 GET oGetConj VAR cConj SIZE 80,10 PIXEL OF oDlg

	@120,10 SAY "Endereço:" PIXEL OF oDlg
	@117,42 GET cEnd SIZE 100,10 PIXEL OF oDlg

	@139,10 SAY "Salário:" PIXEL OF oDlg
	@130,40 Radio oRadio  VAR nRadio ITEMS "R$ 1.000,00","R$ 2.000,00","R$ 3.000,00" SIZE 50,9 ON CHANGE Salario(nRadio,oSaySal) PIXEL OF oDlg    
	@134,90 SAY   oSaySal VAR cSaySal SIZE 20,15 PIXEL OF oDlg

	@170,10 CHECKBOX oChk VAR lChk PROMPT "CheckBox" SIZE 70,9 ON CHANGE MsgAlert(If(lChk,"Marcado","Desmarcado"),"Resultado") PIXEL OF oDlg

	@oDlg:nHeight/2-30,oDlg:nClientWidth/2-70 BUTTON oBtnOk   PROMPT "OK" SIZE 30,15 PIXEL ACTION Confirma() MESSAGE"Clique aqui para confirmar" OF oDlg
	@oDlg:nHeight/2-30,oDlg:nClientWidth/2-35 BUTTON oBtnCanc PROMPT "Cancelar" SIZE 30,15 PIXEL ACTION oDlg:END() CANCEL MESSAGE"Clique aqui para cancelar" OF oDlg

	@190,10 Folder oFolder PROMPT "Pasta 1","Pasta 2" SIZE 200,100 PIXEL OF oDlg
	// oFolder:aDialogs[2]:oFont := oFont
	//oFolder:bChange := {||MsgAlert("Mudando de pasta")}

	@10,10 SAY "Conteúdo da primeira pasta" PIXEL OF oFolder:aDialogs[1]
	@10,10 SAY "Conteúdo da segunda pasta"  Pixel OF oFolder:aDialogs[2]

	ACTIVATE MsDialog oDlg CENTERED ON INIT EnchoiceBar(oDlg, {||u_OK(),oDlg:END()},{||oDlg:END()},,aButtons)
Return (Nil)


Static Function Confirma()

	MsgAlert("Você clicou no botão OK!")

Return

Static Function OK()

	MsgAlert("Você clicou no botao da Barra de Opções")

Return

Static Function VldCivil(cCivil,oSayConj,oGetConj,oSayCivil)

	If cCivil <> "C"
		oSayConj:HIDE()
		oGetConj:HIDE()
		//oSayConj:DISABLE()
		//oGetConj:DISABLE()
	Else
		oSayConj:SHOW()
		oGetConj:SHOW()
		//oSayConj:ENABLE()
		//oGetConj:ENABLE()
	EndIf

	If cCivil == "C"
		oSayCivil:SetTexT("Casado")
	ElseIf cCivil == "S"
		oSayCivil:SetText("Solteiro")
	Else
		oSayCivil:SetText("Divorciado")
	EndIf

Return .T.

Static Function Salario(nRadio,oSaySal)

	If nRadio == 1
		oSaySal:SetText("Mil Reais")
	ElseIf nRadio == 2
		oSaySal:SetText("Dois mil reais")
	Else
		oSaySal:SetText("Tres mil reais")
	EndIf

Return





