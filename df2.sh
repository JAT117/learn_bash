#!/bin/bash
# Print a message about disk useage.
space_free=$( df -h | awk '{ print $5 }' | sort -n | tail -n 1 | sed 's/%//' )
case $space_free in
	[1-6]*)
		echo Plenty of disk space available
		;;
	[7-9]*)
		echo Disk space above 70%
		;;
	*)
		echo Something is not quite right here
		;;
esac
