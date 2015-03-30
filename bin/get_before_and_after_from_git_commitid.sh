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

FILES=`git diff-tree --no-commit-id --name-only -r $result`

OUTPUT='/tmp/git-diff'
mkdir -p $OUTPUT
mkdir -p $OUTPUT/before
mkdir -p $OUTPUT/after
for FILE in $FILES; do
    NEW_FILENAME=`basename $FILE`
    NEW_DIRNAME=`dirname $FILE`
    mkdir -p $OUTPUT/before/$NEW_DIRNAME
    mkdir -p $OUTPUT/after/$NEW_DIRNAME
    git show $result~1:$FILE > $OUTPUT/before/$NEW_DIRNAME/$NEW_FILENAME
    git show $result:$FILE > $OUTPUT/after/$NEW_DIRNAME/$NEW_FILENAME
done
7za a -r ~/tmp/$result.7z $OUTPUT/*

#  mail out directly.
title=`git show $result --pretty=oneline|head -n 1`
echo $title
dialog --yesno "Mail to Lucas?" 10 40
if [ $? -eq 0 ]; then
    git show $result | mutt lucas_shu@askey.com.tw -c ellery_tsai@askey.com.tw -s "$title" -a ~/tmp/$result.7z
fi

rm -rf $OUTPUT
echo "~/tmp/$result.7z"
echo "done".
