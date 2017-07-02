# $line operator name


operators=`grep -i --color udf executions-june29-with-16uhr-sindy.json | sed -n -e 's/^.*my\.udf/my\.udf/p' | sed -n -e 's/-.*//p' | sort | uniq`

tmpfile0=$(mktemp ~/abc-script0.XXXXXX)
tmpfile1=$(mktemp ~/abc-script1.XXXXXX)
tmpfile2=$(mktemp ~/abc-script2.XXXXXX)
tmpfile3=$(mktemp ~/abc-script3.XXXXXX)
tmpfile4=$(mktemp ~/abc-script4.XXXXXX)
tmpfile5=$(mktemp ~/abc-script5.XXXXXX)
tmpfile6=$(mktemp ~/abc-script6.XXXXXX)
tmpfile7=$(mktemp ~/abc-script7.XXXXXX)

b=0

echo 'operator name; dataset name; outcards upper; outcards conf; outcards lower; incards upper; incards conf; incards lower'

while read -r line
	do

		

# dataset name
grep -i $line -A 13 executions-june29-with-16uhr-sindy.json | sed -n -e "s/^.*$line-//p" | sed -n -e 's/).*/)/p' > $tmpfile1

a=($(wc $tmpfile1))
lines=${a[0]}

echo $line > $tmpfile0

for i in $(seq 2 $lines)
 do
	echo $line >> $tmpfile0
 done


# outcards upper Bound
grep -i $line executions-june29-with-16uhr-sindy.json  | sed 's|upperBound|`|' | sed -n -e 's/^.*outCards":\[{"`"://p' | sed -n -e 's/,.*//p' > $tmpfile2
# outcards confidence
grep -i $line executions-june29-with-16uhr-sindy.json | sed 's|confidence|`|' | sed -n -e 's/^.*`"://p' | sed -n -e 's/,".*//p' > $tmpfile3
# outcards lower Bound
grep -i $line executions-june29-with-16uhr-sindy.json | sed 's|lowerBound|`|' | sed -n -e 's/^.*`"://p' | sed -n -e 's/}.*//p' > $tmpfile4

# incards upper Bound
grep -i $line executions-june29-with-16uhr-sindy.json | sed 's|inCards":\[{"upperBound"|`|' |sed -n -e 's/^.*`://p' | sed -n -e 's/,.*//p' > $tmpfile5
# incards confidence
grep -i $line executions-june29-with-16uhr-sindy.json | sed 's|inCards|`|' |sed -n -e 's/^.*`//p' | sed 's|confidence|`|' | sed -n -e 's/^.*`"://p' | sed -n -e 's/,".*//p' > $tmpfile6
# incards lower Bound
grep -i $line executions-june29-with-16uhr-sindy.json | sed 's|inCards|`|' | sed -n -e 's/^.*`//p' | sed 's|lowerBound|`|' | sed -n -e 's/^.*`"://p' | sed -n -e 's/}.*//p' > $tmpfile7

paste -d";" $tmpfile0 $tmpfile1 $tmpfile2 $tmpfile3 $tmpfile4 $tmpfile5 $tmpfile6 $tmpfile7
#paste -d"; " $tmpfile1 $tmpfile2 $tmpfile3 $tmpfile4 $tmpfile5 $tmpfile6 $tmpfile7


	done <<< "$operators"

rm "$tmpfile0"
rm "$tmpfile1"
rm "$tmpfile2"
rm "$tmpfile3"
rm "$tmpfile4"
rm "$tmpfile5"
rm "$tmpfile6"
rm "$tmpfile7"
