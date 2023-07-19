#include "Totvs.ch"
#INCLUDE 'ApWebSRV.ch'

WsService CTT description "Treinamento do WebService para o Curso CTT"
	Wsdata cCodEmp  as String // código da empresa
	Wsdata aEmpresa as array of EstruturaEmp // estrutura inteira do sigamat.emp
	Wsdata cRet     as String // Mensagem de Retorno
	WsMethod LISTAEMPRESA DESCRIPTION "APRESENTA TODOS OS DADOS DO SIGAMAT.EMP DO CLIENTE"
EndWsservice
    
    WsStruct EstruturaEmp
	
    WsData M0_CODIGO As String
	WsData M0_CODFIL As String
	WsData M0_FILIAL As String
	WsData M0_NOME   As String
	WsData M0_NOMECOM As String
	WsData M0_ENDCOB As String
	WsData M0_CIDCOB As String
	WsData M0_ESTCOB As String
	WsData M0_CEPCOB As String
	WsData M0_ENDENT As String
	WsData M0_CIDENT As String
	WsData M0_ESTENT As String
	WsData M0_CEPENT As String
	WsData M0_CGC As String
	WsData M0_INSC As String
	WsData M0_TEL As String
	WsData M0_EQUIP As String
	WsData M0_SEQUENC As String
	WsData M0_DOCSEQ As INTEGER
	WsData M0_FAX As String
	WsData M0_PRODRUR As String
	WsData M0_BAIRCOB As String
	WsData M0_BAIRENT As String
	WsData M0_COMPCOB As String
	WsData M0_COMPENT As String
	WsData M0_TPINSC As Integer
	WsData M0_CNAE As String
	WsData M0_FPAS As String
	WsData M0_ACTRAB As String
	WsData M0_CODMUN As String
	WsData M0_NATJUR As String
	WsData M0_DTBASE As String
	WsData M0_NUMPROP As Integer
	WsData M0_MODEND As String
	WsData M0_MODINSC As String
	WsData M0_CAUSA As String
	WsData M0_INSCANT As String
	WsData M0_TEL_IMP As String
	WsData M0_FAX_IMP As String
	WsData M0_TEL_PO As String
	WsData M0_FAX_PO As String
	WsData M0_IMP_CON As String
	WsData M0_CODZOSE As String
	WsData M0_DESZOSE As String
	WsData M0_COD_ATV As String
	WsData M0_INS_SUF As String
	WsData M0_EMERGEN As String
	WsData M0_LIBMOD As String
	WsData M0_TPESTAB As String
	WsData M0_DTAUTOR As date
	WsData M0_EMPB2B As String
	WsData M0_CAIXA As String
	WsData M0_LICENSA As String	
	WsData M0_CORPKEY As String
	WsData M0_CHKSUM As Integer
	WsData M0_DTVLD As date
	WsData M0_PSW As String
	WsData M0_CTPSW As String
	WsData M0_INTCTRL As String
	WsData M0_INSCM As String
	WsData M0_NIRE As String
	WsData M0_DTRE As date
	WsData M0_CNES As String
	WsData M0_PSWSTRT As String
	WsData M0_DSCCNA As String
	WsData M0_ASSPAT1 As String
	WsData M0_ASSPAT2 As String
	WsData M0_ASSPAT3 As String
	WsData M0_SIZEFIL As Integer
	WsData M0_LEIAUTE As String
	WsData M0_PICTURE As String
	WsData M0_STATUS As String
	WsData M0_RNTRC As String
	WsData M0_DTRNTRC As date
	WsData X_MENSAGEM As String
EndWsStruct

