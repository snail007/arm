#!/bin/bash
CONFIG_FILE=$(dirname $(readlink -f $0))/sslocal.json
PID_FILE=/tmp/sslocal.pid 
case $1 in
	start)
	sslocal --pid-file $PID_FILE -c $CONFIG_FILE -d start
	;;
	stop)
        sslocal --pid-file $PID_FILE -c $CONFIG_FILE -d stop
	;;
	restart)
        sslocal --pid-file $PID_FILE -c $CONFIG_FILE -d restart
	;;
	status)
	touch $PID_FILE
	PID=$(cat $PID_FILE)
	if ps -p $PID > /dev/null 2>&1
	then
		echo "PID:$PID"
	else
		echo not running
		exit 1
	fi
	;;
	*)
	echo "usage:$0 <start|stop|restart|status>"
	;;
esac

