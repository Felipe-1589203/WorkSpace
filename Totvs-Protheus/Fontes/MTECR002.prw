#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"   
#INCLUDE "TOPCONN.CH"    
            
#define DMPAPER_LETTER      1  // Letter 8 1/2 x 11 in
#define DMPAPER_LETTERSMALL 2   // Letter Small 8 1/2 x 11 in
#define DMPAPER_TABLOID     3 // Tabloid 11 x 17 in
#define DMPAPER_LEDGER      4 // Ledger 17 x 11 in                                          
#define DMPAPER_LEGAL       5 // Legal 8 1/2 x 14 in
#define DMPAPER_EXECUTIVE   7 // Executive 7 1/4 x 10 1/2 in                                                	
#define DMPAPER_A3    		8 // A3 297 x 420 mm
#define DMPAPER_A4    		9 // A4 210 x 297 mm
#define DMPAPER_A4SMALL     10 // A4 Small 210 x 297 mm
#define DMPAPER_A5    		11 // A5 148 x 210 mm
#define DMPAPER_B4   	    12 // B4 250 x 354
#define DMPAPER_B5    		13 // B5 182 x 257 mm
#define DMPAPER_FOLIO   	14 // Folio 8 1/2 x 13 in
#define DMPAPER_NOTE   		18 // Note 8 1/2 x 11 in
#define DMPAPER_ENV_10   	20 // Envelope #10 4 1/8 x 9 1/2   

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MTECR001  ºAutor  ³Bruno S. Parreira   º Data ³  10/05/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Impressão do formulário de atendimento da assistência       º±±
±±º          ³técnica.                                                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³Específico p/ clientes Actual Trend - www.actualtrend.com.brº±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function MTECR002()
	Local clDesc1 	:= "Este relatório tem o objetivo de imprimir o"
	Local clDesc2 	:= " formulário de atendimento da assistência técnica."
	Local clDesc3 	:= ''
	Local clString	:= "AB6"     

	Private cpTamanho	:= "G"

	Private cpTitulo  := "Assistência Técnica"
	Private cpTitCont := "Formulário de Atendimento"
	         
	Private cpProgram := "MTECR002"

	Private aOrd      := {}

	Private opFont08  := TFont():New( "Tahoma",,08,,.F.,,,,,.F.) 
	Private opFont08n := TFont():New( "Tahoma",,09,,.T.,,,,,.F.)
	Private opFont10  := TFont():New( "Tahoma",,10,,.F.,,,,,.F.)
	Private opFont10n := TFont():New( "Tahoma",,10,,.T.,,,,,.F.)	
	Private opFont12  := TFont():New( "Tahoma",,12,,.F.,,,,,.F.) 
	Private opFont12n := TFont():New( "Tahoma",,12,,.T.,,,,,.F.)
	Private opFont14n := TFont():New( "Tahoma",,14,,.T.,,,,,.F.) 
	Private opFont14  := TFont():New( "Tahoma",,14,,.F.,,,,,.F.)
	Private opFont15  := TFont():New( "Tahoma",,15,,.F.,,,,,.F.)
	Private opFont17n := TFont():New( "Tahoma",,17,,.T.,,,,,.F.)     
		
	Private aReturn := {"Zebrado",1,"Administracao", 2, 2, 1, "",0 }   

	Private li		:= 80, limite:=132, lRodape:=.F.           

	Private nLin 	 := 100
	Private	nfim     := 2300 //2360 //2470    
	Private nCol 	 := 80
	Private nPula 	 := 100
	Private nPulaF   := 40
	Private	aCols    := {50, 150, 250, 500, 750, 1500}
	Private aColTit  := {750,800}
	//Private a_nvcod  := {0,10,20,30,40,60,70}
	//Private a_nvdesc := {0,30,60,90,120,150,180}
	Private aColTit  := {30,220,630,1215,1540,1880,2100}
	Private n_cont   := 0
	
	Private cpPerg    := "MTECR002"    
	
	Private VerifRes := "N"
	
	Private oprn := TMSPrinter():New(cpTitulo)    
	nCor:=RGB(205,205,205)
	oBrush := TBrush():New("",nCor)
	
	
	cpPerg := PADR(cpPerg,10)
	
	AjustSX1(cpPerg)         
	
	pergunte(cpPerg,.F.)
	
	wnrel:=SetPrint(clString,cpProgram,cpPerg,@cpTitulo,clDesc1,clDesc2,clDesc3,.F.,aOrd,.F.,cpTamanho) 
	
	If nLastKey == 27
 		Return
 	Endif
	
  	oprn:SetPortrait()
  	oprn:setPaperSize(DMPAPER_A4)
	
	SetDefault(aReturn,clString)
	
