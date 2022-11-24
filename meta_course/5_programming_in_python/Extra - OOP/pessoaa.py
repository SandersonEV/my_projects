class Pessoa:

    def __init__(self, nome, idade, comendo = False, falando = False):
        self.nome = nome
        self.idade = idade
        self.comendo = comendo
        self.falando = falando

        absi = 2 # I can also create a variable inside of this method
        print(absi)
        return
    
    def comer(self, alimento):
        if self.comendo == True: # If the parameter 'comendo' is set to true and you try to call the function
            print(f'{self.nome} já está comendo {alimento}')
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