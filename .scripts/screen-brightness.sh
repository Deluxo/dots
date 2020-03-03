#! /bin/sh

acpiPath="/sys/class/backlight"
acpier=$(ls $acpiPath)

if [[ -z $acpier ]]; then
	exit;
else
	acpiPath="$acpiPath/$acpier"
fi

max=$(cat $acpiPath/max_brightness)
now=$(cat $acpiPath/brightness)
absInc=1

if [[ $@ =~ '%' ]]; then
	absInc=$(( $max * $(echo $1 | sed 's/[^0-9]*//g') / 100))
else
	absInc=$(echo $1 | sed 's/[^0-9]*//g')
fi

new=$now

echo "NOW: $now"
echo "MAX: $max"
echo "NEW: $new"

if [[ $@ =~ "+$percent" ]]; then
	new=$(( $now + $absInc ))
elif [[ $@ =~ "-$percent" ]]; then
	new=$(( $now - $absInc ))
fi

echo $new > "$acpiPath/brightness"
