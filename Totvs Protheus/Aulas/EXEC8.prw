#Include 'Rwmake.ch'

User Function EXEC8()
   cAlias    := "SX5"
   cCadastro := "Tabelas"
   aRotina   := { {"Pesquisar","AxPesqui",0,4},;
                  {"Alterar"  ,"AxAltera",0,1} }
   DbSelectArea(cAlias)
   DbSetOrder(1)

   If UPPER(SubStr(cUsuario,7,15))<>"ADMINISTRADOR"
            Set Filter To X5_TABELA == "12" .AND. AllTrim(X5_CHAVE) $ "SP/RJ/MG/ES"
    EndIf 

    Mbrowse(6,1,22,75,CALIAS)
    Set Filter To     
   
Return
