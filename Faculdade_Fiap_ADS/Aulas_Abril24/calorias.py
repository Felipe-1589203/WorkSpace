quantidade_alimentos = int(
    input('Por favor informe quantos alimentos voce consumiu hoje: '))

total_calorias = 0
caloria = 0
for alimento in range(1, quantidade_alimentos + 1, 1):
    while True:
        try:
            caloria = int(
                input(f'Informe a quantidade de calorias do {alimento} alimento: '))
            break
        except ValueError:
            print('Por favor digite um dado numerico!')
    total_calorias += caloria

print(f'Foram consumidas {total_calorias} calorias ao longo do dia!')
