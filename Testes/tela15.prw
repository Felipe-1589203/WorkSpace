#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TOTVS.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'TOPCONN.CH'

User Function Exerc080()


	Private aRotina   := {}
	Private cCadastro := "Solicitação de Software"

	aAdd( aRotina, { "Pesquisar" ,"AxPesqui"    , 0 , 1 })
	aAdd( aRotina, { "Visualizar","u_Mod2Manut" , 0 , 2 })
	aAdd( aRotina, { "Incluir"   ,"u_Mod2Manut" , 0 , 3 })
	aAdd( aRotina, { "Alterar"   ,"u_Mod2Manut" , 0 , 4 })
	aAdd( aRotina, { "Excluir"   ,"u_Mod2Manut" , 0 , 5 })

	dbSelectArea("SZ4")
	dbSetOrder(1)
	dbGoTop()

	mBrowse(,,,,"SZ4")
Return

User Function Mod2Manut(cAlias,nReg,nOpc)

	//Local cChave := ""
	Local nCOLS := 0
	Local i     := 0
	Local lRet  := .F.

	Private dData    := Ctod(" / / ")
	Private cTitulo  := cCadastro
	Private aC       := {}
	Private aR       := {}
	Private aCGF     := {}
	Private cLinOk   := ""
	Private cAllOk   := "u_Md2TudOk()"
	Private aGetsGD  := {}
	Private bF4      := {|| }
	Private cIniCpos := "+Z4_ITEM"
	Private nMax     := 99
	Private aCordW   := {}
	Private lDelGetD := .T.
	Private aHeader  := {}
	Private aCOLS    := {}
	Private nCount   := 0
	Private bCampo   := {|nField| FieldName(nField) }
	Private cNumero  := Space(10)
	Private aAlt     := {}

	dbSelectArea(cAlias)

	For i := 1 To FCount()
		M->&(Eval(bCampo,i)) := CriaVar(FieldName(i),.T.)
	Next nX

	dbSelectArea("SX3")
	dbSetOrder(1)
	dbSeek(cAlias)

	While !Eof() .And. SX3->X3_ARQUIVO == cAlias
		If X3Uso(X3_USADO) .And. cNivel >= X3_NIVEL .And. !(Trim(X3_CAMPO) $ "Z4_NUMERO/Z4_EMISSAO")
			aAdd(aHeader,{ TRIM(X3_TITULO) ,;
				X3_CAMPO ,;
				X3_PICTURE ,;
				X3_TAMANHO ,;
				X3_DECIMAL ,;
				X3_VALID ,;
				X3_USADO ,;
				X3_TIPO ,;
				X3_ARQUIVO ,;
				X3_CONTEXT })
		Endif
		dbSkip()
	End
	dbSelectArea(cAlias)
	dbSetOrder(1)

	If nOpc <> 3
		cNumero := (cAlias)->Z4_NUMERO
		dbSeek(xFilial(cAlias)+cNumero)
		While !Eof() .And. (cAlias)->(Z4_FILIAL+Z4_NUMERO) == Filial(cAlias)+cNumero
			AADD(aCOLS,Array(Len(aHeader)+1))
			nCOLS++
			For i := 1 To Len(aHeader)
				If aHeader[i,10]<> "V"
					aCOLS[nCOLS,i] := FieldGet(FieldPos(aHeader[i,2]))
				Else
					aCOLS[nCOLS,i] := CriaVar(aHeader[i,2],.T.)
				Endif
			Next i
			aCOLS[nCOLS,Len(aHeader)+1] := .F.
			AADD(aAlt,RecNo())
			dbSelectArea(cAlias)
			dbSkip()
		End
	Else
		cNumero := GetSxeNum("SZ4","Z4_NUMERO")
		aAdd(aCOLS,Array(Len(aHeader)+1))
		For i := 1 To Len(aHeader)
			aCOLS[1,i] := CriaVar(aHeader[i,2])
		Next i
		aCOLS[1,Len(aHeader)+1] := .F.
		aCOLS[1,aScan(aHeader,{|x|Trim(x[2])== "Z4_ITEM"})] := "01"
	Endif

	aAdd(aC,{"cNumero",{15,10},"Número: ","@R",,,.T.})
	aAdd(aC,{"dData",{15,80},"Data de Emissao: ","99/99/9999",,,(nOpc==3)})

	aCGD   := {34,5,128,315}
	cLinOk := "AllwaysTrue()"
	dData  := dDataBase
	lRet   := Modelo2(cTitulo,aC,aR,aCGD,nOpc,cLinOk,cAllOk,,,cIniCpos,nMax)

	If lRet
		If nOpc == 3
			If MsgYesNo("Confirma gravação dos dados ?",cTitulo)
				Processa({||Md2Inclu(cAlias)},cTitulo,"Gravando os dados, aguarde...")
			Endif
		Elseif nOpc == 4
			If MsgYesNo("Confirma alteração dos dados ?",cTitulo)
				Processa({||Md2Alter(cAlias)},cTitulo,"Alterando os dados, aguarde...")
			Endif
		Elseif nOpc == 5
			If MsgYesNo("Confirma eliminação dos dados ?",cTitulo)
				Processa({||Md2Exclu(cAlias)},cTitulo,"Excluíndo os dados, aguarde...")
			Endif
		Endif
	Else
		RollBackSX8()
	Endif
