#! / bin / bash 
# based on https://www.monero.how/tutorial-how-to-mine-monero
#

apt-get update
apt-get install -y git libcurl4-openssl-dev build-essential libjansson-dev autotools-dev automake

cd /opt
rm -rf 
git clone https://github.com/hyc/cpuminer-multi
cd cpuminer-multi
./autogen.sh
CFLAGS="-march=native" ./configure
make

curl -sL https://gist.github.com/dragoscirjan/1bed4010872c639fce2da7c9b5fc9a47/raw/5365ff86caf35f20b22aaf257c9c8cac2e56d806/getmonero.org%2520-%2520mine.sh > /opt/cpuminer-multi/mine.sh && chmod 755 /opt/cpuminer-multi/mine.sh
