#! /bin/sh

PrimaryScreen=$(xrandr | grep ' connected ' | head -n 1 | awk '{print $1}')
NewScreen=$(xrandr | grep ' connected ' | tail -n 1 | awk '{print $1}')
SuitableAudio=$(~/.scripts/adevice.sh --list | grep ${NewScreen:0:4} | head -n 1)
DefaultAudioCard="Generic"

function connect() {
xrandr \
	--output $NewScreen \
	--auto \
	--below $PrimaryScreen
}

function disconnect() {
	xrandr --auto
}

function affectALSA() {
	case $NewScreen in
		DisplayPort-0)
			~/.scripts/adevice.sh --set DisplayPort
			;;
		HDMI-A-0)
			~/.scripts/adevice.sh --set HDMI
			;;
		*)
			~/.scripts/adevice.sh --set Generic
			;;
	esac
}

echo $PrimaryScreen
echo $NewScreen
echo $SuitableAudio

if [[ $PrimaryScreen != $NewScreen ]]; then
	connect
	affectALSA
else
	disconnect
	affectALSA
fi

