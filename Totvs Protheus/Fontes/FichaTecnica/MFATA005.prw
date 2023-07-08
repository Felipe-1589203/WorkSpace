#Include "Protheus.ch"
#include "rwmake.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MFATA005  ºAutor  ³Alexandre Sousa     º Data ³  10/23/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Manutencao da Ficha Tecnica.                                º±±   
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º          ³[Mauro Nagata, Actual Trend, Nov/2010                       º±±
±±º          ³Continuidade na customizacao da manutencao da ficha tecnica º±±
±±º          ³Definicao e validacao sendo realizado pelo sr.Andre,TI      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³Especifico MultLock.                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MFATA005()

Public c_BATENTE:=.F.
Public c_pedido := ''
Public c_item	:= ''
Public c_prod	:= ''
Public _cC6Prod,_cC6Ped,_cC6It
aCampoSN8 := {}                     
aCmpEdit  := {}  //campos editaveis
_cAlias := Alias()

n_possitem	:= aScan(aHeader,{ |x| UPPER(ALLTRIM(x[2])) == "C6_ITEM"})
n_posprod	:= aScan(aHeader,{ |x| UPPER(ALLTRIM(x[2])) == "C6_PRODUTO"})
n_posop		:= aScan(aHeader,{ |x| UPPER(ALLTRIM(x[2])) == "C6_NUMOP"})
n_positop	:= aScan(aHeader,{ |x| UPPER(ALLTRIM(x[2])) == "C6_ITEMOP"})
n_postes	:= aScan(aHeader,{ |x| UPPER(ALLTRIM(x[2])) == "C6_TES"})

c_pedido	:= M->C5_NUM
c_item		:= aCols[n,n_possitem]
c_prod		:= aCols[n,n_posprod]
c_TES		:= aCols[n,n_postes]
c_op		:= aCols[n,n_posop]+aCols[n,n_positop]

c_tesFT := GetMV("MV_XTESFT")

If alltrim(c_TES) $ c_tesFT
	msgAlert('ESSA TES NAO PERMITE ABRIR FICHA TECNICA', 'A T E N Ç Ã O')
	Return
EndIf


lBatEdit := .F.   //campos da pasta batente editavel  
For nI := 1 To Len(aCols) 
    If Substr(aCols[nI][n_posprod],1,2) = "BA".And.!aCols[nI][Len(aHeader)+1]
       lBatEdit := .T.   //campos da pasta batente editavel
    EndIf   
Next    

dbSelectArea("SB1")
dbSetOrder(1)
dbSeek(xFilial()+c_prod)
c_grupo := SB1->B1_GRUPO

If !aCols[n,Len(aHeader)+1].And.!Empty(aCols[n,n_posprod])
	If !Empty(c_prod) .and. substr(c_prod,1,2) = 'PO'         
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Carrega matriz com campos que serao alterados neste cadastro ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("SX3")
		dbSetOrder(1)
		dbSeek("SZ0")
		
		Do While !Eof() .And. (X3_ARQUIVO == "SZ0")
			If !(M->C5_XORIGEM != "C".And.AllTrim(SX3->X3_CAMPO) $ "Z0_BATENTE#Z0_FECHELE#Z0_TESBAT#Z0_QTDFECB")       //se segmento do cliente for diferente de Corporativo
			   aAdd(aCampoSN8,X3_CAMPO)                   //Campos a serem alterados, exceto os campos chave.
			EndIf   
			If !(M->C5_XORIGEM != "C".And.AllTrim(SX3->X3_CAMPO) $ "Z0_BATENTE.Z0_FECHELE.Z0_TESBAT.Z0_OBSBAT.Z0_QTDFECB").Or.lBatEdit       //se segmento do cliente for diferente de Corporativo
			   aAdd(aCmpEdit,X3_CAMPO)
			EndIf   
			DbSkip()
		EndDo
		
		_cC6Prod	:= c_prod
		_cC6Ped		:= c_pedido
		_cC6It		:= c_item
		dbSelectArea("SZ0")
		dbSetOrder(1)
		If !Inclui.And.dbSeek(xFilial()+c_pedido+c_item)
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Verifica se o pedido ja tem uma op amarrada                       ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If !Empty(c_op)
				MsgBox("Este pedido já tem um OP amarrada ao pedido","Pedido x OP","INFO")
				_nOpca := AxVisual("SZ0",recno(),4, aCampoSN8)
			Else 
			   If !Altera
			      _nOpca := AxVisual("SZ0",recno(),4, aCampoSN8)
			   Else   
				  _nOpca := AxAltera("SZ0",recno(),4, aCampoSN8,aCmpEdit,,,"U_F005TOK()")
			   EndIf	  
			EndIf
		
		
		Elseif 	!Inclui.And.!dbSeek(xFilial()+c_pedido+c_item) // Incluido Jean
			   _nOpca := AxInClui("SZ0",recno(), 3, aCampoSN8,,aCmpEdit,"U_F005TOK()") // Incluido jean

		Else         
		    If Inclui.And.!dbSeek(xFilial()+c_pedido+c_item)          
			   _nOpca := AxInClui("SZ0",recno(), 3, aCampoSN8,,aCmpEdit,"U_F005TOK()")
			ElseIf !Inclui.And.!dbSeek(xFilial()+c_pedido+c_item)          
			   _nOpca := AxInClui("SZ0",recno(), 3, aCampoSN8,,aCmpEdit,"U_F005TOK()")
			Else
				If !Empty(c_op)
					MsgBox("Este pedido já tem um OP amarrada ao pedido","Pedido x OP","INFO")
					_nOpca := AxVisual("SZ0",recno(),4, aCampoSN8)
				Else
				   _nOpca := AxAltera("SZ0",recno(),4, aCampoSN8,aCmpEdit,,,"U_F005TOK()")
				EndIf
			EndIf  			   
		Endif
		_lRet := _nOpca
	ElseIf !Empty(c_prod) .and. substr(c_prod,1,2) = 'BA'
		aCampoSN8 := {'Z0_PEDIDO', 'Z0_BATENTE'}
		_cC6Prod	:= c_prod
		_cC6Ped		:= c_pedido
		_cC6It		:= c_item
		dbSelectArea("SZ0")
		dbSetOrder(1)
		If dbSeek(xFilial()+c_pedido+c_item)
			Batente(.F., Empty(c_op))
		Else
			Batente(.T., Empty(c_op))
		Endif
		c_BATENTE := .T.
	Else
		Alert("O codigo de produtos deve começar com PO = Porta ou BA = Batente.")
	Endif
Else
	Alert("Linha do Item esta deletada")
Endif
dbSelectArea(_cAlias)

Return()




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³F005TOK   ºAutor  ³Mauro Nagata        º Data ³  12/11/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Avalia antes de finalizar a funcao axinclui                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function F005TOK()                 
Local nPrcVen
Local nValor       
Local nI

If M->C5_XORIGEM != "C"       //se segmento do cliente for diferente de Corporativo
    nTamaCols := Len(aCols)  //quantidade de linhas pre existentes no pedido de vendas
    /*substituido este bloco pelo bloco abaixo [Mauro Nagata, Actual Trend, 06/04/2011]
	If nTamaCols < 2.Or.!"BA"$aCols[2,2]   //verificar se existe mais de um item no pedido ou o segundo item do pedido contem a inicial do codigo do produto igual a BA
		MsgBox("Para produção do Batente insira um novo Item Batente","A T E N Ç Ã O","ALERT")
	EndIf    
	//fim bloco [Mauro Nagata, Actual Trend, 06/04/2011]
	*/          
	//inicio do bloco [Mauro Nagata, Actual Trend, 06/04/2011]
	If nTamaCols < 2   //verificar se existe mais de um item no pedido 
		MsgBox("Para produção do Batente insira um novo Item Batente","A T E N Ç Ã O","ALERT")
	EndIf                                           
	If nTamaCols > 1   //verificar se existe mais de um item no pedido 
	    lIpBA := .F.
	    For nI := 2 To nTamaCols
	        If "BA"$aCols[2,2]
	            lIpBa := .T.
	            Exit
	        EndIf    
	    Next
	    If !lIpBa
		   MsgBox("Para produção do Batente insira um novo Item Batente","A T E N Ç Ã O","ALERT")
		EndIf   
	EndIf                                           
    // fim bloco [Mauro Nagata, Actual Trend, 06/04/2011]
	If !Empty(M->Z0_OLHOM).And.Empty(M->Z0_ALTOLHO)
       MsgBox("É necessário preencher o campo Altura do Olho Mágico. Altere esse campo para continuar [Acessorios]","Altura do Olho Mágico","ALERT")
       Return(.F.)
    EndIf       

       
    //inclusao de item no pedido de vendas
	If !Empty(M->Z0_MOLAA)  //mola aerea
	   nPrcVen   := GetAdvFVal("DA1","DA1_PRCVEN",xFilial("DA1")+M->C5_TABELA+M->Z0_MOLAA,1,0)          
	   If Empty(nPrcVen)
	      MsgBox("O preço de tabela está zerado [Acessórios]"+Chr(13)+Chr(10)+Chr(13)+Chr(10)+AllTrim(M->Z0_MOLAA)+"-"+AllTrim(GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+M->Z0_MOLAA,1,"Produto nao encontrado"))+Chr(13)+Chr(10)+Chr(13)+Chr(10)+"Será necessário cadastrar o preço deste produto","Mola Aérea","ALERT")
	      Return(.F.)
	   EndIf
	   If Empty(M->Z0_QTDMOLA)
	      MsgBox("A quantidade está zerada [Acessórios]"+Chr(13)+Chr(10)+"Informar a quantidade na pasta Acessórios","Mola Aerea","ALERT")
	      Return(.F.)
	   EndIf 
	   If Empty(M->Z0_TESACES)
	      MsgBox("O TES não foi informado [Acessórios]"+Chr(13)+Chr(10)+"Informar o TES na pasta Acessórios","Mola Aerea","ALERT")
	      Return(.F.)
	   EndIf
	   nValor    := nPrcVen * M->Z0_QTDMOLA                                                                                                        
	   If (nPosaCols := aScan(aCols,{|x| x[2]=M->Z0_MOLAA})) > 0
          If aCols[nPosaCols][Len(aHeader)+1] //item deletado
              aCols[nPosaCols][Len(aHeader)+1] := .F. //defazer delecao do item
              If SZ0->Z0_MOLAA != M->Z0_MOLAA   //o produto esta sendo trocado por outro produto
                 If (nPosaColsDel := aScan(aCols,{|x| x[2]=SZ0->Z0_MOLAA})) > 0
                    aCols[nPosaColsDel][Len(aHeader)+1] := .T. //defazer delecao do item
                 EndIf
              EndIf
          EndIf    
          aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_PRODUTO"})] := M->Z0_MOLAA
          aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_DESCRI"})]  := GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+M->Z0_MOLAA,1,"Produto nao encontrado")
          aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_UM"})]      := GetAdvFVal("SB1","B1_UM",xFilial("SB1")+M->Z0_MOLAA,1,"  ")
          aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_QTDVEN"})]  := M->Z0_QTDMOLA
	      aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_PRCVEN"})]  := nPrcVen
	      aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_VALOR"})]   := nValor
          aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_LOCAL"})]   := "01"
	      aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_TES"})]     := M->Z0_TESACES
	      aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_CF"})]      := GetAdvFVal("SF4","F4_CF",xFilial("SF4")+M->Z0_TESACES,1,"    ")
	      aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_XFICTEC"})] := "Z0_MOLAA"
       Else   
		   If Empty(SZ0->Z0_MOLAA).Or.(nPosaCols := aScan(aCols,{|x| x[2]=SZ0->Z0_MOLAA})) = 0
			   aInclItem := {}                              
