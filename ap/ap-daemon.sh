#!/bin/bash
source /etc/profile
APWLAN=wlan3
NETWLAN=wlan1
APNAME=SnailAP

APWLAN_IS_OK=`ifconfig -a | grep $APWLAN`
NETWLAN_IS_OK=`ifconfig -a | grep $NETWLAN`
if [ -z "$APWLAN_IS_OK" ] || [ -z "$NETWLAN_IS_OK" ] ;then
    echo $APWLAN or $NETWLAN not found
    exit 1
fi


HASWLAN=`ifconfig $APWLAN | grep 255.255 `

if [ -z "$HASWLAN" ] ;then
    ifconfig $APWLAN down
    ifdown $APWLAN
    ifup $APWLAN
    iptables-restore < /etc/iptables.ipv4.nat
    echo "$APWLAN up?false,ifup"
fi

service hostapd status|| service hostapd restart

service dnsmasq status || service dnsmasq restart

service udhcpd status|| service udhcpd restart


AP_IS_OK=`iwlist $NETWLAN scanning|grep ESSID|grep $APNAME`
if [ -z "$AP_IS_OK" ] ;then
    service hostpad restart
    echo "AP_IS_OK?false,restarted"
fi