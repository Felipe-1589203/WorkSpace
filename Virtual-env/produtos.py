import requests
import json
from requests.auth import HTTPBasicAuth

# Finalidade consumir a Api da vindi e retornar a tabela de produtos
# Feito em 05/09/2023 por Felipe Souza dos Santos.(Analista financeiro)

def get_vindi_products(api_username, api_password, page=1, per_page=25, sort_by='id', sort_order='asc', query=None):   
    url = 'https://app.vindi.com.br/api/v1/products'
    
    
    all_products = []

    while True:        
        params = {
            'page': page,
            'per_page': per_page,
            'sort_by': sort_by,
            'sort_order': sort_order
        }
        
        
        if query:
            params['query'] = query
        
        try:            
            response = requests.get(url, auth=HTTPBasicAuth("9aEkTNqvfeKOd5hMB9Rl4OqRtPZ6WMbp09A3TnbVtqQ", api_password), params=params)

            if response.status_code == 200:                
                data = response.json()
                products = data.get('products', [])
                all_products.extend(products)

                
                if 'next_page' in response.headers:
                    page += 1
                else:
                    break
            else:
                print('A chamada à API falhou com código de status:', response.status_code)
                break
        except requests.exceptions.RequestException as e:
            print('Erro na chamada à API:', e)
            break

    return all_products

if __name__ == '__main__':   
    api_username = ''
    api_password = ''
    todos_os_produtos = get_vindi_products(
        api_username, 
        api_password, 
        page=1,  
        per_page=50, 
        sort_by='name', 
        sort_order='asc', 
        query=None  
    )

    if todos_os_produtos:        
        with open('primo.json', 'w', encoding='utf-8') as json_file:
            json.dump(todos_os_produtos, json_file, ensure_ascii=False, indent=4)
