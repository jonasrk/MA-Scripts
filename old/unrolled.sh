#!/bin/bash

echo "Bash version ${BASH_VERSION}..."

points_file=hdfs://tenemhead2/data/2dpoints/kmeans_points_100k.txt
iterations=60

echo $iterations
echo $points_file

for j in 30centroids5.txt 30centroids4.txt 30centroids3.txt 30centroids2.txt 30centroids1.txt
do
echo $j

echo "spark"
date +%Y.%m.%d-%H:%M:%S 
time java -cp target/rheemstudy-1.0-SNAPSHOT.jar:/home/jonas.kemper/rheem/rheem-distro/target/rheem-distro-0.4.0-SNAPSHOT.jar:/home/jonas.kemper/rheem/rheem-distro/target/rheem-distro-0.4.0-SNAPSHOT-distro/rheem-distro-0.4.0-SNAPSHOT/*:/opt/spark/spark-1.6.2-bin-hadoop2.6/lib/spark-assembly-1.6.2-hadoop2.6.0.jar  -Drheem.configuration=file:/home/jonas.kemper/rheemstudy/app.properties  kmeansUnrolled spark $iterations 0.0000001 $points_file hdfs://tenemhead2/data/2dpoints/$j -1  > ~/scripts/logs/spark_$j.txt 2>&1

echo "java"
date +%Y.%m.%d-%H:%M:%S 
time java -cp target/rheemstudy-1.0-SNAPSHOT.jar:/home/jonas.kemper/rheem/rheem-distro/target/rheem-distro-0.4.0-SNAPSHOT.jar:/home/jonas.kemper/rheem/rheem-distro/target/rheem-distro-0.4.0-SNAPSHOT-distro/rheem-distro-0.4.0-SNAPSHOT/*:/opt/spark/spark-1.6.2-bin-hadoop2.6/lib/spark-assembly-1.6.2-hadoop2.6.0.jar  -Drheem.configuration=file:/home/jonas.kemper/rheemstudy/app.properties  kmeansUnrolled java $iterations 0.0000001 $points_file hdfs://tenemhead2/data/2dpoints/$j -1 > ~/scripts/logs/java_$j.txt 2>&1

for i in `seq 1 2 24`
do
echo $i
date +%Y.%m.%d-%H:%M:%S 

time java -cp target/rheemstudy-1.0-SNAPSHOT.jar:/home/jonas.kemper/rheem/rheem-distro/target/rheem-distro-0.4.0-SNAPSHOT.jar:/home/jonas.kemper/rheem/rheem-distro/target/rheem-distro-0.4.0-SNAPSHOT-distro/rheem-distro-0.4.0-SNAPSHOT/*:/opt/spark/spark-1.6.2-bin-hadoop2.6/lib/spark-assembly-1.6.2-hadoop2.6.0.jar  -Drheem.configuration=file:/home/jonas.kemper/rheemstudy/app.properties  kmeansUnrolled mixed $iterations 0.0000001 $points_file hdfs://tenemhead2/data/2dpoints/$j $i  > ~/scripts/logs/mixed_$j-m$i-.txt 2>&1

done

done
