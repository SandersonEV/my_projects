# --------------------------------------------------- SanStore --------------------------------------------------

import random as rd
import pandas as pd
from datetime import datetime

class Produtos:

    def __init__(self,nome:str , preco:float, quantidade:int, aviso_de_quantidade = None):
        # validações:
        assert preco >= 0, f'Preço {preco} não pode ser negativo'
        assert quantidade >=0, f'Quantidade {quantidade} não pode ser negativa'
        #cadastro do objeto:
        self.quantidade = quantidade
        self.preco = preco
        self.nome = nome
        self.aviso_de_quantidade = aviso_de_quantidade # avisar quando o estoque atingir essa quantidade
        return print(f'Produto {self.nome} criado com sucesso.')


    def deletar_produto(self):
        del self
        return print('Produto deletado.')

    def adicionar_quantidade(self, quantidade:int):
        #validações:
        assert quantidade > 0, f'A quantidade ({quantidade}) não pode ser negativa'

        self.quantidade = (self.quantidade + quantidade)
        return print(f'{quantidade} unidades adicinadas ao produto: {self.nome}. Total: {self.quantidade}')

    def remover_quantidade(self, quantidade:int):
        #validações:
        assert quantidade > 0, f'A quantidade ({quantidade}) não pode ser negativa'

        self.quantidade = (self.quantidade - quantidade)
        if self.quantidade <= self.aviso_de_quantidade:
            print(f'{self.nome} com o estoque baixo ({self.quantidade}), fazer pedido para renovar o estoque')
        return print(f'{quantidade} unidades removidas do produto: {self.nome}. Total: {self.quantidade}')      
    
    def atualizar_preco(self, novo_preco):
        #validações:
        assert novo_preco > 0, f'O novo preco ({novo_preco}) não pode ser menor do que zero.'

        preco_antigo = self.preco
        self.preco = novo_preco
        return (f'Preço modificado de R$ {preco_antigo} para o novo de R$ {self.preco}')

    def atualizar_aviso(self, novo_aviso_quantidade:int):
        #validações:
        assert novo_aviso_quantidade > 0 and novo_aviso_quantidade < self.quantidade , f'O novo aviso de quantidade baixa ({novo_aviso_quantidade}) não pode ser menor do que zero ou menor do que a quantidade.'

        aviso_antigo = self.aviso_de_quantidade
        self.aviso_de_quantidade = novo_aviso_quantidade
        return (f'Aviso de quantidade baixa modificado de {aviso_antigo} para o {self.aviso_de_quantidade}')

    def aplicar_desconto(self, desconto:int):
        preco_inicial = self.preco
        self.preco = self.preco * (1 - desconto / 100 )
        return print(f'Desconto de {desconto} aplicado. \n Valor sem desconto R${preco_inicial} -> Valor com desconto R${self.preco}.')
    
    def buscar_produto(self):
        return self

class Pedidos:

    def __init__(self, quantidade:int, idProduto, idCliente):

        self.idProduto = idProduto
        self.nomeProduto = Produtos.buscar_produto(self=idProduto)
        self.quantidade = quantidade
        self.dataHora = datetime.now()
        self.idCliente = idCliente
        self.nomeCliente = Clientes.buscar_cliente(self=idCliente).nome
        self.total = quantidade * (Produtos.buscar_produto(self=idProduto).preco)
        Produtos.remover_quantidade(idProduto,quantidade) # Remove q quantidade que foi feita no pedido daquele produto

        if quantidade > Produtos.buscar_produto(idProduto).quantidade: # Se a quantidade do pedido for maoir do que a quantidade em estoque:
            Pedidos.cancelarPedido(self)
            return print('Quantidade insuficiente para efetuar o pedido. Pedido Cancelado')
        else:
            return print('Pedido realizado.')


    def cancelarPedido(self):
        Produtos.adicionar_quantidade(self.idProduto,self.quantidade)
        del self
        return print('Pedido cancelado.')

class Clientes:

    ano_atual = int(datetime.strftime(datetime.now(), '%Y')) # variável da classe que pode ser chamada na main

    def cadastrar_cliente(self,  nome:str, idade:int, cpf:int):
        self.nome = nome
        self.idade = idade
        self.cpf = cpf
    
    def remover_cliente(self):
        del self

    def buscar_cliente(self):
        return self

    @property 
    def cpf(self):
        return self._cpf
    
    @cpf.setter #mudar em caso do cpf ser digitado com o ponto de separação e '-'.
    def cpf(self, valor):
        if not isinstance(valor, int):
            self._cpf = int((valor.replace('.','')).replace('.',''))

# -------------------------
    @staticmethod
    def sortear_cliente(): #sortear um id dado uma lista
        Listid = Clientes
        return print(rd.choice())