//	if !oprn:Setup()
//		Return	
//	EndIf
	
	Processa({||ImpRel()}, cpTitulo, "Gerando Relatório, aguarde...")  
	
	If VerifRes = "S"
		Return
	EndIf
	 
	If ( aReturn[5] == 1 ) //1-Disco, 2-Impressora
		oPrn:Preview()
	Else           
		oPrn:Print() 
		MS_FLUSH()
	EndIf
	
Return	 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Função para ajustar o SX1. PERGUNTAS.                                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 

Static function AjustSX1(clPerg)

	Local aAreaAtu	:= GetArea()
	Local aAreaSX1	:= SX1->(GetArea())
	Local aHelp		:= {}                             
	Local clTamSX1	:= Len(SX1->X1_GRUPO)
	Local clPesPerg	:= ""    
                                       
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define os títulos e Help das perguntas                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	aAdd(aHelp,{{"O.S. Inicial"},{""},{""}})
	aAdd(aHelp,{{"O.S. Final"},{""},{""}})  

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Grava as perguntas no arquivo SX1                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
                                                                     
	PutSx1(clPerg,"01","De O.S...?" ,"" ,"" ,"mv_ch1","C" 	,6,0,,"G","","AB6"	,"","","mv_par01" ,"","","","","","","","","","","","","","","","",aHelp[01,1],aHelp[01,2],aHelp[01,3],"")
	PutSx1(clPerg,"02","Até O.S..?", "",""  ,"mv_ch2","C" 	,6,0,,"G","","AB6"	,"","","mv_par02" ,"","","","","","","","","","","","","","","","",aHelp[02,1],aHelp[02,2],aHelp[02,3],"")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Salva as áreas originais                                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ    

	RestArea( aAreaSX1 )
	RestArea( aAreaAtu )
                                                                                                                                                                                                                                                                                                                                                                                                          
Return( Nil )    

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressão do relatório                                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ    

Static Function ImpRel()   
  
	EstForm()
	
	ContForm()    
					
Return        

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Query                                                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ    

Static Function RPMSQL()
Local clAliasSql := GetNextAlias()

	BeginSql Alias clAliasSql    
	    
		select * from %Table:AB6% AB6
		inner join %Table:AB7% AB7 
		on AB6.AB6_FILIAL = AB7.AB7_FILIAL
		AND AB6.AB6_NUMOS = AB7.AB7_NUMOS
		where AB6.AB6_NUMOS >= %EXP:MV_PAR01% 
		AND AB6.AB6_NUMOS <= %EXP:MV_PAR02% 
		AND AB6.AB6_FILIAL = %xFilial:AB6%
		AND AB7.AB7_FILIAL = %xFilial:AB7%
		AND AB6.%NotDel%
		AND AB7.%NotDel%
		Order by AB6.AB6_NUMOS
	    /*
	    select * from %Table:AB6% AB6
		where AB6_FILIAL=%xFilial:AF6% AND %NotDel% 
		AND AB6_NUMOS>=%EXP:MV_PAR01% AND AB6_NUMOS<=%EXP:MV_PAR02%
		order by AB6_NUMOS
		*/
	EndSql 
	
Return(clAliasSql)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Estrutura do formulario                                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ   

