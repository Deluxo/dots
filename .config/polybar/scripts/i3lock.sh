#! /bin/bash

iconLock=""
iconScreen=""
lockfile="/tmp/lock.sh.lock"

if [ -f $lockfile ]; then
	if [[ $(<$lockfile) == 'locked' ]]; then
		echo "%{F#FFFFFF}$iconLock"
	elif [[ $(<$lockfile) == 'blanking' ]]; then
		echo "%{F#FFFFFF}$iconScreen"
	fi
else
    echo "%{F#65737E}$iconLock"
fi
