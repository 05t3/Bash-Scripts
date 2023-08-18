#!/bin/bash

# Set the API key and categories.
API_KEY="YOUR API KEY"
CATEGORIES="18,22"
COMMENT="sshd: Attempt to login using a non-existent user"

# Get the current date and time.
DATE=$(date +%Y-%m-%d_%H-%M-%S)

# Define the output file name.
OUTPUT_FILE="reported-IPs_$DATE.json"

# Read the IP addresses from the file and loop over them.
while read IP; do
  # POST the submission for each IP and pipe the output to jq.
  curl -s https://api.abuseipdb.com/api/v2/report \
    --data-urlencode "ip=$IP" \
    -d categories="$CATEGORIES" \
    --data-urlencode "comment=$COMMENT" \
    -H "Key: $API_KEY" \
    -H "Accept: application/json" | jq >> "$OUTPUT_FILE"
  # Wait for 2 seconds before processing the next IP.
  sleep 3
done < IP.txt
