#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "Ap5mail.ch"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                                   MUL - T - LOCK                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºPrograma    ³ MA030TOK  ³ Ponto de entrada no cadastro de clientes para envio de WF    º±±
±±º            ³           ³ aviso para emails cadastrados nos parametros MV_XCLIEN0 a    º±±
±±º            ³           ³ MV_XCLIEN5, conforme folder SA1                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAutor       ³ Actual Trend                                          ³ Data ³  29/12/09 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function MA030TOK()

Local _n1
Local _cAlias   := "SA1"
Local _aAreaSA1 := SA1->(GetArea())
Local _aAreaSX3 := SX3->(GetArea())
Local _nAltera  := 0
Local cHtmRet   := ""
Local Assunto   := "Manutenção no cadastro de clientes"

DbSelectArea("SX3")
SX3->(DbSetOrder(4))
SX3->(DbSeek(_cAlias))

cFolder := SX3->X3_FOLDER
cHtmRet := MA030HTML(cHtmRet, 1, cFolder)

If INCLUI == .T.
	_nAltera++
ElseIf INCLUI == .F. .And. ALTERA == .F.
	_nAltera++
ElseIf ALTERA == .T.
	While SX3->X3_ARQUIVO == _cAlias .And. SX3->(!Eof())
		If AllTrim(SX3->X3_CONTEXT) <> "V" .And. X3Uso(SX3->X3_Usado)
			If cFolder <> SX3->X3_FOLDER
				cHtmRet   := MA030HTML(cHtmRet, 2, cFolder)
				cMailDest := IIf(EMpty(cFolder), AllTrim(GetMv("MV_XCLIEN0")), AllTrim(GetMv("MV_XCLIEN"+cFolder)) )
				cFolder   := SX3->X3_FOLDER
				
				If cFolder == "4" .Or. cFolder == "1"
					If Empty(M->A1_XORIGEM)
						cMailDest := AllTrim(GetMv("MV_XCLIEN"+cFolder))
					ElseIf M->A1_XORIGEM == "A" // Automotivo
						cMailDest := AllTrim(GetMv("MV_XCLIENA"))
					ElseIf M->A1_XORIGEM == "C" // Corporativo
						cMailDest := AllTrim(GetMv("MV_XCLIENC"))
					ElseIf M->A1_XORIGEM == "V" // Varejo
						cMailDest := AllTrim(GetMv("MV_XCLIENV"))
					ElseIf M->A1_XORIGEM == "M" // MultLock Center
						cMailDest := AllTrim(GetMv("MV_XCLIENM"))
					ElseIf M->A1_XORIGEM == "S" // Assistencia tecnica
						cMailDest := AllTrim(GetMv("MV_XCLIENS"))
					EndIf                                                  
				EndIf
				
				If _nAltera > 0
					cHtmRet := AllTrim(cHtmRet)
					U_FGEN010(cMailDest,Assunto,cHtmRet,,.T.)
				EndIf
				
				cHtmRet := ""
				cHtmRet := MA030HTML(cHtmRet, 1, cFolder)
				
				_nAltera := 0
			EndIf
			
			If SA1->&(SX3->X3_CAMPO) <> M->&(SX3->X3_CAMPO)
				If SX3->X3_TIPO == "D"
					cHtmRet	+= '<tr>'
					cHtmRet	+= '    <td><div align="left">' + SX3->X3_TITULO               + '</div></td>'
					cHtmRet	+= '    <td><div align="left">' + Dtoc(SA1->&(SX3->X3_CAMPO)) + '</div></td>'
					cHtmRet	+= '    <td><div align="left">' + Dtoc(M->&(SX3->X3_CAMPO)  ) + '</div></td>'
					cHtmRet	+= '</tr>'
					
				ElseIf SX3->X3_TIPO == "N"
					cHtmRet	+= '<tr>'
					cHtmRet	+= '    <td><div align="left"> ' + SX3->X3_TITULO                                              + '</div></td>'
					cHtmRet	+= '    <td><div align="right">' + Transform(SA1->&(SX3->X3_CAMPO),Alltrim(SX3->X3_PICTURE)) + '</div></td>'
					cHtmRet	+= '    <td><div align="right">' + Transform(M->&(SX3->X3_CAMPO)  ,Alltrim(SX3->X3_PICTURE)) + '</div></td>'
					cHtmRet	+= '</tr>'
					
				Else
					cHtmRet	+= '<tr>'
					cHtmRet	+= '    <td><div align="left"> ' + SX3->X3_TITULO         + '</div></td>'
					cHtmRet	+= '    <td><div align="right">' + SA1->&(SX3->X3_CAMPO) + '</div></td>'
					cHtmRet	+= '    <td><div align="right">' + M->&(SX3->X3_CAMPO)   + '</div></td>'
					cHtmRet	+= '</tr>'
				EndIf
				
				_nAltera++
			EndIf
		EndIf
		
		SX3->(DbSkip())
	End-While
