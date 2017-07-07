#!/bin/bash
echo "Bash version ${BASH_VERSION}..."

logfolder=$1
exec_mode=$2
timeout_after=$3
properties_file=$4

platforms=spark,java,basic-graph,java-graph,spark-graph

for props in $properties_file # rheem-benchmark-aggresive-reopt.properties 
do
	properties=$props
	echo $properties

	base_command="timeout --kill-after=1m timeout_after java -Xmx8g -cp /home/jonas.kemper/rheem-benchmark/target/*:/opt/spark/spark-1.6.3_2.11/assembly/target/scala-2.11/spark-assembly-1.6.3-hadoop2.6.0.jar:/home/jonas.kemper/.m2/repository/de/hpi/isg/profiledb-store/0.1.2-SNAPSHOT/*:/home/jonas.kemper/.m2/repository/de/hpi/isg/profiledb-instrumentation/0.1.2-SNAPSHOT/*:/home/jonas.kemper/rheem/rheem-distro/target/rheem-distro_2.11-0.3.1-SNAPSHOT.jar:/home/jonas.kemper/rheem/rheem-distro/target/rheem-distro_2.11-0.3.1-SNAPSHOT-distro/rheem-distro_2.11-0.3.1-SNAPSHOT/* -Drheem.configuration=file:/home/jonas.kemper/MA-Scripts/$properties -Dorg.slf4j.simpleLogger.defaultLogLevel=debug -Dlog4j.configuration=file:/home/jonas.kemper/log4j.properties -Dorg.slf4j.simpleLogger.log.org.qcri.rheem.core.util.JuelUtils$JuelFunction=debug -Dorg.slf4j.simpleLogger.log.org.qcri.rheem.core.optimizer.DefaultOptimizationContext=debug -Dorg.slf4j.simpleLogger.log.org.apache.spark=debug -Dorg.slf4j.simpleLogger.log.org.qcri.rheem.core.api.Job=debug org.qcri.rheem.apps."
	
    
if [ $exec_mode = "validation" ]; then
    
	echo "TPC-H"
	for filename in 100 20 5 1 0_1
		do
		echo $filename
		for query in Q3File #Q3Hybrid Q1 Q3
		do
			echo $query
			date
			this_command="tpch.TpcH 'exp(KMeans-$filename-$properties)' $platforms hdfs://thor01/data/csv/TPC-H/tpch_props_$filename.txt $query 0.2 2>&1 | gzip > /home/jonas.kemper/$logfolder/TpcH-$filename-$query-$properties.gz"
			eval "$base_command$this_command"
			#sleep 1
		done
	done
	
	echo "KMeans"
	for filename in 500MB.csv 3GB.csv 1GB.csv 125MB.csv 10MB.csv
		do
		path=hdfs://thor01/data/csv/kmeans-generator/2d-
		input_file=$path$filename
		date
		echo $input_file
		this_command="kmeans.Kmeans 'exp(KMeans-$filename-$properties)' $platforms $input_file 20 100 2>&1 | gzip > /home/jonas.kemper/$logfolder/KMeans-$filename-$properties.gz"
		eval "$base_command$this_command"
		#sleep 1
	done
	
	echo "SimWords"
	for filename in 0_0625 #0_125 0_25 0_5 2 4 8
		do
		path=hdfs://thor01/data/text/dbpedia/dbpedia-2016-04/long_abstracts_en.
		input_file=$path$filename.txt
		echo $input_file
		date
		this_command="simwords.SimWords 'exp(SimWords-$filename-$properties)' $platforms $input_file 5 5 5 5 2>&1 | gzip > /home/jonas.kemper/$logfolder/SimWords-$filename-$properties.gz"
		eval "$base_command$this_command"
		#sleep 1
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
		#sleep 1
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
		#sleep 1
	done

	echo "CrocoPR"
	for filename in page_links_en_uris_de-0_01.ttl page_links_en-0_125.ttl page_links_en-0_25.ttl page_links_en_uris_de.ttl page_links_en_uris_fr.ttl page_links_en_uris_pt.ttl page_links_en_uris_de-0_5.ttl
		do
		l_path=hdfs://thor01/data/rdf/dbpedia/dbpedia-2016-04/
		l_input_file=$l_path$filename
		echo $l_input_file
		o_path2=page_links_en_uris_de-0_001.ttl
		o_input_file=$l_path$o_path2
		echo $o_input_file
		date
		this_command="crocopr.CrocoPR 'exp(SINDY-$filename-$properties)' $platforms $l_input_file $o_input_file 3 2>&1 | gzip > /home/jonas.kemper/$logfolder/CrocoPR-$filename-$properties.gz"
		eval "$base_command$this_command"
		#sleep 1
	done

fi


if [ $exec_mode = "training" ]; then
    
	echo "TPC-H"
	for filename in 0_01 0_5 2 10 50
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
	for filename in 5GB.csv 4GB.csv 2GB.csv 1MB.csv 250MB.csv
		do
		path=hdfs://thor01/data/csv/kmeans-generator/2d-
		input_file=$path$filename
		date
		echo $input_file
		this_command="kmeans.Kmeans 'exp(KMeans-$filename-$properties)' $platforms $input_file 20 100 2>&1 | gzip > /home/jonas.kemper/$logfolder/KMeans-$filename-$properties.gz"
		eval "$base_command$this_command"
		sleep 5
	done
	
	echo "Wordcount"
	for filename in x
		do
		path=hdfs://thor01/data/csv/CENSUS/CENSUS.csv
		input_file=$path
		echo $input_file
		date
		this_command="wordcount.WordCountScala 'exp(Wordcount-$filename-$properties)' $platforms $input_file 2>&1 | gzip > /home/jonas.kemper/$logfolder/Wordcount-$filename-$properties.gz"
		eval "$base_command$this_command"
		sleep 5
	done
	
	echo "SINDY"
	for filename in x
		do
		l_path=hdfs://thor01/data/csv/WIKIPEDIA
		l_path2=/IMAGELINKS.csv
		l_input_file=$l_path$l_path2
		echo $l_input_file
		o_path2=/IMAGE.csv
		o_input_file=$l_path$o_path2
		echo $o_input_file
		date
		this_command="sindy.Sindy 'exp(SINDY-$filename-$properties)' $platforms , '$l_input_file;$o_input_file' 2>&1 | gzip > /home/jonas.kemper/$logfolder/SINDY-$filename-$properties.gz"
		eval "$base_command$this_command"
		sleep 5
	done

	echo "CrocoPR"
	for filename in page_links_en-0_5.ttl page_links_en.ttl page_links_en_uris_de-0_001.ttl page_links_en_uris_de-0_01.ttl page_links_en_uris_de-0_125.ttl page_links_en_uris_de-0_25.ttl page_links_en_uris_de.ttl page_links_en_uris_fr.ttl page_links_en_uris_pt.ttl 
		do
		l_path=hdfs://thor01/data/rdf/dbpedia/dbpedia-2016-04/
		l_input_file=$l_path$filename
		echo $l_input_file
		o_path2=page_links_en_uris_de-0_001.ttl
		o_input_file=$l_path$o_path2
		echo $o_input_file
		date
		this_command="crocopr.CrocoPR 'exp(SINDY-$filename-$properties)' $platforms $l_input_file $o_input_file 3 2>&1 | gzip > /home/jonas.kemper/$logfolder/CrocoPR-$filename-$properties.gz"
		eval "$base_command$this_command"
		#sleep 1
	done

fi

done