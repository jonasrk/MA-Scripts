mkdir ~/suite-logs-thor-wout-$1
mkdir ~/suite-logs-thor-with-$1
mkdir ~/suite-logs-thor-training-$1
mkdir ~/suite-logs-thor-only-$1

mv ~/MA-Scripts/benchmark-thor.properties ~/MA-Scripts/benchmark-thor_BACKUP_$1.properties
cp ~/MA-Scripts/benchmark-thor-blank.properties ~/MA-Scripts/benchmark-thor.properties
mv ~/.rheem/executions.json ~/.rheem/executions_backup_$1.json
sed -i "s/June24-15uhr/$1/g" ~/MA-Scripts/benchmark-thor.properties

sh ~/MA-Scripts/reoptimizer_benchmark_suite.sh suite-logs-thor-wout-$1 && sh ~/MA-Scripts/create_and_copy_select_repo.sh && sh ~/MA-Scripts/reoptimizer_benchmark_suite.sh suite-logs-thor-with-$1 && mv ~/.rheem/executions.json ~/.rheem/executions_before_training-$1.json && mv ~/MA-Scripts/benchmark-thor.properties ~/MA-Scripts/benchmark-thor_before_training-$1.properties && cp ~/MA-Scripts/benchmark-thor-blank.properties ~/MA-Scripts/benchmark-thor.properties && sh ~/MA-Scripts/reoptimizer_benchmark_suite_training.sh suite-logs-thor-training-$1 && sh ~/MA-Scripts/create_and_copy_select_repo.sh && sh ~/MA-Scripts/reoptimizer_benchmark_suite_only_wc_sindy.sh suite-logs-thor-only-$1


