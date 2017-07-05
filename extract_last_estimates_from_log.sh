
function parse_card_est {

	s="$1;$2;"
	lower=`gzcat $1 | perl -p0e 's/Picked.*//igs' | grep -i cardinality | grep -i "$2" | grep -i in@  | tail -1 | sed -e 's/^.*to (//' | sed -e 's/\.\..*//'`
	s=$s$lower
	upper=`gzcat $1 | perl -p0e 's/Picked.*//igs' | grep -i cardinality | grep -i "$2" | grep -i in@  | tail -1 | sed -e 's/^.*to (//' | sed -e 's/^.*\.\.//' | sed -e 's/, .*//'`
	s="$s;$upper"
	conf=`gzcat $1 | perl -p0e 's/Picked.*//igs' | grep -i cardinality | grep -i "$2" | grep -i in@  | tail -1 | sed -e 's/^.*to (//' | sed -e 's/^.*\.\.//' | sed -e 's/.*, //' | sed -e 's/%.*//'`
	s="$s;$conf"
	lower_out=`gzcat $filename | perl -p0e 's/Picked.*//igs' | grep -i cardinality | grep -i "$operator" | grep -i out@  | tail -1 | sed -e 's/^.*to (//' | sed -e 's/\.\..*//'`
	s="$s;$lower_out"
	upper_out=`gzcat $filename | perl -p0e 's/Picked.*//igs' | grep -i cardinality | grep -i "$operator" | grep -i out@  | tail -1 | sed -e 's/^.*to (//' | sed -e 's/^.*\.\.//' | sed -e 's/, .*//'`
	s="$s;$upper_out"
	conf_out=`gzcat $filename | perl -p0e 's/Picked.*//igs' | grep -i cardinality | grep -i "$operator" | grep -i out@  | tail -1 | sed -e 's/^.*to (//' | sed -e 's/^.*\.\.//' | sed -e 's/.*, //' | sed -e 's/%.*//'`
	s="$s;$conf_out"
	echo $s

	}

echo 'dataset;op name;in lower;in upper;in conf;out lower;out upper;out conf'
for filename in ./SINDY* ; do
    for operator in 'my.udf.Sindy.filter1' 'my.udf.Sindy.flatmap1' 'my.udf.Sindy.flatmap2' 'my.udf.Sindy.reduceBy1' 'my.udf.Sindy.reduceBy2'; do
    	parse_card_est $filename "$operator"
    done
done
for filename in ./Croco* ; do
    for operator in 'my.udf.CrocoPR.distinct1' 'my.udf.CrocoPR.distinct2' 'my.udf.CrocoPR.flatMap'; do
    	parse_card_est $filename "$operator"
    done
done
for filename in ./KMeans* ; do
    for operator in 'my.udf.kmeans.flatmap' 'my.udf.kmeans.reduceByKey'; do
    	parse_card_est $filename "$operator"
    done
done
for filename in ./SimWords* ; do
    for operator in 'Split & scrub' 'Sum word counters' 'Filter frequent words' 'Create word vectors' 'Add word vectors' 'Generate centroids' 'Add up cluster words' 'Create clusters'; do
    	parse_card_est $filename "$operator"
    done
done
for filename in ./TpcH* ; do
    for operator in 'my.udf.tpchq3file.filter1' 'my.udf.tpchq3file.filter2' 'my.udf.tpchq3file.filter3' 'my.udf.tpchq3file.reduce'; do
    	parse_card_est $filename "$operator"
    done
done
for filename in ./Wordcount* ; do
    for operator in 'my.udf.wordcount.filter' 'my.udf.wordcount.flatmap' 'my.udf.wordcount.reduce'; do
    	parse_card_est $filename "$operator"
    done
done

