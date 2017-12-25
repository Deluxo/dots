#!/bin/sh

if [[ $1 == '1' ]]; then
	icon=""
	if pgrep -x "compton" > /dev/null
	then
		echo "%{F#00AF02}$icon" #Green
	else
		echo "%{F#65737E}$icon" #Gray
	fi
elif [[ $1 == '2' ]]; then
	COMPTON="compton -b --vsync drm --paint-on-overlay"
	if pgrep -x "compton" > /dev/null
	then
		killall compton
	else
		$COMPTON
	fi
fi
