
    #INCLUDE 'PROTHEUS.CH'    
    #INCLUDE 'TOTVS.CH'
    #INCLUDE 'RWMAKE.CH'
    
    #DEFINE ENTER CHR(13)+CHR(10)

    USER FUNCTION CALCIMC()

        LOCAL nAltura := space(3), nPeso := space(6) 

        @ 200,001 TO 410,480 DIALOG oDlg TITLE OemToAnsi( "Cálculo de IMC" )
        @ 02,10   TO 095,230 
        @ 10,018  Say "Este programa irá cálcular o IMC-Indice de massa corporal" 
        @ 30,018  Say "Digite sua altura (apenas números)."
        @ 37,018  Say "Exemplo -> 187"
        @ 30,112  Say "Digite o seu peso com casas decimais."
        @ 37,112  Say "Exemplo -> 85,05"
        @ 45,018  MSGET nAltura SIZE 80,11 OF oDlg PIXEL PICTURE "@!" //VALID !VAZIO()
        @ 45,112  MSGET nPeso   SIZE 80,11 OF oDlg PIXEL PICTURE "@!" //VALID !VAZIO()
        @ 70,158  BMPBUTTON     TYPE 02 ACTION  CLOSE(oDlg)
        @ 70,188  BMPBUTTON     TYPE 01 ACTION  geracalc(nAltura,nPeso)

        ACTIVATE DIALOG oDlg CENTERED 

    RETURN

        STATIC FUNCTION geracalc(nAltura,nPeso)
                
            LOCAL cTexto := ""
            LOCAL nIMC

            IF validpeso(nPeso)

                nAltura := VAL(nAltura)/100
                nPeso   := VAL(STRTRAN(nPeso,",","."))

                nImc := nPeso / (nAltura ^ 2)

                DO CASE 
                    case nImc  <= 18.5
                        cTexto := "Abaixo do Peso"
                    case nImc  >= 18.6 .and. nImc <= 24.9
                        cTexto := "Peso normal"
                    case nImc  >= 25 .and. nImc <= 29.9
                        cTexto := "Acima do peso"
                    case nImc  >= 30 .and. nImc <= 39.9 
                        cTexto := "Com Obesidade"
                    otherwise 
                        cTexto := "Obesidade mórbida"    
                ENDCASE               

                MsgInfo("Seu IMC é " + ALLTRIM(STR(nIMC,5,2)) + " e você está " + cTexto)
            ELSE
                Alert("Separa o peso por casas decimais, utilizando (.) ou (,) !")    
            ENDIF

        RETURN  

        STATIC FUNCTION validpeso(nPeso)

            LOCAL lRet  := .F.
            LOCAL cStra := ","
            LOCAL cStrb := "."

            IF cStra $ nPeso .OR. cStrb $ nPeso 
                lRet := .T.
            ELSE
                lRet := .F.
            ENDIF     

        RETURN  lRet
