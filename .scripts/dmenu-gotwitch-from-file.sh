#! /bin/sh

if [[ -z "$@" ]]; then
	cat /tmp/gotwitch-subscriptions
	echo - - - - - - - - - -
	cat /tmp/gotwitch-popular
else
	channel=$(echo $@ | awk '{print $1;}')
	gotwitch -w $channel
fi
