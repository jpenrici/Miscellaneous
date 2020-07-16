#!/bin/bash

# diretório local
local="$PWD/contents.py"
saida="directory_contents.txt"

# subindo nível
cd ../..
ls

# python3 contents.py type="tipo" path="caminho" header="False/True"
python3 $local path="Algorithms" header=False > $saida
python3 $local path="Cpp" header=False >> $saida
python3 $local path="OpenBox" header=False  >> $saida
python3 $local path="Python" header=False >> $saida
python3 $local path="Sublime_Text" header=False >> $saida
python3 $local path="VBA" header=False >> $saida

echo ""
cat $saida