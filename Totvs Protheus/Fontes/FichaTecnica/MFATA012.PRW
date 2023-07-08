#INCLUDE "TOPCONN.CH"
#include "Ap5Mail.ch"
#include "rwmake.ch"
#Include "PROTHEUS.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMFATA012  บAutor  ณAlexadre Sousa      บ Data ณ  06/18/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณAlteracao da Ficha Tecnica.(controle de versoes)            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ Nov/2010 ณ[Mauro Nagata, Actual Trend, Nov/2010                       บฑฑ
ฑฑบ          ณContinuidade na customizacao da manutencao da ficha tecnica บฑฑ
ฑฑบ          ณDefinicao e validacao sendo realizado pelo sr.Andre,TI      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณEspecifico MultLock.                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function MFATA012()

SetPrvt("AROTINA,CARQF3,CCAMPOF3,XCONTEUDO,CCADASTRO,")

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Define Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
aCores := {	{"Empty(Z0_STATALT)",'BR_VERDE'   },;	//Normal
{"Z0_STATALT== 'P'",'BR_AMARELO' },;	//Alteracao Pendente
{"Z0_STATALT== 'C'",'BR_BRANCO'  },;	//Pendencia de Credito
{"Z0_STATALT== 'A'",'BR_AZUL   ' },;	//Aprovado Alteracao
{"Z0_STATALT== 'R'",'BR_VERMELHO'},;   //Rejeitado Alteracao
{"Z0_STATALT== '1'",'BR_LARANJA' },;	//Aprovacao do Credito
{"Z0_STATALT== '0'",'BR_PRETO'   } } 	//Rejeitado do Credito


aRotina :=  {{"Pesquisar"	,"AxPesqui", 0   , 1},;
{"Visualizar"	   ,"U_MFATA12c", 0 ,2},;
{"Alterar" 		   ,"U_MFATA12a", 0 ,3},;
{"Imprimir"		   ,"U_MFATA12f", 0 ,4},;
{"Legenda"		   ,'U_MFATA12b', 0,5,0},;
{"Hist๓rico"       ,'U_MFATA12h', 0,6,0},;
{"Aprovado [PCP]"  ,'U_MFATA12d', 0,7,0},;
{"Rejeitar"		   ,'U_MFATA12e', 0,8,0},;
{"Aprov.[Cr้dito]" ,'U_MFATA12g', 0,9,0}}

CCADASTRO:="Manuten็ใo da Ficha T้cnica"         
dbSelectArea("SZ0")
dbSetOrder(1)
mBrowse( 6, 1,22,76,"SZ0",,,,,,aCores)
dbSelectArea("SZ0")
dbSetOrder(1)

Return




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMFATA12b  บAutor  ณAlexandre Sousa     บ Data ณ  03/04/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณLegenda do Status da Ficha Tecnica.                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function MFATA12b()

Local aCores := {}

aAdd(aCores,{"BR_VERDE"    ,"Ficha T้cnica Original" })
aAdd(aCores,{"BR_AMARELO"  ,"Altera็ใo Pendente"     })
aAdd(aCores,{"BR_BRANCO"   ,"Pend๊ncia de Cr้dito"   })
aAdd(aCores,{"BR_AZUL"     ,"Altera็ใo Aprovada"     })
aAdd(aCores,{"BR_VERMELHO" ,"Altera็ใo Rejeitada"    })
aAdd(aCores,{"BR_LARANJA"  ,"Aprovado pelo Cr้dito"  })
aAdd(aCores,{"BR_PRETO"    ,"Rejeitado pelo Cr้dito" })

BrwLegenda(cCadastro,"Legenda",aCores)

Return




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMFATA12a  บAutor  ณAlexandre Sousa     บ Data ณ  03/04/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRealiza a alteracao da Ficha Tecnica.                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function MFATA12a(cpar1, cpar2, nOpc)
Local aArea_Atual := GetArea()


RegToMemory("SZ0")

DbSelectArea('SZ4')
DbSetOrder(1) //Z4_FILIAL, Z4_PEDIDO, Z4_ITEM, Z4_DATAALT, R_E_C_N_O_, D_E_L_E_T_

Do Case
	Case SZ0->Z0_STATALT $ "P.1"     //alteracao pendente para analise de aprovacao
		MsgBox("Ficha t้cnica foi alterada e estแ em anแlise pelo PCP"+Chr(13)+Chr(10)+Chr(13)+Chr(10)+;
		"Somente ap๓s aprovada ou rejeitada estแ altera็ใo voc๊ terแ permissใo de uma nova altera็ใo","Ficha T้cnica","ALERT")
		Return(.T.)
	Case SZ0->Z0_STATALT == "C"     //alteracao pendente para aprovacao
		MsgBox("Ficha t้cnica foi alterada e na estแ em anแlise pela แrea de Cr้dito"+Chr(13)+Chr(10)+Chr(13)+Chr(10)+;
		"Somente ap๓s aprovada ou rejeitada estแ altera็ใo voc๊ terแ permissใo de uma nova altera็ใo","Ficha T้cnica","ALERT")
		Return(.T.)
EndCase

If VERFATSC6()
	msgalert('A Ficha T้cnica nใo poderแ ser alterada, pois jแ houve faturamento dos itens!!!!', "A T E N ว ร O")
	Return
EndIf


If DbSeek(xFilial('SZ4')+SZ0->(Z0_PEDIDO+Z0_ITEM))
	nRecSZ4 := Recno()
	lStatPnd := .F.  //alteracao pendente
	Do While !Eof().And.SZ0->Z0_PEDIDO+SZ0->Z0_ITEM = SZ4->Z4_PEDIDO+SZ4->Z4_ITEM
		If SZ4->Z4_STATALT $ "P.1"
			lStatPnd := .T.
			Exit
		EndIf
		DbSkip()
	EndDo
	
	If lStatPnd   //.T., alteracao pendente, se Z0_STATALT <> P entao Z4_STATALT tem que ser diferente de "P"
		Msgbox("Ficha t้cnica inconsistente [SZ0 vs SZ4]. Verificar","Ficha T้cncia","ALERT")
		Return(.T.)
	Else           
	    aCmpSel := {} //campo selecionado para axcadastro
	    DbGoTo(nRecSZ4)
	    
	    SC5->(DbSetOrder(1))
		SC5->(DbSeek(xFilial("SC5")+SZ4->Z4_PEDIDO))     
		
		lBatEdit := .F.
		SC6->(DbSetOrder(1))
		SC6->(DbSeek(xFilial("SC6")+SZ4->Z4_PEDIDO))
		Do While !SC6->(Eof()).And.SC6->C6_NUM=SZ4->Z4_PEDIDO
		   If Substr(SC6->C6_PRODUTO,1,2) = "BA"
		      lBatEdit := .T.
		   EndIf
		   SC6->(DbSkip())
		EndDo      
	    
		RecLock('SZ4', .T.)
		DbSelectArea('SX3')
		DbSetOrder(1)
		DbSeek('SZ4')
		Do While SX3->X3_ARQUIVO = 'SZ4'
			If SX3->X3_CONTEXT <> 'V' .and. SX3->X3_CAMPO <> 'Z4_DATAALT'
				SZ4->(&(SX3->X3_CAMPO)) := SZ0->(&("Z0"+SubStr(SX3->X3_CAMPO,3,15)))
			EndIf
			If SX3->X3_CONTEXT <> 'V' .and. SX3->X3_CAMPO <> 'Z4_DATAALT';
			   .And.SX3->X3_CAMPO <> 'Z4_PRCMOLA'.And.SX3->X3_CAMPO <> 'Z4_PRCOLHO';
			   .And.SX3->X3_CAMPO <> 'Z4_PRCCIL1'.And.SX3->X3_CAMPO <> 'Z4_PRCROSE';
			   .And.SX3->X3_CAMPO <> 'Z4_PRCFECH'.And.SX3->X3_CAMPO <> 'Z4_PRC1FER';
			   .And.SX3->X3_CAMPO <> 'Z4_PRC2FER'.And.SX3->X3_CAMPO <> 'Z4_PRC3FER';
			   .And.SX3->X3_CAMPO <> 'Z4_PRC4FER';
			   .And.(!(SC5->C5_XORIGEM != "C".And.AllTrim(SX3->X3_CAMPO) $ "Z4_BATENTE.Z4_OBSBAT").Or.lBatEdit)                                   
//			   .And.(!(SC5->C5_XORIGEM != "C".And.AllTrim(SX3->X3_CAMPO) $ "Z4_BATENTE.Z4_FECHELE.Z4_TESBAT.Z4_OBSBAT").Or.lBatEdit)                                   
				aAdd(aCmpSel,SX3->X3_CAMPO)
			EndIf
			        
			SX3->(DbSkip())
		EndDo
		
		SZ4->(MsUnLock())
	EndIf
	
	DbGoTo(nRecSZ4)
	
	DbSelectArea('SZ4')  //gerenciamento de alteracao da ficha tecnicaa
	DbSetOrder(1) //Z4_FILIAL, Z4_PEDIDO, Z4_ITEM, Z4_DATAALT, R_E_C_N_O_, D_E_L_E_T_
	c_Ret := AxAltera('SZ4', SZ4->(Recno()), nOpc,aCmpSel,aCmpSel,,,"U_F012TOK()")
	If c_Ret == 3
		RecLock('SZ4', .F.)
		DbDelete()
		SZ4->(MsUnLock())
	EndIf
Else
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณAdiciona um registro em branco para registrar a Ficha antes da alteracao e poder real็ar     ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
    aCmpSel := {}   //campo selecionado para axcadastro
	RecLock('SZ4', .T.)    
	lBatEdit := .F.
	DbSelectArea('SX3')
	DbSetOrder(1)
	DbSeek('SZ4')
	Do While SX3->X3_ARQUIVO = 'SZ4'
		If SX3->X3_CONTEXT <> 'V' .and. SX3->X3_CAMPO <> 'Z4_DATAALT'
			SZ4->(&(SX3->X3_CAMPO)) := SZ0->(&("Z0"+SubStr(SX3->X3_CAMPO,3,15)))
		EndIf	 
		If SX3->X3_CONTEXT <> 'V' .and. SX3->X3_CAMPO <> 'Z4_DATAALT';
	       .And.SX3->X3_CAMPO <> 'Z4_PRCMOLA'.And.SX3->X3_CAMPO <> 'Z4_PRCOLHO';
		   .And.SX3->X3_CAMPO <> 'Z4_PRCCIL1'.And.SX3->X3_CAMPO <> 'Z4_PRCROSE';
		   .And.SX3->X3_CAMPO <> 'Z4_PRCFECH'.And.SX3->X3_CAMPO <> 'Z4_PRC1FER';
		   .And.SX3->X3_CAMPO <> 'Z4_PRC2FER'.And.SX3->X3_CAMPO <> 'Z4_PRC3FER';
		   .And.SX3->X3_CAMPO <> 'Z4_PRC4FER';
		   .And.(!(SC5->C5_XORIGEM != "C".And.AllTrim(SX3->X3_CAMPO) $ "Z4_BATENTE.Z4_OBSBAT").Or.lBatEdit)                                                                      
			aAdd(aCmpSel,SX3->X3_CAMPO)
		EndIf	
		SX3->(DbSkip())
	EndDo
	
	SZ4->(MsUnLock())
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณContinuacao da rotina normal.                                                                ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
    aCmpSel := {}   //campo selecionado para axcadastro
	RecLock('SZ4', .T.)
	
	SC5->(DbSetOrder(1))
	SC5->(DbSeek(xFilial("SC5")+SZ0->Z0_PEDIDO))     
	
	lBatEdit := .F.
	SC6->(DbSetOrder(1))
	SC6->(DbSeek(xFilial("SC6")+SZ4->Z4_PEDIDO))
	Do While !SC6->(Eof()).And.SC6->C6_NUM=SZ4->Z4_PEDIDO
	   If Substr(SC6->C6_PRODUTO,1,2) = "BA"
	      lBatEdit := .T.
	   EndIf
	   SC6->(DbSkip())
	EndDo      

	DbSelectArea('SX3')
	DbSetOrder(1)
	DbSeek('SZ4')
	Do While SX3->X3_ARQUIVO = 'SZ4'
		If SX3->X3_CONTEXT <> 'V' .and. SX3->X3_CAMPO <> 'Z4_DATAALT'
			SZ4->(&(SX3->X3_CAMPO)) := SZ0->(&("Z0"+SubStr(SX3->X3_CAMPO,3,15)))
		EndIf	 
		If SX3->X3_CONTEXT <> 'V' .and. SX3->X3_CAMPO <> 'Z4_DATAALT';
	       .And.SX3->X3_CAMPO <> 'Z4_PRCMOLA'.And.SX3->X3_CAMPO <> 'Z4_PRCOLHO';
		   .And.SX3->X3_CAMPO <> 'Z4_PRCCIL1'.And.SX3->X3_CAMPO <> 'Z4_PRCROSE';
		   .And.SX3->X3_CAMPO <> 'Z4_PRCFECH'.And.SX3->X3_CAMPO <> 'Z4_PRC1FER';
		   .And.SX3->X3_CAMPO <> 'Z4_PRC2FER'.And.SX3->X3_CAMPO <> 'Z4_PRC3FER';
		   .And.SX3->X3_CAMPO <> 'Z4_PRC4FER';
		   .And.(!(SC5->C5_XORIGEM != "C".And.AllTrim(SX3->X3_CAMPO) $ "Z4_BATENTE.Z4_OBSBAT").Or.lBatEdit)                                                                      
//		   .And.(!(SC5->C5_XORIGEM != "C".And.AllTrim(SX3->X3_CAMPO) $ "Z4_BATENTE.Z4_FECHELE.Z4_TESBAT.Z4_OBSBAT").Or.lBatEdit)                                                                      
			aAdd(aCmpSel,SX3->X3_CAMPO)
		EndIf	
		SX3->(DbSkip())
	EndDo
	
	SZ4->(MsUnLock())
	
	DbSelectArea('SZ4')
	DbSetOrder(1) //Z4_FILIAL, Z4_PEDIDO, Z4_ITEM, Z4_DATAALT, R_E_C_N_O_, D_E_L_E_T_
	c_Ret   := AxAltera('SZ4', SZ4->(Recno()),nOpc,aCmpSel,aCmpSel,,,'U_F012TOK()')
	If c_Ret == 3
		RecLock('SZ4', .F.)
		DbDelete()
		SZ4->(MsUnLock())
	EndIf
	
EndIf

If c_Ret = 1
	lIpAlt := .F.  //alterado
	DbSelectArea('SX3')
	DbSetOrder(1)
	DbSeek('SZ4')
	Do While SX3->X3_ARQUIVO = 'SZ4'
		If SX3->X3_CONTEXT <> 'V' .And. (SX3->X3_CAMPO <> 'Z4_DATAALT')
			If SZ4->(&(SX3->X3_CAMPO)) != SZ0->(&("Z0"+SubStr(SX3->X3_CAMPO,3,15)))
				lIpAlt := .T.
			EndIf
		EndIf
		SX3->(DbSkip())
	EndDo
	If lIpAlt
		RecLock('SZ0', .F.)
		SZ0->Z0_DATAALT := dDataBase
				
		DbSelectArea("SZ4")
		RecLock('SZ4', .F.)
		If SZ4->Z4_STATALT = "C"   //analise de credito
		   SZ0->Z0_STATALT := 'C'  
		ElseIf SZ4->Z4_STATALT = "P"
		       SZ0->Z0_STATALT := 'P'  //alteracao pendente
		       EnviaWFA()
		EndIf   
		SZ4->Z4_DATAALT := dDataBase
		SZ4->(MsUnLock())          
		SZ0->(MsUnLock())
		
	Else
		RecLock('SZ4', .F.)
		DbDelete()
		SZ4->(MsUnLock())
	EndIf
EndIf

RestArea(aArea_Atual)

Return .T.




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณF012TOK   บAutor  ณMauro Nagata        บ Data ณ  23/12/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณvalidacao da alteracao do pedidos de vendas                 บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function F012TOK()
Local lRet        := .T.
Local aArea_Atual := GetArea()
Local nPrcMolaP   := 0
Local nPrcOlhoP   := 0
Local nPrcFechP   := 0
Local nPrcCil1P   := 0
Local nPrcRosaP   := 0
Local nPrc1FerP   := 0
Local nPrc2FerP   := 0
Local nPrc3FerP   := 0
Local nPrc4FerP   := 0
Local nPrcFecbP   := 0
Private nTotPv    := 0
Private nTotFt    := 0
Private aVerPrc1  := {}

DbSelectArea("SC6")
DbSetOrder(1)
If DbSeek(xFilial("SC6")+SZ0->Z0_PEDIDO)
	Do While !Eof().And.SC6->C6_NUM=SZ0->Z0_PEDIDO
		If AllTrim(SC6->C6_XFICTEC) = "Z0_MOLAA"
