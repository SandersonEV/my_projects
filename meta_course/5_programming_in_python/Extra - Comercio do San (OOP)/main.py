from SanStore import Produtos, Pedidos, Clientes
import pandas as pd

p1 = Produtos(nome= 'Iphone 10', preco=4500,quantidade=40)
p2 = Produtos(nome= 'Camiseta do Brasil', preco=50,quantidade=10)

print(f'nome: {p1.nome}')
print(f'preco: R${p1.preco}')
print(f'quantidade: {p1.quantidade}')
print(f'aviso de quantidade baixa: {p1.aviso_de_quantidade}','\n')
print(p1.__dict__, '\n') # dict of all the itens inside of the object

c1 = Clientes(nome= 'Sanderson Vieira', idade= 28, cpf = '09887922498') # dentro dos inteiros o zero a esquerda seria apenas apagado
print(c1.__dict__, '\n')

print(Produtos.ListOfDicts_productos)