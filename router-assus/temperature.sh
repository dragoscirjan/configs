#! /bin/bash

# wget $URL --no-check-certificate -O - | bash

cat <<TEMP
CPU Temperature : $(cat /proc/dmu/temperature | cut -f3 -d' ' | sed -e 's|[^0-9]*||g') C
2G  Temperature : $(wl -i eth1 phy_tempsense | cut -f1 -d' ') C
5G  Temperature : $(wl -i eth2 phy_tempsense | cut -f1 -d' ') C
TEMP