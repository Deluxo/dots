#! /bin/bash

icon=""

if [ -f /tmp/lock.sh.lock ]; then
    echo "%{F#FFFFFF}$icon"
else
    echo "%{F#65737E}$icon"
fi
