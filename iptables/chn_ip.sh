#!/bin/bash
chnroute_tmp_path="/tmp/chnroute.txt"
chnroute_path="/etc/chnroute.txt"
curl 'http://ftp.apnic.net/apnic/stats/apnic/delegated-apnic-latest' | grep ipv4 | grep CN | awk -F\| '{ printf("%s/%d\n", $4, 32-log($5)/log(2)) }' > $chnroute_tmp_path

if [ $(ls -l $chnroute_tmp_path | awk '{ print $5 }') -gt 10000 ] ; then
    mv $chnroute_tmp_path $chnroute_path
    echo  "$chnroute_path updated."
fi

rm -rf $chnroute_tmp_path

