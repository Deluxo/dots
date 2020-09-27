#!/usr/bin/env bash

DEVICES=$(bluetoothctl paired-devices)
SELECTION=$(echo "$DEVICES" | grep "$(echo "$DEVICES" | cut -f 3- -d ' '| $DMENU -i)" | cut -f 2 -d ' ')

if [[ -z $(bluetoothctl info | egrep $SELECTION) ]]; then
	bluetoothctl connect $SELECTION > /dev/null 2>&1 &!
else
	bluetoothctl disconnect $SELECTION > /dev/null 2>&1 &!
fi
