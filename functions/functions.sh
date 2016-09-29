#!/bin/bash

pm_menu_default_set(){
    export PM_MENU_DEFAULT=$1
}

pm_menu_default_get(){
    echo $PM_MENU_DEFAULT
}

pm_menu_value_hook_set(){
    export PM_MENU_VALUE_HOOK=$1
}

pm_menu_value_hook_get(){
    echo $PM_MENU_VALUE_HOOK
}

pm_is_number(){
    if [ "$1" -eq "$1" ] 2>/dev/null; then
      return 0
    else
      return 1
    fi
}

pm_menu_output_get(){
    echo $PM_FUNC_OUTPUT
}
pm_menu_output_set(){
    export PM_FUNC_OUTPUT=$*
}

pm_interfaces_names(){
    echo `ifconfig | awk '{print $1}' | egrep '^(e|v|w|w|t|p)'`
}

pm_interface_ip(){
    for name in $(pm_interfaces_names)
    do
        if [ "$name" = $1 ] ; then
                echo `ifconfig $name|awk -F ' *|:' '/255\.255\.255/{print $4}'`
                break
        fi
    done
}

pm_menu_print(){
    i=-1
    items=( "$@" )
    default=$(pm_menu_default_get)
    default_index=''
    for item in $*
    do
        i=`expr $i + 1`
        hook=$(pm_menu_value_hook_get)
        if [ ! -z "$hook" ] ;then
                v=$($hook $item)
                echo "$i). $v"
        else
                echo "$i). ${item}"
        fi
        if [ "$item" = "$default" ] ;then
            default_index=$i
        fi
    done
    ret=1

    prompt_text="Please input[0-$i]:"
    if [ ! -z "$default" ] ;then
        prompt_text="Please input[0-$i](defalut:$default_index):"
    fi
    until [[ $ret -eq 0 ]]  && [[ $choose -le $i ]]
    do
        read -p "$prompt_text" choose 
        pm_is_number $choose
        ret=$?
        if [[ ! -z "$default_index" ]] && [[ -z "$choose" ]] ;then
            choose=$default_index
            break
        fi
    done
    pm_menu_output_set ${items[$choose]}
}


