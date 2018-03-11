#!/bin/bash

icons="             "

weather=$(gow forecast vilnius -m -w)

notify-send -t 60000 "Go Weather" "$weather"

#if [[ $? -eq 0 ]]; then
    #metadata="$(playerctl metadata artist) - $(playerctl metadata title)"
#fi

#if [[ $player_status = "Playing" ]]; then
    #echo "%{F#FFFFFFFF}$icon   $metadata"
#elif [[ $player_status = "Paused" ]]; then
    #echo "%{F#AAFFFFFF}$icon   $metadata"
#else
    #echo "%{F#AAFFFFFF}$icon"
#fi

