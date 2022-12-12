import findstring
import pytest

def test_ispresent():
    assert findstring.ispresent('Sam')

# You'll have to use the cd command to go to the test directory

def test_nodigit():
    assert findstring.nodigit('N')