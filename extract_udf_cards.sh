# udf names
sed $'s/selectivityKey/\\\n/g' $1 | sed -n -e 's/^.*my.udf/my.udf/p' | sed -n -e 's/".*//p'
# get input cards
sed $'s/selectivityKey/\\\n/g' $1 | sed -n -e 's/^.*udf//p' | sed -n -e 's/platform.*//p' | sed -n -e 's/^.*upperBound"://p' | sed -n -e 's/,".*//p'
# get output cards
sed $'s/selectivityKey/\\\n/g' $1 | sed -n -e 's/^.*udf//p' | sed -n -e 's/platform.*//p' | sed -n -e 's/inCards":\[{"upperBound.*//p'  | sed -n -e 's/^.*upperBound"://p' | sed -n -e 's/,".*//p'
