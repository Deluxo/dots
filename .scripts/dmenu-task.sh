#! /bin/bash

main() {
	task ls | head -n -2 | sed '/^\s*$/d' | sed '2d' | tail -n +2
}

add() {
	task add $(echo $1 | tail -c +2) >> /dev/null
}

finish() {
	id="$(echo $@ | awk '{print $1;}')"
	task done $id >> /dev/null
}

OUTPUT=''

if [[ -z "$1" ]]; then
	OUTPUT=$(main)
else
	if [[ "$@" =~ ^\+  ]]; then
		OUTPUT=$(add "$1")
	else
		OUTPUT=$(finish $@)
	fi
	OUTPUT=$(main)
fi

OUTPUT=$(echo "$OUTPUT" | $DMENU)

if [[ ! -z "$OUTPUT" ]]; then
	$0 "$OUTPUT"
fi
