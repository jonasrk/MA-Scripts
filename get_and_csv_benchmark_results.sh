#!/bin/bash

cd ~/suite-logs

mkdir $1

cd "/Users/jonas/suite-logs/$1" 

scp -r jonas.kemper@thor01:/home/jonas.kemper/\*$1\* .
scp -r jonas.kemper@thor01:/home/jonas.kemper/MA-Scripts/\*$1\* .
scp -r jonas.kemper@thor01:/home/jonas.kemper/.rheem/\*$1\* .


cd "/Users/jonas/suite-logs/$1/suite-logs-thor-baseline-$1"
sh ~/MA-Scripts/extract_last_estimates_from_log.sh | sed "s/\.\/SINDY-//" | sed "s/-benchmark-thor.*\.properties\.gz//g" | sed "s/.\/CrocoPR-//" | sed "s/\.\/KMeans-//g" | sed "s/\.csv//" | sed "s/\.\/TpcH-//" | sed "s/-Q3File//" | sed "s/\.\/Wordcount-//" > est_cards_baseline-$1.csv
cd "/Users/jonas/suite-logs/$1/suite-logs-thor-training-$1"
sh ~/MA-Scripts/extract_last_estimates_from_log.sh | sed "s/\.\/SINDY-//" | sed "s/-benchmark-thor.*\.properties\.gz//g" | sed "s/.\/CrocoPR-//" | sed "s/\.\/KMeans-//g" | sed "s/\.csv//" | sed "s/\.\/TpcH-//" | sed "s/-Q3File//" | sed "s/\.\/Wordcount-//" > est_cards_training-$1.csv

cd "/Users/jonas/suite-logs/$1/suite-logs-thor-validation-$1"
sh ~/MA-Scripts/extract_last_estimates_from_log.sh | sed "s/\.\/SINDY-//" | sed "s/-benchmark-thor.*\.properties\.gz//g" | sed "s/.\/CrocoPR-//" | sed "s/\.\/KMeans-//g" | sed "s/\.csv//" | sed "s/\.\/TpcH-//" | sed "s/-Q3File//" | sed "s/\.\/Wordcount-//" > est_cards_validation-$1.csv

mkdir /Users/jonas/Google\ Drive/suite-logs/$1

cp /Users/jonas/suite-logs/$1/suite-logs-thor-baseline-$1/*.csv /Users/jonas/Google\ Drive/suite-logs/$1
cp /Users/jonas/suite-logs/$1/suite-logs-thor-training-$1/*.csv /Users/jonas/Google\ Drive/suite-logs/$1
cp /Users/jonas/suite-logs/$1/suite-logs-thor-validation-$1/*.csv /Users/jonas/Google\ Drive/suite-logs/$1


