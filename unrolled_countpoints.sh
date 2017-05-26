#!/bin/bash

echo "Bash version ${BASH_VERSION}..."

for j in 30centroids2.txt 30centroids3.txt 30centroids4.txt 30centroids5.txt
do
echo $j

for i in `seq 1 25`
do

echo $i
date +%Y.%m.%d-%H:%M:%S 
time java -cp target/rheemstudy-1.0-SNAPSHOT.jar:/home/jonas.kemper/rheem/rheem-distro/target/rheem-distro-0.4.0-SNAPSHOT.jar:/home/jonas.kemper/rheem/rheem-distro/target/rheem-distro-0.4.0-SNAPSHOT-distro/rheem-distro-0.4.0-SNAPSHOT/*:/opt/spark/spark-1.6.2-bin-hadoop2.6/lib/spark-assembly-1.6.2-hadoop2.6.0.jar  -Drheem.configuration=file:/home/jonas.kemper/rheemstudy/app.properties  kmeansUnrolled spark -1 30 $i 0.001 hdfs://tenemhead2/data/2dpoints/kmeans_points_1m.txt hdfs://tenemhead2/data/2dpoints/$j  > ~/scripts/logs/spark-count-points_$j-$i.txt 2>&1


done
done
