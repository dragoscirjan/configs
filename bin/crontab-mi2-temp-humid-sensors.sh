#! /bin/bash
set -ex

# Absolute path to this script. /home/user/bin/foo.sh
SCRIPT=$(readlink -f $0)
# Absolute path this script is in. /home/user/bin
SCRIPTPATH=`dirname $SCRIPT`

# cd $SCRIPTPATH/../3rdparty/MiTemperature2
cd $SCRIPTPATH/../3rdparty/MiTemperature2_alt

sensors=(
  "west;A4:C1:38:29:33:26;cigars"
  "west;A4:C1:38:D9:8C:28;kidsroom"
  "west;A4:C1:38:94:02:C5;kitchen"
  "west;A4:C1:38:AE:C9:56;techroom"
  "east;A4:C1:38:15:8E:E6;livroom"
  "east;A4:C1:38:60:CC:D6;bedroom"
  "east;A4:C1:38:34:76:24;study"
  "east;A4:C1:38:4F:89:84;balcony"
)

for item in ${sensors[@]}; do
  IFS=";" read -r -a sensor <<< "${item}"

  if [[ "${sensor[0]}" == "$1" ]] || [[ "${sensor[2]}" == "$1" ]]; then
    # python3 ./LYWSD03MMC.py --device ${sensor[1]} -b -call $SCRIPTPATH/sendToPrometheus.py -n ${sensor[2]} -c 1
    python3 ./LYWSD03MMC.py --device ${sensor[1]} -b -call ../../bin/mi2-temp-humid-colector.sh -n ${sensor[2]} -c 1
    sleep 2
  fi
done

bash $SCRIPTPATH/propmetheus-pushgateway.sh /tmp/mi2-temp-humid-colector.prom