WsMethod LISTAEMPRESA WsReceive cCodEmp WsSend aEmpresa WsService CTT
	Local cEmp := "99"
	Local cFil := "01"
	Local aTab := {"SA1"}
	Local aRet := {}
	Local nDados := 0

	RpcSetEnv(cEmp,cFil,,,'FIN','ListEmpresa',aTab)//abre a conexão com o banco e a empresa padrão
	
    if cCodEmp != 'Abrir'
		::cRet := "Palavra Chave Invalida"
		aadd(aEmpresa,WsClassNew("EstruturaEmp"))

		aEmpresa[1]:M0_CODIGO := ""
		aEmpresa[1]:M0_CODFIL := ""
		aEmpresa[1]:M0_FILIAL := ""
		aEmpresa[1]:M0_NOME := ""
		aEmpresa[1]:M0_NOMECOM := ""
		aEmpresa[1]:M0_ENDCOB := ""
		aEmpresa[1]:M0_CIDCOB := ""
		aEmpresa[1]:M0_ESTCOB := ""
		aEmpresa[1]:M0_CEPCOB := ""
		aEmpresa[1]:M0_ENDENT := ""
		aEmpresa[1]:M0_CIDENT := ""
		aEmpresa[1]:M0_ESTENT := ""
		aEmpresa[1]:M0_CEPENT := ""
		aEmpresa[1]:M0_CGC := ""
		aEmpresa[1]:M0_INSC := ""
		aEmpresa[1]:M0_TEL := ""
		aEmpresa[1]:M0_EQUIP := ""
		aEmpresa[1]:M0_SEQUENC := ""
		aEmpresa[1]:M0_DOCSEQ := 0
		aEmpresa[1]:M0_FAX := ""
		aEmpresa[1]:M0_PRODRUR := ""
		aEmpresa[1]:M0_BAIRCOB := ""
		aEmpresa[1]:M0_BAIRENT := ""
		aEmpresa[1]:M0_COMPCOB := ""
		aEmpresa[1]:M0_COMPENT := ""
		aEmpresa[1]:M0_TPINSC := 0
		aEmpresa[1]:M0_CNAE := ""
		aEmpresa[1]:M0_FPAS := ""
		aEmpresa[1]:M0_ACTRAB := ""
		aEmpresa[1]:M0_CODMUN := ""
		aEmpresa[1]:M0_NATJUR := ""
		aEmpresa[1]:M0_DTBASE := ""
		aEmpresa[1]:M0_NUMPROP := 0
		aEmpresa[1]:M0_MODEND := ""
		aEmpresa[1]:M0_MODINSC := ""
		aEmpresa[1]:M0_CAUSA := ""
		aEmpresa[1]:M0_INSCANT := ""
		aEmpresa[1]:M0_TEL_IMP := ""
		aEmpresa[1]:M0_FAX_IMP := ""
		aEmpresa[1]:M0_TEL_PO := ""
		aEmpresa[1]:M0_FAX_PO := ""
		aEmpresa[1]:M0_IMP_CON := ""
		aEmpresa[1]:M0_CODZOSE := ""
		aEmpresa[1]:M0_DESZOSE := ""
		aEmpresa[1]:M0_COD_ATV := ""
		aEmpresa[1]:M0_INS_SUF := ""
		aEmpresa[1]:M0_EMERGEN := ""
		aEmpresa[1]:M0_LIBMOD := ""
		aEmpresa[1]:M0_TPESTAB := ""
		aEmpresa[1]:M0_DTAUTOR := STOD("")
		aEmpresa[1]:M0_EMPB2B := ""
		aEmpresa[1]:M0_CAIXA := ""
		aEmpresa[1]:M0_LICENSA := ""
		aEmpresa[1]:M0_CORPKEY := ""
		aEmpresa[1]:M0_CHKSUM := 0
		aEmpresa[1]:M0_DTVLD := STOD("")
		aEmpresa[1]:M0_PSW := ""
		aEmpresa[1]:M0_CTPSW := ""
		aEmpresa[1]:M0_INTCTRL := ""
		aEmpresa[1]:M0_INSCM := ""
		aEmpresa[1]:M0_NIRE := ""
		aEmpresa[1]:M0_DTRE := STOD("")
		aEmpresa[1]:M0_CNES := ""
		aEmpresa[1]:M0_PSWSTRT := ""
		aEmpresa[1]:M0_DSCCNA := ""
		aEmpresa[1]:M0_ASSPAT1 := ""
		aEmpresa[1]:M0_ASSPAT2 := ""
		aEmpresa[1]:M0_ASSPAT3 := ""
		aEmpresa[1]:M0_SIZEFIL := 0
		aEmpresa[1]:M0_LEIAUTE := ""
		aEmpresa[1]:M0_PICTURE := ""
		aEmpresa[1]:M0_STATUS := ""
		aEmpresa[1]:M0_RNTRC := ""
		aEmpresa[1]:M0_DTRNTRC := STOD("")
		aEmpresa[1]:X_MENSAGEM := ::cRet
		Return .t.
	endif

	aRet := SM0->(GETAREA())

	WHILE SM0->(!EOF())
		nDados += 1
		aadd(aEmpresa,WsClassNew("EstruturaEmp"))
		aEmpresa[nDados]:M0_CODIGO := SM0->M0_CODIGO
		aEmpresa[nDados]:M0_CODFIL := SM0->M0_CODFIL
		aEmpresa[nDados]:M0_FILIAL := SM0->M0_FILIAL
		aEmpresa[nDados]:M0_NOME := SM0->M0_NOME
		aEmpresa[nDados]:M0_NOMECOM := SM0->M0_NOMECOM
		aEmpresa[nDados]:M0_ENDCOB := SM0->M0_ENDCOB
		aEmpresa[nDados]:M0_CIDCOB := SM0->M0_CIDCOB
		aEmpresa[nDados]:M0_ESTCOB := SM0->M0_ESTCOB
		aEmpresa[nDados]:M0_CEPCOB := SM0->M0_CEPCOB
		aEmpresa[nDados]:M0_ENDENT := SM0->M0_ENDENT
		aEmpresa[nDados]:M0_CIDENT := SM0->M0_CIDENT
		aEmpresa[nDados]:M0_ESTENT := SM0->M0_ESTENT
		aEmpresa[nDados]:M0_CEPENT := SM0->M0_CEPENT
		aEmpresa[nDados]:M0_CGC := SM0->M0_CGC
		aEmpresa[nDados]:M0_INSC := SM0->M0_INSC
		aEmpresa[nDados]:M0_TEL := SM0->M0_TEL
		aEmpresa[nDados]:M0_EQUIP := SM0->M0_EQUIP
		aEmpresa[nDados]:M0_SEQUENC := SM0->M0_SEQUENC
		aEmpresa[nDados]:M0_DOCSEQ := SM0->M0_DOCSEQ
		aEmpresa[nDados]:M0_FAX := SM0->M0_FAX
		aEmpresa[nDados]:M0_PRODRUR := SM0->M0_PRODRUR
		aEmpresa[nDados]:M0_BAIRCOB := SM0->M0_BAIRCOB
		aEmpresa[nDados]:M0_BAIRENT := SM0->M0_BAIRENT
		aEmpresa[nDados]:M0_COMPCOB := SM0->M0_COMPCOB
		aEmpresa[nDados]:M0_COMPENT := SM0->M0_COMPENT
		aEmpresa[nDados]:M0_TPINSC := SM0->M0_TPINSC
		aEmpresa[nDados]:M0_CNAE := SM0->M0_CNAE
		aEmpresa[nDados]:M0_FPAS := SM0->M0_FPAS
		aEmpresa[nDados]:M0_ACTRAB := SM0->M0_ACTRAB
		aEmpresa[nDados]:M0_CODMUN := SM0->M0_CODMUN
		aEmpresa[nDados]:M0_NATJUR := SM0->M0_NATJUR
		aEmpresa[nDados]:M0_DTBASE := SM0->M0_DTBASE
		aEmpresa[nDados]:M0_NUMPROP := SM0->M0_NUMPROP
		aEmpresa[nDados]:M0_MODEND := SM0->M0_MODEND
		aEmpresa[nDados]:M0_MODINSC := SM0->M0_MODINSC
		aEmpresa[nDados]:M0_CAUSA := SM0->M0_CAUSA
		aEmpresa[nDados]:M0_INSCANT := SM0->M0_INSCANT
		aEmpresa[nDados]:M0_TEL_IMP := SM0->M0_TEL_IMP
		aEmpresa[nDados]:M0_FAX_IMP := SM0->M0_FAX_IMP
		aEmpresa[nDados]:M0_TEL_PO := SM0->M0_TEL_PO
		aEmpresa[nDados]:M0_FAX_PO := SM0->M0_FAX_PO
		aEmpresa[nDados]:M0_IMP_CON := SM0->M0_IMP_CON
		aEmpresa[nDados]:M0_CODZOSE := SM0->M0_CODZOSE
		aEmpresa[nDados]:M0_DESZOSE := SM0->M0_DESZOSE
		aEmpresa[nDados]:M0_COD_ATV := SM0->M0_COD_ATV
		aEmpresa[nDados]:M0_INS_SUF := SM0->M0_INS_SUF
		aEmpresa[nDados]:M0_EMERGEN := SM0->M0_EMERGEN
		aEmpresa[nDados]:M0_LIBMOD := SM0->M0_LIBMOD
		aEmpresa[nDados]:M0_TPESTAB := SM0->M0_TPESTAB
		aEmpresa[nDados]:M0_DTAUTOR := SM0->M0_DTAUTOR
		aEmpresa[nDados]:M0_EMPB2B := SM0->M0_EMPB2B
		aEmpresa[nDados]:M0_CAIXA := SM0->M0_CAIXA
		aEmpresa[nDados]:M0_LICENSA := SM0->M0_LICENSA
		aEmpresa[nDados]:M0_CORPKEY := SM0->M0_CORPKEY
		aEmpresa[nDados]:M0_CHKSUM := SM0->M0_CHKSUM
		aEmpresa[nDados]:M0_DTVLD := SM0->M0_DTVLD
		aEmpresa[nDados]:M0_PSW := SM0->M0_PSW
		aEmpresa[nDados]:M0_CTPSW := SM0->M0_CTPSW
		aEmpresa[nDados]:M0_INTCTRL := SM0->M0_INTCTRL
		aEmpresa[nDados]:M0_INSCM := SM0->M0_INSCM
		aEmpresa[nDados]:M0_NIRE := SM0->M0_NIRE
		aEmpresa[nDados]:M0_DTRE := SM0->M0_DTRE
		aEmpresa[nDados]:M0_CNES := SM0->M0_CNES
		aEmpresa[nDados]:M0_PSWSTRT := SM0->M0_PSWSTRT
		aEmpresa[nDados]:M0_DSCCNA := SM0->M0_DSCCNA
		aEmpresa[nDados]:M0_ASSPAT1 := SM0->M0_ASSPAT1
		aEmpresa[nDados]:M0_ASSPAT3 := SM0->M0_ASSPAT3
		aEmpresa[nDados]:M0_SIZEFIL := SM0->M0_SIZEFIL
		aEmpresa[nDados]:M0_LEIAUTE := SM0->M0_LEIAUTE
		aEmpresa[nDados]:M0_PICTURE := SM0->M0_PICTURE
		aEmpresa[nDados]:M0_STATUS := SM0->M0_STATUS
		aEmpresa[nDados]:M0_RNTRC := SM0->M0_RNTRC
		aEmpresa[nDados]:M0_DTRNTRC := SM0->M0_DTRNTRC
		aEmpresa[nDados]:X_MENSAGEM := "Sucesso "+strzero(nDados,2)
		SM0->(DBSKIP())
	END
	RESTAREA(aRet)
