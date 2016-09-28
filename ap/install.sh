apt-get -y install hostapd udhcpd dnsmasq

####################udhcpd########################
if [ ! -f /etc/default/udhcpd.orig ] ;then
    mv /etc/default/udhcpd /etc/default/udhcpd.orig
fi
cp -f udhcpd.default /etc/default/udhcpd

echo -n "please input wlan name for udhcpd , default [wlan0]:"

read WLAN

if [ -z $WLAN ];then
    WLAN=wlan0
fi

sed -i "s/wlan0/$WLAN/g"  /etc/default/udhcpd

####################hostapd########################

if [ ! -f /etc/default/hostapd.orig ] ;then
    mv /etc/default/hostapd /etc/default/hostapd.orig
fi
cp -f hostapd.default /etc/default/hostapd


if [ ! -f /etc/hostapd/hostapd.conf.orig ] ;then
    mv /etc/hostapd/hostapd.conf /etc/hostapd/hostapd.conf.orig
fi
cp -f hostapd.conf /etc/hostapd/hostapd.conf

sed -i "s/wlan0/$WLAN/g"  /etc/hostapd/hostapd.conf


echo -n "please input ap password , default [88886666]:"

read PASSWORD

if [ -z $PASSWORD ];then
    PASSWORD=88886666
fi

sed -i "s/88886666/$PASSWORD/g"  /etc/hostapd/hostapd.conf

####################iptables########################
sh -c "echo 1 > /proc/sys/net/ipv4/ip_forward" 

echo -n "please input interface name that can access net , default [eth0]:"

read NET

if [ -z $NET ];then
    NET=eth0
fi
iptables -F
iptables -X
iptables -t nat -A POSTROUTING -o $NET -j MASQUERADE
iptables -A FORWARD -i $NET -o $WLAN -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i $WLAN -o $NET -j ACCEPT

sysctl -p

sh -c "iptables-save > /etc/iptables.ipv4.nat"

sysctl -p
HASNAT=`grep -rn "iptables.ipv4.nat" /etc/network/interfaces`
if [ -z $HASNAT ];then
    echo "up iptables-restore < /etc/iptables.ipv4.nat">>/etc/network/interfaces
    echo "iptables.ipv4.nat added"
else
    echo "iptables.ipv4.nat skiped"
fi

echo "iface $WLAN inet static">>/etc/network/interfaces.d/$WLAN
echo "        address 192.168.8.1">>/etc/network/interfaces.d/$WLAN
echo "        network 255.255.255.0">>/etc/network/interfaces.d/$WLAN

####################dnsmasq########################
if [ ! -f /etc/dnsmasq.conf.orig ] ;then
    mv /etc/dnsmasq.conf /etc/dnsmasq.conf.orig
fi
cp -f dnsmasq.conf /etc/dnsmasq.conf
sed -i "s/wlan0/$WLAN/g"  /etc/dnsmasq.conf


####################service########################
systemctl daemon-reload

ifconfig $WLAN down
ifdow $WLAN
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


