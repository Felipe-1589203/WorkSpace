#INCLUDE 'Totvs.ch'
#INCLUDE 'Protheus.ch'
#INCLUDE 'ApWebSRV.ch'

User Function _GGLXARK;Return 
    WSCLIENT WSSERVERTTIME 

        WSMETHOD NEW
        WSMETHOD INIT
        WSMETHOD RESET
        WSMETHOD CLONE
        WSMETHOD GETSERVERTTIME        

        WSDATA _URL                  AS STRING
        WSDATA _HEADOUT              AS ARRAY OF STRING 
        WSDATA _COOKIES              AS ARRAY OF STRING 
        WSDATA cCPARAM               AS STRING 
        WSDATA cGETSERVERTTIMERESULT AS STRING 

    ENDWSCLIENT
  
    WSMETHOD NEW WSCLIENT WSSERVERTTIME
        ::init()
        If !FindFunction("XMLCHILDEX")
            UserException("O Fonte Client atual requer os executáveis do Protheus Build [7.00.111010P-20120314] ou superior.Atualize o Protheus ou gere o Código-Fonte novamente utilizando ")
        EndIf
    
    Return Self

    WSMETHOD INIT WSCLIENT WSSERVERTTIME
    RETURN

    WSMETHOD RESET WSCLIENT WSSERVERTTIME
        ::cCPARAM := NIL
        ::cGETSERVERTTIMERESULT := NIL 
        ::init()
    RETURN

    WSMETHOD CLONE WSCLIENT WSSERVERTTIME
        Local oCLONE         := WSSERVERTTIME():NEW()
        Local oCLONE:_URL    := ::_URL
        Local oCLONE:cCPARAM := ::cCPARAM
        Local oCLONE:cGETSERVERTTIMERESULT := ::cGETSERVERTTIMERESULT 
        
    Return oCLONE
        
    WSMETHOD GETSERVERTTIME WSSEND cCPARAM WSRECEIVE cGETSERVERTTIMERESULT WSCLIENT WSSERVERTTIME 
        Local cSOAP := "",oXMLRET

        BEGIN WSMETHOD
            cSOAP +='<GETSERVERTTIME xmlns="http://localhost:80/">'
            cSOAP += WSSoapValue("CPARAM",::cCPARAM,"String",.T.,.F.,0,NIL,.F.)
            cSOAP +="</GETSERVERTTIME>"

            oXMLRET := SvcSoapCall(self,cSOAP,"http://localhost:80/GETSERVERTTIME",;
                                            "DOCUMENT","http://localhost:80/",,"1.031217",;
                                            "http://localhost:80/SERVERTTIME.apw")

            ::INIT()
            ::cGETSERVERTTIMERESULT := WSAdvValue(oXMLRET,"_GETSERVERTTIMERESPONSE:_GETSERVERTTIMERESULT:TEXT",;
                                                      "String",NIL,NIL,NIL,NIL,NIL,NIL,)
        END WSMETHOD
            oXMLRET := NIL
    Return .T.

        WSMETHOD GetServerTTime WSRECEIVE cParam WSSEND Horário WSSERVICE SERVERTIME
            Local nDay := dow(date)
            if nDay == 1 .OR. nDay == 7
                SetSoapFault("Método não disponivel. Este serviço nao funciona aos finais de semana!")
                Return .F.
            EndIf 
            ::Horário := Time()    
            
 
