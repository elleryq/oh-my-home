#!/bin/bash
if [ -z $1 ]; then
    ar=()
    git log --format=format:"%H \"%s\"" > /tmp/result
    while read n s; do
        ar+=("$n" "${s//'"'/}")
    done < /tmp/result
    #echo "${ar[@]}"
    result=$(dialog --stdout --menu "Git log" 24 72 22 "${ar[@]}")
    rm -f /tmp/result
else
    result=$1
fi
if [ -z $result ]; then
    echo "failure."
    exit -1
fi

echo "$result"
git diff $result~1 $result > ~/tmp/$result.patch

#  mail out directly.
title=`git show $result --pretty=oneline|head -n 1`
echo $title
dialog --yesno "Mail myself?" 10 40
if [ $? -eq 0 ]; then
    git show $result | mutt ellery_tsai@askey.com.tw -s "$title" -a ~/tmp/$result.patch
fi

rm -rf $OUTPUT
echo "~/tmp/$result.patch"
echo "done".
