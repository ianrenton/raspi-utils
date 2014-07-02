#!/bin/bash

DIR="/home/pi/video/"
2>/dev/null
cd $DIR

# Delete old files to free up disk space
DISKFULL=$(df -h $DIR | grep -v File | awk '{print $5 }' | cut -d "%" -f1 -)
until [ $DISKFULL -le "90" ]; do
  ls -tr [0-9][0-9][0-9][0-9] | head -n 1 | xargs rm -f;
  DISKFULL=$(df -h $DIR | grep -v File | awk '{print $5 }' | cut -d "%" -f1 -)
done

# Start recording new file
# Each time netcat connects and disconnects, the raspivid line will terminate,
# so run this in a loop
while true; do
  lastfile=$(ls [0-9][0-9][0-9][0-9] | tail -1)
  newfile=$((10#$lastfile+1))
  raspivid -o $DIR$(printf "%04u" $newfile) -t 0 -vf -hf -w 640 -h 360
done
