#!/bin/bash

greetings="Welcome"
user=$(whoami)
day=$(date +%A)
sysinfo=$(uname -a)

echo "$greetings back $user!!! Today is $day, which is the best day of the entire week!"
echo "You are currently using "$SHELL" shell, Version $BASH_VERSION. Enjoy!"
echo "Here are some details about your system $sysinfo"