#INCLUDE 'Rwmake.ch'
#INCLUDE 'Protheus.ch'

User Function Exec10()
    Private cCadastro := "Solicitação de Software"
    Private aRotina   := { {"Excluir"   ,"u_Mod2Manut",0,1},;
                           {"Pesquisar" ,"AxPesqui"   ,0,2},;
                           {"Incluir"   ,"u_Mod2Manut",0,3},;
                           {"Alterar"   ,"u_Mod2Manut",0,4},;
                           {"Visualizar","u_Mod2Manut",0,5} }
    dbSelectArea("SZ4")
    dbSetOrder(1)
    dbGoTop()                       
mBrowse(6,1,22,75,"SZ4")
Return
