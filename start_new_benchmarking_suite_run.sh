exec_mode=$1
filename=$2

if [ $exec_mode = "all" ]; then

    timeout=$3
    select_repo_generator=$4

    mkdir ~/suite-logs-thor-baseline-$filename
    mkdir ~/suite-logs-thor-training-$filename
    mkdir ~/suite-logs-thor-validation-$filename
    
    #mv ~/MA-Scripts/benchmark-thor.properties ~/MA-Scripts/benchmark-thor_BACKUP_$filename.properties
    #mv ~/.rheem/executions.json ~/.rheem/executions_backup_$filename.json
    
    if [ $select_repo_generator = "logistic" ]; then
        cp ~/MA-Scripts/benchmark-thor-blank-logisticTrue.properties ~/MA-Scripts/benchmark-thor-baseline-$filename.properties
        cp ~/MA-Scripts/benchmark-thor-blank-logisticTrue.properties ~/MA-Scripts/benchmark-thor-training-$filename.properties
        cp ~/MA-Scripts/benchmark-thor-blank-logisticTrue.properties ~/MA-Scripts/benchmark-thor-validation-$filename.properties
    fi
    if [ $select_repo_generator = "minmax" ]; then
        cp ~/MA-Scripts/benchmark-thor-blank-logisticFalse.properties ~/MA-Scripts/benchmark-thor-baseline-$filename.properties
        cp ~/MA-Scripts/benchmark-thor-blank-logisticFalse.properties ~/MA-Scripts/benchmark-thor-training-$filename.properties
        cp ~/MA-Scripts/benchmark-thor-blank-logisticFalse.properties ~/MA-Scripts/benchmark-thor-validation-$filename.properties
    fi
    
    
    sed -i "s/June24-15uhr/$filename/g" ~/MA-Scripts/benchmark-thor-*-$filename.properties
    
    sh ~/MA-Scripts/reoptimizer_benchmark_suite.sh suite-logs-thor-baseline-$filename validation $timeout benchmark-thor-baseline-$filename.properties
    mv ~/.rheem/executions.json ~/.rheem/executions_backup_baseline_$filename.json
    
    sh ~/MA-Scripts/reoptimizer_benchmark_suite.sh suite-logs-thor-training-$filename training $timeout benchmark-thor-baseline-$filename.properties
    mv ~/.rheem/executions.json ~/.rheem/executions_backup_training_$filename.json
    sh ~/MA-Scripts/create_and_copy_select_repo.sh benchmark-thor-validation-$filename.properties ~/.rheem/executions_backup_training_$filename.json generate_select_repo
    
    sh ~/MA-Scripts/reoptimizer_benchmark_suite.sh suite-logs-thor-validation-$filename validation $timeout benchmark-thor-validation-$filename.properties
    mv ~/.rheem/executions.json ~/.rheem/executions_backup_validation_$filename.json

fi

if [ $exec_mode = "regenarate_repo" ]; then

    training_log=$3
    select_repo_generator=$4

    if [ $select_repo_generator = "lin" ]; then
        cp ~/MA-Scripts/benchmark-thor-blank-noexec-lin.properties ~/MA-Scripts/benchmark-thor-validation-$filename.properties
    fi
    if [ $select_repo_generator = "minmax" ]; then
        cp ~/MA-Scripts/benchmark-thor-blank-noexec-minmax.properties ~/MA-Scripts/benchmark-thor-validation-$filename.properties
    fi
    if [ $select_repo_generator = "log" ]; then
        cp ~/MA-Scripts/benchmark-thor-blank-noexec-log.properties ~/MA-Scripts/benchmark-thor-validation-$filename.properties
    fi
    if [ $select_repo_generator = "best" ]; then
        cp ~/MA-Scripts/benchmark-thor-blank-noexec-best.properties ~/MA-Scripts/benchmark-thor-validation-$filename.properties
    fi
    sed -i "s/June24-15uhr/$filename/g" ~/MA-Scripts/benchmark-thor-*-$filename.properties
    sh ~/MA-Scripts/create_and_copy_select_repo.sh benchmark-thor-validation-$filename.properties $training_log generate_select_repo $filename