EndIf

cHtmRet := MA030HTML(cHtmRet, 2, cFolder)

If _nAltera > 0
	cHtmRet   := AllTrim(cHtmRet)
	
	If INCLUI == .T. .Or. (INCLUI == .F. .And. ALTERA == .F.)
		For _n1 := 0 to 5
			cMailDest :=  AllTrim(GetMv("MV_XCLIEN"+AllTrim(Str(_n1))))
			If _n1 == 4 .Or. _n1 == 1
				If Empty(SA1->A1_XORIGEM)
					cMailDest := AllTrim(GetMv("MV_XCLIEN"+StrZero(_n1,1)))
				ElseIf SA1->A1_XORIGEM == "A" // Automotivo
					cMailDest := AllTrim(GetMv("MV_XCLIENA"))
				ElseIf SA1->A1_XORIGEM == "C" // Corporativo
					cMailDest := AllTrim(GetMv("MV_XCLIENC"))
				ElseIf SA1->A1_XORIGEM == "V" // Varejo
					cMailDest := AllTrim(GetMv("MV_XCLIENV"))
				ElseIf SA1->A1_XORIGEM == "M" // MultLock Center
					cMailDest := AllTrim(GetMv("MV_XCLIENM"))
				ElseIf M->A1_XORIGEM == "S" // Assistencia tecnica
					cMailDest := AllTrim(GetMv("MV_XCLIENS"))
				EndIf
			EndIf
			
			U_FGEN010(cMailDest,Assunto,cHtmRet,,.T.)
		Next
		
	ElseIf ALTERA == .T.
		cMailDest := IIf(Empty(cFolder), AllTrim(GetMv("MV_XCLIEN0")), AllTrim(GetMv("MV_XCLIEN"+cFolder)) )
		
		If cFolder == "4" .Or. cFolder == "1"
			If Empty(M->A1_XORIGEM)
				cMailDest := AllTrim(GetMv("MV_XCLIEN"+cFolder))
			ElseIf M->A1_XORIGEM == "A" // Automotivo
				cMailDest := AllTrim(GetMv("MV_XCLIENA"))
			ElseIf M->A1_XORIGEM == "C" // Corporativo
				cMailDest := AllTrim(GetMv("MV_XCLIENC"))
			ElseIf M->A1_XORIGEM == "V" // Varejo
				cMailDest := AllTrim(GetMv("MV_XCLIENV"))
			ElseIf M->A1_XORIGEM == "M" // MultLock Center
				cMailDest := AllTrim(GetMv("MV_XCLIENM"))
			ElseIf M->A1_XORIGEM == "S" // Assistencia tecnica
				cMailDest := AllTrim(GetMv("MV_XCLIENS"))
			EndIf
		EndIf
	EndIf
EndIf
                                 
RestArea(_aAreaSA1)
RestArea(_aAreaSX3)

