# Parent/Child Classes: Everything in the parent class is accessed from the chilf class and the __init__ from the parent go to the childs as well.

class Employees:
    def __init__(self, name, last) -> None:
        self.name = name
        self.last = last

class Supervisors(Employees): #child class from Employees
    def __init__(self, name, last, password) -> None:
        super().__init__(name, last) #super() makes a reference to the parent class and can also access the data that is iside of the parent class
        self.password = password

class Chefs(Employees): # The parameters from the parent class is chared with all the child
    def leave_requests(self, days):
        return print(f'May I take a leave for {days} days.')

adrian =  Supervisors('Adrian', 'A', '123456')

emily = Chefs('Emily', 'E') # Chef has no __init__ but he has the init from the parent class
Julho = Chefs('Julho', 'F')

emily.leave_requests(3)
print(adrian.password)
print(emily.name)

# When you define a parent/child you are shortning your code to reuse things from your parent in your child class.