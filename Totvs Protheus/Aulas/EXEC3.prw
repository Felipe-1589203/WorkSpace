#INCLUDE 'Rwmake.ch'


User Function EXEC3()

    If M->E1_TIPO == "DP".AND.M->E1_CLIENTE="000001".AND.M->E1_LOJA="01"
        n_Valor := M->E1_VALOR*1.5
    Else 
        n_Valor := M->E1_VALOR
    ENDIF        

Return(n_Valor)
