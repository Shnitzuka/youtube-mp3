#!/bin/bash
#give txt file as arg
file=$1
lineNum=0
regex='v=(.*)'

for line in $(cat $file)
do
segNum=0
#fetch search page
wget http://www.youtube.com/results?search_query=$line
#cut down search page
var=$(sed -n -e 's/ //g' results?search_query=$line -e /watch/p results?search_query=$line)

for seg in $var
do
segment[$segNum]=$seg
segNum=$(($segNum+1))
done

if [[ ${segment[0]} =~ $regex ]]; then
		address[$lineNum]=${BASH_REMATCH[1]}
		address[$lineNum]=$(echo $address | cut -d'"' -f1)
		address[$lineNum]=http://www.youtube.com/watch?v=$address
		youtube-mp3 $address
fi


done
