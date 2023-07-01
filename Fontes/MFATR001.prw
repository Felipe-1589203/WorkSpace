#INCLUDE "rwmake.ch"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMFATR001  บ Autor ณMarcelo Pagliotto.  บ Data ณ  18/08/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณRelatorio que lista as pms efetuadas durante o mes          บฑฑ
ฑฑบ          ณutilizado para o fechamento mensal.                         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณEspecifico MULTLOCK.                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function MFATR001(c_cliente)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de acordo com os parametros informados pelo usuario."
Local cDesc3         := "Extrato do Cliente"
Local cPict          := ""                            
Local titulo         := "Extrato do Cliente"
Local nLin           := 80
Local imprime        := .T.
Local aOrd			 := {}

Local Cabec2         := ""
//                                 10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180
//                       0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
Local Cabec1         := "Pedido de Material        Produto         Descri็ใo                               Quantidade        Valor   Data do Envio   Dt.Digita็ใo   Operador          Ped. Aglutina    Numero NF"        
//                             999999         999999999999999 - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  999,999,999   999,999.99      99/99/99        99/99/99    XXXXXXXXXXXXXXX        999999    999999999 999
//							Total do Cliente............................................................:   999.999
Private a_pos		 := {       6,             21,                                                        81,           95,             111,            127,        139,                  162,      172}

Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 150
Private tamanho      := "G"
Private nomeprog     := "Extrato do Cliente" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo        := 18
Private aReturn      := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey     := 0
Private cPerg        := "MFATR001"
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "MFATR001" // Coloque aqui o nome do arquivo usado para impressao em disco
Private cString		 := "SC6"

c_cli := Iif(c_cliente = Nil, '', c_cliente)

dbSelectArea("SC6")
dbSetOrder(1)

ValidPerg(cPerg)
                
If !Empty(c_cli)
	pergunte(cPerg,.F.)
Else
	pergunte(cPerg,.T.)
EndIf

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta a interface padrao com o usuario...                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
   Return
Endif

nTipo := If(aReturn[4]==1,15,18)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Processamento. RPTSTATUS monta janela com a regua de processamento. ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณRUNREPORT บ Autor ณ AP6 IDE            บ Data ณ  18/08/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS บฑฑ
ฑฑบ          ณ monta a janela com a regua de processamento.               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

Local nOrdem
Local cCliente 	:= ""
Local nLin     	:= nLin + 1 // Avanca a linha de impressao
Local nTotQtd 	:= 0 
Local nTotVal 	:= 0
Local nTotGQtd  := 0
Local nTotGval  := 0                  

   		c_Query := " Select 	 C5_NUM, C5_CLIENTE, C5_LOJACLI, C5_XTTPPED, C5_XSITPM, C5_EMISSAO, C5_USERLGI, C5_XENTRPM, C6_FILIAL, C6_CLI, C6_ITEM, C6_PRODUTO, C6_QTDVEN, C6_PRCVEN, C6_NUM, C6_LOCAL, C6_TES, C6_LOCAL, B1_DESC, C5_XPMPAI "
		c_Query += " from        "+RetSqlName("SC5")+" SC5   										" 
		c_Query += " inner join  "+RetSqlName("SC6")+" SC6 	    									"
		c_Query += " on          SC5.C5_NUM = SC6.C6_NUM       	   									"
		c_Query += " Left Join   "+RetSqlName("SB1")+" SB1 	    									"
		c_Query += " on          SC6.C6_PRODUTO = SB1.B1_COD       	   								"
		c_Query += " and         C6_FILIAL = '"+xFilial("SC5")+"'									"
		c_Query += " and         SC6.D_E_L_E_T_ <> '*' 												"
		If Empty(c_cli)
			c_Query += " Where		 C5_EMISSAO BETWEEN '"+Dtos(MV_PAR01)+"' AND '"+Dtos(MV_PAR02)+"' 	"
		Else
			c_Query += " Where		 C5_CLIENTE = '"+c_cli+"'	"
		EndIf
		c_Query += " and         SC5.D_E_L_E_T_ <> '*' 												"
		c_Query += " and         C5_XTTPPED = 'S' 													"
//		c_Query += " and         C5_XSITPM = 'F' 				   									"
		c_Query += " and         C5_FILIAL = '"+xFilial("SC6")+"'									"
		c_Query += " Order By    C6_CLI,C5_XENTRPM, C5_XPMPAI	  									"
	
	
	If Select("QRY") > 0
		DbSelectArea("QRY")
		DbCloseArea()
	EndIf
	
	dbUseArea( .T., "TOPCONN", TcGenQry(,,c_Query), "QRY", .T., .F. )
	
	

dbSelectArea(cString)
dbSetOrder(1)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ SETREGUA -> Indica quantos registros serao processados para a regua ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

SetRegua(RecCount())

cCliente := ""

DBSelectarea("QRY")
dbGoTop()

