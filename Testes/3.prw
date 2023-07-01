#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TOTVS.CH'
#INCLUDE 'RWMAKE.CH'

User Function Exercicio9()

	Private cAliaSC1  := "SC2" //tabela filho- parte de cima
	Private cAliaSC2  := "SC1" //tabela pai- parte e baixo
	Private cCadastro := "Tela de duas tabelas"
	Private aRotina   := {}
	
	AADD(aRotina,{"Pesquisar" ,"AxPesqui"   ,0,1})
	AADD(aRotina,{"Visualizar","u_Mod3Manut",0,2})
	AADD(aRotina,{"Incluir"  ,"u_Mod3Manut",0,3})
	AADD(aRotina,{"Alterar"   ,"u_Mod3Manut",0,4})
	AADD(aRotina,{"Exluir"    ,"u_Mod3Manut",0,5})


	DbSelectArea(cAliaSC1)
	DbSetOrder(1)
	DbGoTop()

	mBrowse(,,,,cAliaSC1)

Return

User Function Mod3Manut(cAlias,nRecNo,nOpc)
	
	
	Local cLinOk  := "AllWaysTrue()"
	Local cTudoOk := "u_Md3TudOk"
	Local nOpcE   := nOpc
	Local nOpcG   := nOpc
	Local cFieldOk:= "AllWaysTrue()"
	Local lVirtual:= .T.
	Local nLinhas := 99
	Local nFreeze := 0
	Local lRet    := .T.

	Private aCpoEnchoice := {}
	Private aAltEnchoice := {}
	Private aCols        := {}
	Private aHeader      := {}
	Private aAlt         := {}

	RegToMemory(cAliaSC1,(nOpc==3))
	RegToMemory(cAliaSC2,(nOpc==3))
	CriaHeader()
	CriaCols(nOpc)

	lRet:=Modelo3(cCadastro,cAliaSC1,cAliaSC2,aCpoEnchoice,cLinOk,cTudoOk,nOpcE,nOpcG,cFieldOk,lVirtual,nLinhas,aAltEnchoice,nFreeze)

	If lRet
		If nOpc ==3
			If MsgYesNo("Confirma a Gravação dos dados?",cCadastro)
				Processa({||GrvDados()},cCadastro,"Gravando os dados, aguarde...")
			EndIf
		ElseIf nOpc == 4
			If MsgYesNo("Confirma a alteração dos daos?",cCadastro)
				Processa({||AltDados()},cCadastro,"Alterando os dados, aguarde...")
			EndIf
		ElseIf nOpc == 5
			If MsgYesNo("Confirma a exclusão dos dados?",cCadastro)
				Processa({||ExcDados()},cCadastro,"Excluido dados, aguarde...")
			EndIf
		EndIf
	Else
		RollBacksx8()
	EndIf
Return

Static Function CriaHeader()

	aHeader       := {}
	aCpoEnchoice  := {}
	aAltEnchoice  := {}

	DbSelectArea("SX3")
	DbSetOrder(1)
	DbSeek(cAliaSC2)

	While !EOF() .AND. X3_ARQUIVO == cAliaSC2
		If X3USO(X3_USADO)  .AND. cNivel >= X3_NIVEL
			AADD(aHeader,{Trim(X3_TITULO), X3_CAMPO, X3_PICTURE, X3_TAMANHO, X3_DECIMAL,;
				X3_VALID, X3_USADO, X3_TIPO, X3_ARQUIVO,X3_CONTEXT})
		EndIf
		DbSkip()
	End

	DbSeek(cAliaSC1)
	While !EOF() .AND. X3_ARQUIVO == cAliaSC1
		If X3USO(X3_USADO) .AND. cNivel >= X3_NIVEL
			AADD(aCpoEnchoice,X3_CAMPO)
			AADD(aAltEnchoice,X3_campo)
		EndIf
		DbSkip()
	End
Return

Static Function CriaCols(nOpc)

	Local nQtdCpo := 0
	Local i       := 0
	Local nCols   := 0

	nQtdCpo := Len(aHeader)
	aCols   := {}
	aAlt    := {}

	If nOpc == 3
		AADD(aCols,Array(nQtdCpo+1))
		For i := 1 To nQtdCpo
			aCols[1,i] := Criavar(aHeader[i,2])
		Next i
		aCols[1,nQtdCpo+1] := .F.
	Else
		DbSelectArea(cAliaSC2)
		DbSetOrder(1)	
		DbSeek(xFilial(cAliaSC2)+(cAliaSC1)->C1_NUM)
		While !EOF() .AND. (cAliaSC2)->C2_FILIAL== xFilial(cAliaSC2) .AND. (cAliaSC2)->C2_NUM == (cAliaSC1)->C1_NUM
			AADD(aCols,Array(nQtdCpo+1))
			nCols++
			For i := 1 To nQtdCpo
				If aHeader[i,10] <> "V"
					aCols[nCols,i] := FieldGet(FieldPos(aHeader[i,2]))
				Else
					aCols[nCols,i] := CriaVar(aHeader[1,2],.T.)
				EndIf
			Next i
			aCols[nCols,nQtdCpo+1] := .F.
			AADD(aAlt,Recno())
			DbSelectArea(cAliaSC2)
			DbSkip()
		End
	EndIf
