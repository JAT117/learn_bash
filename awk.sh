#!/bin/bash
while IFS= read -r line
do
  awk {print} $1
done
