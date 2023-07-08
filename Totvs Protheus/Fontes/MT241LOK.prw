#include "rwmake.ch"        


/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±
±³Programa  ³ MT241LOK³ Autor ³ Jean Cavalcante  ³ Data ³ 15.06.05 ³±
±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±
±³Descricao ³ Valida digitação do TM  para Baixa Requisiçoes       ³±
±³          ³ no modelo 2                                          ³±
±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±
±³Uso       ³ Digitacoes de empenhos Requisicao manual.            ³±
±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/


User Function MT241LOK()        
SetPrvt("_CALIAS,_NINDEX,_NREG,_NLINGETD,_NPOSLOTE,_NPOSCTM,_CTM,_CLOTE, ,_NPOSQUANT,_NQUANT")
SetPrvt("_CNAT,ACOLS,_LRETURN")

// Grava Area Inicial
_cAlias  	 := Alias()
_nIndex   	 := IndexOrd()
_nReg     	 := Recno()
_nLinGetD 	 := n
_nPoslote    := aScan(aHeader, { |x| Alltrim(x[2]) == "D3_LOTECTL" })
_cLote       := aCols[_nLinGetD, _nPosLote]
_nPosquant   := aScan(aHeader, { |x| Alltrim(x[2]) == "D3_QUANT" })
_nQuant      := aCols[_nLinGetD, _nPosquant]

_lReturn     := .F.


if M->CTM = "002" .and. Empty(_cLote)
    MsgBox("AO UTILIZAR O MOVIMENTO 002, DEVE-SE PREENCHER O CAMPO DO LOTE COM O NUMERO DA OP!!","ERRO VERIFIQUE!!!","STOP")
   _lReturn := .F.
Elseif M->CTM = "005" .and. _nQuant > 0
    MsgBox("AO UTILIZAR O MOVIMENTO 005, O CAMPO QUANTIDADE TEM QUE SER ZERO!!","ERRO VERIFIQUE!!!","STOP")
   _lReturn := .F.
Elseif DA241DATA > dDATABASE  // BARRAR MOVIMENTACAO DE EMISSAO > QUE DATABASE
   Msgbox("A DATA DE EMISSAO NAO PODE SER MAIOR QUE A DATABASE DO SISTEMA!!!","ERRO VERIFIQUE!!!","STOP")
   _lReturn := .F.
Else
   _lReturn := .T.
endif


// Restaura a Area Inicial
dbSelectArea(_cAlias)
dbSetOrder(_nIndex)
dbGoTo(_nReg)
Return(_lReturn)        
