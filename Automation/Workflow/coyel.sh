#!/bin/bash

# Function to perform when SIGINT is caught
function interrupt_handler {
    echo "User interruption detected. Cleaning up..."
    # Add any cleanup operations here if necessary
    exit 1
}

# Tell the script to execute the interrupt_handler function when it receives SIGINT
trap interrupt_handler SIGINT

# An array to store the PIDs
pids=()


# Function to execute a command in the background and store the PID
function execute_command {
    local command=$1
    local pid
    nohup bash -c "$command" >/dev/null 2>&1 &
    pid=$!
    pids+=($pid)
}

# Function to check the status of each background job
function check_job_status {
    local pid=$1
    wait $pid
    local exit_code=$?
    if [ $exit_code -eq 0 ]; then
        echo -e "\033[32m[\u2714] Command with PID $pid completed successfully.\033[0m"
    else
        echo -e "\033[31m\u274C Command with PID $pid failed with exit code $exit_code.\033[0m"
    fi
}

echo -e " 

████████████████████████████████████████████████████████████████████████████████
█░░░░░░░░░░░░░░█░░░░░░░░░░░░░░█░░░░░░░░██░░░░░░░░█░░░░░░░░░░░░░░█░░░░░░█████████
█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀▄▀░░██░░▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀░░█████████
█░░▄▀░░░░░░░░░░█░░▄▀░░░░░░▄▀░░█░░░░▄▀░░██░░▄▀░░░░█░░▄▀░░░░░░░░░░█░░▄▀░░█████████
█░░▄▀░░█████████░░▄▀░░██░░▄▀░░███░░▄▀▄▀░░▄▀▄▀░░███░░▄▀░░█████████░░▄▀░░█████████
█░░▄▀░░█████████░░▄▀░░██░░▄▀░░███░░░░▄▀▄▀▄▀░░░░███░░▄▀░░░░░░░░░░█░░▄▀░░█████████
█░░▄▀░░█████████░░▄▀░░██░░▄▀░░█████░░░░▄▀░░░░█████░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀░░█████████
█░░▄▀░░█████████░░▄▀░░██░░▄▀░░███████░░▄▀░░███████░░▄▀░░░░░░░░░░█░░▄▀░░█████████
█░░▄▀░░█████████░░▄▀░░██░░▄▀░░███████░░▄▀░░███████░░▄▀░░█████████░░▄▀░░█████████
█░░▄▀░░░░░░░░░░█░░▄▀░░░░░░▄▀░░███████░░▄▀░░███████░░▄▀░░░░░░░░░░█░░▄▀░░░░░░░░░░█
█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░███████░░▄▀░░███████░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█
█░░░░░░░░░░░░░░█░░░░░░░░░░░░░░███████░░░░░░███████░░░░░░░░░░░░░░█░░░░░░░░░░░░░░█
████████████████████████████████████████████████████████████████████████████████ 
"
# Check for command line argument
if [ -z "$1" ]
then
  echo "Please provide the filename containing the list of hosts."
  exit 1
fi

# Prompt the user to select an option
echo "What do you wanna test?🤔"
echo "1. Perform WHOIS lookup"
echo "2. Run WPScan"
echo "3. Run WhatWeb"
echo "4. Run CMSeek"
echo "5. Run SSLyze"
echo "6. Run SSLScan"     
echo "7. Run Amass"
echo "8. Run Nuclei"
echo "9. Run Nikto"
echo "10. Run Lbd"
echo "11. Run wafw00f"
echo "12. Perform Nmap scan"
echo "A. Run all checks"
read -p "Please choose an option: " option
echo -e "\n"

