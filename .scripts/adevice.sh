#! /bin/sh

home="/home/$(echo $(whoami))"
confs="$home/.config/asound.conf.d"
outputs=$(ls ~/.config/asound.conf.d/)

while [ $# -gt 0 ]; do
	arg=$1
	case $arg in
		-l|--list)
			echo $outputs;
			;;
		-s|--set)
			cp $confs/$2 $home/.asoundrc
			;;
	esac
	shift
done
