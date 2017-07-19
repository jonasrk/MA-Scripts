baseline=July14-19uhr58

id=July19-20uhr01
sh start_new_benchmarking_suite_run.sh regenarate_repo $id ~/.rheem/executions_backup_baseline_$baseline.json log
sh start_new_benchmarking_suite_run.sh validate-noexec $id 1m

id=July19-20uhr02
sh start_new_benchmarking_suite_run.sh regenarate_repo $id ~/.rheem/executions_backup_baseline_$baseline.json lin
sh start_new_benchmarking_suite_run.sh validate-noexec $id 1m

id=July19-20uhr03 
sh start_new_benchmarking_suite_run.sh regenarate_repo $id ~/.rheem/executions_backup_baseline_$baseline.json minmax 
sh start_new_benchmarking_suite_run.sh validate-noexec $id 1m

id=July19-20uhr04
sh start_new_benchmarking_suite_run.sh regenarate_repo $id ~/.rheem/executions_backup_baseline_$baseline.json best
sh start_new_benchmarking_suite_run.sh validate-noexec $id 1m

id=July19-20uhr05
sh start_new_benchmarking_suite_run.sh regenarate_repo $id ~/.rheem/executions_backup_training_$baseline.json log
sh start_new_benchmarking_suite_run.sh validate-noexec $id 1m

id=July19-20uhr06
sh start_new_benchmarking_suite_run.sh regenarate_repo $id ~/.rheem/executions_backup_training_$baseline.json lin
sh start_new_benchmarking_suite_run.sh validate-noexec $id 1m

id=July19-20uhr07 
sh start_new_benchmarking_suite_run.sh regenarate_repo $id ~/.rheem/executions_backup_training_$baseline.json minmax 
sh start_new_benchmarking_suite_run.sh validate-noexec $id 1m

id=July19-20uhr08
sh start_new_benchmarking_suite_run.sh regenarate_repo $id ~/.rheem/executions_backup_training_$baseline.json best
sh start_new_benchmarking_suite_run.sh validate-noexec $id 1m
