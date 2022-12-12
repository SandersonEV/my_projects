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
2 - Open the terminal and go to the directory of the test using the cd command
(If you're using the visual stidio you can also use the test in the menu at the left to get more visual results
we use the same pytest but get the results in more visual way)
'''