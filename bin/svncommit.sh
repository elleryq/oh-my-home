#!/bin/bash

#FILES=$(svn status | awk 'BEGIN {i=1;} $1 !~ /^?/{printf("%d [%s]%s off ", i++, $1, $2);}')
FILES=$(svn status | awk '$1 !~ /^?/{printf("%s %s off ", $2, $1);}')
CMD="dialog --separate-output --stdout --checklist Modified/Add/Delete 24 80 20 \
    $FILES"
SELECTED=$($CMD)

if [ "$SELECTED" == "" ]; then
    echo "Select nothing."
else
    #echo "svn commit $SELECTED"
    svn commit $SELECTED
fi

