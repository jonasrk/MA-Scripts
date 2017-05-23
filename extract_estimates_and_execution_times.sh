grep -v Discarding /Users/jonas/IDE_log_May16_8.txt | grep -A 1 "items in" | sed -n -e 's/^.*in //p' | sed -n -e 's/ (est.*//p'  

grep -v Discarding /Users/jonas/IDE_log_May16_8.txt | grep -A 1 "items in" | sed -n -e 's/^.*ed (//p' | sed -n -e 's/ .*//p'   

grep -v Discarding /Users/jonas/IDE_log_May16_8.txt | grep -A 1 "items in" | sed -n -e 's/^.*\.\. //p' | sed -n -e 's/,.*//p' 

grep -v Discarding /Users/jonas/IDE_log_May16_8.txt | grep -A 1 "items in" | grep ExecutionStage | sed -e 's/^.*ExecutionStage\[T\[//' | sed -e 's/^.*ExecutionStage\[T\[//' | sed -e 's/\[.*//'
