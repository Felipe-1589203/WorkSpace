#include "Rwmake.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³MFATR005³ Autor   ³   Jean Cavalcante     ³ Data ³ 03/12/09 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³          |  Ultima Alteracao³   Jean Cavalcante     ³ Data ³ 03/12/09 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Nota Fiscal de Entrada/Saida                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico para o Cliente : MUL-T-LOCK / CONTAR            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß

/*/

User Function MFATR005()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP6 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetPrvt("XNUM_NF,XSERIE,XPREFIXO,XEMISSAO,XTOT_FAT,XLOJA,XFRETE")
SetPrvt("XSEGURO,XBASE_ICMS,XBASE_IPI,XVALOR_ICMS,XICMS_RET,XVALOR_IPI")
SetPrvt("XVALOR_MERC,XNUM_DUPLIC,XCOND_PAG,XPBRUTO,XPLIQUI,XTIPO")
SetPrvt("XESPECIE,XVOLUME,XITEM_PED,XDESCPED")
SetPrvt("XNUM_NFDV,XPREF_DV,XEMIS_DV,XICMS,XCOD_PRO,XQTD_PRO,XPRE_UNI")
SetPrvt("XPRE_TAB,XIPI,XVAL_IPI,XDESC,XVAL_DESC,XVAL_MERC")
SetPrvt("XTES,XCF,XCF2,XICMSOL,XICM_PROD,XPESO_UNIT")
SetPrvt("XDESCR,XUNID_PRO,XCOD_TRIB,XNUNSERIE,XMEN_TRIB,XCOD_FIS,XCLAS_FIS")
SetPrvt("XMEN_POS,XISS,XLUCRO,XCLFISCAL,xFORM")
SetPrvt("I,NPELEM,_CLASFIS,NPTESTE,XPED,XDESC_NOTA")
SetPrvt("XCLIENTE,XTIPO_CLI,XCOD_MENS,XMENSAGEM")
SetPrvt("XTPFRETE,XCOD_VEND,XDESC_NF,XDESC_PAG,XPED_CLI")
SetPrvt("XDESC_PRO,J,XNOME_CLI,XEND_CLI,XBAIRRO")
SetPrvt("XCEP_CLI,XEND_COB,XBAI_COB,XMUN_COB,XCEP_COB,XEST_COB,XREC_CLI,XMUN_CLI,XEST_CLI,XCGC_CLI")
SetPrvt("XINSC_CLI,XTRAN_CLI,XTEL_CLI,XFAX_CLI,XSUFRAMA,XCALCSUF")
SetPrvt("ZFRANCA,XVENDEDOR,XBSICMRET,XNOME_TRANSP,XEND_TRANSP,XMUN_TRANSP")
SetPrvt("XEST_TRANSP,XVIA_TRANSP,XCGC_TRANSP,XTEL_TRANSP,XPARC_DUP,XVENC_DUP")
SetPrvt("XVALOR_DUP,XDUPLICATAS,XNFORI,XPEDIDO,xIMPRIMIR")
SetPrvt("XFAX,NOPC,CCOR,XB_ICMS_SOL,_NPAG,_nTot_Pag,_xDet_Org,_lContinua")
SetPrvt("XV_ICMS_SOL,NCONT,NCOL,NTAMOBS,NAJUSTE,BB,_nIsenta,_nConta,_nConta2,_nLin_Obs,xDespesa")
SetPrvt("XMUNE_CLI,XESTE_CLI,xNREDUZ_C,xP_CATEG_CLI,XCEPE_CLI,xCLFISCAL") //20010911 - Declarcao de Variaveis Endereco de Entrega

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Ambientais                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01             // Da Nota Fiscal                       ³
//³ mv_par02             // Ate a Nota Fiscal                    ³
//³ mv_par03             // Da Serie                             ³
//³ mv_par04             // Nota Fiscal de Entrada/Saida         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Private	CbTxt		:=""
Private	CbCont		:=""
Private	nOrdem 		:=0
Private	Alfa 		:=0
Private	Z			:=0
Private	M			:=0
Private	Tamanho		:="M"
Private	limite		:=220
Private	titulo 		:=PADC("Nota Fiscal - Nfiscal",74)
Private	cDesc1 		:=PADC("Este programa ira emitir a Nota Fiscal de Entrada/Saida",74)
Private	cDesc2 		:=""
Private	cDesc3 		:=PADC("da Nfiscal",74)
Private	aReturn 	:= { "Especial", 1,"Administracao", 1, 2, 1,"",1 }
Private	nomeprog	:= "MFATR005"
Private	cPerg		:= "MFATR005"
Private	nLastKey	:=0
Private	lContinua 	:=.T.
Private	nLin		:=0
Private	wnrel   	:="MFATR005"
Private	cString		:="SF2"
Private	XPROP_NFDV	:=Array(0)
Private XTIPO_PRO	:=Array(0)
Private XALIQISS	:=5
Private XBASEISS	:=0 
Private XTOT_ISS	:=0
Private XFRASE		:=" "          
PRIVATE XDESCPED    := 0.00 
Private XPED_PESOLIQ:=Array(0)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Dimencoes, parametrizacoes e posicoes da Nota Fiscal      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private nTamNf			:=	79     			// Tamanho total da nota fiscal: 88 Linhas em 1/8.
Private	nLinIni			:=	0				// Linha Inicial da Impressao
Private nLIniDet		:=	GETMV("MV_LINDET") //36				// Linha Inicial da Impressao dos Detalhes.
Private nLIniDetS		:=	GETMV("MV_LINSER") //51				// Linha Inicial da Impressao dos Detalhes de Servicos.
Private	nTamDet			:=	GETMV("MV_TAMDET") //15				// Numero de Linhas de Detalhes da Nota Fiscal.
Private	nTamDetS		:=	GETMV("MV_TAMSER") //06				// Numero de Linhas de Detalhes para Servicos na NF.
Private	_nMaxTit		:=	04				// Numero de Titulos a Serem Impressos
Private _aObsTes 		:=	Array(0)
Private xNATUREZA		:=	Array(0)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas, busca o padrao da Nfiscal           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPerg,.F.)               		// Pergunta no SX1

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:=SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.T.)

If nLastKey == 27
	Return
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica Posicao do Formulario na Impressora                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetDefault(aReturn,cString)
If nLastKey == 27
	Return
Endif
VerImp()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicio do Processamento da Nota Fiscal                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RptStatus({|| RptDetail() },"Emitindo NF de Saida...")

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³RptDetail ºAutor  ³Paulo Lenzi         º Data ³  04/12/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function RptDetail()

If mv_par04 == 2
	dbSelectArea("SF2")                // * Cabecalho da Nota Fiscal Saida
	dbSetOrder(1)
	dbSeek(xFilial()+mv_par01+mv_par03,.t.)
	
	dbSelectArea("SD2")                // * Itens de Venda da Nota Fiscal
	dbSetOrder(3)
	dbSeek(xFilial()+mv_par01+mv_par03)
Else
	dbSelectArea("SF1")                // * Cabecalho da Nota Fiscal Entrada
	DbSetOrder(1)
	dbSeek(xFilial()+mv_par01+mv_par03,.t.)
	
	dbSelectArea("SD1")                // * Itens da Nota Fiscal de Entrada
	dbSetOrder(3)
	dbSeek(xFilial()+mv_par01+mv_par03)
Endif


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa  regua de impressao                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetRegua(Val(mv_par02)-Val(mv_par01))

If mv_par04 == 2

    // NF SAIDA
    
	dbSelectArea("SF2")                // * Cabecalho da Nota Fiscal Saida
	dbSetOrder(1)
	dbSeek(xFilial()+mv_par01+mv_par03,.t.)
	
	While !eof() .and. SF2->F2_DOC <= mv_par02 .and. lContinua
		
		If 	SF2->F2_SERIE #mv_par03    // Se a Serie do Arquivo for Diferente
			DbSkip()                   // do Parametro Informado !!!
			Loop
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Inicializa  regua de impressao                            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		SetRegua(Val(mv_par02)-Val(mv_par01))
		
		IF 	lAbortPrint
			@ 00,01 PSAY "** CANCELADO PELO OPERADOR **"
			lContinua := .F.
			Exit
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Levantamento de Dados - Cabecalho da Nota Fiscal de Saida    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		LimpaVarImp()
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Levantamento de Dados - Cabecalho da Nota Fiscal de Saida    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		xNUM_NF     	:=SF2->F2_DOC            	// Numero
		xSERIE      	:=SF2->F2_SERIE          	// Serie
		xEMISSAO    	:=SF2->F2_EMISSAO        	// Data de Emissao
		xTIPO       	:=SF2->F2_TIPO          	// Tipo de Nota Fiscal
		xCLIENTE    	:=SF2->F2_CLIENTE       	// Codigo do Cliente
		xLOJA       	:=SF2->F2_LOJA           	// Loja do Cliente
		
		//Busca dados do Cadastro de CLientes ou Fornecedor
		PesqCliFor("S",SF2->F2_TIPO,SF2->F2_CLIENTE,SF2->F2_LOJA)
		
		xPREFIXO    	:=SF2->F2_PREFIXO        	// Serie
		If	Empty(xPREFIXO)
			xPREFIXO    :=SF2->F2_SERIE	        	// Serie
		EndIf
		xNUM_DUPLIC 	:=SF2->F2_DUPL           	// Numero da Duplicata
		xCOND_PAG   	:=SF2->F2_COND           	// Condicao de Pagamento
		xDESC_PAG	  	:=DescCond(SF2->F2_COND)	// Descricao da Consicao de Pagamento
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Levantamento de Dados - Rodape da Nota Fiscal de Saida       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		xBASE_IPI   	:=SF2->F2_BASEIPI        	// Base   do IPI
		xVALOR_IPI  	:=SF2->F2_VALIPI         	// Valor  do IPI
		xBASE_ICMS  	:=SF2->F2_BASEICM        	// Base   do ICMS
		xVALOR_ICMS 	:=SF2->F2_VALICM         	// Valor  do ICMS
		xBSICMRET   	:=SF2->F2_BRICMS         	// Base do ICMS Retido
		xICMS_RET   	:=SF2->F2_ICMSRET        	// Valor  do ICMS Retido
		xFRETE      	:=SF2->F2_FRETE          	// Frete
		xSEGURO     	:=SF2->F2_SEGURO         	// Seguro
		xDESPESA    	:=SF2->F2_DESPESA  			// Despesas Acessorias da Nota Fiscal
		xTOT_FAT    	:=SF2->F2_VALBRUT        	// Valor Bruto da Fatura
		XDESC_NOTA      :=SF2->F2_DESCONT          // Valor do Desconto na Nota
		XALIQISS		:=5		    				// Aliquota de ISS
		XBASEISS		:=SF2->F2_BASEISS			// Base de ISS
		XTOT_ISS		:=SF2->F2_VALISS 			// Valor total do ISS
		xESPECIE 		:=SF2->F2_ESPECI1        	// Especie 1 no Pedido
		xVOLUME  		:=SF2->F2_VOLUME1        	// Volume 1 no Pedido
		//xPLIQUI  		:=SF2->F2_PLIQUI         	// Peso Liquido
		xPBRUTO  		:=SF2->F2_PBRUTO         	// Peso Bruto

		xPV				:= ""						// Numero do Pedido que sera impresso
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Levantamento de Dados - Itens da Nota Fiscal de Saida        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("SD2")
		dbSetOrder(3)
		dbSeek(xFilial()+xNUM_NF+xSERIE)
		
		while !eof() .and. SD2->D2_DOC == xNUM_NF .and. SD2->D2_SERIE==xSERIE
			
			If 	SD2->D2_SERIE # mv_par03        		// Se a Serie do Arquivo for Diferente
				DbSkip()                   			// do Parametro Informado !!!
				Loop
			Endif
			
			AADD(xCOD_PRO  ,SD2->D2_COD)   										// Codigo do Produto
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Pesquisa Desc. Generica do Produto          ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			dbSelectArea("SB1")
			dbSetOrder(1)
			dbSeek	(xFilial() + SD2->D2_COD)
			AADD(xDESC_PRO ,SB1->B1_DESC)										// Descricao Generica do Produto 
		           
			dbSelectArea("SD2")

			If Empty(aScan(xMEN_TRIB,SD2->D2_CLASFIS))
			    if Empty(SD2->D2_CLASFIS)
  			    	AADD(xMEN_TRIB,"000")
  			      ELSE	
				    AADD(xMEN_TRIB,SD2->D2_CLASFIS)
				ENDIF    
			Endif
		
			npElem := ascan(xCLAS_FIS,SB1->B1_POSIPI)
			
			if npElem == 0
				AADD(xCLAS_FIS  ,SB1->B1_POSIPI)
			endif
			
			npElem := ascan(xCLAS_FIS,SB1->B1_POSIPI)
			
			DO CASE
				CASE npElem == 1
					_CLASFIS := "A"
					
				CASE npElem == 2
					_CLASFIS := "B"
					
				CASE npElem == 3
					_CLASFIS := "C"
					
				CASE npElem == 4
					_CLASFIS := "D"
					
				CASE npElem == 5
					_CLASFIS := "E"
					
				CASE npElem == 6
					_CLASFIS := "F"
					
			ENDCASE                   
			
			AADD(xCLFISCAL,_CLASFIS)
			

			if empty(xPV)
				xPV:= SD2->D2_PEDIDO
			endif

			AADD(xTIPO_PRO ,SB1->B1_TIPO)										// Tipo do Produto
			AADD(xLUCRO    ,SB1->B1_PICMRET)									// Percentual ICMS Retido do Produto
			
			AADD(xUNID_PRO ,SD2->D2_UM)											// Unidade do Produto
			AADD(xCOD_TRIB ,SD2->D2_CLASFIS)									// Situacao Tributaria
			AADD(XNUNSERIE ,SD2->D2_NUMSERI)									// Numero de Serie
			
			AADD(xQTD_PRO  ,SD2->D2_QUANT)     									// Guarda as quantidade da NF
			AADD(xPRE_UNI  ,SD2->D2_PRCVEN)										// Preco Unitario
			AADD(xPRE_TAB  ,SD2->D2_PRUNIT)										// Preco de tabela
			AADD(xDESC     ,SD2->D2_DESC)										// % Desconto
			AADD(xIPI      ,IIF(Empty(SD2->D2_IPI),0,SD2->D2_IPI)) 			// % IPI
			AADD(xVAL_IPI  ,SD2->D2_VALIPI)										// Valor do IPI
			AADD(xICM_PROD ,IIf(Empty(SD2->D2_PICM),0,SD2->D2_PICM))			// Percentual de ICMS
			AADD(xICMS     ,IIf(Empty(SD2->D2_PICM),0,SD2->D2_PICM)) 			// Valor do ICMS
			AADD(xVAL_MERC ,SD2->D2_TOTAL)										// Valor Total da Mercadoria
			
			AADD(xTES      ,SD2->D2_TES)										// Tipo de Entrada/Saida
			AADD(xCF2      ,SD2->D2_CF)											// Codigo Fiscal de Operacoes
			ChecaTES_CFO(SD2->D2_TES)
			AADD(xPEDIDO 	,SD2->D2_PEDIDO)										// Pedido de Vendas
			AADD(xITEM_PED ,SD2->D2_ITEMPV)          
			
//			Alterado para Multiplicar o peso liquido pela quantidade			
			AADD(xPed_PesoLiq,SD2->D2_PESO)										// Item do Pedido de Vendas
//			AADD(xPed_PesoLiq,SD2->D2_PESO * SD2->D2_QUANT)										// Item do Pedido de Vendas
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Pesquisa dados nos itens dos pedidos.                        ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			dbSelectArea("SC6")
			dbSetOrder(1)
			dbSeek(xFilial() + SD2->D2_PEDIDO + SD2->D2_ITEMPV)
			AADD(xPED_CLI ,SC6->C6_PEDCLI)										// Pedido do Cliente
			AADD(xVAL_DESC,SC6->C6_VALDESC)										// Desconto Concedido p/Item
			AADD(xDESCR,SC6->C6_DESCRI)			  
		//	AADD(xIMPRIMIR ,Iif (Empty(SC6->C6_CODACAB),"S","N"))				// Descricao do Item no pedido
			
			AADD(xNUM_NFDV ,IIF(Empty(SD2->D2_NFORI),"",SD2->D2_NFORI))		// Nota Fiscal Original
			AADD(xPREF_DV  ,IIF(Empty(SD2->D2_SERIORI),"",SD2->D2_SERIORI))	// Serie da Nota Fiscal Origem
			If 	!Empty(SD2->D2_NFORI)
				dbSelectArea("SF1")
				dbSetOrder(1)
				IF 	dbSeek(xFilial()+SD2->D2_NFORI+SD2->D2_SERIORI+SF2->F2_CLIENTE+SF2->F2_LOJA)
					AADD(xEMIS_DV , DTOC(SF1->F1_EMISSAO))						// Data de Emissao da NF Origem
					AADD(XPROP_NFDV,SF1->F1_FORMUL)
				EndIf
			EndIf
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Acumula total das mercadorias para impressao na Nota Fiscal   ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			//xVALOR_MERC 	:=	xVALOR_MERC + SD2->D2_TOTAL         			// Acumula Total das Mercadorias
			
			dbSelectArea("SD2")
			dbSetOrder(3)
			dbskip()
		End
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Levantamento de Dados - Dados dos Cabeçalho do Pedido de Vendas            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		
		For _nConta:=1 	to 	Len(xPEDIDO)
			dbSelectArea("SC5")
			dbSetOrder(1)
			dbSeek( xFilial("SC5") + xPEDIDO[_nConta] )
			If ASCAN(xPED,xPEDIDO[_nConta])==0
				dbSeek(xFilial()+xPEDIDO[_nConta])
				
				AADD(xPED,xPEDIDO[_nConta])
				
				xCOD_MENS   :=SC5->C5_MENPAD             // Codigo da Mensagem Padrao
				xMENSAGEM   :=SC5->C5_MENNOTA            // Mensagem para a Nota Fiscal
				xTPFRETE 	:=SC5->C5_TPFRETE            // Tipo de Entrega
				
				// Como existem varios campos com o numero sequencial e checado se existe o campo
				// no dicionario de dados.
				_nConta2	:=	0
				_lContinua	:=	.t.
				While 	_lContinua
					_nConta2++
					_cCampo:="C5_VEND" + Str(_nConta2)
					If	ExitCampo(_cCampo)
						_cCampo:= "SC5->" + _cCampo
						If 	ASCAN(xCOD_VEND,&(_cCampo))==0
							AADD(xCOD_VEND ,&(_cCampo))		//Codigo dos Vendedores
							
							//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
							//³ Pesquisa Cadastro de Vendedores             ³
							//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
							dbSelectArea("SA3")
							dbSetOrder(1)
							dbSeek(xFilial()+xCOD_VEND[_nConta2])
							Aadd(xVENDEDOR,SA3->A3_NREDUZ)
						EndIf
					Else
						_lContinua	:=	.f.
					EndIf
				End
				
				_nConta2	:=	0
				_lContinua	:=	.t.
				While 	_lContinua
					_nConta2++
					_cCampo:="C5_DESC" + Str(_nConta2)
					If	ExitCampo(_cCampo)
						_cCampo:= "SC5->" + _cCampo
						AADD(xDESC_NF ,&(_cCampo))		//Descontos Concedidos no Cabecalho do Pedido
					Else
						_lContinua	:=	.f.
					EndIf
				End
			Endif
		Next
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Pesquisa dados da Transportadora            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		PesqTransp(SF2->F2_TRANSP)
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Pesquisa Titulos a Receber                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		MontaDupli(XPREFIXO,xNUM_DUPLIC,SF2->F2_CLIENTE,SF2->F2_LOJA,"NF")
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime Documento                           ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		Imprime()
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Termino da Impressao da Nota Fiscal                          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		IncRegua()                    // Termometro de Impressao
		nLin:=0
		dbSelectArea("SF2")
		dbSkip()                      // passa para a proxima Nota Fiscal
	EndDo

Else
    
    // NF DE ENTRADA
    
	dbSelectArea("SF1")              // * Cabecalho da Nota Fiscal Entrada
	dbSetOrder(1)
	dbSeek(xFilial()+mv_par01+mv_par03,.t.)
	
	While !eof() .and. SF1->F1_DOC <= mv_par02 .and. lContinua
		If 	SF1->F1_SERIE #mv_par03    // Se a Serie do Arquivo for Diferente
			DbSkip()                   // do Parametro Informado !!!
			Loop
		Endif
		
		// Comentado 18/01/08
		/*
		If 	SF1->F1_FORMUL!="S"    		// Se a Serie do Arquivo for Diferente
			DbSkip()                   	// do Parametro Informado !!!
			Loop
		Endif
        */


		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Inicializa  regua de impressao                            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		SetRegua(Val(mv_par02)-Val(mv_par01))
		
		IF 	lAbortPrint
			@ 00,01 PSAY "** CANCELADO PELO OPERADOR **"
			lContinua := .F.
			Exit
		Endif
		
		// Limpa variaveis acumuladoras para impressao
		LimpaVarImp()
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Levantamento dos Dados: Cabecalho da Nota Fiscal             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		
		xNUM_NF     :=SF1->F1_DOC             // Numero
		xSERIE      :=SF1->F1_SERIE           // Serie
		xEMISSAO    :=SF1->F1_EMISSAO         // Data de Emissao
		xTIPO       :=SF1->F1_TIPO            // Tipo de nota fiscal
		xCLIENTE    :=SF1->F1_FORNECE         // Cliente/Fornecedor
		xLOJA       :=SF1->F1_LOJA            // Loja do Cliente
		PesqCliFor("E",SF1->F1_TIPO,SF1->F1_FORNECE,SF1->F1_LOJA)
		
		xPREFIXO    	:=SF1->F1_PREFIXO        	// Serie
		If	Empty(xPREFIXO)
			xPREFIXO    :=SF1->F1_SERIE	        	// Serie
		EndIf
		xNUM_DUPLIC 	:=SF1->F1_DUPL           	// Numero da Duplicata
		If	Empty(xNUM_DUPLIC)
			xNUM_DUPLIC	:=SF1->F1_DOC	       	// Numero da Duplicata
		EndIf
        
		//18/01/08
		xNUM_DUPLIC :=SF1->F1_DUPL            // Numero da Duplicata
		
		MontaDupli(XPREFIXO,xNUM_DUPLIC,SF1->F1_FORNECE,SF1->F1_LOJA,"NF")

		xCOND_PAG   :=SF1->F1_COND            	// Condicao de Pagamento
		xDESC_PAG	:=DescCond(SF1->F1_COND)	// Descricao da Consicao de Pagamento
		xTOT_FAT    :=SF1->F1_VALBRUT         	// Valor Bruto da Compra
		xFRETE      :=SF1->F1_FRETE           	// Frete
		xSEGURO     :=SF1->F1_Seguro          	// Seguro
		xDespesa    :=SF1->F1_DESPESA         	// Despesa
		xBASE_ICMS  :=SF1->F1_BASEICM         	// Base   do ICMS
		xBASE_IPI   :=SF1->F1_BASEIPI         	// Base   do IPI
		xBSICMRET   :=SF1->F1_BRICMS          	// Base do ICMS Retido
		xVALOR_ICMS :=SF1->F1_VALICM         	// Valor  do ICMS
		xICMS_RET   :=SF1->F1_ICMSRET         	// Valor  do ICMS Retido
		xVALOR_IPI  :=SF1->F1_VALIPI          	// Valor  do IPI

		XALIQISS		:=5		    			// Aliquota de ISS
		XBASEISS		:=0		    			// Base de ISS
		XTOT_ISS		:=SF1->F1_ISS 		 	// Valor total do ISS
		
		
		
		dbSelectArea("SD1")
		dbSetOrder(1)
		dbSeek(xFilial()+xNUM_NF+xSERIE+xCLIENTE+xLOJA)
		
		while !eof() .and. SD1->D1_DOC==xNUM_NF
			If SD1->D1_SERIE # mv_par03         // Se a Serie do Arquivo for Diferente
				DbSkip()                       	// do Parametro Informado !!!
				Loop
			Endif
			
			AADD(xPEDIDO 	,SD1->D1_PEDIDO)    // Ordem de Compra
			AADD(xITEM_PED 	,SD1->D1_ITEMPC)    // Item da O.C.
			AADD(xNUM_NFDV 	,IIF(Empty(SD1->D1_NFORI),"",SD1->D1_NFORI))
			AADD(xPREF_DV  	,IIF(Empty(SD1->D1_SERIORI),"",SD1->D1_SERIORI))
			AADD(XPROP_NFDV ,"S")
			dbSelectArea("SF2")
			dbSetOrder(1)
			IF dbSeek(xFilial() + SD1->D1_NFORI + SD1->D1_SERIORI)
				AADD(xEMIS_DV , DTOC(SF2->F2_EMISSAO))
			EndIf
			
			AADD(xICMS     	,IIf(Empty(SD1->D1_PICM),0,SD1->D1_PICM))
			AADD(xCOD_PRO  	,SD1->D1_COD)            // Produto
			AADD(xQTD_PRO  	,SD1->D1_QUANT)          // Guarda as quant. da NF
			AADD(xPRE_UNI  	,SD1->D1_VUNIT)          // Valor Unitario
			AADD(xIPI      	,SD1->D1_IPI)            // % IPI
			AADD(xVAL_IPI  	,SD1->D1_VALIPI)         // Valor do IPI
			AADD(xDESC     	,SD1->D1_DESC)           // % Desconto
			AADD(xVAL_MERC 	,SD1->D1_TOTAL)          // Valor Total
			
