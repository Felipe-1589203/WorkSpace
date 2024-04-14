numero = int(input('Por favor digite o numero que deseja saber a tabuada: '))

for contador in range(1, 11):
    total = contador * numero
    print(f'{numero} x {contador} = {total}')