Return

Static Function Md2Inclu(cAlias)
	Local i := 0
	Local y := 0
	ProcRegua(Len(aCOLS))
	dbSelectArea(cAlias)
	dbSetOrder(1)
	For i := 1 To Len(aCOLS)
		IncProc()
		If !aCOLS[i,Len(aHeader)+1]
			RecLock(cAlias,.T.)
			For y := 1 To Len(aHeader)
				FieldPut(FieldPos(aHeader[y,2]),aCOLS[i,y])
			Next y
			(cAlias)->Z4_FILIAL  := xFilial(cAlias)
			(cAlias)->Z4_NUMERO  := cNumero
			(cAlias)->Z4_EMISSAO := dData
			MsUnLock()
		Endif
	Next i
Return

Static Function Md2Alter(cAlias)
	Local i := 0
	Local y := 0
	ProcRegua(Len(aCOLS))
	dbSelectArea(cAlias)
	dbSetOrder(1)
	For i := 1 To Len(aCOLS)
		IncProc()
		If !aCOLS[i,Len(aHeader)+1]
			RecLock(cAlias,.T.)			
			For y := 1 To Len(aHeader)
				FieldPut(FieldPos(Trim(aHeader[y,2])),aCOLS[i,y])
			Next y
			(cAlias)->Z4_FILIAL := xFilial(cAlias)
			(cAlias)->Z4_NUMERO := cNumero
			(cAlias)->Z4_EMISSAO := dData
			MsUnLock()
		Endif
	Next i
Return

Static Function Md2Exclu(cAlias)
	ProcRegua(Len(aCOLS))
	dbSelectArea(cAlias)
	dbSetOrder(1)
	dbSeek(xFilial(cAlias)+cNumero)
	While !Eof() .And. (cAlias)->Z4_FILIAL == xFilial(cAlias) .And. (cAlias)->Z4_NUMERO == cNumero
		IncProc()
		RecLock(cAlias,.F.)
		dbDelete()
		MsUnLock()
		dbSkip()
	End
Return

User Function Md2TudOk()
	Local lRet := .T.
	Local i := 0
	Local nDel := 0

	For i:=1 To Len(aCOLS)
		If aCOLS[i,Len(aHeader)+1]
			nDel++
		Endif
	Next i
	If nDel == Len(aCOLS)
		MsgInfo("Para excluir todos os itens, utilize a opção EXCLUIR",cTitulo)
		lRet := .F.
	Endif
Return(lRet)
