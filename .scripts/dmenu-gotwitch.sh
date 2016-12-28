#! /bin/sh

if [ -z "$@" ]
then
	echo Subscribtions;
	echo Popular
else
	if [ "$@" == "Subscribtions" ]; then
		gotwitch streams -ba
	elif [ "$@" == "Popular" ]; then
		gotwitch streams -a
	else
		channel=$(echo $@ | awk '{print $1;}')
		gotwitch -s $channel
	fi
fi
