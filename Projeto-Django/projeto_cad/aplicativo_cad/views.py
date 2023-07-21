from django.shortcuts import render
from .models import usuario


def home(request):
    return render(request, 'usuarios/home.html')


def Usuarios(request):
    # Salvar os dados da tela para o banco de dados
    novo_usuario = usuario()
    novo_usuario.nome = request.POST.get('nome')
    novo_usuario.Idade = request.POST.get('Idade')
    novo_usuario.save()


# Exibir todos os usuarios ja cadastrados em uma nova pagina
usuarios = {
    'usuarios': usuario.objects.all()
}

# Retornar os dados para a pagina de listagem de usuarios
return render(request, 'usuarios/usuarios.html', usuarios)
