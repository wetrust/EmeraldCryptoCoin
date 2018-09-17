#!/bin/bash

exec /sbin/setuser emerald /opt/emerald/emeraldd -conf=/opt/emerald/.emerald/emerald.conf -printtoconsole -datadir=/data >> /var/log/emeraldd.log 2>&1

