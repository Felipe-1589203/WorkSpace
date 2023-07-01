
#INCLUDE "TOTVS.CH"
#INCLUDE "RESTFUL.CH"
#INCLUDE "FWMVCDEF.CH"

USER FUNCTION RestFullRet()

	RetornoApi("GET")
	RetornoApi("PUT")
	RetornoApi("POST")
	RetornoApi("DEL")

RETURN

STATIC FUNCTION RetornoApi(cTipo)

	Local cEndPoint  := ""
	Local oRest
	Local oJson     := JsonObject():New()
	Local Head_Api  := {}
	Local cUri      := "http://localhost/8084/Rest"

	AADD(Head_Api,"Accept: application/json")
	AADD(Head_Api,"content-type: application/json")
	AADD(Head_Api,"User-Agent: Chrome/65.0 (Compatible; Protheus "+ GetBuild() +")")

    cUrl  := '/api/crm/v1/NcustomerVendor/'
    oRest := FwRest():New(cUri)

    If cTipo == "GET"
        cEndPoint := "1/0000101"
        oRest:SetPath(cUrl+cEndPoint)

        If oRest:Get(Head_API)
            lRet := .T.
        ELSE
            lRet := .F.
        EndIf

        cResponse := oRest:GetResult()

        If ValType(cResponse) <> "C"
            cResponde := ""
        EndIf
        cRetApi := cResponse

        If !lRet
            cRetApi += CRLF + CRLF + oRest:GetLastError()
        EndIf

        ret := oJson:FromJson(cResponse)

        If ValType(ret) == "C"
            conOut("Falha ao transformar texto em objeto Json. Erro" + ret)
            Return
        EndIf

        Names := oJson:GetNames()
        u_PrintJson(oJson)
    
    ElseIf cTipo == "POST" 
        cEndPoint := ""
        
        oRest:SetPath(cUrl + cEndPoint)       
        oRest:SetPostParams(PostGetJson())

        If (oRest:Post(Head_Api))
            conOut("POST: " + oRest:GetResult())
        Else
            conOut("POST: " + oRest:GetLastError())
        EndIf

    ElseIf cTipo == "PUT"
        cEndPoint := "1/00000101"

        oRest:SetPath(cUrl + cEndPoint)

        If (oRest:Put(Head_Api, PutGetJson()))
            conOut("PUT: " + oRest:GetResult())
        Else
            conOut("PUT: " + oRest:GetLastError())
        EndIf

    ElseIf cTipo == "DEL"
           cEndPoint := "1/00001501"

           oRest:SetPath(cUrl + cEndPoint)
           oRest:SetPostParams(DELGetJson())                       
        
        If(oRest:DELETE(Head_Api))
           conOut("PUT: " + oRest:GetResult())
        Else
            conOut("PUT: " + oRest:GetLastoError())
        EndIf                  
    EndIf     

    nCodRet := Val(oRest:GetHTTPCod())

    FreeObj(oRest)

    If (nCodeRet >= 200 .AND. nCodRet <= 299) 
        lRet := .T.
    Else 
        lRet := .F.
    EndIf

    If !lRet
        conOut("Erro: " + cValToChar(nCodRet))
        RETURN
    EndIf 

Return


User Function PrintJson()


Return
