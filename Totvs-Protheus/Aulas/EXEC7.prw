#INCLUDE 'Rwmake.ch'
#INCLUDE 'Protheus.ch'

User Function EXEC7()

    cAlias    := 'SB5' 
    cCadastro := "Complemento de produtos"
    Private aRotina :=   {{"Pesquisar" ,"AxPesqui",0,1},;
                          {"Visualizar","AxVisual",0,2},;
                          {"Incluir"   ,"AxInclui",0,3},;
                          {"Alterar"   ,"Axaltera",0,4},;
                          {"Excluir"   ,"AxDeleta",0,5},;
                          {"Compl.Produtos","Mata180()",0,6} }   
    DbSelectArea(cAlias)
    DbSetOrder(1)

    mBrowse( 6,1,22,75,cAlias,"B1_PRV1")                                        

Return NIL
