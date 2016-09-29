#!/bin/bash
#新建路由转发表中的一个链 REDSOCKS
iptables -t nat -N REDSOCKS
#设置不需要代理转发的网段
#目的为墙外代理服务器的数据包一定不能转发
iptables -t nat -A REDSOCKS -d 192.168.8.1 -j RETURN
#目的为局域网和本地回环地址的数据包不用转发
iptables -t nat -A REDSOCKS -d 172.0.0.0/24 -j RETURN
iptables -t nat -A REDSOCKS -d 192.168.0.0/16 -j RETURN
#将数据包转发到 redsocks
iptables -t nat -A REDSOCKS -p tcp -j REDIRECT --to-ports 1080
#将 REDSOCKS 链的规则应用到经过 eth0 网卡的数据包
iptables -t nat -A OUTPUT -p tcp -o wlan3 -j REDSOCKS
