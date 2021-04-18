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
    <content><![CDATA[#COMMENT##FUNCTION##CODE#]]></content>
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
        print("Loaded: {}".format(path))
    except Exception:
        print("error: couldn't open file.")
        pass

    return lines


def save(path, text):
    try:
        f = open(path, "w")
        f.write(text)
        f.close()
        print("Saved: {}".format(path))
    except Exception:
        print("error: cannot save " + path)
        exit(0)


def prepare(data):
    #
    # Exclusive function for preparing C++ header files.
    #
    if len(data) == 0:
        print("Empty")
        return

    # Step 1:
    # Separate lines with words in parentheses.
    #
    # Example:
    #          Words () { ... }
    #          Words ( words )
    #          Words (
    #                 words ...
    #          )
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

    # Step 2:
    # Separate potential constructors and functions.
    data = []
    for i in text.split(END):
        if len(i) > 0:
            # Exclude destructors.
            if i[0] == '~':
                continue
            # Remove internal spaces, comments and blocks ...
            for e in [r'\s+', r'\/\/.*', r'\/\*.*', r'\{.*', r':+.*', r';.*']:
                for s in re.findall(e, i):
                    i = i.replace(s, SPACE)
        data += [i]

    # Step 3:
    # Organize ... 
    data = list(set(data))

    # Step 4:
    # Analyze and prepare output.
    snippets = []
    for i in data:
        if len(i) > 0:
            # i = 'Type Function ( Type Param, ... )'
            comment = "/* " + i + " */" + EOL

            # i = [ 'Type Function', 'Type Param, ...' ]
            i = i.replace(RIGHTP, EMPTY).split(LEFTP)
            func = i[0].split(SPACE)[-1]    # 'Function'

            code = LEFTP
            params = EMPTY
            p = i[-1].split(COMMA)          # [ 'Type Param', '...' ]
            for j in range(len(p)):
                p[j] = p[j].strip()
                if p[j].replace(SPACE, EMPTY) == EMPTY:
                    # Format: Word ()
                    code = "${0:/* Code or () */}"
                    params = EMPTY
                    comment = EMPTY
                else:
                    # Format: Word (word, word, ...)
                    name = p[j].split(SPACE)[-1]    # [ 'Type', 'Param' ]
                    params += name
                    params += COMMA if j < len(p) - 1 else EMPTY
                    code += "${" + str(j + 1) + ":/* "
                    code += name + " */}" if len(name) > 0 else "Code */}"
                    code += COMMA if j < len(p) - 1 else RIGHTP          

            # Model
            result = MODEL.replace("#FUNCTION#", func.strip(SPACE))
            result = result.replace("#PARAMS#", params.strip(SPACE))
            result = result.replace("#COMMENT#", comment.strip(SPACE))
            result = result.replace("#CODE#", code.strip(SPACE))

            # Output
            snippets += [
                {'name': func, 'function': comment, 'snippet': result}
            ]

    return snippets


def test():

    print("Script initialized.")

    # Load C++ file with classes and functions
    data = load("test.h")

    # Snippets
    snippets = prepare(data)

    # Save
    csv = "Name;Path;Function;Number" + EOL
    for i in range(len(snippets)):
        name = snippets[i]['name']
        func = snippets[i]['function']
        snippet = snippets[i]['snippet']
        path = "./Output/SCpp{:02d}_{}.sublime-snippet".format(i, name)
        
        csv += "{};{};{};{} {}".format(name, func, path, i, EOL)
        save(path, snippet)
        # print(snippet)

    save("output_snippets.csv", csv)
    # print(csv)

    print("Script finished.")


if __name__ == '__main__':
    test()
