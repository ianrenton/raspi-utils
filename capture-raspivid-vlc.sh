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
NOW=$(date +"%Y-%m-%d-%M-%S")
raspivid -o - -t 0 -vf -w 640 -h 360 -fps 25 -ex antishake | tee $DIR$NOW.h264 | cvlc -vvv stream:///dev/stdin --sout '#standard{access=http,mux=ts,dst=:8554}' :live-caching=0 :sout-mux-caching=10 :demux=h264