//			xVALOR_MERC :=	 xVALOR_MERC + (SD1->D1_TOTAL - SD1->D1_VALDESC)        // Valor  Total das Mercadorias
			
			AADD(xTES      	,SD1->D1_TES)            // Tipo de Entrada/Saida
			AADD(xCF2       ,SD1->D1_CF)             // Codigo Fiscal
			ChecaTES_CFO(SD1->D1_TES)
			
			AADD(xICM_PROD ,IIf(Empty(SD1->D1_PICM),0,SD1->D1_PICM))
			
			AADD(xUNID_PRO ,SD1->D1_UM)
			AADD(xCOD_TRIB ,SD1->D1_CLASFIS)
			AADD(XNUNSERIE ," "	)					// Numero de Serie
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Pesquisa Desc. Generica do Produto          ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			dbSelectArea("SB1")
			dbSetOrder(1)
			dbSeek	(xFilial()+SD1->D1_COD)
			AADD(xDESC_PRO ,SB1->B1_DESC)
			
			// Comentado 18/01/08
			/*
			IF 	Empty(SD1->D1_X_DESCR)
				AADD(xDESCR,SB1->B1_DESC)
			Else
				AADD(xDESCR,SD1->D1_X_DESCR)
			EndIf
			*/
						
			AADD(xDESCR,SB1->B1_DESC)			
			
			
			
			AADD(XTIPO_PRO, SB1->B1_TIPO)										// Tipo do produto
			AADD(xMEN_POS  ,SB1->B1_POSIPI)
			AADD(xLUCRO    ,SB1->B1_PICMRET)
			AADD(XCLAS_FIS ,SB1->B1_CLASFIS)									// Classificacao Fiscal
			
			dbSelectArea("SD1")
			dbSetOrder(1)
			dbskip()
		End
		
		
		
		Imprime()
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Termino da Impressao da Nota Fiscal                          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		
		IncRegua()                    // Termometro de Impressao
		nLin:=0
		
		dbSelectArea("SF1")
		dbSetOrder(1)
		dbSkip()                     // e passa para a proxima Nota Fiscal
		
	EndDo
