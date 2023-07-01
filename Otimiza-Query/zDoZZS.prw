#Include "Protheus.ch"
#Include "totvs.ch"

/*/{Protheus.doc} zDoZZS
	Aplicação U_zDoZZS()
/*/
User Function zDoZZS()
	Local aArea := GetArea()
	Local aSX2 := {} 
	Local aSX3 := {}
	Local aSIX := {}
	Local cX3  := ""
	
	//Tabela
	//			01			02						03		04			05			06 
	//			Chave		Descrição				Modo	Modo Un.	Modo Emp.	X2_UNICO
	aSX2 := {	'ZZS',		'Consultas SQL',		'C',	'C',		'C',		''}
	
	//Campos
	//			01	    	    02			03				04			05		06					07								08			09		10			11		12			13		 14		15			16		17			18			19		20			21
	//			Campo		    Filial?	    Tamanho			Decimais	Tipo	Titulo				Descrição						Máscara		Nível	Vld.Usr	    Usado	Ini.Padr.	Cons.F3	 Visual	Contexto	Browse	Obrigat	    Lista.Op	Mod.Edi Ini.Brow	Pasta
	aAdd(aSX3,{	'ZZS_FILIAL',   .T.,        FWSizeFilial(), 0,          'C',    "Filial      ",     "Filial do Sistema        ",    "",         1,      "",         .F.,    "",         "",      "",     "",         "N",    .T.,        "",         "",     "",         ""})
	aAdd(aSX3,{	'ZZS_CODE',     .F.,        08,             0,          'C',    "Codigo      ",     "Codigo da Sentenca       ",    "@!",	    1,      "",			.T.,	"",		    "",		 "A",	"R",		"S",    .T.,        "",         "",     "",         ""})
	aAdd(aSX3,{	'ZZS_TBMAIN',   .F.,        03,             0,          'C',    "Tabela Princ",     "Tabela Principal         ",    "@!",       1,      "",         .T.,    "",         "",      "A",    "R",        "S",    .T.,        "",         "",     "",         ""})
    aAdd(aSX3,{	'ZZS_SETOR',    .F.,        20,             0,          'C',    "Setor       ",     "Setor da Empresa         ",    "@!",       1,      "",         .T.,    "",         "",      "A",    "R",        "S",    .F.,        "",         "",     "",         ""})
    aAdd(aSX3,{	'ZZS_DTCRIA',   .F.,        08,             0,          'D',    "Data Criacao",     "Data da Criacao          ",    "",         1,      "",         .T.,    "DATE()",   "",      "A",    "R",        "S",    .T.,        "",         "",     "",         ""})
    aAdd(aSX3,{	'ZZS_DTATUA',   .F.,        08,             0,          'D',    "Data Atualiz",     "Data da Atualizacao      ",    "",         1,      "",         .T.,    "",         "",      "A",    "R",        "S",    .F.,        "",         "",     "",         ""})
    aAdd(aSX3,{	'ZZS_COMENT',   .F.,        200,            0,          'C',    "Comentario  ",     "Comentario               ",    "@!",       1,      "",         .T.,    "",         "",      "A",    "R",        "S",    .F.,        "",         "",     "",         ""})
    aAdd(aSX3,{	'ZZS_QUERY',    .F.,        10,             0,          'M',    "Query       ",     "Query - Sentenca SQL     ",    "",         1,      "",         .T.,    "",         "",      "A",    "R",        "N",    .T.,        "",         "",     "",         ""})
    aAdd(aSX3,{	'ZZS_ORDER',    .F.,        10,             0,          'M',    "Group Order ",     "Group by - Order by      ",    "",         1,      "",         .T.,    "",         "",      "A",    "R",        "N",    .F.,        "",         "",     "",         ""})
    aAdd(aSX3,{	'ZZS_CNDCAO',   .F.,        10,             0,          'M',    "Condicao    ",     "Condicao - Where         ",    "",         1,      "",         .T.,    "",         "",      "A",    "R",        "N",    .F.,        "",         "",     "",         ""})
    aAdd(aSX3,{	'ZZS_CPESQ',    .F.,        30,             0,          'C',    "Cpo Pesquisa",     "Campo de Pesquisa        ",    "@!",       1,      "",         .T.,    "",         "",      "A",    "R",        "N",    .F.,        "",         "",     "",         ""})
	
	//Índices
	//			01			02		03						            04				05				06			07
	//			Índice		Ordem	Chave					            Descrição		Propriedade	    NickName	Mostr.Pesq
	aAdd(aSIX,{	"ZZS",		"1",	"ZZS_FILIAL+ZZS_CODE",	            "Codigo",		"U",			"ZZSSQL",	"S"})
		
	//Criando os dados
	u_zDoDB(aSX2, aSX3, aSIX)

	DbSelectArea("SX3")
	SX3->(DbSetOrder(1)) //X3_ARQUIVO
	SX3->(DbGoTop())
	SX3->(DbSeek('ZZS'))

	cX3 := "Tabela ZZS " + Chr(13)+Chr(10)+Chr(13)+Chr(10)

	While !SX3->(EoF())  .AND. SX3->X3_ARQUIVO == 'ZZS'
		   cX3 += SX3->X3_CAMPO
		   cX3 += Chr(13) + Chr(10) 

		SX3->(DbSkip() )
	EndDo

	MSGINFO( cX3, ':: Campos criados ::' )
	
	RestArea(aArea)
Return
