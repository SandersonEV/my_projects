class Produto:
    def __init__(self, nome, preco) -> None:
        self.nome = nome
        self.preco = preco
    
    def desconto(self, percentual):
        self.preco = self.preco * (1 - (percentual/100))


# ------------------------------- Getter e Setter para a variável preco --------------------------------
# Quando é preciso alterar um dado que foi colocado com data type diferente.
# Ex: foi colocado uma str no lugar de um int (Preco = R$50 e deveria ser somente 50)

# Getter: Pega o valor

    @property
    def preco(self):
        return self._preco #por convencao nos apenas adicionamos um '_' ao inicio do nome da variável que iremos trabalhar e que foi selecionada após o def.

# Setter: configura/altera o valor
    @preco.setter
    def preco(self, valor):
        if isinstance(valor, str): # checa se a variável valor pertence a str.
            valor = float(valor.replace('R$', '')) #apaga o R$ (caso seja colocado).

        self._preco = valor

# Usando Getter e Setter primeiro o input adicionado na variável 'preco' passará pelo Setter para só depois ser inserido dentro da variável

# ------------------------------------ Getter e Setter na variável 'nome' -----------------------------------------------
  
   # 1 - Cria uma função com o nome da variável
   # 2 - retorna ela mesma (self) e salva dentro de outra '_nome'
   
    @property
    def nome(self):
        return self._nome 

   # 3 - a nova função nome possui um valor
   # 4 - self._nome recebe o novo valor após a modificação
   # 5 - o valor antigo é substituido pelo novo valor de self._nome
    
    @nome.setter
    def nome(self, valor):
        self._nome = str(valor)
