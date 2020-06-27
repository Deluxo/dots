#!/usr/bin/env bash
if [ -z "$@" ]; then
    echo "$(bluetoothctl devices)"
else
	selected=$(echo "$@" | awk '{print $2}')

	if [[ -z $(bluetoothctl info | egrep $selected) ]]; then
		bluetoothctl connect $selected > /dev/null 2>&1 &!
	else
		bluetoothctl disconnect $selected > /dev/null 2>&1 &!
	fi
fi
