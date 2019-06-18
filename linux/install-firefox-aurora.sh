#! /bin/bash
set -e

# https://www.ubuntuupdates.org/ppa/firefox_aurora
#which apt-get > /dev/null && {  
#  add-apt-repository -y ppa:ubuntu-mozilla-daily/firefox-aurora 
#  apt-get update
#  apt-get install -y firefox
#}

rm -rf /opt/firefox
curl -sL "https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=linux64&lang=en-US" > /opt/firefox.tar.bz2
cd /opt && tar -xjf firefox.tar.bz2 && rm -rf firefox.tar.bz2