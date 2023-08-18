This script is a Bash script that uses the "curl" command to report a list of IP addresses to the AbuseIPDB API.

The script first sets the API key and categories, which will be used in the API call. 

It then gets the current date and time and uses it to create a unique output file name for storing the results of the API call.

The script reads a list of IP addresses from a file named "IP.txt" and loops over them. For each IP address, it makes a POST request to the AbuseIPDB API with the IP address, categories, and comment included as data. The response from the API is piped to the "jq" command, which is used to format the output as JSON and append it to the output file.

After each IP address is processed, the script waits for 3 seconds before moving on to the next IP address. This is to avoid overwhelming the API with too many requests at once.

--------

To use the script:
- Modify the script by updating your AbuseIPDB API Key
- Modify the Input & Output files to a name of your liking.

1. Create a file called `xxxxxxx.txt` containing a list of bad ip's
2. chmod +x script-above.sh
3. ./script-above.sh