Endif   



@ 000, 000 PSAY chr(27)+"2"         // Impressao em 1/6   AQUI!!!
@ 000, 000 PSAY Chr(18)             // Descompressao de Impressao

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³                                                              ³
//³                      FIM DA IMPRESSAO                        ³
//³                                                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

dbSelectArea("SF2")
Retindex("SF2")
dbSelectArea("SF1")
Retindex("SF1")
dbSelectArea("SD2")
Retindex("SD2")
dbSelectArea("SD1")
Retindex("SD1")
Set Device To Screen

If aReturn[5] == 1
	Set Printer TO
	dbcommitAll()
	ourspool(wnrel)
Endif

MS_FLUSH()

Return()



//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³                   FUNCOES ESPECIFICAS                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ VERIMP   ³ Autor ³   Marcos Simidu       ³ Data ³ 20/12/95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Verifica posicionamento de papel na Impressora             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Nfiscal                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function VerImp()

nLin:= 0                // Contador de Linhas
If aReturn[5]==2
	nOpc:= 1
	While .T.
		SetPrc(0,0)
		dbCommitAll()
		@ nLin ,000 PSAY " "
		@ nLin ,004 PSAY "*"
		@ nLin ,022 PSAY "."
		IF MsgYesNo("Fomulario esta posicionado ? ")
			nOpc := 1
		Else
			IF 	MsgYesNo("Tenta Novamente ? ")
				nOpc := 2
			Else
				nOpc := 3
			EndIf
		Endif
		Do Case
			Case nOpc==1
				lContinua:=.T.
				Exit
			Case nOpc==2
				Loop
			Case nOpc==3
				lContinua:=.F.
				Return
		EndCase
	End
