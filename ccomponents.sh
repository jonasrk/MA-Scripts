#!/bin/bash

echo "Bash version ${BASH_VERSION}..."

points_file=hdfs://tenemhead2/data/rdf/dbpedia/dbpedia-2015/page-links-en-uris_de.sample_100k.nt

echo $points_file



j=100k.nt


time java -cp target/rheemstudy-1.0-SNAPSHOT.jar:/home/jonas.kemper/rheem/rheem-distro/target/rheem-distro-0.4.0-SNAPSHOT.jar:/home/jonas.kemper/rheem/rheem-distro/target/rheem-distro-0.4.0-SNAPSHOT-distro/rheem-distro-0.4.0-SNAPSHOT/*:/opt/spark/spark-1.6.2-bin-hadoop2.6/lib/spark-assembly-1.6.2-hadoop2.6.0.jar  -Drheem.configuration=file:/home/jonas.kemper/rheemstudy/app.properties ConnectedComponents spark 25 $points_file  > ~/scripts/logs/ccomp_100k_iter_$j-spark.txt 2>&1

time java -cp target/rheemstudy-1.0-SNAPSHOT.jar:/home/jonas.kemper/rheem/rheem-distro/target/rheem-distro-0.4.0-SNAPSHOT.jar:/home/jonas.kemper/rheem/rheem-distro/target/rheem-distro-0.4.0-SNAPSHOT-distro/rheem-distro-0.4.0-SNAPSHOT/*:/opt/spark/spark-1.6.2-bin-hadoop2.6/lib/spark-assembly-1.6.2-hadoop2.6.0.jar  -Drheem.configuration=file:/home/jonas.kemper/rheemstudy/app.properties ConnectedComponents java 25 $points_file  > ~/scripts/logs/ccomp_100k_iter_$j-java.txt 2>&1

for i in `seq 1 1 24`
do
echo $i
date +%Y.%m.%d-%H:%M:%S 

time java -cp target/rheemstudy-1.0-SNAPSHOT.jar:/home/jonas.kemper/rheem/rheem-distro/target/rheem-distro-0.4.0-SNAPSHOT.jar:/home/jonas.kemper/rheem/rheem-distro/target/rheem-distro-0.4.0-SNAPSHOT-distro/rheem-distro-0.4.0-SNAPSHOT/*:/opt/spark/spark-1.6.2-bin-hadoop2.6/lib/spark-assembly-1.6.2-hadoop2.6.0.jar  -Drheem.configuration=file:/home/jonas.kemper/rheemstudy/app.properties ConnectedComponents mixed 25 $points_file $i  > ~/scripts/logs/ccomp_100k_iter_$j-$i.txt 2>&1

done

