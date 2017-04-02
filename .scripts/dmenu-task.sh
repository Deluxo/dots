#! /bin/bash

main() {
	task ls | head -n -2 | sed '/^\s*$/d' | sed '2d'
}

add() {
	task add $(echo $1 | tail -c +2) >> /dev/null
}

finish() {
	id="$(echo $@ | awk '{print $1;}')"
	task done $id >> /dev/null
}

if [[ -z "$1" ]]; then
	main
else
	if [[ "$@" =~ ^\+  ]]; then
		add "$1"
	else
		finish $@
	fi
	main
fi
