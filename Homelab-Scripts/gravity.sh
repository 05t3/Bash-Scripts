#!/bin/bash
# This dumdum script updates my list of ad-serving domains for Pihole. It runs as a cronjob everyday using the following syntax:
# 0 0 * * * /home/ubuntu/cron/gravity.sh


timestamp=$(date "+%Y.%m.%d")
updatelogdir="/home/ubuntu/report/pihole-gravity-update"
updatelogname=Gravity_Update_Log_For.$timestamp
updatedlistdir="/home/ubuntu/report/pihole-gravity-lists"
updatedlistname=Updated_Lists_For.$timestamp

pihole -g > $updatelogdir/$updatelogname ; cat $updatelogdir/$updatelogname | grep -B 3 -w "List has been updated" | grep -w "Target:" | awk '{print $3}' > $updatedlistdir/$updatedlistname