#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ CriaCols บAutor  ณAlexandre Martins   บ Data ณ  22/10/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao que cria o aCols para o objeto MsNewGetDados         บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ nOpcBrow = Opcao selecionada no mBrowse                    บฑฑ
ฑฑบ          ณ aHeadATU = Array com aHeader ja criado                     บฑฑ
ฑฑบ          ณ cTabeSX2 = Tabela para retorno dos dados quando ALTERACAO  บฑฑ
ฑฑบ          ณ            VISUALIZACAO e EXCLUSAO                         บฑฑ
ฑฑบ          ณ nOrdIndi = Ordem de indice para retorno de linhas          บฑฑ
ฑฑบ          ณ cExpress = Expressao de chave de busca                     บฑฑ
ฑฑบ          ณ cCondica = Condicao para busca dos dados na tabela         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Omnilink                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CriaCols(nOpcBrow,aHeadATU,cTabeSX2,nOrdIndi,cExpress,cCondica,cQryFilt)
Local aRetorno := {}
Local aAreaBKP := GetArea() 
Local cCpoRegi	:= ""
Local i
   
If nOpcBrow == 3
	//ฺฤฤฤฤฤฤฤฤฟ
	//ณINCLUSAOณ
	//ภฤฤฤฤฤฤฤฤู                  
	Aadd(aRetorno,Array(Len(aHeadAtu) + 1))
	For i := 1 To Len(aHeadAtu)
		aRetorno[Len(aRetorno)][i]	:= CriaVar(AllTrim(aHeadAtu[i][2]),.T.)
	Next i                       
	aRetorno[Len(aRetorno)][Len(aHeadAtu) + 1]	:= .F.
ElseIf nOpcBrow == 2 .Or. nOpcBrow == 4 .Or. nOpcBrow == 5
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณVISUALIZACAO, ALTERACAO e EXCLUSAOณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู  
	If !Empty(cCondica) 
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณFiltro por CONDICAOณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		dbSelectArea(cTabeSX2)
		&(cTabeSX2)->(dbSetOrder(nOrdIndi))
		If &(cTabeSX2)->(dbSeek(cExpress))
			While &(cTabeSX2)->(!Eof()) .And. &(cCondica)
				Aadd(aRetorno,Array(Len(aHeadAtu) + 1))
				For i := 1 To Len(aHeadAtu) 
					cCpoRegi := cTabeSX2+"->"+AllTrim(aHeadAtu[i][2])
					aRetorno[Len(aRetorno)][i]	:= &(cCpoRegi)
				Next i 
				aRetorno[Len(aRetorno)][Len(aHeadAtu) + 1] := .F.
				
				&(cTabeSX2)->(dbSkip())
			EndDo
		EndIf
	ElseIf !Empty(cQryFilt)   
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณFiltro por QUERYณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If Select("TRB_QRY") > 0
			TRB_QRY->(dbCloseArea())
		EndIf
		
		dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cQryFilt),"TRB_QRY", .F., .T.)
		dbSelectArea("TRB_QRY")
		TRB_QRY->(dbGoTop())
		While TRB_QRY->(!Eof())
			Aadd(aRetorno,Array(Len(aHeadAtu) + 1))
			For i := 1 To Len(aHeadAtu)         
				cCpoRegi := "TRB_QRY->"+AllTrim(aHeadAtu[i][2])  
								
				If aHeadAtu[i][8] == "D"
					aRetorno[Len(aRetorno)][i]	:= STod(&(cCpoRegi))
				Else
					aRetorno[Len(aRetorno)][i]	:= &(cCpoRegi)	
				EndIf

			Next i 
			aRetorno[Len(aRetorno)][Len(aHeadAtu) + 1] := .F.   
			
			TRB_QRY->(dbSkip())
		EndDo
		
		TRB_QRY->(dbCloseArea())
	EndIf
EndIf

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณRestaura a area inicialณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
RestArea(aAreaBKP)

Return(aRetorno)
