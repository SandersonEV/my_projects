# --------------------------------------------------- SanStore --------------------------------------------------

import random as rd
from datetime import datetime
import pandas as pd

class Produtos:

    list_produtos_obj = []

    def __init__(self,nome:str , preco:float, quantidade:int, aviso_de_quantidade = 0):
        # validações:
        assert preco >= 0, f'{nome}: Preço (R${preco}) não pode ser negativo'
        assert quantidade >=0, f'{nome}: Quantidade ({quantidade}) não pode ser negativa'
        assert aviso_de_quantidade >= 0, 'O aviso apenas aceita zero ou valores positivos.'
        assert aviso_de_quantidade < quantidade, f'{nome}: Quantidade do produto em estoque abaixo do aviso'
        #cadastro do objeto:
        self.quantidade = quantidade
        self.preco = preco
        self.nome = nome
        self.aviso_de_quantidade = aviso_de_quantidade # avisar quando o estoque atingir essa quantidade
        Produtos.list_produtos_obj.append(self) # cria novo item na lista
        return print(f'Produto ({self.nome}) criado com sucesso.')

    def deletar_produto(self):
        Produtos.list_produtos_obj.remove(self)
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
        assert self.quantidade > quantidade, f'Estoque de {self.nome} insuficiente para remover {quantidade} itens. Estoque atual: {self.quantidade} itens'

        self.quantidade = self.quantidade - quantidade
        if self.quantidade <= self.aviso_de_quantidade:
            print(f'{self.nome} com o estoque baixo ({self.quantidade}). Fazer pedido para renovar o estoque')
        return print(f'{quantidade} unidades removidas do produto: {self.nome}. Estoque final: {self.quantidade}')      
    
    def atualizar_preco(self, novo_preco:float):
        #validações:
        assert novo_preco > 0, f'O novo preco ({novo_preco}) não pode ser menor do que zero.'

        preco_antigo = self.preco
        self.preco = novo_preco

        return print(f'Preço modificado de R$ {preco_antigo} para o novo de R$ {self.preco}')

    def atualizar_aviso(self, novo_aviso_quantidade:int):
        #validações:
        assert novo_aviso_quantidade >= 0, f'O novo aviso de quantidade baixa ({novo_aviso_quantidade}) não pode ser menor do que zero .'
        self.quantidade > novo_aviso_quantidade, f'Novo aviso de quantidade baixa ({novo_aviso_quantidade}) é menor do que a estoque atual. Adicione mais produtos ao estoque antes de atualizar o aviso.'

        aviso_antigo = self.aviso_de_quantidade
        self.aviso_de_quantidade = novo_aviso_quantidade
        return print(f'Aviso de estoque baixo modificado de {aviso_antigo} para o {self.aviso_de_quantidade} com sucesso.')

    def aplicar_desconto(self, desconto:int):
        self.preco = self.preco * (1 - desconto / 100 )
        return print(f'Desconto de {desconto} aplicado. \n  Valor com desconto aplicado: R${self.preco}.')
    
    def buscar_produto(self):
        return self

    @staticmethod # cria uma lista contendo todos os parametros dos objetos da classe
    def ListOfDicts_produtos():
        y = []
        for x in Produtos.list_produtos_obj:
            y.append(x.__dict__)   
        return y

    @staticmethod # cria uma dataframe de todos os objetos
    def dataframe_produtos():
        df = pd.DataFrame(Produtos.ListOfDicts_produtos)
        return df        

    @staticmethod# Exportar csv com todos os produtos
    def csv_produtos():
        to_csv = Produtos.dataframe_produtos
        pd.DataFrame.to_csv(to_csv, sep= ';', encoding='utf8',index=False, header=True)
        return to_csv
        
    
class Pedidos:

    list_pedidos_obj = [] # Lista pertencente à classe contendo todos os pedidos.

    def __init__(self, quantidade:int, idProduto, idCliente):

        self.idProduto = idProduto
        self.nomeProduto = Produtos.buscar_produto(self=idProduto)
        self.quantidade = quantidade
        self.dataHora = datetime.now()
        self.idCliente = idCliente
        self.nomeCliente = Clientes.buscar_cliente(self=idCliente).nome
        self.total = quantidade * (Produtos.buscar_produto(self=idProduto).preco)
        Produtos.remover_quantidade(idProduto,quantidade) # Remove q quantidade que foi feita no pedido daquele produto
        Pedidos.list_pedidos_obj.append(self)
        
        if quantidade > Produtos.buscar_produto(idProduto).quantidade: # Se a quantidade do pedido for maoir do que a quantidade em estoque:
            Pedidos.cancelarPedido(self) # cancela o pedido e adiciona novamente a quantidade retirada.
            return print('Quantidade insuficiente para efetuar o pedido. Pedido Cancelado')
        else:
            return print('Pedido realizado.')


    def cancelarPedido(self):
        Pedidos.list_pedidos_obj.remove(self) # remover da lista dos objetos
        Produtos.adicionar_quantidade(self.idProduto,self.quantidade) # reestabelecer a quantidade removida
        del self
        return print('Pedido cancelado.')

class Clientes:

    ano_atual = int(datetime.strftime(datetime.now(), '%Y')) # variável da classe que pode ser chamada na main
    list_clients_obj = []

    def __init__(self,  nome:str, idade:int, cpf:str):
        assert idade > 16, f'O {self.nome} cadastro apenas autorizado de pessoas com idade maior do que 16 anos.'
        self.nome = nome
        self.idade = idade
        self.cpf = cpf
        Clientes.list_clients_obj.append(self)
    
    def remover_cliente(self):
        Clientes.list_clients_obj.remove(self)
        del self
        
    def buscar_cliente(self):
        return self

    @property 
    def cpf(self):
        return self._cpf
    
    @cpf.setter #mudar em caso do cpf ser digitado com o ponto de separação e '-'.
    def cpf(self, valor):
        if not isinstance(valor, int):
            self._cpf = int((valor.replace('.','')).replace('-',''))