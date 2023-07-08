#INCLUDE 'PROTHEUS.CH'


User Function TESTEVAR()
   Local nNumero  := 10.5
   Local cNumero  := ""
   Local dData    := Ctod("01/12/2021")
   Local cData     
   Local sData    
   Local cTexto   := "AULA PRATICA"
   Local cTexto2  := ""

    cData   := Dtoc(dData)
    sData   := Dtos(dData)
    cNumero := cValToChar(nNumero)
    cTexto2 := Left(cTexto,5)
    cTexto2 := SubStr(cTexto,1,5)
    cTexto2 := Capital(cTexto2)
    cTexto2 := Upper(cTexto2)
    cTexto2  := Replace(cTexto2,"A","O")

Return
