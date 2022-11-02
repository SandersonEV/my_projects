import requests,json

r = requests.get('https://parallelum.com.br/fipe/api/v1/carros/marcas').json()
r=json.loads(r.content)
print(r)
print(type(r[0]))