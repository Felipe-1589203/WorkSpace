/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MFATA008  ºAutor  ³Alexandre Sousa     º Data ³  11/19/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Gatilho para atualizar a condicao de pagamento 999          º±±
±±º          ³Apenas para automotivo.                                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³Especifico MULTLOCK.                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MFATA008()
	
	Local n_posval	:= aScan(aHeader, {|x| x[2]="C6_VALOR"})

	Private n_vezes	:= 0
	Private n_total	:= 0
	
	For n_x := 1 to len(aCols)
		If !aCols[n_x, len(aHeader)+1]
			n_total += aCols[n_x, n_posval]
		EndIf
	Next
	
	If !Empty(M->C5_DATA1)
		n_vezes++
	EndIf
	
	If !Empty(M->C5_DATA2)
		n_vezes++
	EndIf

	If !Empty(M->C5_DATA3)
		n_vezes++
	EndIf

	If !Empty(M->C5_DATA4)
		n_vezes++
	EndIf

	If !Empty(M->C5_DATA5)
		n_vezes++
	EndIf

	If !Empty(M->C5_DATA6)
		n_vezes++
	EndIf

	If !Empty(M->C5_DATA7)
		n_vezes++
	EndIf

	If !Empty(M->C5_DATA8)
		n_vezes++
	EndIf

	If !Empty(M->C5_DATA9)
		n_vezes++
	EndIf

	If !Empty(M->C5_DATAA)
		n_vezes++
	EndIf

	For n_x := 1 to n_vezes
		If n_vezes < 10
			c_exec := "M->C5_PARC"+Strzero(n_x,1)+" := n_total/n_vezes"
		Else
			c_exec := "M->C5_PARCA := n_total/n_vezes"
		EndIf
		&(c_exec)
	Next

Return n_total/n_vezes
