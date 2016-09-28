#!/bin/bash
if [ ! -f /etc/init.d/smdb ] ;then
    echo -n "samba already installed.Remove it?[Y/n](n):"
    read PURGE
    if [ x$PURGE = "xY" ] || [ x$PURGE = "xy" ]; then
        apt-get -y purge samba
    else
        exit 1
    fi
fi

apt-get -y install samba

if [ ! -f /etc/samba/smb.conf.orig ] ;then
    mv /etc/samba/smb.conf /etc/samba/smb.conf.orig
fi

cp -f smb.conf /etc/samba/smb.conf

systemctl daemon-reload

systemctl enable smbd

systemctl restart smbd

systemctl status smbd

echo "/mnt now can be accessed by guest"