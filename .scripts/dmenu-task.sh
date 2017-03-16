#! /bin/sh

main() {
	task ls | head -n -2 | sed '/^\s*$/d' | sed '2d'
}

add() {
	task add $(echo $1 | tail -c +2) >> /dev/null
}

finish() {
	task done "$(echo $@ | awk '{print $2;}')" >> /dev/null
}

if [ -z "$1" ]
then
	main
else
	if [[ "$@" =~ ^\+  ]]; then
		add "$1"
	elif [[ "$@" =~ ^-.[0-9] ]]; then
		finish $@
	fi
	main
fi
