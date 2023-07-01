#INCLUDE 'Protheus.ch'"
#INCLUDE 'Rwmake.ch'

User Function Mod2Manut(cAlias,nReg,nOpc)
 // Local cChave := ""
    Local nCols  := 0
    Local i      := 0
    Local lRet   := .F.
    
    Private cAlias   := "SX3"
    Private cCadastro:= "TELA MODELO 2" 
    Private aC       := {}
    Private aR       := {}
    Private aCGF     := {}
    Private cLinOk   := ""
    Private cAllOk   := "u_Md2TudOk"
    Private aGetsGD  := {}
    Private bF4      := {|| }
    Private clniCpos := "+Z4_ITEM"
    Private nMax     := 99
    Private aCdorW   := {}
    Private lDelGetd := .T.
    Private aHeader  := {}
    Private aCols    := {}
    Private nCount   := 0
    Private bCampo   := {|nField|FieldName(nField)}
    Private cNumero  := Ctod("//")
  //Private cNumero  := Space(6)
    Private aAlt     := {}

    dbSeletcArte(SX3)
    For i := 1 To Fcount()
    M->&(Eval(bCampo,i)) := CriarVar(FieldName(i),.T.)
    Next nx

    DbSelectArea(cAlias)
    DbSetOrder(1)
    DbSeek(SX3)
    
    While !EOF().AND.SX3->X3_ARQUIVO == cAlias
    If X3Uso(X3_USADO).AND.cNivel >= X3_NIVEL .AND.!(Trim(X3_CAMPO)$"Z4_NUMERO/Z4_EMISSAO")
    aadd(aHeader,{ Trim(X3_Titulo),;
                 X3_CAMPO  ,;
                 X3_PICTURE,;
                 X3_TAMANHO,;
                 X3_DECIMAL,;
                 X3_VALID  ,;
                 X3_USADO  ,;
                 X3_TIPO   ,;
                 X3_ARQUIVO,;
                 X3_CONTEXT })
    EndIf
    DbSkip()
    End
    DbSelectArea(cAlias)
    DbSetOrder(1)

    If nOpc <> 3 
    cNumero := (cAlias)->Z4_NUMERO

    DbSeek(xFilial(cAlias)+cNumero)
    While !EOf() .AND. (cAlias)->(Z4_FILIAL+Z4_NUMERO) == Filial(cAlias)+cNumero

      AADD(aCols,Array(Len(Aheader)+1))
      nCols++


      For i := 1 To Len(aHeader)

        If aHeader[1,10]<>"V"
            aCols[nCols,i]:= FieldGet(FieldPos(aHeader[i,2]))
        Else
            Cols[nCols,i] := CriaVar(aHeader[i,2],.T.)
        EndIf 
        
        Next i 

        AADD(aAlt,Recnio())
        DbSelectArea(cAlias)
        DbSkip()
    END
       Else
    cNumero := GetSexNum("SZ4","Z4_NUMERO")  

    AADD(aCols,Array(Len(aHeader)+1))
    For i := 1 To Len(aHeader)
    aCols[1,i] := CriaVar(aHeader[i,2])
    Next i

    aCols[1,Len(aHeader)+1]:= .F.
    AcOLS[1,aScan(aHeader,{|x|Trim(x[2])=="Z4_ITEM"})] := "01"
    
    EndIf

    AADD(aC,{"cNumero",{15,10},"Número","@!",,,.F.})
    AADD(aC,{"dData",{15,80},"Data de Emissão",99/99/99,,,(nOpc==3)})

    aCGD   := {34,5,128,315}
    cLinOK := "AllwaysTrue()"
    dData  := dDatabase
    lRet := Modelo2(cTitulo,aC,aR,aCGD,nOoc,cLinOK,cAllOK,,,clniCpos,nMAX)     
    
    If lRet

      If nOpc == 3

         If MsgYesNo("Confirma gravação dos dados ?",cTitulo)
            Processa({||Md2Inclu(cAlias)},cTitulo,"Gravando os dados, aguarde...")
         ENDIF
         
      ElseIf nOpc == 4
           If MsgYesNo("Confirma alteração dos dados ?",cTitulo)
              Processa({||Md2Alter(cAlias)},cTitulo,"Alterando os dados, agurde...")
            EndIf
      ElseIf nOpc == 5
            If MsgYesNo("Confirma exclusão dos dados ?",cTitulo)
               Processa({||Md2Exclu(cAlias)},cTitulo,"Excludindo os dados, aguarde...")
            Endif
      EndIf
    Else
        RollBackSX8()
    EndIf    
Return
