#!/bin/bash
ROOT_DIR=$(dirname $(readlink -f $0))/..
. $ROOT_DIR/functions/functions
cd $ROOT_DIR

install="y"

if [ ! -f /usr/local/bin/ss-server ] ; then
    install=$(pm_read "ss已经存在，是否强制安装?[y/N]")
fi

if [ "$install" = "y" ] ; then
    apt-get -y update
    apt-get -y install build-essential autoconf libtool libssl-dev \
        gawk debhelper dh-systemd init-system-helpers pkg-config asciidoc xmlto apg libpcre3-dev
    git clone https://github.com/shadowsocks/shadowsocks-libev.git
    cd shadowsocks-libev
    ./configure
    make && make install
    cd ../
    rm -rf shadowsocks-libev
fi
