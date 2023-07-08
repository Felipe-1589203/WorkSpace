#INCLUDE 'Protheus.ch'
#INCLUDE 'Rwmake.ch'

    User function moder1()
        Local cAlias   := "SA1"
        Local cTitulo  := "Cadastro de alunos"
        Local cFunExec := "modeluma()"
        Local cFunAlt  := "modelumb()"

        AxCadastro (cTitulo,cAlias,cFunExec,cFunAlt)   

    Return

    Static function modeluma()
        Local lRet := MsgBox("Tem certeza que deseja excluir o registro selecionado ?","Confirmação","YESNO")

    Return lRet

    Static function modelumb()
        Local lRet := .F.
        Local cMsg := ""
        
        If inclui
            cMsg := "Confirma a inclusão do registro ?"
        Else 
            cMsg := "Confirma a alteração do registro ?"
        Endif 

    lRet := MsgBox(cMsg, "Confirmação", "YESNO")            

    Return lRet
