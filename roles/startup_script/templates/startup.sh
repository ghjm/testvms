#!/bin/bash
echo "Setting NTP date..."
ntpdate pool.ntp.org
echo "Getting menu..."
curl {{ menu_url }} > menu.sh && \
chmod a+x ./menu.sh && \
./menu.sh "$@"