Endif

Return()



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ IMPRIME  ³ Autor ³   Mario Falcheti Jr   ³ Data ³ 27/03/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime a Nota Fiscal de Entrada e de Saida                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Imprime()

@ 000, 000 PSAY chr(27)+"0"                // Impressao em 1/8
@ 000, 002 PSAY Chr(15)                		// Compressao de Impressao

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cabecalho da N.F.                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cabecalho()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Detalhe da Nota Fiscal              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ImpDet()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Rodape da Nota Fiscal               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

nLin := 060							   						// Linha que sera realizada a impressao
@ nLin, 006  PSAY xBASE_ICMS  Picture "@E@Z 999,999,999.99"  // Base do ICMS
@ nLin, 032  PSAY xVALOR_ICMS Picture "@E@Z 999,999,999.99"  // Valor do ICMS
@ nLin, 062  PSAY xBSICMRET   Picture "@E@Z 999,999,999.99"  // Base ICMS Ret.
@ nLin, 089  PSAY xICMS_RET   Picture "@E@Z 999,999,999.99"  // Valor  ICMS Ret.
@ nLin, 110  PSAY xVALOR_MERC Picture "@E@Z 999,999,999.99"  // Valor Tot. Prod.

nLin := 063										   			// Linha que sera realizada a impressao
@ nLin, 006  PSAY xFRETE      Picture "@E@Z 999,999,999.99"  // Valor do Frete
@ nLin, 032  PSAY xSEGURO     Picture "@E@Z 999,999,999.99"  // Valor Seguro
@ nLin, 062  PSAY xDespesa    Picture "@E@Z 999,999,999.99"  // Valor Despesa
@ nLin, 089  PSAY xVALOR_IPI  Picture "@E@Z 999,999,999.99"  // Valor do IPI
@ nLin, 110  PSAY xTOT_FAT    Picture "@E@Z 999,999,999.99"  // Valor Total NF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao Dados da Transportadora  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nLin := 067												// Linha que sera realizada a impressao
@ nLin, 006  PSAY xNOME_TRANSP                       	// Nome da Transport.
If xTPFRETE=='C'                                    	// Frete por conta do
	@ nLin, 078 PSAY "1"                              	// Emitente (1)
Else                                                	//     ou
	@ nLin, 078 PSAY "2"                             	// Destinatario (2)
Endif          

If !EMPTY(xCGC_TRANSP)                              	// Se C.G.C. Transportador nao for Vazio
	If 	Len(AllTrim(xCGC_TRANSP))==14
		@ nLin, 120 PSAY xCGC_TRANSP Picture "@R 99.999.999/9999-99"
	Else
		@ nLin, 120 PSAY xCGC_TRANSP Picture "@R 999.999.999-99"
	EndIf
Endif

nLin := 068										   		// Linha que sera realizada a impressao
@ nLin, 006 PSAY xEND_TRANSP                         	// Endereco Transp.
@ nLin, 075 PSAY xMUN_TRANSP                         	// Municipio
@ nLin, 110 PSAY xEST_TRANSP                         	// U.F.
@ nLin, 120 PSAY " "                                 	// Reservado p/Insc. Estad.

nLin := 072												// Linha que sera realizada a impressao
@ nLin, 006 PSAY xVOLUME  Picture "@E@Z 999,999.99"   	// Quant. Volumes
@ nLin, 021 PSAY xESPECIE Picture "@!"                	// Especie


If mv_par04 == 2
	@ nLin, 068 PSAY xPV  Picture "@!"                	// Numero do Pedido
Endif

@ nLin, 095 PSAY xPBRUTO  Picture "@E@Z 999,999.999" 	// Res para Peso Bruto
@ nLin, 110 PSAY xPLIQUI  Picture "@E@Z 999,999.999" 	// Res para Peso Liquido

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao de Duplicadas            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DUPLIC()

// Observacoes Fixas
If 	Len(xNUM_NFDV) > 0  .and. !Empty(xNUM_NFDV[1])

	nLin 	:= 	065										// Linha que sera realizada a impressao
	nCol	:=	010										// Coluna que sera realizada a impressao
	If  len(xPROP_NFDV)>0 .and. 	xPROP_NFDV[1]="S"
		nCol:=	040										// Coluna que sera realizada a impressao    
	EndIf

EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao de Observacoes Variaveis ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
_nLim_OBS	:=	075
nLin		:=	091
nCol		:=	006


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime folhas das notas fiscais de saida ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  _NPAG > 0 .And. nLin < _nLim_OBS
	_NPAG++
	@ nLin, nCol PSAY "Folha " + StrZero(_NPAG,3,0) + "/" + StrZero(_nTot_Pag,3,0) + "."
	nlin++
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime endereco de entrega.       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If	!empty(XREC_CLI) .and.	XEND_CLI!=XREC_CLI
	@ nLin, nCol PSAY XREC_CLI
	nLin++
	@ nLin, nCol PSAY "Cep: " + Trans(XCEPE_CLI,"@R 99999-999") + " - " + Trim(XMUNE_CLI) + " / " + XESTE_CLI
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fecho da Nota Fiscal               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nLin:=099
@ nLin, 115 PSAY xNUM_NF                   	// Numero da Nota Fiscal

nLin:=104
@ nLin, 000 PSAY " "

SetPrc(0,0)                                	// (Zera o Formulario)

Return()


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Cabecalho³ Autor ³   Mario Falcheti Jr   ³ Data ³ 27/03/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime o Cabecalho do formulario de Nota Fiscal           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Faturamento - Emissao de Nota Fiscal                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Cabecalho()

Local  _nConta1:=0
Local  _nColuna:=0
Local  _nMaximo:=0

nLin := 001								// Linha que sera realizada a impressao
@ nLin, 120 PSAY xNUM_NF                // Numero da Nota Fiscal

nLin := 004								// Linha que sera realizada a impressao
If mv_par04 == 1
	//@ nLin, 110 PSAY "X"				// Tipo de Nota Fiscal - Entrada
	@ nLin, 98 PSAY "X"				// Tipo de Nota Fiscal - Entrada
Else                                    //                     - Saida
	@ nLin, 080 PSAY "X"
