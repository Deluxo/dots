#! /bin/sh

if [ -z "$@" ] || [ "$@" == "Back" ]
then
	echo Subscribtions;
	echo Popular
else
	if [ "$@" == "Subscribtions" ]; then
		echo Back;
		gotwitch streams -ba
	elif [ "$@" == "Popular" ]; then
		echo Back;
		gotwitch streams -a
	else
		channel=$(echo $@ | awk '{print $1;}')
		gotwitch -s $channel
	fi
fi