Static Function EstForm()  

	Local aArea := GetArea()
	Local clTxt := ""

	oPrn:EndPage()

	If Li > 55
	    //Começo Cabeçalho
		oPrn:Say(nLin	,930,cpTitulo ,opFont14n,100)
		oPrn:Say(nLin+50,850,cpTitCont,opFont14n,100)
	
		oPrn:Box(50,nCol,250,nfim)
		oPrn:Box(50,nCol,250,500) 
		oPrn:SayBitmap(110,nCol+25,"Lgrl"+cFilAnt+".bmp",360,88,,)
		oPrn:Box(50,nCol,250,nfim-500)
		oPrn:Box(150,nfim-500,250,nfim)
	
		oPrn:Say(050,1815,"Nº de O.S.:",opFont08n,100)
		oPrn:Say(150,1815,"Data:"      ,opFont08n,100)
	    //Fim Cabeçalho
		nLin := 270
        //Começo Primeiro Bloco         
        oPrn:FillRect({nLin,nCol,nLin+40,nfim}, oBrush)
		oPrn:Box(nLin,nCol,nLin+40,nfim)
		oPrn:Say(nLin,nCol+20,"Dados Cadastrais do Cliente", opFont10n,100) 
		
		nLin += nPulaF
		
		oPrn:Box(nLin,nCol,nLin+300,nfim) 
		
		oPrn:Box(nLin,nCol,nLin+100,1.8*(nfim-(50))/10)
        oPrn:Say(nLin,nCol+20,"Código:", opFont08n,100) 
        oPrn:Box(nLin,nCol,nLin+100,4*(nfim-(50))/10)
        oPrn:Say(nLin,(1.8*(nfim-(50))/10)+20,"Loja:", opFont08n,100)
        oPrn:Box(nLin,nCol,nLin+100,nfim)
        oPrn:Say(nLin,(4*(nfim-(50))/10)+20,"Nome:", opFont08n,100)
        
        nLin += nPula
        
        oPrn:Box(nLin,nCol,nLin+100,7*(nfim-(50))/10)
		oPrn:Say(nLin,nCol+20,"Endereço:", opFont08n,100)
		oPrn:Box(nLin,nCol,nLin+100,nfim)                          
		oPrn:Say(nLin,(7*(nfim-(50))/10)+20,"Município:", opFont08n,100)
	    
	    nLin += nPula
	    
	    oPrn:Box(nLin,nCol,nLin+100,3.5*(nfim-(50))/10)
	    oPrn:Say(nLin,nCol+20,"Bairro:", opFont08n,100)
	    oPrn:Box(nLin,nCol,nLin+100,7*(nfim-(50))/10)  
	    oPrn:Say(nLin,(3.5*(nfim-(50))/10)+20,"Contato:", opFont08n,100)
		oPrn:Box(nLin,nCol,nLin+100,nfim)
		oPrn:Say(nLin,(7*(nfim-(50))/10)+20,"Fone:", opFont08n,100)  
		//Fim Primeiro Bloco
		
		nLin += nPula
		nLin += 20
		
		//Começo Segundo Bloco
		oPrn:FillRect({nLin,nCol,nLin+40,nfim}, oBrush)
		oPrn:Box(nLin,nCol,nLin+40,nfim)
		oPrn:Say(nLin,nCol+20,"Dados de Endereço do Atendimento", opFont10n,100) 
		
		nLin += nPulaF
		
		oPrn:Box(nLin,nCol,nLin+400,nfim)
		
		oPrn:Box(nLin,nCol,nLin+100,nfim)
	    oPrn:Say(nLin,nCol+20,"Endereço de Atendimento:", opFont08n,100) 
	    
	    nLin += nPula
	    
	    oPrn:Box(nLin,nCol,nLin+100,3.5*(nfim-(50))/10)
	    oPrn:Say(nLin,nCol+20,"Cidade:", opFont08n,100)
	    oPrn:Box(nLin,nCol,nLin+100,7*(nfim-(50))/10)  
	    oPrn:Say(nLin,(3.5*(nfim-(50))/10)+20,"Estado:", opFont08n,100)
		oPrn:Box(nLin,nCol,nLin+100,nfim)
		oPrn:Say(nLin,(7*(nfim-(50))/10)+20,"Bairro:", opFont08n,100)  
	    
	    nLin += nPula
	    
	    oPrn:Box(nLin,nCol,nLin+100,nfim)
	    oPrn:Say(nLin,nCol+20,"Ponto de Referência:", opFont08n,100)
	    
	    nLin += nPula
	    
	    oPrn:Box(nLin,nCol,nLin+100,5*(nfim-(50))/10)
	    oPrn:Say(nLin,nCol+20,"Data Agendada:", opFont08n,100) 
	    oPrn:Box(nLin,nCol,nLin+100,nfim)
	    oPrn:Say(nLin,(5*(nfim-(50))/10)+20,"Técnico Agendado:", opFont08n,100) 
	    //Fim Segundo Bloco                                                       
	    
	    nLin += nPula
		nLin += 20
		
		//Começo Terceiro Bloco
		oPrn:FillRect({nLin,nCol,nLin+40,nfim}, oBrush)
		oPrn:Box(nLin,nCol,nLin+40,nfim)
		oPrn:Say(nLin,nCol+20,"Dados do Produto", opFont10n,100) 
		
		nLin += nPulaF
		
		oPrn:Box(nLin,nCol,nLin+300,nfim) 
		
		oPrn:Box(nLin,nCol,nLin+100,7*(nfim-(50))/10)
        oPrn:Say(nLin,nCol+20,"Descrição:", opFont08n,100)
        oPrn:Box(nLin,nCol,nLin+100,nfim) 
        oPrn:Say(nLin,(7*(nfim-(50))/10)+20,"Código:", opFont08n,100)
        
        nLin += nPula
        
        oPrn:Box(nLin,nCol,nLin+100,7*(nfim-(50))/10)
        oPrn:Say(nLin,nCol+20,"Data de Compra:", opFont08n,100)
        oPrn:Box(nLin,nCol,nLin+100,nfim) 
        oPrn:Say(nLin,(7*(nfim-(50))/10)+20,"Pedido nº:", opFont08n,100)
        
	    nLin += nPula
	    
	    oPrn:Box(nLin,nCol,nLin+100,nfim)
	    oPrn:Say(nLin+35,nCol+20,"Produto em Garantia:", opFont10n,100)
	    
	    oPrn:Box(nLin+35,nCol+500,nLin+65,nCol+530)
		oPrn:Say(nLin+35,nCol+550,"Sim", opFont10n,100)
		oPrn:Box(nLin+35,nCol+800,nLin+65,nCol+830)
		oPrn:Say(nLin+35,nCol+850,"Não", opFont10n,100)
		//Fim Terceiro Bloco                             
		
		nLin += nPula
		nLin += 20
		
		//Começo Quarto Bloco
		oPrn:FillRect({nLin,nCol,nLin+40,nfim}, oBrush)                  
		oPrn:Box(nLin,nCol,nLin+40,nfim)
		oPrn:Say(nLin,nCol+20,"Dados do Atendimento", opFont10n,100) 
		
		nLin += nPulaF
		
		oPrn:Box(nLin,nCol,nLin+1740,nfim)
		
		oPrn:Box(nLin,nCol,nLin+200,9*(nfim-(50))/10)
        oPrn:Say(nLin,nCol+20,"Serviço solicitado pelo cliente:", opFont08n,100)
        oPrn:Box(nLin,nCol,nLin+200,nfim) 
        oPrn:Say(nLin,(9*(nfim-(50))/10)+20,"Ocorrência:", opFont08n,100)
		
		nLin += nPula
		nLin += nPula
		
		oPrn:Box(nLin,nCol,nLin+200,nfim) 
        oPrn:Say(nLin,nCol+20,"Problema detectado pelo técnico:", opFont08n,100)
        
        nLin += nPula
        nLin += nPula
        
        oPrn:Box(nLin,nCol,nLin+200,nfim) 
        oPrn:Say(nLin,nCol+20,"Serviço Executado:", opFont08n,100)
        
		nLin += nPula
        nLin += nPula
        
        oPrn:Box(nLin,nCol,nLin+100,nfim)
	    oPrn:Say(nLin+35,nCol+20,"Há necessidade de troca de peças:", opFont10n,100)
		
		oPrn:Box(nLin+35,nCol+700,nLin+65,nCol+730)
		oPrn:Say(nLin+35,nCol+750,"Sim, relacionar peças abaixo", opFont10n,100)
		oPrn:Box(nLin+35,nCol+1300,nLin+65,nCol+1330)
		oPrn:Say(nLin+35,nCol+1350,"Não", opFont10n,100)
		
		nLin += nPula
		
		oPrn:FillRect({nLin,nCol,nLin+40,nfim}, oBrush)   
		oPrn:Box(nLin,nCol,nLin+40,nfim)
		oPrn:Say(nLin,nCol+115,"Código:", opFont10n,100)
		oPrn:Box(nLin,nCol,nLin+40,2*(nfim-(50))/10)
		oPrn:Say(nLin,nCol+950,"Descrição:", opFont10n,100) 
		oPrn:Box(nLin,nCol,nLin+40,8*(nfim-(50))/10)
		oPrn:Say(nLin,nCol+1900,"Custo:", opFont10n,100) 
		
		nLin += nPulaF
		
		oPrn:Box(nLin,nCol,nLin+300,nfim)
		oPrn:Box(nLin,nCol,nLin+300,2*(nfim-(50))/10) 
		oPrn:Box(nLin,nCol,nLin+300,8*(nfim-(50))/10) 
		
		nLin += nPula
		nLin += nPula
		nLin += nPula
		
		oPrn:Box(nLin,nCol,nLin+100,nfim)
	    oPrn:Say(nLin+35,nCol+20,"Cliente de Acordo:", opFont10n,100)
	    
	    oPrn:Box(nLin+35,nCol+400,nLin+65,nCol+430)
		oPrn:Say(nLin+35,nCol+450,"Sim", opFont10n,100)
		oPrn:Box(nLin+35,nCol+700,nLin+65,nCol+730)
		oPrn:Say(nLin+35,nCol+750,"Não", opFont10n,100)
		
		nLin += nPula     
		
		oPrn:Box(nLin,nCol,nLin+100,nfim)
		oPrn:Box(nLin,nCol,nLin+100,5*(nfim-(50))/10)
	    oPrn:Say(nLin+35,nCol+20,"Serviço Finalizado:", opFont10n,100)
	    
	    oPrn:Box(nLin+35,nCol+400,nLin+65,nCol+430)
		oPrn:Say(nLin+35,nCol+450,"Sim", opFont10n,100)
		oPrn:Box(nLin+35,nCol+700,nLin+65,nCol+730)
		oPrn:Say(nLin+35,nCol+750,"Não", opFont10n,100)
		
		oPrn:Say(nLin+35,(5*(nfim-(50))/10)+20,"Necessário Retorno:", opFont10n,100)
	    
	    oPrn:Box(nLin+35,(5*(nfim-(50))/10)+400,nLin+65,(5*(nfim-(50))/10)+430)
		oPrn:Say(nLin+35,(5*(nfim-(50))/10)+450,"Sim", opFont10n,100)
		oPrn:Box(nLin+35,(5*(nfim-(50))/10)+700,nLin+65,(5*(nfim-(50))/10)+730)
		oPrn:Say(nLin+35,(5*(nfim-(50))/10)+750,"Não", opFont10n,100)
		
		nLin += nPula 
		
		oPrn:Box(nLin,nCol,nLin+100,nfim) 
		
		oPrn:Box(nLin,nCol,nLin+100,2.5*(nfim-(50))/10)
        oPrn:Say(nLin,nCol+20,"Hora de Início:", opFont08n,100) 
        oPrn:Box(nLin,nCol,nLin+100,5*(nfim-(50))/10)
        oPrn:Say(nLin,(2.5*(nfim-(50))/10)+20,"Hora Fim:", opFont08n,100)
        oPrn:Box(nLin,nCol,nLin+100,nfim)
        oPrn:Say(nLin,(5*(nfim-(50))/10)+20,"Técnico:", opFont08n,100)    
        
        nLin += nPula
        
        oPrn:Box(nLin,nCol,nLin+200,nfim) 
        oPrn:Say(nLin,nCol+20,"Observação:", opFont08n,100)
        
		nLin += nPula
        nLin += nPula   
        
        oPrn:Box(nLin,nCol,nLin+100,nfim) 
        oPrn:Say(nLin,nCol+20,"Nome Responsável Pelo Acompanhamento do Atendimento:", opFont08n,100)
        
        nLin += nPula
	    
	    oPrn:Box(nLin,nCol,nLin+100,5*(nfim-(50))/10)
	    oPrn:Say(nLin,nCol+20,"Assinatura:", opFont08n,100) 
	    oPrn:Box(nLin,nCol,nLin+100,nfim)
	    oPrn:Say(nLin,(5*(nfim-(50))/10)+20,"Data:", opFont08n,100)  
		
		//Fim Quarto Bloco
	
	Endif

	RestArea(aArea)
	
