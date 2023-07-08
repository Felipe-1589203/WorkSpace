#INCLUDE 'Protheus.ch'
#INCLUDE 'topconn.ch'
#INCLUDE 'rwmake.ch'

    User function dowhile()

        Local lLogic := .T.
        Local nVar   := 0
        Local cVar   := 'Numeros: '

        Do While lLogic 
            cVar += AllTrim(Str(nVar))+','            
            nVar--
            If nVar > -10
                lLogic := .F.
            ENDIF
        EndDo 

        Alert(cVar)        

    Return
