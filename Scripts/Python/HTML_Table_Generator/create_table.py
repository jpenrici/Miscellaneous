# -*- Mode: Python; coding: utf-8; indent-tabs-mpythoode: nil; tab-width: 4 -*-

'''
    Creates the structure of an HTML Table.

    Example:
        python3 create_table.py rows=3 cols=3 <outputfile.html>
        python3 create_table.py r=3 c=3 <outputfile.html>
''' 

import os, sys

DELIM   = ";"
EOL     = "\n"


def save(filename : str, text : str) -> None:
    try:
        f = open(filename, "w")
        f.write(text)
        f.close()
    except Exception:
        print("error saving " + filename + " ...")
        exit(0) 


def prepare(rows : int, cols : int) -> str:
    output = "<table>\n"
    for r in range(rows):
        temp = "<th></th>\n" if r == 0 else "<td></td>\n"
        output += "<tr>\n" + (cols * temp) + "</tr>\n"
    return output + "</table>"
        

def main(argv):
    if (len(argv) != 3):
        print ('use => python3 create_table.py rows=Number cols=Number <outputfile.html>')
        print ('    or python3 create_table.py r=Number c=Number <outputfile.html>')
        exit(0)

    filename = ""
    rows, cols = 0, 0

    try:
        for arg in argv:
            if arg[:5].upper() == "ROWS=" or arg[:2].upper() == "R=":
                rows = int((arg.split("="))[-1])
            if arg[:5].upper() == "COLS=" or arg[:2].upper() == "C=":
                cols = int((arg.split("="))[-1])
            if arg[-5::].upper() == ".HTML":
                filename = arg
    except Exception as e:
        print("Invalid values!")
        exit(0)

    if rows < 1 or cols < 1 or filename == "":
        print("Invalid values!")
        exit(0)

    print("Create empty Table with " + str(rows) + " rows and " + str(cols) + " columns ...")
    save(filename, prepare(rows, cols))
    
    print("finished.")


if __name__ == "__main__":
    # Test
    # main(["rows=3", "cols=4", "table.html"])
    # main(["r=3", "c=5", "table.html"])

    main(sys.argv[1:])
