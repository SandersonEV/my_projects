class Paylips:
    def __init__(self, name, payment, amount) -> None:
        self.name = name
        self.payment = payment
        self.amount = amount
        return
    
    def pay(self):
        self.payment = 'yes'
        return

    def status(self):
        if self.payment == 'yes':
            return print(f'{self.name} is paid {self.amount}')
        else:
            return print(f'{self.name} is not paid yet')

nathan = Paylips('Nathan', 'no', 1000)
roger = Paylips('Roger', 'no', 3000)

print(f'{nathan.status()} \n {roger.status()} \n')

roger.pay()

print(f'{nathan.status()} \n {roger.status()}')