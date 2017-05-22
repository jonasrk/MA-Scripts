#!/bin/bash

echo "Bash version ${BASH_VERSION}..."

for i in 1000
do
echo "maxIterations: $i"

for filename in 0.1m 0.5m #1m 1250k 1500k 2m 3m 4m
do

path=hdfs://tenemhead2/data/HIGGS/higgs-train-
input_file=$path$filename.csv

echo "input file: $input_file"


#for partial_n in `seq 2 5 300`
#do
#echo "partial_n: $partial_n"

#for platform in all_spark all_java mixed
#do
#echo "platform: $platform"

for sample_size in 10
do
echo "sample size: $sample_size"


if [ $filename = 0.1m ]
then
dataset_size=100000
fi
if [ $filename = 0.5m ]
then
dataset_size=500000
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

#time scala -cp /home/jonas.kemper/rheem-benchmark/target/*:/opt/spark/spark-1.6.2-bin-hadoop2.6/lib/spark-assembly-1.6.2-hadoop2.6.0.jar:/home/jonas.kemper/.m2/repository/de/hpi/isg/profiledb-store/0.1.2-SNAPSHOT/*:/home/jonas.kemper/.m2/repository/de/hpi/isg/profiledb-instrumentation/0.1.2-SNAPSHOT/*:/home/jonas.kemper/rheem/rheem-distro/target/rheem-distro-0.2.2-SNAPSHOT.jar:/home/jonas.kemper/rheem/rheem-distro/target/rheem-distro-0.2.2-SNAPSHOT-distro/rheem-distro-0.2.2-SNAPSHOT/* -Drheem.configuration=file:/home/jonas.kemper/rheem-benchmark.properties -Dorg.slf4j.simpleLogger.defaultLogLevel=debug org.qcri.rheem.apps.sgd.SGD 'exp(1)' java,spark regular $input_file $dataset_size 28 $maxIterations 0.001 $sample_size

time java -Xss10m -cp /home/jonas.kemper/rheem-benchmark/target/*:/opt/spark/spark-1.6.2-bin-hadoop2.6/lib/spark-assembly-1.6.2-hadoop2.6.0.jar:/home/jonas.kemper/.m2/repository/de/hpi/isg/profiledb-store/0.1.2-SNAPSHOT/*:/home/jonas.kemper/.m2/repository/de/hpi/isg/profiledb-instrumentation/0.1.2-SNAPSHOT/*:/home/jonas.kemper/rheem/rheem-distro/target/rheem-distro-0.2.2-SNAPSHOT.jar:/home/jonas.kemper/rheem/rheem-distro/target/rheem-distro-0.2.2-SNAPSHOT-distro/rheem-distro-0.2.2-SNAPSHOT/* -Drheem.configuration=file:/home/jonas.kemper/rheem-benchmark.properties -Dorg.slf4j.simpleLogger.defaultLogLevel=debug org.qcri.rheem.apps.sgd.SGD "exp(16May_$1)" java,spark regular $input_file $dataset_size 28 $i 0.001 10

done
done
done
#done
#done
