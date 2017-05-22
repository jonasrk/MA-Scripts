#!/bin/bash

echo "Bash version ${BASH_VERSION}..."

for i in 300
do
echo "iterations: $i"

for filename in 3m 4m
do

path=hdfs://tenemhead2/data/HIGGS/higgs-train-
input_file=$path$filename.csv

echo "input file: $input_file"


for partial_n in 6000
do
echo "partial_n: $partial_n"

for platform in all_spark all_java mixed
do
echo "platform: $platform"

for sample_size in 1
do
echo "sample size: $sample_size"


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

date +%Y.%m.%d-%H:%M:%S 

time java -Xss10m -cp target/rheemstudy-1.0-SNAPSHOT.jar:/home/jonas.kemper/rheem/rheem-distro/target/rheem-distro-0.4.0-SNAPSHOT.jar:/home/jonas.kemper/rheem/rheem-distro/target/rheem-distro-0.4.0-SNAPSHOT-distro/rheem-distro-0.4.0-SNAPSHOT/*:/opt/spark/spark-1.6.2-bin-hadoop2.6/lib/spark-assembly-1.6.2-hadoop2.6.0.jar -Dorg.slf4j.simpleLogger.defaultLogLevel=info -Drheem.configuration=file:/home/jonas.kemper/rheemstudy/app.properties SvrgUnrolled $input_file 28 $sample_size $platform $i $partial_n $dataset_size > ~/scripts/logs/SvrgUnrolled-$i-$platform-$partial_n-log-$sample_size-$filename.txt 2>&1

done
done
done
done
done
