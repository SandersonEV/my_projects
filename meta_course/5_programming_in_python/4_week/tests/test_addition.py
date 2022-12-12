import addition
import pytest


# First:

def test_add():
    assert addition.add(4,5) == 9 # The add function using 4 and 5 must return 9

def test_sub():
    assert addition.sub(4,5) == -1 # the subtraction function using 4 and 5 must return -1

# Second:
'''
1 - Split the screen and open one with the functions and other with the tests
2 - Open the terminal and type: python -m pytest test_addition.py
'''