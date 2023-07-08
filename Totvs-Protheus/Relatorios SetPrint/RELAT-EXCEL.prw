#Include"rwmake.ch"


User Function RELEXCEL()

	Local aParamBox := {}
	Local aRet		:= {}

	If !MsgYesNo("Este relat๓rio irแ gerar planilha de PRODUTOS, deseja continuar?","RELEXCEL")
		Return
	EndIf


	Aadd(aParamBox,{1,"Produto De"   ,SPACE(9),PesqPict("SB1","B1_COD")   ,"" ,"SB1"	, "", 50, .F.})
	Aadd(aParamBox,{1,"Produto Ate"  ,SPACE(9),PesqPict("SB1","B1_COD")   ,"" ,"SB1"	, "", 50, .F.})
	Aadd(aParamBox,{1,"Dt.Limite De" ,SPACE(9),PesqPict("SC1","C1_DATPRF"),"" ,""	    , "", 50, .F.})

	If ParamBox(aParamBox,"Informe Parametro",@aRet)
		cProdDe     := aRet[1]
		cProdAte    := aRet[2]
	else
		Return
	EndIf



	Processa({|| RELEX1(cProdDe,cProdAte) })


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRELEXCEL  บAutor  ณMicrosiga           บ Data ณ  09/09/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRELATORIO DE DADOS DE PRODUTOS                             บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function RELEX1(cProdDe,cProdAte)

	Local n
	Private cArqTxt := "C:\EXCEL\RELEXCELI.CSV"
	Private nHdl    := fCreate(cArqTxt)
	Private cEOL    := "CHR(13)+CHR(10)"
	MakeDir("C:\EXCEL\")



	cQuery := " SELECT B1_COD, B1_DESC, B1_TIPO, B1_UM, B1_RASTRO
	cQuery += " FROM "+RetSqlName("SB1")+" SB1"
	cQuery += " WHERE
	cQuery += " D_E_L_E_T_ <> '*'
	cQuery += " AND B1_COD BETWEEN '"+cProdDe+"' AND '"+cProdAte+"'"
	cQuery += " ORDER BY B1_COD"

	MEMOWRIT("QUERY\RELEXCEL.SQL", cQuery )

	dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), 'QUERY', .F., .T.)
	Count To nRec

	ProcRegua(nRec)

	If nRec == 0
		MsgStop("Nใo foram encontrados dados!","Aten็ใo - RELEXCEL")
		QUERY->(dbCloseArea())
		Return
	EndIf

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Cria o arquivo texto                                                ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

	If Empty(cEOL)
		cEOL := CHR(13)+CHR(10)
	Else
		cEOL := Trim(cEOL)
		cEOL := &cEOL
	Endif

	If nHdl == -1
		MsgAlert("O arquivo de nome "+cArqTxt+" nao pode ser executado! Verifique os parametros.","Atencao!")
		Return
	Endif


	For n := 1 to FCount()
		aTam := TamSX3(FieldName(n))
		If !Empty(aTam) .and. aTam[3] $ "N/D"
			TCSETFIELD('QUERY',FieldName(n),aTam[3],aTam[1],aTam[2])
		EndIf
	Next

	cLin    := ''
	For n := 1 to FCount()

		If !FieldName(n) $ "R_E_C_N_O_|R_E_C_D_E_L_"
			cLin += AllTrim(Posicione("SX3",2,FieldName(n),"X3_TITULO"))

			IF n == FCount()
				cLin += cEOL//VAI PARA A LINHA DE BAIXO
			Else
				cLin += ';' //PROXIMA COLUNA
			EndIf
		EndIf

	Next

	If fWrite(nHdl,cLin,Len(cLin)) != Len(cLin)
		U_InforConout("Ocorreu um erro na gravacao do arquivo.")
		dbCloseArea()
		fClose(nHdl)
		Return
	Endif


	dbSelectArea("QUERY")
	dbGotop()

	While !Eof()

		IncProc("Processando Aguarde...")

		cLin    := ''
		For n := 1 to FCount()
			If !FieldName(n) $ "R_E_C_N_O_|R_E_C_D_E_L_"
				If Empty(Posicione("SX3",2,FieldName(n),"X3_CBOX"))
					//TIRA PONTO E VIRGULA
					cValor := AllTrim(Transform(FieldGet(n),PesqPict(IIF(At('_',FieldName(n))=3,'S'+Left(FieldName(n),2),Left(FieldName(n),3)),FieldName(n))))
					cLin += StrTran(cValor,";",",")
				Else
					cBox := Posicione("SX3",2,FieldName(n),"X3_CBOX")
					cVar := AllTrim(Transform(FieldGet(n),PesqPict(IIF(At('_',FieldName(n))=3,'S'+Left(FieldName(n),2),Left(FieldName(n),3)),FieldName(n))))+"="
					cConteudo := SubStr(cBox,At(cVar,cBox),Len(cBox))
					cConteudo := SubStr(cConteudo,Len(cVar)+1,At(";",cConteudo)-3)
					cLin += cConteudo
				EndIf
				cLin += IIF(n == FCount(),cEOL,';')
			EndIf
		Next

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Gravacao no arquivo texto. Testa por erros durante a gravacao da    ณ
		//ณ linha montada.                                                      ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

		If fWrite(nHdl,cLin,Len(cLin)) != Len(cLin)
			U_InforConout("Ocorreu um erro na gravacao do arquivo.")
			TRB->(dbCloseArea())
			fClose(nHdl)
			Return
		Endif

		dbSelectArea("QUERY")
		dbSkip()
	End
	QUERY->(dbCloseArea())

	fClose(nHdl)
	If ! ApOleClient( 'MsExcel' )
		ShellExecute("open",cArqTxt,"","", 1 )
		Return
	EndIf

	oExcelApp := MsExcel():New()
	oExcelApp:WorkBooks:Open( cArqTxt ) // Abre uma planilha
	oExcelApp:SetVisible(.T.)

	If MsgYesNo("Deseja fechar a planilha do excel?")
		oExcelApp:Quit()
		oExcelApp:Destroy()
	EndIf


Return



