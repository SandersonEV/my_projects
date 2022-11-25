'''
Na programação orientada a objectos nos criamos uma classe que vai guardar e definir quais e como serão as interações do objeto atribuido na main.

Na main nos iremos 'puxar' a classe 'Pessoa' e definir algum objeto como sendo pertencente a essa classe.
    - O objeto definido na main também irá e herdar todas as funções e variáveis relacionadas a essa classe.

'''
from datetime import datetime
# import random = importaria o modulo todo. como não será necessário fazer isso deveremos importar apenas o randint
from random import randint
class Pessoa:

    ano_atual = int(datetime.strftime(datetime.now(), '%Y')) # variável da classe que pode ser chamada na main

    def __init__(self, nome, idade, comendo = False, falando = False):
        self.nome = nome # variáveis da instância
        self.idade = idade
        self.comendo = comendo
        self.falando = falando

        # I can also create a variable inside of this method
        print(f'Usuário {self.nome} criado com sucesso')
        return
    
    def comer(self, alimento):

        if self.comendo == True: # If the parameter 'comendo' is set to true and you try to call the function
            print(f'{self.nome} já está comendo {alimento}')
            return
        elif self.falando == True:
            print('Não pode comer falando!')
            return
        else:
            print(f'{self.nome} está comendo {alimento}')
            self.comendo = True # As the method declare that the user is eating, tha self.comendo should change to true.
            return

    def parar_de_comer(self):
        if self.comendo == True:
            print(f'{self.nome} parou de comer.')
            self.comendo = False
            return
        else:
            print(f'{self.nome} não está comendo')
            return

    def falar(self, assunto): # the self method is to pass the istance referenced in the main.py when call this function (ex: p1.falar(self) = p1.falar(p1))
        if self.comendo == True:
            print(f'O {self.nome} não pode falar agora pois está comendo')
            return
        elif self.falando == True:
            print(f'O {self.nome} já está falando')
            return            
        else:
            print(f'{self.nome}: {assunto}')
            return

    def parar_de_falar(self):
        if self.falando == True:
            self.falando = False
            return
        else:
            print(f'O {self.nome} não está a falar. ')
            return
    
    def get_ano_de_nascimento(self):
        return self.ano_atual - self.idade

# -------------------------------------------------- Métodos de classe ------------------------------------------------------
# metodos de classe são métodos relativos somente à classe

    @classmethod # metodo de classe - não é necessário a instancia (self)
    def por_ano_nascimento(cls, nome, ano_nascimento): # Criar um novo usuário através do ano de nascimento 
        idade = cls.ano_atual - ano_nascimento # obter idade através do ano
        return cls(nome, idade) # retorna os parametro necessários para criação de um novo usuário

        

    @staticmethod # Método Estático - não precisa nem da instância nem da classe - é como se fosse uma função qualquer separada da classe.
    def gera_id(): # não é necessário receber nenhum parametro (mas pode)
        return randint(10000,19999)