Return     

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Estrutura do formulario                                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ   

Static Function ContForm()
    Local clNomCli 	:= ""
    Local clLojCli  := ""
    Local clEndCli	:= ""  
    Local clMunCli 	:= ""
    Local clBrrCli	:= ""
    Local clCttCli	:= ""
    Local clFonCli  := ""
    
    Local clEndAtd  := ""
	Local clCidAtd  := ""
	Local clEstAtd  := ""
	Local clBrrAtd  := ""
	Local clPtrAtd  := ""
	Local clDtaAtd  := ""
	Local clTecAtd  := ""  
	
	Local clDscPro  := ""
	Local clCodPro  := ""
	Local clDtaPro  := ""
	Local clPedPro  := ""
	Local clGarPro  := ""   
	
	Local clSvcAtd  := ""
	Local clPblAtd  := ""
	Local clExeAtd  := ""
	Local clTroAtd  := ""
	
	Local clCdAtd1  := ""
	Local clCdAtd2  := ""
	Local clCdAtd3  := ""
	Local clCdAtd4  := ""
	Local clCdAtd5  := ""
	Local clDsAtd1  := ""
	Local clDsAtd2  := ""
	Local clDsAtd3  := ""
	Local clDsAtd4  := ""
	Local clDsAtd5  := ""
	Local clCtAtd1  := ""
	Local clCtAtd2  := ""
	Local clCtAtd3  := ""  
	Local clCtAtd4  := ""
	Local clCtAtd5  := ""
    
	clAliasOS := RPMSQL()
	
	DbSelectArea(clAliasOS)
	(clAliasOS)->(DbGoTop()) 
	
   	if (clAliasOS)->(!EOF())
		while (clAliasOS)->(!EOF())
		
			//Dados Cadastrais do Cliente
			oPrn:Say(80, 1900,(clAliasOS)->AB6_NUMOS, opFont14, 100)   //No. da OS
			oPrn:Say(180, 1900,DtoC(stod((clAliasOS)->AB6_EMISSA)), opFont14, 100) //Data  	
		 
		    clNomCli := Posicione("SA1",1,xFilial("SA1")+AB6_CODCLI,"A1_NOME")
		    clLojCli := Posicione("SA1",1,xFilial("SA1")+AB6_CODCLI,"A1_LOJA")      
		    clEndCli := Posicione("SA1",1,xFilial("SA1")+AB6_CODCLI,"A1_END")
		    clMunCli := Posicione("SA1",1,xFilial("SA1")+AB6_CODCLI,"A1_MUN")  
		    clBrrCli := Posicione("SA1",1,xFilial("SA1")+AB6_CODCLI,"A1_BAIRRO")   
		    clCttCli := Posicione("SA1",1,xFilial("SA1")+AB6_CODCLI,"A1_CONTATO")   
		    clFonCli := Posicione("SA1",1,xFilial("SA1")+AB6_CODCLI,"A1_DDD")+" "+Posicione("SA1",1,xFilial("SA1")+AB6_CODCLI,"A1_TEL")       
		    
		    oPrn:Say(340,nCol+30,(clAliasOS)->AB6_CODCLI, opFont14, 100) //Codigo
		    oPrn:Say(340,(1.8*(nfim-(50))/10)+30,clLojCli, opFont14, 100) //Loja
		    oPrn:Say(340,(4*(nfim-(50))/10)+30,clNomCli, opFont14, 100) //Nome
		    
		    oPrn:Say(440,nCol+30,clEndCli, opFont14, 100) //Endereco
		    oPrn:Say(440,(7*(nfim-(50))/10)+30,clMunCli, opFont14, 100) //Municipio
		    
		    oPrn:Say(540,nCol+30,clBrrCli, opFont14, 100) //Bairro
		    oPrn:Say(540,(3.5*(nfim-(50))/10)+30,clCttCli, opFont14, 100) //Contato
		    oPrn:Say(540,(7*(nfim-(50))/10)+30,clFonCli, opFont14, 100) //Fone
		    //Fim Primeiro Bloco
		    
		    //Dados do Atendimento
	  	    clEndAtd := AB6->AB6_XENDER 	//Posicione("SA1",1,xFilial("SA1")+AB6_CODCLI,"A1_END")
	  	    clCidAtd := AB6->AB6_XCIDAD 	//Posicione("SA1",1,xFilial("SA1")+AB6_CODCLI,"A1_MUN")  
	  	    clEstAtd := AB6->AB6_XBAIRR 	//Posicione("SA1",1,xFilial("SA1")+AB6_CODCLI,"A1_ESTADO")  
	  	    clBrrAtd := AB6->AB6_XEST   	//Posicione("SA1",1,xFilial("SA1")+AB6_CODCLI,"A1_BAIRRO")  
	  	    clPtrAtd := AB6->AB6_XPREFE 	//"Complemento"  

			// dados da agenda do tecnico

	  	    clDtaAtd := "" //DtoC(stod((claliasOS)->AB8_ENTREG))  
	  	    clTecAtd := "" //"Zé da Silva"  
	  	    
	  	    
	  	    oPrn:Say(700,nCol+30,clEndAtd, opFont14, 100) //Endereço de Atendimento
		    
		    oPrn:Say(800,nCol+30,clCidAtd, opFont14, 100) //Cidade
		    oPrn:Say(800,(3.5*(nfim-(50))/10)+30,clEstAtd, opFont14, 100) //Estado
		    oPrn:Say(800,(7*(nfim-(50))/10)+30,clBrrAtd, opFont14, 100) //Bairro
		    
		    oPrn:Say(900,nCol+30,clPtrAtd, opFont14, 100) //Ponto de referência
		    
		    oPrn:Say(1000,nCol+30,clDtaAtd, opFont14, 100) //Data Agendada
		    oPrn:Say(1000,(5*(nfim-(50))/10)+30,cltecAtd, opFont14, 100) //Técnico Agendado 
		    //Fim Segundo Bloco    
		    
		    //Dados do Produto  
		    
		    clCodPro := AB7->AB7 //"PS9879-A"
		    clDscPro := "Descrição do Produto"
