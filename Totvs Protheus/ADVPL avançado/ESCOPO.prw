#INCLUDE 'Protheus.ch'

//Declaração de tipo de variaveis 

Static cTexto := "Estatica"

User Function ESCOPO()
	Local nNumero := 20
	Private dData := Date()

	FILHA()

	If nNumero >= 10.5
		Alert("Sim é maior, ou Igual")
	else
		Alert("Não, é menor")	
	endif	
Return 

nCount :=0 
nCount2 := 10

While nCount <= 10
	 
	 nNumero += 2
	 nChar   += 3
	 nRar    += 4
	nCount ++
	nCount2--
End	 

Static Function FILHA()
	Local   nNumero   := 20
	Private lContinua := .T.
	Public  aDados    := {1,3,7}

	cTexto := "Novamente"+Space(10)
	dData  := dData + nNumero
	dData+= nNumero

	If !lContinua 
		Alert("É falsa")
	else
		Alert("É verdadeira")
	Endif		


	U_secundaria()

Return
	
User Function secundaria()
	Local nNumero := 30

	aDados := {0,0,0}
	nResto := nNumero % 4
	cTexto := cTexto - " Ateu Espaço"

	if cTexto $ "Ateu"
		Alert("Sim esta contido")
	else 
		Alert("Não está contido")
	Endif		

Return
