while read p; do
  sh parse_estimates.sh "$p"
  echo $p
  done <$1