//			   aAdd(aInclItem,{"C6_ITEM",StrZero(Len(aCols)+1,2)})   
               aAdd(aInclItem,{"C6_ITEM", StrZero(Val(aCols[Len(aCols), aScan(aHeader,{|x| x[2]="C6_ITEM"})])+1,2) })   
			   aAdd(aInclItem,{"C6_PRODUTO",M->Z0_MOLAA})   
			   aAdd(aInclItem,{"C6_DESCRI",GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+M->Z0_MOLAA,1,"Produto nao encontrado")})          
			   aAdd(aInclItem,{"C6_UM",GetAdvFVal("SB1","B1_UM",xFilial("SB1")+M->Z0_MOLAA,1,"  ")})          
			   aAdd(aInclItem,{"C6_QTDVEN",M->Z0_QTDMOLA})                                   
			   aAdd(aInclItem,{"C6_PRCVEN",nPrcVen})                                   
			   aAdd(aInclItem,{"C6_VALOR",nValor})                                   
		       aAdd(aInclItem,{"C6_LOCAL","01"})                                   	   
			   aAdd(aInclItem,{"C6_TES",M->Z0_TESACES})
			   aAdd(aInclItem,{"C6_CF",GetAdvFVal("SF4","F4_CF",xFilial("SF4")+M->Z0_TESACES,1,"    ")})
			   aAdd(aInclItem,{"C6_XFICTEC","Z0_MOLAA"})
			   CarrItPed(aInclItem)   
		   ElseIf (nPosaCols := aScan(aCols,{|x| x[2]=SZ0->Z0_MOLAA})) > 0
		           aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_PRODUTO"})] := M->Z0_MOLAA
		           aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_DESCRI"})]  := GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+M->Z0_MOLAA,1,"Produto nao encontrado")
		           aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_UM"})]      := GetAdvFVal("SB1","B1_UM",xFilial("SB1")+M->Z0_MOLAA,1,"  ") 
		           aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_QTDVEN"})]  := M->Z0_QTDMOLA
			       aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_PRCVEN"})]  := nPrcVen
			       aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_VALOR"})]   := nValor
		           aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_LOCAL"})]   := "01"
			       aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_TES"})]     := M->Z0_TESACES
			       aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_CF"})]      := GetAdvFVal("SF4","F4_CF",xFilial("SF4")+M->Z0_TESACES,1,"    ")
			       aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_XFICTEC"})] := "Z0_MOLAA"
	       EndIf   
	   EndIf
	ElseIf !Empty(SZ0->Z0_MOLAA)                                                          	     
	       If (nPosaCols := aScan(aCols,{|x| x[2]=SZ0->Z0_MOLAA})) > 0
	          aCols[nPosaCols][Len(aHeader)+1] := .T.                 
	          RecLock("SZ0",.F.)
	          SZ0_Z0_QTDMOLA := 0
	          
	          SZ0->(MsUnLock())                                                         	     
	       EndIf   
	EndIf         
	If !Empty(M->Z0_OLHOM)       
	   nPrcVen   := GetAdvFVal("DA1","DA1_PRCVEN",xFilial("DA1")+M->C5_TABELA+M->Z0_OLHOM,1,0)          
	   nValor    := nPrcVen * M->Z0_QTDOLHO    
	   If Empty(nPrcVen)
	      MsgBox("O preço de tabela está zerado [Acessórios]"+Chr(13)+Chr(10)+Chr(13)+Chr(10)+AllTrim(M->Z0_OLHOM)+"-"+AllTrim(GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+M->Z0_OLHOM,1,"Produto nao encontrado"))+Chr(13)+Chr(10)+Chr(13)+Chr(10)+"Será necessário cadastrar o preço deste produto","Olho Mágico","ALERT")
	      Return(.F.)
	   EndIf
	   If Empty(M->Z0_QTDOLHO)
	      MsgBox("A quantidade está zerada [Acessórios]"+Chr(13)+Chr(10)+"Informar a quantidade na pasta Acessórios","Olho Mágico","ALERT")
	      Return(.F.)
	   EndIf 
	   If Empty(M->Z0_TESACES)
	      MsgBox("O TES não foi informado [Acessórios]"+Chr(13)+Chr(10)+"Informar o TES na pasta Acessórios","Olho Mágico","ALERT")
	      Return(.F.)
	   EndIf
	   If (nPosaCols := aScan(aCols,{|x| x[2]=M->Z0_OLHOM})) > 0
          If aCols[nPosaCols][Len(aHeader)+1] //item deletado
              aCols[nPosaCols][Len(aHeader)+1] := .F. //defazer delecao do item
              If SZ0->Z0_OLHOM != M->Z0_OLHOM   //o produto esta sendo trocado por outro produto
                 If (nPosaColsDel := aScan(aCols,{|x| x[2]=SZ0->Z0_OLHOM})) > 0
                    aCols[nPosaColsDel][Len(aHeader)+1] := .T. //defazer delecao do item
                 EndIf
              EndIf
          EndIf       
          aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_PRODUTO"})] := M->Z0_OLHOM
          aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_DESCRI"})]  := GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+M->Z0_OLHOM,1,"Produto nao encontrado")
          aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_UM"})]      := GetAdvFVal("SB1","B1_UM",xFilial("SB1")+M->Z0_OLHOM,1,"  ")
          aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_QTDVEN"})]  := M->Z0_QTDOLHO
	      aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_PRCVEN"})]  := nPrcVen
	      aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_VALOR"})]   := nValor
          aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_LOCAL"})]   := "01"
	      aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_TES"})]     := M->Z0_TESACES
	      aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_CF"})]      := GetAdvFVal("SF4","F4_CF",xFilial("SF4")+M->Z0_TESACES,1,"    ")
	      aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_XFICTEC"})] := "Z0_OLHOM"
	                                           
       Else   
		   If Empty(SZ0->Z0_OLHOM).Or.(nPosaCols := aScan(aCols,{|x| x[2]=SZ0->Z0_OLHOM})) = 0
			   aInclItem := {}                              
			   aAdd(aInclItem,{"C6_ITEM",StrZero(Len(aCols)+1,2)})   
			   aAdd(aInclItem,{"C6_PRODUTO",M->Z0_OLHOM})   
			   aAdd(aInclItem,{"C6_DESCRI",GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+M->Z0_OLHOM,1,"Produto nao encontrado")})          
			   aAdd(aInclItem,{"C6_UM",GetAdvFVal("SB1","B1_UM",xFilial("SB1")+M->Z0_OLHOM,1,"  ")})          
			   aAdd(aInclItem,{"C6_QTDVEN",M->Z0_QTDOLHO})                                   
			   aAdd(aInclItem,{"C6_PRCVEN",nPrcVen})                                   
			   aAdd(aInclItem,{"C6_VALOR",nValor})                                   
		       aAdd(aInclItem,{"C6_LOCAL","01"})                                   	   
			   aAdd(aInclItem,{"C6_TES",M->Z0_TESACES})
			   aAdd(aInclItem,{"C6_CF",GetAdvFVal("SF4","F4_CF",xFilial("SF4")+M->Z0_TESACES,1,"    ")})
			   aAdd(aInclItem,{"C6_XFICTEC","Z0_OLHOM"})
			   CarrItPed(aInclItem)   
		   ElseIf (nPosaCols := aScan(aCols,{|x| x[2]=SZ0->Z0_OLHOM})) > 0
		           aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_PRODUTO"})] := M->Z0_OLHOM
		           aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_DESCRI"})]  := GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+M->Z0_OLHOM,1,"Produto nao encontrado")
		           aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_UM"})]      := GetAdvFVal("SB1","B1_UM",xFilial("SB1")+M->Z0_OLHOM,1,"  ") 
		           aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_QTDVEN"})]  := M->Z0_QTDOLHO
			       aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_PRCVEN"})]  := nPrcVen
			       aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_VALOR"})]   := nValor
		           aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_LOCAL"})]   := "01"
			       aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_TES"})]     := M->Z0_TESACES
			       aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_CF"})]      := GetAdvFVal("SF4","F4_CF",xFilial("SF4")+M->Z0_TESACES,1,"    ")
			       aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_XFICTEC"})] := "Z0_OLHOM"
	       EndIf   
	   EndIf    
	ElseIf !Empty(SZ0->Z0_OLHOM)                                                          	     
	       If (nPosaCols := aScan(aCols,{|x| x[2]=SZ0->Z0_OLHOM})) > 0
	          aCols[nPosaCols][Len(aHeader)+1] := .T.                   
	          RecLock("SZ0",.F.)
	          SZ0->Z0_QTDOLHO := 0                                          	     
	          SZ0->Z0_ALTOLHO := 0
	          SZ0->(MsUnLock())  
	          
	          M->Z0_QTDOLHO := 0                                          	     
	          M->Z0_ALTOLHO := 0
	       EndIf   
	EndIf         
	If !Empty(M->Z0_FECHAD)       
	   nPrcVen   := GetAdvFVal("DA1","DA1_PRCVEN",xFilial("DA1")+M->C5_TABELA+M->Z0_FECHAD,1,0)          
	   nValor    := nPrcVen * M->Z0_QTDFECH    
	   If Empty(nPrcVen)
	      MsgBox("O preço de tabela está zerado [Acessórios]"+Chr(13)+Chr(10)+Chr(13)+Chr(10)+AllTrim(M->Z0_FECHAD)+"-"+AllTrim(GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+M->Z0_FECHAD,1,"Produto nao encontrado"))+Chr(13)+Chr(10)+Chr(13)+Chr(10)+"Será necessário cadastrar o preço deste produto","Fechadura Adicional","ALERT")
	      Return(.F.)
	   EndIf
	   If Empty(M->Z0_QTDFECH)
	      MsgBox("A quantidade está zerada [Acessórios]"+Chr(13)+Chr(10)+"Informar a quantidade na pasta Acessórios","Fechadura Adicional","ALERT")
	      Return(.F.)
	   EndIf 
	   If Empty(M->Z0_TESACES)
	      MsgBox("O TES não foi informado [Acessórios]"+Chr(13)+Chr(10)+"Informar o TES na pasta Acessórios","Fechadura Adicional","ALERT")
	      Return(.F.)
	   EndIf
	   If (nPosaCols := aScan(aCols,{|x| x[2]=M->Z0_FECHAD})) > 0
          If aCols[nPosaCols][Len(aHeader)+1] //item deletado
              aCols[nPosaCols][Len(aHeader)+1] := .F. //defazer delecao do item
              If SZ0->Z0_FECHAD != M->Z0_FECHAD   //o produto esta sendo trocado por outro produto
                 If (nPosaColsDel := aScan(aCols,{|x| x[2]=SZ0->Z0_FECHAD})) > 0
                    aCols[nPosaColsDel][Len(aHeader)+1] := .T. //defazer delecao do item
                 EndIf
              EndIf
          EndIf       
              aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_PRODUTO"})]  := M->Z0_FECHAD
	          aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_DESCRI"})]  := GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+M->Z0_FECHAD,1,"Produto nao encontrado")
	          aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_UM"})]  := GetAdvFVal("SB1","B1_UM",xFilial("SB1")+M->Z0_FECHAD,1,"  ")
	          aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_QTDVEN"})]  := M->Z0_QTDFECH
		      aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_PRCVEN"})]  := nPrcVen
		      aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_VALOR"})]  := nValor
	          aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_LOCAL"})]  := "01"
		      aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_TES"})]  := M->Z0_TESACES
		      aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_CF"})] := GetAdvFVal("SF4","F4_CF",xFilial("SF4")+M->Z0_TESACES,1,"    ")
		      aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_XFICTEC"})] := "Z0_FECHAD"
	                                           
       Else   
		   If Empty(SZ0->Z0_FECHAD).Or.(nPosaCols := aScan(aCols,{|x| x[2]=SZ0->Z0_FECHAD})) = 0
			   aInclItem := {}                              
			   aAdd(aInclItem,{"C6_ITEM",StrZero(Len(aCols)+1,2)})   
			   aAdd(aInclItem,{"C6_PRODUTO",M->Z0_FECHAD})   
			   aAdd(aInclItem,{"C6_DESCRI",GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+M->Z0_FECHAD,1,"Produto nao encontrado")})          
			   aAdd(aInclItem,{"C6_UM",GetAdvFVal("SB1","B1_UM",xFilial("SB1")+M->Z0_FECHAD,1,"  ")})          
			   aAdd(aInclItem,{"C6_QTDVEN",M->Z0_QTDFECH})                                   
			   aAdd(aInclItem,{"C6_PRCVEN",nPrcVen})                                   
			   aAdd(aInclItem,{"C6_VALOR",nValor})                                   
		       aAdd(aInclItem,{"C6_LOCAL","01"})                                   	   
			   aAdd(aInclItem,{"C6_TES",M->Z0_TESACES})
			   aAdd(aInclItem,{"C6_CF",GetAdvFVal("SF4","F4_CF",xFilial("SF4")+M->Z0_TESACES,1,"    ")})
			   aAdd(aInclItem,{"C6_XFICTEC","Z0_FECHAD"})
			   CarrItPed(aInclItem)   
		   ElseIf (nPosaCols := aScan(aCols,{|x| x[2]=SZ0->Z0_FECHAD})) > 0
		           aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_PRODUTO"})] := M->Z0_FECHAD
		           aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_DESCRI"})]  := GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+M->Z0_FECHAD,1,"Produto nao encontrado")
		           aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_UM"})]      := GetAdvFVal("SB1","B1_UM",xFilial("SB1")+M->Z0_FECHAD,1,"  ") 
		           aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_QTDVEN"})]  := M->Z0_QTDFECH
			       aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_PRCVEN"})]  := nPrcVen
			       aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_VALOR"})]   := nValor
		           aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_LOCAL"})]   := "01"
			       aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_TES"})]     := M->Z0_TESACES
			       aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_CF"})]      := GetAdvFVal("SF4","F4_CF",xFilial("SF4")+M->Z0_TESACES,1,"    ")
			       aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_XFICTEC"})] := "Z0_FECHAD"
	       EndIf   
	   EndIf    
	ElseIf !Empty(SZ0->Z0_FECHAD)                                                          	     
	       If (nPosaCols := aScan(aCols,{|x| x[2]=SZ0->Z0_FECHAD})) > 0
	          aCols[nPosaCols][Len(aHeader)+1] := .T.                    
	          RecLock("SZ0",.F.)
	          SZ0->Z0_QTDFECH := 0
	          SZ0->Z0_ALTFECH := 0
	          SZ0->(MsUnLock())   
	          
	          M->Z0_QTDFECH := 0  
	          M->Z0_ALTFECH := 0                                    	     
	       EndIf   
	EndIf
	If !Empty(M->Z0_CILACES)       
	   nPrcVen   := GetAdvFVal("DA1","DA1_PRCVEN",xFilial("DA1")+M->C5_TABELA+M->Z0_CILACES,1,0)          
	   nValor    := nPrcVen * M->Z0_QTDCIL1    
	   If Empty(nPrcVen)
	      MsgBox("O preço de tabela está zerado [Acessórios]"+Chr(13)+Chr(10)+Chr(13)+Chr(10)+AllTrim(M->Z0_CILACES)+"-"+AllTrim(GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+M->Z0_CILACES,1,"Produto nao encontrado"))+Chr(13)+Chr(10)+Chr(13)+Chr(10)+"Será necessário cadastrar o preço deste produto","Cilindro","ALERT")
	      Return(.F.)
	   EndIf
	   If Empty(M->Z0_QTDCIL1)
	      MsgBox("A quantidade está zerada [Acessórios]"+Chr(13)+Chr(10)+"Informar a quantidade na pasta Acessórios","Cilindro","ALERT")
	      Return(.F.)
	   EndIf 
	   If Empty(M->Z0_TESACES)
	      MsgBox("O TES não foi informado [Acessórios]"+Chr(13)+Chr(10)+"Informar o TES na pasta Acessórios","Cilindro","ALERT")
	      Return(.F.)
	   EndIf
	   If (nPosaCols := aScan(aCols,{|x| x[2]=M->Z0_CILACES})) > 0
          If aCols[nPosaCols][Len(aHeader)+1] //item deletado
              aCols[nPosaCols][Len(aHeader)+1] := .F. //defazer delecao do item
              If SZ0->Z0_CILACES != M->Z0_CILACES   //o produto esta sendo trocado por outro produto
                 If (nPosaColsDel := aScan(aCols,{|x| x[2]=SZ0->Z0_CILACES})) > 0
                    aCols[nPosaColsDel][Len(aHeader)+1] := .T. //defazer delecao do item
                 EndIf
              EndIf
          EndIf       
              aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_PRODUTO"})]  := M->Z0_CILACES
	          aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_DESCRI"})]  := GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+M->Z0_CILACES,1,"Produto nao encontrado")
	          aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_UM"})]  := GetAdvFVal("SB1","B1_UM",xFilial("SB1")+M->Z0_CILACES,1,"  ")
	          aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_QTDVEN"})]  := M->Z0_QTDCIL1
		      aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_PRCVEN"})]  := nPrcVen
		      aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_VALOR"})]  := nValor
	          aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_LOCAL"})]  := "01"
		      aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_TES"})]  := M->Z0_TESACES
		      aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_CF"})] := GetAdvFVal("SF4","F4_CF",xFilial("SF4")+M->Z0_TESACES,1,"    ")
		      aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_XFICTEC"})] := "Z0_CILACES"
	                                         
       Else   
		   If Empty(SZ0->Z0_OLHOM).Or.(nPosaCols := aScan(aCols,{|x| x[2]=SZ0->Z0_CILACES})) = 0
			   aInclItem := {}                              
			   aAdd(aInclItem,{"C6_ITEM",StrZero(Len(aCols)+1,2)})   
			   aAdd(aInclItem,{"C6_PRODUTO",M->Z0_CILACES})   
			   aAdd(aInclItem,{"C6_DESCRI",GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+M->Z0_CILACES,1,"Produto nao encontrado")})          
			   aAdd(aInclItem,{"C6_UM",GetAdvFVal("SB1","B1_UM",xFilial("SB1")+M->Z0_CILACES,1,"  ")})          
			   aAdd(aInclItem,{"C6_QTDVEN",M->Z0_QTDCIL1})                                   
			   aAdd(aInclItem,{"C6_PRCVEN",nPrcVen})                                   
			   aAdd(aInclItem,{"C6_VALOR",nValor})                                   
		       aAdd(aInclItem,{"C6_LOCAL","01"})                                   	   
			   aAdd(aInclItem,{"C6_TES",M->Z0_TESACES})
			   aAdd(aInclItem,{"C6_CF",GetAdvFVal("SF4","F4_CF",xFilial("SF4")+M->Z0_TESACES,1,"    ")})
			   aAdd(aInclItem,{"C6_XFICTEC","Z0_CILACES"})
			   CarrItPed(aInclItem)   
		   ElseIf (nPosaCols := aScan(aCols,{|x| x[2]=SZ0->Z0_CILACES})) > 0
		           aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_PRODUTO"})] := M->Z0_CILACES
		           aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_DESCRI"})]  := GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+M->Z0_CILACES,1,"Produto nao encontrado")
		           aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_UM"})]      := GetAdvFVal("SB1","B1_UM",xFilial("SB1")+M->Z0_CILACES,1,"  ") 
		           aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_QTDVEN"})]  := M->Z0_QTDCIL1
			       aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_PRCVEN"})]  := nPrcVen
			       aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_VALOR"})]   := nValor
		           aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_LOCAL"})]   := "01"
			       aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_TES"})]     := M->Z0_TESACES
			       aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_CF"})]      := GetAdvFVal("SF4","F4_CF",xFilial("SF4")+M->Z0_TESACES,1,"    ")
			       aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_XFICTEC"})] := "Z0_CILACES"
	       EndIf   
	   EndIf    
	ElseIf !Empty(SZ0->Z0_CILACES)                                                          	     
	       If (nPosaCols := aScan(aCols,{|x| x[2]=SZ0->Z0_CILACES})) > 0
	          aCols[nPosaCols][Len(aHeader)+1] := .T.                     
	          RecLock("SZ0",.F.)
	          SZ0->Z0_QTDCIL1 := 0
	          SZ0->(MsUnLock())   
	          
	          M->Z0_QTDCIL1 := 0                                     	     
	       EndIf   
	EndIf         
	If !Empty(M->Z0_ROSACES)       
	   nPrcVen   := GetAdvFVal("DA1","DA1_PRCVEN",xFilial("DA1")+M->C5_TABELA+M->Z0_ROSACES,1,0)          
	   nValor    := nPrcVen * M->Z0_QTDROSE    
	   If Empty(nPrcVen)
	      MsgBox("O preço de tabela está zerado [Acessórios]"+Chr(13)+Chr(10)+Chr(13)+Chr(10)+AllTrim(M->Z0_ROSACES)+"-"+AllTrim(GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+M->Z0_ROSACES,1,"Produto nao encontrado"))+Chr(13)+Chr(10)+Chr(13)+Chr(10)+"Será necessário cadastrar o preço deste produto","Roseta","ALERT")
	      Return(.F.)
	   EndIf
	   If Empty(M->Z0_QTDOLHO)
	      MsgBox("A quantidade está zerada [Acessórios]"+Chr(13)+Chr(10)+"Informar a quantidade na pasta Acessórios","Roseta","ALERT")
	      Return(.F.)
	   EndIf 
	   If Empty(M->Z0_TESACES)
	      MsgBox("O TES não foi informado [Acessórios]"+Chr(13)+Chr(10)+"Informar o TES na pasta Acessórios","Roseta","ALERT")
	      Return(.F.)
	   EndIf
	   If (nPosaCols := aScan(aCols,{|x| x[2]=M->Z0_ROSACES})) > 0
          If aCols[nPosaCols][Len(aHeader)+1] //item deletado
              aCols[nPosaCols][Len(aHeader)+1] := .F. //defazer delecao do item
              If SZ0->Z0_ROSACES != M->Z0_ROSACES   //o produto esta sendo trocado por outro produto
                 If (nPosaColsDel := aScan(aCols,{|x| x[2]=SZ0->Z0_ROSACES})) > 0
                    aCols[nPosaColsDel][Len(aHeader)+1] := .T. //defazer delecao do item
                 EndIf
              EndIf
          EndIf       
              aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_PRODUTO"})]  := M->Z0_ROSACES
	          aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_DESCRI"})]  := GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+M->Z0_ROSACES,1,"Produto nao encontrado")
	          aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_UM"})]  := GetAdvFVal("SB1","B1_UM",xFilial("SB1")+M->Z0_ROSACES,1,"  ")
	          aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_QTDVEN"})]  := M->Z0_QTDROSE
		      aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_PRCVEN"})]  := nPrcVen
		      aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_VALOR"})]  := nValor
	          aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_LOCAL"})]  := "01"
		      aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_TES"})]  := M->Z0_TESACES
		      aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_CF"})] := GetAdvFVal("SF4","F4_CF",xFilial("SF4")+M->Z0_TESACES,1,"    ")
		      aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_XFICTEC"})] := "Z0_ROSACES"
	                                           
       Else   
		   If Empty(SZ0->Z0_ROSACES).Or.(nPosaCols := aScan(aCols,{|x| x[2]=SZ0->Z0_ROSACES})) = 0
			   aInclItem := {}                              
			   aAdd(aInclItem,{"C6_ITEM",StrZero(Len(aCols)+1,2)})   
			   aAdd(aInclItem,{"C6_PRODUTO",M->Z0_ROSACES})   
			   aAdd(aInclItem,{"C6_DESCRI",GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+M->Z0_ROSACES,1,"Produto nao encontrado")})          
			   aAdd(aInclItem,{"C6_UM",GetAdvFVal("SB1","B1_UM",xFilial("SB1")+M->Z0_ROSACES,1,"  ")})          
			   aAdd(aInclItem,{"C6_QTDVEN",M->Z0_QTDROSE})                                   
			   aAdd(aInclItem,{"C6_PRCVEN",nPrcVen})                                   
			   aAdd(aInclItem,{"C6_VALOR",nValor})                                   
		       aAdd(aInclItem,{"C6_LOCAL","01"})                                   	   
			   aAdd(aInclItem,{"C6_TES",M->Z0_TESACES})
			   aAdd(aInclItem,{"C6_CF",GetAdvFVal("SF4","F4_CF",xFilial("SF4")+M->Z0_TESACES,1,"    ")})
			   aAdd(aInclItem,{"C6_XFICTEC","Z0_ROSACES"})
			   CarrItPed(aInclItem)   
		   ElseIf (nPosaCols := aScan(aCols,{|x| x[2]=SZ0->Z0_ROSACES})) > 0
		           aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_PRODUTO"})] := M->Z0_ROSACES
		           aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_DESCRI"})]  := GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+M->Z0_ROSACES,1,"Produto nao encontrado")
		           aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_UM"})]      := GetAdvFVal("SB1","B1_UM",xFilial("SB1")+M->Z0_ROSACES,1,"  ") 
		           aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_QTDVEN"})]  := M->Z0_QTDROSE
			       aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_PRCVEN"})]  := nPrcVen
			       aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_VALOR"})]   := nValor
		           aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_LOCAL"})]   := "01"
			       aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_TES"})]     := M->Z0_TESACES
			       aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_CF"})]      := GetAdvFVal("SF4","F4_CF",xFilial("SF4")+M->Z0_TESACES,1,"    ")
			       aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_XFICTEC"})] := "Z0_ROSACES"
	       EndIf   
	   EndIf    
	ElseIf !Empty(SZ0->Z0_ROSACES)                                                          	     
	       If (nPosaCols := aScan(aCols,{|x| x[2]=SZ0->Z0_ROSACES})) > 0
	          aCols[nPosaCols][Len(aHeader)+1] := .T.                     
	          RecLock("SZ0",.F.)
	          SZ0->Z0_QTDROSE := 0
	          SZ0->(MsUnLock())   
	          
	          M->Z0_QTDROSE := 0                                     	     
	       EndIf   
	EndIf         
	If !Empty(M->Z0_PRD1FER)       
	   nPrcVen   := GetAdvFVal("DA1","DA1_PRCVEN",xFilial("DA1")+M->C5_TABELA+M->Z0_PRD1FER,1,0)          
	   nValor    := nPrcVen * M->Z0_QTD1FER
	   If Empty(nPrcVen)
	      MsgBox("O preço de tabela está zerado [Acessórios]"+Chr(13)+Chr(10)+Chr(13)+Chr(10)+AllTrim(M->Z0_PRD1FER)+"-"+AllTrim(GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+M->Z0_PRD1FER,1,"Produto nao encontrado"))+Chr(13)+Chr(10)+Chr(13)+Chr(10)+"Será necessário cadastrar o preço deste produto","Produto 1","ALERT")
	      Return(.F.)
	   EndIf
	   If Empty(M->Z0_QTD1FER)
	      MsgBox("A quantidade está zerada [Ferragem]"+Chr(13)+Chr(10)+"Informar a quantidade na pasta Ferragem","Produto 1","ALERT")
	      Return(.F.)
	   EndIf 
	   If Empty(M->Z0_TESFER)
	      MsgBox("O TES não foi informado [Ferragem]"+Chr(13)+Chr(10)+"Informar o TES na pasta Ferragem","Produto 1","ALERT")
	      Return(.F.)
	   EndIf
	   If (nPosaCols := aScan(aCols,{|x| x[2]=M->Z0_PRD1FER})) > 0
          If aCols[nPosaCols][Len(aHeader)+1] //item deletado
              aCols[nPosaCols][Len(aHeader)+1] := .F. //defazer delecao do item
              If SZ0->Z0_PRD1FER != M->Z0_PRD1FER   //o produto esta sendo trocado por outro produto
                 If (nPosaColsDel := aScan(aCols,{|x| x[2]=SZ0->Z0_PRD1FER})) > 0
                    aCols[nPosaColsDel][Len(aHeader)+1] := .T. //defazer delecao do item
                 EndIf
              EndIf
          EndIf       
              aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_PRODUTO"})]  := M->Z0_PRD1FER
	          aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_DESCRI"})]  := GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+M->Z0_PRD1FER,1,"Produto nao encontrado")
	          aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_UM"})]  := GetAdvFVal("SB1","B1_UM",xFilial("SB1")+M->Z0_PRD1FER,1,"  ")
	          aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_QTDVEN"})]  := M->Z0_QTD1FER
		      aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_PRCVEN"})]  := nPrcVen
		      aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_VALOR"})]  := nValor
	          aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_LOCAL"})]  := "01"
		      aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_TES"})]  := M->Z0_TESFER
		      aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_CF"})] := GetAdvFVal("SF4","F4_CF",xFilial("SF4")+M->Z0_TESFER,1,"    ")
		      aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_XFICTEC"})] := "Z0_PRD1FER"
	                                           
       Else   
		   If Empty(SZ0->Z0_PRD1FER).Or.(nPosaCols := aScan(aCols,{|x| x[2]=SZ0->Z0_PRD1FER})) = 0
			   aInclItem := {}                              
			   aAdd(aInclItem,{"C6_ITEM",StrZero(Len(aCols)+1,2)})   
			   aAdd(aInclItem,{"C6_PRODUTO",M->Z0_PRD1FER})   
			   aAdd(aInclItem,{"C6_DESCRI",GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+M->Z0_PRD1FER,1,"Produto nao encontrado")})          
			   aAdd(aInclItem,{"C6_UM",GetAdvFVal("SB1","B1_UM",xFilial("SB1")+M->Z0_PRD1FER,1,"  ")})          
			   aAdd(aInclItem,{"C6_QTDVEN",M->Z0_QTD1FER})                                   
			   aAdd(aInclItem,{"C6_PRCVEN",nPrcVen})                                   
			   aAdd(aInclItem,{"C6_VALOR",nValor})                                   
		       aAdd(aInclItem,{"C6_LOCAL","01"})                                   	   
			   aAdd(aInclItem,{"C6_TES",M->Z0_TESFER})
			   aAdd(aInclItem,{"C6_CF",GetAdvFVal("SF4","F4_CF",xFilial("SF4")+M->Z0_TESFER,1,"    ")})
			   aAdd(aInclItem,{"C6_XFICTEC","Z0_PRD1FER"})
			   CarrItPed(aInclItem)   
		   ElseIf (nPosaCols := aScan(aCols,{|x| x[2]=SZ0->Z0_PRD1FER})) > 0
		           aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_PRODUTO"})] := M->Z0_PRD1FER
		           aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_DESCRI"})]  := GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+M->Z0_PRD1FER,1,"Produto nao encontrado")
		           aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_UM"})]      := GetAdvFVal("SB1","B1_UM",xFilial("SB1")+M->Z0_PRD1FER,1,"  ") 
		           aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_QTDVEN"})]  := M->Z0_QTD1FER
			       aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_PRCVEN"})]  := nPrcVen
			       aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_VALOR"})]   := nValor
		           aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_LOCAL"})]   := "01"
			       aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_TES"})]     := M->Z0_TESFER
			       aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_CF"})]      := GetAdvFVal("SF4","F4_CF",xFilial("SF4")+M->Z0_TESFER,1,"    ")
			       aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_XFICTEC"})] := "Z0_PRD1FER"
	       EndIf   
	   EndIf    
	ElseIf !Empty(SZ0->Z0_PRD1FER)                                                          	     
	       If (nPosaCols := aScan(aCols,{|x| x[2]=SZ0->Z0_PRD1FER})) > 0
	          aCols[nPosaCols][Len(aHeader)+1] := .T.                     
	          Reclock("SZ0",.F.)
	          SZ0->Z0_QTD1FER := 0
	          SZ0->(MsUnLock())        
	          
	          M->Z0_QTD1FER := 0                                     	     
	       EndIf   
	EndIf         
	If !Empty(M->Z0_PRD2FER)       
	   nPrcVen   := GetAdvFVal("DA1","DA1_PRCVEN",xFilial("DA1")+M->C5_TABELA+M->Z0_PRD2FER,1,0)          
	   nValor    := nPrcVen * M->Z0_QTD2FER
	   If Empty(nPrcVen)
	      MsgBox("O preço de tabela está zerado [Ferragem]"+Chr(13)+Chr(10)+Chr(13)+Chr(10)+AllTrim(M->Z0_PRD2FER)+"-"+AllTrim(GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+M->Z0_PRD2FER,1,"Produto nao encontrado"))+Chr(13)+Chr(10)+Chr(13)+Chr(10)+"Será necessário cadastrar o preço deste produto","Produto 2","ALERT")
	      Return(.F.)
	   EndIf
	   If Empty(M->Z0_QTD2FER)
	      MsgBox("A quantidade está zerada [Ferragem]"+Chr(13)+Chr(10)+"Informar a quantidade na pasta Ferragem","Produto 2","ALERT")
	      Return(.F.)
	   EndIf 
	   If Empty(M->Z0_TESFER)
	      MsgBox("O TES não foi informado [Ferragem]"+Chr(13)+Chr(10)+"Informar o TES na pasta Ferragem","Produto 2","ALERT")
	      Return(.F.)
	   EndIf
	   If (nPosaCols := aScan(aCols,{|x| x[2]=M->Z0_PRD2FER})) > 0
          If aCols[nPosaCols][Len(aHeader)+1] //item deletado
              aCols[nPosaCols][Len(aHeader)+1] := .F. //defazer delecao do item
              If SZ0->Z0_PRD2FER != M->Z0_PRD2FER   //o produto esta sendo trocado por outro produto
                 If (nPosaColsDel := aScan(aCols,{|x| x[2]=SZ0->Z0_PRD2FER})) > 0
                    aCols[nPosaColsDel][Len(aHeader)+1] := .T. //defazer delecao do item
                 EndIf
              EndIf
          EndIf      
              aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_PRODUTO"})]  := M->Z0_PRD2FER
	          aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_DESCRI"})]  := GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+M->Z0_PRD2FER,1,"Produto nao encontrado")
	          aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_UM"})]  := GetAdvFVal("SB1","B1_UM",xFilial("SB1")+M->Z0_PRD2FER,1,"  ")
	          aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_QTDVEN"})]  := M->Z0_QTD2FER
		      aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_PRCVEN"})]  := nPrcVen
		      aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_VALOR"})]  := nValor
	          aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_LOCAL"})]  := "01"
		      aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_TES"})]  := M->Z0_TESFER
		      aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_CF"})] := GetAdvFVal("SF4","F4_CF",xFilial("SF4")+M->Z0_TESFER,1,"    ")
		      aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_XFICTEC"})] := "Z0_PRD2FER"
	                                           
       Else   
		   If Empty(SZ0->Z0_PRD2FER).Or.(nPosaCols := aScan(aCols,{|x| x[2]=SZ0->Z0_PRD2FER})) = 0
			   aInclItem := {}                              
			   aAdd(aInclItem,{"C6_ITEM",StrZero(Len(aCols)+1,2)})   
			   aAdd(aInclItem,{"C6_PRODUTO",M->Z0_PRD2FER})   
			   aAdd(aInclItem,{"C6_DESCRI",GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+M->Z0_PRD2FER,1,"Produto nao encontrado")})          
			   aAdd(aInclItem,{"C6_UM",GetAdvFVal("SB1","B1_UM",xFilial("SB1")+M->Z0_PRD2FER,1,"  ")})          
			   aAdd(aInclItem,{"C6_QTDVEN",M->Z0_QTD2FER})                                   
			   aAdd(aInclItem,{"C6_PRCVEN",nPrcVen})                                   
			   aAdd(aInclItem,{"C6_VALOR",nValor})                                   
		       aAdd(aInclItem,{"C6_LOCAL","01"})                                   	   
			   aAdd(aInclItem,{"C6_TES",M->Z0_TESFER})
			   aAdd(aInclItem,{"C6_CF",GetAdvFVal("SF4","F4_CF",xFilial("SF4")+M->Z0_TESFER,1,"    ")})
			   aAdd(aInclItem,{"C6_XFICTEC","Z0_PRD2FER"})
			   CarrItPed(aInclItem)   
		   ElseIf (nPosaCols := aScan(aCols,{|x| x[2]=SZ0->Z0_PRD2FER})) > 0
		           aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_PRODUTO"})] := M->Z0_PRD2FER
		           aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_DESCRI"})]  := GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+M->Z0_PRD2FER,1,"Produto nao encontrado")
		           aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_UM"})]      := GetAdvFVal("SB1","B1_UM",xFilial("SB1")+M->Z0_PRD2FER,1,"  ") 
		           aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_QTDVEN"})]  := M->Z0_QTD2FER
			       aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_PRCVEN"})]  := nPrcVen
			       aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_VALOR"})]   := nValor
		           aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_LOCAL"})]   := "01"
			       aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_TES"})]     := M->Z0_TESFER
			       aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_CF"})]      := GetAdvFVal("SF4","F4_CF",xFilial("SF4")+M->Z0_TESFER,1,"    ")
			       aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_XFICTEC"})] := "Z0_PRD2FER"
	       EndIf   
	   EndIf    
	ElseIf !Empty(SZ0->Z0_PRD2FER)                                                          	     
	       If (nPosaCols := aScan(aCols,{|x| x[2]=SZ0->Z0_PRD2FER})) > 0
	          aCols[nPosaCols][Len(aHeader)+1] := .T.                  
	          RecLock("SZ0",.F.)
	          SZ0->Z0_QTD2FER := 0
	          SZ0->(MsUnLock()) 
	          M->Z0_QTD2FER := 0                                          	     
	       EndIf   
	EndIf
	If !Empty(M->Z0_PRD3FER)       
	   nPrcVen   := GetAdvFVal("DA1","DA1_PRCVEN",xFilial("DA1")+M->C5_TABELA+M->Z0_PRD3FER,1,0)          
	   nValor    := nPrcVen * M->Z0_QTD3FER
	   If Empty(nPrcVen)
	      MsgBox("O preço de tabela está zerado [Ferragems]"+Chr(13)+Chr(10)+Chr(13)+Chr(10)+AllTrim(M->Z0_PRD3FER)+"-"+AllTrim(GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+M->Z0_PRD3FER,1,"Produto nao encontrado"))+Chr(13)+Chr(10)+Chr(13)+Chr(10)+"Será necessário cadastrar o preço deste produto","Produto 3","ALERT")
	      Return(.F.)
	   EndIf
	   If Empty(M->Z0_QTD3FER)
	      MsgBox("A quantidade está zerada [Ferragem]"+Chr(13)+Chr(10)+"Informar a quantidade na pasta Ferragem","Produto 3","ALERT")
	      Return(.F.)
	   EndIf 
	   If Empty(M->Z0_TESFER)
	      MsgBox("O TES não foi informado [Ferragem]"+Chr(13)+Chr(10)+"Informar o TES na pasta Ferragem","Produto 3","ALERT")
	      Return(.F.)
	   EndIf
	   If (nPosaCols := aScan(aCols,{|x| x[2]=M->Z0_PRD3FER})) > 0
          If aCols[nPosaCols][Len(aHeader)+1] //item deletado
              aCols[nPosaCols][Len(aHeader)+1] := .F. //defazer delecao do item
              If SZ0->Z0_PRD3FER != M->Z0_PRD3FER   //o produto esta sendo trocado por outro produto
                 If (nPosaColsDel := aScan(aCols,{|x| x[2]=SZ0->Z0_PRD3FER})) > 0
                    aCols[nPosaColsDel][Len(aHeader)+1] := .T. //defazer delecao do item
                 EndIf
              EndIf
          EndIf      
              aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_PRODUTO"})]  := M->Z0_PRD3FER
	          aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_DESCRI"})]  := GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+M->Z0_PRD3FER,1,"Produto nao encontrado")
	          aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_UM"})]  := GetAdvFVal("SB1","B1_UM",xFilial("SB1")+M->Z0_PRD3FER,1,"  ")
	          aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_QTDVEN"})]  := M->Z0_QTD3FER
		      aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_PRCVEN"})]  := nPrcVen
		      aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_VALOR"})]  := nValor
	          aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_LOCAL"})]  := "01"
		      aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_TES"})]  := M->Z0_TESFER
		      aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_CF"})] := GetAdvFVal("SF4","F4_CF",xFilial("SF4")+M->Z0_TESFER,1,"    ")
		      aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_XFICTEC"})] := "Z0_PRD3FER"
	                                          
       Else   
		   If Empty(SZ0->Z0_PRD3FER).Or.(nPosaCols := aScan(aCols,{|x| x[2]=SZ0->Z0_PRD3FER})) = 0
			   aInclItem := {}                              
			   aAdd(aInclItem,{"C6_ITEM",StrZero(Len(aCols)+1,2)})   
			   aAdd(aInclItem,{"C6_PRODUTO",M->Z0_PRD3FER})   
			   aAdd(aInclItem,{"C6_DESCRI",GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+M->Z0_PRD3FER,1,"Produto nao encontrado")})          
			   aAdd(aInclItem,{"C6_UM",GetAdvFVal("SB1","B1_UM",xFilial("SB1")+M->Z0_PRD3FER,1,"  ")})          
			   aAdd(aInclItem,{"C6_QTDVEN",M->Z0_QTD3FER})                                   
			   aAdd(aInclItem,{"C6_PRCVEN",nPrcVen})                                   
			   aAdd(aInclItem,{"C6_VALOR",nValor})                                   
		       aAdd(aInclItem,{"C6_LOCAL","01"})                                   	   
			   aAdd(aInclItem,{"C6_TES",M->Z0_TESFER})
			   aAdd(aInclItem,{"C6_CF",GetAdvFVal("SF4","F4_CF",xFilial("SF4")+M->Z0_TESFER,1,"    ")})
			   aAdd(aInclItem,{"C6_XFICTEC","Z0_PRD3FER"})
			   CarrItPed(aInclItem)   
		   ElseIf (nPosaCols := aScan(aCols,{|x| x[2]=SZ0->Z0_PRD3FER})) > 0
		           aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_PRODUTO"})] := M->Z0_PRD3FER
		           aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_DESCRI"})]  := GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+M->Z0_PRD3FER,1,"Produto nao encontrado")
		           aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_UM"})]      := GetAdvFVal("SB1","B1_UM",xFilial("SB1")+M->Z0_PRD3FER,1,"  ") 
		           aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_QTDVEN"})]  := M->Z0_QTD3FER
			       aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_PRCVEN"})]  := nPrcVen
			       aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_VALOR"})]   := nValor
		           aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_LOCAL"})]   := "01"
			       aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_TES"})]     := M->Z0_TESFER
			       aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_CF"})]      := GetAdvFVal("SF4","F4_CF",xFilial("SF4")+M->Z0_TESFER,1,"    ")
			       aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_XFICTEC"})] := "Z0_PRD3FER"
	       EndIf   
	   EndIf    
	ElseIf !Empty(SZ0->Z0_PRD3FER)                                                          	     
	       If (nPosaCols := aScan(aCols,{|x| x[2]=SZ0->Z0_PRD3FER})) > 0
	          aCols[nPosaCols][Len(aHeader)+1] := .T.                                   
	          RecLock("SZ0",.F.)
	          SZ0->Z0_QTD3FER := 0
	          SZ0->(MsUnLock())                          	     
	          M->Z0_QTD3FER := 0
	       EndIf   
	EndIf
	If !Empty(M->Z0_PRD4FER)       
	   nPrcVen   := GetAdvFVal("DA1","DA1_PRCVEN",xFilial("DA1")+M->C5_TABELA+M->Z0_PRD4FER,1,0)          
	   nValor    := nPrcVen * M->Z0_QTD4FER
	   If Empty(nPrcVen)
	      MsgBox("O preço de tabela está zerado [Acessórios]"+Chr(13)+Chr(10)+Chr(13)+Chr(10)+AllTrim(M->Z0_PRD4FER)+"-"+AllTrim(GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+M->Z0_PRD4FER,1,"Produto nao encontrado"))+Chr(13)+Chr(10)+Chr(13)+Chr(10)+"Será necessário cadastrar o preço deste produto","Produto 4","ALERT")
	      Return(.F.)
	   EndIf
	   If Empty(M->Z0_QTD4FER)
	      MsgBox("A quantidade está zerada [Ferragem]"+Chr(13)+Chr(10)+"Informar a quantidade na pasta Ferragem","Produto 4","ALERT")
	      Return(.F.)
	   EndIf 
	   If Empty(M->Z0_TESFER)
	      MsgBox("O TES não foi informado [Ferragem]"+Chr(13)+Chr(10)+"Informar o TES na pasta Ferragem","Produto 4","ALERT")
	      Return(.F.)
	   EndIf
	   If (nPosaCols := aScan(aCols,{|x| x[2]=M->Z0_PRD4FER})) > 0
          If aCols[nPosaCols][Len(aHeader)+1] //item deletado
              aCols[nPosaCols][Len(aHeader)+1] := .F. //defazer delecao do item
              If SZ0->Z0_PRD4FER != M->Z0_PRD4FER   //o produto esta sendo trocado por outro produto
                 If (nPosaColsDel := aScan(aCols,{|x| x[2]=SZ0->Z0_PRD4FER})) > 0
                    aCols[nPosaColsDel][Len(aHeader)+1] := .T. //defazer delecao do item
                 EndIf
              EndIf
          EndIf   
              aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_PRODUTO"})]  := M->Z0_PRD4FER
	          aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_DESCRI"})]  := GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+M->Z0_PRD4FER,1,"Produto nao encontrado")
	          aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_UM"})]  := GetAdvFVal("SB1","B1_UM",xFilial("SB1")+M->Z0_PRD4FER,1,"  ")
	          aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_QTDVEN"})]  := M->Z0_QTD4FER
		      aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_PRCVEN"})]  := nPrcVen
		      aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_VALOR"})]  := nValor
	          aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_LOCAL"})]  := "01"
		      aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_TES"})]  := M->Z0_TESFER
		      aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_CF"})] := GetAdvFVal("SF4","F4_CF",xFilial("SF4")+M->Z0_TESFER,1,"    ")
		      aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_XFICTEC"})] := "Z0_PRD4FER"
	                                           
       Else   
		   If Empty(SZ0->Z0_PRD4FER).Or.(nPosaCols := aScan(aCols,{|x| x[2]=SZ0->Z0_PRD4FER})) = 0
			   aInclItem := {}                              
			   aAdd(aInclItem,{"C6_ITEM",StrZero(Len(aCols)+1,2)})   
			   aAdd(aInclItem,{"C6_PRODUTO",M->Z0_PRD4FER})   
			   aAdd(aInclItem,{"C6_DESCRI",GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+M->Z0_PRD4FER,1,"Produto nao encontrado")})          
			   aAdd(aInclItem,{"C6_UM",GetAdvFVal("SB1","B1_UM",xFilial("SB1")+M->Z0_PRD4FER,1,"  ")})          
			   aAdd(aInclItem,{"C6_QTDVEN",M->Z0_QTD4FER})                                   
			   aAdd(aInclItem,{"C6_PRCVEN",nPrcVen})                                   
			   aAdd(aInclItem,{"C6_VALOR",nValor})                                   
		       aAdd(aInclItem,{"C6_LOCAL","01"})                                   	   
			   aAdd(aInclItem,{"C6_TES",M->Z0_TESFER})
			   aAdd(aInclItem,{"C6_CF",GetAdvFVal("SF4","F4_CF",xFilial("SF4")+M->Z0_TESFER,1,"    ")})
			   aAdd(aInclItem,{"C6_XFICTEC","Z0_PRD4FER"})
			   CarrItPed(aInclItem)   
		   ElseIf (nPosaCols := aScan(aCols,{|x| x[2]=SZ0->Z0_PRD4FER})) > 0
		           aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_PRODUTO"})] := M->Z0_PRD4FER
		           aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_DESCRI"})]  := GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+M->Z0_PRD4FER,1,"Produto nao encontrado")
		           aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_UM"})]      := GetAdvFVal("SB1","B1_UM",xFilial("SB1")+M->Z0_PRD4FER,1,"  ") 
		           aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_QTDVEN"})]  := M->Z0_QTD4FER
			       aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_PRCVEN"})]  := nPrcVen
			       aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_VALOR"})]   := nValor
		           aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_LOCAL"})]   := "01"
			       aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_TES"})]     := M->Z0_TESFER
			       aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_CF"})]      := GetAdvFVal("SF4","F4_CF",xFilial("SF4")+M->Z0_TESFER,1,"    ")
			       aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_XFICTEC"})] := "Z0_PRD4FER"
	       EndIf   
	   EndIf    
	ElseIf !Empty(SZ0->Z0_PRD4FER)                                                          	     
	       If (nPosaCols := aScan(aCols,{|x| x[2]=SZ0->Z0_PRD4FER})) > 0
	          aCols[nPosaCols][Len(aHeader)+1] := .T.                                                             	     
	          RecLock("SZ0",.F.)
	          SZ0->Z0_QTD4FER := 0
	          SZ0->(MsUnLock())
	          M->Z0_QTD4FER := 0
	       EndIf   
	EndIf
	If !Empty(M->Z0_FECHELE)       
	   nPrcVen   := GetAdvFVal("DA1","DA1_PRCVEN",xFilial("DA1")+M->C5_TABELA+M->Z0_FECHELE,1,0)          
	   nValor    := nPrcVen * M->Z0_QTDFECB    
	   If Empty(nPrcVen)
	      MsgBox("O preço de tabela está zerado [Batente]"+Chr(13)+Chr(10)+Chr(13)+Chr(10)+AllTrim(M->Z0_FECHELE)+"-"+AllTrim(GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+M->Z0_FECHELE,1,"Produto nao encontrado"))+Chr(13)+Chr(10)+Chr(13)+Chr(10)+"Será necessário cadastrar o preço deste produto","Fechadura Elétrica","ALERT")
	      Return(.F.)
	   EndIf
	   If Empty(M->Z0_QTDFECB)
	      MsgBox("A quantidade está zerada [Batente]"+Chr(13)+Chr(10)+"Informar a quantidade na pasta Batente","Fechadura Elétrica","ALERT")
	      Return(.F.)
	   EndIf 
	   If Empty(M->Z0_TESBAT)
	      MsgBox("O TES não foi informado [Batente]"+Chr(13)+Chr(10)+"Informar o TES na pasta Batente","Fechadura Elétrica","ALERT")
	      Return(.F.)
	   EndIf
	   If (nPosaCols := aScan(aCols,{|x| x[2]=M->Z0_FECHELE})) > 0
          If aCols[nPosaCols][Len(aHeader)+1] //item deletado
              aCols[nPosaCols][Len(aHeader)+1] := .F. //defazer delecao do item
              If SZ0->Z0_FECHELE != M->Z0_FECHELE   //o produto esta sendo trocado por outro produto
                 If (nPosaColsDel := aScan(aCols,{|x| x[2]=SZ0->Z0_FECHELE})) > 0
                    aCols[nPosaColsDel][Len(aHeader)+1] := .T. //defazer delecao do item
                 EndIf
              EndIf
          EndIf       
              aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_PRODUTO"})]  := M->Z0_FECHELE
	          aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_DESCRI"})]  := GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+M->Z0_FECHELE,1,"Produto nao encontrado")
	          aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_UM"})]  := GetAdvFVal("SB1","B1_UM",xFilial("SB1")+M->Z0_FECHELE,1,"  ")
	          aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_QTDVEN"})]  := M->Z0_QTDFECB
		      aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_PRCVEN"})]  := nPrcVen
		      aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_VALOR"})]  := nValor
	          aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_LOCAL"})]  := "01"
		      aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_TES"})]  := M->Z0_TESBAT
		      aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_CF"})] := GetAdvFVal("SF4","F4_CF",xFilial("SF4")+M->Z0_TESBAT,1,"    ")
		      aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_XFICTEC"})] := "Z0_FECHELE"
	                                           
       Else   
		   If Empty(SZ0->Z0_FECHELE).Or.(nPosaCols := aScan(aCols,{|x| x[2]=SZ0->Z0_FECHELE})) = 0
			   aInclItem := {}                              
			   aAdd(aInclItem,{"C6_ITEM",StrZero(Len(aCols)+1,2)})   
			   aAdd(aInclItem,{"C6_PRODUTO",M->Z0_FECHELE})   
			   aAdd(aInclItem,{"C6_DESCRI",GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+M->Z0_FECHELE,1,"Produto nao encontrado")})          
			   aAdd(aInclItem,{"C6_UM",GetAdvFVal("SB1","B1_UM",xFilial("SB1")+M->Z0_FECHELE,1,"  ")})          
			   aAdd(aInclItem,{"C6_QTDVEN",M->Z0_QTDFECB})                                   
			   aAdd(aInclItem,{"C6_PRCVEN",nPrcVen})                                   
			   aAdd(aInclItem,{"C6_VALOR",nValor})                                   
		       aAdd(aInclItem,{"C6_LOCAL","01"})                                   	   
			   aAdd(aInclItem,{"C6_TES",M->Z0_TESBAT})
			   aAdd(aInclItem,{"C6_CF",GetAdvFVal("SF4","F4_CF",xFilial("SF4")+M->Z0_TESBAT,1,"    ")})
			   aAdd(aInclItem,{"C6_XFICTEC","Z0_FECHELE"})
			   CarrItPed(aInclItem)   
		   ElseIf (nPosaCols := aScan(aCols,{|x| x[2]=SZ0->Z0_FECHELE})) > 0
		           aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_PRODUTO"})] := M->Z0_FECHELE
		           aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_DESCRI"})]  := GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+M->Z0_FECHELE,1,"Produto nao encontrado")
		           aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_UM"})]      := GetAdvFVal("SB1","B1_UM",xFilial("SB1")+M->Z0_FECHELE,1,"  ") 
		           aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_QTDVEN"})]  := M->Z0_QTDFECB
			       aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_PRCVEN"})]  := nPrcVen
			       aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_VALOR"})]   := nValor
		           aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_LOCAL"})]   := "01"
			       aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_TES"})]     := M->Z0_TESBAT
			       aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_CF"})]      := GetAdvFVal("SF4","F4_CF",xFilial("SF4")+M->Z0_TESBAT,1,"    ")
			       aCols[nPosaCols][aScan(aHeader,{|x| x[2]="C6_XFICTEC"})] := "Z0_FECHELE"
	       EndIf   
	   EndIf    
	ElseIf !Empty(SZ0->Z0_FECHELE)                                                          	     
	       If (nPosaCols := aScan(aCols,{|x| x[2]=SZ0->Z0_FECHELE})) > 0
	          aCols[nPosaCols][Len(aHeader)+1] := .T.                    
	          RecLock("SZ0",.F.)
	          SZ0->Z0_QTDFECB := 0
	          SZ0->(MsUnLock())   
	          
	          M->Z0_QTDFECB := 0  
	       EndIf   
	EndIf
	
	n:=1
	
	
