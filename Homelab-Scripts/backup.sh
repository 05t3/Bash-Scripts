#!/bin/bash
#This simple stupid script thats runs every last day of the month at 2355h and back's up every important log files found in my /home/ubuntu/report directory.
#It runs as a cron job as:
# 0 55 23 L * ? * /home/ubuntu/cron/backup.sh

month=$(LC_ALL=C date +%B).Backup
directories="/home/ubuntu/report"
backup="/home/ubuntu/backup"

tar -zcvf $backup/$month.tar.gz $directories
