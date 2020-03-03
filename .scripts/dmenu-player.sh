#! /bin/sh

if [ -z "$@" ]
then
	echo "play / pause";
	echo "previous";
	echo "next";
else
	if [ "$@" == "play / pause" ]; then
		playerctl play-pause
	elif [ "$@" == "previous" ]; then
		playerctl previous
	elif [ "$@" == "next" ]; then
		playerctl next
	fi
fi
