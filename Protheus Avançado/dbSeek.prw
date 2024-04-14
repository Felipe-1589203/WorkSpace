#INCLUDE 'Protheus.ch'
#INCLUDE 'TOPConn.ch'
#include "TbiConn.ch"
#include "TbiCode.ch"
#include 'totvs.ch'

User Function dbseek1()

    RpcSetType(3)
    PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "COM"

    dbselectarea('SA2')
    dbsetorder(retOrder("SA2", "A2_FILIAL+A2_COD"))
    cChaveIndice := IndexKey(retOrder("SA2", "A2_FILIAL+A2_COD"))
    cChavedeBusca := "  000006"
    dbSeek(cChavedeBusca)
    cNome := SA2->A2_NOME

    RESET ENVIRONMENT

Return
