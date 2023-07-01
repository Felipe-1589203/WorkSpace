#include "topconn.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MTA410T   ºAutor  ³Alexandre Sousa     º Data ³  10/29/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de entrada no final da liberacao de pedidos atraves   º±±
±±º          ³do botao liberacao automatica. Atualiza flags da PM.        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³Especifico MULTLOCK.                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MTA410T()

Local c_query := ""
Local lInclui := .F.    
LOCAL cPedido :=SC5->C5_NUM   

	c_query := " update "+RetSqlName("SC9")+" set  C9_XFATURA = C5_XFATURA, C9_XPM = C5_XTTPPED, C9_XORIGEM = C5_XORIGEM "
	c_query += " from   "+RetSqlName("SC5")+" "
	c_query += " where  C5_NUM = C9_PEDIDO "
	c_query += " and    "+RetSqlName("SC5")+".D_E_L_E_T_ <> '*' "
	c_query += " and    "+RetSqlName("SC9")+".D_E_L_E_T_ <> '*' "
	c_query += " and    C9_XFATURA = '' "
	c_query += " and    C5_XFATURA <> '' "

	TcSqlExec(c_query)

//incluido bloco abaixo para tratar inclusao de pedido na SZ2 quando pedido de Industrialização/Beneficiamento incluido  LH-Actual 07/12/2016     

MontaQry1(cPedido)

QRY->(DbGoTop())    
If QRY->(!EOF())
    lInclui := .F. 
Else
  	lInclui := .T.
EndIf             
                                                      
If lInclui
	RecLock("SZ2", .T.)
	SZ2->Z2_FILIAL	:= xFilial("SZ2")
	SZ2->Z2_PEDIDO	:= SC5->C5_NUM
	SZ2->Z2_CLIENTE	:= SC5->C5_CLIENTE
	SZ2->Z2_LOJA	:= SC5->C5_LOJACLI
	If SC5->C5_TIPO = 'N'
		SZ2->Z2_NOMECLI	:= GetAdvFval("SA1", "A1_NOME", xFilial("SA1")+SC5->(C5_CLIENTE+C5_LOJACLI), 1, ' ')
	Else
		SZ2->Z2_NOMECLI	:= GetAdvFval("SA2", "A2_NOME", xFilial("SA2")+SC5->(C5_CLIENTE+C5_LOJACLI), 1, ' ')
	EndIf
	SZ2->Z2_TRANSP 	:= SC5->C5_TRANSP
	SZ2->Z2_DESCTRA	:= GetAdvFval("SA4", "A4_NOME", xFilial("SA4")+SC5->C5_TRANSP, 1, ' ')
	SZ2->Z2_STATUS	:= 'P'
	MsUnLock()	
EndIf
// fim do bloco LH - Actual 07/12/2016
Return                       

// funcao que verifica se o pedido ja existe na SZ2 e retorna o conteudo falso ou verdadeiro LH -Actual 07/12/2016
Static Function MontaQry1(cPedido)
Local cQuery := ''     

cQuery := " Select * from "+RetSqlName("SZ2")+" SZ2 where Z2_PEDIDO = '"+cPedido+"' and Z2_DOC = ' ' and Z2_STATUS = 'P' and D_E_L_E_T_ = ' ' "

If Select("QRY") > 0
	DbSelectArea("QRY")
	DbCloseArea()
EndIf

dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "QRY", .T., .F. )    

Return    
// fim da funcao LH -Actual 07/12/2016