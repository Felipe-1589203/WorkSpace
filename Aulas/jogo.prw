#include 'protheus.ch'

    user function adivinha()

        local nNum := RANDOMIZE(1,100)
        local nChute := 0 
        local nTent := 0

        while nChute != nNum
            nChute := val(FWInputBox("Escolha um numero entre [1 e 100]", ""))

          if nChute == nNum
             MsgInfo("Parabens voce acertou - <b> " + cValtochar(nChute) + "</b><br>ERROS: "+ cValtochar(nTent), "Fim de jogo")

          elseif nChute > nNum 
             MsgAlert("Valor alto","Tente novamente")
             nTent += 1
          else 
             MsgAlert ("Valor baixo","Tente novamento")    
             nTent += 1        
          endif

        End
    
    return
