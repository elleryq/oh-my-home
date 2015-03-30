#!/bin/bash
if [ ! -e patch.txt ]; then
    echo "Need patch.txt"
    echo "The file must contain the filename which need to be copied."
    echo "Every filename separated by new line."
    exit -1
fi
FILES=`cat patch.txt`
if [ -e ~/tmp/patch ]; then
    echo "Remove ~/tmp/patch"
    rm -rf ~/tmp/patch/
fi
echo "start to make patch directory."
for FILE in $FILES; do
    DEST=~/tmp/patch/$(dirname $FILE)
    mkdir -p $DEST
    if [ -e $FILE ]; then
        cp $FILE $DEST
    else
        echo "$FILE" >> ~/tmp/patch/REMOVE_THESE_FILES
    fi
done
echo "done."
exit 0
