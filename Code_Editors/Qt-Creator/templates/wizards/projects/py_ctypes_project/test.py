# coding: utf-8

"""
    This Python module uses the ctypes library.
    Learn more: https://docs.python.org/3/library/ctypes.html
"""

import sys

try:
    from ctypes import cdll, c_int, c_double, c_char, c_char_p, POINTER, Structure
except ModuleNotFoundError:
    print("Module 'cytpes' is not installed!")
    sys.exit(0)

try:
    lib = cdll.LoadLibrary('./lib/lib%{LibraryName}.so')
except OSError:
    print("File custom library not found!")
    sys.exit(0)


def test():

    # Ctypes code.
    
    pass


if __name__ == '__main__':
    test()
