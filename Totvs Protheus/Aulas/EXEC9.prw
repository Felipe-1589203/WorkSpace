#INCLUDE 'Rwmake.ch'

User Function EXEC9()
    Private cCadastro := "Cadastro de Produtos"
    Private aRotina   :=  { {"Excluir"   ,"AxExclui",0,1},;
                            {"Pesquisar" ,"AxPesqui",0,2},;
                            {"Incluir"   ,"AxInclui",0,3},;
                            {"Alterar"   ,"AxAltera",0,4},;
                            {"Visualizar","AxVisual",0,5},;
                            {"Legenda"   ,"u_Legenda()",0,6} }
        Private cDelFunc := .T. //VALIDAÇÃO PARA EXCLUSÃO.PODE-SE USAR A FUNÇÃO ExecBlock
        aCores := { {"B1_PRV1== 0","BR_VERMELHO"},;
                    {"B1_PRV1 > 0 .AND. B1_PRV1 <= 100","BR_LARANJA"},;
                    {"B1_PRV1 > 100 .AND. B1_PRV1 <= 200","BR_AZUL"},;
                    {"B1_PRV1 > 200","BR_VERDE"} }
    DbSelectArea("SB1")
    DbSetOrder(1)
    Mbrowse(6,1,22,75,"SB1",,,,,6,aCores)                                       
Return
//-------------------------------------------------------------------------------//

User Function Legenda()
    BrwLegenda(cCadastro,"Valores",{ {"BR_VERMELHO","Preço não informado"},;
                                     {"BR_LARANJA" ,"Preço > 0 <= 100"   },;
                                     {"BR_AZUL"    ,"Preço > 100 <= 200" },;
                                     {"BR_VERDE"   ,"Peço  > 200"        } } )
Return .T.
