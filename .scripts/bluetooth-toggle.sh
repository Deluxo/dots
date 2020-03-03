#! /bin/sh

STATUS=$(bluetoothctl show | grep Powered | awk '{print $2}')
APP="bluetoothctl"
CMD="power"
ARG_ON="on"
ARG_OFF="off"
TEXT=""

echo "STATUS: $STATUS"

if [[ $STATUS == 'no' ]]; then
	TEXT=$($APP $CMD $ARG_ON)
else	
	TEXT=$($APP $CMD $ARG_OFF)
fi

notify-send 'Bluetooth' "$TEXT"