Endif


//nLin := 010								// Linha que sera realizada a impressao
//If 	Len(xNATUREZA)!=0
//	@ nLin, 006 PSAY xNATUREZA[1]       // Texto da Natureza de Operacao//
//EndIf

_nMaximo := 2    
nLin := 010								// Linha que sera realizada a impressao
_nColuna := 006               
For _nConta1:=1 to Len(xNATUREZA)
	If 	_nConta1	>	1
		@ nLin, _nColuna PSAY "/"
		_nColuna++
	EndIf
	@ nLin, _nColuna PSAY xNATUREZA[_nConta1]
	_nColuna+=Len(xNATUREZA[_nConta1]) // 15
	If 	_nConta1=_nMaximo
		_nConta1:=Len(xNATUREZA)
	EndIf
Next


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao dos Codigos Fiscais      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
_nColuna := 043  						// Coluna inicial para impressao dos CFOPs
_nMaximo := 4							// Numero maximo de CFO impressos no cabecalho da Nota Fiscal.
For _nConta1:=1 to Len(xCF)
	If 	_nConta1	>	1
		@ nLin, _nColuna PSAY "/"
		_nColuna++
	EndIf
	@ nLin, _nColuna PSAY xCF[_nConta1]
	_nColuna+=5
	If 	_nConta1=_nMaximo
		_nConta1:=Len(xCF)
	EndIf
Next


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao dos Dados do Cliente      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nLin := 014								// Linha que sera realizada a impressao
@ nLin, 006 PSAY xNOME_CLI              //Nome do Cliente

If 	!EMPTY(xCGC_CLI)                   	// Se o C.G.C. do Cli/Forn nao for Vazio
	If 	Len(AllTrim(xCGC_CLI))==14
		@ nLin, 085 PSAY xCGC_CLI Picture "@R 99.999.999/9999-99"
	Else
		@ nLin, 085 PSAY xCGC_CLI Picture "@R 999.999.999-99"
	EndIf
Endif
@ nLin, 115 PSAY xEMISSAO              	// Data da Emissao do Documento

nLin := 017								// Linha que sera realizada a impressao
@ nLin, 006 PSAY xEND_CLI               // Endereco
@ nLin, 072 PSAY xBAIRRO                // Bairro
@ nLin, 95 PSAY xCEP_CLI Picture "@R 99999-999"         // CEP
@ nLin, 115 PSAY " "                    // Data Saida/Entrada


nLin := 020								// Linha que sera realizada a impressao
@ nLin, 006 PSAY xMUN_CLI               // Municipio
@ nLin, 058 PSAY xTEL_CLI               // Telefone/FAX

// Se o tipo do Cliente/Fornecedor for "X" imprimir pais
//If	xTIPO_CLI == "X"
//	@ nLin, 085 PSAY xPAIS_CLI          // Pais do Cliente
//EndIf
@ nLin, 076 PSAY xEST_CLI               // U.F.
@ nLin, 085 PSAY xINSC_CLI              // Insc. Estadual
@ nLin, 115 PSAY " "                    // Hora da Saida    

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao dos Dados da Fatura       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oNFatura := DescCond(xCond_Pag) 
nLin := 23
@ nLin,006 PSAY oNFatura


Return()


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ DUPLIC   ³ Autor ³   Mario Falcheti Jr.  ³ Data ³ 27/03/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao do Parcelamento das Duplicatas                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Nfiscal                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function DUPLIC()
Local oPosTitulo 	:= {}
Local nLin 			:= 076		
Local nCol1			:= 003 // 004
Local nCol2			:= 005 // 007
Local nCol3			:= 022 // 023
Local nCol4			:= 063 // 065	

IF LEN(XPARC_DUP)>0
   FOR I:=1 TO LEN(XPARC_DUP)
       aAdd(oPosTitulo,{Alltrim(xParc_Dup[I]),xValor_Dup[I],xVenc_Dup[I]," "})
   NEXT
Endif

IF LEN(xCLAS_FIS)>0

		_cContDupl := iif( LEN(XPARC_DUP) < LEN(xCLAS_FIS),LEN(XPARC_DUP),LEN(xCLAS_FIS) )

   		FOR AA:= 1 TO _cContDupl
      		 oPostitulo[AA][4] := xCLAS_FIS[AA]
   		NEXT
    
        FOR AB:=AA TO LEN(xCLAS_FIS)
           aAdd(oPosTitulo,{"","","",xCLAS_FIS[AB]})
       NEXT    
ENDIF
 
IF LEN(oPosTitulo)>0   
   FOR I:=1 to LEN(oPosTitulo)

	if !empty(oPosTitulo[I][1]) .OR. !empty(oPosTitulo[I][3])
       @ nLin,03  PSAY substr( Alltrim(oPosTitulo[I][1]),1,1)
       @ nLin,05  PSAY transform(oPosTitulo[I][2],"@E 99,999,999.99")
       @ nLin,22  PSAY oPosTitulo[I][3] picture "@D"
       @ nLin,63  PSAY substr(alltrim(oPosTitulo[I][4] ),1,8)
	else
       @ nLin,65  PSAY substr(alltrim(oPosTitulo[I][4] ),1,8)
	endif

//       IF nLin > 86
//          	nLin := 76
//			nCol1:= 035
//			nCol2:= 040
//			nCol3:= 055  
//	   endif	  
	   nLin:=nLin+1             
   NEXT  
endif

Return()

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ IMPDET   ³ Autor ³   Mario Falcheti Jr.  ³ Data ³ 27/03/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao de Linhas de Detalhe da Nota Fiscal              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Nfiscal                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function IMPDET()

Local	_QuantDet	:=	0
Local	_QuantDetS	:=	0


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica a necessidade de Quebra de Paginas e Totais de Paginas  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
// Inicializa Variaveis
_NPAG		:=	0
_nTot_Pag	:=	0

If	Len(xCOD_PRO)	>	nTamDet
	For	I:=1 	to 	Len(xCOD_PRO)
		If	xCF2[I] $  "SER;PRE"
			_QuantDetS++
		Else
			_QuantDet++
		EndIf
	Next

	If 	_QuantDet	>	nTamDet		.Or.;
		_QuantDetS	>	nTamDetS
		// Calcula total de paginas da Nota Fiscal.
		_nTot_Pag:= Round((_QuantDetS/nTamDetS),0)
		If	_nTot_Pag	> 	1
			_nTot_Pag:= ( _nTot_Pag + (Round((_QuantDet/nTamDet),0)) - 1 )
		EndIf
	EndIf
EndIf



//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime materiais ou mercadorias                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nLin:= 	nLIniDet      	   		   			// Inicio da Impressao do Detalhe na NF.
J	:=	0					   	   			// Inicializa contador para quebra de formulario




For I:=1 to Len(xCOD_PRO)
	
   AADD(xMEN_TRIB,"000")

	If mv_par04 == 2 // se for nf de saida...
	

		If	XTIPO_PRO[I] <> "0"	 .And. XTIPO_PRO[I] <> "MO"  //.And. xIMPRIMIR[I] == "S"
		
			@ nLin, 008  PSAY substr(xDESCR[I],1,31)+"-"+substr(XNUNSERIE[I],1,10)
	
			if !EMPTY(xCLFISCAL[I])
	  		   @ nLin, 052  PSAY xCLFISCAL[I] 
	  		ENDIF
	  		

		 	IF !EMPTY(xMEN_TRIB[I])   
			   @ nLin, 056  PSAY xMEN_TRIB[I]   
		 	ENDIF
		 	   
			@ nLin, 062  PSAY XUNID_PRO[I]
			@ nLin, 065  PSAY XQTD_PRO[I]             		Picture "@E 9999.99"
			@ nLin, 072  PSAY XPRE_UNI[I]              		Picture "@E 99,999,999.99"
			@ nLin, 090  PSAY XVAL_MERC[I]             		Picture "@E 99,999,999.99"
			@ nLin, 109  PSAY XICM_PROD[I]           		Picture "99"
			@ nLin, 113  PSAY XIPI[I]		           		Picture "99"
			@ nLin, 119  PSAY XVAL_IPI[I]           		Picture "@E 999,999.99"  
			xVALOR_MERC := xVALOR_MERC + XVAL_MERC[I]       
	         
			nLin++
			J++
	
			// Controle de Quebra de Formulario
			If 	J 	>= 	nTamDet
				Quebra_NF()
			
			// Reinicia Variaveis
				J	:=	0
				nLin:= 	nLIniDet
			Endif
		
	  

		EndIf   
		
		xPLIQUI := xPLIQUI + ( XPED_PESOLIQ[I] * XQTD_PRO[I] ) 	
       
       
    Else // se for nf de entrada...
    
		@ nLin, 008  PSAY substr(xDESCR[I],1,31)+"-"+substr(XNUNSERIE[I],1,10)

		// Comentado por 18/01/08
		/*
		
		if !EMPTY(xCLFISCAL[I])
  		   @ nLin, 052  PSAY xCLFISCAL[I] 
  		ENDIF
  		
  		IF !EMPTY(xMEN_TRIB[I])   
		   @ nLin, 056  PSAY xMEN_TRIB[I]   
		ENDIF   
		
		*/
		
		@ nLin, 062  PSAY XUNID_PRO[I]
		@ nLin, 065  PSAY XQTD_PRO[I]             		Picture "@E 9999.99"
		@ nLin, 072  PSAY XPRE_UNI[I]              		Picture "@E 99,999,999.99"
		@ nLin, 090  PSAY XVAL_MERC[I]             		Picture "@E 99,999,999.99"
		@ nLin, 109  PSAY XICM_PROD[I]           		Picture "99"
		@ nLin, 113  PSAY XIPI[I]		           		Picture "99"
		@ nLin, 119  PSAY XVAL_IPI[I]           		Picture "@E 999,999.99"  
		xVALOR_MERC := xVALOR_MERC + XVAL_MERC[I]       
        
 
		nLin++
		J++

		// Controle de Quebra de Formulario
		If 	J 	>= 	nTamDet
			Quebra_NF()
		
		// Reinicia Variaveis
			J	:=	0
			nLin:= 	nLIniDet
		Endif
    
    EndIf
    
