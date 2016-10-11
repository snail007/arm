#!/bin/bash
ROOT_DIR=$(dirname $(readlink -f $0))/..
. $ROOT_DIR/functions/functions
cd $ROOT_DIR

apt-get -y install hostapd udhcpd dnsmasq iptables-persistent

UUID=$(pm_randstr 4)

WLAN=$(pm_read "please input wlan name for AP" "wlan0")

NET=$(pm_read "please input interface name that can access net" "eth0")

APNAME=$(pm_read "please input AP name" "SnailAP-$UUID")

PASSWORD=$(pm_read "please input AP password" "88886666")

####################udhcpd########################

pm_cp_safe udhcpd.conf /etc/udhcpd.conf

sed -i "s/wlan0/$WLAN/g"  /etc/udhcpd.conf

####################hostapd########################

pm_cp_safe hostapd.default /etc/default/hostapd

pm_cp_safe hostapd.conf /etc/hostapd/hostapd.conf

sed -i "s/wlan0/$WLAN/g"  /etc/hostapd/hostapd.conf
sed -i "s/SnailAP/$APNAME/g"  /etc/hostapd/hostapd.conf
sed -i "s/88886666/$PASSWORD/g"  /etc/hostapd/hostapd.conf



####################iptables########################
sh -c "echo 1 > /proc/sys/net/ipv4/ip_forward" 

iptables -t nat -A POSTROUTING -o $NET -j MASQUERADE
iptables -A FORWARD -i $NET -o $WLAN -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i $WLAN -o $NET -j ACCEPT

if [ ! -z $(which netfilter-persistent) ] ;then
    netfilter-persistent save
fi

if [ ! -z $(which iptables-persistent) ] ;then
    iptables-persistent save
fi

sysctl -p

echo "iface $WLAN inet static">>/etc/network/interfaces.d/$WLAN
echo "        address 192.168.8.1">>/etc/network/interfaces.d/$WLAN
echo "        network 255.255.255.0">>/etc/network/interfaces.d/$WLAN

####################dnsmasq########################
pm_cp_safe dnsmasq.conf /etc/dnsmasq.conf

sed -i "s/wlan0/$WLAN/g"  /etc/dnsmasq.conf

dnsmasq_dns="/etc/dnsmasq.d/dns.conf"
echo "no-resolv">$dnsmasq_dns
echo "server=202.141.162.123">>$dnsmasq_dns
echo "server=202.38.93.153">>$dnsmasq_dns
echo "server=202.141.176.93">>$dnsmasq_dns



####################service########################
systemctl daemon-reload

ifconfig $WLAN down
ifdown $WLAN
ifup $WLAN

systemctl enable hostapd
systemctl restart hostapd
systemctl status hostapd

systemctl enable udhcpd
systemctl restart udhcpd
systemctl status udhcpd

systemctl enable dnsmasq
systemctl restart dnsmasq
systemctl status dnsmasq






