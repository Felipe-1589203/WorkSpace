quantidade_transacoes = int(input('Informe a quantidade de transações: '))

total_transacoes = 0

for n_transacao in range(1, quantidade_transacoes + 1, 1):
    transacao = float(
        input(f'Por favor informe a transacao de numero {n_transacao}: '))
    total_transacoes += transacao

media = total_transacoes / quantidade_transacoes

print(
    f'Neste dia foi gasto um total de R${total_transacoes}, com uma média de {media}')
