#!/bin/sh
ta_dir="../"
if [ "$#" -ge 1 ] ; then 
	ta_dir=$1
fi
for student in `ls ${ta_dir}`; do 
	find "${ta_dir}${student}" -name "*.html"| while read html ; do 
		result=$(source html.sh "${html}")
		echo -e "${student}\t${result}"
	done;
done;
