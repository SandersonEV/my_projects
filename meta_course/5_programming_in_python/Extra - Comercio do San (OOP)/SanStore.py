# --------------------------------------------------- SanStore --------------------------------------------------

import random as rd
from datetime import datetime
import pandas as pd

class Produtos:

    list_produtos_obj = []

    def __init__(self,nome:str , preco:float, quantidade:int, aviso_de_quantidade = 0): #Inicializar
        # validações:
        assert preco >= 0, f'{nome}: Preço (R${preco}) não pode ser negativo'
        assert quantidade >=0, f'{nome}: Quantidade ({quantidade}) não pode ser negativa'
        assert aviso_de_quantidade >= 0, 'O aviso apenas aceita zero ou valores positivos.'
        assert aviso_de_quantidade < quantidade, f'{nome}: Quantidade do produto em estoque abaixo do aviso'
        #cadastro do objeto:
        self.nome = nome
        self.quantidade = quantidade
        self.preco = preco
        self.aviso_de_quantidade = aviso_de_quantidade # avisar quando o estoque atingir essa quantidade   
        Produtos.list_produtos_obj.append(self) # cria novo item na lista
        return print(f'(RETORNO) Produto ({self.nome}) criado com sucesso.')

    def deletar_produto(self):

        if isinstance(self, Computadores) == True: # Se o objeto (self) for pertencente à classe Computadores:
            Computadores.list_computadores_obj.remove(self)

        Produtos.list_produtos_obj.remove(self)
        del self # Mesmo que o objeto (self) pertença à classe Computadores(Produtos) apenas um objeto é criado. Sendo assim, o objeto precisa ser indicado após o comando 'del' somente uma vez.
        return print('(RETORNO) Produto removido.')

    def adicionar_quantidade(self, quantidade:int):
        #validações:
        assert quantidade > 0, f'(AVISO) A quantidade ({quantidade}) não pode ser negativa'

        self.quantidade = (self.quantidade + quantidade)
        return print(f'(RETORNO) {quantidade} unidades adicinadas ao produto: {self.nome}.')

    def remover_quantidade(self, quantidade:int):
        #validações:
        assert quantidade > 0, f'(AVISO) A quantidade ({quantidade}) não pode ser negativa'
        assert self.quantidade > quantidade, f'(AVISO) Estoque de {self.nome} insuficiente para remover {quantidade} itens.'

        self.quantidade = self.quantidade - quantidade
        if self.quantidade <= self.aviso_de_quantidade:
            print(f'(AVISO) {self.nome} com o estoque baixo ({self.quantidade} und).')
        return print(f'(RETORNO) {quantidade} unidades removidas do produto: {self.nome}.')      
    
    def atualizar_preco(self, novo_preco:float):
        #validações:
        assert novo_preco > 0, f'(AVISO) O novo preco ({novo_preco}) não pode ser menor do que zero.'

        preco_antigo = self.preco
        self.preco = novo_preco

        return print(f'(RETORNO) {self.nome}: preço modificado de R$ {preco_antigo} para R$ {self.preco}')

    def atualizar_aviso(self, novo_aviso_quantidade:int):
        #validações:
        assert novo_aviso_quantidade >= 0, f'(AVISO) O novo aviso de quantidade baixa ({novo_aviso_quantidade}) não pode ser menor do que zero .'
        assert self.quantidade > novo_aviso_quantidade, f'(AVISO) Novo aviso de quantidade baixa ({novo_aviso_quantidade}) é menor do que a estoque atual. Adicione mais produtos ao estoque antes de atualizar o aviso.'

        aviso_antigo = self.aviso_de_quantidade
        self.aviso_de_quantidade = novo_aviso_quantidade
        return print(f'(RETORNO) {self.nome}: aviso de estoque baixo modificado de {aviso_antigo} para o {self.aviso_de_quantidade} com sucesso.')

    def aplicar_desconto(self, desconto:int):
        self.preco = self.preco * (1 - desconto / 100 )
        return print(f'(RETORNO) {self.nome}: desconto de {desconto}% aplicado ->  Valor com desconto aplicado: R$ {self.preco}.')
    
    def buscar_produto(self):
        return self

    @classmethod
    def ListOfDicts_produtos(cls): # Essa lista deve conter apenas as colunas comuns a classe Produtos. Sendo assim, devemos limpar as colunas referentes a classe Computadores.
        y = []
        for x in cls.list_produtos_obj:
            if isinstance(x, Computadores): # Caso o objeto va vez pertença à classe Computadores:
                g = {chave: valor for (chave,valor) in x.__dict__.items() if chave not in ['ram','processador','placa_video']} #DICTIONARY COMPREHENSION:
                y.append(g) 
            else:
                y.append(x.__dict__)   
        return y

    @classmethod
    def dataframe_produtos(cls):
        df = pd.DataFrame(cls.ListOfDicts_produtos())
        return df

    @classmethod
    def csv_produtos(cls):
        to_csv = cls.dataframe_produtos()
        csv = pd.DataFrame.to_csv(to_csv, sep= ';', encoding='utf8',index=False, header=True,)
        return csv
           
