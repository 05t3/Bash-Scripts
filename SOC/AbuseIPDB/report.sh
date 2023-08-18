#!/bin/bash

# Set the API key and categories.
API_KEY="YOUR API KEY"
CATEGORIES="18,22"
COMMENT="sshd: Attempt to login using a non-existent user"

# Check for required tools
if ! command -v curl &> /dev/null; then
    echo "Error: curl is not installed."
    exit 1
fi

if ! command -v jq &> /dev/null; then
    echo "Error: jq is not installed."
    exit 1
fi

# Get the current date and time.
DATE=$(date +%Y-%m-%d_%H-%M-%S)

# Define the output file name.
OUTPUT_FILE="reported-IPs_$DATE.json"

# Check if IP.txt exists
if [ ! -f IP.txt ]; then
    echo "Error: IP.txt not found!"
    exit 1
fi

# Count total IPs and initialize processed count
TOTAL_IPS=$(wc -l < IP.txt)
PROCESSED_IPS=0

# Read the IP addresses from the file and loop over them.
while read -r IP; do
    ((PROCESSED_IPS++))
    RESPONSE=$(curl -sS -w "%{http_code}" -o /tmp/curl_response https://api.abuseipdb.com/api/v2/report \
        --data-urlencode "ip=$IP" \
        -d categories="$CATEGORIES" \
        --data-urlencode "comment=$COMMENT" \
        -H "Key: $API_KEY" \
        -H "Accept: application/json")

    # Check if curl was successful and handle errors.
    if [[ $RESPONSE -ne 200 ]]; then
        echo "Error reporting IP $IP. See /tmp/curl_response for details."
    else
        jq < /tmp/curl_response >> "$OUTPUT_FILE"
    fi

    # Update the progress on the same line.
    echo -ne "Progress: $PROCESSED_IPS/$TOTAL_IPS IPs processed.\r"

    # Wait for 3 seconds before processing the next IP.
    sleep 3
done < IP.txt

# Move to a new line after processing is complete.
echo -e "\nProcessing complete. $PROCESSED_IPS/$TOTAL_IPS IPs reported."
exit 0
