#INCLUDE "PROTHEUS.CH"

User Function acom001()
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³acom001   ºPaulo  ³multlock            º Data ³  11-03-10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±//Alterar a data de entrega do pedido de compras
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Especifico  - www.actualtrend.com.br                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                        
 Local c_para      := GetMV('MV_XCOMP')
 Local c_para1    := GetMV('MV_XCOMP1')           
  
 Local cMensagem  := ''  
 Local cMail_usu  :=  Pega_email(__CUSERID)    

 c_para := c_para + c_para1 
 c_para := c_para + alltrim(cMail_usu)

 Private c_msgerro  := ''

//gravando aheader
CopaHeader 		:= aHeader
CopArotina 		:= aRotina
CopAcols   		:= aCols
CopcCadastro 	:= cCadastro
cAlias 			:= Alias()
cIndex 			:= IndexOrd()
nRec   			:= Recno()
aArea      		:= GetArea()
cPerg	 		:= "ACOM01"
lperg 			:= ValidPerg(cPerg)
Iperg 			:= pergunte(cPerg,.T.)
//Private cPict3:= "9999"                

		if empty(mv_par01)    .or.   ! Iperg
		    alert("Data nao informada ou Abortada")
		    ret := retAmbiente()
		    Return
		endif
				    
lLiberDat	    := .F.
lFlag			:= .T.
_cNum 			:=  CA120NUM    //M->C7_NUM		        
_cItem			:=  StrZero(mv_par02,4)
		
		if	!dbseek(xfilial("SC7")+_cNum+StrZero(mv_par02,4))
			Alert("Item do pedido nao existe")      	
			ret := retAmbiente()
		    Return			
		endif	 
			    
// Grava a Data Alterada conforme item selecionado

			dbseek(xfilial("SC7")+_cNum+StrZero(mv_par02,4))			
			RecLock("SC7",.F.)
			  ddtem		 := SC7->C7_EMISSAO		                                                                    
			  ddprf		 := SC7->C7_DATPRF
			  C7_XNPENTE := MV_PAR01
			Msunlock()
		    lLiberDat:= .T.				                  
 	
 		if mv_par01 < ddprf
			Alert("Data nao alterada ...Data de Entrega menor do que a data de emissão")      	
			lFlag:= .F.			
			Return
		endif		
	
			 
if 		lLiberDat 
	Alert("Data Entrega Alterada")    
   	cmensagem := EnvMail("htm\ALTCOMPRAS.html","C:\mt010inc.HTML", c_para)  
else
	Alert("Data nao alterada ...Pedido ja entregue ou com eliminaçao de residuo")      	
endif
	
Return

static function RetAmbiente()
   //restaurando ambiente
	dbSelectArea(calias )
	dbGoto( nRec )
	aHeader 	:= CopaHeader    
	Acols 			:= CopAcols
	aRotina 		:= CopArotina
	cCadastro 	:= CopcCadastro
    RestArea(aArea)        
Return
    
//===============================

Static Function ValidPerg(c_Perg)

	Local i,j
	c_Alias := Alias()
	
	DbSelectArea("SX1")
	DbSetOrder(1)
	
	c_Perg 	:= PADR(c_Perg, 10)
	aRegs	:= {}
	
	aAdd(aRegs,{c_Perg,"01"  ,"Data de Entrega   ?",""      ,""     ,"MV_CH1","D"    ,08      ,0       ,0     ,"G" ,"naovazio","MV_PAR01",""      	,""      ,""      ,""   ,""         ,""         ,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
	aAdd(aRegs,{c_Perg,"02"  ,"Para qual Item ? ",""      ,""     ,"MV_CH2","N"    ,04      ,0       ,0     ,"G" ,"naovazio","MV_PAR02",""      	,""      ,""      ,""   ,""         ,""         ,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
		
	For i:=1 to Len(aRegs)
		If !dbSeek(c_Perg+aRegs[i,2])
			RecLock("SX1", .T.)
			For j:=1 to FCount()
				If j <= Len(aRegs[i])
					FieldPut(j,aRegs[i,j])
				Endif
			Next
			MsUnlock()
		Endif
	Next
	
	DbSelectArea(c_Alias)

Return Nil   
Static Function EnvMail(c_FileOrig, c_FileDest, c_para)

 Local l_Continua := .T.
 Private c_texto  := ''
 Private c_msgerro := ''
 fArq(c_FileOrig, c_FileDest)
 If !u_FGEN010(c_para,"ALTERACAO DATA DE ENTREGA",c_texto,,.t.) 
  Return c_msgerro
 EndIf

Return ""

Static Function fArq(c_FileOrig, c_FileDest)

 Local l_Ret  := .T.
 Local c_Buffer := ""
 Local n_Posicao := 0
 Local n_QtdReg := 0
 Local n_RegAtu := 0

 If !File(c_FileOrig)
  l_Ret := .F.
  MsgStop("Arquivo [ "+c_FileOrig+" ] não localizado.", "Não localizou")
 Else
  
  Ft_fuse( c_FileOrig )   // Abre o arquivo
  Ft_FGoTop()
  n_QtdReg := Ft_fLastRec()
  nHandle := MSFCREATE( c_FileDest )

  ///////////////////////////////////
  // Carregar o array com os itens //
  ///////////////////////////////////
  While !ft_fEof() .And. l_Ret
   
   c_Buffer := ft_fReadln()
   
   FWrite(nHandle, &("'" + c_Buffer + "'"))
   c_texto += &("'" + c_Buffer + "'")
   ft_fSkip()
   
  Enddo
  FClose(nHandle)

 Endif
 
Return l_Ret