//		    clDtaPro := //"10/10/2010"
//		    clPedPro := //"00987"
		    clGarPro := "N"
		    
		    oPrn:Say(1160,nCol+30,clDscPro, opFont14, 100) //Descricao
		    oPrn:Say(1160,(7*(nfim-(50))/10)+30,clCodPro, opFont14, 100) //Código
		    
		    oPrn:Say(1260,nCol+30,clDtaPro, opFont14, 100) //Data da Compra
		    oPrn:Say(1260,(7*(nfim-(50))/10)+30,clPedPro, opFont14, 100) //Pedido No.
		    
		    If clGarPro = "S"                                //Produto em Garantia
//		    	oPrn:Say(1360,nCol+505,"X", opFont10n, 100) //Sim 
		    	oPrn:Say(1360,nCol+505," ", opFont10n, 100) //Sim 
		    Else
		    	oPrn:Say(1360,nCol+805," ", opFont10n, 100) //Nao		
//		    	oPrn:Say(1360,nCol+805,"X", opFont10n, 100) //Nao		
		    EndIf
		    //Fim Terceiro Bloco    
		    
		    //Começo Quarto Bloco
		    clSvAtd1 := "Cliente solicita que seja trocado uma peça do produto"
		    clSvAtd2 := "que está com defeito." 
		    clSvAtd3 := "que está com defeito."
		    clOcAtd1 := "001" 
		    clOcAtd2 := "002"   
		    clOcAtd3 := "002"
		    clPbAtd1 := "A peça que está com problema quebrou devido a"
		    clPbAtd2 := "má utilização do produto" 
		    clPbAtd3 := "má utilização do produto"
		    clExAtd1 := "A peça foi reparada no local e retirada para"
		    clExAtd2 := "analise na empresa" 
		    clExAtd3 := "analise na empresa"
		    clTroAtd := "S"
		    
