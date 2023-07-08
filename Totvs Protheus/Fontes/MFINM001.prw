#INCLUDE "Protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE "Rwmake.ch"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                              M U L T  -  T  -  L O C K                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºPrograma    ³ MFINM001  ³Chamado no X3_INIBRW do campo E1_XSITDES para trazer descricaoº±±
±±º            ³           ³ da situacao do titulo no transferencia (Fina060), para       º±±
±±º            ³           ³ verificar titulos em cartorios                               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAutor       ³ Actual Trend                                          ³ Data ³  25/06/10 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
                                                                         
User Function MFINM001(nTipo)                                  
                                                 
Local lRet := ""                                                                        
                                    
lRet := IIf(SE1->E1_SITUACA = "0", "Em Carteira"      , ;
        IIf(SE1->E1_SITUACA = "1", "Cob. Simples"     , ;
        IIf(SE1->E1_SITUACA = "2", "Cob. Descontada"  , ;
        IIf(SE1->E1_SITUACA = "3", "Cob. Caucionada"  , ;
        IIf(SE1->E1_SITUACA = "4", "Cob. Vinculada"   , ;
        IIf(SE1->E1_SITUACA = "5", "Cob. com Advogado", ;
        IIf(SE1->E1_SITUACA = "6", "Cob. Judicial"    , ;
        IIf(SE1->E1_SITUACA = "7", "Caução descontada", ;
        IIf(SE1->E1_SITUACA = "F", "Carteira protesto", ;
        IIf(SE1->E1_SITUACA = "G", "Carteira acordo"  , ;
        IIf(SE1->E1_SITUACA = "H", "Carteira cartorio", "" )))))))))))

Return(lRet)