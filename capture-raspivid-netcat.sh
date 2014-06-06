#!/bin/bash

DIR="/home/pi/video/"
2>/dev/null

# Delete old files to free up disk space
DISKFULL=$(df -h $DIR | grep -v File | awk '{print $5 }' | cut -d "%" -f1 -)
until [ $DISKFULL -le "90" ]; do
  ls -tr *.h264 | head -n 1 | xargs rm -f;
  DISKFULL=$(df -h $DIR | grep -v File | awk '{print $5 }' | cut -d "%" -f1 -)
done

# Start recording new file and streaming over HTTP
# Each time netcat connects and disconnects, the raspivid line will terminate,
# so run this in a loop
while true; do
  NOW=$(date +"%Y-%m-%d-%M-%S")
  raspivid -o - -t 0 -vf -hf -w 640 -h 360 -fps 10 -ex antishake | tee $DIR$NOW.h264 | nc -l -p 5001
done
