#INCLUDE 'RWMAKE.CH'
#define EXCLUSIVO .F.
#define CLR_HGRAY      12632256

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRFAT002   บAutor  ณPaulo Lenzi         บ Data ณ  19/11/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณImpressao Grafica da Duplicada a Receber da MultLock        บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Depto Financeiro                                           บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function MFINR001()
Local oDlg
SetPrvt("CPERG,CCABEC1,CCABEC2,CCABEC3,CUSERNAME,NLIN,NCOL,NPAG,_cPath,cArqTrb")
Private oFont09N,oFont09,oFont20N,oFont20,oFont18N,oFont18,oFont16N,oFont16,oFont14N,oFont12N,oFont10N,oFont14,oFont12,oFont10,oFont08
Private cPerg := "MFINR01"
Private wParam01,wParam02,wParam03,wParam04,wParam05,wParam06
Private lContinua := .F.
ValidPerg()
Pergunte(cPerg,.F.)

wParam01 := mv_par01
wParam02 := mv_par02
wParam03 := mv_par03
wParam04 := mv_par04
wParam05 := mv_par07
wParam06 := mv_par08
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบDesc.     ณ Fontes de Letras Padrao para Impressao das Etiquetas       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
oFont28AN	:= TFont():New("Arial",28,28,,.T.,,,,.T.,.F.)
oFont28A 	:= TFont():New("Arial",28,28,,.F.,,,,.T.,.F.)
oFont20AN	:= TFont():New("Arial",20,20,,.T.,,,,.T.,.F.)
oFont20A 	:= TFont():New("Arial",20,20,,.F.,,,,.T.,.F.)
oFont16AN	:= TFont():New("Arial",16,16,,.T.,,,,.T.,.F.)
oFont16A 	:= TFont():New("Arial",16,16,,.F.,,,,.T.,.F.)
oFont20N	:= TFont():New("Times New Roman",20,20,,.T.,,,,.T.,.F.)
oFont20 	:= TFont():New("Times New Roman",20,20,,.F.,,,,.T.,.F.)
oFont18N	:= TFont():New("Times New Roman",18,18,,.T.,,,,.T.,.F.)
oFont18 	:= TFont():New("Times New Roman",18,18,,.F.,,,,.T.,.F.)
oFont16N	:= TFont():New("Times New Roman",14,14,,.T.,,,,.T.,.F.)
oFont16 	:= TFont():New("Times New Roman",14,14,,.F.,,,,.T.,.F.)
oFont14N	:= TFont():New("Times New Roman",12,12,,.T.,,,,.T.,.F.)
oFont14 	:= TFont():New("Times New Roman",12,12,,.F.,,,,.T.,.F.)
oFont12	    := TFont():New("Times New Roman",12,12,,.F.,,,,.T.,.F.)
oFont12N	:= TFont():New("Times New Roman",12,12,,.T.,,,,.T.,.F.)
oFont10	    := TFont():New("Times New Roman",10,10,,.F.,,,,.T.,.F.)
oFont10N	:= TFont():New("Times New Roman",10,10,,.T.,,,,.T.,.F.)
oFont09N	:= TFont():New("Times New Roman",09,09,,.T.,,,,.T.,.F.)
oFont09 	:= TFont():New("Times New Roman",09,09,,.F.,,,,.T.,.F.)
oFont08N	:= TFont():New("Times New Roman",08,08,,.T.,,,,.T.,.F.)
oFont08	    := TFont():New("Times New Roman",08,08,,.F.,,,,.T.,.F.)
oFont06	    := TFont():New("Times New Roman",07,07,,.T.,,,,.T.,.F.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบDesc.     ณ Telas para Parametrizar e acionar as Funcoes               บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
@ 200,1 TO 380,380 DIALOG oDlg TITLE "Duplicata'
@ 02,05 TO 070,185
@ 16,018 Say "Impressao Grafica da Duplicata especifica " SIZE 160,7
@ 24,018 Say " para a MultLock" SIZE 160,7
@ 32,018 Say " " SIZE 160,7
@ 40,018 Say " " SIZE 160,7
@ 75,088 BMPBUTTON TYPE 11 ACTION Pergunte(cPerg,.T.)
@ 75,118 BMPBUTTON TYPE 06 ACTION Processa( {|| FPrint() } )
@ 75,158 BMPBUTTON TYPE 02 ACTION Close(oDlg)
ACTIVATE DIALOG oDlg CENTERED
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณValidPerg บAutor  ณPaulo Lenzi         บ Data ณ  20/07/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para a geracao do arquivo de perguntas               บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ValidPerg()

Local i,j

_sAlias := Alias()
dbSelectArea("SX1")
dbSetOrder(1)
cPerg := PADR(cPerg,10)
aRegs:={}

AADD(aRegs,{cPerg,"01","Do Prefixo      ?"," "," ","mv_ch1","C",03,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"02","Ate o Prefixo   ?"," "," ","mv_ch2","C",03,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"03","Do Titulo       ?"," "," ","mv_ch3","C",09,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"04","Ate o Titulo    ?"," "," ","mv_ch4","C",09,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"05","Da Parcela      ?"," "," ","mv_ch5","C",03,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"06","Ate a Parcela   ?"," "," ","mv_ch6","C",03,0,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"07","Da Emissao      ?"," "," ","mv_ch7","D",08,0,0,"G","","mv_par07","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"08","Ate a Emissao   ?"," "," ","mv_ch8","D",08,0,0,"G","","mv_par08","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
For i:=1 to Len(aRegs)
	If !dbSeek(cPerg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to FCount()
			If j <= Len(aRegs[i])
				FieldPut(j,aRegs[i,j])
			Endif
		Next
		MsUnlock()
	Endif
Next
dbSelectArea(_sAlias)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFPrint    บAutor  ณPaulo Lenzi         บ Data ณ  20/07/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para a Impressao das Etiquetas                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FPrint()
Local nConta:= 0
Public oPrint
Public cFig := GetSrvProfString("StartPath","")
Public cfig2:= GetSrvProfString("StartPath","")
Private nLin := 0  
Private nValDup := 0

oPrint    	:= TMSPrinter():New("Etiquetas")
oPrint      :SETPAPERSIZE(9)
oPrint      :Setup()
oPrint		:StartPage()

DbSelectArea("SE1")
DbSetOrder(1)
DbSeek(xFilial("SE1")+MV_PAR01+MV_PAR03+MV_PAR05,.T.)
ProcRegua(RecCount()-Recno())
While !EOF() .and. SE1->(E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA) <= xFilial("SE1")+MV_PAR02+MV_PAR04+MV_PAR06
	
	IF SE1->E1_NUM < MV_PAR03
		DbSelectArea("SE1")
		DbSkip()
		Loop
	ENDIF
	
	
	IF SE1->E1_NUM > MV_PAR04
		DbSelectArea("SE1")
		DbSkip()
		Loop
	ENDIF
	
	IF SE1->E1_EMISSAO < MV_PAR07
		DbSelectArea("SE1")
		DbSkip()
		Loop
	ENDIF
	
	IF SE1->E1_EMISSAO > MV_PAR08
		DbSelectArea("SE1")
		DbSkip()
		Loop
	ENDIF   
	
	IF SE1->E1_TIPO <> "NF" //Bruno
		DbSelectArea("SE1")
		DbSkip()
		Loop
	ENDIF   
	                                                                
	incproc()
	DadosEmpresa(SE1->E1_EMISSAO)
	
	DbSelectArea("SA1")
	DbSetOrder(1)
	IF DBSEEK(xFilial("SA1")+SE1->E1_CLIENTE+SE1->E1_LOJA,.T.)
		oPrint:Say(800+nLin,980, SA1->A1_NOME, oFont08)   // Razao Social
		oPrint:Say(840+nLin,800, AllTrim(SA1->A1_END)+"  "+AllTrim(SA1->A1_COMPLEM)+" , "+SA1->A1_XNUM+" - "+SA1->A1_BAIRRO , oFont08)   // Endereco
		oPrint:Say(880+nLin,800, SA1->A1_MUN , oFont08)   // Municipio
		oPrint:Say(880+nLin,1350, SA1->A1_EST , oFont08)   // Estado
		oPrint:Say(880+nLin,1680, Transform(SA1->A1_CEP,"@R 99999-999"), oFont08)  // Cep
		oPrint:Say(920+nLin,980, AllTrim(SA1->A1_ENDCOB)+","+SA1->A1_XNUMC+"-"+SA1->A1_BAIRROC, oFont06)   // Endereco de Cobranca
		oPrint:Say(960+nLin,990, AllTrim(SA1->A1_ENDCOB)+","+SA1->A1_XNUMC+"-"+SA1->A1_BAIRROC, oFont06)   // Praca de Pagamento
		oPrint:Say(1000+nLin,880,Transform(SA1->A1_CGC,"@R 99.999.999/9999-99"), oFont08)   // cgc
		oPrint:Say(1000+nLin,1350,Transform(SA1->A1_INSCR,"@R 999.999.999.999"), oFont08)   // cgc
	ENDIF   
	
	DbSelectArea("SE1")
	//nValDup := SE1->E1_VALOR-SE1->E1_DECRESC 
	nValDup := SE1->E1_VALOR-(SE1->E1_DECRESC+SE1->E1_PIS+SE1->E1_COFINS+SE1->E1_CSLL)
	
	oPrint:Say(600+nLin,620, Transform(SE1->E1_NUM,"@R 999999999"), oFont08) // Numero da Fatura
	oPrint:Say(600+nLin,750,"-", oFont08) // Numero da Fatura
	oPrint:Say(600+nLin,761, Transform(SE1->E1_PARCELA,"@!"), oFont08) // Numero da Fatura
//	oPrint:Say(600+nLin,810, Transform(SE1->E1_VALOR,"@E 999,999,999.99"), oFont12N)
	oPrint:Say(600+nLin,810, Transform(nValDup,"@E 999,999,999.99"), oFont12N)
	oPrint:Say(600+nLin,1210, Transform(SE1->E1_NUM,"@R 999999999"), oFont08)
	oPrint:Say(600+nLin,1410, Transform(SE1->E1_VENCTO,"@R 99/99/9999"), oFont12N)
	
	oVlrExt := PADR(Extenso(nValDup),100," ")
	
	oPrint:Say(1100+nLin,810, oVlrExt, oFont08)
	
	nconta:=nconta + 1
	if nConta == 1
		nLin := 1600
	endif
	if nConta > 1
		oPrint:EndPage()
		nConta := 0
		nLin := 0
	endif
	DbSkip()
End
oPrint:EndPage()
oPrint:Preview()
oPrint:End()

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFLOGO     บAutor  ณPaulo Lenzi         บ Data ณ  20/07/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para imprimir o Logotipo da empresa                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FLOGO()
Local _IMAGEM := "LOGO"

//antigo
//cBitMap := "\imagem\" + LTRIM(_IMAGEM)+".Bmp"
cBitMap := "\imagem\" + LTRIM(_IMAGEM) + SM0->M0_CODIGO + ".Bmp"

//antigo
//oPrint:SayBitmap( 110+nLin,065,cBitMap,250,200 )
oPrint:SayBitmap( 110+nLin,065,cBitMap,550,150 )

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFLATE     บAutor  ณPaulo Lenzi         บ Data ณ  20/07/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para imprimir o Carimbo Lateral   a                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FLATE()
Local _LATERAL := "LATERAL"
cBitMap := "\imagem\" + LTRIM(_LATERAL)+ SM0->M0_CODIGO + ".Bmp"
oPrint:SayBitmap( 600+nLin,065,cBitMap,500,590 )   //1500+nLin,600
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณDadosEmpresa บAutor  ณPaulo Lenzi         บ Data ณ  20/07/06บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para carregar e imprimir os Dados da Empresa SM0     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function DadosEmpresa(oEmissao)
Local oEndereco := ALLTRIM(SM0->M0_ENDCOB)
Local oCidade   := ALLTRIM(SM0->M0_CIDCOB)
Local oEstado   := ALLTRIM(SM0->M0_ESTCOB)
Local oCep      := ALLTRIM(SM0->M0_CEPCOB)
Local oTelefone := ALLTRIM(SM0->M0_TEL)
Local oFax      := ALLTRIM(SM0->M0_FAX)
Local oCGC      := ALLTRIM(SM0->M0_CGC)
Local oINSCR    := ALLTRIM(SM0->M0_INSC)
Local oDia      := Strzero(Day(oEmissao),2)
Local oMes      := MesExtenso(Month(oEmissao))
Local oAno      := StrZero(Year(oEmissao),4)

Local oLocaliz  := oEndereco+" - "+oCidade+" - "+oEstado+" - "+oCep
Local oComunica := "Fone : "+oTelefone+" - Fax :"+oFax

Local ExData    := oDia+"/"+oMes+"/"+oAno


oPrint:Box(100+nLin,060,  460+nLin,800)

If SM0->M0_CODIGO == "01"
	oPrint:Say(340+nLin,100, "DO BRASIL INDฺSTRIA E COMษRCIO LTDA", oFont06)
EndIf

oPrint:Say(380+nLin,100, oLocaliz, oFont06)
oPrint:Say(420+nLin,100, oComunica, oFont06)

oPrint:Box(100+nLin,805,  460+nLin,2000)
oPrint:Say(140+nLin,810, "INSCRIวรO NO C. N .P. J (MF). Nบ  ", oFont12N)
oPrint:Say(140+nLin,1500,Transform(oCGC,"@R 99.999.999/9999-99"), oFont12N)
oPrint:Say(200+nLin,810, "INSCRIวรO ESTADUAL  No. ", oFont12N)
oPrint:Say(200+nLin,1500,Transform(oINSCR,"@R 999.999.999.999"), oFont12N)
oPrint:Say(400+nLin,810, "DATA DE EMISSรO   ", oFont12N)
oPrint:Say(400+nLin,1500,ExData, oFont12N)


oPrint:Box(500+nLin,610,640+nLin,800)    // fatura
oPrint:Box(500+nLin,800,640+nLin,1200)   // fatura / duplicata
oPrint:Box(500+nLin,1200,640+nLin,1400)  // duplicata
oPrint:Box(500+nLin,1400,640+nLin,1700)  // vencimento
oPrint:Box(500+nLin,610,560+nLin,1700)   // divisao

oPrint:Say(520+nLin,620, "FATURA No. ", oFont08N)
oPrint:Say(520+nLin,810, "FATURA/DUPLICATA", oFont08N)
oPrint:Say(520+nLin,1210, "DUPLICATA", oFont08N)
oPrint:Say(520+nLin,1410, "VENCIMENTO", oFont08N)

oPrint:Box(500+nLin,060, 1500+nLin,600)  // Caixa Lateral
FLATE()

oPrint:Box(750+nLin,610, 1500+nLin,2000)  // Caixa Princial

oPrint:Say(800+nLin,620, "NOME/RAZAO SOCIAL: ", oFont08N)
oPrint:Say(840+nLin,620, "ENDERECO: ", oFont08N)
oPrint:Say(880+nLin,620, "MUNICIPIO: ", oFont08N)
oPrint:Say(880+nLin,1300,"UF:", oFont08N)
oPrint:Say(880+nLin,1600,"CEP:", oFont08N)                      
oPrint:Say(920+nLin,620, "ENDERECO COBRANCA: ", oFont06)
oPrint:Say(960+nLin,620, "ENDERECO PAGAMENTO: ", oFont06)
oPrint:Say(1000+nLin,620, "C.N.P.J. (MF) No.: ", oFont08N)
oPrint:Say(1000+nLin,1300, "IE: ", oFont08N)

oPrint:Box(1060+nLin,610,1160+nLin,2000) // Extenso
oPrint:Box(1060+nLin,610,1160+nLin,800)
oPrint:Say(1080+nLin,620, "Valor por", oFont08N)
oPrint:Say(1120+nLin,620, "Extenso", oFont08N)
                                                                        
oPrint:Say(1200+nLin,620, "Reconhe็o(emos) a exatisใo desta DUPLICATA DE VENDA MERCANTIL, na importancia acima que pagarei(emos) เ  ", oFont06)

//Antigo
//oPrint:Say(1240+nLin,620, "MUL-T-LOCK DO BRASIL INDฺSTRIA E COMษRCIO LTDA., ou เ sua ordem na pra็a e vencimento acima indicados.", oFont06)

oPrint:Say(1240+nLin,620, ALLTRIM(SM0->M0_NOMECOM)+", ou เ sua ordem na pra็a e vencimento acima indicados.", oFont06)
oPrint:Say(1280+nLin,620, "Na falta de pagamento no vencimento, serใo cobrados juros legais mais despesas bancแrias.", oFont06)
oPrint:Say(1400+nLin,620, "Em  ____/____/_____", oFont08N)
oPrint:Say(1440+nLin,620, "    DATA DO ACEITE                                                         ASSINATURA DO SACADO   ", oFont08N)
FLOGO()
Return
