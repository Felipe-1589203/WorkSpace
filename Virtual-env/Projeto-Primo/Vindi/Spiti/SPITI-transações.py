import requests
import base64
from datetime import datetime
import pandas as pd
from pandas import json_normalize
import time
from concurrent.futures import ThreadPoolExecutor

usuario = "9aEkTNqvfeKOd5hMB9Rl4OqRtPZ6WMbp09A3TnbVtqQ"
senha = ""

base_url = "https://app.vindi.com.br/api/v1/transactions"
per_page = 50
date_cri = "2023-09-01"
date_ate = datetime.now().strftime("%Y-%m-%d")

ultimo_id_coletado = 0

output_data = []

start_time = time.time()

def fetch_and_process_data(page, starting_after):
    url = f"{base_url}?page={page}&per_page={per_page}&query=updated_at>={date_cri}&updated_at<={date_ate}&starting_after={starting_after}"

    headers = {
        "Authorization": f"Basic {base64.b64encode(f'{usuario}:{senha}'.encode()).decode()}"
    }

    response = requests.get(url, headers=headers)
    
    if response.status_code == 200:
        data = response.json()
        transactions = data.get('transactions', [])

        if not transactions:
            return None

        df = json_normalize(transactions)

        
        columns_to_keep = ["id", "transaction_type", "status", "amount", "created_at", "updated_at", "charge.id", "customer.id","customer.name", "customer.email"]
        df = df[columns_to_keep]

        df = df.rename(columns={
            "id":"id-transação",
             "transaction_type":"tipo-transação",
              "status": "status -transação",
               "amount": "valor-transação",
                "created_at": "criação-transação",
                 "updated_at": "atualização-transação",
                  "charge.id": "id-cobrança",
                   "customer.id": "id-cliente",
                   "customer.name": "nome-cliente",
                    "customer.email": "email-cliente"
        })    

        for coluna in df.columns:
            if df[coluna].dtype == 'object':
                df[coluna] = df[coluna].astype(str)

        for coluna in df.columns:
            if df[coluna].dtype == 'object':
                df[coluna] = df[coluna].str.replace(',', '.').str.replace(r"[^0-9.]", "")

        return df, transactions[-1]['id']

    else:
        print(f"Erro na solicitação: {response.status_code} - {response.text}")
        return None

page = 1
ultimo_id_coletado = 0

with ThreadPoolExecutor() as executor:
    while True:
        future = executor.submit(fetch_and_process_data, page, ultimo_id_coletado)
        result = future.result()

        if result is None:
            print("Não há mais dados para salvar. Saindo do loop.")
            break

        df, ultimo_id_coletado = result
        output_data.append(df)
        page += 1

end_time = time.time()
elapsed_time_seconds = end_time - start_time
elapsed_time_minutes = elapsed_time_seconds / 60

print(f"Solicitação à API feita com sucesso!")
print(f"Tempo decorrido para salvar os dados: {elapsed_time_seconds:.2f} segundos ({elapsed_time_minutes:.2f} minutos)")

final_df = pd.concat(output_data, ignore_index=True)

excel_file = "relatorio-vindi-spiti.xlsx"
sheet_name = "transações"

try:
    existing_data = pd.read_excel(excel_file, sheet_name=sheet_name)
    ultimo_id_coletado = existing_data['id-transação'].max() if not existing_data.empty else 0
except FileNotFoundError:
    existing_data = None

with ThreadPoolExecutor() as executor:
    while True:
        future = executor.submit(fetch_and_process_data, page, ultimo_id_coletado)
        result = future.result()

        if result is None:        
            break

        df, ultimo_id_coletado = result

        if existing_data is not None:
            df = df[~df['id-transação'].isin(existing_data['id-transação'])]

        output_data.append(df)
        page += 1

final_df = pd.concat(output_data, ignore_index=True)

with pd.ExcelWriter(excel_file, engine='openpyxl', mode='a', if_sheet_exists='overlay') as writer:
    if existing_data is not None:
        final_df = pd.concat([existing_data, final_df], ignore_index=True)
    final_df.to_excel(writer, sheet_name=sheet_name, index=False)
print(f"Dados salvos em {excel_file}")