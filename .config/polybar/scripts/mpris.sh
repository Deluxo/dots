#!/bin/bash

icon=""
player_status=$(playerctl status 2> /dev/null)

if [[ $? -eq 0 ]]; then
    metadata="$(playerctl metadata artist) - $(playerctl metadata title)"
fi

if [[ $player_status = "Playing" ]]; then
    echo "%{F#FFFFFFFF}$icon $metadata"
elif [[ $player_status = "Paused" ]]; then
    echo "%{F#AAFFFFFF}$icon $metadata"
else
    echo "%{F#AAFFFFFF}$icon"
fi
