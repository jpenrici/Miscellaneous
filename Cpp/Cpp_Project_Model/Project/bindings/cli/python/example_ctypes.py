import ctypes
import sys


try:
    from ctypes import cdll, c_char_p
except ModuleNotFoundError:
    print("Module 'cytpes' is not installed!")
    sys.exit(0)

try:
    # Project/dist/lib/liblibrary.so
    LIBRARY_NAME = "liblibrary.so"
    LIBRARY_PATH = "../../../dist/lib" 
    lib = cdll.LoadLibrary(f'{LIBRARY_PATH}/{LIBRARY_NAME}')
except OSError:
    print(f"File '{LIBRARY_NAME}' not found!")
    sys.exit(0)
    

def path():
    
    try:
        lib.path.restype = ctypes.c_char_p 
    
        c_string_ptr = lib.path()
    
        py_string = c_string_ptr.decode('utf-8')
    
        print("Test Python with Ctypes  ...");
        print(f"{py_string}")
        
    except OSError as e:
        print(f"[ERROR] : {e}")


if __name__ == '__main__':
    path()
