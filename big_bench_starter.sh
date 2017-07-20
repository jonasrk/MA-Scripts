baseline=July14-19uhr58

id=July20-12uhr41
sh start_new_benchmarking_suite_run.sh regenarate_repo $id ~/.rheem/executions_backup_baseline_$baseline.json log
sh start_new_benchmarking_suite_run.sh validate-noexec $id 1m

id=July20-12uhr42
sh start_new_benchmarking_suite_run.sh regenarate_repo $id ~/.rheem/executions_backup_baseline_$baseline.json lin
sh start_new_benchmarking_suite_run.sh validate-noexec $id 1m

id=July20-12uhr43 
sh start_new_benchmarking_suite_run.sh regenarate_repo $id ~/.rheem/executions_backup_baseline_$baseline.json minmax 
sh start_new_benchmarking_suite_run.sh validate-noexec $id 1m

id=July20-12uhr44
sh start_new_benchmarking_suite_run.sh regenarate_repo $id ~/.rheem/executions_backup_baseline_$baseline.json best
sh start_new_benchmarking_suite_run.sh validate-noexec $id 1m

id=July20-12uhr45
sh start_new_benchmarking_suite_run.sh regenarate_repo $id ~/.rheem/executions_backup_training_$baseline.json log
sh start_new_benchmarking_suite_run.sh validate-noexec $id 1m

id=July20-12uhr46
sh start_new_benchmarking_suite_run.sh regenarate_repo $id ~/.rheem/executions_backup_training_$baseline.json lin
sh start_new_benchmarking_suite_run.sh validate-noexec $id 1m

id=July20-12uhr47 
sh start_new_benchmarking_suite_run.sh regenarate_repo $id ~/.rheem/executions_backup_training_$baseline.json minmax 
sh start_new_benchmarking_suite_run.sh validate-noexec $id 1m

id=July20-12uhr48
sh start_new_benchmarking_suite_run.sh regenarate_repo $id ~/.rheem/executions_backup_training_$baseline.json best
sh start_new_benchmarking_suite_run.sh validate-noexec $id 1m
