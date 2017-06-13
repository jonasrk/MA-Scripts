#!/bin/bash
echo "Bash version ${BASH_VERSION}..."

logfolder=suite-logs-neu
platforms=spark,java

for props in benchmark.properties # rheem-benchmark-aggresive-reopt.properties 
do
	properties=$props
	echo $properties

	base_command="timeout --kill-after 1m 30m time java -Xmx8g -cp /home/jonas.kemper/rheem-benchmark/target/*:/opt/spark/spark-1.6.2-bin-hadoop2.6/lib/spark-assembly-1.6.2-hadoop2.6.0.jar:/home/jonas.kemper/.m2/repository/de/hpi/isg/profiledb-store/0.1.2-SNAPSHOT/*:/home/jonas.kemper/.m2/repository/de/hpi/isg/profiledb-instrumentation/0.1.2-SNAPSHOT/*:/home/jonas.kemper/rheem/rheem-distro/target/rheem-distro_2.11-0.3.1-SNAPSHOT.jar:/home/jonas.kemper/rheem/rheem-distro/target/rheem-distro_2.11-0.3.1-SNAPSHOT-distro/rheem-distro_2.11-0.3.1-SNAPSHOT/* -Drheem.configuration=file:/home/jonas.kemper/rheem-benchmark/$properties -Dorg.slf4j.simpleLogger.defaultLogLevel=debug -Dlog4j.configuration=file:/home/jonas.kemper/log4j.properties -Dorg.slf4j.simpleLogger.log.org.qcri.rheem.core.util.JuelUtils$JuelFunction=debug -Dorg.slf4j.simpleLogger.log.org.qcri.rheem.core.optimizer.DefaultOptimizationContext=debug -Dorg.slf4j.simpleLogger.log.org.apache.spark=debug -Dorg.slf4j.simpleLogger.log.org.qcri.rheem.core.api.Job=debug org.qcri.rheem.apps."
	
	echo "TPC-H"
	for filename in #tpch-10g.properties tpch-5g.properties tpch.properties
	do
		echo $filename
		for query in Q3File #Q3Hybrid Q1 Q3
		do
			echo $query
			date
			this_command="tpch.TpcH 'exp(KMeans-$filename-$properties)' $platforms hdfs://tenemhead2/data/$filename $query 0.2 2>&1 | gzip > /home/jonas.kemper/$logfolder/TpcH-$filename-$query-$properties.gz"
			eval "$base_command$this_command"
			sleep 5
		done
	done
	
	echo "KMeans"
	for filename in #1k 10k 100k 1m 5m 10m
		do
		path=hdfs://tenemhead2/data/2dpoints/kmeans_points_
		input_file=$path$filename.txt
		date
		echo $input_file
		this_command="kmeans.Kmeans 'exp(KMeans-$filename-$properties)' $platforms $input_file 20 100 2>&1 | gzip > /home/jonas.kemper/$logfolder/KMeans-$filename-$properties.gz"
		eval "$base_command$this_command"
		sleep 5
	done

	echo "SGD"
	for filename in #0.01m 0.1m 0.5m 1m 1250k 1500k 2m 3m 4m
		do
		path=hdfs://tenemhead2/data/HIGGS/higgs-train-
		input_file=$path$filename.csv
		echo $input_file
	 	date	
		if [ $filename = 0.01m ]
		then
		dataset_size=10000
		fi
		if [ $filename = 0.1m ]
		then
		dataset_size=100000
		fi
		if [ $filename = 1m ]
		then
		dataset_size=1000000
		fi
		if [ $filename = 1250k ]
		then
		dataset_size=1250000
		fi
		if [ $filename = 1500k ]
		then
		dataset_size=1500000
		fi
		if [ $filename = 2m ]
		then
		dataset_size=2000000
		fi
		if [ $filename = 3m ]
		then                 
		dataset_size=3000000 
		fi                   
		if [ $filename = 4m ]
		then                 
		dataset_size=4000000 
		fi                   
		echo "dataset size: $dataset_size"
		this_command="sgd.SGD 'exp(SGD-$filename-$properties)' $platforms regular $input_file $dataset_size 28 100 0.001 10 2>&1 | gzip > /home/jonas.kemper/$logfolder/SGD-$filename-$properties.gz"
		eval "$base_command$this_command"
		sleep 5
	done
	
	echo "SimWords"
	for filename in 01pc #2pc 3pc
		do
		path=hdfs://tenemhead2/data/text/dbpedia-2015-10/long_abstracts_en_
		input_file=$path$filename.txt
		echo $input_file
		date
		this_command="simwords.SimWords 'exp(SimWords-$filename-$properties)' $platforms $input_file 5 5 5 5 2>&1 | gzip > /home/jonas.kemper/$logfolder/SimWords-$filename-$properties.gz"
		eval "$base_command$this_command"
		sleep 5
	done
	
	echo "Wordcount"
	for filename in 01pc 2pc 3pc 10pc 25pc 50pc
		do
		path=hdfs://tenemhead2/data/text/dbpedia-2015-10/long_abstracts_en_
		input_file=$path$filename.txt
		echo $input_file
		date
		this_command="wordcount.WordCountScala 'exp(Wordcount-$filename-$properties)' $platforms $input_file 2>&1 | gzip > /home/jonas.kemper/$logfolder/Wordcount-$filename-$properties.gz"
		eval "$base_command$this_command"
		sleep 5
	done
	
	echo "SINDY"
	for filename in .tbl -10G.tbl
		do
		l_path=hdfs://tenemhead2/data/TPC-H/lineitem
		l_input_file=$l_path$filename
		echo $l_input_file
		o_path=hdfs://tenemhead2/data/TPC-H/orders
		o_input_file=$o_path$filename
		echo $o_input_file
		date
		this_command="sindy.Sindy 'exp(SINDY-$filename-$properties)' $platforms , '$l_input_file;$o_input_file' 2>&1 | gzip > /home/jonas.kemper/$logfolder/SINDY-$filename-$properties.gz"
		eval "$base_command$this_command"
		sleep 5
	done
done	
