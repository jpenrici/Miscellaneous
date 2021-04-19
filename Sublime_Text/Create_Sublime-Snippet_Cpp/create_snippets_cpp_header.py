# -*- Mode: Python3; coding: utf-8; indent-tabs-mpythoode: nil; tab-width: 4 -*-
#
# Lists classes and functions of Cpp Headers for building snippets.
#

import re
import os
import sys

EMPTY = ""
COMMA = ','
END = "#END#"
EOL = chr(10)
SPACE = chr(32)
LPARENTHESES = '('
RPARENTHESES = ')'

MODEL = """<!-- Automatically built. Update as needed! -->
<snippet>
    <description>#FUNCTION#(#PARAMS#)</description>
    <content><![CDATA[#COMMENT##CODE#]]></content>
    <tabTrigger>#TRIGGER#</tabTrigger>
    <scope>source.c++</scope>
</snippet> 
"""

# Enable comment insertion in the snippet.
# Example:
#   /* Type Function ( Type Param, ... ) */
insert_comment = True

# Inclusion of a general identifier.
# Example:
#   snippet_id = 'App_Test'
# Result:
#   #FUNCTION#(#PARAMS#)  ==>  'App_Test Function(Params)'
snippet_id = EMPTY


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
    global insert_comment, snippet_id

    if len(data) == 0:
        print("Empty.")
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
    text = EMPTY
    for i in range(len(data)):
        if LPARENTHESES in data[i]:
            text += data[i].replace(EOL, EMPTY).strip()
            if RPARENTHESES in data[i]:
                text += END
                continue
            for j in range(i + 1, len(data)):
                if RPARENTHESES in data[j]:
                    text += data[j].replace(EOL, END).strip()
                    break
                text += data[j].replace(EOL, EMPTY).strip()
            i = j

    # Step 2:
    # Separate constructors and functions.
    data = []
    for i in text.split(END):
        if len(i) > 0:
            # Exclude destructors.
            if i[0] == '~':
                continue
            # Remove Regex ...
            expr = [
                r'\s+',        # spaces
                r'\/\/.*',     # comment
                r'\/\*.*',     # comment
                r'\s*\{.*',    # block
                r':+.*',       # constructor
                r';.*',        # end line
                r'operator.*'  # overload
            ]
            for e in expr:
                for s in re.findall(e, i):
                    i = i.replace(s, SPACE)
        data += [i]

    # Step 3:
    # Organize ... 
    data = list(set(data))

    # Step 4:
    # Analyze and prepare output.
    snippets = []
    for item in data:
        if len(item) > 0:
            # item = 'Type Function ( Type Param, ... )'
            comment = "/* " + item + " */" + EOL
            expr = item

            # item = [ 'Type Function', 'Type Param, ...' ]
            item = item.replace(RPARENTHESES, EMPTY).split(LPARENTHESES)
            func = item[0].split(SPACE)[-1]           # 'Function'
            if len(func) == 0:
                continue

            params = EMPTY
            code = LPARENTHESES
            param = item[-1].split(COMMA)             # [ 'Type Param', '...' ]
            for i in range(len(param)):
                param[i] = param[i].strip()
                if param[i].replace(SPACE, EMPTY) == EMPTY:
                    # Format: Word ()
                    params = EMPTY
                    code = "${0:/* Code or () */}"
                else:
                    # Format: Word (word, word, ...)
                    name = param[i].split(SPACE)[-1]  # [ 'Type', 'Param' ]
                    params += name
                    params += COMMA if i < len(param) - 1 else EMPTY
                    code += "${" + str(i + 1) + ":/* "
                    code += name + " */}" if len(name) > 0 else "Code */}"
                    code += COMMA if i < len(param) - 1 else RPARENTHESES

            # Global details
            name = func
            code = func + code
            func = snippet_id + SPACE + func
            comment = comment if insert_comment else EMPTY

            # Model
            result = MODEL.replace("#FUNCTION#", func.strip(SPACE))
            result = result.replace("#PARAMS#", params.strip(SPACE))
            result = result.replace("#COMMENT#", comment.strip(SPACE))
            result = result.replace("#CODE#", code.strip(SPACE))
            result = result.replace("#TRIGGER#", name.strip(SPACE))

            # Output
            snippets += [{'name': name, 'function': expr, 'snippet': result}]

    return snippets


def create(path_cppheader, directory_snippet=EMPTY, identifier=EMPTY,
    comment=True):

    global insert_comment, snippet_id
    insert_comment = comment
    snippet_id = identifier

    print("Script initialized.")

    # Load C++ file with classes and functions
    data = load(path_cppheader)
    if len(data) == 0:
        print("File empty.")
        return

    # Snippets
    snippets = prepare(data)
    if len(snippets) == 0:
        print("Nothing to do.")
        return

    # Save
    directory = "./Output" if directory_snippet == EMPTY else directory_snippet
    extension = ".sublime-snippet"
    if not os.path.exists(directory):
        print("Create " + directory)
        os.makedirs(directory)
    else:
        filelist = [f for f in os.listdir(directory) if f.endswith(extension)]
        for f in filelist:
            if f[:4] == "SCpp":
                print("Remove " + f)
                os.remove(os.path.join(directory, f))

    csv = "Name;Function;Path;Number" + EOL
    for i in range(len(snippets)):
        name = snippets[i]['name']
        func = snippets[i]['function']
        snippet = snippets[i]['snippet']
        fname = (snippet_id + name[0].upper() + name[1:]).replace(SPACE, EMPTY)
        path = "{}/SCpp{:02d}_{}{}".format(directory, i, fname, extension)
        csv += "{};{};{};{} {}".format(name, func, path, i, EOL)
        save(path, snippet)
        # print(snippet)

    save("output_snippets.csv", csv)
    # print(csv)

    print("Script finished.")


if __name__ == '__main__':
    # Test
    create(path_cppheader="test.h", identifier="Test")
