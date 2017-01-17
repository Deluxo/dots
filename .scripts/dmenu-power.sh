#! /bin/sh

if [ -z "$@" ]
then
	echo Screen off;
	echo Sleep Now;
	echo Sleep After 1h;
	echo Sleep After 30m;
	echo Restart;
	echo Turn Off;
	echo KILL ME;
else
	if [ "$@" == "Sleep Now" ]; then
		systemctl suspend
	elif [ "$@" == "Sleep After 1h" ]; then
		systemctl suspend &!
	elif [ "$@" == "Sleep After 30m" ]; then
		systemctl suspend &!
	elif [ "$@" == "Restart" ]; then
		reboot
	elif [ "$@" == "Turn Off" ]; then
		shutdown now
	elif [ "$@" == "KILL ME" ]; then
		killall bspwm
	elif [ "$@" == "Screen off" ]; then
		sleep 1 && xset dpms force standby
	fi
fi