fi

if [ $exec_mode = "validate-noexec" ]; then

    timeout=$3

    mkdir ~/suite-logs-thor-validation-$filename
    sh ~/MA-Scripts/reoptimizer_benchmark_suite.sh suite-logs-thor-validation-$filename validation $timeout benchmark-thor-validation-$filename.properties

fi

if [ $exec_mode = "baseline-training-noexec" ]; then

    timeout=$3

    mkdir ~/suite-logs-thor-baseline-$filename
    cp ~/MA-Scripts/benchmark-thor-blank-noexec-best.properties ~/MA-Scripts/benchmark-thor-baseline-$filename.properties
    sh ~/MA-Scripts/reoptimizer_benchmark_suite.sh suite-logs-thor-baseline-$filename validation $timeout benchmark-thor-baseline-$filename.properties

    #mkdir ~/suite-logs-thor-training-$filename
    #cp ~/MA-Scripts/benchmark-thor-blank-noexec-best.properties ~/MA-Scripts/benchmark-thor-training-$filename.properties
    #sh ~/MA-Scripts/reoptimizer_benchmark_suite.sh suite-logs-thor-training-$filename training $timeout benchmark-thor-training-$filename.properties

fi

if [ $exec_mode = "generate-baseline-and-training-logs" ]; then

    timeout=$3

    mkdir ~/suite-logs-thor-baseline-$filename
    mkdir ~/suite-logs-thor-training-$filename
    cp ~/MA-Scripts/benchmark-thor-blank-logisticFalse.properties ~/MA-Scripts/benchmark-thor-baseline-$filename.properties
    cp ~/MA-Scripts/benchmark-thor-blank-logisticFalse.properties ~/MA-Scripts/benchmark-thor-training-$filename.properties
    sed -i "s/June24-15uhr/$filename/g" ~/MA-Scripts/benchmark-thor-*-$filename.properties
    
    sh ~/MA-Scripts/reoptimizer_benchmark_suite.sh suite-logs-thor-baseline-$filename validation $timeout benchmark-thor-baseline-$filename.properties
    mv ~/.rheem/executions.json ~/.rheem/executions_backup_baseline_$filename.json
    
    sh ~/MA-Scripts/reoptimizer_benchmark_suite.sh suite-logs-thor-training-$filename training $timeout benchmark-thor-training-$filename.properties
    mv ~/.rheem/executions.json ~/.rheem/executions_backup_training_$filename.json


fi

if [ $exec_mode = "generate-baseline-and-training-logs-only-training" ]; then

    timeout=$3

    #mkdir ~/suite-logs-thor-baseline-$filename
    mkdir ~/suite-logs-thor-training-$filename
    #cp ~/MA-Scripts/benchmark-thor-blank-logisticFalse.properties ~/MA-Scripts/benchmark-thor-baseline-$filename.properties
    cp ~/MA-Scripts/benchmark-thor-blank-logisticFalse.properties ~/MA-Scripts/benchmark-thor-training-$filename.properties
    sed -i "s/June24-15uhr/$filename/g" ~/MA-Scripts/benchmark-thor-*-$filename.properties
    
    #sh ~/MA-Scripts/reoptimizer_benchmark_suite.sh suite-logs-thor-baseline-$filename validation $timeout benchmark-thor-baseline-$filename.properties
    #mv ~/.rheem/executions.json ~/.rheem/executions_backup_baseline_$filename.json
    
    sh ~/MA-Scripts/reoptimizer_benchmark_suite.sh suite-logs-thor-training-$filename training $timeout benchmark-thor-training-$filename.properties
    mv ~/.rheem/executions.json ~/.rheem/executions_backup_training_$filename.json


fi
