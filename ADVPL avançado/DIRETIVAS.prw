#INCLUDE 'Protheus.ch'
#INCLUDE 'Totvs.ch'

User Function DIRETIVA()
    Local nValor1 := 10
    Local nValor2 := 20
    Local nResult  := 0

     nResult := RECEBE(@nValor1,nValor2)

    If nResult <> 0
       MsgInfo("O valor é: "+AllTrim(str(nResult))+" deseja continuar? Prossiga com ok!")
    else
       Alert("O valor não é diferente de zero")    
    endif 
RETURN
//----------------------------------------------------------------------------\\    
Static Function RECEBE(nValor1,nValor2)
    nRetorno := 0
    nValor1 := 20
    nRetorno := nValor1 * nValor2
    
Return(nRetorno)
