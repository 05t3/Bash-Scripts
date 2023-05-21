# This script update ( From backup4.sh) introduces few new bash scripting techniques but rest for the code between Lines 8-16 should be by now self-explanatory. Line 8 is using a -z bash option in combination with conditional if statement to check whether positional parameter $1 contains any value. -z simply returns true if the length of the string which in our case is variable $1 is zero. If this is the case, we set $user variable to a current user's name.

# Else on Line 11, we check if the requested user's home directory exists by using -d bash option. Note the exclamation mark before the -d option. Exclamation mark, in this case, acts as a negator. By default -d option returns true if the directory exists, hence our ! just reverts the logic and on Line 12 we print an error message. Line 13 uses exit command causing script execution termination. We have also assigned exit value 1 as opposed to 0 meaning that the script exited with an error. If the directory check passes validation, on Line 15 we assign our $user variable to positional parameter $1 as requested during by the user. 


#!/bin/bash
#using double quotes to handle cases where the argument contains spaces or special characters.
#if [ -z $1 ]; then
if [ -z "$1" ]; then
        user=$(whoami)                                                                                                                                                                                                                                                         
else                                                                                                                                                                                                                                                                           
        if [ ! -d "/home/$1" ]; then                                                                                                                                                                                                                                           
                echo "Requested $1 user home directory doesn't exist."                                                                                                                                                                                                         
                exit 1                                                                                                                                                                                                                                                         
        fi                                                                                                                                                                                                                                                                     
        user=$1                                                                                                                                                                                                                                                                
fi        


user=$(whoami)
input=/home/$user/Workflow/
output=/home/$user/backups/${user}_workflow_$(date +%Y-%m-%d_%H%M%S).tar.gz

function total_files {
        find $1 -type f | wc -l
}

function total_directories {
        find $1 -type d | wc -l
}

function total_archived_directories {
        tar -tzf $1 | grep /$ | wc -l
}

function total_archived_files {
        tar -tzf $1 | grep -v /$ | wc -l
}


#Displaying errors to the user or logging them to a separate file rather than directing them to /dev/null
#tar -czf $output $input 2> /dev/null
tar -czf "$output" -C "$input" . 2>&1

src_files=$( total_files $input )
src_directories=$( total_directories $input )

arch_files=$( total_archived_files $output )
arch_directories=$( total_archived_directories $output )

echo "Files to be included: $src_files"
echo "Directories to be included: $src_directories"
echo "Files archived: $arch_files"
echo "Directories archived: $arch_directories"

if [ $src_files -eq $arch_files ]; then
        echo "Backup of $input completed!"
        echo "Details about the output backup file:"
        ls -l $output
else
        #echo "Backup of $input failed!"
        #including a timestamp in the error message when the backup fails. 
        echo "Backup of $input failed at $(date +%Y-%m-%d_%H%M%S)."
fi