//			cPrdMola := SC6->C6_PRODUTO
			nPrcMolaP := SC6->C6_PRCVEN
			nVlrItP   := SC6->C6_QTDVEN*nPrcMolaP
			nVlrItF   := M->Z4_QTDMOLA*nPrcMolaP
			nDifFP    := nVlrItF-nVlrItP
			aAdd(aVerPrc1,{"Mola A้rea [Acess๓rios]",nPrcMolaP,nVlrItF,nDifFP})	
		EndIf
		If AllTrim(SC6->C6_XFICTEC) = "Z0_OLHOM"
			cPrdOlho  := SC6->C6_PRODUTO
			nPrcOlhoP := SC6->C6_PRCVEN
			nVlrItP   := SC6->C6_QTDVEN*nPrcOlhoP
			nVlrItF   := M->Z4_QTDOLHO*nPrcOlhoP
			nDifFP    := nVlrItF-nVlrItP
			aAdd(aVerPrc1,{"Olho Mแgico [Acess๓rios]",nPrcOlhoP,nVlrItF,nDifFP})
		EndIf
		If AllTrim(SC6->C6_XFICTEC) = "Z0_FECHAD"
			cPrdFech  := SC6->C6_PRODUTO
			nPrcFechP := SC6->C6_PRCVEN
			nVlrItP   := SC6->C6_QTDVEN*nPrcFechP
			nVlrItF   := M->Z4_QTDFECH*nPrcFechP
			nDifFP    := nVlrItF-nVlrItP
			aAdd(aVerPrc1,{"Fechadura Adicional [Acess๓rios]",nPrcFechP,nVlrItF,nDifFP})
		EndIf
		If AllTrim(SC6->C6_XFICTEC) = "Z0_CILACES"
			cPrdCilA  := SC6->C6_PRODUTO
			nPrcCilAP := SC6->C6_PRCVEN
			nVlrItP   := SC6->C6_QTDVEN*nPrcCilAP
			nVlrItF   := M->Z4_QTDCIL1*nPrcCilAP
			nDifFP    := nVlrItF-nVlrItP
			aAdd(aVerPrc1,{"Cilindro [Acess๓rios]",nPrcCilAP,nVlrItF,nDifFP})
		EndIf
		If AllTrim(SC6->C6_XFICTEC) = "Z0_ROSACES"
			cPrdRosA  := SC6->C6_PRODUTO
			nPrcRosAP := SC6->C6_PRCVEN
			nVlrItP   := SC6->C6_QTDVEN*nPrcRosAP
			nVlrItF   := M->Z4_QTDROSE*nPrcRosAP
			nDifFP    := nVlrItF-nVlrItP
			aAdd(aVerPrc1,{"Roseta [Acess๓rios]",nPrcRosAP,nVlrItF,nDifFP})
		EndIf
		If AllTrim(SC6->C6_XFICTEC) = "Z0_PRD1FER"
			cPrdPrd1  := SC6->C6_PRODUTO
			nPrc1FerP  := SC6->C6_PRCVEN
			nVlrItP   := SC6->C6_QTDVEN*nPrc1FerP 
			nVlrItF   := M->Z4_QTD1FER*nPrc1FerP 
			nDifFP    := nVlrItF-nVlrItP
			aAdd(aVerPrc1,{"Produto 1 [Ferragens]",nPrc1FerP ,nVlrItF,nDifFP})
		EndIf
		If AllTrim(SC6->C6_XFICTEC) = "Z0_PRD2FER"
			cPrdPrd2  := SC6->C6_PRODUTO
			nPrc2FerP := SC6->C6_PRCVEN
			nVlrItP   := SC6->C6_QTDVEN*nPrc2FerP
			nVlrItF   := M->Z4_QTD2FER*nPrc2FerP
			nDifFP    := nVlrItF-nVlrItP
			aAdd(aVerPrc1,{"Produto 2 [Ferragens]",nPrc2FerP,nVlrItF,nDifFP})
		EndIf
		If AllTrim(SC6->C6_XFICTEC) = "Z0_PRD3FER"
			cPrdPrd3  := SC6->C6_PRODUTO
			nPrc3FerP := SC6->C6_PRCVEN
			nVlrItP   := SC6->C6_QTDVEN*nPrc3FerP
			nVlrItF   := M->Z4_QTD3FER*nPrc3FerP
			nDifFP    := nVlrItF-nVlrItP
			aAdd(aVerPrc1,{"Produto 3 [Ferragens]",nPrc3FerP,nVlrItF,nDifFP})
		EndIf
		If AllTrim(SC6->C6_XFICTEC) = "Z0_PRD4FER"
			cPrdPrd4  := SC6->C6_PRODUTO
			nPrc4FerP := SC6->C6_PRCVEN
			nVlrItP   := SC6->C6_QTDVEN*nPrc4FerP
			nVlrItF   := M->Z4_QTD4FER*nPrc4FerP
			nDifFP    := nVlrItF-nVlrItP
			aAdd(aVerPrc1,{"Produto 4 [Ferragens]",nPrc4FerP,nVlrItF,nDifFP})
		EndIf
		If AllTrim(SC6->C6_XFICTEC) = "Z0_FECHELE"
			cPrdFech  := SC6->C6_PRODUTO
			nPrcFechP := SC6->C6_PRCVEN
			nVlrItP   := SC6->C6_QTDVEN*nPrcFecbP
			nVlrItF   := M->Z4_QTDFECH*nPrcFecbP
			nDifFP    := nVlrItF-nVlrItP
			aAdd(aVerPrc1,{"Fechadura Adicional [Acess๓rios]",nPrcFecbP,nVlrItF,nDifFP})
		EndIf
		
		nTotPv += SC6->C6_VALOR  //valor totalizador do pedido
		nTotFt := nTotPv
		DbSkip()
	EndDo
EndIf

//aArea_SC5 := SC5->(GetArea())
//DbSelectArea("SC5")
//DbSetOrder(1)
//DbSeek(xFilial("SC5")+SZ0->Z0_PEDIDO)

lAlt     := .F.

lStatVal := " "
lIpTodo := .F.

Do While lStatVal $ " .P"  //status [P]roximo item
	lStatVal := "I"  //status [I]nicial
	nPrcMolaF := 0
	If !Empty(M->Z4_MOLAA)  //mola aerea
		If Empty(M->Z4_QTDMOLA)
			MsgBox("A quantidade estแ zerada [Acess๓rios]"+Chr(13)+Chr(10)+"Informar a quantidade na pasta Acess๓rios","Mola Aerea","ALERT")
			Return(.F.)
		EndIf
		If Empty(M->Z4_TESACES)
			MsgBox("O TES nใo foi informado [Acess๓rios]"+Chr(13)+Chr(10)+"Informar o TES na pasta Acess๓rios","Mola Aerea","ALERT")
			Return(.F.)                                                               
		EndIf
		If M->Z4_MOLAA != SZ0->Z0_MOLAA .Or. M->Z4_QTDMOLA != SZ0->Z0_QTDMOLA 
		   lIpOk := .F.
		   DbSelectArea("SC6")
           DbSetOrder(1)
           If DbSeek(xFilial("SC6")+SZ0->Z0_PEDIDO)
         	  Do While !Eof().And.SC6->C6_NUM=SZ0->Z0_PEDIDO
		         If AllTrim(SC6->C6_XFICTEC) = "Z0_MOLAA"
		            lIpOk := .T.
		         EndIf
		         DbSkip()   
		      EndDo
		   EndIf       
		   If !lIpOk
			  aAdd(aVerPrc1,{"Mola A้rea [Acess๓rios]",0,0,0})	
		   EndIf   
		   nPrcMolaF:= VerPrc1("Mola A้rea [Acess๓rios]",M->Z4_MOLAA,M->Z4_QTDMOLA,SZ0->Z0_MOLAA,SZ0->Z0_QTDMOLA,nPrcMolaP)  //alteracao de produto e eh necessario avaliar
		EndIf
	Else 
		RecLock("SZ4",.F.)
		SZ4->Z4_QTDMOLA := 0    //zerar quantidade da mola aerea
		SZ4->(MsUnLock())
		
		//atualizacao das variaveis de memorias
		M->Z4_QTDMOLA := 0
	EndIf        
	If lStatVal = "C" .And.lIpTodo
	   Loop
	EndIf   
	nPrcOlhoF := 0
	
	If !Empty(M->Z4_OLHOM)
		If Empty(M->Z4_QTDOLHO)
			MsgBox("A quantidade estแ zerada [Acess๓rios]"+Chr(13)+Chr(10)+"Informar a quantidade na pasta Acess๓rios","Olho Mแgico","ALERT")
			Return(.F.)                                                              
		EndIf
		If Empty(M->Z4_TESACES)
			MsgBox("O TES nใo foi informado [Acess๓rios]"+Chr(13)+Chr(10)+"Informar o TES na pasta Acess๓rios","Olho Mแgico","ALERT")
			Return(.F.)
		EndIf
		If Empty(M->Z4_ALTOLHO)
			MsgBox("A Altura do Olho Mแgico nใo foi informada [Acess๓rios]"+Chr(13)+Chr(10)+"Informar a Altura na pasta Acess๓rios","Olho Mแgico","ALERT")
			Return(.F.)
		EndIf
		If M->Z4_OLHOM != SZ0->Z0_OLHOM.Or. M->Z4_QTDOLHO != SZ0->Z0_QTDOLHO
		   lIpOk := .F.
		   DbSelectArea("SC6")
           DbSetOrder(1)
           If DbSeek(xFilial("SC6")+SZ0->Z0_PEDIDO)
         	  Do While !Eof().And.SC6->C6_NUM=SZ0->Z0_PEDIDO
		         If AllTrim(SC6->C6_XFICTEC) = "Z0_OLHOM"
		            lIpOk := .T.
		         EndIf
		         DbSkip()   
		      EndDo
		   EndIf       
		   If !lIpOk
			  aAdd(aVerPrc1,{"Olho Mแgico [Acess๓rios]",0,0,0})	
		   EndIf   
		   nPrcOlhoF :=VerPrc1("Olho Mแgico [Acess๓rios]",M->Z4_OLHOM,M->Z4_QTDOLHO,SZ0->Z0_OLHOM,SZ0->Z0_QTDOLHO,nPrcOlhoP)  //alteracao de produto e eh necessario avaliar
		EndIf
	Else         
		RecLock("SZ4",.F.)
		SZ4->Z4_QTDOLHO := 0   //zerar quantidade do olho magico
		SZ4->Z4_ALTOLHO := 0   //zerar quantidade da altura do olho magico
		SZ4->(MsUnLock())
		
		//atualizacao das variaveis de memorias
		M->Z4_QTDOLHO := 0
		M->Z4_ALTOLHO := 0
	EndIf             
	If lStatVal = "C" .And.lIpTodo
	   Loop
	EndIf   
	nPrcFechF := 0

	If !Empty(M->Z4_FECHAD)	
		If Empty(M->Z4_QTDFECH)
			MsgBox("A quantidade estแ zerada [Acess๓rios]"+Chr(13)+Chr(10)+"Informar a quantidade na pasta Acess๓rios","Fechadura Adicional","ALERT")
			Return(.F.)
		EndIf
		If Empty(M->Z4_TESACES)
			MsgBox("O TES nใo foi informado [Acess๓rios]"+Chr(13)+Chr(10)+"Informar o TES na pasta Acess๓rios","Fechadura Adicional","ALERT")
			Return(.F.)
		EndIf
		If M->Z4_FECHAD != SZ0->Z0_FECHAD  
		   lIpOk := .F.
		   DbSelectArea("SC6")
           DbSetOrder(1)
           If DbSeek(xFilial("SC6")+SZ0->Z0_PEDIDO)
         	  Do While !Eof().And.SC6->C6_NUM=SZ0->Z0_PEDIDO
		         If AllTrim(SC6->C6_XFICTEC) = "Z0_FECHAD"
		            lIpOk := .T.
		         EndIf
		         DbSkip()   
		      EndDo
		   EndIf       
		   If !lIpOk
			  aAdd(aVerPrc1,{"Fechadura Adicional [Acess๓rios]",0,0,0})	
		   EndIf   
		   nPrcFechF := VerPrc1("Fechadura Adicional [Acess๓rios]",M->Z4_FECHAD,M->Z4_QTDFECH,SZ0->Z0_FECHAD,SZ0->Z0_QTDFECH,nPrcFechP)  //alteracao de produto e eh necessario avaliar
		EndIf
	Else              
		RecLock("SZ4",.F.)
		SZ4->Z4_QTDFECH := 0    //zerar quantidade da fechadura
		SZ4->Z4_ALTFECH := 0    //zerar a altura da fechadura
		SZ4->(MsUnLock())
		
		//atualizacao das variaveis de memorias
		M->Z4_QTDFECH := 0
		M->Z4_ALTFECH := 0
	EndIf             
	If lStatVal = "C" .And.lIpTodo
	   Loop
	EndIf   
	nPrcCil1F := 0
	If !Empty(M->Z4_CILACES)		
		If Empty(M->Z4_QTDCIL1)
			MsgBox("A quantidade estแ zerada [Acess๓rios]"+Chr(13)+Chr(10)+"Informar a quantidade na pasta Acess๓rios","Cilindro","ALERT")
			Return(.F.)
		EndIf
		If Empty(M->Z4_TESACES)
			MsgBox("O TES nใo foi informado [Acess๓rios]"+Chr(13)+Chr(10)+"Informar o TES na pasta Acess๓rios","Cilindro","ALERT")
			Return(.F.)
		EndIf
		If M->Z4_CILACES != SZ0->Z0_CILACES
		   lIpOk := .F.
		   DbSelectArea("SC6")
           DbSetOrder(1)
           If DbSeek(xFilial("SC6")+SZ0->Z0_PEDIDO)
         	  Do While !Eof().And.SC6->C6_NUM=SZ0->Z0_PEDIDO
		         If AllTrim(SC6->C6_XFICTEC) = "Z0_CILACES"
		            lIpOk := .T.
		         EndIf
		         DbSkip()   
		      EndDo
		   EndIf       
		   If !lIpOk
			  aAdd(aVerPrc1,{"Cilindro [Acess๓rios]",0,0,0})	
		   EndIf   
		   nPrcCil1F := VerPrc1("Cilindro [Acess๓rios]",M->Z4_CILACES,M->Z4_QTDCIL1,SZ0->Z0_CILIACES,SZ0->Z0_QTDCIL1,nPrcCilAP)  //alteracao de produto e eh necessario avaliar
		EndIf
	Else              
		RecLock("SZ4",.F.)
		SZ4->Z4_QTDCIL1 := 0   //zerar quantidade do cilindro
		SZ4->(MsUnLock())
		
		//atualizacao das variaveis de memorias
		M->Z4_QTDCIL1 := 0
	EndIf            
	If lStatVal = "C" .And.lIpTodo
	   Loop
	EndIf   
	nPrcRoseF := 0
	If !Empty(M->Z4_ROSACES)
		If Empty(M->Z4_QTDROSE)
			MsgBox("A quantidade estแ zerada [Acess๓rios]"+Chr(13)+Chr(10)+"Informar a quantidade na pasta Acess๓rios","Roseta","ALERT")
			Return(.F.)
		EndIf
		If Empty(M->Z4_TESACES)
			MsgBox("O TES nใo foi informado [Acess๓rios]"+Chr(13)+Chr(10)+"Informar o TES na pasta Acess๓rios","Roseta","ALERT")
			Return(.F.)
		EndIf
		If M->Z4_ROSACES != SZ0->Z0_ROSACES
		   lIpOk := .F.
		   DbSelectArea("SC6")
           DbSetOrder(1)
           If DbSeek(xFilial("SC6")+SZ0->Z0_PEDIDO)
         	  Do While !Eof().And.SC6->C6_NUM=SZ0->Z0_PEDIDO
		         If AllTrim(SC6->C6_XFICTEC) = "Z0_ROSACES"
		            lIpOk := .T.
		         EndIf
		         DbSkip()   
		      EndDo
		   EndIf       
		   If !lIpOk
			  aAdd(aVerPrc1,{"Roseta [Acess๓rios]",0,0,0})	
		   EndIf   
		   nPrcRoseF := VerPrc1("Roseta [Acess๓rios]",M->Z4_ROSACES,M->Z4_QTDROSE,SZ0->Z0_ROSACES,SZ0->Z0_QTDROSE,nPrcRosaP)  //alteracao de produto e eh necessario avaliar
		EndIf
	Else             
		RecLock("SZ4",.F.)
		SZ4->Z4_QTDROSE := 0  //zerar quantidade da roseta
		SZ4->(MsUnLock())
		
		//atualizacao das variaveis de memorias
		M->Z4_QTDROSE := 0
	EndIf           
	If lStatVal = "C" .And.lIpTodo
	   Loop
	EndIf   
	nPrc1FerF := 0
	If !Empty(M->Z4_PRD1FER)	
		If Empty(M->Z4_QTD1FER)
			MsgBox("A quantidade estแ zerada [Ferragem]"+Chr(13)+Chr(10)+"Informar a quantidade na pasta Ferragem","Produto 1","ALERT")
			Return(.F.)
		EndIf
		If Empty(M->Z4_TESFER)
			MsgBox("O TES nใo foi informado [Ferragem]"+Chr(13)+Chr(10)+"Informar o TES na pasta Ferragem","Produto 1","ALERT")
			Return(.F.)
		EndIf
		If M->Z4_PRD1FER != SZ0->Z0_PRD1FER
		   lIpOk := .F.
		   DbSelectArea("SC6")
           DbSetOrder(1)
           If DbSeek(xFilial("SC6")+SZ0->Z0_PEDIDO)
         	  Do While !Eof().And.SC6->C6_NUM=SZ0->Z0_PEDIDO
		         If AllTrim(SC6->C6_XFICTEC) = "Z0_PRD1FER"
		            lIpOk := .T.
		         EndIf
		         DbSkip()   
		      EndDo
		   EndIf       
		   If !lIpOk
			  aAdd(aVerPrc1,{"Produto 1 [Ferragens]",0,0,0})	
		   EndIf   
		   nPrc1FerF := VerPrc1("Produto 1 [Ferragens]",M->Z4_PRD1FER,M->Z4_QTD1FER,SZ0->Z0_PRD1FER,SZ0->Z0_QTD1FER,nPrc1FerP )  //alteracao de produto e eh necessario avaliar
		EndIf
	Else            
		Reclock("SZ4",.F.)
		SZ4->Z4_QTD1FER := 0    //zerar quantidade do produto 1
		SZ4->(MsUnLock())
		
		//atualizacao das variaveis de memorias
		M->Z4_QTD1FER := 0
	EndIf           
	If lStatVal = "C" .And.lIpTodo
	   Loop
	EndIf   
	nPrc2FerF := 0
	If !Empty(M->Z4_PRD2FER)		
		If Empty(M->Z4_QTD2FER)
			MsgBox("A quantidade estแ zerada [Ferragem]"+Chr(13)+Chr(10)+"Informar a quantidade na pasta Ferragem","Produto 2","ALERT")
			Return(.F.)
		EndIf
		If Empty(M->Z4_TESFER)
			MsgBox("O TES nใo foi informado [Ferragem]"+Chr(13)+Chr(10)+"Informar o TES na pasta Ferragem","Produto 2","ALERT")
			Return(.F.)
		EndIf
		If M->Z4_PRD2FER != SZ0->Z0_PRD2FER
		   lIpOk := .F.
		   DbSelectArea("SC6")
           DbSetOrder(1)
           If DbSeek(xFilial("SC6")+SZ0->Z0_PEDIDO)
         	  Do While !Eof().And.SC6->C6_NUM=SZ0->Z0_PEDIDO
		         If AllTrim(SC6->C6_XFICTEC) = "Z0_PRD2FER"
		            lIpOk := .T.
		         EndIf
		         DbSkip()   
		      EndDo
		   EndIf       
		   If !lIpOk
			  aAdd(aVerPrc1,{"Produto 2 [Ferragens]",0,0,0})	
		   EndIf   
		   nPrc2FerF := VerPrc1("Produto 2 [Ferragens]",M->Z4_PRD2FER,M->Z4_QTD2FER,SZ0->Z0_PRD2FER,SZ0->Z0_QTD2FER,nPrc2FerP)  //alteracao de produto e eh necessario avaliar
		EndIf
	Else            
		RecLock("SZ4",.F.)
		SZ4->Z4_QTD2FER := 0   //zerar quantidade do produto 2
		SZ4->(MsUnLock())
		
		//atualizacao das variaveis de memorias
		M->Z4_QTD2FER := 0
	EndIf           
	If lStatVal = "C" .And.lIpTodo
	   Loop
	EndIf   
	nPrc3FerF := 0
	If !Empty(M->Z4_PRD3FER)		
		If Empty(M->Z4_QTD3FER)
			MsgBox("A quantidade estแ zerada [Ferragem]"+Chr(13)+Chr(10)+"Informar a quantidade na pasta Ferragem","Produto 3","ALERT")
			Return(.F.)
		EndIf
		If Empty(M->Z4_TESFER)
			MsgBox("O TES nใo foi informado [Ferragem]"+Chr(13)+Chr(10)+"Informar o TES na pasta Ferragem","Produto 3","ALERT")
			Return(.F.)
		EndIf
		If M->Z4_PRD3FER != SZ0->Z0_PRD3FER
		   lIpOk := .F.
		   DbSelectArea("SC6")
           DbSetOrder(1)
           If DbSeek(xFilial("SC6")+SZ0->Z0_PEDIDO)
         	  Do While !Eof().And.SC6->C6_NUM=SZ0->Z0_PEDIDO
		         If AllTrim(SC6->C6_XFICTEC) = "Z0_PRD3FER"
		            lIpOk := .T.
		         EndIf
		         DbSkip()   
		      EndDo
		   EndIf       
		   If !lIpOk
			  aAdd(aVerPrc1,{"Produto 3 [Ferragens]",0,0,0})	
		   EndIf   
		   nPrc3FerF := VerPrc1("Produto 3 [Ferragens]",M->Z4_PRD3FER,M->Z4_QTD3FER,SZ0->Z0_PRD3FER,SZ0->Z0_QTD3FER,nPrc3FerP)  //alteracao de produto e eh necessario avaliar
		EndIf
	Else            
		RecLock("SZ4",.F.)
		SZ4->Z4_QTD3FER := 0            //zerar quantidade do produto 3
		SZ4->(MsUnLock())
		
		//atualizacao das variaveis de memorias
		M->Z4_QTD3FER := 0
	EndIf           
	If lStatVal = "C" .And.lIpTodo
	   Loop
	EndIf   
	nPrc4FerF := 0
	If !Empty(M->Z4_PRD4FER)		
		If Empty(M->Z4_QTD4FER)
			MsgBox("A quantidade estแ zerada [Ferragem]"+Chr(13)+Chr(10)+"Informar a quantidade na pasta Ferragem","Produto 4","ALERT")
			Return(.F.)
		EndIf
		If Empty(M->Z4_TESFER)
			MsgBox("O TES nใo foi informado [Ferragem]"+Chr(13)+Chr(10)+"Informar o TES na pasta Ferragem","Produto 4","ALERT")
			Return(.F.)
		EndIf
		If M->Z4_PRD4FER != SZ0->Z0_PRD4FER
		   lIpOk := .F.
		   DbSelectArea("SC6")
           DbSetOrder(1)
           If DbSeek(xFilial("SC6")+SZ0->Z0_PEDIDO)
         	  Do While !Eof().And.SC6->C6_NUM=SZ0->Z0_PEDIDO
		         If AllTrim(SC6->C6_XFICTEC) = "Z0_PRD4FER"
		            lIpOk := .T.
		         EndIf
		         DbSkip()   
		      EndDo
		   EndIf       
		   If !lIpOk
			  aAdd(aVerPrc1,{"Produto 4 [Ferragens]",0,0,0})	
		   EndIf   
		   nPrc4FerF := VerPrc1("Produto 4 [Ferragens]",M->Z4_PRD4FER,M->Z4_QTD4FER,SZ0->Z0_PRD4FER,SZ0->Z0_QTD4FER,nPrc4FerP)  //alteracao de produto e eh necessario avaliar
		EndIf
	Else            
		RecLock("SZ4",.F.)
		SZ4->Z4_QTD4FER := 0   //zerar quantidade do produto 4
		SZ4->(MsUnLock())
		
		//atualizacao das variaveis de memorias
		M->Z4_QTD4FER := 0
	EndIf             
	If lStatVal = "C" .And.lIpTodo
	   Loop
	EndIf   
	nPrcFecbF := 0
	If !Empty(M->Z4_FECHELE)	
		If Empty(M->Z4_QTDFECB)
			MsgBox("A quantidade estแ zerada [Batente]"+Chr(13)+Chr(10)+"Informar a quantidade na pasta Batente","Fechadura El้trica","ALERT")
			Return(.F.)
		EndIf
		If Empty(M->Z4_TESBAT)
			MsgBox("O TES nใo foi informado [Batente]"+Chr(13)+Chr(10)+"Informar o TES na pasta Batente","Fechadura El้trica","ALERT")
			Return(.F.)
		EndIf
		If M->Z4_FECHELE != SZ0->Z0_FECHELE
		   lIpOk := .F.
		   DbSelectArea("SC6")
           DbSetOrder(1)
           If DbSeek(xFilial("SC6")+SZ0->Z0_PEDIDO)
         	  Do While !Eof().And.SC6->C6_NUM=SZ0->Z0_PEDIDO
		         If AllTrim(SC6->C6_XFICTEC) = "Z0_FECHELE"
		            lIpOk := .T.
		         EndIf
		         DbSkip()   
		      EndDo
		   EndIf       
		   If !lIpOk
			  aAdd(aVerPrc1,{"Fechadura El้trica [Batente]",0,0,0})	
		   EndIf   
		   nPrcFechF := VerPrc1("Fechadura El้trica [Batente]",M->Z4_FECHELE,M->Z4_QTDFECB,SZ0->Z0_FECHELE,SZ0->Z0_QTDFECB,nPrcFecbP)  //alteracao de produto e eh necessario avaliar
		EndIf
	Else              
		RecLock("SZ4",.F.)
		SZ4->Z4_QTDFECB := 0    //zerar quantidade da fechadura
		SZ4->(MsUnLock())
		
		//atualizacao das variaveis de memorias
		M->Z4_QTDFECB := 0
	EndIf             
	If lStatVal = "C" .And.lIpTodo
	   Loop
	EndIf   
	If Empty(AllTrim(M->Z4_PRD1FER+M->Z4_PRD3FER+M->Z4_PRD3FER+M->Z4_PRD4FER))
		RecLock("SZ4",.F.)
		SZ4->Z4_TESFER := "   "  //limpar conteudo do TES
		SZ4->(MsUnLock())
		
		//atualizacao das variaveis de memorias
		M->Z4_TESFER := "   "
	EndIf              
    lIpTodo := .T.
