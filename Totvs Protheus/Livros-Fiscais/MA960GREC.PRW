#include "protheus.ch" 
 
 
//-------------------------------------------------------------------------------------------------------------//
/*/{Protheus.doc} MA960GREC
Ponto de Entrada para preenchimento dos campos F6_TIPOGNU, F6_DOCORIG, F6_DETRECE e F6_CODPROD de acordo com o código de receita e UF.
Implementado por Marcelo Oliveira - Actual Trend 07/10/2021
@author 
@since 
/*/
//------------------------------------------------------------------------------------------------------------//
User Function MA960GREC()
 
    Local aParam   := {10, '1', '', 0, ''} //Parâmetros de retorno default
    Local cReceita := PARAMIXB[1]    //Código de Receita da guia atual
    Local cUF      := PARAMIXB[2]    //Sigla da UF da guia atual
 
    If Alltrim(cReceita) $ '100099' .And. cUF $ 'RJ' //Valida o Código de Receita e sigla da UF da guia atual
        aParam := {24, '2', '', 27, ''}              //Retorna os campos F6_TIPOGNU, F6_DOCORIG, F6_DETRECE, F6_CODPROD e F6_CODAREA de acordo com o código de receita e sigla da UF da guia atual.
    EndIf
 
    If Alltrim(cReceita) $ '100099' .And. cUF $ 'ES' //Valida o Código de Receita e sigla da UF da guia atual
        aParam := {24, '2', '', 7, '5'}             //Retorna os campos F6_TIPOGNU, F6_DOCORIG, F6_DETRECE, F6_CODPROD e F6_CODAREA de acordo com o código de receita e sigla da UF da guia atual.
    EndIf

    If Alltrim(cReceita) $ '100099' .And. cUF $ 'RS'    //Valida o Código de Receita e sigla da UF da guia atual
        aParam := {22, '2', '', 0, ''}                 //Retorna os campos F6_TIPOGNU, F6_DOCORIG, F6_DETRECE, F6_CODPROD e F6_CODAREA de acordo com o código de receita e sigla da UF da guia atual. 
    EndIf

    If Alltrim(cReceita) $ '100102' .And. cUF $ 'DF'    //Valida o Código de Receita e sigla da UF da guia atual
        aParam := {10, '1', '', 0, ''}                  //Retorna os campos F6_TIPOGNU, F6_DOCORIG, F6_DETRECE, F6_CODPROD e F6_CODAREA de acordo com o código de receita e sigla da UF da guia atual. 
    EndIf

    If Alltrim(cReceita) $ '100102' .And. cUF $ 'MA'  //
        aParam := {10, '1', '', 27, ''}              
    EndIf

    If Alltrim(cReceita) $ '100102' .And. cUF $ 'SC'    //Valida o Código de Receita e sigla da UF da guia atual
        aParam := {24, '2', '', 0, ''}                  //Retorna os campos F6_TIPOGNU, F6_DOCORIG, F6_DETRECE, F6_CODPROD e F6_CODAREA de acordo com o código de receita e sigla da UF da guia atual. 
    EndIf

    If Alltrim(cReceita) $ '100102' .And. cUF $ 'MT'    //Valida o Código de Receita e sigla da UF da guia atual
        aParam := {20, '1', '000055', 0, ''}            //Retorna os campos F6_TIPOGNU, F6_DOCORIG, F6_DETRECE, F6_CODPROD e F6_CODAREA de acordo com o código de receita e sigla da UF da guia atual. 
    EndIf

    If Alltrim(cReceita) $ '100099' .And. cUF $ 'PE'    //Valida o Código de Receita e sigla da UF da guia atual
        aParam := {24, '2', '', 0, ''}                  //Retorna os campos F6_TIPOGNU, F6_DOCORIG, F6_DETRECE, F6_CODPROD e F6_CODAREA de acordo com o código de receita e sigla da UF da guia atual. 
    EndIf

    If Alltrim(cReceita) $ '100099' .And. cUF $ 'AM'    //Valida o Código de Receita e sigla da UF da guia atual
        aParam := {22, '1', '33', 0, ''}                  //Retorna os campos F6_TIPOGNU, F6_DOCORIG, F6_DETRECE, F6_CODPROD e F6_CODAREA de acordo com o código de receita e sigla da UF da guia atual.
    EndIf

    If Alltrim(cReceita) $ '100099' .And. cUF $ 'RR'    //Valida o Código de Receita e sigla da UF da guia atual
        aParam := {10, '1', '33', 0, ''}                  //Retorna os campos F6_TIPOGNU, F6_DOCORIG, F6_DETRECE, F6_CODPROD e F6_CODAREA de acordo com o código de receita e sigla da UF da guia atual. 
    EndIf

        If Alltrim(cReceita) $ '100099' .And. cUF $ 'MA'    //Valida o Código de Receita e sigla da UF da guia atual
        aParam := {10, '1', '33', 0, ''}                  //Retorna os campos F6_TIPOGNU, F6_DOCORIG, F6_DETRECE, F6_CODPROD e F6_CODAREA de acordo com o código de receita e sigla da UF da guia atual. 
    EndIf



Return aParam