class Pedidos:

    list_pedidos_obj = [] # Lista pertencente à classe contendo todos os pedidos.

    def __init__(self, quantidade:int, Produto, Cliente):

        self.dataHora = datetime.now().isoformat(' ', 'seconds')
        self.Cliente = Cliente
        self.nomeCliente = Clientes.buscar_cliente(self=Cliente).nome
        self.Produto = Produto
        self.nomeProduto = Produtos.buscar_produto(self=Produto).nome
        self.quantidade = quantidade
        self.total = quantidade * (Produtos.buscar_produto(self=Produto).preco)
        Produtos.remover_quantidade(Produto,quantidade) # Remove q quantidade que foi feita no pedido daquele produto
        Pedidos.list_pedidos_obj.append(self)
        
        if quantidade > Produtos.buscar_produto(Produto).quantidade: # Se a quantidade do pedido for maoir do que a quantidade em estoque:
            Pedidos.cancelarPedido(self) # cancela o pedido e adiciona novamente a quantidade retirada.
            return print('(RETORNO) Pedido Cancelado: Quantidade insuficiente para efetuar o pedido. ')
        else:
            return print('(RETORNO) Pedido realizado.')


    def cancelarPedido(self):
        Pedidos.list_pedidos_obj.remove(self) # remover da lista dos objetos
        Produtos.adicionar_quantidade(self.Produto,self.quantidade) # reestabelecer a quantidade removida
        del self
        return print('(RETORNO) Pedido cancelado.')

    @classmethod
    def listDict_pedidos(cls):
        o = []
        for x in cls.list_pedidos_obj:
           o.append(x.__dict__)
        return o
    
    @classmethod 
    def dataframe_pedidos(cls):
        df = pd.DataFrame(cls.listDict_pedidos())
        return df

class Clientes:

    ano_atual = int(datetime.strftime(datetime.now(), '%Y')) # variável da classe que pode ser chamada na main
    list_clients_obj = []

    def __init__(self,  nome:str, idade:int, cpf:str):
        assert idade > 16, f'O {self.nome} cadastro apenas autorizado de pessoas com idade maior do que 16 anos.'
        self.nome = nome
        self.idade = idade
        self.cpf = cpf
        Clientes.list_clients_obj.append(self)
        return print(f'Cliente ({self.nome}) criado com sucesso.')

    @property 
    def cpf(self):
        return self._cpf
    
    @cpf.setter #mudar em caso do cpf ser digitado com o ponto de separação e '-'.
    def cpf(self, valor):
        self._cpf = str((valor.replace('.','')).replace('-',''))
    
    def __eq__(self, other): # Para que dois usuários sejam iguais o cpf é que deve ser o comparadaro
        return self.cpf == other.cpf

    def remover_cliente(self):
        Clientes.list_clients_obj.remove(self)
        del self
     
    def buscar_cliente(self): # Esse Metodo auxilia nos momentos em que o objeto precisa ser referenciado em outro lugar
        return self
    
    @classmethod
    def sortear_cliente(cls):
        sorteado = rd.choice(cls.list_clients_obj)
        return print(f'O sorteado foi {sorteado.nome} portador do CPF: {sorteado.cpf}')


    @classmethod
    def listDict_clientes(cls):
        i = []
        for x in cls.list_clients_obj:
            i.append(x.__dict__)
        return i

    @classmethod
    def dataframe_clientes(cls):
        df = pd.DataFrame(cls.listDict_clientes())
        return df

class Computadores(Produtos): # Filho(Pai) 

    list_computadores_obj = []

    def __init__(self, nome: str, preco: float, quantidade: int,ram: str, processador: str,placa_video: bool = False, aviso_de_quantidade = 0):
        super().__init__(nome, preco, quantidade, aviso_de_quantidade)
        self.ram = ram
        self.placa_video = placa_video
        self.processador = processador
        Computadores.list_computadores_obj.append(self) 
        # precisa de return ja que é um subclasse?

    # O objeto criado sera pertencente à classe Computadores(Produtos).

    def remover_computador(self):
        return Produtos.deletar_produto(self)

    @classmethod
    def listDict_Computadores(cls):
        z = []
        for x in cls.list_computadores_obj:
            z.append(x.__dict__)
            return z
    
    @classmethod
    def dataframe_computadores(cls):
        df = pd.DataFrame(cls.listDict_Computadores())
        return df

''' 
Implementações futuras:

- Random ID
- Buscar e deletar através do ID
- Random ID != dos existentes

'''