EndDo

lRet := If(lStatVal$"O.C.I",.T.,.F.)      
If lRet 
   M->Z4_PRCMOLA := nPrcMolaF
   M->Z4_PRCOLHO := nPrcOlhoF
   M->Z4_PRCFECH := nPrcFechF
   M->Z4_PRCCIL1 := nPrcCil1F
   M->Z4_PRCROSE := nPrcRoseF
   M->Z4_PRC1FER := nPrc1FerF
   M->Z4_PRC2FER := nPrc2FerF
   M->Z4_PRC3FER := nPrc3FerF
   M->Z4_PRC4FER := nPrc4FerF     
   If lStatVal = "C"
      M->Z4_STATALT := "C"
   Else                   
      M->Z4_STATALT := "P"
   EndIf        
EndIf   

//RestArea(aArea_SC5)
RestArea(aArea_Atual)

Return lRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณIncEmp    บAutor  ณAlexandre Martins   บ Data ณ  01/04/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณInclui um empenho atraves de rotina automatica.             บฑฑ
ฑฑศออออออdออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function IncEmp(c_cod, cLocal, ctrt)

lMsHelpAuto := .T.
lMSErroAuto := .F.

aMata380:= {}
aadd(aMata380,{"D4_COD"		,c_cod 			,NIL}) // Produto
aadd(aMata380,{"D4_LOCAL"	,cLocal       	,NIL}) // Armazem
aadd(aMata380,{"D4_OP"		,SC2->(C2_NUM+C2_ITEM+C2_SEQUEN) ,NIL}) // OP
aadd(aMata380,{"D4_DATA"	,dDataBase    	,NIL}) // Data do empenho
aadd(aMata380,{"D4_QTDEORI"	,SC6->C6_QTDVEN	,NIL}) // Quantidade do Empenho
aadd(aMata380,{"D4_QUANT"	,SC6->C6_QTDVEN	,NIL}) // Saldo do Empenho
aadd(aMata380,{"D4_TRT"		,ctrt			,NIL}) // Saldo do Empenho
aadd(aMata380,{"D4_XPEDFT"	,SZ0->(Z0_PEDIDO+Z0_ITEM),NIL}) // Saldo do Empenho

msExecAuto({|x,y|MATA380(x,y)},aMata380,3)

If lMSErroAuto
	DisarmTransaction()
	Mostraerro()
	Break
EndIf

Return




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณExcEmp    บAutor  ณAlexandre Sousa     บ Data ณ  03/04/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณExclui os empenhos gerados contra a OP.                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ExcEmp()

Local a_area := SD4->(GetArea())

lMsHelpAuto := .T.
lMSErroAuto := .F.

aMata380:= {}
aadd(aMata380,{"D4_COD"		,SD4->D4_COD	,NIL}) // Produto
aadd(aMata380,{"D4_LOCAL"	,SD4->D4_LOCAL 	,NIL}) // Armazem
aadd(aMata380,{"D4_OP"		,SD4->D4_OP		,NIL}) // OP
aadd(aMata380,{"D4_DATA"	,SD4->D4_DATA  	,NIL}) // Data do empenho
aadd(aMata380,{"D4_QTDEORI"	,SD4->D4_QTDEORI,NIL}) // Quantidade do Empenho
aadd(aMata380,{"D4_QUANT"	,SD4->D4_QUANT	,NIL}) // Saldo do Empenho
aadd(aMata380,{"D4_TRT"		,SD4->D4_TRT	,NIL}) // Saldo do Empenho
aadd(aMata380,{"D4_XPEDFT"	,SD4->D4_XPEDFT	,NIL}) // Saldo do Empenho

msExecAuto({|x,y|MATA380(x,y)},aMata380,5)

If lMSErroAuto
	DisarmTransaction()
	Mostraerro()
	Break
EndIf

RestArea(a_area)

Return





/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMFATA012  บAutor  ณMicrosiga           บ Data ณ  06/18/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณVisualizar - Todas as alteracoes solicitadas.               บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function MFATA12c()        //visualizar

c_Query := "SELECT CASE WHEN Z4_STATALT = 'P' THEN 'Altera็ใo Pendente' "
c_Query += "            WHEN Z4_STATALT = 'C' THEN 'Pend๊ncia de Cr้dito' "
c_Query += "            WHEN Z4_STATALT = 'A' THEN 'Altera็ใo Aprovada' "
c_Query += "            WHEN Z4_STATALT = 'R' THEN 'Altera็ใo Rejeitada' "
c_Query += "            WHEN Z4_STATALT = '1' THEN 'Cr้dito Aprovado' "
c_Query += "            WHEN Z4_STATALT = '0' THEN 'Cr้dito Rejeitado' "
c_Query += "            ELSE 'NORMAL' END as STATUSFT, "
c_Query += "       Z4_PEDIDO+' / '+Z4_ITEM AS CHAVE, "
c_Query += "       Convert(VarChar(10),Cast(Z4_DATAALT as DateTime),103) AS DATAALT,
c_Query += "       R_E_C_N_O_ AS REG, * "
c_Query += "FROM "+RetSqlName('SZ4')+" "
c_Query += "WHERE Z4_PEDIDO = '"+SZ0->Z0_PEDIDO+"' and Z4_ITEM = '"+SZ0->Z0_ITEM+"' and D_E_L_E_T_ = '' "
c_Query += "ORDER BY R_E_C_N_O_

a_campos := {{"Data Alt.", "Pedido / Item", "Status","Produto","Descri็ใo","Registro"}, {"DATAALT", "CHAVE", "STATUSFT","Z4_MODELO","Z4_DESCMOD","REG"}}
c_tit := "Vizualiza็๕es das Altera็๕es"
cRet := U_FGEN008c(c_Query, a_campos, c_tit, 6)

//If type('c_Ret') <> 'C'
//	Return
//EndIf

cR := cRet

If type('cR') <> 'N'
	Return
EndIf

//cPedido := Substr(cRet,1,6)
//cItem   := Substr(cRet,10,2)

DbSelectArea('SZ4')
//DbSetOrder(1) //Z4_FILIAL, Z4_PEDIDO, Z4_ITEM, Z4_DATAALT, R_E_C_N_O_, D_E_L_E_T_
//If DbSeek(xFilial('SZ4')+cPedido+cItem)
AxVisual('SZ4', SZ4->(DbGoTo(cRet)), 2)
//EndIf

Return





/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMFATA012d บAutor  ณMicrosiga           บ Data ณ  06/18/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRealiza a aprovacao da Alteracao na ficha tecnica.          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function MFATA12d()
Local c_Query
Local cRet
Local cPedido
Local cItem
Local cCli
Local cLoja
Local cUltItem
Local lIpOk


If SZ0->Z0_STATALT <> 'P'.And.SZ0->Z0_STATALT <> '1'
	MsgBox('Ficha T้cnica nใo tem pend๊ncia de altera็ใo ou aprova็ใo pelo Cr้dito',"Ficha T้cnica","ALERT")
	Return
EndIf

