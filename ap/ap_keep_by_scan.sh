#!/bin/bash
source /etc/profile
if [ -z "$2" ] ;then
    echo "$0 <wlan_interface_name> <ap_name>"
    exit
fi
while true;do
    AP_IS_OK=`iwlist $1 scanning|grep ESSID|grep $2`
    if [ -z "$AP_IS_OK" ] ;then
        killall hostapd
        #service hostapd restart
        echo "AP_IS_OK?false,restarted"
    fi
    sleep 10
done
