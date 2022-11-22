# This peace of code wasn't wited by me and it is an exemple

menu = {
    1: {"name": 'espresso',
        "price": 1.99},
    2: {"name": 'coffee', 
        "price": 2.50},
    3: {"name": 'cake', 
        "price": 2.79},
    4: {"name": 'soup', 
        "price": 4.50},
    5: {"name": 'sandwich',
        "price": 4.99}
}


def calculate_subtotal(order): # function to calculate the subtotal of the order

    print('Calculating bill subtotal...')

    total = 0
    for x in order: # 'x' runs in a list of dicts from orders 
        total += x["price"]

    return (float(round(total),2))

    raise NotImplementedError()

def calculate_tax(subtotal): # function to calculate the tax of 15% with the subtotal.

    print('Calculating tax from subtotal...')
    tax = round(subtotal * 0.15, 2)
    return(float(tax))

    raise NotImplementedError()

def summarize_order(order):

    subtotal = calculate_subtotal(order)
    tax = calculate_tax(subtotal)
    total = round(subtotal + tax, 2)
    names = []
    names = [nam['name'] for nam in order] # gets only the nam['name'] from the orders dict

    return names, total

    raise NotImplementedError()

# ----------------------------------------- everything written between the lines was done beforehand ---------------------------------------------------

# This function is provided for you, and will print out the items in an order
def print_order(order):

    print('You have ordered ' + str(len(order)) + ' items')
    items = []
    items = [item["name"] for item in order]
    print(items)
    return order

# This function is provided for you, and will display the menu
def display_menu():

    print("------- Menu -------")
    for selection in menu:
        print(f"{selection}. {menu[selection]['name'] : <9} | {menu[selection]['price'] : >5}")
    print()

# This function is provided for you, and will create an order by prompting the user to select menu items
def take_order():

    display_menu()
    order = [] # define an empty list
    count = 1
    for i in range(3): # range(3) means 'i' will run in a list of 3 items
        item = input('Select menu item number ' + str(count) + ' (from 1 to 5): ')
        count += 1
        order.append(menu[int(item)]) # When the order is made, the outter dict 1:, 2:... wasn't go. It means that the order is not like the menu (dict{dict{}})
    return order

# -----------------------------------------------------------------------------------------------------------------------------------------------------

'''
Here are some sample function calls to help you test your implementations.
'''
def main(): 

    order = take_order()
    print_order(order)

    subtotal = calculate_subtotal(order)
    print("Subtotal for the order is: " + str(subtotal))

    tax = calculate_tax(subtotal)
    print("Tax for the order is: " + str(tax))

    items, subtotal = summarize_order(order)

if __name__ == "__main__":
    main() 