DbSelectArea('SZ4')
DbSetOrder(1) //Z4_FILIAL, Z4_PEDIDO, Z4_ITEM, Z4_DATAALT, R_E_C_N_O_, D_E_L_E_T_
If DbSeek(xFilial('SZ4')+SZ0->Z0_PEDIDO+SZ0->Z0_ITEM)
	lStatPnd := .F.  //alteracao pendente
	Do While !Eof().And.SZ0->Z0_PEDIDO+SZ0->Z0_ITEM = SZ4->Z4_PEDIDO+SZ4->Z4_ITEM
		If SZ4->Z4_STATALT $ "P.1"
			lStatPnd := .T.
			Exit
		EndIf
		DbSkip()
	EndDo
	If !lStatPnd   //.T., alteracao pendente
		Msgbox("Ficha t้cnica inconsistente [SZ0 vs SZ4]. Verificar","Ficha T้cncia","ALERT")
		Return(.T.)
	EndIf
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณVerifica se os empenhos ja foram gerados alguma vez.   ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If !Empty(SZ0->Z0_STATUS)
		MsgBox("Os empenhos dessa ficha t้cnica jแ foram gerados! ", "Ficha Tecnica","ALERT")
		Return
	EndIf
	
	//	If !MsgBox("Estas preste a aprovar a altera็ใo desta Ficha T้cnica. Deseja APROVAR a altera็ใo desta Ficha T้cnica ?","Ficha T้cnica","YESNO")
	If AxVisual('SZ4', SZ4->(Recno()), 2) != 1
		Return
	EndIf
	
	RecLock('SZ4', .F.)
	SZ4->Z4_STATALT := 'A'   //alteracao aprovada
	SZ4->(MsUnLock())
	
	RecLock('SZ0', .F.)
	DbSelectArea('SX3')
	DbSetOrder(1)
	DbSeek('SZ0')
	Do While !Eof().And.SX3->X3_ARQUIVO = 'SZ0'
		If SX3->X3_CONTEXT <> 'V' .And. SX3->X3_CAMPO <> 'Z0_STATALT' .And. SX3->X3_CAMPO <> 'Z0_STATUS'
		   SZ0->(&(SX3->X3_CAMPO)) := SZ4->(&("Z4"+SubStr(SX3->X3_CAMPO,3,15)))
		EndIf
		DbSkip()
    EndDo		   
                   
    DbSelectArea("SC6")
    DbSetOrder(1)
    DbSeek(xFilial("SC6")+SZ0->Z0_PEDIDO)
    Do While !Eof().And.SZ0->Z0_PEDIDO = SC6->C6_NUM
       cC6_FT := AllTrim(SC6->C6_XFICTEC)
       If !Empty(cC6_FT)
	      Do Case                                                                      
	         Case cC6_FT = "Z0_MOLAA"
	              RecLock("SC6",.F.)
	              If !Empty(SZ0->Z0_MOLAA).And.!Empty(SZ0->Z0_QTDMOLA)
	                 SC6->C6_PRODUTO := SZ0->Z0_MOLAA
	                 SC6->C6_QTDVEN  := SZ0->Z0_QTDMOLA
	                 SC6->C6_PRCVEN  := If(Empty(SZ0->Z0_PRCMOLA),SC6->C6_PRCVEN,SZ0->Z0_PRCMOLA)
	                 SC6->C6_VALOR   := SC6->C6_QTDVEN*SC6->C6_PRCVEN
	                 SC6->C6_TES     := SZ0->Z0_TESACES
	              Else
	                 DbDelete()                 
	              EndIf      
	              SC6->(MsUnLock())	                 
	         Case cC6_FT = "Z0_OLHOM"
	              RecLock("SC6",.F.)            
	              If !Empty(SZ0->Z0_OLHOM).And.!Empty(SZ0->Z0_QTDOLHO)
	                 SC6->C6_PRODUTO := SZ0->Z0_OLHOM
		             SC6->C6_QTDVEN  := SZ0->Z0_QTDOLHO
		             SC6->C6_PRCVEN  := If(Empty(SZ0->Z0_PRCOLHO),SC6->C6_PRCVEN,SZ0->Z0_PRCOLHO)
		             SC6->C6_VALOR   := SC6->C6_QTDVEN*SC6->C6_PRCVEN
		             SC6->C6_TES     := SZ0->Z0_TESACES
		          Else
	                 DbDelete()
	              EndIf      
	              SC6->(MsUnLock())	                 
             Case cC6_FT = "Z0_FECHAD"
                  RecLock("SC6",.F.)
                  If !Empty(SZ0->Z0_FECHAD).And.!Empty(SZ0->Z0_QTDFECH)
                     SC6->C6_PRODUTO := SZ0->Z0_FECHAD
		             SC6->C6_QTDVEN  := SZ0->Z0_QTDFECH
		             SC6->C6_PRCVEN  := If(Empty(SZ0->Z0_PRCFECH),SC6->C6_PRCVEN,SZ0->Z0_PRCFECH)
		             SC6->C6_VALOR   := SC6->C6_QTDVEN*SC6->C6_PRCVEN
		             SC6->C6_TES     := SZ0->Z0_TESACES
		          Else
	                 DbDelete()
	              EndIf      
	              SC6->(MsUnLock())	                 
             Case cC6_FT = "Z0_CILACES"
                  RecLock("SC6",.F.)
                  If !Empty(SZ0->Z0_CILACES).And.!Empty(SZ0->Z0_QTDCIL1)
                     SC6->C6_PRODUTO := SZ0->Z0_CILACES
		             SC6->C6_QTDVEN  := SZ0->Z0_QTDCIL1
		             SC6->C6_PRCVEN  := If(Empty(SZ0->Z0_PRCCIL1),SC6->C6_PRCVEN,SZ0->Z0_PRCCIL1)
		             SC6->C6_VALOR   := SC6->C6_QTDVEN*SC6->C6_PRCVEN
		             SC6->C6_TES     := SZ0->Z0_TESACES
		          Else
	                 DbDelete()
	              EndIf      
	              SC6->(MsUnLock())	                 
	         Case cC6_FT = "Z0_ROSACES" 
	              RecLock("SC6",.F.)
	              If !Empty(SZ0->Z0_ROSACES).And.!Empty(SZ0->Z0_QTDROSE)
	                 SC6->C6_PRODUTO := SZ0->Z0_ROSACES
		             SC6->C6_QTDVEN  := SZ0->Z0_QTDROSE
		             SC6->C6_PRCVEN  := If(Empty(SZ0->Z0_PRCROSE),SC6->C6_PRCVEN,SZ0->Z0_PRCROSE)
		             SC6->C6_VALOR   := SC6->C6_QTDVEN*SC6->C6_PRCVEN
		             SC6->C6_TES     := SZ0->Z0_TESACES
		          Else
	                 DbDelete()
	              EndIf      
	              SC6->(MsUnLock())	                 
             Case cC6_FT = "Z0_PRD1FER"                                  
                  RecLock("SC6",.F.)
                  If !Empty(SZ0->Z0_PRD1FER).And.!Empty(SZ0->Z0_QTD1FER)
                     SC6->C6_PRODUTO := SZ0->Z0_PRD1FER
		             SC6->C6_QTDVEN  := SZ0->Z0_QTD1FER
		             SC6->C6_PRCVEN  := If(Empty(SZ0->Z0_PRC1FER),SC6->C6_PRCVEN,SZ0->Z0_PRC1FER)
		             SC6->C6_VALOR   := SC6->C6_QTDVEN*SC6->C6_PRCVEN
		             SC6->C6_TES     := SZ0->Z0_TESFER
		          Else
	                 DbDelete()
	              EndIf      
	              SC6->(MsUnLock())	                 
	         Case cC6_FT = "Z0_PRD2FER"             
	              RecLock("SC6",.F.)
	              If !Empty(SZ0->Z0_PRD2FER).And.!Empty(SZ0->Z0_QTD2FER)
	                 SC6->C6_PRODUTO := SZ0->Z0_PRD2FER
		             SC6->C6_QTDVEN  := SZ0->Z0_QTD2FER 
		             SC6->C6_PRCVEN  := If(Empty(SZ0->Z0_PRC2FER),SC6->C6_PRCVEN,SZ0->Z0_PRC2FER)
		             SC6->C6_VALOR   := SC6->C6_QTDVEN*SC6->C6_PRCVEN
		             SC6->C6_TES     := SZ0->Z0_TESFER
		          Else
	                 DbDelete()
	              EndIf        
	              SC6->(MsUnLock())	                 
	         Case cC6_FT = "Z0_PRD3FER"
	              RecLock("SC6",.F.)
	              If !Empty(SZ0->Z0_PRD3FER).And.!Empty(SZ0->Z0_QTD3FER)
	                 SC6->C6_PRODUTO := SZ0->Z0_PRD3FER
		             SC6->C6_QTDVEN  := SZ0->Z0_QTD3FER
		             SC6->C6_PRCVEN  := If(Empty(SZ0->Z0_PRC3FER),SC6->C6_PRCVEN,SZ0->Z0_PRC3FER)
		             SC6->C6_VALOR   := SC6->C6_QTDVEN*SC6->C6_PRCVEN
		             SC6->C6_TES     := SZ0->Z0_TESFER
		          Else
	                 DbDelete()
	              EndIf      
	              SC6->(MsUnLock())	                 
		     Case cC6_FT = "Z0_PRD4FER"
		          RecLock("SC6",.F.)
		          If !Empty(SZ0->Z0_PRD4FER).And.!Empty(SZ0->Z0_QTD4FER)
		             SC6->C6_PRODUTO := SZ0->Z0_PRD4FER
		             SC6->C6_QTDVEN  := SZ0->Z0_QTD4FER
		             SC6->C6_PRCVEN  := If(Empty(SZ0->Z0_PRC4FER),SC6->C6_PRCVEN,SZ0->Z0_PRC4FER)
		             SC6->C6_VALOR   := SC6->C6_QTDVEN*SC6->C6_PRCVEN
		             SC6->C6_TES     := SZ0->Z0_TESFER
		          Else
	                 DbDelete()
	              EndIf        
	              SC6->(MsUnLock())	                 
	         Case cC6_FT = "Z0_FECHELE"
                  RecLock("SC6",.F.)
                  If !Empty(SZ0->Z0_FECHELE).And.!Empty(SZ0->Z0_QTDFECB)
                     SC6->C6_PRODUTO := SZ0->Z0_FECHELE
		             SC6->C6_QTDVEN  := SZ0->Z0_QTDFECB
		             SC6->C6_PRCVEN  := If(Empty(SZ0->Z0_PRCFECB),SC6->C6_PRCVEN,SZ0->Z0_PRCFECB)
		             SC6->C6_VALOR   := SC6->C6_QTDVEN*SC6->C6_PRCVEN
		             SC6->C6_TES     := SZ0->Z0_TESBAT
		          Else
	                 DbDelete()
	              EndIf      
	              SC6->(MsUnLock())	                      
	      EndCase       		 
       EndIf           
       DbSelectArea("SC6")
       DbSkip()
    EndDo                                         
    
    If !Empty(SZ0->Z0_MOLAA)
       lIpOk := .F.                      
       DbSelectArea("SC6")
       DbSetOrder(1)
       DbSeek(xFilial("SC6")+SZ0->Z0_PEDIDO)
       Do While !Eof().And.SC6->C6_NUM=SZ0->Z0_PEDIDO
          If lIpOk := (AllTrim(SC6->C6_XFICTEC) == "Z0_MOLAA")             
             Exit
          EndIf  
          SC6->(DbSkip())
       EndDo
       If !lIpOk
          DbSelectArea("SC6")
          DbSetOrder(1)
          DbSeek(xFilial("SC6")+SZ0->Z0_PEDIDO)
          Do While !Eof().And.SC6->C6_NUM=SZ0->Z0_PEDIDO
             cUltItem := StrZero(Val(SC6->C6_ITEM)+1,2)
             cCli     := SC6->C6_CLI
             cLoja    := SC6->C6_LOJA
             DbSkip()
          EndDo      
          RecLock("SC6",.T.)                        
          SC6->C6_FILIAL  := xFilial("SC6")
          SC6->C6_NUM     := SZ0->Z0_PEDIDO
          SC6->C6_ITEM    := cUltItem
          SC6->C6_PRODUTO := SZ0->Z0_MOLAA
          SC6->C6_DESCRI  := GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+SZ0->Z0_MOLAA,1,"Produto nao encontrado")
          SC6->C6_UM      := GetAdvFVal("SB1","B1_TIPO",xFilial("SB1")+SZ0->Z0_MOLAA,1,"Produto nao encontrado")
          SC6->C6_QTDVEN  := SZ0->Z0_QTDMOLA
          SC6->C6_PRCVEN  := SZ0->Z0_PRCMOLA 
          SC6->C6_VALOR   := SZ0->Z0_QTDMOLA*SZ0->Z0_PRCMOLA
          SC6->C6_TES     := SZ0->Z0_TESACES
          SC6->C6_LOCAL   := GetAdvFVal("SB1","B1_LOCPAD",xFilial("SB1")+SZ0->Z0_MOLAA,1,"  ")
          SC6->C6_CF      := GetAdvFVal("SF4","F4_CF",xFilial("SF4")+SZ0->Z0_TESACES,1,"    ")
          SC6->C6_CLI     := cCli
          SC6->C6_LOJA    := cLoja
          SC6->C6_PRUNIT  := SZ0->Z0_PRCMOLA
          SC6->C6_XFICTEC := "Z0_MOLAA" 
       EndIf
    EndIf       
                
       
    If !Empty(SZ0->Z0_OLHOM)
       lIpOk := .F.    
       DbSelectArea("SC6")                  
       DbSetOrder(1)
       DbSeek(xFilial("SC6")+SZ0->Z0_PEDIDO)
       Do While !Eof().And.SC6->C6_NUM=SZ0->Z0_PEDIDO
          If lIpOk := (AllTrim(SC6->C6_XFICTEC) == "Z0_OLHOM")             
             Exit
          EndIf  
          SC6->(DbSkip())
       EndDo
       If !lIpOk
          DbSelectArea("SC6")
          DbSetOrder(1)
          DbSeek(xFilial("SC6")+SZ0->Z0_PEDIDO)
          Do While !Eof().And.SC6->C6_NUM=SZ0->Z0_PEDIDO
             cUltItem := StrZero(Val(SC6->C6_ITEM)+1,2)
             cCli     := SC6->C6_CLI
             cLoja    := SC6->C6_LOJA
             DbSkip()
          EndDo      
          RecLock("SC6",.T.)                        
          SC6->C6_FILIAL  := xFilial("SC6")
          SC6->C6_NUM     := SZ0->Z0_PEDIDO
          SC6->C6_ITEM    := cUltItem
          SC6->C6_PRODUTO := SZ0->Z0_OLHOM
          SC6->C6_DESCRI  := GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+SZ0->Z0_OLHOM,1,"Produto nao encontrado")
          SC6->C6_UM      := GetAdvFVal("SB1","B1_TIPO",xFilial("SB1")+SZ0->Z0_OLHOM,1,"Produto nao encontrado")
          SC6->C6_QTDVEN  := SZ0->Z0_QTDOLHO
          SC6->C6_PRCVEN  := SZ0->Z0_PRCOLHO 
          SC6->C6_VALOR   := SZ0->Z0_QTDOLHO*SZ0->Z0_PRCOLHO
          SC6->C6_TES     := SZ0->Z0_TESACES
          SC6->C6_LOCAL   := GetAdvFVal("SB1","B1_LOCPAD",xFilial("SB1")+SZ0->Z0_OLHOM,1,"  ")
          SC6->C6_CF      := GetAdvFVal("SF4","F4_CF",xFilial("SF4")+SZ0->Z0_TESACES,1,"    ")
          SC6->C6_CLI     := cCli
          SC6->C6_LOJA    := cLoja
          SC6->C6_PRUNIT  := SZ0->Z0_PRCOLHO
          SC6->C6_XFICTEC := "Z0_OLHOM" 
       EndIf
    EndIf       
    
    If !Empty(SZ0->Z0_FECHAD)
       lIpOk := .F.                      
       DbSelectArea("SC6")
       DbSetOrder(1)
       DbSeek(xFilial("SC6")+SZ0->Z0_PEDIDO)
       Do While !Eof().And.SC6->C6_NUM=SZ0->Z0_PEDIDO
          If lIpOk := (AllTrim(SC6->C6_XFICTEC) == "Z0_FECHAD")             
             Exit
          EndIf  
          SC6->(DbSkip())
       EndDo
       If !lIpOk
          DbSelectArea("SC6")
          DbSetOrder(1)
          DbSeek(xFilial("SC6")+SZ0->Z0_PEDIDO)
          Do While !Eof().And.SC6->C6_NUM=SZ0->Z0_PEDIDO
             cUltItem := StrZero(Val(SC6->C6_ITEM)+1,2)
             cCli     := SC6->C6_CLI
             cLoja    := SC6->C6_LOJA
             DbSkip()
          EndDo      
          RecLock("SC6",.T.)                        
          SC6->C6_FILIAL  := xFilial("SC6")
          SC6->C6_NUM     := SZ0->Z0_PEDIDO
          SC6->C6_ITEM    := cUltItem
          SC6->C6_PRODUTO := SZ0->Z0_FECHAD
          SC6->C6_DESCRI  := GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+SZ0->Z0_FECHAD,1,"Produto nao encontrado")
          SC6->C6_UM      := GetAdvFVal("SB1","B1_TIPO",xFilial("SB1")+SZ0->Z0_FECHAD,1,"Produto nao encontrado")
          SC6->C6_QTDVEN  := SZ0->Z0_QTDFECH
          SC6->C6_PRCVEN  := SZ0->Z0_PRCFECH 
          SC6->C6_VALOR   := SZ0->Z0_QTDFECH*SZ0->Z0_PRCFECH
          SC6->C6_TES     := SZ0->Z0_TESACES
          SC6->C6_LOCAL   := GetAdvFVal("SB1","B1_LOCPAD",xFilial("SB1")+SZ0->Z0_FECHAD,1,"  ")
          SC6->C6_CF      := GetAdvFVal("SF4","F4_CF",xFilial("SF4")+SZ0->Z0_TESACES,1,"    ")
          SC6->C6_CLI     := cCli
          SC6->C6_LOJA    := cLoja
          SC6->C6_PRUNIT  := SZ0->Z0_PRCFECH
          SC6->C6_XFICTEC := "Z0_FECHAD" 
       EndIf
    EndIf       
    
    If !Empty(SZ0->Z0_CILACES)
       lIpOk := .F.                         
       DbSelectArea("SC6")
       DbSetOrder(1)
       DbSeek(xFilial("SC6")+SZ0->Z0_PEDIDO)
       Do While !Eof().And.SC6->C6_NUM=SZ0->Z0_PEDIDO
          If lIpOk := (AllTrim(SC6->C6_XFICTEC) == "Z0_CILACES")             
             Exit
          EndIf  
          SC6->(DbSkip())
       EndDo
       If !lIpOk
          DbSelectArea("SC6")
          DbSetOrder(1)
          DbSeek(xFilial("SC6")+SZ0->Z0_PEDIDO)
          Do While !Eof().And.SC6->C6_NUM=SZ0->Z0_PEDIDO
             cUltItem := StrZero(Val(SC6->C6_ITEM)+1,2)
             cCli     := SC6->C6_CLI
             cLoja    := SC6->C6_LOJA
             DbSkip()
          EndDo      
          RecLock("SC6",.T.)                        
          SC6->C6_FILIAL  := xFilial("SC6")
          SC6->C6_NUM     := SZ0->Z0_PEDIDO
          SC6->C6_ITEM    := cUltItem
          SC6->C6_PRODUTO := SZ0->Z0_CILACES
          SC6->C6_DESCRI  := GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+SZ0->Z0_CILACES,1,"Produto nao encontrado")
          SC6->C6_UM      := GetAdvFVal("SB1","B1_TIPO",xFilial("SB1")+SZ0->Z0_CILACES,1,"Produto nao encontrado")
          SC6->C6_QTDVEN  := SZ0->Z0_QTDCIL1
          SC6->C6_PRCVEN  := SZ0->Z0_PRCCIL1 
          SC6->C6_VALOR   := SZ0->Z0_QTDCIL1*SZ0->Z0_PRCCIL1
          SC6->C6_TES     := SZ0->Z0_TESACES
          SC6->C6_LOCAL   := GetAdvFVal("SB1","B1_LOCPAD",xFilial("SB1")+SZ0->Z0_CILACES,1,"  ")
          SC6->C6_CF      := GetAdvFVal("SF4","F4_CF",xFilial("SF4")+SZ0->Z0_TESACES,1,"    ")
          SC6->C6_CLI     := cCli
          SC6->C6_LOJA    := cLoja
          SC6->C6_PRUNIT  := SZ0->Z0_PRCCIL1
          SC6->C6_XFICTEC := "Z0_CILACES" 
       EndIf
    EndIf       
    
    If !Empty(SZ0->Z0_ROSACES)
       lIpOk := .F.                      
       DbSelectArea("SC6")
       DbSetOrder(1)
       DbSeek(xFilial("SC6")+SZ0->Z0_PEDIDO)
       Do While !Eof().And.SC6->C6_NUM=SZ0->Z0_PEDIDO
          If lIpOk := (AllTrim(SC6->C6_XFICTEC) == "Z0_ROSACES")             
             Exit
          EndIf  
          SC6->(DbSkip())
       EndDo
       If !lIpOk
          DbSelectArea("SC6")
          DbSetOrder(1)
          DbSeek(xFilial("SC6")+SZ0->Z0_PEDIDO)
          Do While !Eof().And.SC6->C6_NUM=SZ0->Z0_PEDIDO
             cUltItem := StrZero(Val(SC6->C6_ITEM)+1,2)
             cCli     := SC6->C6_CLI
             cLoja    := SC6->C6_LOJA
             DbSkip()
          EndDo      
          RecLock("SC6",.T.)                        
          SC6->C6_FILIAL  := xFilial("SC6")
          SC6->C6_NUM     := SZ0->Z0_PEDIDO
          SC6->C6_ITEM    := cUltItem
          SC6->C6_PRODUTO := SZ0->Z0_ROSACES
          SC6->C6_DESCRI  := GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+SZ0->Z0_ROSACES,1,"Produto nao encontrado")
          SC6->C6_UM      := GetAdvFVal("SB1","B1_TIPO",xFilial("SB1")+SZ0->Z0_ROSACES,1,"Produto nao encontrado")
          SC6->C6_QTDVEN  := SZ0->Z0_QTDROSE
          SC6->C6_PRCVEN  := SZ0->Z0_PRCROSE 
          SC6->C6_VALOR   := SZ0->Z0_QTDROSE*SZ0->Z0_PRCROSE
          SC6->C6_TES     := SZ0->Z0_TESACES
          SC6->C6_LOCAL   := GetAdvFVal("SB1","B1_LOCPAD",xFilial("SB1")+SZ0->Z0_ROSACES,1,"  ")
          SC6->C6_CF      := GetAdvFVal("SF4","F4_CF",xFilial("SF4")+SZ0->Z0_TESACES,1,"    ")
          SC6->C6_CLI     := cCli
          SC6->C6_LOJA    := cLoja
          SC6->C6_PRUNIT  := SZ0->Z0_PRCROSE
          SC6->C6_XFICTEC := "Z0_ROSACES" 
       EndIf
    EndIf       
    
    If !Empty(SZ0->Z0_PRD1FER)
       lIpOk := .F.                         
       DbSelectArea("SC6")
       DbSetOrder(1)
       DbSeek(xFilial("SC6")+SZ0->Z0_PEDIDO)
       Do While !Eof().And.SC6->C6_NUM=SZ0->Z0_PEDIDO
          If lIpOk := (AllTrim(SC6->C6_XFICTEC) == "Z0_PRD1FER")             
             Exit
          EndIf  
          SC6->(DbSkip())
       EndDo
       If !lIpOk
          DbSelectArea("SC6")
          DbSetOrder(1)
          DbSeek(xFilial("SC6")+SZ0->Z0_PEDIDO)
          Do While !Eof().And.SC6->C6_NUM=SZ0->Z0_PEDIDO
             cUltItem := StrZero(Val(SC6->C6_ITEM)+1,2)
             cCli     := SC6->C6_CLI
             cLoja    := SC6->C6_LOJA
             DbSkip()
          EndDo      
          RecLock("SC6",.T.)                        
          SC6->C6_FILIAL  := xFilial("SC6")
          SC6->C6_NUM     := SZ0->Z0_PEDIDO
          SC6->C6_ITEM    := cUltItem
          SC6->C6_PRODUTO := SZ0->Z0_PRD1FER
          SC6->C6_DESCRI  := GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+SZ0->Z0_PRD1FER,1,"Produto nao encontrado")
          SC6->C6_UM      := GetAdvFVal("SB1","B1_TIPO",xFilial("SB1")+SZ0->Z0_PRD1FER,1,"Produto nao encontrado")
          SC6->C6_QTDVEN  := SZ0->Z0_QTD1FER
          SC6->C6_PRCVEN  := SZ0->Z0_PRC1FER 
          SC6->C6_VALOR   := SZ0->Z0_QTD1FER*SZ0->Z0_PRC1FER
          SC6->C6_TES     := SZ0->Z0_TESFER
          SC6->C6_LOCAL   := GetAdvFVal("SB1","B1_LOCPAD",xFilial("SB1")+SZ0->Z0_PRD1FER,1,"  ")
          SC6->C6_CF      := GetAdvFVal("SF4","F4_CF",xFilial("SF4")+SZ0->Z0_TESACES,1,"    ")
          SC6->C6_CLI     := cCli
          SC6->C6_LOJA    := cLoja
          SC6->C6_PRUNIT  := SZ0->Z0_PRC1FER
          SC6->C6_XFICTEC := "Z0_PRD1FER" 
       EndIf
    EndIf       
    
    If !Empty(SZ0->Z0_PRD2FER)
       lIpOk := .F.                         
       DbSelectArea("SC6")
       DbSetOrder(1)
       DbSeek(xFilial("SC6")+SZ0->Z0_PEDIDO)
       Do While !Eof().And.SC6->C6_NUM=SZ0->Z0_PEDIDO
          If lIpOk := (AllTrim(SC6->C6_XFICTEC) == "Z0_PRD2FER")             
             Exit
          EndIf  
          SC6->(DbSkip())
       EndDo
       If !lIpOk
          DbSelectArea("SC6")
          DbSetOrder(1)
          DbSeek(xFilial("SC6")+SZ0->Z0_PEDIDO)
          Do While !Eof().And.SC6->C6_NUM=SZ0->Z0_PEDIDO
             cUltItem := StrZero(Val(SC6->C6_ITEM)+1,2)
             cCli     := SC6->C6_CLI
             cLoja    := SC6->C6_LOJA
             DbSkip()
          EndDo      
          RecLock("SC6",.T.)                        
          SC6->C6_FILIAL  := xFilial("SC6")
          SC6->C6_NUM     := SZ0->Z0_PEDIDO
          SC6->C6_ITEM    := cUltItem
          SC6->C6_PRODUTO := SZ0->Z0_PRD2FER
          SC6->C6_DESCRI  := GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+SZ0->Z0_PRD2FER,1,"Produto nao encontrado")
          SC6->C6_UM      := GetAdvFVal("SB1","B1_TIPO",xFilial("SB1")+SZ0->Z0_PRD2FER,1,"Produto nao encontrado")
          SC6->C6_QTDVEN  := SZ0->Z0_QTD2FER
          SC6->C6_PRCVEN  := SZ0->Z0_PRC2FER 
          SC6->C6_VALOR   := SZ0->Z0_QTD2FER*SZ0->Z0_PRC2FER
          SC6->C6_TES     := SZ0->Z0_TESFER
          SC6->C6_LOCAL   := GetAdvFVal("SB1","B1_LOCPAD",xFilial("SB1")+SZ0->Z0_PRD2FER,1,"  ")
          SC6->C6_CF      := GetAdvFVal("SF4","F4_CF",xFilial("SF4")+SZ0->Z0_TESACES,1,"    ")
          SC6->C6_CLI     := cCli
          SC6->C6_LOJA    := cLoja
          SC6->C6_PRUNIT  := SZ0->Z0_PRC2FER
          SC6->C6_XFICTEC := "Z0_PRD2FER" 
       EndIf
    EndIf       
    
                                     
    If !Empty(SZ0->Z0_PRD3FER)
       lIpOk := .F.                         
       DbSelectArea("SC6")
       DbSetOrder(1)
       DbSeek(xFilial("SC6")+SZ0->Z0_PEDIDO)
       Do While !Eof().And.SC6->C6_NUM=SZ0->Z0_PEDIDO
          If lIpOk := (AllTrim(SC6->C6_XFICTEC) == "Z0_PRD3FER")             
             Exit
          EndIf  
          SC6->(DbSkip())
       EndDo
       If !lIpOk
          DbSelectArea("SC6")
          DbSetOrder(1)
          DbSeek(xFilial("SC6")+SZ0->Z0_PEDIDO)
          Do While !Eof().And.SC6->C6_NUM=SZ0->Z0_PEDIDO
             cUltItem := StrZero(Val(SC6->C6_ITEM)+1,2)
             cCli     := SC6->C6_CLI
             cLoja    := SC6->C6_LOJA
             DbSkip()
          EndDo      
          RecLock("SC6",.T.)                        
          SC6->C6_FILIAL  := xFilial("SC6")
          SC6->C6_NUM     := SZ0->Z0_PEDIDO
          SC6->C6_ITEM    := cUltItem
          SC6->C6_PRODUTO := SZ0->Z0_PRD3FER
          SC6->C6_DESCRI  := GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+SZ0->Z0_PRD3FER,1,"Produto nao encontrado")
          SC6->C6_UM      := GetAdvFVal("SB1","B1_TIPO",xFilial("SB1")+SZ0->Z0_PRD3FER,1,"Produto nao encontrado")
          SC6->C6_QTDVEN  := SZ0->Z0_QTD3FER
          SC6->C6_PRCVEN  := SZ0->Z0_PRC3FER 
          SC6->C6_VALOR   := SZ0->Z0_QTD3FER*SZ0->Z0_PRC3FER
          SC6->C6_TES     := SZ0->Z0_TESFER
          SC6->C6_LOCAL   := GetAdvFVal("SB1","B1_LOCPAD",xFilial("SB1")+SZ0->Z0_PRD3FER,1,"  ")
          SC6->C6_CF      := GetAdvFVal("SF4","F4_CF",xFilial("SF4")+SZ0->Z0_TESACES,1,"    ")
          SC6->C6_CLI     := cCli
          SC6->C6_LOJA    := cLoja
          SC6->C6_PRUNIT  := SZ0->Z0_PRC3FER
          SC6->C6_XFICTEC := "Z0_PRD3FER" 
       EndIf
    EndIf       
    
    If !Empty(SZ0->Z0_PRD4FER)
       lIpOk := .F.                         
       DbSelectArea("SC6")
       DbSetOrder(1)
       DbSeek(xFilial("SC6")+SZ0->Z0_PEDIDO)
       Do While !Eof().And.SC6->C6_NUM=SZ0->Z0_PEDIDO
          If lIpOk := (AllTrim(SC6->C6_XFICTEC) == "Z0_PRD4FER")             
             Exit
          EndIf  
          SC6->(DbSkip())
       EndDo
       If !lIpOk
          DbSelectArea("SC6")
          DbSetOrder(1)
          DbSeek(xFilial("SC6")+SZ0->Z0_PEDIDO)
          Do While !Eof().And.SC6->C6_NUM=SZ0->Z0_PEDIDO
             cUltItem := StrZero(Val(SC6->C6_ITEM)+1,2)
             cCli     := SC6->C6_CLI
             cLoja    := SC6->C6_LOJA
             DbSkip()
          EndDo      
          RecLock("SC6",.T.)                        
          SC6->C6_FILIAL  := xFilial("SC6")
          SC6->C6_NUM     := SZ0->Z0_PEDIDO
          SC6->C6_ITEM    := cUltItem
          SC6->C6_PRODUTO := SZ0->Z0_PRD4FER
          SC6->C6_DESCRI  := GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+SZ0->Z0_PRD4FER,1,"Produto nao encontrado")
          SC6->C6_UM      := GetAdvFVal("SB1","B1_TIPO",xFilial("SB1")+SZ0->Z0_PRD4FER,1,"Produto nao encontrado")
          SC6->C6_QTDVEN  := SZ0->Z0_QTD4FER
          SC6->C6_PRCVEN  := SZ0->Z0_PRC4FER 
          SC6->C6_VALOR   := SZ0->Z0_QTD4FER*SZ0->Z0_PRC4FER
          SC6->C6_TES     := SZ0->Z0_TESFER
          SC6->C6_LOCAL   := GetAdvFVal("SB1","B1_LOCPAD",xFilial("SB1")+SZ0->Z0_PRD4FER,1,"  ")
          SC6->C6_CF      := GetAdvFVal("SF4","F4_CF",xFilial("SF4")+SZ0->Z0_TESACES,1,"    ")
          SC6->C6_CLI     := cCli
          SC6->C6_LOJA    := cLoja
          SC6->C6_PRUNIT  := SZ0->Z0_PRC4FER
          SC6->C6_XFICTEC := "Z0_PRD4FER" 
       EndIf
    EndIf       
    
    If !Empty(SZ0->Z0_FECHELE)
       lIpOk := .F.                      
       DbSelectArea("SC6")
       DbSetOrder(1)
       DbSeek(xFilial("SC6")+SZ0->Z0_PEDIDO)
       Do While !Eof().And.SC6->C6_NUM=SZ0->Z0_PEDIDO
          If lIpOk := (AllTrim(SC6->C6_XFICTEC) == "Z0_FECHELE")             
             Exit
          EndIf  
          SC6->(DbSkip())
       EndDo
       If !lIpOk
          DbSelectArea("SC6")
          DbSetOrder(1)
          DbSeek(xFilial("SC6")+SZ0->Z0_PEDIDO)
          Do While !Eof().And.SC6->C6_NUM=SZ0->Z0_PEDIDO
             cUltItem := StrZero(Val(SC6->C6_ITEM)+1,2)
             cCli     := SC6->C6_CLI
             cLoja    := SC6->C6_LOJA
             DbSkip()
          EndDo      
          RecLock("SC6",.T.)                        
          SC6->C6_FILIAL  := xFilial("SC6")
          SC6->C6_NUM     := SZ0->Z0_PEDIDO
          SC6->C6_ITEM    := cUltItem
          SC6->C6_PRODUTO := SZ0->Z0_FECHELE
          SC6->C6_DESCRI  := GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+SZ0->Z0_FECHELE,1,"Produto nao encontrado")
          SC6->C6_UM      := GetAdvFVal("SB1","B1_TIPO",xFilial("SB1")+SZ0->Z0_FECHELE,1,"Produto nao encontrado")
          SC6->C6_QTDVEN  := SZ0->Z0_QTDFECB
          SC6->C6_PRCVEN  := SZ0->Z0_PRCFECB 
          SC6->C6_VALOR   := SZ0->Z0_QTDFECB*SZ0->Z0_PRCFECB
          SC6->C6_TES     := SZ0->Z0_TESBAT
          SC6->C6_LOCAL   := GetAdvFVal("SB1","B1_LOCPAD",xFilial("SB1")+SZ0->Z0_FECHELE,1,"  ")
          SC6->C6_CF      := GetAdvFVal("SF4","F4_CF",xFilial("SF4")+SZ0->Z0_TESBAT,1,"    ")
          SC6->C6_CLI     := cCli
          SC6->C6_LOJA    := cLoja
          SC6->C6_PRUNIT  := SZ0->Z0_PRCFECB
          SC6->C6_XFICTEC := "Z0_FECHELE" 
       EndIf
    EndIf       
    
                                                    
    SZ0->Z0_STATALT := 'A'  //alteracao aprovada
    SZ0->(MsUnLock())
	
   MsgBox("Altera็ใo da Ficha T้cnica Aprovada","Ficha T้cnica","INFO")               
	
 EnviaWF12D(.T.)
