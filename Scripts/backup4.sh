# Lines 15 - 21 are used to define two functions returning a total number of files and directories included within the resulting compressed backup file. After the backup Line 23 is executed, on Lines 25 - 29 we declare new variables to hold the total number of source and destination files and directories. 

# The variables concerning backed up files are later used on Lines 36 - 42 as part of our new conditional if/then/else statement returning a message about the successful backup on Lines 37 - 39only if the total number of both, source and destination backup files is equal as stated on Line 36. 

#!/bin/bash

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

tar -czf $output $input 2> /dev/null

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
        echo "Backup of $input failed!"
fi