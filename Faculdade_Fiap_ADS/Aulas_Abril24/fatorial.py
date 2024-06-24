minutos = int(input('Informe os numeros dos minutos do horario atual: '))

fatorial = minutos

for numero in range(1, minutos):
    fatorial = fatorial * numero


print(f'A senha e liberdade{fatorial}')