EndIf

Return




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMFATA012g บAutor  ณMicrosiga           บ Data ณ  06/18/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Realiza a aprovacao da Credito                             บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function MFATA12g()
Local c_Query
Local cRet
Local cPedido
Local cItem


If SZ0->Z0_STATALT <> 'C'
	MsgBox('Ficha T้cnica nใo depende de aprova็ใo de Cr้dito',"Ficha T้cnica","ALERT")
	Return
EndIf


DbSelectArea('SZ4')
DbSetOrder(1) //Z4_FILIAL, Z4_PEDIDO, Z4_ITEM, Z4_DATAALT, R_E_C_N_O_, D_E_L_E_T_
If DbSeek(xFilial('SZ4')+SZ0->Z0_PEDIDO+SZ0->Z0_ITEM)
	lStatPnd := .F.  //alteracao pendente
	Do While !Eof().And.SZ0->Z0_PEDIDO+SZ0->Z0_ITEM = SZ4->Z4_PEDIDO+SZ4->Z4_ITEM
		If SZ4->Z4_STATALT = "C"
			lStatPnd := .T.
			Exit
		EndIf
		DbSkip()
	EndDo
	If !lStatPnd   //.T., alteracao pendente
		Msgbox("Ficha tecnica inconsistente [SZ0 vs SZ4]. Verificar","Ficha T้cncia","ALERT")
		Return(.T.)
	EndIf
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณVerifica se os empenhos ja foram gerados alguma vez.   ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
//	If !Empty(SZ0->Z0_STATUS)
//		MsgBox("Os empenhos dessa ficha t้cnica jแ foram gerados! ", "Ficha Tecnica","ALERT")
//		Return
//	EndIf
	
	//	If !MsgBox("Esta preste a aprovar a altera็ใo desta Ficha T้cnica. Deseja APROVAR a altera็ใo desta Ficha T้cnica ?","Ficha T้cnica","YESNO")
	If AxVisual('SZ4', SZ4->(Recno()), 2) != 1
		Return
	EndIf
	
	RecLock('SZ4', .F.)
	SZ4->Z4_STATALT := '1'   //credito aprovado
	SZ4->(MsUnLock())
	
	RecLock('SZ0', .F.)
	SZ0->Z0_STATALT := '1'  //alteracao aprovada
	SZ0->(MsUnLock())
	
	MsgBox("Cr้dito Aprovado","Anแlise de Cr้dito","INFO")
	
	EnviaWF12G(.T.)
