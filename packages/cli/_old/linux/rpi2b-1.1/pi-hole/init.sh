#! /bin/bash

netstat -tlpna | grep 53 | grep systemd && bash ./remove-systemd-resolved.sh

docker-compose -f docker-compose.yml up -d
