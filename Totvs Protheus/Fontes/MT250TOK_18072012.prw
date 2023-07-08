#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#include "Ap5Mail.ch"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                                   MUL - T - LOCK                                      บฑฑ
ฑฑฬออออออออออออัอออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบPrograma    ณ MT250TOK  ณ P.E. na validacao total dos dados da tela na digitacao das   บฑฑ
ฑฑบ            ณ           ณ producoes de OP                                              บฑฑ
ฑฑฬออออออออออออุอออออออออออฯอออออออออออออออออออออออออออออออออออออออออออัออออออัอออออออออออนฑฑ
ฑฑบAutor       ณ Actual Trend                                          ณ Data ณ  21/09/09 บฑฑ
ฑฑฬออออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออฯอออออออออออนฑฑ
ฑฑบParametros  ณ                                                                          บฑฑ
ฑฑฬออออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno     ณ                                                                          บฑฑ
ฑฑฬออออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบObservacoes ณ                                                                          บฑฑ
ฑฑศออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

User Function MT250TOK()
                                                                                                       
Local aAreaSB1  := SB1->(GetArea())            
Local aAreaSA1  := SA1->(GetArea())
Local aAreaSC5  := SC5->(GetArea())
Local aAreaSC6  := SC6->(GetArea())
Local aAreaSG1  := SG1->(GetArea())
Local aAreaSD4  := SD4->(GetArea())
Local cProduto  := Posicione("SB1",1, xFilial("SB1") + M->D3_COD  , "B1_DESC")
Local cItemPed  := Posicione("SC6",7, xFilial("SC6") + M->D3_OP   , "C6_NUM")
Local cPedido   := Posicione("SC5",1, xFilial("SC5") + SC6->C6_NUM, "C5_NUM")
Local cCliente  := Posicione("SA1",1, xFilial("SA1") + SC5->C5_CLIENTE+SC5->C5_LOJACLI, "A1_NOME")
//Local cFrom     := Iif(SC5->C5_XORIGEM == "A", GetMV('MV_XMAILAU'), IIf(SC5->C5_XORIGEM == "C", GetMV('MV_XMAILCO'), IIf(SC5->C5_XORIGEM == "V", GetMV('MV_XMAILVA'), If(SC5->C5_XORIGEM == "M", GetMV('MV_XMAILMT'), "marco_a@multlock.com.br" ))))
Local cFrom     := Iif(SC5->C5_XORIGEM == "A", GetMV('MV_XMAILAU'), IIf(SC5->C5_XORIGEM == "C", GetMV('MV_XMAILCO'), IIf(SC5->C5_XORIGEM == "V", GetMV('MV_XMAILVA'), If(SC5->C5_XORIGEM == "M", GetMV('MV_XMAILMT'), "marco_a@multlock.com.br" ))))
  
//alert("TESTE - ENVIO WORFLOW")

If upper(alltrim(SC5->C5_XORIGEM)) == "C"
	cFrom	:= GetMV('MV_XMAILCO')
	cFrom	+= '; alexandre.martins@actualtrend.com.br'
EndIf
 
Private c_Texto  := ''
Private c_MsgErro:= ''  
Private cAviso := " "

SD4->(DbSetOrder(2))
SD4->(DbSeek( xFilial("SD4") +  M->D3_OP ))
While SD4->D4_FILIAL = 	xFilial("SD4") .And. SD4->D4_OP = M->D3_OP .And. SD4->(!Eof())
    nQtdeStru := 0                   
	SG1->(DbSetOrder(1))
	If SG1->(DbSeek( xFilial("SG1") +  M->D3_COD + SD4->D4_COD))
	    nQtdeStru :=  SG1->G1_QUANT                  
    EndIf

	If (M->D3_QUANT*nQtdeStru) > (SD4->D4_QTDEORI - SD4->D4_QUANT)
		cAviso += "Componente: "+ Alltrim(SD4->D4_COD) +" Arm: "+ SD4->D4_LOCAL+ " Qtd Apontada maior que liberada: "+AllTrim(TransForm((SD4->D4_QTDEORI - SD4->D4_QUANT), PesqPict("SD4","D4_QUANT"))) + Chr(13)+Chr(10)
	EndIf

	SD4->(DbSkip())
End-While

If !Empty(cAviso) .and. M->D3_TM <> "012"
	Aviso( "Impossํvel apontar OP, Analisar saldos dos Empenhos!", cAviso, {"&Ok"} )
	Return(.F.)
EndIf

If INCLUI == .T. .And. !Empty(cPedido)
	fArq("\HTML\Producao.htm", "C:\Producao.htm")

	__CopyFile("\HTML\Producao.htm", "C:\Producao.htm")

	If !FGEN010(cFrom,"Movimento de Produ็ใo",c_texto,"",.T.)
		Return c_MsgErro
	EndIf