EndIf

Return






/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMFATA012  บAutor  ณMicrosiga           บ Data ณ  06/18/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRealiza a rejeicao da Alteracao da ficha.                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function MFATA12e()

If SZ0->Z0_STATALT <> 'P'.And.SZ0->Z0_STATALT <> '1'.And.SZ0->Z0_STATALT <> 'C'  //pendente - - analise de credito
	MsgBox('Ficha T้cnica nใo tem altera็๕es Pendentes',"Ficha T้cnica","ALERT")
	Return
EndIf

DbSelectArea('SZ4')
DbSetOrder(1) //Z4_FILIAL, Z4_PEDIDO, Z4_ITEM, Z4_DATAALT, R_E_C_N_O_, D_E_L_E_T_
If DbSeek(xFilial('SZ4')+SZ0->(Z0_PEDIDO+Z0_ITEM))
	lStatPnd := .F.  //alteracao pendente
	Do While !Eof().And.SZ0->Z0_PEDIDO+SZ0->Z0_ITEM = SZ4->Z4_PEDIDO+SZ4->Z4_ITEM
		If SZ4->Z4_STATALT $ "P.1.C"
			lStatPnd := .T.
			Exit
		EndIf
		DbSkip()
	EndDo
	If !lStatPnd   //.T., alteracao pendente
		Msgbox("Ficha t้cnica inconsistente [SZ0 vs SZ4]. Verificar","Ficha T้cncia","ALERT")
		Return(.T.)
	EndIf
	
	//	If !MsgBox("Esta preste a rejeitar a altera็ใo desta Ficha T้cnica. Deseja REJEITAR a altera็ใo desta Ficha T้cnica ?","Ficha T้cnica","YESNO")
	If AxVisual('SZ4', SZ4->(Recno()), 2) != 1
		Return
	EndIf
	
	RecLock('SZ4', .F.)
	If SZ4->Z4_STATALT $ "P.1"
       SZ4->Z4_STATALT := 'R'  //alteracao rejeitada 
    ElseIf SZ4->Z4_STATALT = "C"                        
           SZ4->Z4_STATALT := '0'  //analise de credito rejeitada 
    EndIf       
	SZ4->(MsUnLock())
	
	RecLock('SZ0', .F.)
	If SZ0->Z0_STATALT $ "P.1"
       SZ0->Z0_STATALT := 'R'  //alteracao rejeitada 
    ElseIf SZ0->Z0_STATALT = "C"                        
           SZ0->Z0_STATALT := '0'  //analise de credito rejeitada 
    EndIf       
	SZ0->(MsUnLock())
	                          
	If SZ0->Z0_STATALT = "R"
	   MsgBox("Altera็ใo Rejeitada pelo PCP","Ficha T้cnica","INFO")
	   EnvWF12ER(.F.)
    ElseIf SZ0->Z0_STATALT = "0"                        
           MsgBox("Cr้dito Rejeitado","Anแlise de Cr้dito","INFO")
           EnvWF12EC(.F.)
    EndIf      
	
EndIf

Return




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณEnviaWFR  บAutor  ณMicrosiga           บ Data ณ  06/22/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณEnvia o workflow para os responsaveis quando incluir a      บฑฑ
ฑฑบ          ณsolicitacao de alteracao da FT.                             บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function EnviaWFR(l_aprova)

Local cFrom     := GetMV('MV_XMAILFT')+";mauro.nagata@actualtrend.com.br"

Private c_Texto  := ''
Private c_MsgErro:= ''
Private c_assunt := ''

DbSelectArea('SC5')
DbSetOrder(1) // C5_FILIAL, C5_NUM, R_E_C_N_O_, D_E_L_E_T_
DbSeek(xFilial('SC5')+SZ0->Z0_PEDIDO)

If l_aprova
	fArq("\HTML\MFATA012b.htm", "C:\MFATA012b.htm")
	__CopyFile("\HTML\MFATA012b.htm", "C:\MFATA012b.htm")
	c_assunt := "[Ficha Tecnica] "+SZ0->Z0_PEDIDO + " - Aprovacao da Alteracao pelo PCP"
Else
	fArq("\HTML\MFATA012c.htm", "C:\MFATA012c.htm")
	__CopyFile("\HTML\MFATA012c.htm", "C:\MFATA012c.htm")
	c_assunt := " [Ficha Tecnica] "+SZ0->Z0_PEDIDO + " - Rejeicao da Alteracao pelo PCP"
EndIf

If !FGEN010(cFrom,c_assunt,c_texto,"",.T.)
	Return c_MsgErro
EndIf

Return(.T.)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณEnviaWFA  บAutor  ณMicrosiga           บ Data ณ  06/22/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณEnvia o workflow para os responsaveis quando incluir a      บฑฑ
ฑฑบ          ณsolicitacao de alteracao da FT.                             บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function EnviaWFA()

//Local cFrom     := SuperGetMV('MV_XMAILF1',.F.,"andre@multlock.com.br")
Local cFrom     := SuperGetMV('MV_XMAILF1',.F.,"andre@multlock.com.br")

Private c_Texto  := ''
Private c_MsgErro:= ''

DbSelectArea('SC5')
DbSetOrder(1) // C5_FILIAL, C5_NUM, R_E_C_N_O_, D_E_L_E_T_
DbSeek(xFilial('SC5')+SZ0->Z0_PEDIDO)
                                

fArq("\HTML\MFATA012a.htm", "C:\MFATA012a.htm")

__CopyFile("\HTML\MFATA012a.htm", "C:\MFATA012a.htm")

If !FGEN010(cFrom,"[Ficha Tecnica] "+SZ0->Z0_PEDIDO + " - Solicitacao de Alteracao da Ficha Tecnica",c_texto,"",.T.)
	Return c_MsgErro
EndIf           

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



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMFATA12h  บAutor  ณMauro Nagata        บ Data ณ 08/02/2011  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณhistorico da ficha tecnica                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function MFATA12h()

c_Query := "SELECT CASE WHEN Z4_STATALT = 'P' THEN 'Em Anแlise pelo PCP' "
c_Query += "            WHEN Z4_STATALT = 'A' THEN 'Aprovado pelo PCP' "
c_Query += "            WHEN Z4_STATALT = 'R' THEN 'Rejeitado pelo PCP' "
c_Query += "            WHEN Z4_STATALT = '1' THEN 'Aprovado Cr้dito' "
c_Query += "            WHEN Z4_STATALT = '0' THEN 'Rejeitado Cr้dito' "
c_Query += "            WHEN Z4_STATALT = 'C' THEN 'Em Anแlise pelo Cr้dito' "
c_Query += "            ELSE 'NORMAL' END as STATUSFT, "
c_Query += "       Convert(VarChar(10),Cast(Z4_DATAALT as DateTime),103) AS DATAALT,R_E_C_N_O_ AS REG,* "
c_Query += "FROM "+RetSqlName('SZ4')
c_Query += " WHERE Z4_PEDIDO = '"+SZ0->Z0_PEDIDO+"' and Z4_ITEM = '"+SZ0->Z0_ITEM+"' and D_E_L_E_T_ <> '*' "  
c_Query += "ORDER BY REG DESC "

a_campos := {{"Data Alt.", "Pedido", "Item", "Status"}, {"DATAALT", "Z4_PEDIDO", "Z4_ITEM", "STATUSFT"}}
c_tit := "Altera็๕es Solicitadas็"
c_Ret := U_FGEN008(c_Query, a_campos, c_tit, 1)

Return







/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMFATA12f  บAutor  ณAlexandre Sousa     บ Data ณ  11/10/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณImprime a Ficha Tecnica via html.                           บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function MFATA12f()

Private c_FechElt := ''
Private c_descfhe := ''

Private c_kitabpf := ''
Private c_desckta := ''

Private c_molaaer := ''
Private c_descmla := ''

Private c_altfdp  := ''
Private c_htmbat  := ''

Private c_cmdint := ''


c_Query := "SELECT CASE WHEN Z4_STATALT = 'P' THEN 'Em Anแlise pelo PCP' "
c_Query += "            WHEN Z4_STATALT = 'A' THEN 'Aprovado pelo PCP' "
c_Query += "            WHEN Z4_STATALT = 'R' THEN 'Rejeitado pelo PCP' "
c_Query += "            WHEN Z4_STATALT = '1' THEN 'Aprovado Cr้dito' "
c_Query += "            WHEN Z4_STATALT = '0' THEN 'Rejeitado Cr้dito' "
c_Query += "            WHEN Z4_STATALT = 'C' THEN 'Em Anแlise pelo Cr้dito' "
c_Query += "            ELSE 'NORMAL' END as STATUSFT, "
c_Query += "       Convert(VarChar(10),Cast(Z4_DATAALT as DateTime),103) AS DATAALT, R_E_C_N_O_ AS REG, * "
c_Query += "FROM "+RetSqlName('SZ4')
c_Query += " WHERE Z4_PEDIDO = '"+SZ0->Z0_PEDIDO+"' and Z4_ITEM = '"+SZ0->Z0_ITEM+"' and D_E_L_E_T_ <> '*' "
c_Query += "ORDER BY REG DESC "

a_campos := {{"Data Alt.", "Pedido", "Item", "Status","Reg"}, {"DATAALT", "Z4_PEDIDO", "Z4_ITEM", "STATUSFT","REG"}}
c_tit := "Altera็๕es Solicitadas็"
c_Ret := U_FGEN008(c_Query, a_campos, c_tit, 5)

If type('c_Ret') <> 'N'
	Return
EndIf

DbSelectArea('SC6')
DbSetOrder(1) //C6_FILIAL, C6_NUM, C6_ITEM, C6_PRODUTO, R_E_C_N_O_, D_E_L_E_T_
If DbSeek(xFilial('SC6')+SZ0->(Z0_PEDIDO+Z0_ITEM))
	n_qtdp := SC6->C6_QTDVEN
Else
	n_qtdp := 1
Endif

cPerg := 'MFATA012'
ValidPerg()
PERGUNTE(cPerg, .F.)

n_item := If (MV_PAR01+1>n_qtdp, 1, MV_PAR01+1)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Criacao da Interface                                                ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
@ 336,470 To 451,720 Dialog mkwdlg Title OemToAnsi("Impressใo")
@ 1,2 Say OemToAnsi("Imprimir item:") Size 33,8
@ 2,6.5 Say OemToAnsi("de") Size 9,8
@ 2,2 Get n_item valid VALIDITIMP() picture '@E 999' Size 34,10
@ 2,8 Get n_qtdp when .F. Size 34,10
@ 4,7 Button OemToAnsi("OK") Size 29,11 Action (c_ok:=1, close(mkwdlg))
Activate Dialog mkwdlg

DbSelectArea('SX1')
dbSeek(padr(cPerg,10)+'01')
RecLock('SX1',.F.)
SX1->X1_CNT01 := strzero(n_item)
MsUnLock()

DbSelectArea('SZ0')

DbSelectArea('SZ4')
DbSetOrder(1) //Z4_FILIAL, Z4_PEDIDO, Z4_ITEM, Z4_DATAALT, R_E_C_N_O_, D_E_L_E_T_
DbGoTo(c_Ret)
//If DbSeek(xFilial('SZ4')+SZ0->(Z0_PEDIDO+Z0_ITEM)+Dtos(Ctod(c_Ret)))
	c_FechElt := SZ4->Z4_FECHELE    //SUPERGETMV('MV_XFECHEL')
	c_descfhe := GetAdvFval('SB1', 'B1_DESC', xfilial('SB1')+c_FechElt, 1, '')
	
	c_kitabpf := SZ4->Z4_KITABER //SUPERGETMV('MV_XKITAPF')

	c_molaaer := SZ4->Z4_MOLAA //SUPERGETMV('MV_XMOLAA')
	c_descmla := GetAdvFval('SB1', 'B1_DESC', xfilial('SB1')+c_molaaer, 1, '')
	               

	Do Case
	   Case Z4_STATALT = 'P'
	        cStatus :=  '[ Em Anแlise pelo PCP ]'
	   Case Z4_STATALT = 'A' 
	        cStatus :=  '[ Aprovado pelo PCP ]' 
	   Case Z4_STATALT = 'R' 
	        cStatus :=  '[ Rejeitado pelo PCP ]' 
	   Case Z4_STATALT = '1' 
	        cStatus :=  '[ Aprovado Cr้dito ]'
	   Case Z4_STATALT = '0' 
	        cStatus :=  '[ Altera็ใo Rejeitada ]' "
	   Case Z4_STATALT = 'C'
	        cStatus :=  '[ Em Anแlise pelo Cr้dito ]' 
	   Case Z4_STATALT = ' '
	        cStatus :=  ''      
    EndCase

	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณVerifica se os empenhos ja foram pagos no estoque           ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If veremp('Z4_MODINT')
		c_cmdint := 'style="background:#E5E5E5"'
	EndIf
	
	a_realca := VerAltZ4(SZ4->Z4_PEDIDO)
