def mult(num1, num2):
    return num1 * num2

oper = input('Digite a operação A, D, M, S: ')
number1 = int(input('Digite o primeiro numero: '))
number2 = int(input('Digite o segundo numero: '))

if oper == 'M':
    resultado = mult(number1, number2)

elif oper == 'A':
    resultado = number1 + number2
elif oper == 'D':
    resultado = number1 / number2
elif oper == 'S':
    resultado = number1 - number2
elif oper != range('A,D,M,S'):
    resultado = 'Operação inválida'

print(f'O resultado da operação é {number1} {oper} {number2}: {resultado}')