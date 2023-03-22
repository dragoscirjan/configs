#!/usr/bin/env python3

import sys
from prometheus_client import CollectorRegistry, Gauge, push_to_gateway

PROMETHEUS_URL = "http://192.168.1.3:9091"

#print(sys.argv)

val_sensor = sys.argv[2]
val_temp = sys.argv[3]
val_hum = sys.argv[4]
val_bat = sys.argv[5]
val_bat_pct = sys.argv[6]

registry = CollectorRegistry()

t = Gauge('temp_celsius', 'Temperature, celsius', registry=registry, labelnames=('sensor', ))
h = Gauge('humidity_pct', 'Humidity, percentage', registry=registry, labelnames=('sensor', ))
bv = Gauge('battery_voltage', 'Battery, voltage', registry=registry, labelnames=('sensor', ))
bp = Gauge('battery_pct', 'Battery, percent', registry=registry, labelnames=('sensor', ))

t.labels(val_sensor).set(val_temp)
h.labels(val_sensor).set(val_hum)
bv.labels(val_sensor).set(val_bat)
bp.labels(val_sensor).set(val_bat_pct)

push_to_gateway(PROMETHEUS_URL, job='tempBatch', registry=registry)