//		    oPrn:Say(1520,nCol+30,clSvAtd1, opFont14, 100) //Serviço solicitado pelo cliente - 1a Linha 
//		    oPrn:Say(1570,nCol+30,clSvAtd2, opFont14, 100) //Serviço solicitado pelo cliente - 2a Linha  
//		    oPrn:Say(1620,nCol+30,clSvAtd3, opFont14, 100) //Serviço solicitado pelo cliente - 3a Linha
		   
//		    oPrn:Say(1520,(9*(nfim-(50))/10)+30,clOcAtd1, opFont14, 100) //Ocorrencia - 1a Linha
//		    oPrn:Say(1570,(9*(nfim-(50))/10)+30,clOcAtd2, opFont14, 100) //Ocorrencia - 2a Linha
//		    oPrn:Say(1620,(9*(nfim-(50))/10)+30,clOcAtd3, opFont14, 100) //Ocorrencia - 3a Linha
		    
//		    oPrn:Say(1720,nCol+30,clPbAtd1, opFont14, 100) //Problema detectado pelo técnico - 1a Linha 
//		    oPrn:Say(1770,nCol+30,clPbAtd2, opFont14, 100) //Problema detectado pelo técnico - 2a Linha
//		    oPrn:Say(1820,nCol+30,clPbAtd3, opFont14, 100) //Problema detectado pelo técnico - 3a Linha
		    