Next





IF XDESC_NOTA > 0
   nLin++
   @ nLin,008 PSAY "Valor Bruto da Nota:"+Transform(xTOT_FAT+XDESC_NOTA,"@E 999,999,999.99")+" Valor Desconto: "+Transform(XDESC_NOTA,"@E 999,999,999.99")+" Valor Liquido :"+Transform(xTOT_FAT,"@E 999,999,999.99")
ENDIF                     

IF XDESC_NOTA == 0 .AND. LEN(xVAL_DESC)>0  
   FOR I:= 1 TO LEN(xVAL_DESC)
       XDESC_NOTA := XDESC_NOTA + xVAL_DESC[I]
   NEXT                                       
   @ nLin,008 PSAY "Valor Bruto da Nota:"+Transform(xTOT_FAT+XDESC_NOTA,"@E 999,999,999.99")+" Valor Desconto: "+Transform(XDESC_NOTA,"@E 999,999,999.99")+" Valor Liquido :"+Transform(xTOT_FAT,"@E 999,999,999.99")   
ENDIF 

If mv_par04 = 2
Else
   nLin++
	If SF1->F1_TIPO == "D"
		@ nLin, 009  PSAY  "Retorno de material conf. NF: " + xNUM_NFDV[1] + " de " + DtoC(GetAdvFval("SF2", "F2_EMISSAO", xFilial("SF2")+xNUM_NFDV[1]+xPREF_DV[1], 1, ""))
		
	EndIf
	nLin+=1
EndIf



//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime Mensagem para Nota Fiscal (Formula - Cadastro de TES)    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
_Men := Alltrim(Formula(xForm))
if nLin < 46    //47  
  
  nLin := 46    //47   
  if !empty(Alltrim(Substr(_Men,1,110)))
      @ nLin, 004  PSAY  "Obs.: "+Alltrim(Substr(_Men,1,110)) 
  endif
  if !empty(Alltrim(Substr(_Men,111,110)))    
      nLin+=1
      @ nLin, 004  PSAY  "Obs.: "+Alltrim(Substr(_Men,111,110))  
  endif    
endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime Mensagem para Nota Fiscal (C5_MENNOTA)                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If	!Empty(XMENSAGEM)
	nLin+=1
	@ nLin, 004  PSAY "Obs.: " + Alltrim(XMENSAGEM)
EndIf		


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime Endereco de Cobranca      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
if !empty(xEND_COB)
	nLin+=1
	_strCobr := Alltrim(xEND_COB) +" - "+Alltrim(xBAI_COB) +" - "+Alltrim(xMUN_COB)+"-"+xEST_COB+"   CEP: "+ Trans(xCEP_COB,"@R 99999-999")
	@ nLin, 004  PSAY  "End.Cobranca.: "+_strCobr 
endif


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime Servicos                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nLin:= 	nLIniDetS				// Inicio da Impressao do Detalhe na NF.
J	:=	0						// Inicializa contador para quebra de formulario

For J:=1 to Len(xCOD_PRO)

	If	 XTIPO_PRO[J] = "MO"

		@ nLin, 006  PSAY xDESCR[J]	
		@ nLin, 110  PSAY SF2->F2_VALISS             		Picture "@E 99,999,999.99"		
		nLin :=nLin+2
		@ nLin, 110  PSAY SF2->F2_BASEISS             		Picture "@E 99,999,999.99"		
		nLin :=nLin+1
		
		J++

	EndIf
Next



Return()


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Quebra_NF³ Autor ³   Mario Falcheti Jr   ³ Data ³ 27/03/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Faz a quebra de formularios de Notas Fiscais               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Faturamento - Emissao de Nota Fiscal                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Quebra_NF()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Calculo dos Impostos                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

nLin:=060
@ nLin, 010 PSAY "***************"  // Base do ICMS
@ nLin, 036 PSAY "***************"  // Valor do ICMS
@ nLin, 064 PSAY "***************"  // Base ICMS Ret.
@ nLin, 092 PSAY "***************"  // Valor  ICMS Ret.
@ nLin, 120 PSAY "***************"  // Valor Tot. Prod.

nLin:=063
@ nLin, 010 PSAY "***************"  // Valor do Frete
@ nLin, 036 PSAY "***************"  // Valor Seguro
@ nLin, 064 PSAY "***************"  // Valor Despesa
@ nLin, 092 PSAY "***************"  // Valor do IPI
@ nLin, 120 PSAY "***************"  // Valor Total NF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Observacoes                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
_NPAG++
nLin:=071
@ nLin, 010 PSAY "Folha " + StrZero(_NPAG,3,0) + "/" + StrZero(_nTot_Pag,3,0) +", Continua."

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fecho da Nota Fiscal               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

nLin:=099
@ nLin, 115 PSAY xNUM_NF                   	// Numero da Nota Fiscal

nLin:=104
@ nLin, 000 PSAY " "

SetPrc(0,0)                                	// (Zera o Formulario)


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cabecalho do Novo Formulario       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Cabecalho()

Return()



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³DescCond  ³ Autor ³   Mario Falcheti Jr.  ³ Data ³ 27/03/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Verifica posicionamento de papel na Impressora             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Nfiscal                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function DescCond(_xCodCond)

Local _xDescCond	:=	_xCodCond
Local _aAreaAtu		:=	GetArea()

	dbSelectArea("SE4")
	dbSetOrder(1)
	If 	dbSeek(xFilial()+_xCodCond)
		_xDescCond:=SE4->E4_DESCRI
	EndIf

	RestArea(_aAreaAtu)

Return(_xDescCond)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ChecaTES_CFO ³ Autor ³ Mario Falcheti Jr. ³ Data ³ 27/03/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Faz Checagens TES e CFO p/Acumulo unico  Array Cadastro TES³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Nfiscal                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function ChecaTES_CFO(_cCodTES)

// 	CFOP para ser Impresso no Cabecalho da Nota Fiscal (acumula de acordo com o gerado na nota fiscal.
If 	mv_par04 == 2
	If	!Empty(SD2->D2_CF)
		If 	Len(xCF)=0
			AADD(xCF	,SD2->D2_CF)
		Else
			For _nConta:=1 To Len(xCF)
				If 	xCF[_nConta]=SD2->D2_CF
					_nConta:=Len(xCF)
				Else
					If 	_nConta=Len(xCF)
						AADD(xCF	,SD2->D2_CF)
					EndIf
				EndIf
			Next
		EndIf
	EndIf
Else
	If	!Empty(SD1->D1_CF)
		If 	Len(xCF)=0
			AADD(xCF	,SD1->D1_CF)
		Else
			For _nConta:=1 To Len(xCF)
				If 	xCF[_nConta]=SD1->D1_CF
					_nConta:=Len(xCF)
				Else
					If 	_nConta=Len(xCF)
						AADD(xCF	,SD1->D1_CF)
					EndIf
				EndIf
			Next
		EndIf
	EndIf
EndIf



dbSelectArea("SF4")
dbSetOrder(1)
If	dbSeek( xFilial("SF4") + _cCodTES )
	xFORM := SF4->F4_FORMULA
	// Acumula texto da Natureza de Operacoes para ser impresso no Cabecalho da Nota Fiscal.
	If	!Empty(SF4->F4_TEXTO)
		If 	Len(xNATUREZA)=0
			If	!Empty(SF4->F4_TEXTO)
			   IF Ascan(xNATUREZA,SF4->F4_TEXTO) = 0
				   AADD(xNATUREZA,SF4->F4_TEXTO)
				Endif   
			EndIF
		Else
			For _nConta:=1 To Len(xNATUREZA)

					If _nConta=Len(xNATUREZA)
			  			 IF Ascan(xNATUREZA,SF4->F4_TEXTO) = 0
				   			AADD(xNATUREZA,SF4->F4_TEXTO)
						Endif   
					EndIf
			Next
		EndIf
	EndIf
	
