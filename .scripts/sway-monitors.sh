#! /bin/sh

CMD="swaymsg output"
ENABLE="enable"
DISABLE="disable"
ENABLE_LIST="$@"

for row in $(swaymsg -t get_outputs | jq -r '.[] | @base64'); do
	_jq() {
		echo ${row} | base64 --decode | jq -r ${1}
	}

	NAME=$(_jq '.name')
	ACTIVE=$(_jq '.active')

	if [[ -z $ENABLE_LIST ]]; then
		eval "$CMD $NAME $ENABLE"
	elif [[ "$ENABLE_LIST" =~ $NAME ]]; then
		eval "$CMD $NAME $ENABLE"
	else
		eval "$CMD $NAME $DISABLE"
	fi
done
