#! /bin/bash
# https://crontab.guru/#1_*/1_*_*_*
# 1 */1 * * * root  /opt/cpuminer-multi/mine.sh
#

set -xe

(ps ax | grep minerd | grep -v grep) && killall -9 /opt/cpuminer-multi/minerd

OPTS=" -S -B"

USER=$(cat /etc/monero | grep USER= | cut -f2 -d"=")

PASS=$(cat /etc/monero | grep PASS= | cut -f2 -d"=")
PASS=${PASS:-x}

THREADS=$(cat /etc/monero | grep THREADS= | cut -f2 -d"=")
THREADS=${THREADS:-2}

POOL=$(cat /etc/monero | grep POOL= | cut -f2 -d"=")
POOL=${POOL:-stratum+tcp://pool.minexmr.com:4444}

/opt/cpuminer-multi/minerd -a cryptonight -o $POOL -u $USER -p $PASS -t $THREADS $OPTS