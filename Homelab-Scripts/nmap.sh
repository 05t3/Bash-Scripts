#!/bin/bash
#set e to automatically exit the script if any command fails.
set -e

if [[ -z "$1" ]]; then
  echo "Usage: $0 <ip_address>"
  exit 1
fi

ip="$1"
timestamp=$(date "+%Y.%m.%d")
directory="/home/ubuntu/report/nmap_scans"
comprehensive=Full_Port_Scan_For.$timestamp.txt
final=Services_Running_On.$timestamp.txt

if [[ ! -d "$directory" ]]; then
  echo "Directory $directory does not exist"
  exit 1
fi

sudo nmap -sCV -T4 -p- "$ip" --system-dns > "$directory/$comprehensive" && cat "$directory/$comprehensive" | egrep "open|filtered|closed" > "$directory/$final"
