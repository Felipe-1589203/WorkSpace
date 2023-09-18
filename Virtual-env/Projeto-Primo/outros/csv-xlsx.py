import pandas as pd

# Defina o caminho do arquivo CSV e o caminho do arquivo XLSX
arquivo_csv = 'Finclass.csv'
arquivo_xlsx = 'Produtos-finclass.xlsx'

# Leia o arquivo CSV em um DataFrame
df = pd.read_csv(arquivo_csv, delimiter='\t', header=None)

# Escreva o DataFrame em um arquivo XLSX
df.to_excel(arquivo_xlsx, index=False, header=None)

print(f"Os dados foram convertidos e salvos em {arquivo_xlsx}")
