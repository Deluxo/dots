#! /bin/sh

onKill() {
	killall compton &> /dev/null
}

onStart() {
	compton --config /home/lukas/.config/compton/compton.conf &!
}

if [[ $1 =~ "kill" || $1 == "0" ]]; then
	onKill
elif [[ $1 =~ "start" || $1 == "1" ]]; then
	onKill
	onStart
fi
