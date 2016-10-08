#!/bin/bash
curl 'http://ftp.apnic.net/apnic/stats/apnic/delegated-apnic-latest' | grep ipv4 | grep CN | awk -F\| '{ printf("%s/%d\n", $4, 32-log($5)/log(2)) }' > /tmp/chnroute.txt

if [ $(ls -l /tmp/chnroute.txt | awk '{ print $5 }') -gt 10000 ] ; then
    mv /tmp/chnroute.txt /etc/chnroute.txt
    echo  "/etc/chnroute.txt updated."
fi

rm -rf /tmp/chnroute.txt

