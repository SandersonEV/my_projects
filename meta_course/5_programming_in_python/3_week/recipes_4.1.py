class Recipe():

    def __init__(self, dish, items, time) -> None:
        self.dish = dish
        self.items = items
        self.time = time
    
    def contents(self):
        return print(f'The {self.dish} has {self.items} and and takes {self.time} min to prepare.')



# -----------------------------------------------------------------------------------------------------------------            

pizza = Recipe('Pizza', ['Cheese', 'Bread', 'Tomato'], 45)
pasta = Recipe('Pasta', ['Penne', 'Sauce', 'Tomato'], 55)

print(pasta.items, '\n')
print(pizza.items, '\n')

pasta.contents()

