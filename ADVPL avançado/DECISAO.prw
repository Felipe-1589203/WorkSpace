#INCLUDE 'Protheus.ch'


User Function decisao()
	Local nNumero   := 0
	Local nCount    := 0 
	Local lContinua := .T.
	Local aArray1   := {0,0,0}
	Local aArray2   := {}
	Local aArray3    := ARRAY(3,3)
	Local nPos      := 0


	While  lContinua .AND. nCount <> 10
		nCount++
		aArray1[1] := nCount
		aArray1[2] := nCount / 2
		aArray1[3] := nCount ^ 2		
		
	End	
		lContinua := .F.

	FOR nNumero  := 1 to 10
		AADD(aArray2,{nNumero})
		if nNumero == 7
			EXIT
		endif
	NEXT

	nPos := aScan(aArray2,{|x|x[1] == 4})
	Adel(aArray2,nPos)
	Asize(aArray2, len(aArray2)-1 )


Return



