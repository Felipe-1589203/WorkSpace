#Include 'Protheus.ch'
#INCLUDE 'Tbiconn.ch'
#INCLUDE 'Tbicode.ch'

User Function parametro()
    Local dParam 

    PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "FAT"

        dParam:= GetMv("MV_ULMES")
        dParam += 90
        PutMv("MV_ULMES",dParam)

        MsgInfo(Dtoc(GetMv("MV_ULMES")))       

    RESET ENVIRONMENT

Return
