#! /bin/bash

iconLock=""
iconScreen=""
lockfile="/tmp/lock.sh.lock"

if [ -f $lockfile ]; then
	if [[ $(<$lockfile) == 'locked' ]]; then
		echo "%{F#FFFFFFFF}$iconLock"
	elif [[ $(<$lockfile) == 'blanking' ]]; then
		echo "%{F#FFFFFFFF}$iconScreen"
	fi
else
    echo "%{F#AAFFFFFF}$iconLock"
fi
