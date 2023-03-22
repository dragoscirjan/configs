#! /bin/bash

# /home/ubuntu/myhome-monitor/3rdparty/MiTemperature2/../../bin/mi2-temp-humid-to-file.sh sensorname,temperature,humidity,voltage,batteryLevel,timestamp kidsroom 23.77 46 3.094 99 1647290484

push_file=/tmp/mi2-temp-humid-colector.prom
add_types=1

prefix=

if [ -f $push_file ]; then
  grep TYPE $push_file -RIn > /dev/null && add_types=0
fi

if [ $add_types -eq 1 ]; then

  cat <<EOF >> $push_file
# TYPE ${prefix}temp_celsius gauge
# HELP ${prefix}temp_celsius Temperature, celsius
${prefix}temp_celsius{sensor="$2"} $3
# TYPE ${prefix}humidity_pct gauge
# HELP ${prefix}humidity_pct Humidity, percentage
${prefix}humidity_pct{sensor="$2"} $4
# TYPE ${prefix}battery_voltage gauge
# HELP ${prefix}battery_voltage Battery, voltage
${prefix}battery_voltage{sensor="$2"} $5
# TYPE ${prefix}battery_pct gauge
# HELP ${prefix}battery_pct Humidity, percentage
${prefix}battery_pct{sensor="$2"} $6
EOF

else

  cat <<EOF >> $push_file
${prefix}temp_celsius{sensor="$2"} $3
${prefix}humidity_pct{sensor="$2"} $4
${prefix}battery_voltage{sensor="$2"} $5
${prefix}battery_pct{sensor="$2"} $6
EOF

fi