//	c_alterou := 'bgcolor="#CCCCCC"'
	
	
	If SZ4->Z4_ALTURA <> 0
		c_altfdp += '           <tr>'
		c_altfdp += '             <td height="32" bordercolor="#333333" align="center" class="style5">Altura:</td>
		c_altfdp += '             <td width="120" bordercolor="#333333"><span class="style5">'+TRANSFORM(SZ4->Z4_ALTURA ,'@E 999,999,999')+' mm</span></td>
		c_altfdp += '             <td colspan="3" bordercolor="#333333"><span class="style5">*** ATENวรO: ALTURA FORA DO PADRรO *** </span></td>'
		c_altfdp += '           </tr>'
	EndIF
	
	If !Empty(SZ4->Z4_BATENTE)
		c_htmbat := "    <tr> "
		c_htmbat += '      <td width="87%"><font face="Calibri" size="2">&nbsp;<b>1.5 Batente:</b></font></td>'
		c_htmbat += "    </tr>"
		c_htmbat += "    <tr>"
		c_htmbat += '      <td width="87%">'
		c_htmbat += '        <div align="center">'
		c_htmbat += '          <table border="1" cellpadding="0" cellspacing="0" width="100%">'
		c_htmbat += "            <tr>"
		c_htmbat += '              <td width="18%"><font face="Calibri" size="2">&nbsp;Batente:</font> </td>'
		c_htmbat += '              <td width="15%"><font face="Calibri" size="2">&nbsp;'+SZ4->Z4_BATENTE+'</font></td>'
		c_htmbat += '              <td width="67%"><font face="Calibri" size="2">&nbsp;' + GetAdvFval('SB1','B1_DESC', xFilial('SB1')+SZ4->Z4_BATENTE,1,'XX') + '</font></td>'
		c_htmbat += "            </tr>"
		c_htmbat += "            <tr>"
		c_htmbat += '              <td width="18%"><font face="Calibri" size="2">&nbsp;Fech. El้trica:</font>'
		c_htmbat += "              </td>"
		c_htmbat += '              <td width="15%"><font face="Calibri" size="2">&nbsp;'+c_FechElt+'</font></td>'
		c_htmbat += '              <td width="67%"><font face="Calibri" size="2">&nbsp;'+c_descfhe+'</font></td>'
		c_htmbat += "            </tr>"
		c_htmbat += "            <tr>"
		c_htmbat += '              <td width="18%"><font face="Calibri" size="2">&nbsp;Observa็๕es:</font> </td>'
		c_htmbat += '              <td width="82%" colspan="2"><font face="Calibri" size="2">&nbsp;'+SZ4->Z4_OBSBAT+'</font></td>'
		c_htmbat += "            </tr> "
		c_htmbat += "          </table> "
		c_htmbat += "        </div>"
		c_htmbat += "      </td>"
		c_htmbat += "    </tr>"
	EndIf
	
	DbSelectArea("SC5")
	DbSetOrder(1)
	DbSeek(xFilial("SC5")+SZ4->Z4_PEDIDO)
	
	DbSelectArea('SC6')
	DbSetOrder(1) //C6_FILIAL, C6_NUM, C6_ITEM, C6_PRODUTO, R_E_C_N_O_, D_E_L_E_T_
	DbSeek(xFilial('SC6')+SZ4->(Z4_PEDIDO+Z4_ITEM))
	
	cPath := AllTrim(GetTempPath())
	If Empty(SZ4->Z4_MODELO)
		U_FGEN009("\html\MFATA012b.html", cPath+"SIGA.html")
	Else
		U_FGEN009("\html\MFATA012.html", cPath+"SIGA.html")
	EndIf
//EndIf

Return


Static Function veremp(c_campo)

Local l_Ret := .F.

DbSelectArea('SD4')
DbSetOrder(7) //D4_FILIAL, D4_XPEDFT, D4_COD, R_E_C_N_O_, D_E_L_E_T_
If DbSeek(xFilial('SD4')+SZ4->Z4_PEDIDO+SZ4->&(c_campo))
	If SD4->D4_QTDEORI <> SD4->D4_QUANT
		l_Ret := .T.
	EndIf
EndIf

Return l_Ret
                          
Static Function VerAltZ4(c_pedz4)
	
	a_Ret := {}
	
	DbSelectArea('SX3')
	DbSetOrder(2)
	DbSeek('Z4_')
	While SX3->(!EOF()) .and. SX3->X3_ARQUIVO = 'SZ4' 
		If SX3->X3_CONTEXT <> 'V' .and. SX3->X3_VISUAL <> 'V' .and. SX3->X3_TIPO <> 'M'
			Aadd(a_Ret, {SX3->X3_CAMPO, ''})
		EndIf
		SX3->(DbSkip())
	EndDo
	
	c_Query := "select * from SZ4010 where Z4_PEDIDO = '"+c_pedz4+"'"	
		
 	If Select("QRP") > 0
		DbSelectArea("QRP")
		DbCloseArea()
	EndIf
	TcQuery c_Query New Alias "QRP"
	
	For n_x := 1 to len(a_Ret)
		QRP->(DbGotop())
		c_tmp := nil
		While QRP->(!EOF())
			If c_tmp <> nil
				If c_tmp <> QRP->&(a_Ret[n_x,1])
					a_Ret[n_x, 2] := 'bgcolor="#CCCCCC"'
				EndIf                                                      	
			EndIf
			c_tmp := QRP->&(a_Ret[n_x,1])
			QRP->(DbSkip())
		EndDo
	Next

Return a_Ret

Static Function VALIDITIMP()

	Local l_Ret := .T.

	If n_item > n_qtdp
		msgAlert('O item nใo pode ser maior que a quantidade!!!', 'A T E N ว ร O')
		n_item := n_qtdp
		l_Ret := .F.
	Endif

Return l_Ret


Static Function VerPrc1(pProd,pCProdFt,pQtdFt,pCProdPv,pQtdPv,pPrcPv)

Private oButton1
Private oButton2
Private cProd    := pProd
Private oCodFt
Private cCodFt   := pCProdFt
Private oCodPv
Private cCodPv   := pCProdPv
Private oDescFt
Private cDescFt  := GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+pCProdFt,1,"Nao Cadastrado")
Private oDescPv
Private cDescPv  := GetAdvFVal("SB1","B1_DESC",xFilial("SB1")+pCProdPv,1,"Nao Cadastrado")
Private oFont1   := TFont():New("Verdana",,024,,.F.,,,,,.F.,.F.)
Private oFont2   := TFont():New("MS Sans Serif",,018,,.F.,,,,,.F.,.T.)
Private oFont3   := TFont():New("MS Sans Serif",,016,,.F.,,,,,.F.,.F.)
Private oFont4   := TFont():New("Verdana",,020,,.F.,,,,,.F.,.F.)
Private oFont5   := TFont():New("Verdana",,019,,.F.,,,,,.F.,.F.)
Private oPanel1
Private oPanel2
Private oPanel3
Private oPanel4
Private oPanel5
Private oPanel6
Private oPercDif
Private nPercDif := 0
Private oSay1
Private oSay10
Private oSay11
Private oSay12
Private oSay13
Private oSay14
Private oSay4
Private oSay5
Private oSay6
Private oSay7
Private oSay9

Private oPrcFt
Private nPrcFt   := pPrcPv
Private oPrcPv
Private nPrcPv   := pPrcPv

Private oQtdFt
Private nQtdFt   := pQtdFt
Private oQtdPv
Private nQtdPv   := pQtdPv

Private oVlrFt
Private nVlrFt := nQtdFt * nPrcFt
Private oVlrPv
Private nVlrPv := nQtdPv * nPrcPv

Private oDifItP
Private nDifItP  := 0
Private oDifPv
Private nDifPv   := 0
Private oPercItP
Private nPercItP := 0
Private oPercPv
Private nPercPv  := 0
Static oDlg

nPosVP := aScan(aVerPrc1,{|x|x[1]=cProd})
If nPosVP > 0
	nPrcFt  := aVerPrc1[nPosVP][2]      //preco da ficha tecnica
	nVlrFt  := aVerPrc1[nPosVP][3]      //valor total da ficha tecnica
	nDifItP := aVerPrc1[nPosVP][4]      //diferenca
EndIf

nDifPv := 0
For nI := 1 To Len(aVerPrc1)
	nDifPv += aVerPrc1[nI][4]
Next
nPercPv  := Round((nDifPv/nTotPv)*100,2)

nDifItP  := nVlrFt - nVlrPv
nPercItP := Round((nDifItP/nVlrPv)*100,2)
lAlt := .T. //houve alteracao na ft


DEFINE MSDIALOG oDlg TITLE "Ficha T้cnica vs Pedido" FROM 000, 000  TO 510, 780 COLORS 0, 16777215 PIXEL

@ 005, 017 SAY     oSay1                                SIZE 387, 245 OF oDlg    COLORS        0, 16777215             PIXEL

@ 019, 077 MSPANEL oPanel4   PROMPT cProd               SIZE 236, 014 OF oSay1   COLORS 10485760, 2829311 FONT oFont1  CENTERED RAISED

@ 055, 028 MSPANEL oPanel5   PROMPT "Ficha T้cnica"     SIZE 070, 013 OF oSay1   COLORS 10485760, 4227327 FONT oFont2  CENTERED RAISED

@ 069, 029 MSPANEL oPanel1                              SIZE 151, 089 OF oSay1   COLORS        0, 16777215 LOWERED
@ 011, 006 SAY     oSay4     PROMPT "C๓digo do Produto" SIZE 048, 007 OF oPanel1 COLORS        0, 16777215             PIXEL
@ 011, 060 SAY     oCodFt    PROMPT cCodFt              SIZE 048, 010 OF oPanel1 COLORS      255, 16777215 FONT oFont3 PIXEL
@ 022, 006 SAY     oDescFt   PROMPT cDescFt             SIZE 300, 010 OF oPanel1 COLORS      255, 16777215 FONT oFont3 PIXEL
@ 036, 006 SAY     oSay5     PROMPT "Quantidade"        SIZE 048, 007 OF oPanel1 COLORS        0, 16777215             PIXEL
@ 036, 065 SAY     oQtdFt    PrOMPT nQtdFt              SIZE 077, 010 OF oPanel1 COLORS      255, 16777215 FONT oFont3 PIXEL Picture "@RE 999,999.99"
@ 050, 006 SAY     oSay6     PROMPT "Pre็o Unitแrio"    SIZE 045, 010 OF oPanel1 COLORS        0, 16777215             PIXEL
@ 049, 045 MSGET   oPrcFt    VAR    nPrcFt              SIZE 050, 010 OF oPanel1 COLORS      255, 16777215 FONT oFont3 PIXEL Picture "@RE 999,999,999.99"  VALID Vld_PrcFt()
@ 064, 006 SAY     oSay7     PROMPT "Valor Total"       SIZE 045, 010 OF oPanel1 COLORS        0, 16777215             PIXEL
@ 064, 056 SAY     oVlrFt    PROMPT nVlrFt              SIZE 050, 010 OF oPanel1 COLORS      255, 16777215 FONT oFont3 PIXEL Picture "@RE 999,999,999.99"

@ 055, 224 MSPANEL oPanel6   PROMPT "Pedido de Vendas"  SIZE 070, 013 OF oSay1   COLORS 10485760, 4227327 FONT oFont2 CENTERED RAISED

@ 069, 225 MSPANEL oPanel2                              SIZE 151, 089 OF oSay1   COLORS 0, 16777215 LOWERED
@ 011, 006 SAY     oSay9     PROMPT "C๓digo do Produto" SIZE 048, 007 OF oPanel2 COLORS        0, 16777215             PIXEL
@ 011, 060 SAY     oCodPv    PROMPT cCodPv              SIZE 048, 010 OF oPanel2 COLORS      255, 16777215 FONT oFont3 PIXEL
@ 022, 006 SAY     oDescPv   PROMPT cDescPv             SIZE 300, 010 OF oPanel2 COLORS      255, 16777215 FONT oFont3 PIXEL
@ 036, 006 SAY     oSay10    PROMPT "Quantidade"        SIZE 048, 007 OF oPanel2 COLORS        0, 16777215             PIXEL
@ 036, 065 SAY     oQtdPv    PROMPT nQtdPv              SIZE 077, 010 OF oPanel2 COLORS      255, 16777215 FONT oFont3 PIXEL Picture "@RE 999,999.99"
@ 050, 006 SAY     oSay11    PROMPT "Pre็o Unitแrio"    SIZE 048, 010 OF oPanel2 COLORS        0, 16777215             PIXEL
@ 050, 056 SAY     oPrcPv    PROMPT nPrcPv              SIZE 050, 010 OF oPanel2 COLORS      255, 16777215 FONT oFont3 PIXEL Picture "@RE 999,999,999.99"
@ 064, 006 SAY     oSay12    PROMPT "Valor Total"       SIZE 045, 010 OF oPanel2 COLORS        0, 16777215             PIXEL
@ 064, 056 SAY     oVlrPv    PROMPT nVlrPv              SIZE 050, 010 OF oPanel2 COLORS      255, 16777215 FONT oFont3 PIXEL Picture "@RE 999,999,999.99"


@ 170, 054 MSPANEL oPanel3                              SIZE 215, 060 OF oSay1 COLORS 0, 4227327 FONT oFont4 LOWERED
@ 006, 064 SAY     oSay2    PROMPT "Item do Pedido"     SIZE 067, 013 OF oPanel3 FONT oFont5 COLORS 10485760, 16777215 PIXEL
@ 006, 139 SAY     oSay3    PROMPT "Pedido de Vendas"   SIZE 067, 013 OF oPanel3 FONT oFont5 COLORS 10485760, 16777215 PIXEL
@ 024, 009 SAY     oSay13   PROMPT "Diferen็a R$"       SIZE 055, 013 OF oPanel3 FONT oFont5 COLORS 10485760, 16777215 PIXEL
@ 040, 008 SAY     oSay14   PROMPT "Percentual %"       SIZE 055, 013 OF oPanel3 FONT oFont5 COLORS 10485760, 16777215 PIXEL
@ 023, 070 SAY     oDifItP  PROMPT nDifItP              SIZE 067, 013 OF oPanel3 FONT oFont4 COLORS 0       , 16777215 PIXEL Picture "@RE 999,999,999.99"
@ 039, 089 SAY     oPercItP PROMPT nPercItP             SIZE 067, 013 OF oPanel3 FONT oFont4 COLORS 0       , 16777215 PIXEL Picture "@RE 9,999.99"
@ 023, 152 SAY     oDifPv   PROMPT nDifPv               SIZE 067, 013 OF oPanel3 FONT oFont4 COLORS 0       , 16777215 PIXEL Picture "@RE 999,999,999.99"
@ 039, 172 SAY     oPercPv  PROMPT nPercPv              SIZE 067, 013 OF oPanel3 FONT oFont4 COLORS 0       , 16777215 PIXEL Picture "@RE 9,999.99"

@ 171, 298 BUTTON oButton1 PROMPT "Pr๓ximo Item" SIZE 060, 021 OF oSay1 ACTION B_Act1()                    PIXEL
@ 196, 298 BUTTON oButton2 PROMPT "Cancelar"     SIZE 060, 021 OF oSay1 ACTION (lStatVal:="X",oDlg:END()) PIXEL
@ 221, 298 BUTTON oButton3 PROMPT "Confirmar"    SIZE 060, 021 OF oSay1 ACTION B_Act3() PIXEL    
oButton1:Disable()
//oButton2:Disable()
oButton3:Disable()

ACTIVATE MSDIALOG oDlg CENTERED

Return(nPrcFt)




Static Function Vld_PrcFt()
//Local nVlrFtAux := nVlrFt   //Valor Total do item na ficha tecnica

If nPrcFt <= 0
   Return.F.
EndIf
nVlrFt  := nPrcFt * nQtdFt  //novo valor total do item na ficha tecnica
oVlrFt:Refresh()

nDifItP  := nVlrFt - nVlrPv
oDifItP:Refresh()

nPosVP := aScan(aVerPrc1,{|x|x[1]=cProd})
If nPosVP = 0
	aAdd(aVerPrc1,{cProd,nPrcFt,nVlrFt,nDifItP})  //descricao produto, preco unitario, valor total do item, diferenca entre pedido e ficha
Else
	aVerPrc1[nPosVP][2] := nPrcFt   //preco unitario
	aVerPrc1[nPosVP][3] := nVlrFt   //valor total do item
	aVerPrc1[nPosVP][4] := nDifItP  //diferenca entre pedido e ficha
EndIf

nDifPv := 0
For nI := 1 To Len(aVerPrc1)
	nDifPv += aVerPrc1[nI][4]
Next
//nDifPv := (nTotFt -(nVlrPv - nVlrFt)) - nTotPv
oDifPv:Refresh()

nPercPv  := Round((nDifPv/nTotPv)*100,2)
oPercPv:Refresh()

nPercItP := Round((nDifItP/nVlrPv)*100,2)
oPercItP:Refresh()

oButton1:Enable()
oButton2:Enable()
If lIpTodo
   oButton3:Enable()    
