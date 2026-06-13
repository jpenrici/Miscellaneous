#!/bin/bash
#
# This script is intended to make copying directories easier, but without
# any warranty. Study carefully before running.
# 
# Este script tem a finalidade de facilitar a cópia dos diretórios, mas sem
# qualquer garantia. Estude atentamente antes de executar.
# 

MACRO_DIR="macro_extra"
MACRO_PATH="$HOME/.config/libreoffice/4/user/Scripts/python"

echo "criar $MACRO_PATH"
mkdir -p $MACRO_PATH

echo "remove $MACRO_PATH/$MACRO_DIR"
rm -r $MACRO_PATH/$MACRO_DIR

echo "copy $MACRO_DIR -> $MACRO_PATH"
cp -r $MACRO_DIR $MACRO_PATH
