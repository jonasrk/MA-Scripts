i=1

while true; do

	DAY=`date +%d`
	S="July$DAY"
	DASH="-"
	HOUR=`date +%H`
	S="$S$DASH$HOUR"
	UHR="uhr"
	MINUTE=`date +%M`
	S="$S$UHR$MINUTE"
	echo $S
	sleep 2

	M="m"
	IM="$i$M"
	echo "$IM"

	sh start_new_benchmarking_suite_run.sh generate-baseline-and-training-logs $S $IM

	i=$(($i*2))

done
