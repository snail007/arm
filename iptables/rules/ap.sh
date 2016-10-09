#!/bin/bash
PWD=$(dirname $(readlink -f $0))
. $PWD/../../functions/functions

#可以上网的网卡名称
ap_if_net=$(pm_native_cfg_get "ap_if_net" "请输入可以上网的网卡名称")
#ap热点的网卡名称
ap_if=$(pm_native_cfg_get "ap_if" "请输入ap热点的网卡名称")

iptables -t nat -A POSTROUTING -o $ap_if_net -j MASQUERADE
iptables -A FORWARD -i $ap_if_net -o $ap_if -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i $ap_if -o $ap_if_net -j ACCEPT

bash $PWD/../save.sh