Return(.T.)


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                                   MUL - T - LOCK                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºPrograma    ³ MA030HTML ³ Gera codigo HTML para envio                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAutor       ³ Actual Trend                                          ³ Data ³  29/12/09 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function MA030HTML(cHtmRet, nTipo, cFolder)

Local _cCliente := IIf((INCLUI == .F. .And. ALTERA == .F.), SA1->A1_COD, Posicione("SA1",1, xFilial('SA1') + M->A1_COD + M->A1_LOJA, "A1_COD"))
_cCliente := IIf((INCLUI == .F. .And. ALTERA == .F.), SA1->A1_COD+" / "+SA1->A1_LOJA+" - "+SA1->A1_NOME, M->A1_COD+" / "+M->A1_LOJA+" - "+M->A1_NOME)

If nTipo == 1      // Cabecalho
	cHtmRet += '<html>'
	
	cHtmRet += '    <head>'
	cHtmRet += '        <title>Documento sem t&iacute;tulo</title>'
	cHtmRet += '        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">'
	cHtmRet += '    </head>'
	
	cHtmRet += '    <body>'
	//cHtmRet += '        <tr>'
	//cHtmRet += '            <img border="0" src="http://gps.totvs.com.br/workflow/logototvs2008.jpg"/></font></div></td>'+ CRLF
	//cHtmRet += '            <img border="0" src="/Protheus/Protheus10/Ap_Data_MTL/System/Logotipo/LOGOTIPO.jpg"/></font></div></td>'+ CRLF
	//cHtmRet += '        </tr>'
	cHtmRet	+= '        <br> <br>'
	
	cHtmRet += '        <font face="Times New Roman, Times, serif"></font>'
	cHtmRet	+= '        <strong> Cliente      : </strong> '+_cCliente
	cHtmRet	+= '        <br> <br>'
	cHtmRet	+= '        <strong> Alterado por : </strong> '+Subs(cUsuario,7,15)+" <strong> em </strong> "+Dtoc(dDatabase)+"<strong> as </strong> "+Left(Time(),5)+" <strong> Hrs </strong>"
	cHtmRet	+= '        <br> <br>'
	
	If INCLUI   == .T.
		cHtmRet += '        <font size="+2">'
		cHtmRet	+= '            <strong><center> Registro I N C L U I D O </strong><center>'
		cHtmRet += '        <font size="-2">'
		cHtmRet	+= '        <br> <br>'                      
	ElseIf INCLUI == .F. .And. ALTERA == .F.
		cHtmRet += '        <font size="+2">'
		cHtmRet	+= '            <strong><center> Registro D E L E T A D O </strong><center>'
		cHtmRet += '        <font size="-2">'
		cHtmRet	+= '        <br> <br>'
	ElseIf ALTERA == .T.
		cHtmRet += '        <font size="+2">'
		cHtmRet	+= '            <strong><center> Campos Alterados na pasta '+ IIf(Empty(cFolder),' "Outros','"'+AllTrim(Posicione("SXA",1, "SA1"+cFolder, "XA_DESCRIC"))) +'"'+' </strong><center>'
		cHtmRet += '        <font size="-2">'
		cHtmRet	+= '        <br> <br>'
		
		cHtmRet	+= '        <table width="895" border="1">'
		cHtmRet	+= '            <tr>'
		cHtmRet	+= '                <td width="63">  <strong>Campo         </strong></td>'
		cHtmRet	+= '                <td width="200"> <strong>Conteúdo de   </strong></td>'
		cHtmRet	+= '                <td width="200"> <strong>Conteúdo para </strong></td>'
		cHtmRet	+= '            </tr>'
	EndIf
	
ElseIf nTipo == 2  // Rodape
	
	cHtmRet	+= '        </table>' + CRLF + CRLF + CRLF + CRLF
	cHtmRet += '    </body>'
	cHtmRet += '</html>'
EndIf

Return(cHtmRet)