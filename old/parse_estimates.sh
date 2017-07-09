#!/bin/bash

# escape [ and ] with \] and \[

s_escaped1=`sed 's/\[/\\\[/g' <<<"$1"`
s_escaped2=`sed 's/\]/\\\]/g' <<<"$s_escaped1"`
echo $s_escaped2

# for each operator, of its last estimate before choosing the initial plan, extract the last estimate before choosing the initial plan, extract ... 

# ... the minimum
cat -b log-May22-10.txt | grep -i "$s_escaped2 " | grep -i "estimat" | grep Setting | tail -1 | sed -n -e 's/^.*(//p' | sed -n -e 's/ \..*//p' >> est_min.txt
# ... maximum
cat -b log-May22-10.txt | grep -i "$s_escaped2 " | grep -i "estimat" | grep Setting | tail -1 | sed -n -e 's/^.*\.\. //p' | sed -n -e 's/, .*//p' >> est_max.txt
# ... and p value
cat -b log-May22-10.txt | grep -i "$s_escaped2 " | grep -i "estimat" | grep Setting | tail -1 | sed -n -e 's/^.*, p=//p' | sed -n -e 's/%)..*//p' >> est_p.txt