/*	If !Empty(c_op)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Verifica se os empenhos ja foram gerados alguma vez.   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(M->Z0_STATUS)
			MsgBox("Os empenhos dessa Ficha Técnica já foram gerados! ", "A T E N Ç Ã O","INFO")
			Return(.T.)
		EndIf
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Posiciona a OP para gerar os empenhos.                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		DbSelectArea("SC2")
		DbSetOrder(1) //C2_FILIAL, C2_NUM, C2_ITEM, C2_SEQUEN, C2_ITEMGRD, R_E_C_N_O_, D_E_L_E_T_
		If !DbSeek(xFilial('SC2')+c_op)
			MsgBox("Ordem de produção Nr. (" + c_op + ") deste item do pedido não foi localizada. Verificar !!!", "A T E N Ç Ã O","ALERT")
			Return(.F.)
		EndIf                                       		
		                                            
		
		
		If MsgBox("Deseja atualizar agora? (Serão inseridos registros na tabela de empenhos de acordo com as informações da especificação técnica informada). ", "A T E N Ç Ã O","YESNO")			
		   a_strut := SZ0->(DbStruct())
			For i := 1 To Len(a_strut)
				DbSelectArea("SB1")
				DbSetOrder(1) //B1_FILIAL, B1_COD, R_E_C_N_O_, D_E_L_E_T_
				If ValType("SZ0->"+a_strut[i,1]) = 'C' .And. !Empty(&("SZ0->"+a_strut[i,1]));
				   .and. AllTrim(a_strut[i,1]) $ "Z0_MODINT, Z0_MODEXT, Z0_CILACAB, Z0_MOLAA, Z0_OLHOM, Z0_FECHAD, Z0_CILACES, Z0_ROSACES, Z0_FERRINT, Z0_PARADAP, Z0_CAPADOB"
					If DbSeek(xFilial("SB1")+Alltrim(&("SZ0->"+a_strut[i,1])), .T.)
						DbSelectArea("SB2")
						DbSetorder(1) //B2_FILIAL, B2_COD, B2_LOCAL, R_E_C_N_O_, D_E_L_E_T_
						If !DbSeek(xFilial("SB2")+SB1->B1_COD+SB1->B1_LOCPAD, .F.)
							If MsgBox("O produto " + AllTrim(SB1->B1_COD) + " não possui saldo na tabela SB2 para este local "+SB1->B1_LOCPAD+". Deseja criar agora ?","A T E N Ç Ã O","YESNO")
							   CriaSB2(SB1->B1_COD,SB1->B1_LOCPAD)
							Else
							   Loop
							EndIf
						EndIf
						
						c_TRT := ''
						DbSelectArea("SD4")   //requisicoes empenhadas
						DbSetOrder(1) //D4_FILIAL, D4_COD, D4_OP, D4_TRT, D4_LOTECTL, D4_NUMLOTE, R_E_C_N_O_, D_E_L_E_T_
						If DbSeek(xFilial("SD4")+SB1->B1_COD+SC2->(C2_NUM+C2_ITEM+C2_SEQUEN))
							Do While SD4->(D4_FILIAL+D4_COD+D4_OP) = xFilial("SD4")+SB1->B1_COD+SC2->(C2_NUM+C2_ITEM+C2_SEQUEN)
								c_TRT := soma1(SD4->D4_TRT)
								SD4->(DbSkip())
							EndDo
						EndIf
						
						IncEmp(SB1->B1_COD, SB1->B1_LOCPAD, c_TRT)
						//Excluir empenho quando eliminar produto da ficha tecnica
					EndIf
				EndIf
			Next
			
			If SZ0->Z0_FECHELT = 'S'
				c_FechElt := SUPERGETMV('MV_XFECHEL')
				DbSelectArea("SB1")
				DbSetOrder(1) //B1_FILIAL, B1_COD, R_E_C_N_O_, D_E_L_E_T_
				If DbSeek(xFilial("SB1")+Alltrim(c_FechElt), .T.)
					DbSelectArea("SB2")
					DbSetorder(1) //B2_FILIAL, B2_COD, B2_LOCAL, R_E_C_N_O_, D_E_L_E_T_
					If DbSeek(xFilial("SB2")+SB1->B1_COD+SB1->B1_LOCPAD, .F.)
						c_TRT := ''
						DbSelectArea("SD4")
						DbSetOrder(1) //D4_FILIAL, D4_COD, D4_OP, D4_TRT, D4_LOTECTL, D4_NUMLOTE, R_E_C_N_O_, D_E_L_E_T_
						If DbSeek(xFilial("SD4")+SB1->B1_COD+SC2->(C2_NUM+C2_ITEM+C2_SEQUEN))
							While SD4->(D4_FILIAL+D4_COD+D4_OP) = xFilial("SD4")+SB1->B1_COD+SC2->(C2_NUM+C2_ITEM+C2_SEQUEN)
								c_TRT := soma1(SD4->D4_TRT)
								SD4->(DbSkip())
							EndDo
						EndIf
						
						IncEmp(SB1->B1_COD, SB1->B1_LOCPAD, c_TRT)
					EndIf
				EndIf
			EndIf
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Atualiza o FLAG da Ficha Técnica                                                   ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			M->Z0_STATUS := 'X'
			
		EndIf
	EndIf
*/	
	
