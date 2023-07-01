#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'FWMVCDEF.CH'

//-------------------------------------------------------------------
/*/{Protheus.doc} MOD1_MVC
montagem tela para um tabela em MVC

@author Paulo Bindo
@since 01/10/2021
@version P12

/*/
//-------------------------------------------------------------------
User Function MOD1_MVC()
Local oBrowse

oBrowse := FWMBrowse():New()
oBrowse:SetAlias('SZ1')
oBrowse:SetDescription('Cadastro de Vendedor')
oBrowse:AddLegend("Z1_TIPO== 'D'","BLUE","Revendedor")
oBrowse:AddLegend("Z1_TIPO== 'M'","GREEN" ,"Solidario")
//oBrowse:SetFilterDefault( "Z1_TIPO=='M'" )

oBrowse:DisableDetails()
oBrowse:Activate()

Return NIL


//-------------------------------------------------------------------
/*/{Protheus.doc} MenuDef
montagem menu em MVC

@author Paulo Bindo
@since 01/10/2021
@version P12
/*/
//-------------------------------------------------------------------

Static Function MenuDef()
Local aRotina := {}

ADD OPTION aRotina TITLE 'Pesquisar'  ACTION 'PesqBrw'          OPERATION 1 ACCESS 0
ADD OPTION aRotina TITLE 'Visualizar' ACTION 'VIEWDEF.MOD1_MVC' OPERATION 2 ACCESS 0
ADD OPTION aRotina TITLE 'Incluir'    ACTION 'VIEWDEF.MOD1_MVC' OPERATION 3 ACCESS 0
ADD OPTION aRotina TITLE 'Alterar'    ACTION 'VIEWDEF.MOD1_MVC' OPERATION 4 ACCESS 0
ADD OPTION aRotina TITLE 'Excluir'    ACTION 'VIEWDEF.MOD1_MVC' OPERATION 5 ACCESS 0
ADD OPTION aRotina TITLE 'Imprimir'   ACTION 'VIEWDEF.MOD1_MVC' OPERATION 8 ACCESS 0
ADD OPTION aRotina TITLE 'Copiar'     ACTION 'VIEWDEF.MOD1_MVC' OPERATION 9 ACCESS 0
Return aRotina



//-------------------------------------------------------------------
/*/{Protheus.doc} ModelDef
montagem modelo dados em MVC

@author Paulo Bindo
@since 01/10/2021
@version P12
/*/
//-------------------------------------------------------------------

Static Function ModelDef()
Local oStruSZ1 := FWFormStruct( 1, 'SZ1', /*bAvalCampo*/,/*lViewUsado*/ )
Local oModel

oModel := MPFormModel():New('MOD1MVCM', /*bPreValidacao*/, /*bPosValidacao*/, /*bCommit*/, /*bCancel*/ )

//oModel := MPFormModel():New('MOD1MVCM', /*bPreValidacao*/, { |oMdl| MOD1CPOS( oMdl ) }, /*bCommit*/, /*bCancel*/ )

oModel:AddFields( 'SZ1MASTER', /*cOwner*/, oStruSZ1, /*bPreValidacao*/, /*bPosValidacao*/, /*bCarga*/ )

oModel:SetPrimaryKey({'Z1_FILIAL', 'Z1_CLIENT', 'Z1_LOJA' })

oModel:SetDescription( 'Modelo de Dados do Vendedor' )

oModel:GetModel( 'SZ1MASTER' ):SetDescription( 'Dados do Vendedor' )

oModel:SetVldActivate( { |oModel| MOD1ACT( oModel ) } )                        
//oStruSZ1:RemoveField( 'Z1_FATOR' ) 






Return oModel

//-------------------------------------------------------------------
/*/{Protheus.doc} ViewDef
montagem view  em MVC

@author Paulo Bindo
@since 01/10/2021
@version P12
/*/
//-------------------------------------------------------------------

Static Function ViewDef()
Local oModel   := FWLoadModel( 'MOD1_MVC' ) //ModelDef() //FWLoadModel( 'MOD1_MVC' )
Local oStruSZ1 := FWFormStruct( 2, 'SZ1' )
Local oView  

oView := FWFormView():New()
oView:SetModel( oModel )
oView:AddField( 'VIEW_SZ1',oStruSZ1, 'SZ1MASTER' )
//oStruSZ1:RemoveField( 'Z1_FATOR' )
oView:CreateHorizontalBox( 'TELA' , 100 )
oView:SetOwnerView( 'VIEW_SZ1', 'TELA' )
oView:SetCloseOnOk({||.T.})

Return oView

//-------------------------------------------------------------------
/*/{Protheus.doc} MOD1CPOS
montagem view  em MVC

@author Paulo Bindo
@since 01/10/2021
@version P12
/*/
//-------------------------------------------------------------------

Static Function MOD1CPOS( oModel )
Local nOperation := oModel:GetOperation()
Local lRet       := .T.

If nOperation == 4 .OR. 3
	If Empty(oModel:GetValue("SZ1MASTER","Z1_MVC"))
		Help( ,, 'HELP',, 'Informe o campo TIPO',1, 0)
		lRet := .F.
	EndIf
EndIf

Return lRet


//-------------------------------------------------------------------
/*/{Protheus.doc} MOD1ACT
valida se pode excluir

@author Paulo Bindo
@since 01/10/2021
@version P12
/*/
//-------------------------------------------------------------------

Static Function MOD1ACT( oModel )
Local aArea      := GetArea()
Local cQuery     := ''
Local cTmp       := ''
Local lRet       := .T.
Local nOperation := oModel:GetOperation()

If nOperation == 5 .AND. lRet

	cTmp    := GetNextAlias()

	
	cQuery  := " SELECT Z1_CLIENT FROM " + RetSqlName( 'SZ1' ) + " Z1 "
	cQuery  += " WHERE EXISTS ( "
	cQuery  += "       SELECT 1 FROM " + RetSqlName( 'SA1' ) + " A1 "
	cQuery  += "        WHERE Z1_CLIENT = A1_COD AND Z1_LOJA = Z1_LOJA"
	cQuery  += "          AND A1.D_E_L_E_T_ <> '*' ) "
	cQuery  += "   AND Z1_CLEINT = '" + SZ1->Z1_CLIENT  + "' "
	cQuery  += "   AND Z1.D_E_L_E_T_ = ' ' "
	cQuery := ChangeQuery(cQuery)

	dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ) , cTmp, .F., .T. )

	lRet := (cTmp)->( EOF() )

	(cTmp)->( dbCloseArea() )

	If !lRet
		Help("Especifico",1,"HELP","PROCESSAMENTO","Este Cadastro nao pode ser excluido!", 1, 0,,,,,,{"Desvincule a conta bancaria."})
	EndIf

EndIf

RestArea( aArea )

Return lRet