//		    oPrn:Say(1920,nCol+30,clExAtd1, opFont14, 100) //Servico Executado - 1a Linha 
//		    oPrn:Say(1970,nCol+30,clExAtd2, opFont14, 100) //Servico Executado - 2a Linha
//		    oPrn:Say(2020,nCol+30,clExAtd3, opFont14, 100) //Servico Executado - 3a Linha 
		    
		    If clTroAtd = "S"                                //Ha necessidade de troca de pecas
//		    	oPrn:Say(2120,nCol+705,"X", opFont10n, 100) //Sim, relacionar pecas abaixo 
		    	oPrn:Say(2120,nCol+705," ", opFont10n, 100) //Sim, relacionar pecas abaixo 
		    Else
		    	oPrn:Say(2120,nCol+1305," ", opFont10n, 100) //Nao		
//		    	oPrn:Say(2120,nCol+1305,"X", opFont10n, 100) //Nao		
		    EndIf 
		     
		    clCdAtd1 := "00001"
		    clCdAtd2 := "00002"
		    clCdAtd3 := "00003"
		    clCdAtd4 := "00004"
		    clCdAtd5 := "00005"
		    clDsAtd1 := "Descrição do primeiro produto"
		    clDsAtd2 := "Descrição do segundo produto"
		    clDsAtd3 := "Descrição do terceiro produto"
		    clDsAtd4 := "Descrição do quarto produto"
		    clDsAtd5 := "Descrição do quinto produto"
		    clCtAtd1 := "R$ 600,00"
		    clCtAtd2 := "R$ 1.100,00"
		    clCtAtd3 := "R$ 4.600,00" 
		    clCtAtd4 := "R$ 300,00"
		    clCtAtd5 := "R$ 23.567,00"
		    
