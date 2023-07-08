#INCLUDE 'Rwmake.ch'

User Function valdd()
 // Local cArea := Alias(),n_Rec:=Recno(),c_Ind:=IndexOrd()
    Local aArea := GetArea()//SUbstitui a linha de cima
    Local cCod  := SB1->B1_COD,lDel:=.T.

    MsgBox("Verificando amarração do produto: "+cCod,"Atenção!!!")
    DbSelectArea("SC4")

    iF DbSeek(xFilial("SC4")+cCod)//Verifica se existe Previsão de Vendas
        If MsgBox("Deseja excluir a Previsão de Vendas","Previsão de Venda","YESNO")
           lDel:=.T.
           If Reclock("SC4")
              DbDelete()
           Else
              MsgBox("Registro em uso, produto não será excluído")
              lDel:=.F.
           EndIf 
        Else
           MsgBox("Produto não será excluído")
           lDel:=.F.           
        EndIf    
    EndIf
    RestArea(aArea)//Substitui as três linhas acima   
Return(lDel)
