#!/bin/bash

user=$(whoami)
input=/home/$user/Workflow/
output=/home/$user/backups/${user}_workflow_$(date +%Y-%m-%d_%H%M%S).tar.gz

tar -czf $output $input 2> /dev/null
echo "Backup of $input completed! Details about the output backup file:"
ls -l $output

