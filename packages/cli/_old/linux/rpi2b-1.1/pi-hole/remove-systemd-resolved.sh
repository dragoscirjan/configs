#! /bin/bash

# https://github.com/pi-hole/docker-pi-hole/#installing-on-ubuntu

sed -r -i.orig 's/#?DNSStubListener=yes/DNSStubListener=no/g' /etc/systemd/resolved.conf

rm /etc/resolv.conf \
  && ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf

systemctl restart systemd-resolved
