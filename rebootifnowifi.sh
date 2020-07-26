#!/bin/bash

ping -c 1 192.168.1.254 > /dev/null 
if [ $? -ne 0 ]; then
  reboot
fi
