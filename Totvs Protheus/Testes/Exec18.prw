#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TOTVS.CH'

///////////////RLATORIO FORMATO SETPRINT/////////////

User Function Exec18()
    
    Local aOrd    := {}     
    Local cDesc1  := "Este Programa tem como objetivo imprimir relatórios"
    Local cDesc2  := "de acordo com os parametros informados pelo usuario."
    Local cDesc3  :=  "Cadastro de Software"
    Local cPict   := ""
    Local titulo  := "Cadastro de software"
    Local nLin    := 80
    Local Cabc1   := "Código do nome"
    Local Cabc2   := "------------------------"
    Local imprime := .T.     
     
    Private cString     := "SC5"
    Private CbTxt       := ""
    Private lEnd        := .F.
    Private lAbortPrint := .F.
    Private limite      := 80
    Private tamanho     := "P"
    Private NomeProg    := "Ecec18"
    Private nTipo       := 18
    Private aReturn     := {"Zebrado",1,"Aministração",2,2,1,"",1}
    Private nLastKey    := 0
    Private cPerg       := "MTR120"
    Private cbtxt       := Space(10)
    Private cbcont      := 00
    Private CONTFL      := 01
    Private m_pag       := 01
    Private wnrel       := "Exec18"
    
    DbSelectArea("SC5")
    DbSetOrder(1)
    Pergunte(cPerg,.F.)

    wnerel := SetPrint(cString,NomeProg,cPerg,@Titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)

    If nLastKey == 27
        Return
    EndIf
    SetDefault(aReturn,cString)

    If nLastkey == 27
        Return
    EndIf
    nTipo := if(aReturn[4]==1,15,18)

    RptStatus({||RunReport(Cabec1,Cabec2,Titulo,nLin)},Titulo)
    
Return

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

    Local nOrdem

    DbSelectArea(cString)
    DbSetOrder(1)
    SetRegua(RecCount())
    DbGoTop()
    DbSeek(Xfilial("SC5")+mv_par01,.T.)

    While !EOF() .AND. SC5->C5_NUM <= mv_par02
        If lAbortPrint
            @nLin,00 PSAY "***Cancelado pelo operador***"
                Exit
        EndIf
        If nLin > 55
            Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
            nLin := 8
        EndIf

        nLin := nLin + 1
        @nLin,000 PSAY SC5->C5_NUM 
        @nLin,008 PSAY SC5->C5_CLIENTE
        @nLin,061 PSAY SC5->C5_CLIENT
        @nLin,071 PSAY SC5->C5_TIPO
        DbSkip()
        IncRegua()
    EndDo

    SET DEVICE TO SCREEN

    If aReturn[5] == 1
        DbCommitAll()
        SET PRINTER TO
        OwrSpool(wnrel)
    EndIf
    MS_FLUSH()
Return


