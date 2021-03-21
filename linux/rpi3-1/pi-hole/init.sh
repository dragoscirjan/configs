#! /bin/bash

systemctl status systemd-resolved | grep "Active: active" \
  && ( \
    systemctl disable systemd-resolved.service \
    && systemctl stop systemd-resolved \
  )

docker-compose -f docker-compose.yml up -d
