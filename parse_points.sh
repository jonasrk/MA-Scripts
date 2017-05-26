#!/bin/bash
for filename in *; do
	echo $filename
	echo $filename | grep -Po '\K[A-Z]*?(?=\.)'
	echo $filename | grep -o '[0-9]*'
	echo '00:'
	echo 'concat'
	grep elapsed $filename | grep -Po '\ .*\ \K.*?(?=elapsed)' 
	grep -Po 'Accumulated costs: \K.*?(?= \.\.)' $filename
	#grep -Po 'UnstablePoints Buffer\(\K.*?(?=\))' $filename
	grep -Po 'Buffer\(\K.*?(?=\)\))' $filename
	echo "---"
done
