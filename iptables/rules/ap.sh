#!/bin/bash
#可以上网的网卡名称
NET=wlan1
#ap热点的网卡名称
WLAN=wlan3

iptables -t nat -A POSTROUTING -o $NET -j MASQUERADE
iptables -A FORWARD -i $NET -o $WLAN -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i $WLAN -o $NET -j ACCEPT

bash save.sh