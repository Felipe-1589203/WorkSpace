lista_instrumentos = ['bateria', 'guitarra', 'violao']

# insere um elemento sempre na ultima posição disponivel
lista_instrumentos.append('Pandeiro')
print(lista_instrumentos)

# insere qualquer elemento em qualquer posição desejada
lista_instrumentos.insert(0, 'baixo')
print(lista_instrumentos)

# Remove sempre o ultimo elemento sem posição, com possição o elemento desejado
lista_instrumentos.pop(4)
print(lista_instrumentos)