EndIf                                 
Return(.T.)
     


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CarrItPed ºAutor  ³Mauro Nagata        º Data ³  25/11/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Inclusao de item no pedido de vendas                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CarrItPed(pICampo)

Local aICampo := pICampo  
Local nTamHead
Local nTamCols

//[Inicio] [Inclusao dos itens do pedido, conforme regras da ficha tecnica] [Mauro Nagata, Actual Trend, 23/11/2010]
nTamHead := Len(aHeader)
aAdd(aCols,Array(nTamHead+1))	                                                                                
nTamCols := Len(aCols)
For nH := 1 to nTamHead  //cabecalho dos itens de pedido de vendas
    For nC := 1 To Len(aICampo)	  //itens do pedido de vendas
     	If AllTrim(aHeader[nH][2]) == aICampo[nC][1]    //achou cabecalho 
		   aCols[nTamCols][nH] := aICampo[nC][2]        //armazena conteudo
		Else                       
		   If Empty(aCols[nTamCols][nH])  
		      If aHeader[nH][2] == "C6_ALI_WT" 
		         aCols[nTamCols][nH] := "SC6"                              
		      ElseIf aHeader[nH][2] == "C6_REC_WT" 
		             aCols[nTamCols][nH] := 0
		      Else   
		         aCols[nTamCols][nH] := CriaVar(aHeader[nH][2])   
		      EndIf   
		   EndIf   
	    EndIf
	Next    
