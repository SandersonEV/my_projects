from pessoaa import Pessoa # the first name after the from means the name of the file and the name after import means the class name.

p1 = Pessoa('Lucas', 23)
p2 = Pessoa('Pedro', 34)

print(p1)  # You can see that are two differente persons creted as pe
print(p2)  # We have two different objects

print(f'{p1.nome} tem {p1.idade} anos')

print(p1.comer(alimento= 'batata'), '\n')
print(p2.comer('maçã'))
print(p2.comer('maçã'))

# ----------------------------------------------------------------
p3 = Pessoa('Ricado', 56)
p3.falar('O placar de hoje vai ser 4 X 0 para o Brasil!!')
