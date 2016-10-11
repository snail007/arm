#!/bin/bash

ROOT_DIR=$(dirname $(readlink -f $0))
. $ROOT_DIR/functions/functions
cd $ROOT_DIR


apt-get update

apt-get -y install build-essential lrzsz git gcc g++ zlib1g-dev \
 autoconf  cmake libpcre3 libpcre3-dev libevent-dev \
 openssl libssl-dev  libcurl4-gnutls-dev libtool \
 libssl-dev libncurses5-dev libxml2-dev iptables-persistent \
 gawk debhelper dh-systemd init-system-helpers pkg-config \
 ethtool supervisor iftop htop iotop asciidoc xmlto apg ipset \
 curl