Next        
aCols[nTamCols][nTamHead+1] := .F.
//[Fim] [Inclusao dos itens do pedido, conforme regras da ficha tecnica] [Mauro Nagata, Actual Trend, 23/11/2010]




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Batente   ºAutor  ³Alexandre Sousa     º Data ³  02/11/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Verifica e grava os dados do batente.                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Batente(l_grv, l_edita)
Private oDescFech

c_OBS		:= space(10)
c_descfhe	:= space(40)
c_codFech	:= space(15)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If l_grv
	n_posprod	:= aScan(aHeader,{ |x| UPPER(ALLTRIM(x[2])) == "C6_PRODUTO"})
	c_codbat	:= aCols[n,n_posprod]
	c_descbat	:= GetAdvFval('SB1', 'B1_DESC', xfilial('SB1')+c_codbat, 1, '')
	n_posFech	:= Space(15)
	c_OBS		:= space(10)
	c_descFech	:= space(40)
Else
	c_codbat := SZ0->Z0_BATENTE
	c_descbat	:= GetAdvFval('SB1', 'B1_DESC', xfilial('SB1')+c_codbat, 1, '')
	c_codFech   := SZ0->Z0_FECHELE
	c_descFech	:= GetAdvFval('SB1', 'B1_DESC', xfilial('SB1')+c_codFech, 1, '')
	c_OBS 		:= SZ0->Z0_OBSBAT
