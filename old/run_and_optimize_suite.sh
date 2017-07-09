#!/bin/bash
echo "Bash version ${BASH_VERSION}..."
i=0
while true
do
echo $i
i=$((i+1))

sh /home/jonas.kemper/MA-Scripts/reoptimizer_benchmark_suite.sh
sh /home/jonas.kemper/MA-Scripts/reoptimizer_benchmark_suite.sh poly

java -cp /home/jonas.kemper/rheem/rheem-distro/target/rheem-distro-0.2.2-SNAPSHOT.jar:/home/jonas.kemper/rheem/rheem-distro/target/rheem-distro-0.2.2-SNAPSHOT-distro/rheem-distro-0.2.2-SNAPSHOT/*:/opt/spark/spark-1.6.2-bin-hadoop2.6/lib/spark-assembly-1.6.2-hadoop2.6.0.jar -Drheem.configuration=file:/home/jonas.kemper/rheem-benchmark-goa-polynomial.properties org.qcri.rheem.profiler.log.GeneticOptimizerApp | tee ~/costFunctions_polynomial-May28-$i-auto.txt

java -cp /home/jonas.kemper/rheem/rheem-distro/target/rheem-distro-0.2.2-SNAPSHOT.jar:/home/jonas.kemper/rheem/rheem-distro/target/rheem-distro-0.2.2-SNAPSHOT-distro/rheem-distro-0.2.2-SNAPSHOT/*:/opt/spark/spark-1.6.2-bin-hadoop2.6/lib/spark-assembly-1.6.2-hadoop2.6.0.jar -Drheem.configuration=file:/home/jonas.kemper/rheem-benchmark-goa.properties org.qcri.rheem.profiler.log.GeneticOptimizerApp | tee ~/costFunctions_May28-$i-auto.txt



sed -i.bak -e '11,1000d' ~/vim rheem-benchmark-aggresive-reopt.properties
j=`grep -nr ================== ~/costFunctions_May28_$i-auto.txt   | tail -1 | egrep -o '^[^:]+'`
j=$((j+1))

l=`wc -l ~/costFunctions_May28_$i-auto.txt  | egrep -o '^[^ ]+'`
l=$((l-1))
sed -n "$j, $l p" ~/costFunctions_May28_$i-auto.txt  >> ~/rheem-benchmark-aggresive-reopt.properties 



sed -i.bak -e '11,1000d' ~/vim rheem-benchmark-aggresive-reopt.propertiespoly
j=`grep -nr ================== ~/costFunctions_polynomial-May28_$i-auto.txt   | tail -1 | egrep -o '^[^:]+'`
j=$((j+1))

l=`wc -l ~/costFunctions_polynomial-May28_$i-auto.txt  | egrep -o '^[^ ]+'`
l=$((l-1))
sed -n "$j, $l p" ~/costFunctions_polynomial-May28_$i-auto.txt  >> ~/rheem-benchmark-aggresive-reopt.propertiespoly


sed -i.bak -e '5,1000d' ~/vim rheem-benchmark-no-reopt.properties
j=`grep -nr ================== ~/costFunctions_May28_$i-auto.txt   | tail -1 | egrep -o '^[^:]+'`
j=$((j+1))

l=`wc -l ~/costFunctions_May28_$i-auto.txt  | egrep -o '^[^ ]+'`
l=$((l-1))
sed -n "$j, $l p" ~/costFunctions_May28_$i-auto.txt  >> ~/rheem-benchmark-no-reopt.properties 



sed -i.bak -e '5,1000d' ~/vim rheem-benchmark-no-reopt.propertiespoly
j=`grep -nr ================== ~/costFunctions_polynomial-May28_$i-auto.txt   | tail -1 | egrep -o '^[^:]+'`
j=$((j+1))

l=`wc -l ~/costFunctions_polynomial-May28_$i-auto.txt  | egrep -o '^[^ ]+'`
l=$((l-1))
sed -n "$j, $l p" ~/costFunctions_polynomial-May28_$i-auto.txt  >> ~/rheem-benchmark-no-reopt.propertiespoly



sleep 5

sleep 5

done