/*
		    oPrn:Say(2260,nCol+30,clCdAtd1, opFont14, 100)	 
		    oPrn:Say(2310,nCol+30,clCdAtd2, opFont14, 100)
		    oPrn:Say(2360,nCol+30,clCdAtd3, opFont14, 100)
		    oPrn:Say(2410,nCol+30,clCdAtd4, opFont14, 100)
		    oPrn:Say(2460,nCol+30,clCdAtd5, opFont14, 100)	 
		    
		    oPrn:Say(2260,(2*(nfim-(50))/10)+30,clDsAtd1, opFont14, 100)	 
		    oPrn:Say(2310,(2*(nfim-(50))/10)+30,clDsAtd2, opFont14, 100)
		    oPrn:Say(2360,(2*(nfim-(50))/10)+30,clDsAtd3, opFont14, 100)
		    oPrn:Say(2410,(2*(nfim-(50))/10)+30,clDsAtd4, opFont14, 100)
		    oPrn:Say(2460,(2*(nfim-(50))/10)+30,clDsAtd5, opFont14, 100)	 
		    
		    oPrn:Say(2260,(8*(nfim-(50))/10)+30,clCtAtd1, opFont14, 100)	 
		    oPrn:Say(2310,(8*(nfim-(50))/10)+30,clCtAtd2, opFont14, 100)
		    oPrn:Say(2360,(8*(nfim-(50))/10)+30,clCtAtd3, opFont14, 100)
		    oPrn:Say(2410,(8*(nfim-(50))/10)+30,clCtAtd4, opFont14, 100)
		    oPrn:Say(2460,(8*(nfim-(50))/10)+30,clCtAtd5, opFont14, 100)	 
		   
		    //Fim Quarto Bloco   	
 */
			
   			(clAliasOS)->(DbSkip())

		EndDo
	Else
		ApMsgStop(OemToAnsi("Não existem dados para essa pesquisa!"),"Formulário de O.S.")	  
		VerifRes := "S"
	EndIf		        // 2260

Return
