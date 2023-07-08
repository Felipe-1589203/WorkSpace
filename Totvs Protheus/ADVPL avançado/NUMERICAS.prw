#INCLUDE 'Protheus.ch'


User Function numericas()
    Local nNumero    := 13
    Local nResultado := 0 
    Local cTexto     := ""
    Local aArray     := {}
    Local dTeste

    nResultado := Round(nNumero/2,3)
    nResultado := Round(nResultado,2)

    Alert(ValType(nNumero))
    Alert(ValType(nResultado))
    Alert(ValType(cTexto))
    Alert(ValType(aArray))
    Alert(ValType(dTeste))
Return
