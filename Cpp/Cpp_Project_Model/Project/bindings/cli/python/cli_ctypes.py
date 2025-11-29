# -*- coding: utf-8 -*-

import ctypes
import sys

from typing import Optional, Any
from pathlib import Path


try:
    from ctypes import cdll, c_char_p
except ModuleNotFoundError:
    print("Module 'cytpes' is not installed!")
    sys.exit(0)

# Project/dist/lib/liblibrary.so
LIBRARY_NAME: str = "liblibrary.so"
LIBRARY_PATH: Path = Path("../../../dist/lib")
FULL_PATH: Path = LIBRARY_PATH / LIBRARY_NAME

lib: Optional[Any] = None

try:
    lib = cdll.LoadLibrary(str(FULL_PATH))
except OSError as e:
    lib = None
    print(f"File '{FULL_PATH}' not found! Error: {e}")
        

def get_path() -> str:
    
    if lib is None:
        return f"[FATAL ERROR] Library '{LIBRARY_NAME}' was not loaded."
        
    try:
        lib.path.restype = ctypes.c_char_p 
    
        c_string_ptr: Optional[bytes] = lib.path()
    
        if c_string_ptr:
            py_string: str = c_string_ptr.decode('utf-8')
            return py_string
        else:
            return "[ERROR] C function returned a NULL pointer."

        return py_string
        
    except OSError as e:
        return f"[RUNTIME ERROR] : {e}"


def view_path() -> None:
    print("Test Python with Ctypes  ...");

    result: str = get_path()
    print(f"{result}")


if __name__ == '__main__':
    view_path()
