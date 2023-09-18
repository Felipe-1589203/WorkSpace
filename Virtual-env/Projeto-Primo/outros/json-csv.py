import json
import pandas as pd

# Ler o arquivo JSON
with open('id-cobranças.json', 'r') as file:
    data = json.load(file)

# Transformar em um DataFrame do Pandas
df = pd.DataFrame(data['products'])

# Especificar o nome do arquivo CSV de saída
nome_arquivo_csv = 'Finclass.csv'

# Salvar o DataFrame em um arquivo CSV
df.to_csv(nome_arquivo_csv, index=False)

print(f'O arquivo CSV foi gerado com sucesso: {nome_arquivo_csv}')
