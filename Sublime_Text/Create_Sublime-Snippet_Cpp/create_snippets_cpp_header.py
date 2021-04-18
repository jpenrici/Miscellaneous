# -*- Mode: Python; coding: utf-8; indent-tabs-mpythoode: nil; tab-width: 4 -*-
#
# Lists classes and functions of Cpp Headers for building snipptes.
#

import re
import os
import sys

EMPTY = ""
COMMA = ','
LEFTP = '('
RIGHTP = ')'
END = "#END#"
EOL = chr(10)
SPACE = chr(32)

MODEL = """<!-- Automatically built. Update as needed! -->
<snippet>
    <description>#FUNCTION#(#PARAMS#)</description>
    <content><![CDATA[/* #COMMENT# */
#FUNCTION#(#CODE#)]]></content>
    <tabTrigger>#FUNCTION#</tabTrigger>
    <scope>source.c++</scope>
</snippet> 
"""


def load(path):
    lines = []
    try:
        f = open(path)
        lines = [line for line in f]
        f.close()
    except Exception:
        print("error: couldn't open file.")
        pass

    return lines


def save(path, text):
    try:
        path = open(path, "w")
        path.write(text)
        path.close()
    except Exception:
        print("error: cannot save " + path)
        exit(0)


def prepare(data):

    if len(data) == 0:
        print("Empty")
        return

    text = ""
    for i in range(len(data)):
        if LEFTP in data[i]:
            text += data[i].replace(EOL, EMPTY).strip()
            if RIGHTP in data[i]:
                text += END
                continue
            for j in range(i + 1, len(data)):
                if RIGHTP in data[j]:
                    text += data[j].replace(EOL, END).strip()
                    break
                text += data[j].replace(EOL, EMPTY).strip()
            i = j

    data = []
    for i in text.split(END):
        if len(i) > 0:
            if i[0] == '~':
                continue
            # Remove internal spaces, comments and blocks ...
            for e in [r'\s+', r'\/\/.*', r'\/\*.*', r'\{.*', r':+.*', r';.*']:
                for s in re.findall(e, i):
                    i = i.replace(s, SPACE)
        data += [i]

    # data = list(set(data))
    # print(data)

    snippets = []
    for i in data:
        if len(i) > 0:
            # i = 'Type Function ( Type Param, ... )'
            comment = i

            # i = [ 'Type Function', 'Type Param, ...' ]
            i = i.replace(RIGHTP, EMPTY).split(LEFTP)
            func = i[0].split(SPACE)[-1]    # Function

            params, code = EMPTY, EMPTY
            p = i[-1].split(COMMA)          # [ 'Type Param,', '...' ]
            for j in range(len(p)):
                p[j] = p[j].strip()
                if p[j].replace(SPACE, EMPTY) != EMPTY:
                    name = p[j].split(SPACE)[-1]    # [ 'Type', 'Param']
                    params += name
                    params += COMMA if j < len(p) - 1 else EMPTY
                    code += "${" + str(j) + ":/* "
                    code += name + " */}" if len(name) > 0 else "Code */}"
                    code += COMMA if j < len(p) - 1 else EMPTY          
                
            result = MODEL.replace("#FUNCTION#", func.strip(SPACE))
            result = result.replace("#PARAMS#", params.strip(SPACE))
            result = result.replace("#COMMENT#", comment.strip(SPACE))
            result = result.replace("#CODE#", code.strip(SPACE))
            snippets += [result]

    return snippets

def main():

    # Load C++ file with classes and functions
    data = load("test.h")

    # Snippets
    snippets = prepare(data)

    # Save
    for i in range(len(snippets)):
        path = "./Output/SCpp_" + str(i) + ".sublime-snippet"
        save(path, snippets[i])


if __name__ == '__main__':
    main()
