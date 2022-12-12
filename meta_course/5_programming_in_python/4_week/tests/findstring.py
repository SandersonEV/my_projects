def ispresent(person):
    names = ['Alan', 'Sam', 'Bob', 'Ricardo', 'Pedro']
    if person in names:
        return True
    else:
        return False

def nodigit(person): # Trua if the string contains alpha letters
    if person.isalpha():
        return True
    else:
        return False