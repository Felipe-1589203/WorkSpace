#INCLUDE 'Protheus.ch'
#INCLUDE 'Totvs.ch'



    User function teste()

        
        Local cSau := "Saúde Boa",cTem := "Tempo ensolardo"
        

        If !cSau == ("Saúde Boa") .and. !cTem == ("Tempo ensolarado")
            MsgAlert("Vou a praia hoje")
        Else
            MsgAlert("Não vou a praia hoje")  
        Endif     

    Return
