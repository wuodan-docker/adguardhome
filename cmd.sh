#!/bin/bash

set -e

# make sure the docker volume mountpoints are writable
chmod ugo+w conf
chmod ugo+w work
sudo -u nobody \
	./AdGuardHome \
		-h 0.0.0.0 \
		-c /opt/adguardhome/conf/AdGuardHome.yaml \
		-w /opt/adguardhome/work
