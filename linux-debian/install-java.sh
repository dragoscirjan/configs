#! /bin/bash
set -e

VERSION=${VERSION:8}

which apt-get > /dev/null && {
	apt-get install -y apt-utils debconf-utils software-properties-common
	apt-get remove -y oracle-java* openjdk-*
	add-apt-repository -y ppa:webupd8team/java || ( apt-get install -y python-software-properties && add-apt-repository -y ppa:webupd8team/java )
	apt-get update
	debconf-set-selections <<< "oracle-java$VERSION-installer	shared/accepted-oracle-license-v1-1 boolean true"
	apt-get install -y oracle-java$VERSION-installer oracle-java$VERSION-set-default
	update-java-alternatives -s java-$VERSION-oracle
}