#!/bin/bash
#set e to automatically exit if any command fails.
set -e


#check that the user provided an IP address as an argument.
if [[ -z "$1" ]]; then
  echo "Usage: $0 <ip_address>"
  exit 1
fi

ip="$1"
timestamp=$(date "+%Y.%m.%d")
directory="/home/ubuntu/report/nmap_scans"
comprehensive=Full_Port_Scan_For.$timestamp.txt
final=Services_Running_On.$timestamp.txt

#check that the directory where the output files are going to be saved actually exists.
if [[ ! -d "$directory" ]]; then
  echo "Directory $directory does not exist"
  exit 1
fi

sudo nmap -sCV -T4 -p- "$ip" --system-dns > "$directory/$comprehensive" && cat "$directory/$comprehensive" | egrep "open|filtered|closed" > "$directory/$final"
#All I did was make error-proof the script lol