While QRY->(!EOF()) //.And. SC6->C6_CLI == (MV_PAR01)


   //ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
   //ณ Impressao do cabecalho do relatorio. . .                            ณ
   //ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
  If nLin > 50 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
    Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo) 
    nLin := 10
       nLin++ 
       @nLin, 005 Psay "Cliente: " + QRY->C5_CLIENTE + "-" + QRY->C5_LOJACLI + " " +;  
       GetAdvFval("SA1", "A1_NOME", xFilial("SA1")+QRY->C5_CLIENTE+QRY->C5_LOJACLI, 1,)
       If cCliente <> QRY->C6_CLI
	       nTotQtd := 0
	       nTotVal := 0 
	   EndIf
	   cCliente :=  QRY->C6_CLI
       nLin++
       nLin++
  Endif

   //ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
   //ณ Verifica o cancelamento pelo usuario...                             ณ
   //ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

   If lAbortPrint
      @nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
      Exit
   Endif

	/*If SC6->C6_CLI <> MV_PAR01
		QRY->(DbSkip())
		Loop
	EndIf*/

  
   
  
     If cCliente <> QRY->C6_CLI
       nLin++ 
       @nLin, 005 Psay "Cliente: " + QRY->C5_CLIENTE + "-" + QRY->C5_LOJACLI + " " +;  
       GetAdvFval("SA1", "A1_NOME", xFilial("SA1")+QRY->C5_CLIENTE+QRY->C5_LOJACLI, 1,)
       nTotQtd := 0
       nTotVal := 0 
       nLin++
       nLin++
     ENDIF 
  
  		c_nome := EMBARALHA(QRY->C5_USERLGI,1)
  		c_numnf := ''
  		DbSelectArea("SD2")
  		DbSetOrder(8)
  		If DbSeek(xFilial("SD2")+QRY->C5_XPMPAI)
  			c_numnf += SD2->D2_DOC + ' '+SD2->D2_SERIE
  		EndIf
  
		@nLin, a_pos[01]  Psay QRY->C6_NUM		 			        
		@nLin, a_pos[02]  Psay QRY->C6_PRODUTO + " - " + QRY->B1_DESC 
		@nLin, a_pos[03]  Psay QRY->C6_QTDVEN   				     	 Picture "@E 999,999,99"  //refiz 
		@nLin, a_pos[04]  Psay QRY->C6_PRCVEN*QRY->C6_QTDVEN 			 Picture "@E 999,999.99" 
		@nLin, a_pos[05]  Psay StoD(QRY->C5_XENTRPM)
		@nLin, a_pos[06]  Psay StoD(QRY->C5_EMISSAO)					  
        @nLin, a_pos[07]  Psay substr(c_nome,1,15)
        @nLin, a_pos[08]  Psay QRY->C5_XPMPAI
        @nLin, a_pos[09]  Psay c_numnf
        nLin++
		
		 cCliente := QRY->C6_CLI 
		
		
      If cCliente == QRY->C6_CLI
        nTotQtd += QRY->C6_QTDVEN 
		nTotVal += QRY->C6_PRCVEN*QRY->C6_QTDVEN
      EndIF    
      
      nTotGQtd  += QRY->C6_QTDVEN 
	  nTotGval  += QRY->C6_PRCVEN*QRY->C6_QTDVEN
       
       
  	QRY->(dbSkip()) 
   
   If cCliente <> QRY->C6_CLI
   		nLin++ 
        @nLin, 005 Psay "Total do Cliente..........................................................: "
        @nLin, a_pos[03] Psay nTotQtd  Picture "@E 999,999,99"  //refiz
        @nLin, a_pos[04] Psay nTotVal  Picture "@E 999,999.99"  //"Total do Cliente" 
        nLin++
   EndiF
EndDo
        
        nLin++
    	@nLin, 005 Psay "Total Geral...............................................................: "
        @nLin, a_pos[03] Psay nTotGQtd  Picture "@E 999,999,99"   //refiz
        @nLin, a_pos[04] Psay nTotGVal  Picture "@E 999,999.99"  //"Total do Cliente" 

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Finaliza a execucao do relatorio...                                 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

SET DEVICE TO SCREEN

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Se impressao em disco, chama o gerenciador de impressao...          ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

If aReturn[5]==1
   dbCommitAll()
   SET PRINTER TO
   OurSpool(wnrel)
Endif

MS_FLUSH()

Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณVALIDPERG บ Autor ณ MKW Windows 2.0    บ Data ณ  06/01/99   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Verifica a existencia das perguntas criando-as caso seja   บฑฑ
ฑฑบ          ณ necessario (caso nao existam).                             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function ValidPerg(c_Perg)

	c_Alias := Alias()
	
	DbSelectArea("SX1")
	DbSetOrder(1)
	
	c_Perg 	:= PADR(c_Perg, 10)                        
	aRegs	:= {}
	
	aAdd(aRegs,{c_Perg,"01"  ,"Emissao de  ?",""      ,""     ,"MV_CH1","D"    ,08      ,0       ,1     ,"G" ,""    ,"MV_PAR01",""      	,""      ,""      ,""   ,""         ,""         ,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
	aAdd(aRegs,{c_Perg,"02"  ,"Emissao ate ?",""      ,""     ,"MV_CH2","D"    ,08      ,0       ,1     ,"G" ,""    ,"MV_PAR02",""      	,""      ,""      ,""   ,""         ,""         ,""      ,""      ,""    ,""        ,""             ,""      ,""     ,""     ,""       ,""             ,""      ,""      ,""    ,""        ,""            ,""      ,""      ,""    ,""   })
	
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