
from django.urls import path
from aplicativo_cad import views

urlpatterns = [
    path('', views.home, name='home'),
    path('usuarios/', views.usuario, name='listagem_usuarios')
]
