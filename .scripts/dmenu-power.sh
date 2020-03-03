#! /bin/sh

if [ -z "$@" ]
then
	echo "sleep";
	echo "shutdown";
	echo "restart";
	echo "screen off";
	echo "kill wm";
	echo "update & shutdown";
else
	if [ "$@" == "sleep" ]; then
		systemctl suspend
	elif [ "$@" == "restart" ]; then
		reboot
	elif [ "$@" == "shutdown" ]; then
		shutdown -P now
	elif [ "$@" == "update & shutdown" ]; then
		sleep 1 && alacritty -e "yes | p && shutdown -P now"
	elif [ "$@" == "killL wm" ]; then
		killall i3
	elif [ "$@" == "screen off" ]; then
		sleep 1 && xset dpms force standby
	fi
fi