EndIf

RestArea(aAreaSB1)

RestArea(aAreaSA1)
RestArea(aAreaSC5)
RestArea(aAreaSC6)
RestArea(aAreaSD4)
RestArea(aAreaSG1)

Return(.T.)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                                   MUL - T - LOCK                                      บฑฑ
ฑฑฬออออออออออออัอออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบPrograma    ณ fArq      ณ Funcao para gravacao buffer arquivo HTML.                    บฑฑ
ฑฑฬออออออออออออุอออออออออออฯอออออออออออออออออออออออออออออออออออออออออออัออออออัอออออออออออนฑฑ
ฑฑบAutor       ณ Actual Trend                                          ณ Data ณ  21/09/09 บฑฑ
ฑฑฬออออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออฯออออออฯอออออออออออนฑฑ
ฑฑบParametros  ณ                                                                          บฑฑ
ฑฑฬออออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno     ณ                                                                          บฑฑ
ฑฑฬออออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบObservacoes ณ                                                                          บฑฑ
ฑฑศออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

Static Function fArq(c_FileOrig, c_FileDest)

Local l_Ret 	:= .T.
Local c_Buffer	:= ""
Local n_Posicao	:= 0
Local n_QtdReg	:= 0
Local n_RegAtu	:= 0

If !File(c_FileOrig)
	l_Ret := .F.
	MsgStop("Arquivo [ "+c_FileOrig+" ] nใo localizado.", "Nใo localizou")
Else
	
	Ft_fuse( c_FileOrig ) 		// Abre o arquivo
	Ft_FGoTop()
	n_QtdReg := Ft_fLastRec()
	nHandle	:= MSFCREATE( c_FileDest )
	
	///////////////////////////////////
	// Carregar o array com os itens //
	///////////////////////////////////
	While !ft_fEof() .And. l_Ret
		c_Buffer := ft_fReadln()
		
		FWrite(nHandle, &("'" + c_Buffer + "'"))
		c_texto += &("'" + c_Buffer + "'")
		ft_fSkip()
	Enddo
	FClose(nHandle)
EndIf

Return l_Ret             



//---------------------------------


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFGEN010   บAutor  ณAlexandre Martins   บ Data ณ  10/06/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao para envio de e-mail.                               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParโmetrosณ ExpC1: e-mail do destinatแrio                              บฑฑ
ฑฑบ          ณ ExpC2: assunto do e-mail                                   บฑฑ
ฑฑบ          ณ ExpC3: texto do e-mail                                     บฑฑ
ฑฑบ          ณ ExpC4: anexos do e-mail                                    บฑฑ
ฑฑบ          ณ ExpL1: exibe mensagem de envio                             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ Retorno  ณ ExpL2: .T. - envio realizado                               บฑฑ
ฑฑบ          ณ        .F. - nใo enviado                                   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Exclusivo Nytron                                           บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FGEN010(c_MailDestino,c_Assunto,c_Texto,c_Anexos,l_Mensagem)

Local 	l_Ret				:= .T.
Local 	c_Cadastro		:= "Envio de e-mail"
Private	c_MailServer	:= AllTrim(GetMv("MV_RELSERV"))
Private	c_MailConta 	:= AllTrim(GetMv("MV_RELAUSR"))
Private l_Auth			:= GetMv("MV_RELAUTH")
Private c_MailAuth		:= AllTrim(GetMv("MV_RELACNT"))

Private	c_MailSenha		:= AllTrim(GetMv("MV_RELPSW"))
Private c_SenhaAuth		:= AllTrim(GetMv("MV_RELAPSW"))
Private	c_MailDestino	:= If( ValType(c_MailDestino) != "U" , c_MailDestino,  "" )
Private	l_Mensagem		:= If( ValType(l_Mensagem)    != "U" , l_Mensagem,  .T. )

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณEfetua validacoesณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

If Empty(c_MailDestino)
	If l_Mensagem
		Aviso(	c_Cadastro, "Conta(s) de e-mail de destino(s) nใo informada. ";
		+"Envio nใo realizado.",{"&Ok"},,"Falta informa็ใo" )
	EndIf
	c_msgerro := "Conta(s) de e-mail de destino(s) nใo informada. Envio nใo realizado."
	l_Ret	:= .F.
EndIf

If Empty(c_Assunto)
	If l_Mensagem
		Aviso(	c_Cadastro,"Assunto do e-mail nใo informado. ";
		+"Envio nใo realizado.",{"&Ok"},,"Falta informa็ใo" )
	EndIf
	c_msgerro := "Assunto do e-mail nใo informado. Envio nใo realizado."
	l_Ret	:= .F.