EndIf

Return()


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Checa se existe o campo no SX3 e retorna True ou False        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function ExitCampo(_cCampo)

Local	_lRet		:=	.T.
Local	_aAreaAtu	:=	GetArea()
Local	_aAreaSX3	:=	GetArea("SX3")

dbSelectArea("SX3")
dbSetOrder(2)
If	!dbSeek(_cCampo)
	_lRet:=.f.
EndIf

RestArea(_aAreaSX3)
RestArea(_aAreaAtu)

Return (_lRet)


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Busca dados dos Cadastros de Clientes ou Fornecedor, de Acordo com a Movimentacao e o Tipo da NF ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function PesqCliFor(_cMovES,_cTipoNF,_cCOD,_cLoja)

// Informa se faz o tratamento de Zona Franca ou Nao.
zFranca			:=.F.

If	_cMovES="S"
	If _cTipoNF=='N' .OR. _cTipoNF=='C' .OR. _cTipoNF=='P' .OR. _cTipoNF=='I';
		.OR. _cTipoNF=='S' .OR. _cTipoNF=='T' .OR. _cTipoNF=='O'
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Pesquisa Cadastro de Clientes               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("SA1")
		dbSetOrder(1)
		dbSeek(xFilial("SA1")+_cCOD+_cLoja)
		
		xNOME_CLI:=SA1->A1_NOME            	// Nome
		xTIPO_CLI:=SA1->A1_TIPO            	// Tipo de Cliente
		xEND_CLI :=SA1->A1_END             	// Endereco
		xBAIRRO  :=SA1->A1_BAIRRO          	// Bairro
		xCEP_CLI :=SA1->A1_CEP             	// CEP
		
		dbSelectArea("SYA")
		dbSetOrder(1)
		dbSeek(xFilial("SYA") + SA1->A1_PAIS)
		xPAIS_CLI:=SYA->YA_DESCR         		// Pais do Cliente
		
		xEND_COB :=SA1->A1_ENDCOB          	// Endereco de Cobranca
		xBAI_COB :=SA1->A1_BAIRROC   		// Bairro de Cobranca
		xMUN_COB :=SA1->A1_MUNC	       		// Municipio de cobranca
		xCEP_COB :=SA1->A1_CEPC      		// CEP de cobranca
		xEST_COB :=SA1->A1_ESTC   			// U.F. de cobranca
		xREC_CLI :=SA1->A1_ENDENT          	// Endereco de Entrega
		XMUNE_CLI:=SA1->A1_MUNE	        	// Municipio de Entrega
		XESTE_CLI:=SA1->A1_ESTE				// Estado de Entrega
		xNREDUZ_C:=SA1->A1_NREDUZ			// Nome reduzido do Cliene
		XCEPE_CLI:=SA1->A1_CEPE				// Cep de Entrega
		xMUN_CLI :=SA1->A1_MUN             	// Municipio
		xEST_CLI :=SA1->A1_EST             	// Estado
		xCGC_CLI :=SA1->A1_CGC             	// CGC
		xINSC_CLI:=SA1->A1_INSCR           	// Inscricao estadual
		xTRAN_CLI:=SA1->A1_TRANSP          	// Transportadora
		xTEL_CLI :=SA1->A1_TEL             	// Telefone
		xFAX_CLI :=SA1->A1_FAX             	// Fax
		xSUFRAMA :=SA1->A1_SUFRAMA         	// Codigo Suframa
		xCALCSUF :=SA1->A1_CALCSUF         	// Calcula Suframa
		
		// Alteracao p/ Calculo de Suframa
		If !Empty(xSUFRAMA) .And. xCALCSUF =="S"
			If _cTipoNF != 'D' .And. _cTipoNF != 'B'
				zFranca := .T.
			Endif
		Endif
		
	Else
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Pesquisa Cadastro de Fornecedores           ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("SA2")
		dbSetOrder(1)
		dbSeek(xFilial("SA2")+_cCOD+_cLoja)
		xCOD_CLI :=SA2->A2_COD             // Codigo do Fornecedor
		xNOME_CLI:=SA2->A2_NOME            // Nome Fornecedor
		xEND_CLI :=SA2->A2_END             // Endereco
		xBAIRRO  :=SA2->A2_BAIRRO          // Bairro
		xCEP_CLI :=SA2->A2_CEP             // CEP
		xMUN_CLI :=SA2->A2_MUN             // Municipio
		xEST_CLI :=SA2->A2_EST             // Estado
		xCGC_CLI :=SA2->A2_CGC             // CGC
		xINSC_CLI:=SA2->A2_INSCR           // Inscricao estadual
		xTRAN_CLI:=SA2->A2_TRANSP          // Transportadora
		xTEL_CLI :=SA2->A2_TEL             // Telefone
		xFAX_CLI :=SA2->A2_FAX             // Fax
	Endif
Else
	If 	xTIPO == "D" .Or. xTipo =="B"
		dbSelectArea("SA1")
		dbSetOrder(1)
		dbSeek(xFilial("SA1")+_cCOD+_cLoja)
		xNOME_CLI:=SA1->A1_NOME            	// Nome
		xTIPO_CLI:=SA1->A1_TIPO            	// Tipo de Cliente
		xEND_CLI :=SA1->A1_END             	// Endereco
		xBAIRRO  :=SA1->A1_BAIRRO          	// Bairro
		xCEP_CLI :=SA1->A1_CEP             	// CEP

		dbSelectArea("SYA")
		dbSetOrder(1)
		dbSeek(xFilial("SYA") + SA1->A1_PAIS)
		xPAIS_CLI:=SYA->YA_DESCR         		// Pais do Cliente

		xEND_COB :=SA1->A1_ENDCOB          	// Endereco de Cobranca
		xBAI_COB :=SA1->A1_BAIRROC   		// Bairro de Cobranca
		xMUN_COB :=SA1->A1_MUNC	       		// Municipio de cobranca
		xCEP_COB :=SA1->A1_CEPC      		// CEP de cobranca
		xEST_COB :=SA1->A1_ESTC   			// U.F. de cobranca
		xREC_CLI :=SA1->A1_ENDENT          	// Endereco de Entrega
		XMUNE_CLI:=SA1->A1_MUNE	        	// Municipio de Entrega
		XESTE_CLI:=SA1->A1_ESTE				// Estado de Entrega
		xNREDUZ_C:=SA1->A1_NREDUZ			// Nome reduzido do Cliene
		XCEPE_CLI:=SA1->A1_CEPE				// Cep de Entrega
		xMUN_CLI :=SA1->A1_MUN             	// Municipio
		xEST_CLI :=SA1->A1_EST             	// Estado
		xCGC_CLI :=SA1->A1_CGC             	// CGC
		xINSC_CLI:=SA1->A1_INSCR           	// Inscricao estadual
		xTRAN_CLI:=SA1->A1_TRANSP          	// Transportadora
		xTEL_CLI :=SA1->A1_TEL             	// Telefone
		xFAX_CLI :=SA1->A1_FAX             	// Fax
		xSUFRAMA :=SA1->A1_SUFRAMA         	// Codigo Suframa
		xCALCSUF :=SA1->A1_CALCSUF         	// Calcula Suframa
	Else
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Cadastro de Fornecedores                    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("SA2")
		dbSetOrder(1)
		dbSeek(xFilial()+_cCod+_cLoja)
		xCOD_CLI :=SA2->A2_COD             // Codigo do Fornecedor
		xNOME_CLI:=SA2->A2_NOME            // Nome Fornecedor
		xEND_CLI :=SA2->A2_END             // Endereco
		xBAIRRO  :=SA2->A2_BAIRRO          // Bairro
		xCEP_CLI :=SA2->A2_CEP             // CEP
		xMUN_CLI :=SA2->A2_MUN             // Municipio
		xEST_CLI :=SA2->A2_EST             // Estado
		xCGC_CLI :=SA2->A2_CGC             // CGC
		xINSC_CLI:=SA2->A2_INSCR           // Inscricao estadual
		xTRAN_CLI:=SA2->A2_TRANSP          // Transportadora
		xTEL_CLI :=SA2->A2_TEL             // Telefone
		xFAX_CLI :=SA2->A2_FAX             // Fax
	EndIf
EndIf
Return()


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Pesquisa Cadastro de Transportadoras        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Static Function PesqTransp(_cCodTrans)

dbSelectArea("SA4")
dbSetOrder(1)
If	dbSeek(xFilial()+_cCodTrans)
	xNOME_TRANSP :=SA4->A4_NOME           // Nome Transportadora
	xEND_TRANSP  :=SA4->A4_END            // Endereco
	xMUN_TRANSP  :=SA4->A4_MUN            // Municipio
	xEST_TRANSP  :=SA4->A4_EST            // Estado
	xVIA_TRANSP  :=SA4->A4_VIA            // Via de Transporte
	xCGC_TRANSP  :=SA4->A4_CGC            // CGC
	xTEL_TRANSP  :=SA4->A4_TEL            // Fone