EndIf	   
oButton1:SetFocus()             

Return.T.



Static Function B_Act1()           //botao proximo item


lStatVal := "P"  //proximo item
oButton1:Disable()
oButton2:Disable()
oButton3:Disable()
oPrcFt:SetFocus()

oDlg:End()        
Return.T.

        

Static Function B_Act3()    //botal confirmar

If nDifPv > 0    //valor da ficha tecnica maior que o pedido de vendas
   If MsgBox("A altera็ใo na Ficha T้cnica resultou em aumento no pedido de venda. Deseja encaminhar para anแlise de cr้dito ?","Ficha T้cnica","YESNO")
      EnvWF12DB3()   //workflow para analise de credito
      lStatVal:="C"                                    
      oDlg:END()
      Return .T.
   Else
      Return .T.
   EndIf
Else
	If lStatVal <> 'C'
	   lStatVal:="O"                                       
	EndIf
   oDlg:END()
   Return .T.
EndIf      




Static Function fBt_Canc()

M->Z4_MOLAA := SZ0->Z0_MOLAA
oDlg:End()
Return.T.



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณEnvWF12BD3บAutor  ณMauro Nagata        บ Data ณ  07/02/2011 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณEnvia o workflow para os responsaveis de analise de credito บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function EnvWF12DB3()

Local cFrom     := SuperGetMV('MV_XMAILF2',.F.,"andre@multlock.com.br")

Private c_Texto  := ''
Private c_MsgErro:= ''
Private c_assunt := ''

DbSelectArea('SC5')
DbSetOrder(1) // C5_FILIAL, C5_NUM, R_E_C_N_O_, D_E_L_E_T_
DbSeek(xFilial('SC5')+SZ0->Z0_PEDIDO)


fArq("\HTML\MFATA012db3.htm", "C:\MFATA012db3.htm")
__CopyFile("\HTML\MFATA012db3.htm", "C:\MFATA012db3.htm")
c_assunt := "[Ficha Tecnica] "+SZ0->Z0_PEDIDO + " - Analise de Credito na Alteracao da Ficha Tecnica"

If !FGEN010(cFrom,c_assunt,c_texto,"",.T.)
	Return c_MsgErro
EndIf

Return(.T.)



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณEnviaWF12DบAutor  ณMauro Nagata        บ Data ณ  07/02/2011 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณEnvia o workflow aprovacao da alteracao da FT pelo PCP      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function EnviaWF12D()

Local cFrom     := SuperGetMV('MV_XMAILF3',.F.,"andre@multlock.com.br")

Private c_Texto  := ''
Private c_MsgErro:= ''
Private c_assunt := ''

DbSelectArea('SC5')
DbSetOrder(1) // C5_FILIAL, C5_NUM, R_E_C_N_O_, D_E_L_E_T_
DbSeek(xFilial('SC5')+SZ0->Z0_PEDIDO)


fArq("\HTML\MFATA012d.htm", "C:\MFATA012d.htm")
__CopyFile("\HTML\MFATA012d.htm", "C:\MFATA012d.htm")
c_assunt := "[Ficha Tecnica] "+SZ0->Z0_PEDIDO + " - Aprovacao da Alteracao pelo PCP"

If !FGEN010(cFrom,c_assunt,c_texto,"",.T.)
	Return c_MsgErro
EndIf

Return(.T.)



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณEnviaWF12GบAutor  ณMauro Nagata        บ Data ณ  07/02/2011 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณEnvia o workflow aprovando credito                          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function EnviaWF12G()

Local cFrom     := SuperGetMV('MV_XMAILF4',.F.,"andre@multlock.com.br")

Private c_Texto  := ''
Private c_MsgErro:= ''
Private c_assunt := ''

DbSelectArea('SC5')
DbSetOrder(1) // C5_FILIAL, C5_NUM, R_E_C_N_O_, D_E_L_E_T_
DbSeek(xFilial('SC5')+SZ0->Z0_PEDIDO)


fArq("\HTML\MFATA012g.htm", "C:\MFATA012g.htm")
__CopyFile("\HTML\MFATA012g.htm", "C:\MFATA012g.htm")
c_assunt := "[Ficha Tecnica] "+SZ0->Z0_PEDIDO + " - Aprovacao de Credito"

If !FGEN010(cFrom,c_assunt,c_texto,"",.T.)
	Return c_MsgErro
EndIf

Return(.T.)




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณEnvWF12ER บAutor  ณMauro Nagata        บ Data ณ  07/02/2011 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณEnvia o workflow rejeitando a alteracao pelo PCP            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function EnvWF12ER()

Local cFrom      := SuperGetMV('MV_XMAILF6',.F.,"thiago.rufino@actualtremd.com.br")

Private c_Texto  := ''
Private c_MsgErro:= ''
Private c_assunt := ''

DbSelectArea('SC5')
DbSetOrder(1) // C5_FILIAL, C5_NUM, R_E_C_N_O_, D_E_L_E_T_
DbSeek(xFilial('SC5')+SZ0->Z0_PEDIDO)


fArq("\HTML\MFATA012er.htm", "C:\MFATA012er.htm")
__CopyFile("\HTML\MFATA012er.htm", "C:\MFATA012er.htm")
c_assunt := "[Ficha Tecnica] "+SZ0->Z0_PEDIDO + " - Rejeicao da Alteracao pelo PCP"

If !FGEN010(cFrom,c_assunt,c_texto,"",.T.)
	Return c_MsgErro
EndIf

Return(.T.)                                               




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณEnvWF12EC บAutor  ณMauro Nagata        บ Data ณ  07/02/2011 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณEnvia o workflow rejeitando o credito                       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function EnvWF12EC()

Local cFrom     := SuperGetMV('MV_XMAILF5',.F.,"thiago.rufino@actualtremd.com.br")

Private c_Texto  := ''
Private c_MsgErro:= ''
Private c_assunt := ''

DbSelectArea('SC5')
DbSetOrder(1) // C5_FILIAL, C5_NUM, R_E_C_N_O_, D_E_L_E_T_
DbSeek(xFilial('SC5')+SZ0->Z0_PEDIDO)


fArq("\HTML\MFATA012ec.htm", "C:\MFATA012ec.htm")
__CopyFile("\HTML\MFATA012ec.htm", "C:\MFATA012ec.htm")
c_assunt := "[Ficha Tecnica] "+SZ0->Z0_PEDIDO + " - Rejeicao do Credito"

If !FGEN010(cFrom,c_assunt,c_texto,"",.T.)
	Return c_MsgErro
EndIf

Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณVALIDPERG บ Autor ณ AP5 IDE            บ Data ณ  25/06/01   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Verifica a existencia das perguntas criando-as caso seja   บฑฑ
ฑฑบ          ณ necessario (caso nao existam).                             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ValidPerg()

Local _sAlias := Alias()
Local aRegs := {}
Local i,j

dbSelectArea("SX1")
dbSetOrder(1)
cPerg := PADR(cPerg,10)
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Variaveis utilizadas para parametros                         ณ
//ณ mv_par01              Data Vendas De    	                 ณ
//ณ mv_par02              Data Vendas At้       	             ณ
//ณ mv_par03              Cliente De ?                           ณ
//ณ mv_par04              Cliente Ate ?                          ณ
//ณ mv_par05              Representante	De ?      			     ณ
//ณ mv_par06              Representante Ate ?				     ณ
//ณ mv_par07              Estado De ?           	             ณ
//ณ mv_par08              Estado Ate ?	                         ณ
//ณ mv_par09              Apurar Valor ?	                     ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
aAdd(aRegs,{cPerg,"01","Impressao      ? ","","","MV_CH1","N",03,0,0,"G","","MV_PAR01","","","","","","","","","","","","","","","","","","","","","","","","",""})

For i:=1 to Len(aRegs)
	If !dbSeek(cPerg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to FCount()
			If j <= Len(aRegs[i])
				FieldPut(j,aRegs[i,j])
			Endif
		Next
		MsUnlock()
	Endif
Next

DbSelectArea(_sAlias)

Return Nil


Static Function VERFATSC6()
	
	Local l_Ret := .F.
	
	DbSelectArea('SC6')
	DbSetOrder(1)
	DbSeek(xFilial('SC6')+SZ0->Z0_PEDIDO)
	While SC6->(!EOF()) .and. SC6->C6_NUM = SZ0->Z0_PEDIDO
		If !Empty(SC6->C6_NOTA)
			l_Ret := .T.
		EndIf
		SC6->(DbSkip())
	EndDo

Return l_Ret



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFGEN008c  บAutor  ณAlexandre Sousa     บ Data ณ  04/13/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao generica para mostrar o resultado de uma query.      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณc_Query: Query a ser excutada para obter informacoes.       บฑฑ
ฑฑบ          ณa_campos:Array contendo uma coluna com a descricao dos cam- บฑฑ
ฑฑบ          ณpos que sera mostrada na List, e outra contendo o nome dos  บฑฑ
ฑฑบ          ณcampos que serao retornados pela query.                     บฑฑ
ฑฑบ          ณc_tit: Titulo da janela.                                    บฑฑ
ฑฑบ          ณn_pos: Posicao do campo a ser retornado pela consulta.      บฑฑ
ฑฑบ          ณc_Ret: String com o valor do campo informado.               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ          ณMauro Nagata, Actual Trend, 06/04/2011                      บฑฑ
ฑฑบ          ณCustomizacao Mul-T-Lock                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function FGEN008c(c_Query, a_campos, c_tit, n_pos)

Local aSalvAmb := GetArea()
Local aVetor   := {}
Local cTitulo  := Iif( c_tit = Nil, "Tํtulo", c_tit)
Local nPos		:= Iif(n_pos = Nil, 1, n_pos)
Local n_x		:= 0
Local c_Lst		:= ''

Private oDlg	:= Nil
Private oLbx	:= Nil
Private c_Ret	:= '' 
Private bVisual
Private bSair

If Select("QRX") > 0
	DbSelectArea("QRX")
	DbCloseArea()
EndIf
TcQuery c_Query New Alias "QRX"

//+-------------------------------------+
//| Carrega o vetor conforme a condicao |
//+-------------------------------------+
While QRX->(!EOF())
	aAdd(aVetor, Array(len(a_campos[2])))
	
	For n_x := 1 to len(a_campos[2])
		aVetor[len(aVetor),n_x] := &("QRX->"+a_campos[2,n_x])
	Next
	QRX->(dbSkip())
End

If Len( aVetor ) == 0
	Aviso( cTitulo, "Nao existe dados para a consulta", {"Ok"} )
	Return
Endif

//+-----------------------------------------------+
//| Limitado a dez colunas                        |
//+-----------------------------------------------+
c_A := IIf(len(a_campos[1])>=1,a_campos[1,1],'' )
c_B := IIf(len(a_campos[1])>=2,a_campos[1,2],'' )
c_C := IIf(len(a_campos[1])>=3,a_campos[1,3],'' )
c_D := IIf(len(a_campos[1])>=4,a_campos[1,4],'' )
c_E := IIf(len(a_campos[1])>=5,a_campos[1,5],'' )
c_F := IIf(len(a_campos[1])>=6,a_campos[1,6],'' )
c_G := IIf(len(a_campos[1])>=7,a_campos[1,7],'' )
c_H := IIf(len(a_campos[1])>=8,a_campos[1,8],'' )
c_I := IIf(len(a_campos[1])>=9,a_campos[1,9],'' )
c_J := IIf(len(a_campos[1])>=10,a_campos[1,10],'' )

//+-----------------------------------------------+
//| Monta a tela para usuario visualizar consulta |
//+-----------------------------------------------+
DEFINE MSDIALOG oDlg TITLE cTitulo FROM 000,000 TO 300,500 PIXEL
@ 010,010 LISTBOX oLbx FIELDS HEADER c_A, c_B, c_C, c_D, c_E, c_F, c_G, c_H, c_I, c_J On DBLCLICK (c_Ret := oLbx:AARRAY[oLbx:NAT][nPos], oDlg:End()) SIZE 230,095 OF oDlg PIXEL	ColSizes 20,20,20,20,20,20,20,20,20,20

oLbx:SetArray( aVetor )

c_Lst := '{|| {aVetor[oLbx:nAt,1],'
For n_x := 2 to len(a_campos[2])-1
	c_Lst += '     aVetor[oLbx:nAt,'+Str(n_x)+'],'
Next
c_Lst += '    aVetor[oLbx:nAt,'+Str(len(a_campos[2]))+']}}'

oLbx:bLine := &c_Lst
c_Ret := &c_Lst
                                                                                                                                                                 
@ 118,095 Button bVisual PROMPT "Visualizar"  When .T. Size 060,020 Action(Bt_Visualc(c_Ret := oLbx:AARRAY[oLbx:NAT][nPos]), oDlg:End()) PIXEL OF oDlg MESSAGE "Visualizar Altera็ใo Selecionada"
@ 118,175 Button bSair   PROMPT "Sair"        When .T. Size 060,020 Action(oDlg:End())                  PIXEL OF oDlg MESSAGE "Finalizar Visualiza็ใo"

ACTIVATE MSDIALOG oDlg Centered

RestArea( aSalvAmb )

Return c_Ret



Static Function Bt_Visualc(pPar)  //botao gera pedido de vendas
Local nReg
Local cQuery          
Local nI
Local aStructSZ0
Local nTamSZ0
Local aCampos
Local cArqTmp
                 
aCampos :=	{{"PASTA" , "C" , 20,0},;
		 	 {"TITULO", "C" , 25,0},;
		  	 {"ORIG"  , "C" , 20,0},;
             {"ALTE"  , "C" , 20,0}}
			
cArqTmp := CriaTrab(aCampos)
DbUseArea( .T.,, cArqTmp, "TRB", .T., .F. )
IndRegua ( "TRB",cArqTmp,"PASTA",,,"Selecionando Registros...") 

nReg := pPar                           
DbSelectArea("SZ4")
DbGoTo(nReg)

DbSelectArea("SZ0")
DbSetOrder(1)
DbSeek(xFilial("SZ0")+SZ4->Z4_PEDIDO+SZ4->Z4_ITEM)
                                   
aPasta     := {"Modelo","Acabamento","Acess๓rios","Ferragens","Acabamento Plแstico","Batente","Observa็ใo","Assist๊ncia T้cnica","Outros"}
aStructSZ0 := SZ0->(DbStruct())
nTamSZ0    := Len(aStructSZ0)

For nI := 1 To nTamSZ0
    cString := AllTrim(Substr(aStructSZ0[nI,1],4,10))
    nQPasta := Val(GetAdvFVal("SX3","X3_FOLDER","Z0_"+cString,2,""))
    cPasta  := If(nQPasta = 0.Or.nQPasta > 9,"Outros",aPasta[nQPasta])  //pasta
    cTitu   := GetAdvFVal("SX3","X3_DESCRIC","Z0_"+cString,2,"")  //titulo
    cOrig   := &("SZ0->Z0_"+cString)                                                   //dado original
    cAlte   := &("SZ4->Z4_"+cString)                                                   //dado alterado
   
    If cOrig != cAlte 
       cType := Type("cOrig")
       DbSelectArea("TRB")
       RecLock("TRB",.T.)
       TRB->PASTA  := cPasta
       TRB->TITULO := cTitu
       TRB->ORIG   := AllTrim(If(cType = "N",Str(cOrig),If(cType="D",Dtoc(cOrig),cOrig)))
       TRB->ALTE   := AllTrim(If(cType = "N",Str(cAlte),If(cType="D",Dtoc(cAlte),cAlte)))
       TRB->(MsUnLock())
    EndIf
Next                  

DbSelectArea("TRB")
DbSetOrder(1)
//mBrowse( 6, 1,22,75,"TRB")
u_mybrowse()

DbCloseArea("TRB")

Return.T.    

User Function MyBrowse()
Static oDlg1

  DEFINE MSDIALOG oDlg1 TITLE "Altera็๕es" FROM 000, 000  TO 400, 850 COLORS 0, 16777215 PIXEL

    fWBrowse1()

  ACTIVATE MSDIALOG oDlg1 CENTERED

Return

//------------------------------------------------ 
Static Function fWBrowse1()
//------------------------------------------------ 
Local oWBrowse1
Local aWBrowse1 := {}

    DbSelectArea("TRB")
    DbGoTop()
    Do While !Eof()
       Aadd(aWBrowse1,{TRB->PASTA,TRB->TITULO,TRB->ORIG,TRB->ALTE})
       DbSkip()
    EndDo
    
    @ 039, 062 LISTBOX oWBrowse1 Fields HEADER "Pasta","Tํtulo","Original","Alterado" SIZE 300, 120 OF oDlg1 PIXEL ColSizes 50,80,60,60
    
    oWBrowse1:SetArray(aWBrowse1)
    oWBrowse1:bLine := {|| {aWBrowse1[oWBrowse1:nAt,1],;
                             aWBrowse1[oWBrowse1:nAt,2],;
                             aWBrowse1[oWBrowse1:nAt,3],;
                             aWBrowse1[oWBrowse1:nAt,4]}} 
    
Return