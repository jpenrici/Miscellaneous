#!/bin/bash
# Copia pacotes Deb instalados para um arquivo tipo texto (lista),
# para posterior necessidade de recuperação ou comparação.

echo ""
echo "Packages..."
echo ""

data=$(date +%Y-%m-%d)
output="package_list_bkp-$data"
list_package=$(dpkg --get-selections)

#touch $output

echo "# dpkg --get-selections > $output" > $output
echo "# Packages:" >> $output
echo "-------------------------------" >> $output
echo "$list_package" >> $output
echo "-------------------------------" >> $output

cat $output

sleep 4
echo "exit ..."
exit 0