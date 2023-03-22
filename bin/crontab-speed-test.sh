#! /bin/bash
set -ex

# Absolute path to this script. /home/user/bin/foo.sh
SCRIPT=$(readlink -f $0)
# Absolute path this script is in. /home/user/bin
SCRIPTPATH=`dirname $SCRIPT`

speed_data=$(speedtest --json)

if_dld_speed=$(echo $speed_data | jq ".download" -r)
if_dld_speed=$(echo "scale=2 ; $if_dld_speed / 1" | bc)
if_uld_speed=$(echo $speed_data | jq ".upload" -r)
if_uld_speed=$(echo "scale=2 ; $if_uld_speed / 1" | bc)
if_ping=$(echo $speed_data | jq ".ping" -r)
if_ping=$(echo "scale=2 ; $if_ping / 1" | bc)



if_name=$(ip addr | awk '/state UP/ {print $2}' | sed 's/.$//')

if_ssid_name=$(nmcli -t -f name,device connection show --active | grep $if_name | cut -d\: -f1)
if [ "$if_ssid_name" == "" ]; then
  if_ssid_name=$(iw dev $if_name info | grep ssid | awk '{print $2}')
fi



push_file=/tmp/speed-test.prom
add_types=1

prefix=

if [ -f $push_file ]; then
  grep TYPE $push_file -RIn > /dev/null && add_types=0
fi

if [ $add_types -eq 1 ]; then

  cat <<EOF >> $push_file
# TYPE ${prefix}net_download gauge
# HELP ${prefix}net_download Download Speed, MBps
${prefix}net_download{if="$if_name",ssid="${if_ssid_name:-none}",hostname="$(hostname)"} $if_dld_speed
# TYPE ${prefix}net_upload gauge
# HELP ${prefix}net_upload Upload Speed, MBps
${prefix}net_upload{if="$if_name",ssid="${if_ssid_name:-none}",hostname="$(hostname)"} $if_uld_speed
# TYPE ${prefix}net_ping gauge
# HELP ${prefix}net_ping Ping, seconds
${prefix}net_ping{if="$if_name",ssid="${if_ssid_name:-none}",hostname="$(hostname)"} $if_ping
EOF

else

  cat <<EOF >> $push_file
${prefix}net_download{if="$if_name",ssid="${if_ssid_name:-none}",hostname="$(hostname)"} $if_dld_speed
${prefix}net_upload{if="$if_name",ssid="${if_ssid_name:-none}",hostname="$(hostname)"} $if_uld_speed
${prefix}net_ping{if="$if_name",ssid="${if_ssid_name:-none}",hostname="$(hostname)"} $if_ping
EOF

fi

bash $SCRIPTPATH/propmetheus-pushgateway.sh $push_file
