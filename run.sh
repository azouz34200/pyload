#!/bin/bash

if [ -f "/opt/pyload/.pyload/pyload.pid" ]
then
	        rm /opt/pyload/.pyload/pyload.pid
	fi

exec /opt/pyload/pyLoadCore.py --configdir=/opt/pyload/.pyload
