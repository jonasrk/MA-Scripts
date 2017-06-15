# udf names
sed -n -e 's/^.*my.udf/my.udf/p' $1 | sed -n -e 's/".*//p'
# get input cards
sed -n -e 's/^.*udf//p' $1 | sed -n -e 's/platform.*//p' | sed -n -e 's/^.*upperBound"://p' | sed -n -e 's/,".*//p'
# get output cards
sed -n -e 's/^.*udf//p' $1 | sed -n -e 's/platform.*//p' | sed -n -e 's/inCards":\[{"upperBound.*//p'  | sed -n -e 's/^.*upperBound"://p' | sed -n -e 's/,".*//p'
