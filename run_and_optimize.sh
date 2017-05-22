#!/bin/bash
echo "Bash version ${BASH_VERSION}..."
i=0
while true
do
echo $i
i=$((i+1))

sh /home/jonas.kemper/scripts/SGDexp.sh $i

java -cp /home/jonas.kemper/rheem/rheem-distro/target/rheem-distro-0.2.2-SNAPSHOT.jar:/home/jonas.kemper/rheem/rheem-distro/target/rheem-distro-0.2.2-SNAPSHOT-distro/rheem-distro-0.2.2-SNAPSHOT/*:/opt/spark/spark-1.6.2-bin-hadoop2.6/lib/spark-assembly-1.6.2-hadoop2.6.0.jar -Drheem.configuration=file:/home/jonas.kemper/rheem-benchmark.properties org.qcri.rheem.profiler.log.GeneticOptimizerApp | tee ~/costFunctions_May16_$i-auto.txt

sed -i.bak -e '7,1000d' ~/rheem-benchmark.properties 

j=`grep -nr ================== ~/costFunctions_May16_$i-auto.txt   | tail -1 | egrep -o '^[^:]+'`
j=$((j+1))

l=`wc -l ~/costFunctions_May16_$i-auto.txt | egrep -o '^[^ ]+'`
l=$((l-1))
sed -n "$j, $l p" ~/costFunctions_May16_$i-auto.txt  >> ~/rheem-benchmark.properties 

sleep 5

done
