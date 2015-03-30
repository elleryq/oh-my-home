#!/bin/sh
OUT=`echo "$1" | awk -F . '{print $1;}'`
ffmpeg -i $1 -s 352x288 -vcodec h263 -acodec libfaac -ac 1 -ar 16000 -r 13 -ab 32000 -aspect 3:2 $OUT.3gp
