#!/bin/sh
	for filename in 0_01 0_1 0_5 1 2 5 10 20 50 100
		do
		l_path=hdfs://thor01/data/csv/TPC-H/sf$filename
		l_path2=/lineitem.tbl
		l_path3=/orders.tbl
		l_path4=/customer.tbl
		l_input_file2=rheem.apps.tpch.csv.lineitem=$l_path$l_path2
		l_input_file3=rheem.apps.tpch.csv.orders=$l_path$l_path3
		l_input_file4=rheem.apps.tpch.csv.customer=$l_path$l_path4
		echo $l_input_file2 >  tpch_props_$filename.txt
		echo $l_input_file3 >> tpch_props_$filename.txt
		echo $l_input_file4 >> tpch_props_$filename.txt
		done
