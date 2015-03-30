#!/bin/bash
 
if [ $# -lt 1 ]; then
echo "Uso: $0 "
exit 1
fi
 
#ID=`echo $1 | cut -d= -f2 | cut -d\&amp; -f1`
ID=`echo $1 | cut -d= -f2`
FILE="youtube-${ID}"
BASE_URL="http://youtube.com/get_video.php"
echo $FILE
 
wget -O /tmp/${FILE} $1
 
if [ $? == 0 ]; then
T_PARAM=`grep '&amp;t=' /tmp/${FILE} | head -n 1 | awk -F'&amp;t=' '{print $2}' | cut -d\&amp; -f 1`
VIDEO_URL="${BASE_URL}?video_id=${ID}&amp;t=${T_PARAM}"
 
wget -O ${FILE}.flv $VIDEO_URL
 
if [ $? != 0 ]; then
rm -f ${FILE}.flv
exit 1
else
echo "Formato (avi , mpg o wmv): "
read formato
ffmpeg -i ${FILE}.flv ${FILE}.$formato
fi
fi
 
rm -f /tmp/${FILE}
