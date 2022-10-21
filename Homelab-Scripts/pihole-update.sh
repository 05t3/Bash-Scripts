#!/bin/bash

# Bash script to Update Pi-hole subsystems

timestamp=$(date "+%Y.%m.%d")
directory=/home/ubuntu/report/pihole-update-logs
log=Pihole_update_log_for.$timestamp.txt

pihole -up > $directory/$log
