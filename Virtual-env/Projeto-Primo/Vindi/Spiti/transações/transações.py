import requests
import base64
from datetime import datetime
import pandas as pd
from pandas import json_normalize

usuario = "9aEkTNqvfeKOd5hMB9Rl4OqRtPZ6WMbp09A3TnbVtqQ"
senha = ""

base_url = "https://app.vindi.com.br/api/v1/transactions"
page = 1
per_page = 50
date_cri = "2023-09-01"
date_ate = datetime.now().strftime("%Y-%m-%d")

ultimo_id_coletado = 0

output_data = []

while True:
    url = f"{base_url}?page={page}&per_page={per_page}&query=created_at>={date_cri}&created_at<={date_ate}&starting_after={ultimo_id_coletado}"

    headers = {
        "Authorization": f"Basic {base64.b64encode(f'{usuario}:{senha}'.encode()).decode()}"
    }

    response = requests.get(url, headers=headers)
    print(response.status_code)

    if response.status_code == 200:
        data = response.json()
        transactions = data.get('transactions', [])

        if not transactions:
            print("Não há mais dados para salvar. Saindo do loop.")
            break

        # Normalizar campos aninhados em um DataFrame
        df = json_normalize(transactions)

        for coluna in df.columns:
            if df[coluna].dtype == 'object':
                df[coluna] = df[coluna].astype(str)

        for coluna in df.columns:
            if df[coluna].dtype == 'object':
                df[coluna] = df[coluna].str.replace(',', '.').str.replace(r"[^0-9.]", "")

        output_data.append(df)
        
        ultimo_id_coletado = transactions[-1]['id']
        page += 1
        print(f"Dados da última solicitação: {transactions}")
    else:
        print(f"Erro na solicitação: {response.status_code} - {response.text}")
        break

print("Solicitação à API feita com sucesso!")

# Concatenar todos os DataFrames em um único DataFrame
final_df = pd.concat(output_data, ignore_index=True)

# Salvar dados em um arquivo Excel (.xlsx)
excel_file = "transações.xlsx"
final_df.to_excel(excel_file, index=False)

print(f"Dados salvos em {excel_file}")
