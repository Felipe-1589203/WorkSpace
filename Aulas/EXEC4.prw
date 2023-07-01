#INCLUDE 'Rwmake.ch'

User Function EXEC4()

    Local aFone:= {} 
    Local nP   := 0
    Local cRet := ""

    aAdd(aFone,{"SP","11"})
    aAdd(aFone,{"RJ","21"})
    aAdd(aFone,{"MG","31"})
    aAdd(aFone,{"AM","91"})
    aAdd(aFone,{"BA","71"})  
    nP:=aScan(aFone,{|x|x[1]==M->A1_EST})
    If nP <> 0
        cRet:=aFone[nP][2]    
    EndIf     
Return(cRet)
