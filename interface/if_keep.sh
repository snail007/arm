#!/bin/bash
source /etc/profile
if [ -z "$*" ] ;then
    echo "$0 <interface_name1> <interface_name2> ..."
    exit
fi
while true;do
    for ifname in $* 
    do
        IF_IS_OK=`ifconfig -a | grep $ifname`
        if [ -z "$IF_IS_OK" ] ;then
            echo "interface $ifname not found"
        else
            HASIP=`ifconfig $ifname | grep 255.255`
            if [ -z "$HASIP" ] ;then
                ifconfig $ifname down
                ifdown $ifname
                ifup $ifname
                echo "$ifname up?false,ifup"
            fi
        fi
    done
    sleep 10
done