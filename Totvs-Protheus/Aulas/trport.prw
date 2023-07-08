#INCLUDE 'Protheus.ch'
#INCLUDE 'Parmtype.ch'
#INCLUDE 'Totvs.ch'

    #DEFINE ENTER CHR(13)+CHR(10) 

    User Function RelSA1()

        Private Cperg      := "RelSA1"
        Private cNextAlias := GetNextAlias()

        ValidPerg(cPerg)

            If Pergunte(cPerg,.T.)
                oReport := ReportDef()
                oReport := PrintDialog() 
            EndIf       

    Return

        Static Function ReportDef()

        
            oReport := TrePort():New(cPerg,"Relatório de clientes por estado",;
            cPerg,{|oReport| ReporPrint(oReport)},"Impressão de relatório de Clientes por estado") 
            oReport := SetLandScape(.T.)
            oReport := HideParamPage()

            //TRcell():New( <oParent> , <cTitle> , <uTable> , <aOrder> , <lLoadoCells> , <lLoadOrder> , <uTotalText>,<>)
            oSection := TrSection():New(oReport,OemToAnsi("Relatório de clientes por estado"),{"SA1"})

            //TRcell():New( <oParent> , <cNome>) ,  <cAlias> , <cTitulo> , <cPicture> , <nSize> , <lPixel> , <bBlock> , <aAlign>)
            TrCell():New(   TrSection,  "A1_COD",   cNextAlias,"Código",)  
            TrCell():New(   TrSection,  "A1_NOME",  cNextAlias,"Nome",)          
            TrCell():New(   TrSection,  "Pessoa",   cNextAlias,"Pessoa",)
            TrCell():New(   TrSection,  "A1_END",   cNextAlias,"Endereço",)
            TrCell():New(   TrSection,  "A1_BAIRRO",cNextAlias,"Bairro",)
            TrCell():New(   TrSection,  "A1_EST",   cNextAlias,"Estado",)
            TrCell():New(   TrSection,  "A1_CEP",   cNextAlias,"Cep",)
            TrCell():New(   TrSection,  "A1_MUN",   cNextAlias,"Municipio",)
            

        Return oReport
          
          //Função de Consulta

          Static function ReportPrint(oReport)

          Local oSection := oReport:Section(1)
          Local cQuery   := ""
          Local nCount   := 0
          
	     cQuery += "SELECT   "   + ENTER
         cQuery += "A1_COD,  "   + ENTER
         cQuery += "A1_NOME, "   + ENTER
         cQuery += "CASE WHEN A1_PESSOA ='J' THEN 'Juridica' ELSE 'Fisica' END PESSOA, " + ENTER
         cQuery += "A1_END, "    + ENTER
         cQuery += "A1_BAIRRO, " + ENTER
         cQuery += "A1_EST, "    + ENTER
         cQuery += "A1_CEP, "    + ENTER
         cQuery += "A1_MUN "     + ENTER
         cQuery += "FROM" + RetSqlName("SA1") + " WHERE D_E_L_E_T_= '' " + ENTER
            
          If !EMPTY(MV_PAR01)
            cQuery  += "AND A1_EST = '" +MV_PAR01+ "' " + ENTER
          EndIf 
             cQuery += "ORDER BY A1_EST, A1_COD "

        DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cNextAlias)

        Count to nCount
        (cNextAlias)->(dbgotop())
        oReport:SetMeter(nCount)
        oSection:init()

        while !(cNextAlias)->(Eof())
            oReport:IncMeter()
            oSection:PrintLine()
           If oReport:Cancel()
                Exit 
           EndIf  
           (cNextAlias)->(DbSkip())
        EndDo       

        Return         
          //Função de perguntas
          Static Function ValidPerg(cPerg)

            Local aAlias := GetArea()
            Local aRegs  := {}
            Local i,j

            cPerg := PadR(Cperg,len(SX1->X1_GRUPO)," ")

            AADD(aRegs,{cPerg,"01","Estado","","","mv_ch1","C",2,0,0,G,"",MV_PAR01,"","","","","","","","","","","","","","","","","","","","","","","","","","12","","","","",""})
            
            DbSelectArea("SX1")
            SX1->(DbSetOrder(1))

            For i := 1 to LEN(aRegs)
                If !DbSeek(cPerg + aRegs[1,2])
                    RecLock("SX1",.T.)

                    For j := 1 to Fcount()
                        FieldPut(j,aRegs[i,j])
                    Next

                EndIf
            Next
            RestArea(aAlias)          
          Return

          
    
    