//	valfechel()
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Criacao da Interface                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
@ 231,325 To 566,954 Dialog mkwdlg Title OemToAnsi("Dados do Batente")
@ 029,012 Say OemToAnsi("Batente:") Size 26,8
@ 028,045 Get c_codbat when .F. F3 'SB1' Size 063,10
@ 028,114 Get c_descbat WHEN .F. Size 175,10
@ 049,006 Say OemToAnsi("Fech. Elétrica:") Size 36,8
@ 045,045 Get c_codFech F3 'SB1' Size 063,10 Valid Vld_DescFech()
@ 045,114 Say oDescFech PROMPT c_descFech Size 175,10
@ 068,007 Say OemToAnsi("Observações:") Size 36,8
@ 065,045 Get c_OBS MEMO When l_edita Size 250,49
@ 130,257 Button OemToAnsi("CANCELA") Size 36,16 Action close(mkwdlg)
@ 131,209 Button OemToAnsi("OK") Size 36,16 Action (GRAVABAT(l_grv), close(mkwdlg))
Activate Dialog mkwdlg
                                                                 
Return                                                           


Static Function Vld_DescFech()

c_descFech	:= GetAdvFval('SB1', 'B1_DESC', xfilial('SB1')+c_codFech, 1, '')
oDescFech:Refresh()
Return.T.