# Read the list of hosts from the file
while read host
do
  if [ "$option" == "1" ] || [ "$option" == "A" ]
  then
    echo "----------------------------------------------------------------------"
    echo "                          Running Tests                               "
    echo -e "----------------------------------------------------------------------\n\n"
    mkdir -p "$host" && nohup bash -c "whois "$host" | sed 's,\x1B\[[0-9;]*[a-zA-Z],,g'" > "$host/whois.txt"  2>/dev/null & 
    pids+=($!)
    echo -e "\033[34m\u23F1 WHOIS lookup for $host Started.\033[0m"
  fi

  if [ "$option" == "2" ] || [ "$option" == "A" ]
  then
    # echo "Running WPScan on $host..."
    mkdir -p "$host" && nohup bash -c "wpscan --url "$host" --rua --api-token <API-TOKEN> -e ap,at,cb,dbe --plugins-version-detection aggressive --format cli | sed 's,\x1B\[[0-9;]*[a-zA-Z],,g'" > "$host/wpscan.txt" 2>/dev/null & 
    pids+=($!)
    echo -e "\033[34m\u23F1 Wordpress Scan on $host Started.\033[0m"
  fi

  if [ "$option" == "3" ] || [ "$option" == "A" ]
  then
    # echo "Running WhatWeb for $host..."
    mkdir -p "$host" && nohup bash -c "whatweb "$host" | sed 's,\x1B\[[0-9;]*[a-zA-Z],,g'" > "$host/whatweb.txt" 2>/dev/null & 
    pids+=($!)
    echo -e "\033[34m\u23F1 WhatWeb lookup for $host Started.\033[0m"
  fi

  if [ "$option" == "4" ] || [ "$option" == "A" ]
  then
    # echo "Running CMSeek for $host..."
    mkdir -p "$host" && nohup bash -c "cmseek -u "$host" --follow-redirect --random-agent | sed 's,\x1B\[[0-9;]*[a-zA-Z],,g'" > "$host/cmseek.txt" 2>/dev/null & 
    pids+=($!)
    echo -e "\033[34m\u23F1 CMS Detection Started.\033[0m"
  fi

  if [ "$option" == "5" ] || [ "$option" == "A" ]
  then
    # echo "Running SSLyze for $host..."
    mkdir -p "$host" && nohup bash -c "sslyze --sslv2 --tlsv1_1 --sslv3 --early_data --resum --resum_attempts 100 --compression --fallback --openssl_ccs --tlsv1 --heartbleed --robot --reneg --tlsv1_3 --tlsv1_2 --http_headers --json_out sslyze.json target "$host" | sed 's,\x1B\[[0-9;]*[a-zA-Z],,g'" > "$host/sslyze.txt" 2>/dev/null & 
    pids+=($!)
    echo -e "\033[34m\u23F1 SSL vulnerability Scan Started.\033[0m"
  fi

  if [ "$option" == "6" ] || [ "$option" == "A" ]
  then
    # echo "Running SSLScan for $host..."
    mkdir -p "$host" && nohup bash -c "sslscan "$host" | sed 's,\x1B\[[0-9;]*[a-zA-Z],,g' > "$host/sslscan.txt"" 2>/dev/null & 
    pids+=($!)
    echo -e "\033[34m\u23F1 SSLScan Started.\033[0m"
  fi

  if [ "$option" == "7" ] || [ "$option" == "A" ]
  then
    # echo "Running Amass on $host..."
    mkdir -p "$host" && nohup bash -c "amass enum -active -d "$host" | sed 's,\x1B\[[0-9;]*[a-zA-Z],,g'" > "$host/amass.txt" 2>/dev/null & 
    pids+=($!)
    echo -e "\033[34m\u23F1 Subdomain Recon Started.\033[0m"  
  fi

  if [ "$option" == "8" ] || [ "$option" == "A" ]
  then
    # echo "Running Nuclei on $host..."
    mkdir -p "$host" && nohup bash -c "nuclei -u "$host" | sed 's,\x1B\[[0-9;]*[a-zA-Z],,g'" > "$host/nuclei.txt" 2>/dev/null & 
    echo -e "\033[34m\u23F1 Nuclei Vulnerability Scan Started.\033[0m"
    pids+=($!)
  fi

  if [ "$option" == "9" ] || [ "$option" == "A" ]
  then
    # echo "Running Nikto on $host..."
    mkdir -p "$host" && nohup bash -c "nikto -h http://"$host" | sed 's,\x1B\[[0-9;]*[a-zA-Z],,g'" > "$host/nikto.txt" 2>/dev/null & 
    pids+=($!)
    echo -e "\033[34m\u23F1 Nikto Scan Started.\033[0m"
  fi

  if [ "$option" == "10" ] || [ "$option" == "A" ]
  then
    # echo "Running Lbd on $host..."
    mkdir -p "$host" && nohup bash -c "lbd "$host" | sed 's,\x1B\[[0-9;]*[a-zA-Z],,g'" > "$host/lbd.txt" 2>/dev/null & 
    pids+=($!)
    echo -e "\033[34m\u23F1 Load Balancer Identification Started.\033[0m"
  fi

  if [ "$option" == "11" ] || [ "$option" == "A" ]
  then
    # echo "Running wafw00f on $host..."
    mkdir -p "$host" && nohup bash -c "wafw00f "$host" | sed 's,\x1B\[[0-9;]*[a-zA-Z],,g'" > "$host/wafw00f.txt" 2>/dev/null & 
    pids+=($!)
    echo -e "\033[34m\u23F1 WAF Identification Started.\033[0m"
  fi

  if [ "$option" == "12" ] || [ "$option" == "A" ]
  then
    # echo "Performing Nmap scan for $host..."
    mkdir -p "$host" && nohup bash -c "nmap -sCV -T4 -p- -Pn "$host" -oA "$host/nmap-results"" 2>/dev/null & 
    pids+=($!)
    echo -e "\033[34m\u23F1 Nmap Scan Started.\033[0m"
  fi

  # Exit if option "A" is selected
  if [ "$option" == "A" ]
  then
    exit 0
  fi

done < "$1"

# At the end of the script:
# check the status of each background job
for pid in "${pids[@]}"; do
  wait $pid
  if [ $? -eq 0 ]; then
    echo -e "\033[32m[\u2714] Command with PID $pid completed successfully.\033[0m"
  else
    echo -e "\033[31m\u274C Command with PID $pid failed.\033[0m"
  fi
done
