#INCLUDE "rwmake.ch" 
#INCLUDE "TOPCONN.CH"       
/*
||*************************************************************************||
||-------------------------------------------------------------------------||
||*********|**********|*******|********************|******|****************||
||Programa |FGEN016   |Autor  |Sérgio Silveira     | Data | 01/06/2006     ||
||*************************************************************************||
||Descricao|  Permite a edição do SX5 através de uma mbrowse               ||
||*************************************************************************||
||Uso      | Generico     |                                                ||
||*************************************************************************||
*/
USER FUNCTION FGEN016(_cCodTab, _cTXTDescr, _lxIntRef, _axTabLink, _axFieldLink)   

/*---------------------------------------------------------------------------
Parâmetros:

Obrigatórios:
1)_cCodTab     -> Código da Tabela
2)_cTXTDescr   -> Nome Descritivo da Tabela (Cabeçalho da Mbrowse)  
3)_lxIntRef    -> Usa Integridade Referencial? 

Obrigatórios apenas para qdo o parâmetro 3 for .T.:
4)_axTabLink   -> Vetor com os Alias das Tabelas referenciadas
5)_axFieldLink -> Vetor com os nomes dos campo a serem referenciados nas tabelas.

-----------------------------------------------------------------------------*/

Local   _aArea      := GetArea() 
Private _cString    := ""
Private _lIntRef    := _lxIntRef
Private _aTabLink   := Aclone(_axTabLink)
Private _aFieldLink := Aclone(_axFieldLink)
        

Dbselectarea("SX5")   
DbSetOrder(1)
_cString := alias()


cCadastro:=  OEMTOANSI(_cTXTDescr)

aRotina := {{"Pesquisar"           ,"AxPesqui"               ,0,1},;
            {"Visualizar"          ,"U_VisualSX5(_cString)"  ,0,2},;
            {"Incluir"             ,"U_IncluiSX5(_cString)"  ,0,3},;
            {"Alterar"             ,"U_AlteraSX5(_cString)"  ,0,4},;        
            {"Excluir"             ,"U_DeletaSX5(_cString, _lIntRef, _aTabLink, _aFieldLink)"  ,0,5,5} } 
                                                              			 

dbSelectArea(_cString)
//DbSetFilter( {|| SX5->X5_FILIAL == xFilial('SX5') .AND. Alltrim(SX5->X5_TABELA) == Alltrim(_cCodTab) }, "SX5->X5_FILIAL == xFilial('SX5') .AND. Alltrim(SX5->X5_TABELA) == Alltrim(_cCodTab)" ) 

_cIndSX5 := CriaTrab(NIL,.F.)
_cOrdSX5 := "X5_TABELA+X5_CHAVE"
_cConSX5 := " SX5->X5_FILIAL == '"+xFilial('SX5')+"' .AND. Alltrim(SX5->X5_TABELA) == '"+Alltrim(_cCodTab)+"' "
IndRegua("SX5",_cIndSX5,_cOrdSX5,,_cConSX5,"Indexando Arquivo SX5")

nIndex := RetIndex("SX5")
dbSetOrder(nIndex+1)
dbGotop()

MBrowse( 6,1,22,75,_cString)                 

dbSelectArea("SX5")
dbSetOrder(1)
Ferase(_cIndSX5+OrdBagExt())
RestArea(_aArea)             

Return

//----------------------------------------------

USER FUNCTION VisualSX5(_cString)

 AxVisual(_cString, Recno(), 2, {"X5_CHAVE","X5_DESCRI"} )     
 
RETURN 
       
//----------------------------------------------

USER FUNCTION IncluiSX5(_cString)
Local _nOpc        := 0   
Local _cTabCurrent := SX5->X5_TABELA 
         
 RecLock("SX5",.T.)
    SX5->X5_TABELA := _cTabCurrent 
 MsUnLock()
 
_nOpc := AxAltera(_cString, Recno(), 3, {"X5_CHAVE","X5_DESCRI"}, {"X5_CHAVE","X5_DESCRI"} )     
 

 If _nOpc <> 1
    RecLock("SX5",.F.)
       DbDelete()
    MsUnLock()
 EndIf
 
 
RETURN 

//----------------------------------------------

USER FUNCTION AlteraSX5(_cString)

 AxAltera(_cString, Recno(), 4, {"X5_CHAVE","X5_DESCRI"}, {"X5_DESCRI"} )     
 
RETURN 

//----------------------------------------------

USER FUNCTION DeletaSX5(_cString, _lIntRef, _aTabLink, _aFieldLink)

Local _lDelete := .F.      

 If (_lIntRef )
    _lDelete:=U_ChkIntRef( _aTabLink, _aFieldLink, SX5->X5_CHAVE)
 Else
    _lDelete := .T.
 EndIf
 
 If (_lDelete) 
    AxDeleta(_cString, Recno(), 5 )     
 Else
    MsgBox(OemToAnsi("Esse Item não poderá ser excluído porque está em uso em outro(s) Cadastro(s)!"),"Integridade Referencial","STOP")
 EndIf
 
RETURN 
         
//----------------------------------------------

USER FUNCTION ChkIntRef( _aTabLink, _aFieldLink, _cChave)

Local _lDeleta      := .T.
Local _aArea        :=  GetArea()   
Local cQuery        := ""  
Local _nI           := 0   
Local _nQtdeReg     := 0    

For _nI := 1 To Len(_aTabLink)
   
    _nQtdeReg := 0
     
    cQuery := "SELECT "+_aFieldLink[_nI]+" "
    cQuery += "FROM "+RetSqlName(_aTabLink[_nI]) +" "
    cQuery += "WHERE "+_aFieldLink[_nI]+" = '"+_cChave+"' AND "
    cQuery += RetSqlName(_aTabLink[_nI])+".D_E_L_E_T_ <> '*' "
    cQuery += "GROUP BY "+_aFieldLink[_nI]+" "
    cQuery := ChangeQuery(cQuery)

    TCQUERY cQuery NEW ALIAS "TAB"  
      
    Dbselectarea("TAB")   
    While(!EOF())
        _nQtdeReg++
        DbSkip()
    EndDo  
    
    TAB->(DbCloseArea())
    
    If _nQtdeReg > 0
       _lDeleta  := .F.
       Exit
    EndIf
    
Next

RestArea(_aArea)

RETURN(_lDeleta)
