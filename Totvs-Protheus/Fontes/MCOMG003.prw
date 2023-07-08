#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                                   MUL - T - LOCK                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºPrograma    ³ MCOMG003  ³ Gatilho AC9_OBJETO - replicar por item do pedido de compras  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAutor       ³ Actual Trend                                          ³ Data ³  03/01/11 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±± ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function MCOMG003()

Local _oDlg, oMark
Local nOpca     := 0                
Local cMarArea  := GetMark()
Local lInverte  := .F.
Local _aCpo     := {}  

Local cObjeto   := M->AC9_OBJETO                                              
Local aArea     := GetArea()

cQuery := "SELECT '"+ cMarArea +"' TMP_OK, SC7.C7_ITEM, SC7.C7_PRODUTO, SC7.C7_XPRDIMP, SC7.C7_DESCRI"
cQuery += "  FROM "+ RetSQLName( 'SC7' ) +" SC7"
cQuery += " WHERE SC7.C7_FILIAL  = '"+ xFilial("SC7") +"'"
cQuery += "   AND SC7.C7_NUM     = '"+ SC7->C7_NUM    +"'"
cQuery += "   AND SC7.D_E_L_E_T_ = ' ' "
cQuery += " ORDER BY SC7.C7_ITEM"

cAliasA	:= GetNextAlias()
cQuery  := ChangeQuery(cQuery)

DbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cAliasA , .F., .T.)
aEval( SC7->(dbStruct()),{|x| If(x[2]!="C", TcSetField(cAliasA,AllTrim(x[1]),x[2],x[3],x[4]),Nil)})

_aStruct := (cAliasA)->(DbStruct())
cArqTMP  := CriaTrab( _aStruct )
DbUseArea( .T.,__LocalDriver, cArqTMP, "TMP", .T. , .F. )
IndRegua("TMP" , cArqTMP, "C7_ITEM" ,,,"Criando Indice..." )

DbSelectArea("TMP")     
Append From &cAliasA
( cAliasA )->( DbCloseArea())

DbSelectArea( "TMP" )                        
TMP->( DbGoTop() )                                                             
                                                                 
For _n1 := 1 to Len(_aStruct)
	If AllTrim(_aStruct[_n1,1]) == "TMP_OK"
		aAdd(_aCpo  ,{"TMP_OK",,"", "@BMP"})
	Else
		aAdd(_aCpo  ,{_aStruct[_n1,1],, RetTitle(_aStruct[_n1,1]) , PesqPict( &("'"+Left(_aStruct[_n1,1],3)+"'"), _aStruct[_n1,1] )   })
	EndIf
Next _n1

Define MsDialog _oDlg Title " Selecione Item do pedido a ser copiado conhecimento " From 000,000 TO 400,645 Pixel

oMark 						:= MsSelect():New(	"TMP", "TMP_OK" , "" , _aCpo , @lInverte, @cMarArea ,{ 020,005,200,320 },,, _oDlg)
oMark:bAval               	:= {|| ( G003MARK(cMarArea,oMark,"TMP","TMP_OK") , oMark:oBrowse:Refresh() ) }
oMark:oBrowse:lhasMark    	:= .T.
oMark:oBrowse:lCanAllmark 	:= .F.
oMark:oBrowse:bAllMark   	:= {|| ( G003MALL(cMarArea,oMark,"TMP","TMP_OK") , oMark:oBrowse:Refresh() ) }

Activate MsDialog _oDlg Centered On Init EnchoiceBar(_oDlg, { || nOpca:=1,_oDlg:End()}, { || nOpca:=0,_oDlg:End()})

If nOpca == 1

EndIf                                        

TMP->( DbCloseArea())

RestArea(aArea)

Return(cObjeto)
                                                      
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                                   MUL - T - LOCK                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºPrograma    ³ G003MARK  ³ Marca e desmarca apenas 1 item do  browse                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros  ³ExpC1 = Marcacao do Browse                             ³      ³           º±±
±±º            ³ExpO2 = Objeto do Browse                               ³      ³           º±±
±±º            ³ExpC3 = Alias da tabela do browse                      ³      ³           º±±
±±º            ³ExpC4 = Campo de marcacao                              ³      ³           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAutor       ³ Actual Trend                                          ³ Data ³  03/01/11 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function G003MARK(cMarArea,oMark,_cAlias,_cCpo)

Local nReg := (_cAlias)->(Recno())

RecLock(_cAlias, .F.)
If Empty((_cAlias)->&_cCpo)
	(_cAlias)->&_cCpo := cMarArea
Else
	(_cAlias)->&_cCpo := ""
EndIf
MsUnlock()

(_cAlias)->(DbGoTo(nReg))
oMark:oBrowse:Refresh(.T.)

Return Nil

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                                   MUL - T - LOCK                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºPrograma    ³ G003MALL  ³ Marca e desmarca todos os itens do  browse                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros  ³ExpC1 = Marcacao do Browse                             ³      ³           º±±
±±º            ³ExpO2 = Objeto do Browse                               ³      ³           º±±
±±º            ³ExpC3 = Alias da tabela do browse                      ³      ³           º±±
±±º            ³ExpC4 = Campo de marcacao                              ³      ³           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAutor       ³ Actual Trend                                          ³ Data ³  03/01/11 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function G003MALL(cMarArea,oMark,_cAlias,_cCpo)

Local nReg  := (_cAlias)->(Recno())

(_cAlias)->(DbGoTop())
While (_cAlias)->(!Eof())
	RecLock((_cAlias), .F.)
	If Empty((_cAlias)->&_cCpo)
		(_cAlias)->&_cCpo := cMarArea
	Else
		(_cAlias)->&_cCpo := ""
	EndIf
	MsUnlock()
	(_cAlias)->(DbSkip())
End-While

(_cAlias)->(DbGoTo(nReg))
oMark:oBrowse:Refresh(.T.)

Return Nil