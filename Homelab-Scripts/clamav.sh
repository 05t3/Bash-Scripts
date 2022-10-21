#!/bin/bash

timestamp=$(date "+%Y.%m.%d")
directories="/home/ubuntu/"
reportdir="/home/ubuntu/report/clamav-scan"
reportname=Clamav_results_for.$timestamp
infected="/home/ubuntu/report/clamav-infected-files"
md5="/home/ubuntu/report/clamav-infected-files"
md5templog=md5sum_hashes_for.$timestamp
md5log=md5sum_hashes_for.$timestamp

sudo clamscan -iro $directories --copy=$infected -l $reportdir/$reportname | grep FOUND > $md5/$md5templog ; cat $md5/$md5templog | cut -d ":" -f1  | xargs md5sum  > $md5/$md5log && rm -rf $md5/$md5templog
