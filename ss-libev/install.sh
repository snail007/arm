#!/bin/bash
if [ ! -f /usr/local/bin/ss-server ] ; then
    git clone https://github.com/shadowsocks/shadowsocks-libev.git
    cd shadowsocks-libev
    ./configure
    make && make install
    cd ../
    rm -rf shadowsocks-libev
fi

