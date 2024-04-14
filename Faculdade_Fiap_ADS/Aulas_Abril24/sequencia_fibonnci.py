quantidade_elementos = 10
anterior1 = 1
anterior2 = 0

for n_elemento in range(1, quantidade_elementos + 1, 1):
    atual = anterior1 + anterior2
    anterior1 = anterior2
    anterior2 = atual
    print(atual)
