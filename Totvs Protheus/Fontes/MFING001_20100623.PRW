#INCLUDE "RWMAKE.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºProg. Ori ³FGEN001   ºAutor  ³JEAN CAVALCANTE     º Data ³  19-06-07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ FUNCAO PARA TRAZER CAMPO DE ENDERECO DO CLIENTE            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ ESPECIFICO CNAB MULTLOCK                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function MFGEN001() // RETORNA ENDCOB
 c_endcob := IIF(EMPTY(SA1->A1_ENDCOB),SUBSTR(AllTrim(SA1->A1_END)+" "+AllTrim(SA1->A1_COMPLEM),1,40),SUBSTR(AllTrim(SA1->A1_ENDCOB)+" "+AllTrim(SA1->A1_XCOMPC),1,40))
Return(c_endcob) 

User Function MFGEN002() // RETORNA BAIRRO
 c_endbairro := IIF(EMPTY(SA1->A1_BAIRROC),SUBSTR(SA1->A1_BAIRRO,1,12),SUBSTR(SA1->A1_BAIRROC,1,12))
Return(c_endbairro) 

User Function MFGEN003() // cep
 c_cep := IIF(EMPTY(SA1->A1_CEPC),SUBSTR(SA1->A1_CEP,1,8),SUBSTR(SA1->A1_CEPC,1,8))
Return(c_cep) 

User Function MFGEN004() // MUNICIPIO
 c_mun := IIF(EMPTY(SA1->A1_MUNC),SUBSTR(SA1->A1_MUN,1,12),SUBSTR(SA1->A1_MUNC,1,12))
Return(c_mun) 

User Function MFGEN005() // U.F
 c_est := IIF(EMPTY(SA1->A1_ESTC),SUBSTR(SA1->A1_EST,1,2),SUBSTR(SA1->A1_ESTC,1,2))
Return(c_est) 

User Function MFGEN006() // CEP - BRADESCO
 c_CEP1 := IIF(EMPTY(SA1->A1_CEPC),SUBSTR(SA1->A1_CEP,1,5),SUBSTR(SA1->A1_CEPC,1,5))                                       
Return(c_CEP1) 

User Function MFGEN007() // CEP - BRADESCO2
 c_CEP2 := IIF(EMPTY(SA1->A1_CEPC),SUBSTR(SA1->A1_CEP,6,8),SUBSTR(SA1->A1_CEPC,6,8))
Return(c_CEP2)                                                                      

User Function MFGEN009() // RETORNA ENDCOB                                                                
 c_endcob := IIF(EMPTY(SA1->A1_ENDCOB),SUBSTR(SA1->A1_END,1,37),SUBSTR(SA1->A1_ENDCOB,1,37))
Return(c_endcob) 

User Function MFGEN010() // RETORNA NUMERO DO TITULO COM 6 DIGITOS
 c_Titulo := SE1->E1_PREFIXO + Iif(len(AllTrim(SE1->E1_NUM)) < 9, LEFT(SE1->E1_NUM,6), RIGHT(SE1->E1_NUM,6) ) + IIf(Empty(SE1->E1_PARCELA),"1",SE1->E1_PARCELA)
Return(c_Titulo) 