#Include "TOTVS.ch"

// FUNÇÃO PRINCIPAL
User function PBFWMSG()
    Local oSay := NIL // CAIXA DE DIÁLOGO GERADA

    // GERA A TELA DE PROCESSAMENTO
    FwMsgRun(NIL, {|oSay| RunMessage(oSay)}, "Processing", "Starting process...")
Return 

// FUNÇÃO PARA ALTERAÇÃO DA MENSAGEM
Static Function RunMessage(oSay)
    Local nX := 0 // CONTROLE CONTADOR DO LAÇO

    // SIMULA A PREPARAÇÃO PARA EXECUÇÃO
    Sleep(2000)

    // LAÇO COM PAUSA DE UM SEGUNDO PARA SIMULAÇÃO
    For nX := 1 To 10
        oSay:SetText("Working at: " + StrZero(nX, 6)) // ALTERA O TEXTO CORRETO
        ProcessMessage() // FORÇA O DESCONGELAMENTO DO SMARTCLIENT

        Sleep(1000) // SIMULA O PROCESSAMENTO DA FUNÇÃO
    Next nX
Return
