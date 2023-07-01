#INCLUDE 'Protheus.ch'

User Function Bloco()
    Local nItem      := 350
    Local nResult    := 0
    Local bBloco1    := {||}
  

    bBloco1 := ({|H| E:= 15, E:=15, Z:= 30, R := (E*Z)- H})

    nResult := eVAL(bBloco1,nItem)
Return
