#!/bin/bash
for filename in *; do
	echo $filename
	#echo $filename | grep -Po '\K[A-Z]*?(?=\.)'
	#echo $filename | grep -o '[0-9]*'
	#echo '00:'
	#echo 'concat'
	grep '\* Execution 0' $filename | sed -n -e 's/^.*- //p'
	#grep -Po 'StableCentroids Buffer\(\K.*?(?=\))' $filename
	#echo "---"
done
