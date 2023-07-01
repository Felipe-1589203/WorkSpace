#include "rwmake.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MFATA007  ºAutor  ³Alexandre Sousa     º Data ³  11/10/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Manutencao da Ficha tecnica.                                º±±
±±º          ³Imprime e gera empenhos na op.                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³Especifico MULTLOCK.                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MFATA007()

	SetPrvt("AROTINA,CARQF3,CCAMPOF3,XCONTEUDO,CCADASTRO,")

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define Variaveis                                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	aCores := {{'!EMPTY(Z0_STATUS)','DISABLE'},;
				{'EMPTY(Z0_STATUS)','ENABLE'}}

	aRotina :=  {{"Pesquisa"	,"AxPesqui"  , 0, 1},;
	            {"Visualiza"	,"AxVisual"  , 0, 2},;
	            {"Altera"  		,"U_FATA007d", 0, 4 },;
	            {"Imprimir"		,"U_FATA007a", 0, 2},;
	            {"Legenda"		,'U_FATA007b', 0, 5,0},;
	            {"Empenhos"		,'U_FATA007c', 0, 6,0},;
	            {"Estorno"		,'U_FATA007e', 0, 7,0}}

	CCADASTRO:="Manutenção da Ficha Técnica"
	dbSelectArea("SZ0")
	dbSetOrder(1)  
	mBrowse( 6, 1,22,76,"SZ0",,,,,,aCores)
	dbSelectArea("SZ0")
	dbSetOrder(1)

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FATA007a  ºAutor  ³Alexandre Sousa     º Data ³  11/10/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Imprime a Ficha Tecnica via html.                           º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FATA007a()

	Private c_FechElt := ''
	Private c_descfhe := ''
	
	Private c_kitabpf := ''
	Private c_desckta := ''
	
	Private c_molaaer := ''
	Private c_descmla := ''
	
	Private c_altfdp  := ''
	Private c_htmbat  := ''

	If !Empty(SZ0->Z0_FECHELE)
		c_FechElt := SZ0->Z0_FECHELE
		c_descfhe := GetAdvFval('SB1', 'B1_DESC', xfilial('SB1')+c_FechElt, 1, '')
	EndIf

//	If SZ0->Z0_KITABER = 'S'
    c_kitabpf := SZ0->Z0_KITABER //SUPERGETMV('MV_XKITAPF')
//	c_desckta := GetAdvFval('SB1', 'B1_DESC', xfilial('SB1')+c_kitabpf, 1, '')
//	EndIf

//	If SZ0->Z0_MOLAA = 'S'
	c_molaaer := SZ0->Z0_MOLAA //SUPERGETMV('MV_XMOLAA')
	c_descmla := GetAdvFval('SB1', 'B1_DESC', xfilial('SB1')+c_molaaer, 1, '')
