from abc import ABC, abstractmethod


class Employee(ABC): # ABC como uma classe pai da classe que você quer abstrair

    @abstractmethod
    def donate(self): # Um metodo que não pode ser chamado
        pass

class Donation(Employee):
    def donate(self):
        a = float(input('How much would you like to donate: '))
        return a

# -------------------------------------------------------------
total = []

john = Donation()
j = john.donate()
total.append(j)

peter = Donation()
p = peter.donate()
total.append(p)
print(total,' total de R$: ', sum(total))