Return

Static Function GrvDados()

	Local bCampo := {|nField| Field(nField)}
	Local i      := 0
	Local y      := 0
	Local nItem  := 0

	ProcRegua(Len(aCols)+Fcount())
	DbSelectArea(cAliaSC1)

	RecLock(cAliaSC1,.T.)

	For i := 1 To Fcount()
		IncProc()
		If  "Filial" $ FieldNmae(i)
			FieldPut(i,xFilial(cAliaSC1))
		Else
			FieldPut(i,M->&(Eval(Bcampo,i)))
		Endif
	Next i
	MsUnlock()

	DbSelectArea(cAliaSC2)
	DbSetOrder(1)

	For i := 1 To Len(aCols)
		IncProc()
		If !aCols[i,Len(aHeader)+1]
			RecLock(cAliaSC2,.T.)
			For y := 1 To Len(aHeader)
				FieldPut(FieldPos(Trim(aHeader[y,2])),aCols[i,y])
			Next y
			nItem++
			(cAliaSC2)->C2_FILIAL := xFilial(cAliaSC2)
			(cAliaSC2)->C2_NUM    := (cAliaSC1)->C1_NUM
			(cAliaSC2)->C2_ITEM   := StrZero(nItem,2,0)
			MsUnlock()
		EndIf
	Next i
Return

Static Function AltDados()

	Local bCampo := {|nField|Field(nField)}
	Local i      := 0
	Local y      := 0
	Local nItem  := 0

	ProcRegua(Len(aCols)+Fcount())
	DbSelectArea(cAliaSC1)
	RecLock(cAliaSC1,.F.)

	For i := 1 To Fcount()
		IncProc()
		If "Filial" $ FieldName(i)
			FieldPut(i,xFilial(cAliaSC1))
		Else
			FieldPut(i,M->&(Eval(bCampo,i)))
		EndIf
	Next i
	MsUnlock()
	DbSelectArea(cAliaSC2)
	DbSetOrder(1)

	nItem := Len(aAlt)+1

	For i := 1 To Len(aCols)
		If i <= Len(aAlt)
			DbGoTo(aAlt[i])
			RecLock(cAliaSC2,.F.)
			If aCols[i,Len(aHeader)+1]
				DbDelete()
			Else
				For y := 1 To Len(aHeader)
					FieldPut(FieldPos(Trim(aHeader[y,2])),aCols[i,y])
				Next y
			EndIf
			MsUnlock()
		Else
			If !aCols[i,Len(aHeader)+1]
				RecLock(cAliaSC2,.T.)
				For y := 1 To Len(aHeader)
					FieldPut(FieldPos(Trim(aHeader[y,2])),aCols[i,y])
				Next y
				(cAliaSC2)->C2_FILIAL := xFilial(cAliaSC2)
				(cAliaSC2)->C2_NUM    := (cAliaSC1)->C1_NUM
				(cAliaSC2)->C2_ITEM   := StrZero(nItem,2,0)
				MsUnlock()
				nItem++
			EndIf
		EndIf
	Next i
Return

Static Function ExcDados()

	ProcRegua(Len(aCols)+1)
	DbSelectArea(cAliaSC2)
	DbSetOrder(1)
	DbSeek(xFilial(cAliaSC2)+(cAliaSC1)->C1_NUM)

	While !EOF() .AND. (cAliaSC2)->C2_FILIAL == xFilial(cAliaSC2) .AND. (cAliaSC2)->C2_NUM == (cAliaSC1)->C1_NUM
		IncProc()
		RecLock(cAliaSC2,.F.)
		DbDelete()
		MsUnlock()
		DbSkip()
	End

	DbSelectArea(cAliaSC1)
	DbSetOrder(1)
	IncProc()
	RecLock(cAliaSC1,.F.)
		DbDelete()
	MsUnlock()			

Return

User Function Md3TudOk()

	Local lRet := .T.
	Local i    := 0
	Local nDel := 0

	For i := 1 To Len(aCols)
		If aCols[i,Len(aHeader)+1]
	 		nDel++
		EndIf
	Next i

	If nDel == Len(aCols)
		MsgInfo("Para excluir todos os itens, utilize a função 'EXCLUIR' ",cCadastro)
		lRet := .F.
	EndIf
	
Return(lRet)