/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³valfechel ºAutor  ³Microsiga           º Data ³  02/11/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Valida a digitacao da fechadura.                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/


Static Function valfechel()

Local c_codfecha := SUPERGETMV('MV_XFECHEL')

If cCombo = 'SIM'
	c_descfhe := GetAdvFval('SB1', 'B1_DESC', xfilial('SB1')+c_codfech, 1, '')
Else
	c_descfhe := ' '
EndIf

Return .T.
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GRAVABAT  ºAutor  ³Alexandre Sousa     º Data ³  02/11/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Grava dados do batente.                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GRAVABAT(l_grv)

RecLock('SZ0', l_grv)
SZ0->Z0_PEDIDO := c_pedido
SZ0->Z0_ITEM   := c_item
SZ0->Z0_BATENTE := c_codbat
SZ0->Z0_OBSBAT  := c_OBS
SZ0->Z0_FECHELE := c_codFech
MsUnLock()

Return

User Function Alt_Porta()
Local lRet := .T.

If !(M->Z0_ALTURA >= 2000.And.M->Z0_ALTURA <= 2100) .Or. M->Z0_ALTURA = 0
	lRet := SuperGetMv("MV_ALTPORT",.T.,.F.)   //caso nao seja criado o parametro o padrao sera para negar continuidade se nao fornecer a altura pre estabelecida
	MsgBox("Coloque uma altura valida entre 2000 e 2100 "+If(!lRet,"(obrigatório)",""),"A T E N Ç Ã O","ALERT")
EndIf
Return(lRet)

