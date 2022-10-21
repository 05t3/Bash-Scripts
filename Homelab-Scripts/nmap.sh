#!/bin/bash

timestamp=$(date "+%Y.%m.%d")
ip=$(ifconfig eth0 | grep -w  "inet" | awk '{print $2}')
directory="/home/ubuntu/report/nmap_scans"
comprehensive=Full_Port_Scan_For.$timestamp.txt
final=Services_Running_On.$timestamp.txt

sudo nmap -sCV -T4 -p- $ip --system-dns > $directory/$comprehensive && cat $directory/$comprehensive | egrep "open|filtered|closed" > $directory/$final