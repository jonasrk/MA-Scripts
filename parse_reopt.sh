for filename in *
	do
		IFS='-' read -ra ADDR <<< $filename
		for i in "${ADDR[@]}" 
			do
		    		 echo $i
			done
		zgrep "* Execution" $filename | head -1 | sed -e 's/^.*- //g'
	done