//	EndIf

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
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Criacao da Interface                                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	@ 336,470 To 451,720 Dialog mkwdlg Title OemToAnsi("Impressão")
	@ 11,12 Say OemToAnsi("Imprimir item:") Size 33,8
	@ 22,50 Say OemToAnsi("de") Size 9,8
	@ 21,13 Get n_item valid VALIDITIMP() picture '@E 999' Size 34,10
	@ 21,63 Get n_qtdp when .F. Size 34,10
	@ 42,78 Button OemToAnsi("OK") Size 29,11 Action (c_ok:=1, close(mkwdlg))
	Activate Dialog mkwdlg

	DbSelectArea('SX1')
	dbSeek(padr(cPerg,10)+'01')
	RecLock('SX1',.F.)
	SX1->X1_CNT01 := strzero(n_item)
	MsUnLock()

	DbSelectArea('SZ0')

	If SZ0->Z0_ALTURA <> 0
		c_altfdp += '           <tr>'
		c_altfdp += '             <td height="32" bordercolor="#333333" align="center" class="style5">Altura:</td>
		c_altfdp += '             <td width="120" bordercolor="#333333"><span class="style5">'+TRANSFORM(SZ0->Z0_ALTURA ,'@E 999,999,999')+' mm</span></td>
		c_altfdp += '             <td colspan="3" bordercolor="#333333"><span class="style5">*** ATENÇÃO: ALTURA FORA DO PADRÃO *** </span></td>'
		c_altfdp += '           </tr>'
	EndIF

	If !Empty(SZ0->Z0_BATENTE)
		c_htmbat := "    <tr> " 
		c_htmbat += '      <td width="87%"><font face="Calibri" size="2">&nbsp;<b>1.5 Batente:</b></font></td>'
		c_htmbat += "    </tr>" 
		c_htmbat += "    <tr>" 
		c_htmbat += '      <td width="87%">'
		c_htmbat += '        <div align="center">'
		c_htmbat += '          <table border="1" cellpadding="0" cellspacing="0" width="100%">'
		c_htmbat += "            <tr>" 
		c_htmbat += '              <td width="18%"><font face="Calibri" size="2">&nbsp;Batente:</font> </td>'
		c_htmbat += '              <td width="15%"><font face="Calibri" size="2">&nbsp;'+SZ0->Z0_BATENTE+'</font></td>'
		c_htmbat += '              <td width="67%"><font face="Calibri" size="2">&nbsp;' + GetAdvFval('SB1','B1_DESC', xFilial('SB1')+SZ0->Z0_BATENTE,1,'XX') + '</font></td>'
		c_htmbat += "            </tr>" 
		c_htmbat += "            <tr>" 
		c_htmbat += '              <td width="18%"><font face="Calibri" size="2">&nbsp;Fech. Elétrica:</font>'
		c_htmbat += "              </td>" 
		c_htmbat += '              <td width="15%"><font face="Calibri" size="2">&nbsp;'+c_FechElt+'</font></td>'
		c_htmbat += '              <td width="67%"><font face="Calibri" size="2">&nbsp;'+c_descfhe+'</font></td>' 
		c_htmbat += "            </tr>"
		c_htmbat += "            <tr>"
		c_htmbat += '              <td width="18%"><font face="Calibri" size="2">&nbsp;Observações:</font> </td>'
		c_htmbat += '              <td width="82%" colspan="2"><font face="Calibri" size="2">&nbsp;'+SZ0->Z0_OBSBAT+'</font></td>'
		c_htmbat += "            </tr> "
		c_htmbat += "          </table> "
		c_htmbat += "        </div>"
		c_htmbat += "      </td>"
		c_htmbat += "    </tr>"
	EndIf
                             
    Do Case
	   Case Z0_STATALT = 'P'
	        cStatus :=  '[ Em Análise pelo PCP ]'
	   Case Z0_STATALT = 'A' 
	        cStatus :=  '[ Aprovado pelo PCP ]' 
	   Case Z0_STATALT = 'R' 
	        cStatus :=  '[ Rejeitado pelo PCP ]' 
	   Case Z0_STATALT = '1' 
	        cStatus :=  '[ Aprovado Crédito ]'
	   Case Z0_STATALT = '0' 
	        cStatus :=  '[ Alteração Rejeitada ]' "
	   Case Z0_STATALT = 'C'
	        cStatus :=  '[ Em Análise pelo Crédito ]' 
    EndCase
    
	DbSelectArea("SC5")
	DbSetOrder(1)
	DbSeek(xFilial("SC5")+SZ0->Z0_PEDIDO)
	
	DbSelectArea('SC6')
	DbSetOrder(1) //C6_FILIAL, C6_NUM, C6_ITEM, C6_PRODUTO, R_E_C_N_O_, D_E_L_E_T_
	DbSeek(xFilial('SC6')+SZ0->(Z0_PEDIDO+Z0_ITEM))
	
	cPath := AllTrim(GetTempPath())
	If Empty(SZ0->Z0_MODELO)
		U_FGEN009("\html\MFATA007b.html", cPath+"SIGA.html")	
	Else
		U_FGEN009("\html\MFATA007.html", cPath+"SIGA.html")	
	EndIf
	
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FATA007b  ºAutor  ³Alexandre Sousa     º Data ³  03/04/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Legenda do Status da Ficha Tecnica.                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FATA007b()

	Local aCores := {} 
	                   
	aAdd(aCores,{"BR_VERDE"   ,"Empenho Pendente" })
	aAdd(aCores,{"BR_VERMELHO","Empenho Gerado" })
	BrwLegenda(cCadastro,"Legenda",aCores)

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FATA007d  ºAutor  ³Alexandre Sousa     º Data ³  03/04/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Realiza a alteracao da Ficha Tecnica.                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FATA007d(cpar1, cpar2, cpar3)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Verifica se os empenhos ja foram gerados alguma vez.   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Empty(SZ0->Z0_STATUS)
		msgAlert("Os empenhos dessa ficha técnica já foram gerados! ", "A T E N Ç Ã O")
		Return
	EndIf

	DbSelectArea("SC6")
	DbSetOrder(1) //C6_FILIAL, C6_NUM, C6_ITEM, C6_PRODUTO, R_E_C_N_O_, D_E_L_E_T_
	If DbSeek(xFilial("SC6")+SZ0->(Z0_PEDIDO+Z0_ITEM+Z0_MODELO))
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Verifica se ja foi aberta a OP para o pedido.          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(SC6->(C6_NUMOP+C6_ITEMOP))
			msgAlert("O pedido de vendas já possui OP aberta! Não poderá ser alterada!!!", "A T E N Ç Ã O")
			Return
		EndIf
    EndIf

	AxAltera(cpar1, cpar2, cpar3)

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FATA007c  ºAutor  ³Alexandre Sousa     º Data ³  03/04/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Realiza os empenhos contra a OP.                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FATA007c()
                                                                            

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Verifica se os empenhos ja foram gerados alguma vez.   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Empty(SZ0->Z0_STATUS)
		msgAlert("Os empenhos dessa ficha técnica já foram gerados! ", "A T E N Ç Ã O")
		Return
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Pesquisa se o pedido ja tem uma OP aberta              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DbSelectArea("SC6")
	DbSetOrder(1) //C6_FILIAL, C6_NUM, C6_ITEM, C6_PRODUTO, R_E_C_N_O_, D_E_L_E_T_
	If DbSeek(xFilial("SC6")+SZ0->(Z0_PEDIDO+Z0_ITEM+Z0_MODELO))

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Verifica se ja foi aberta a OP para o pedido.          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If Empty(SC6->(C6_NUMOP+C6_ITEMOP))
			msgAlert("O pedido de vendas ainda não possui OP aberta!", "A T E N Ç Ã O")
			Return
		EndIf
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Posiciona a OP para gerar os empenhos.                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		DbSelectArea("SC2")
		DbSetOrder(1) //C2_FILIAL, C2_NUM, C2_ITEM, C2_SEQUEN, C2_ITEMGRD, R_E_C_N_O_, D_E_L_E_T_
		If !DbSeek(xFilial('SC2')+SC6->(C6_NUMOP+C6_ITEMOP))
			msgAlert("Ordem de produção Nr. (" + SC6->(C6_NUMOP+C6_ITEMOP) + ") não localizada!", "A T E N Ç Ã O")
			Return
		EndIf

		If msgYesNo("Deseja atualizar agora? (Serão inseridos registros na tabela de empenhos de acordo com as informações da especificação técnica informada). ", "A T E N Ç Ã O")
			a_strut := SZ0->(DbStruct())
			
			For i := 1 to len(a_strut)
				DbSelectArea("SB1")
				DbSetOrder(1) //B1_FILIAL, B1_COD, R_E_C_N_O_, D_E_L_E_T_
				If ValType("SZ0->"+a_strut[i,1]) = 'C' .And. !Empty(&("SZ0->"+a_strut[i,1])) .And. AllTrim(a_strut[i,1]) $ "Z0_MODINT, Z0_MODEXT, Z0_CILACAB, Z0_OLHOM, Z0_FECHAD, Z0_MOLAA, Z0_CILACES, Z0_ROSACES, Z0_PARADAP, Z0_CAPADOB, Z0_FERRINT, Z0_FECHELE"
					If DbSeek(xFilial("SB1")+Alltrim(&("SZ0->"+a_strut[i,1])), .T.) 
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³Verifica se o produto tem saldo no SB2 e cria se nao tiver.     ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						DbSelectArea("SB2")
						DbSetorder(1) //B2_FILIAL, B2_COD, B2_LOCAL, R_E_C_N_O_, D_E_L_E_T_
						If !DbSeek(xFilial("SB2")+SB1->B1_COD+SB1->B1_LOCPAD, .F.)
							If msgYesNo("O produto " + AllTrim(SB1->B1_COD) + " não possui saldo na tabela SB2. Deseja Criar agora?")	
								CriaSB2(SB1->B1_COD,SB1->B1_LOCPAD)
							Else
								Loop
							EndIf
						EndIf
						
						c_TRT := ''
						DbSelectArea("SD4")
						DbSetOrder(1) //D4_FILIAL, D4_COD, D4_OP, D4_TRT, D4_LOTECTL, D4_NUMLOTE, R_E_C_N_O_, D_E_L_E_T_
						If DbSeek(xFilial("SD4")+SB1->B1_COD+SC2->(C2_NUM+C2_ITEM+C2_SEQUEN))
							While SD4->(D4_FILIAL+D4_COD+D4_OP) = xFilial("SD4")+SB1->B1_COD+SC2->(C2_NUM+C2_ITEM+C2_SEQUEN)
								c_TRT := soma1(SD4->D4_TRT)
								SD4->(DbSkip())
							EndDo
						EndIf
						
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³Verifica se o item ja existe no empenho para nao duplicar         ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						l_jatemnoemp := .F.
						DbSelectArea('SD4')
						DbSetOrder(7) //D4_FILIAL, D4_XPEDFT, D4_COD, R_E_C_N_O_, D_E_L_E_T_
						DbGotop()
						If DbSeek(xFilial('SD4')+SZ0->(Z0_PEDIDO+Z0_ITEM))
							While SD4->(!EOF()) .and. SD4->D4_XPEDFT = SZ0->(Z0_PEDIDO)
								If SD4->D4_XCAMPFT = a_strut[i,1]
									l_jatemnoemp := .T.
								EndIf
								SD4->(DbSkip())
							EndDo
						EndIf
						
						If !l_jatemnoemp
							IncEmp(SB1->B1_COD, SB1->B1_LOCPAD, c_TRT,a_strut[i,1])
						EndIf
					EndIf
				EndIf
			Next
