# -*- Mode: Python; coding: utf-8; indent-tabs-mpythoode: nil; tab-width: 4 -*-

'''
    Simple CSV to HTML Table conversion.

    use:
        python3 csv2table.py <inputfile.csv> <outputfile.html>
''' 

import os, sys

DELIM   = ";"
EOL     = "\n"

# Templates
TABLE   = "<table>" + EOL + "#value#</table>" + EOL
ROW     = "<tr>"    + EOL + "#value#</tr>"    + EOL
HEADER  = "<th>#value#</th>" + EOL
CONTENT = "<td>#value#</td>" + EOL


def csv(filename : str, text_coding='UTF-8') -> list[str]:
    data = []
    try:
        if os.path.exists(filename):
            print(filename + " ok ...")
            with open(filename, encoding=text_coding) as f:
                for line in f:
                    data += [line.replace("\n","")]
        else:
            print(filename + " not found ...")
            exit(0)
    except:
        print("unexpected error:", sys.exc_info()[0])
        raise
    return data


def save(filename : str, text : str) -> None:
    try:
        f = open(filename, "w")
        f.write(text)
        f.close()
    except Exception:
        print("error saving " + filename + " ...")
        exit(0) 


def prepare(data : list[str]) -> str:
    output = ""
    for i in range(0, len(data)):
        values = ""
        items = data[i].split(DELIM)
        template = HEADER if i == 0 else CONTENT
        for item in items:
            values += template.replace("#value#", item)
        output += ROW.replace("#value#", values)
    return TABLE.replace("#value#", output)


def csv2table(filename_csv : str, filename_html : str) -> None:
    data = csv(filename_csv)
    if (len(data) > 0):
        output = prepare(data)
        save(filename_html, output)
        print("check " + filename_html)
    else:
        print(filename_csv + " empty")


def main(argv):
    if (len(argv) != 2):
        print ('use => python3 csv2table.py <inputfile.csv> <outputfile.html>')
        exit(0)
    if (argv[0][-3::].upper() != "CSV"):
        print(argv[0] + ": wrong extension")
        exit(0)
    csv2table(argv[0], argv[1])
    print("finished.")


if __name__ == "__main__":
    # Test
    # main(["table.csv", "table.html"])

    main(sys.argv[1:])
