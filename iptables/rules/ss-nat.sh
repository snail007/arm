#!/bin/bash
PWD=$(dirname $(readlink -f $0))
. $PWD/../../functions/functions

case $1 in
    remove)
        iptables -t nat -D OUTPUT -p tcp -j SHADOWSOCKS >/dev/null 2>&1
        iptables -t nat -F SHADOWSOCKS >/dev/null 2>&1
        iptables -t nat -X SHADOWSOCKS >/dev/null 2>&1
        bash $PWD/../save.sh
    ;;
    install)
        #运行ss-server服务端服务器IP地址:
        ss_server_ip=$(pm_native_cfg_get "ss_server_ip" "请输入ss-server服务器IP")

        #本地运行ss-local客户端监听的端口:
        ss_local_port=$(pm_native_cfg_get "ss_local_port" "请输入本地运行ss-local客户端监听的端口" 1080)

        #create a new chain named SHADOWSOCKS
        iptables -t nat -N SHADOWSOCKS

        # Ignore your shadowsocks server's addresses
        # It's very IMPORTANT, just be careful.
        iptables -t nat -A SHADOWSOCKS -d $ss_server_ip -j RETURN

        # Ignore LANs IP address
        iptables -t nat -A SHADOWSOCKS -d 0.0.0.0/8 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 10.0.0.0/8 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 127.0.0.0/8 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 169.254.0.0/16 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 172.16.0.0/12 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 192.168.0.0/16 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 224.0.0.0/4 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 240.0.0.0/4 -j RETURN

        if [ "$2" = "--ipset" ] ;then
                if [ ! -e "/etc/chnroute.txt" ] ;then
                    bash $PWD/../chn_ip.sh
                fi

                if [ -e "/etc/chnroute.txt" ] ;then
                    # Setup the ipset
                    ipset -N chnroute hash:net maxelem 65536

                    for ip in $(cat '/etc/chnroute.txt'); do
                      ipset add chnroute $ip
                    done
                    # Allow connection to chinese IPs
                    iptables -t nat -A SHADOWSOCKS -p tcp -m set --match-set chnroute dst -j RETURN
                fi
        fi

        # Ignore Asia IP address
        iptables -t nat -A SHADOWSOCKS -d 1.0.0.0/8 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 14.0.0.0/8 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 27.0.0.0/8 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 36.0.0.0/8 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 39.0.0.0/8 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 42.0.0.0/8 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 49.0.0.0/8 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 58.0.0.0/8 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 59.0.0.0/8 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 60.0.0.0/8 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 61.0.0.0/8 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 101.0.0.0/8 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 103.0.0.0/8 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 106.0.0.0/8 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 110.0.0.0/8 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 111.0.0.0/8 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 112.0.0.0/8 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 113.0.0.0/8 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 114.0.0.0/8 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 115.0.0.0/8 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 116.0.0.0/8 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 117.0.0.0/8 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 118.0.0.0/8 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 119.0.0.0/8 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 120.0.0.0/8 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 121.0.0.0/8 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 122.0.0.0/8 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 123.0.0.0/8 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 124.0.0.0/8 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 125.0.0.0/8 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 126.0.0.0/8 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 169.0.0.0/8 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 175.0.0.0/8 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 180.0.0.0/8 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 182.0.0.0/8 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 183.0.0.0/8 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 202.0.0.0/8 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 203.0.0.0/8 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 210.0.0.0/8 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 211.0.0.0/8 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 218.0.0.0/8 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 219.0.0.0/8 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 220.0.0.0/8 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 221.0.0.0/8 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 222.0.0.0/8 -j RETURN
        iptables -t nat -A SHADOWSOCKS -d 223.0.0.0/8 -j RETURN
        # Anything else should be redirected to shadowsocks's local port
        iptables -t nat -A SHADOWSOCKS -p tcp -j REDIRECT --to-ports $ss_local_port
        # Apply the rules to nat client
        iptables -t nat -A PREROUTING -p tcp -j SHADOWSOCKS
        # Apply the rules to localhost
        iptables -t nat -A OUTPUT -p tcp -j SHADOWSOCKS
        bash $PWD/../save.sh
    ;;
    *)
        echo "$0 <install|remove>"
    ;;
esac

