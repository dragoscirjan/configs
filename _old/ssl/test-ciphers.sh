#!/usr/bin/env bash

# OpenSSL requires the port number.
SERVER=$1
DELAY=1
if [[ "$2" != "" ]]; then
    ciphers=$2
    # IFS=',' read -r -a ciphers <<< "$2"
    # ciphers="ECDHE-ECDSA-AES256-GCM-SHA384 ECDHE-RSA-AES256-GCM-SHA384 ECDHE-ECDSA-CHACHA20-POLY1305 ECDHE-RSA-CHACHA20-POLY1305 ECDHE-ECDSA-AES128-GCM-SHA256 ECDHE-RSA-AES128-GCM-SHA256"
else
    ciphers=$(openssl ciphers 'ALL:eNULL' | sed -e 's/:/ /g')
fi 

echo Obtaining cipher list from $(openssl version).

for cipher in ${ciphers[@]}
do
    echo -n Testing $cipher...
    result=$(echo -n | openssl s_client -cipher "$cipher" -connect $1 2>&1)
    if [[ "$result" =~ ":error:" ]] ; then
        error=$(echo -n $result | cut -d':' -f6)
        echo NO \($error\)
    else
        if [[ "$result" =~ "Cipher is ${cipher}" || "$result" =~ "Cipher    :" ]] ; then
            echo YES
        else
            echo UNKNOWN RESPONSE
            echo $result
        fi
    fi
    sleep $DELAY
done
