#!/bin/bash
# 2016.08.13

Dir="/media/linusyeung/SHIT/NewFolder/"
File="$(ls -1 $Dir)"
Pattern=".html"

for file in $File
do
	ofile="${file%$Pattern}".md
	pandoc -f html -t markdown_github $file -o $ofile 
	echo "Okay for $ofile"
done

echo 
exit 0

