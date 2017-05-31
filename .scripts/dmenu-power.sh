#! /bin/sh

if [ -z "$@" ]
then
	echo screen off;
	echo sleep now;
	echo sleep after 1h;
	echo sleep after 30m;
	echo restart;
	echo shutdown;
	echo kill wm;
else
	if [ "$@" == "sleep now" ]; then
		systemctl suspend
	elif [ "$@" == "sleep after 1h" ]; then
		systemctl suspend &!
	elif [ "$@" == "sleep after 30m" ]; then
		systemctl suspend &!
	elif [ "$@" == "restart" ]; then
		reboot
	elif [ "$@" == "shutdown" ]; then
		shutdown -P now
	elif [ "$@" == "killL wm" ]; then
		killall bspwm
	elif [ "$@" == "screen off" ]; then
		sleep 1 && xset dpms force standby
	fi
fi