EndIf

Return()


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Pesquisa Titulos a Receber                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function MontaDupli(_cPrefixo,_cNumero,_cCliente,_cLoja,_cTipoTit)

dbSelectArea("SE1")
dbSetOrder(1)

If	Empty(_cPrefixo)
	_cPrefixo:=&(GETMV("MV_1DUPREF"))
EndIf

xDUPLICATAS:=IIF(dbSeek(xFilial() + _cPrefixo + _cNumero,.T.),.T.,.F.) // Flag p/Impressao de Duplicatas

while !eof() .and. xDUPLICATAS=.T. .and. SE1->E1_NUM=_cNumero
	If 	SE1->E1_CLIENTE!=_cCliente .Or. SE1->E1_LOJA!=_cLoja .Or. SE1->E1_TIPO!=_cTipoTit .Or. SE1->E1_PREFIXO!=_cPrefixo
		dbSkip()
		Loop
	Endif
	AADD(xPARC_DUP ,SE1->E1_PARCELA)
	AADD(xVENC_DUP ,SE1->E1_VENCTO)
	AADD(xVALOR_DUP,SE1->E1_VALOR)
	dbSkip()
EndDo
Return()


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Limpa Variaveis de Acumulo para Impressao   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function LimpaVarImp()

// Cabecalho da Nota Fiscal
xNUM_NF     	:=" "		            	// Numero
xSERIE      	:=" "		            	// Serie
xEMISSAO    	:=dDataBase					//Data de Emissao
xTIPO       	:=" "		            	// Tipo de Nota Fiscal

//Dados do Cliente
xCLIENTE    	:=" "						// Codigo do Cliente
xLOJA       	:=" "						// Loja do Cliente
xNOME_CLI		:=" "						// Nome
xTIPO_CLI		:=" "						// Tipo de Cliente
xEND_CLI 		:=" "						// Endereco
xNREDUZ_C		:=" "						// Nome Reduzido (Fantazia)
xBAIRRO  		:=" "						// Bairro
xMUN_CLI 		:=" "						// Municipio
xEST_CLI 		:=" "						// Estado
xPAIS_CLI       :=" "	             		// Pais do Cliente
xCGC_CLI 		:=" "						// Cgc
xCEP_CLI 		:=" "						// Cep
xINSC_CLI		:=" "						// Inscricao estadual do Cliente
xTRAN_CLI		:=" "						// Transportadora do Cliente
xCALCSUF 		:=" "						// Suframa
xSUFRAMA 		:=" "						// Suframa
xTEL_CLI 		:=" "						// Telefone
xFAX_CLI 		:=" "						// Fax
xEND_COB 		:=" "						// Endereco de Cobranca
xBAI_COB		:=" "                		// Bairro de Cobranca
xMUN_COB		:=" "          		       	// Municipio
xCEP_COB		:=" "   	        		// CEP
xEST_COB		:=" "             			// U.F.
xREC_CLI 		:=" "						// Endereco de Recebimento
XMUNE_CLI		:=" "						// Municipio de Entrega
XESTE_CLI		:=" "						// Estado de Entrega
XCEPE_CLI		:=" "						// Cep de Entrega
_NPAG			:=0							// Numero de Pagina
xNATUREZA		:= Array(0)	
// Duplicatas
xPREFIXO    	:=" "			        	// Prefixo gerado
xNUM_DUPLIC 	:=" "			           	// Numero da Duplicata gerada
xCOND_PAG   	:=" "			           	// Condicao de Pagamento
xDESC_PAG	  	:=" "						// Descricao da Consicao de Pagamento
xPARC_DUP  		:={}               		    // Parcelas
xVENC_DUP  		:={}                   		// Vencimentos
xVALOR_DUP 		:={}                  		// Valores     
xIMPRIMIR       :={}

//Rodape da Nota Fiscal
xVALOR_MERC 	:= 0         				// Valor  da Mercadoria (Acumular no total dos Itens "Produtos")
xVALOR_SERV 	:= 0         				// Valor  da Mercadoria (Acumular no total dos Itens "Servicos")
xBASE_IPI   	:= 0         				// Base   do IPI
xVALOR_IPI  	:= 0         				// Valor  do IPI
xBASE_ICMS  	:= 0         				// Base   do ICMS
xVALOR_ICMS 	:= 0         				// Valor  do ICMS
xBSICMRET   	:= 0         				// Base do ICMS Retido
xICMS_RET   	:= 0         				// Valor  do ICMS Retido
xFRETE      	:= 0         				// Frete
xSEGURO     	:= 0         				// Seguro
xDESPESA    	:= 0         				// Despesas Acessorias da Nota Fiscal
xTOT_FAT    	:= 0         				// Valor Bruto da Fatura
XALIQISS		:=5							// Aliquota de ISS
XBASEISS		:=0 						// Base do ISS
XTOT_ISS		:=0							// Total do ISS
// Transportadora
xNOME_TRANSP 	:=" "           			// Nome Transportadora
xEND_TRANSP  	:=" "            			// Endereco
xMUN_TRANSP  	:=" "            			// Municipio
xEST_TRANSP  	:=" "            			// Estado
xVIA_TRANSP  	:=" "            			// Via de Transporte
xCGC_TRANSP  	:=" "            			// CGC
xTEL_TRANSP  	:=" "            			// Fone
xTPFRETE     	:=" "           			// Tipo de Frete
xVOLUME      	:= 0            			// Volume
xESPECIE     	:=" "           			// Especie
xPBRUTO      	:= 0            			// Peso Bruto
xPLIQUI 	   	:= 0			    		// Peso Liquido
xCOD_MENS    	:=" "           			// Codigo da Mensagem
xMENSAGEM    	:=" "           			// Mensagem da Nota    
xCLFISCAL       :={}
XDESC_NOTA      := 0                        // Valor Desconto na Nota
// Volumes
xESPECIE 		:=" "        				// Especie 1 no Pedido
xVOLUME  		:=" "        				// Volume 1 no Pedido

xPBRUTO  		:=0 			         	// Peso Bruto
xNFORI   		:=" "


// Observacoes:
_aObsTes 		:={}


// Pedidos de Venda
xITEM_PED		:={}                         	// Numero do Item do Pedido de Venda
xCOD_VEND		:={}							// Codigo Vendedor
xVENDEDOR		:={}							// Nome do Vendedor
xPED  			:={}

// Nota Fiscais de Origem
xNUM_NFDV		:={}                         	// nUMERO QUANDO HOUVER DEVOLUCAO
XPROP_NFDV		:={}							// Tipo de Formulario (Proprio ou nao)
xEMIS_DV 		:={}                         	// Serie  quando houver devolucao
xPREF_DV 		:={}                         	// Serie  quando houver devolucao

// Itens da Nota Fiscal/Pedido
xICMS    		:={}                         	// Porcentagem do ICMS
xCOD_PRO 		:={}                         	// Codigo  do Produto
XTIPO_PRO		:=Array(0)						// Tipo do produto
xQTD_PRO 		:={}                         	// Peso/Quantidade do Produto
xPRE_UNI 		:={}                         	// Preco Unitario de Venda
xPRE_TAB 		:={}                         	// Preco Unitario de Tabela
xIPI     		:={}                         	// Porcentagem do IPI
xVAL_IPI 		:={}                         	// Valor do IPI
xDESC    		:={}                         	// Desconto por Item
xVAL_DESC		:={}                         	// Valor do Desconto
xVAL_MERC		:={}                         	// Valor da Mercadoria
xTES     		:={}                         	// TES
xCF      		:={}                         	// Classificacao quanto natureza da Operacao
xCF2     		:={}                         	// Classificacao quanto natureza da Operacao
xICMSOL  		:={}                         	// Base do ICMS Solidario
xICM_PROD		:={}                        	// ICMS do Produto
xPESO_PRO		:={}                       		// Peso Liquido
xUNID_PRO		:={}                        	// Unidade do Produto
xDESC_PRO		:={}							// Descricao do Produto no pedido.
xMEN_POS 		:={}                        	// Mensagem da Posicao IPI
xDESCR   		:={}                         	// Descricao do Produto
xCOD_TRIB		:={}                           	// Codigo de Tributacao
//XNUNSERIE		:=Array(0)						// Numero de Serie
XNUNSERIE		:={}							// Numero de Serie
xMEN_TRIB		:={}                           	// Mensagens de Tributacao
xCOD_FIS 		:={}                           	// Cogigo Fiscal
XCLAS_FIS		:={}                           	// Classificacao Fiscal
xISS     		:={}                           	// Aliquota de ISS
xLUCRO   		:={}                           	// Margem de Lucro p/ ICMS Solidario
xCLFISCAL		:={}							//
xPED_CLI 		:={}                          	// Numero de Pedido do cliente
XPEDIDO			:=Array(0)						// Pedido de venda na saida ou pedido de compra na entrada

Return()
