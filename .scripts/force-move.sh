#! /bin/bash

CLASS=$1
DESKTOP=$2
INPROGRESS=true
while ($INPROGRESS)
do
	if [[ "$(wmctrl -lx | grep $CLASS | awk '{print $3}')" =~ "$CLASS" ]]; then
		wmctrl -xr $CLASS -t $DESKTOP
		INPROGRESS=false
	else
		sleep 1
	fi
done
