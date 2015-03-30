#!/bin/sh
FSTYPE=ext4
if [ ! "$1" = "/dev/sda" ] ; then
	echo "Are you sure??(y/n)"
	read ANSWER
	if [ ! "$ANSWER" == "y" ]; then
		echo "skip!!"
		exit 0
	fi
    MOUNTED=`mount | grep $1`
    if [ ! -z "$MOUNTED" ]; then
        echo "Mounted!  Umount first!!"
        echo "$MOUNTED" | awk '{print $1}' | xargs umount
    fi
	DRIVE=$1
	if [ -b "$DRIVE" ] ; then
		dd if=/dev/zero of=$DRIVE bs=1024 count=1024
		SIZE=`fdisk -l $DRIVE | grep Disk | awk '{print $5}'`
		echo DISK SIZE - $SIZE bytes
		CYLINDERS=`echo $SIZE/255/63/512 | bc`
# Layout:
#   boot
#   system(fs)
#   recovery
#   extended
#     cache
#     userdata (data)
		echo CYLINDERS - $CYLINDERS
		{
		echo ,9,0x0C,*
		echo ,70,,-
		echo ,70,,-
		echo ,,0x05,-
		echo ,10,,-
		echo ,,,-
		} | sfdisk -D -H 255 -S 63 -C $CYLINDERS $DRIVE
#dd if=/dev/zero of=${DRIVE}1 bs=512 count=1
		mkfs.vfat -F 32 -n "boot" ${DRIVE}1
		mkfs.${FSTYPE} -L "fs" ${DRIVE}2
		mkfs.${FSTYPE} -L "recovery" ${DRIVE}3
		mkfs.${FSTYPE} -L "cache" ${DRIVE}5
		mkfs.${FSTYPE} -L "data" ${DRIVE}6
	fi 
fi
exit 0
