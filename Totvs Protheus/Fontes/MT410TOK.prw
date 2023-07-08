#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                                   MUL - T - LOCK                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºPrograma    ³ MT410TOK  ³ PE no OK do pedido de venda, para digitacao das formas pagto º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAutor       ³ Actual Trend                                          ³ Data ³  23/09/09 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function MT410TOK()

Local nI,nX,_n1                                  
Local _oDlg
Local _nOpcA      := 0
Local _nUsado     := 0
Local lRet        := .T.                                         
Local _aArea      := GetArea()
Local _aArc5	  := SC5->(GetArea())
Local _aSize      := MsAdvSize()
Local _aPosObj    := {}
Local _aObjects   := {}
Local _cCond      := M->C5_CONDPAG
Local _nValTot    := 1000
Local _aVencto    := Condicao(_nValTot,_cCond,0.00,dDataBase,0.00,,)
Local _cParIni    := GetMv("MV_1DUP")
Local _nPosParce  := 0
Local nDupl       := 0
Local cDupl       := ""
                                                                                                        
Private _oGetDados
Private a_coltmp := aClone(aCols)
Private a_hedtmp := aClone(aHeader)
Private cRotina  := Iif(INCLUI == .F., Iif(ALTERA == .F., "DELETA", "ALTERA"), "INCLUI")
Private lRefresh := .T.
Private aHeadSCV := {}
Private aColSCV  := {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Incluido por Alexandre, valida se existem PM's em aberto para a CONTAR do dia anterior                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If M->C5_XTTPPED = 'S' .and. cFilAnt == '03'
/*
	If !U_MFATV004()
		aCols	:= aClone(a_coltmp)
		aHeader	:= aClone(a_hedtmp)
		RestArea(_aArc5)
		RestArea(_aArea)
		Return .F.
	EndIf
*/	
EndIf

AAdd( _aObjects, { 100, 100, .t., .t. } )
_aSize[ 3 ] -= 50
_aSize[ 4 ] -= 50
_aSize[ 5 ] -= 100
_aSize[ 6 ] -= 100

aInfo   := { _aSize[ 1 ], _aSize[ 2 ], _aSize[ 3 ], _aSize[ 4 ], 3, 2 }
_aPosObj := MsObjSize( aInfo, _aObjects )

RegToMemory("SCV", .T., .T.)

//********************** Verifica se gera titulos financeiro conforme TES
For _n1:= 1 to Len(aCols)
	cDupl := GetAdvfVal("SF4","F4_DUPLIC", xFilial("SF4")+aCols[_n1,GdFieldPos("C6_TES",aHeader)],1,"")
	If cDupl == 'S'
		nDupl++
	EndIf                            
Next _n1                                       

If nDupl > 0 .and. SC5->C5_TIPO <> 'D'
	//********************** Executa rotina                         
	If cRotina == "DELETA"
		DbSelectArea("SCV")
		SCV->(DbSetOrder(1))
		If SCV->(DbSeek( xFilial("SCV") + M->C5_NUM ))
			While SCV->CV_PEDIDO == M->C5_NUM .And. SCV->(!Eof())
				RecLock("SCV",.F.)
				SCV->(DbDelete())
				MsUnlock()
				
				SCV->(DbSkip())
			End-While
		EndIf
	Else
     
        IF M->C5_TIPO == "B" .OR. M->C5_TIPO == "D"
				lRet := .T.
				Return(lRet)
        Else
			If Empty(AllTrim(GetAdvfVal("SA1","A1_XTPPAG", xFilial("SA1")+M->C5_CLIENTE,1,"")))
				Aviso("Forma Pagto","Condição de pagamento em branco no cadastro de clientes, impossivel validar o pedido!",{"Ok"},3)
				lRet := .F.
				Return(lRet)
			EndIf
		Endif
			
		DbSelectArea("SX3")
		SX3->(DbSetOrder(1))
		SX3->(DbSeek("SCV"))
		While SX3->(!Eof()) .and. SX3->X3_ARQUIVO == "SCV"
			If X3Uso(SX3->X3_USADO) .and. cNivel >= SX3->X3_NIVEL
				_nUsado++
				Aadd(aHeadSCV,{Trim(X3Titulo()),SX3->X3_CAMPO,SX3->X3_PICTURE, SX3->X3_TAMANHO, SX3->X3_DECIMAL, SX3->X3_VALID,"", SX3->X3_TIPO, "", "" })
			EndIf
			SX3->(DbSkip())
		End-While
		
		_nPosParce :=  GdFieldPos("CV_XPARCEL",aHeadSCV)
		
		If M->C5_CONDPAG == '999'
			_aVencto := {}
			For _n1 := 1 to 10
				n_parc := AllTrim(Soma1(AllTrim(Str(_n1-1,2)),1))
				
				If !Empty(M->&("C5_DATA"+ n_parc )) .And. !Empty(M->&("C5_PARC"+ n_parc ))
					Aadd(_aVencto, {M->&("C5_DATA"+ n_parc ), M->&("C5_PARC"+ n_parc ) } )
				EndIf
			Next
		EndIf
		
		If Len(_aVencto) <= 0
			If M->C5_CONDPAG == '999'
				Aviso("Forma Pagto 999","Necessário digitar data e valor para salvar o Pedido !",{"Ok"},3)
			Else
				Aviso("Forma Pagto","Condição de pagamento invalida!",{"Ok"},3)
			EndIf
			lRet := .F.
			Return(lRet)
		EndIf
		
		DbSelectArea("SCV")
		SCV->(DbSetOrder(2))
		If SCV->(DbSeek( xFilial("SCV") + M->C5_NUM ))
			While SCV->CV_PEDIDO == M->C5_NUM .And. SCV->(!Eof())
				If Len(aColSCV) <= Len(_aVencto)
					Aadd(aColSCV,Array(_nUsado+1))
					For nI := 1 To _nUsado
						If ( aHeadSCV[nI][10] != "V" )
							aColSCV[Len(aColSCV)][nI] := SCV->(FieldGet(FieldPos(aHeadSCV[nI][2])))
						Else
							aColSCV[Len(aColSCV)][nI] := CriaVar(aHeadSCV[nI][2])
						EndIf
					Next
					aColSCV[Len(aColSCV)][_nUsado+1] := .F.
				EndIf
				SCV->(DbSkip())
			End-While
			
			If Len(aColSCV) < Len(_aVencto)
				_cParIni := aColSCV[Len(aColSCV)][_nPosParce]
				
				For nX := (Len(aColSCV)+1) to Len(_aVencto)
					_cParIni := StrZero(nX,1)
					
					Aadd(aColSCV,Array(_nUsado+1))
					For nI := 1 To _nUsado
						If nI == GdFieldPos("CV_XPARCEL",aHeadSCV)
							aColSCV[Len(aColSCV)][nI] := _cParIni
						Else
							aColSCV[Len(aColSCV)][nI] := CriaVar(aHeadSCV[nI][2])
						EndIf
					Next nI
					aColSCV[Len(aColSCV)][_nUsado+1] := .F.
				Next nX
			EndIf
		Else
			For _n1 := 1 to Len(_aVencto)
				If _n1 > 1
					_cParIni := Soma1(_cParIni)
				EndIf
				
				Aadd(aColSCV,Array(_nUsado+1))
				For nI := 1 To _nUsado
					If nI == GdFieldPos("CV_PEDIDO",aHeadSCV)
						aColSCV[Len(aColSCV)][nI] := M->C5_NUM
					ElseIf nI == GdFieldPos("CV_XPARCEL",aHeadSCV)
						aColSCV[Len(aColSCV)][nI] := _cParIni
					Else
						aColSCV[Len(aColSCV)][nI] := CriaVar(aHeadSCV[nI][2],.F.)
					EndIf
				Next
				aColSCV[Len(aColSCV)][_nUsado+1] := .F.
			Next _n1
		EndIf
		
		aSort(aColSCV,,,{|x,y| x[1] < y[1] })
		
		Define MsDialog _oDlg Title "Formas de pagamento" From _aSize[7],00 to _aSize[6],_aSize[5]  PIXEL
		
		_oGetDados := MsNewGetDados():New(_aPosObj[1,1],_aPosObj[1,2],_aPosObj[1,3],_aPosObj[1,4], GD_INSERT+GD_DELETE+GD_UPDATE, , /*cTudoOk*/, /*cIniCpos*/,{"CV_FORMAPG"}, /*nFreeze*/,999,"AllwaysTrue", /*cSuperApagar*/, "U_M410DELE()",_oDlg, aHeadSCV,aColSCV)
		_oGetDados:oBrowse:Align := CONTROL_ALIGN_TOP
		
		Activate MsDialog _oDlg On Init EnchoiceBar(_oDlg, {|| _nOpcA := 1, lRet := U_M410TUDO(_nOpcA), Iif(lRet == .T., _oDlg:End(), "") },{|| _nOpcA := 0, lRet := U_M410TUDO(_nOpcA), Iif(lRet == .T., _oDlg:End(), Aviso("Forma pgto invalida","Existe forma pgto invalida, favor preencher em todas as parcelas",{"OK"})) }) Centered
		
	EndIf
EndIf

RestArea(_aArc5)
RestArea(_aArea)

aCols	:= aClone(a_coltmp)
aHeader	:= aClone(a_hedtmp)

Return(lRet)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                                   MUL - T - LOCK                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºPrograma    ³ M410TUDO  ³ Funcao TudoOK na Get de formas de pagamento.                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAutor       ³ Actual Trend                                          ³ Data ³  23/09/09 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function M410TUDO(_nOpcA)

Local _n2, nz, nY
Local lRet          := .T.
Local nPosForma     := GdFieldPos("CV_FORMAPG",aHeadSCV)
Local _nPosParce    := GdFieldPos("CV_XPARCEL",aHeadSCV)
Local _cCondPagto   := AllTrim( GetMv("MV_CONDCLI",, '1=BOL,2=CH,3=CO,4=CR,5=R$' ))
Local cLinhaPG      := ""
Local nCondErro     := 0
Local nSemForma     := 0
If M->C5_TIPO == "B" .OR. M->C5_TIPO == "D"
	Private _cCondCliente := "BOL"
Else
	Private _cCondCliente := AllTrim(GetAdvfVal("SA1","A1_XTPPAG", xFilial("SA1")+M->C5_CLIENTE,1,""))
Endif
Private nColCli       := At("="+_cCondCliente,  _cCondPagto )

aColSCV := _oGetDados:aCols

If cRotina <> "DELETA"
	If Empty(_cCondCliente)
		Aviso("Forma Pagto","Condição de pagamento em branco no cadastro de clientes, impossivel validar o pedido!",{"Ok"},3)
		lRet := .F.
		Return(lRet)
	EndIf
	
	For _n2 := 1 to Len(aColSCV)
		If Empty(aColSCV[_n2,nPosForma])
			nSemForma++
		Else
			nColPag       := At("="+AllTrim(aColSCV[_n2,GDFIELDPOS("CV_FORMAPG",aHeadSCV)]),  _cCondPagto )
			_cCondCli     := IIf(nColCli<=0,"", Subs(_cCondPagto,(nColCli-1),1))
			_cCondPag     := IIf(nColPag<=0,"", Subs(_cCondPagto,(nColPag-1),1))
			
			If _cCondPag < _cCondCli
				cLinhaPG += StrZero(_n2,2)+" ,"
				nCondErro++
			EndIf
		EndIf
	Next _n2
	
	If nCondErro > 0
		If _nOpcA == 1
			Aviso("Forma Pagto","Condição de pagamento na parcela(s) "+cLinhaPG+" não liberada para esse cliente, selecionar condição valida conforme cadastro do cliente!",{"Ok"},3)
		EndIf
		lRet := .F.
		
		Return()
	EndIf
	
	If nSemForma > 0
		If _nOpcA == 1
			Aviso("Forma pgto em branco","Existe forma pgto em branco, favor preencher em todas as parcelas",{"OK"})
		EndIf
		lRet := .F.
	Else
		For nY := 1 To Len(aColSCV)
			DbSelectArea("SCV")
			SCV->(DbSetOrder(2))
			If SCV->(DbSeek( xFilial("SCV") + M->C5_NUM + aColSCV[nY,_nPosParce]+ aColSCV[nY,nPosForma] ))
				RecLock("SCV",.F.)
			Else
				RecLock("SCV",.T.)
			EndIf
			
			For nZ := 1 To Len(aHeadSCV)
				If aHeadSCV[nZ][10] <> "V"
					SCV->&(aHeadSCV[nZ][2]) := aColSCV[nY][nZ] //SCV->(FieldPut(FieldPos(aHeadSCV[nZ][2]),aColSCV[nY][nZ]))
				EndIf
			Next nZ
			
			SCV->CV_FILIAL := xFilial("SCV")
			SCV->CV_PEDIDO := M->C5_NUM
			SCV->(MsUnLock())
		Next nY
		
		DbSelectArea("SCV")
		SCV->(DbSetOrder(2))
		If SCV->(DbSeek( xFilial("SCV") + M->C5_NUM + Soma1(aColSCV[Len(aColSCV),_nPosParce]) ))
			While SCV->CV_PEDIDO == M->C5_NUM .And. SCV->CV_XPARCEL >= Soma1(aColSCV[Len(aColSCV),_nPosParce]) .And. SCV->(!Eof())
				RecLock("SCV",.F.)
				SCV->(DbDelete())
				SCV->(MsUnLock())
				
				SCV->(DbSkip())
			End-While
		EndIf
	EndIf
EndIf

Return(lRet)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                                   MUL - T - LOCK                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºPrograma    ³ M410DELE  ³ Funcao Deletar na Get de formas de pagamento.                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAutor       ³ Actual Trend                                          ³ Data ³  23/09/09 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function M410DELE()
Aviso("Não deletar","Não é permitido deletar, pois serão geradas parcelas conforme condição de pagamento",{"Cancela"})
Return(.F.)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                                   MUL - T - LOCK                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºPrograma    ³ M410CLIE  ³ Funcao Valida se Forma de pagto pode ser usada pelo cliente. º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAutor       ³ Actual Trend                                          ³ Data ³  15/10/09 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function M410CLIE()                                                                                                

Local aArea        := GetArea()
Local lRet         := .T. //M->CV_FORMAPG
Local cCondCliente := AllTrim(GetAdvfVal("SA1","A1_XTPPAG", xFilial("SA1")+M->C5_CLIENTE,1,""))
Local cCondPagto   := AllTrim( GetMv("MV_CONDCLI",, '1=BOL,2=CH,3=CO,4=CR,5=R$' ))
Local nColCli      := At("="+cCondCliente,  cCondPagto )
Local nColPag      := At("="+AllTrim(M->CV_FORMAPG),  cCondPagto )
Local cCondCli     := IIf(nColCli<=0,"", Subs(cCondPagto,(nColCli-1),1))
Local cCondPag     := IIf(nColPag<=0,"", Subs(cCondPagto,(nColPag-1),1))

If cCondPag < cCondCli
	Aviso("Forma Pagto","Condição de pagamento não liberada para esse cliente, selecionar condição valida conforme cadastro do cliente!",{"Ok"},3)
	M->CV_DESCFOR := " "
	aCols[n,GDFIELDPOS("CV_DESCFOR",aHeader)] := ""
	
	lRet := .F. //Space(03)             
EndIf

RestArea(aArea)

Return(lRet)