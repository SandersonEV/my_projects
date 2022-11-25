from produto2 import Produto

# -------------------------------------------------------- Test 1 ---------------------------------------------------------
p1 = Produto('Camiseta', 50)
print(p1.nome, ' -  R$ ', p1.preco, '\n')
p1.desconto(10)
print(p1.nome, ' -  R$ ', p1.preco,'- (Preço após o desconto)', '\n') # OK

# -------------------------------------------------------- Test 2 ---------------------------------------------------------
p2 = Produto('Meias', 'R$20') # Dessa vez iremos tentar adiciona o 'R$' ao valor. Sendo assim, caso não haja um tratamento para tranformalo em float/int, o desconto não poderá ser aplicado
print(p2.nome, ' -  R$ ', p2.preco, '\n')
p2.desconto(10)
print(p2.nome, ' -  R$ ', p2.preco,'- (Preço após o desconto)', '\n') # OK

# -------------------------------------------------------- Test 3 ---------------------------------------------------------
p3 = Produto('Botas', 'R$ 30') # Dessa vez iremos tentar adiciona o 'R$ ' com um espaço
print(p3.nome, ' -  R$ ', p3.preco, '\n')
p3.desconto(10)
print(p3.nome, ' -  R$ ', p3.preco,'- (Preço após o desconto)', '\n') # OK

