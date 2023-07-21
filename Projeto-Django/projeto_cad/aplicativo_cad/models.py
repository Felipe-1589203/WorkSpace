from django.db import models


class Usuario(models.Model):
    pass
    id_usuario = models.AutoField(primary_key=True)
    nome = models.CharField(max_length=255, null=True)
    idade = models.IntegerField()
