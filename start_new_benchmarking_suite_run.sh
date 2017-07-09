mkdir ~/suite-logs-thor-baseline-$1
mkdir ~/suite-logs-thor-training-$1
mkdir ~/suite-logs-thor-validation-$1

#mv ~/MA-Scripts/benchmark-thor.properties ~/MA-Scripts/benchmark-thor_BACKUP_$1.properties
#mv ~/.rheem/executions.json ~/.rheem/executions_backup_$1.json

cp ~/MA-Scripts/benchmark-thor-blank.properties ~/MA-Scripts/benchmark-thor-baseline-$1.properties
cp ~/MA-Scripts/benchmark-thor-blank.properties ~/MA-Scripts/benchmark-thor-training-$1.properties
cp ~/MA-Scripts/benchmark-thor-blank.properties ~/MA-Scripts/benchmark-thor-validation-$1.properties


sed -i "s/June24-15uhr/$1/g" ~/MA-Scripts/benchmark-thor-*-$1.properties


sh ~/MA-Scripts/reoptimizer_benchmark_suite.sh suite-logs-thor-baseline-$1 validation $2 benchmark-thor-baseline-$1.properties
mv ~/.rheem/executions.json ~/.rheem/executions_backup_baseline_$1.json

sh ~/MA-Scripts/reoptimizer_benchmark_suite.sh suite-logs-thor-training-$1 training $2 benchmark-thor-baseline-$1.properties
sh ~/MA-Scripts/create_and_copy_select_repo.sh benchmark-thor-validation-$1.properties $2
mv ~/.rheem/executions.json ~/.rheem/executions_backup_training_$1.json

sh ~/MA-Scripts/reoptimizer_benchmark_suite.sh suite-logs-thor-validation-$1 validation $2 benchmark-thor-validation-$1.properties
mv ~/.rheem/executions.json ~/.rheem/executions_backup_validation_$1.json
