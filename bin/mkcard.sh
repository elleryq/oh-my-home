#!/bin/sh
if [ ! "$1" = "/dev/sda" ] ; then
	echo "Are you sure??(y/n)"
	read ANSWER
	if [ ! "$ANSWER" == "y" ]; then
		echo "skip!!"
		exit 0
	fi
    mount | grep $1 | awk '{print $1}' | xargs umount
	DRIVE=$1
	if [ -b "$DRIVE" ] ; then
		dd if=/dev/zero of=$DRIVE bs=1024 count=1024
		SIZE=`fdisk -l $DRIVE | grep Disk | awk '{print $5}'`
		echo DISK SIZE - $SIZE bytes
		CYLINDERS=`echo $SIZE/255/63/512 | bc`
		echo CYLINDERS - $CYLINDERS
		{
		echo ,9,0x0C,*
		echo ,,,-
		} | sfdisk -D -H 255 -S 63 -C $CYLINDERS $DRIVE
#dd if=/dev/zero of=${DRIVE}1 bs=512 count=1
		mkfs.vfat -F 32 -n "boot" ${DRIVE}1
		mke2fs -j -L "fs" ${DRIVE}2
	fi 
fi