/*			
			If !Empty(SZ0->Z0_FECHAD)
				c_FechElt := SZ0->Z0_FECHAD
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
*/			
		    
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Atualiza o FLAG da Ficha Técnica                                                   ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			RecLock("SZ0", .F.)
			SZ0->Z0_STATUS := 'X'
			MsUnLock()

		EndIf
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Verifica se ja existem empenhos para a OP selecionada. ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
/*		DbSelectArea("SD4")
//		DbSetOrder(2) //D4_FILIAL, D4_OP, D4_COD, D4_LOCAL, R_E_C_N_O_, D_E_L_E_T_
//		If DbSeek(xFilial('SD4')+SC6->(C6_NUMOP+C6_ITEMOP))
			msgAlert("Já existem itens empenhados para a OP correspondente. Utilize a rotina de ajustes de empenhos!", "A T E N Ç Ã O")
			RecLock("SZ0", .F.)
			SZ0->Z0_STATUS := 'X'
			MsUnLock()
		Else
			If msgYesNo("A ordem de produção não tem os empenhos atualizados. Deseja atualizar agora? (Serão inseridos registros na tabela de empenhos de acordo com sua estrutura", "A T E N Ç Ã O")
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Verifica se o produto tem estrutura cadastrada.        ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				DbSelectArea("SG1")
				DbSetorder(1) //G1_FILIAL, G1_COD, G1_COMP, G1_TRT, R_E_C_N_O_, D_E_L_E_T_
				If DbSeek(xFilial("SG1")+SZ0->Z0_MODELO)
					While SG1->(!EOF()) .and. SG1->G1_COD == SZ0->Z0_MODELO
						IncEmp()
						SG1->(DbSkip())
					EndDo
				Else
					msgAlert("Esse produto não tem uma estrutura cadastrada, não será possível atualizar os empenhos!", "A T E N Ç Ã O")
				EndIf
			EndIf
		EndIf
*/
		
	Else
		msgAlert("O pedido de vendas ainda não possui OP aberta!", "A T E N Ç Ã O")
	EndIf

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FATA007e  ºAutor  ³Alexandre Sousa     º Data ³  03/04/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Estorno dos empenhos gerados.                               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FATA007e()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Verifica se os empenhos ja foram gerados alguma vez.   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Empty(SZ0->Z0_STATUS)
		msgAlert("Os emepenhos dessa ficha técnica ainda não foram gerados! ", "A T E N Ç Ã O")
		Return
	EndIf

	If msgYesNo('Confirma o estorno dos empenhos gerados contra a OP?')
		DbSelectArea('SD4')
		DbSetOrder(7) //D4_FILIAL, D4_XPEDFT, D4_COD, R_E_C_N_O_, D_E_L_E_T_
		DbGotop()
		DbSeek(xFilial('SD4')+SZ0->(Z0_PEDIDO))
		l_pagouemp := .F.
		
		While SD4->(!EOF()) .and. SZ0->(Z0_PEDIDO) = SD4->D4_XPEDFT
			If SD4->D4_QTDEORI <> SD4->D4_QUANT
				l_pagouemp := .T.
			EndIf
			SD4->(DbSkip())
		EndDo
		
		If l_pagouemp
			MsgAlert('O um ou mais empenhos dessa OP ja foram pagos no estoque, verifique esse movimento antes de estornar!!!', "A T E N Ç Ã O")
			Return
		EndIf

		SD4->(DbGotop())
		SD4->(DbSeek(xFilial('SD4')+SZ0->(Z0_PEDIDO)))
		While SD4->(!EOF()) .and. SZ0->(Z0_PEDIDO) = SD4->D4_XPEDFT
			ExcEmp()
			SD4->(DbSkip())
		EndDo
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Atualiza o FLAG da Ficha Técnica                                                   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		RecLock("SZ0", .F.)
		SZ0->Z0_STATUS := ''
		MsUnLock()

	EndIf

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³IncEmp    ºAutor  ³Alexandre Martins   º Data ³  01/04/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Inclui um empenho atraves de rotina automatica.             º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function IncEmp(c_cod, cLocal, ctrt, ccmpft)

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
	aadd(aMata380,{"D4_XCAMPFT"	,ccmpft			,NIL}) // Saldo do Empenho

	msExecAuto({|x,y|MATA380(x,y)},aMata380,3)

	If lMSErroAuto
		DisarmTransaction()
		Mostraerro()
		Break
	EndIf

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ExcEmp    ºAutor  ³Alexandre Sousa     º Data ³  03/04/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Exclui os empenhos gerados contra a OP.                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
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
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³VALIDPERG º Autor ³ AP5 IDE            º Data ³  25/06/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Verifica a existencia das perguntas criando-as caso seja   º±±
±±º          ³ necessario (caso nao existam).                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ValidPerg()

Local _sAlias := Alias()
Local aRegs := {}
Local i,j

dbSelectArea("SX1")
dbSetOrder(1)
cPerg := PADR(cPerg,10)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01              Data Vendas De    	                 ³
//³ mv_par02              Data Vendas Até       	             ³
//³ mv_par03              Cliente De ?                           ³
//³ mv_par04              Cliente Ate ?                          ³
//³ mv_par05              Representante	De ?      			     ³
//³ mv_par06              Representante Ate ?				     ³
//³ mv_par07              Estado De ?           	             ³
//³ mv_par08              Estado Ate ?	                         ³
//³ mv_par09              Apurar Valor ?	                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

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

Static Function VALIDITIMP()

	Local l_Ret := .T.

	If n_item > n_qtdp
		msgAlert('O item não pode ser maior que a quantidade!!!', 'A T E N Ç Ã O')
		n_item := n_qtdp
		l_Ret := .F.
	Endif

Return l_Ret

