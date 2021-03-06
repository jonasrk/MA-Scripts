#!/bin/bash
echo "Bash version ${BASH_VERSION}..."

logfolder=$1
platforms=spark,java,basic-graph,java-graph,spark-graph

for props in benchmark-thor.properties # rheem-benchmark-aggresive-reopt.properties 
do
	properties=$props
	echo $properties

	base_command="timeout --kill-after=1m 48m java -Xmx8g -cp /home/jonas.kemper/rheem-benchmark/target/*:/opt/spark/spark-1.6.3_2.11/assembly/target/scala-2.11/spark-assembly-1.6.3-hadoop2.6.0.jar:/home/jonas.kemper/.m2/repository/de/hpi/isg/profiledb-store/0.1.2-SNAPSHOT/*:/home/jonas.kemper/.m2/repository/de/hpi/isg/profiledb-instrumentation/0.1.2-SNAPSHOT/*:/home/jonas.kemper/rheem/rheem-distro/target/rheem-distro_2.11-0.3.1-SNAPSHOT.jar:/home/jonas.kemper/rheem/rheem-distro/target/rheem-distro_2.11-0.3.1-SNAPSHOT-distro/rheem-distro_2.11-0.3.1-SNAPSHOT/* -Drheem.configuration=file:/home/jonas.kemper/MA-Scripts/$properties -Dorg.slf4j.simpleLogger.defaultLogLevel=debug -Dlog4j.configuration=file:/home/jonas.kemper/log4j.properties -Dorg.slf4j.simpleLogger.log.org.qcri.rheem.core.util.JuelUtils$JuelFunction=debug -Dorg.slf4j.simpleLogger.log.org.qcri.rheem.core.optimizer.DefaultOptimizationContext=debug -Dorg.slf4j.simpleLogger.log.org.apache.spark=debug -Dorg.slf4j.simpleLogger.log.org.qcri.rheem.core.api.Job=debug org.qcri.rheem.apps."
	
	echo "TPC-H"
	for filename in #0_01 0_1 0_5 1 2 5 10 20 50 100
		do
		echo $filename
		for query in Q3File #Q3Hybrid Q1 Q3
		do
			echo $query
			date
			this_command="tpch.TpcH 'exp(KMeans-$filename-$properties)' $platforms hdfs://thor01/data/csv/TPC-H/tpch_props_$filename.txt $query 0.2 2>&1 | gzip > /home/jonas.kemper/$logfolder/TpcH-$filename-$query-$properties.gz"
			eval "$base_command$this_command"
			sleep 5
		done
	done
	
	echo "KMeans"
	for filename in #5GB.csv 500MB.csv 4GB.csv 3GB.csv 2GB.csv 250MB.csv 1MB.csv 1GB.csv 125MB.csv 10MB.csv 
		do
		path=hdfs://thor01/data/csv/kmeans-generator/2d-
		input_file=$path$filename
		date
		echo $input_file
		this_command="kmeans.Kmeans 'exp(KMeans-$filename-$properties)' $platforms $input_file 20 100 2>&1 | gzip > /home/jonas.kemper/$logfolder/KMeans-$filename-$properties.gz"
		eval "$base_command$this_command"
		sleep 5
	done

	echo "SGD"
	for filename in #0.01m 0.1m 0.5m 1m 1250k 1500k 2m 3m 4m
		do
		path=hdfs://thor01/data/HIGGS/higgs-train-
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
	for filename in #0_0625 #0_125 0_25 0_5 2 4 8
		do
		path=hdfs://thor01/data/text/dbpedia/dbpedia-2016-04/long_abstracts_en.
		input_file=$path$filename.txt
		echo $input_file
		date
		this_command="simwords.SimWords 'exp(SimWords-$filename-$properties)' $platforms $input_file 5 5 5 5 2>&1 | gzip > /home/jonas.kemper/$logfolder/SimWords-$filename-$properties.gz"
		eval "$base_command$this_command"
		sleep 5
	done
	
	echo "Wordcount"
	for filename in 0_0625 0_125 0_25 0_5 2 4 8
		do
		path=hdfs://thor01/data/text/dbpedia/dbpedia-2016-04/long_abstracts_en.
		input_file=$path$filename.txt
		echo $input_file
		date
		this_command="wordcount.WordCountScala 'exp(Wordcount-$filename-$properties)' $platforms $input_file 2>&1 | gzip > /home/jonas.kemper/$logfolder/Wordcount-$filename-$properties.gz"
		eval "$base_command$this_command"
		sleep 5
	done
	
	echo "SINDY"
	for filename in 0_01 0_1 0_5 1 2 5 10 20 50 100
		do
		l_path=hdfs://thor01/data/csv/TPC-H/sf$filename
		l_path2=/lineitem.tbl
		l_input_file=$l_path$l_path2
		echo $l_input_file
		o_path2=/orders.tbl
		o_input_file=$l_path$o_path2
		echo $o_input_file
		date
		this_command="sindy.Sindy 'exp(SINDY-$filename-$properties)' $platforms , '$l_input_file;$o_input_file' 2>&1 | gzip > /home/jonas.kemper/$logfolder/SINDY-$filename-$properties.gz"
		eval "$base_command$this_command"
		sleep 5
	done
done	
