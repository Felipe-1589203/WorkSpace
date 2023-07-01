#INCLUDE 'Protheus.ch'

User Function EXEC1() 
 
     Local oDlg
     Local oBtnOk
     Local aButtons
     Local oSayConj
     Local oGetConj
     Local oSayCivil,cSayCivil
     Local oSaySal,cSaySal
     Local oRadio,nRadio
     Local oChk,lChk
     Local cNome    := Space(20)
     Local cConjuge := Space(20)
     Local cEnder   := Space(30)
     Local cCivil   := (1)
     Local oFont
     Local oFolder

     Define Font oFont Name "Arial" Size 0,-12 Bold 
     aButtons:={{"BMPPERG",{||MsgInfo("Pergunte")},"Pergunte..."},;
          {"BMPCALEN",{||MsgInfo("Calendário")},"Calendário..."}}

     Define MSdialog oDlg Title "Exemplo" From 0,0 To 500,600 Pixel 

     @20,10 Say "Nome:" Pixel Of oDlg 
     @20,50 Get cNome Size  50,10 Pixel Of oDlg 

     @40,10 Say "Estado Civil:" Pixel Of oDlg 
     @40,50 Get cCivil Size 10,10 Picture "@!"Valid cCivil$"S|C|D".AND.u_VldCivil(cCivil,oSayConj,oGetConj,oSayCivil) Pixel Of oDlg

     @40,80 Say oSayCivil Var cSayCivil Size 20,10 Pixel Of oDlg 

     @60,10 Say oSayConj Var "Conjuguê:" Pixel Of oDlg 
     @60,50 Get oGetConj Var cConjuge Size 50,10 Pixel Of oDlg

     @80,10 Say "Endereço:" Pixel Of oDlg
     @80,50 Get cEnder Pixel Of oDlg   

     @100,10 Say "Salário" Pixel Font oFont Of oDlg
     
     @100,40 Radio oRadio Var nRadio Items "1000","2000","3000" Size 50,9 On Change u_Salario(nRadio,oSaySal) Pixel Of oDlg

     @100,80 Say oSaySal Var cSaySal Size 20,10 Pixel Of oDlg

     @140,10 CheckBox oChk Var lChk Prompt"Check Box"Size 70,9 On Change MsgAlert(if(lChk,"Marcado","Desmarcado"))Pixel Of oDlg
     
     @oDlg:nHeigth/2-30,oDlg:nClientWidth/2-70 Button oBtnOk Prompt"&OK" Size 30,15 Pixel Action u_Confirma()Message"Clique aqui para confirmar" Of oDlg 

     @160,10 Folder oFolder Prompts "Pasta 1","Pasta 2"Size 200,80 Pixel Of oDlg
     oFolder:aDialogs[2]:=oFont
     //oFolder:bChange:={||MsgAlert("Mudando de pasta")}

     @10,10 Say "Conteudo na primeira pasta"Pixel Of oFolder:aDialogs[1]
     @10,10 Say "Conteudo da segunda pasta"Pixel Of oFolder:aDialogs[2]

     Activate MsDialog oDlg Centered On Init EchoiceBar(oDlg,  {||u_OK(),oDlg:End()},;
     {||oDlg:End()},,aButtons)
Return Nil

//---------------------------------------------------------------------------//
     User Function Confirma()

     MsgAlert("Você clicou no Botão OK")
//Aqui poderia, por exemplo, gravar os dados num arquivo
     Return
//---------------------------------------------------------------------------//

     User Function OK()
          MsgAlert("Você clicou no botão OK da EnchoiceBar!")
//Aqui poderia, por exemplo, gravar os dados num arquivo
     Return
//---------------------------------------------------------------------------//

     User Function VldCivil(cCivil,oSayConj,oGetConj,oSayCivil)
          IF cCivil<>"C"
             oSayConj:Hide()
             oGetConj:Hide()
           //oSayConj:Disable()
           //oGetConj:Disable  
          Else
             oSayConj:Show()
             oGetConj:Show()
           //oSayConj:Enable()
           //oGetConj:Enabela()  
          EndIf

          If cCivil=="C"
             oSayCivil:SetText("Casado")
          ElseIF cCivil=="S"
             oSayCivil:SetText("Solteiro")                
          Else
             oSayCivil:SetText("Divorciado")
          EndIf
     Return .T.
//--------------------------------------------------------------------//

     User Function Salario(nRadio,oSaySal)
          If   nRadio==1
               oSaySal:SetText("Hum mil")
          ElseIf nRadio==2
               oSaySal:SetText("Dois mil")  
          Else 
               oSaySal:SetText("Três mil")
          EndIf 
     Return
