#! /bin/sh

if [ -z "$1" ]
then
	task ls | head -n -2 | tail -n +4 | sort
else
	if [[ "$1" =~ ^\+  ]]; then
		task add "$(echo $1 | tail -c +2)"
	elif [[ "$1" =~ ^.[0-9] ]]; then
		task done "$(echo $@ | awk '{print $1;}')"
	fi
fi