EndIf

If Empty(c_Texto)
	If l_Mensagem
		Aviso(	c_Cadastro,"Texto do e-mail nใo informado. ";
		+"Envio nใo realizado.",{"&Ok"},, "Falta informa็ใo" )
	EndIf
	c_msgerro := "Texto do e-mail nใo informado. Envio nใo realizado."
	l_Ret	:= .F.
EndIf

If l_Ret
	If l_Mensagem
		Processa({|| l_Ret := SendMail(c_MailDestino,c_Assunto,c_Texto,c_Anexos,l_Mensagem), "Enviando e-mail"})
	Else
		l_Ret := SendMail(c_MailDestino,c_Assunto,c_Texto,c_Anexos,l_Mensagem)
	EndIf
EndIf

Return(l_Ret)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณSendMail  บAutor  ณAlexandre MArtins   บ Data ณ  10/06/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao de envio de e-mail.                                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Exclusivo Nytron.                                          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function SendMail(c_MailDestino,c_Assunt,c_Text,c_Anexo,l_Mensagem)

Local l_Conexao		:= .F.
Local l_Envio			:= .F.
Local l_Desconexao	:= .F.
Local l_Ret				:= .F.
Local c_Assunto		:= If( ValType(c_Assunt) != "U" , c_Assunt , "" )
Local c_Texto			:= If( ValType(c_Text)   != "U" , c_Text   , "" )
Local c_Anexos			:= If( ValType(c_Anexo)  != "U" , c_Anexo  , "" )
Local c_Erro_Conexao	:= ""
Local c_Erro_Envio		:= ""
Local c_Erro_Desconexao	:= ""
Local c_Cadastro			:= "Envio de e-mail"

If l_Mensagem
	IncProc("Conectando-se ao servidor de e-mail...")
EndIf

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Executa conexao ao servidor mencionado no parametro. ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Connect Smtp Server c_MailServer ACCOUNT c_MailConta PASSWORD c_MailSenha RESULT l_Conexao

If !l_Conexao
	GET MAIL ERROR c_Erro_Conexao
	If l_Mensagem
		Aviso(	c_Cadastro, "Nao foi possํvel estabelecer conexใo com o servidor - ";
		+c_Erro_Conexao,{"&Ok"},,"Sem Conexใo" )
	EndIf
	c_msgerro := "Nao foi possํvel estabelecer conexใo com o servidor - "+c_Erro_Conexao
	l_Ret := .F.
EndIf

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณVerifica se deve fazer autenticacaoณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If l_Auth
	If !MailAuth(c_MailAuth, c_SenhaAuth)
		GET MAIL ERROR c_Erro_Conexao
		If l_Mensagem
			Aviso(	c_Cadastro, "Nao foi possํvel autenticar a conexใo com o servidor - ";
			+c_Erro_Conexao,{"&Ok"},,"Sem Conexใo" )
		EndIf
		c_msgerro := "Nao foi possํvel autenticar a conexใo com o servidor - "+c_Erro_Conexao
		l_Ret := .F.
	EndIf
EndIf

If l_Mensagem
	IncProc("Enviando e-mail...")
EndIf

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Executa envio da mensagem. ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If !Empty(c_Anexos)
	Send Mail From c_MAILCONTA to c_MailDestino SubJect c_Assunto BODY c_Texto FORMAT TEXT ATTACHMENT c_Anexos RESULT l_Envio
Else
	Send Mail From c_MAILCONTA to c_MailDestino SubJect c_Assunto BODY c_Texto FORMAT TEXT RESULT l_Envio
EndIf

If !l_Envio
	Get Mail Error c_Erro_Envio
	If l_Mensagem
		Aviso(	c_Cadastro,"Nใo foi possํvel enviar a mensagem - ";
		+c_Erro_Envio,{"&Ok"},,	"Falha de envio" )
	EndIf
	c_msgerro := "Nใo foi possํvel enviar a mensagem - "+c_Erro_Envio
	l_Ret := .F.
Else
	l_Ret := .T.
EndIf

If l_Mensagem
	IncProc("Desconectando-se do servidor de e-mail...")
EndIf

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Executa disconexao ao servidor SMTP. ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
DisConnect Smtp Server Result l_Desconexao

If !l_Desconexao
	Get Mail Error c_Erro_Desconexao
	If l_Mensagem
		Aviso(	c_Cadastro,"Nใo foi possํvel desconectar-se do servidor - ";
		+c_Erro_Desconexao,{"&Ok"},,"Descone็ใo" )
	EndIf
	c_msgerro := "Nใo foi possํvel desconectar-se do servidor - "+c_Erro_Desconexao
	l_Ret := .F.
EndIf

Return(l_Ret)                         