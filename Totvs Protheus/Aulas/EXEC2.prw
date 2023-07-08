#INCLUDE 'Rwmake.ch'

//-----------------------------------------------------------
/*/{Protheus.doc} exec2
@Description -> programa para retornar variavel na memória
@Author Felipe Souza -> Actual Trend 
@Since 15/12/2023
/*/
//-----------------------------------------------------------  

User Function EXEC2() 
    Local cNome1,cCep,cTipo,cEst,cFant,cEnd,nLoja:= ""
    Local cNome2 := ""
    If M->A1_COD:="000001"
      
       cNome2:= cNome1 :="Felipe Souza Dos Santos"
                nLoja :="001"
                cEnd  :="Rua Renato Aparecido leal"
                cFant :="Felipe .S"
                cCep  :="06654550"
                cTipo :="R"   
                cEst  :="SP"            
    Else 
        cNome:=M->A1_NOME;nLoja:=M->A1_LOJA;cEnd:=A1_END;cFant:=M->A1_NREDUZ;cCep:=M->A1_CEP;cTipo:=M->A1_TIPO;cEst:=M->A1_EST      

    EndIf    
Return(cNome,nLoja,cEnd,cFant,cCep,cTipo,cEst) 
