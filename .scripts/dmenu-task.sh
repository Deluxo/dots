#! /bin/sh

if [ -z "$1" ]
then
	task ls | head -n -2 | tail -n +4 | sort
else
	if [[ "$1" =~ ^\+  ]]; then
		if [[ "$1" =~ due: ]]; then
			due=$(echo "$1" | grep -o 'due:.*' | sed 's/due://gi')
			dsc=$(echo "$1" | sed "s/due:$due//gi")
			task add "$(echo $dsc | tail -c +2)" due:$due
		else
			task add "$(echo $1 | tail -c +2)"
		fi
	elif [[ "$1" =~ ^-.[0-9] ]]; then
		task done "$(echo $@ | awk '{print $2;}')"
	fi
fi
