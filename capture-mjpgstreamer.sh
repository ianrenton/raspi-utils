#!/bin/bash

raspistill -w 640 -h 480 -hf -vf -o /home/pi/video/pic.jpg -tl 100 -t 999999999 -th 0:0:0 &
cd /home/pi/mjpg-streamer/
export LD_LIBRARY_PATH=./
./mjpg_streamer -i "input_file.so -f /home/pi/video -n pic.jpg" -o "output_http.so -w ./www"
