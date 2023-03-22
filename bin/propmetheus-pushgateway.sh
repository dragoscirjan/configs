#! /bin/bash
set -ex

# Absolute path to this script. /home/user/bin/foo.sh
SCRIPT=$(readlink -f $0)
# Absolute path this script is in. /home/user/bin
SCRIPTPATH=`dirname $SCRIPT`

push_file=$1
gateway_url=$(yq ".prometheus.gateway_url" $SCRIPTPATH/../config.yml)

cat $push_file | curl -X POST -H "Content-type: text/plain" --data-binary @- $gateway_url/metrics/job/tempBatch

echo "" > $push_file
