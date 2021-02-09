#!/bin/bash
# else example
if [ $# -eq 1 ]
 then
	nl -b $1
 else
	nl -b /dev/stdin
fi
