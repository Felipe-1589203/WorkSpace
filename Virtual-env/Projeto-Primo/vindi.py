import requests


url = 'https://app.vindi.com.br/api/v1/products?page=1&per_page=25&sort_by=id&sort_order=asc'
headers = {
    'Authorization': 'Bearer SEU_TOKEN_DE_AUTORIZAÇÃO',  
}


response = requests.get(url, headers=headers)
if response.status_code == 200:
    um = response.json()
    print(um)
else:
    print('A chamada à API falhou com código de status:', response.status_code)
