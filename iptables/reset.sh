#!/bin/bash
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X

bash save.sh


