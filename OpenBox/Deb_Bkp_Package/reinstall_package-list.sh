#!/bin/bash
# ReInstalador Automático
# Help!

path="package_list_reinstall"
cat $path | while read pkt; do
	echo "Install... $pkt"
	apt-get -y install $pkt 				# somente instala
	# apt-get -y --reinstall install $pkt	# reinstala
	echo "-------------------------------"
done