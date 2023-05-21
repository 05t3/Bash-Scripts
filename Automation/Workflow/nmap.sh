#!/bin/bash

# Check if the hosts.txt file exists
if [ ! -f hosts.txt ]; then
    echo "File hosts.txt does not exist."
    exit 1
fi

# Initialize an array to hold active hosts
declare -a active_hosts

# Read the hosts.txt file line by line
while IFS= read -r host; do

    # Check if the host is alive
    ping -c 1 $host > /dev/null
    if [ $? -ne 0 ]; then
        echo -e "\033[31m! Host $host is not responding.\033[0m"
    else
        active_hosts+=("$host")
    fi

done < hosts.txt

# Perform WHOIS lookups for active hosts
for host in "${active_hosts[@]}"; do
    echo -e "\033[34m\u23F1 Performing WHOIS lookup for $host...\033[0m"
    mkdir -p "$host" && nohup bash -c "whois "$host" | sed 's,\x1B\[[0-9;]*[a-zA-Z],,g'" > "$host/whois.txt"  2>/dev/null &
done

# Wait for all background tasks to finish
wait

echo -e "\033[32m[\u2714] WHOIS lookups completed successfully.\033[0m"

# Perform Nmap scans for active hosts
for host in "${active_hosts[@]}"; do
    echo -e "\033[34m\u23F1 Scanning $host with Nmap...\033[0m"
    nohup bash -c "nmap -sCV -T4 -p- -Pn "$host" -oA "$host/nmap-results"" 2>/dev/null & 
    # Wait for the current Nmap scan to finish before starting the next one
    wait
    echo -e "\033[32m[\u2714] Nmap scan for $host completed successfully.\033[0m"
done
