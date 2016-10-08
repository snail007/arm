#!/bin/bash
ROOT_DIR=$(dirname $(readlink -f $0))/..
. $ROOT_DIR/functions/functions
cd $ROOT_DIR

 
echo $(pm_read "请输入ss本地端口：")



#for rule in `ls rules/*.sh`
#    do
#        echo $rule
#    done
#echo $(ifconfig | awk '{print $1}' | egrep 'eth|w|wlan|tun|ppp')

#ipline(){
#    ip=$(pm_interface_ip $1)
#    echo "$1 [ $ip ]"
#}
#
#echo "请选择网卡IP："
#pm_menu_value_hook_set "ipline"
#pm_menu_print $(pm_interfaces_names)
#
#echo $(pm_menu_output_get)



#print_addr(){
#    for eth in ifconfig | awk '{print $1}' | egrep 'eth|wlan|tun|ppp'
#    do
#
#    done
#}

