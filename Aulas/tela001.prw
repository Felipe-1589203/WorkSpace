#INCLUDE 'Rwmake.ch'

    User Function tela001()

      Local cVldAlt := ".T." 
      Local cValdExc:= ".T."
      Local cValdInc := ".T."   

      Private cPerg := "PEGZZ9"
      Private cString := "ZZ9"

      DbSelectArea("ZZ9")
      DbSetOrder(1)

      cPerg := "PEGZZ9"
      Pergunte(cPerg,.F.)
      SetKey(123,{|| Pergunte(Coeg,.T.)})

      AxCadastro(cString,"Cadastro de pessoas",cValdExc,cVldAlt,cValdInc)

      Set Key 123 To

    Return Nil
