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

if [ ! -f /usr/local/bin/ss-server ] ; then
    git clone https://github.com/shadowsocks/shadowsocks-libev.git
    cd shadowsocks-libev
    ./configure
    make && make install
    cd ../
    rm -rf shadowsocks-libev
fi

curl 'http://ftp.apnic.net/apnic/stats/apnic/delegated-apnic-latest' | grep ipv4 | grep CN | awk -F\| '{ printf("%s/%d\n", $4, 32-log($5)/log(2)) }' > /tmp/chnroute.txt

if [ $(ls -l /tmp/chnroute.txt | awk '{ print $5 }') -gt 10000 ] ; then
    mv /tmp/chnroute.txt /etc/chnroute.txt
fi





