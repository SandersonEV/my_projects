from pessoa1 import Pessoa # the first name after the from means the name of the file and the name after import means the class name.

p1 = Pessoa('Lucas', 23) # Criando um novo objeto p1 pertencente à classe Pessoa
p2 = Pessoa('Pedro', 34)

print(p1)  # You can see that are two differente persons creted as pe
print(p2)  # We have two different objects

print(f'{p1.nome} tem {p1.idade} anos')

print(p1.comer(alimento= 'batata'), '\n')
print(p2.comer('maçã'))
print(p2.comer('maçã'))

# ----------------------------------------------------------------------------------------------------------------------------
p3 = Pessoa('Ricado', 56)
p3.falar('O placar de hoje vai ser 4 X 0 para o Brasil!!')

print(Pessoa.ano_atual, '\n') # call the variable inside of the class

print(p1.get_ano_de_nascimento(), '\n') # as the function get_ano_de_nascimento do not print and only return, must contain a print function before.

# ------------------------------------------------------------- 2 --------------------------------------------------------------

p4 = Pessoa.por_ano_nascimento('Sanderson', 1994) # Create a new user using the birth year through a class method
print(p4.nome, p4.idade, '\n')

print(Pessoa.gera_id(), '\n') # A function from the class Pessoa that do not need any parameter to happen.

print(p1.gera_id(), '\n') # I can call also using the instance 'p1'

