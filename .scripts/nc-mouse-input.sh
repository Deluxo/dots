#! /bin/sh

# Configs
remoteCacheFile="/tmp/nc-mouse-remote"
killInputDev="/dev/input/event7"
remoteIP=${2}
defaultPort="4681"
remotePort=${3:-$defaultPort}

# Variables
localInputDev="/dev/input/mice"
localInputIdentifier="2:10:TPPS/2_Elan_TrackPoint"
mode=${1:-kill}
killSelfCmd="pkill -TERM -P $$"
remoteScript="/tmp/$(basename $0)"

function onSendCleanup {
	notify-send "nc-input.sh" 'Local input ENABLED.'
	swaymsg input $localInputIdentifier events enabled
	exit 0;
}

function onListenCleanup {
	rm $remoteScript
	exit 0;
}

if [[ $mode == "send" ]]; then
	isEnabled=$(swaymsg -t get_inputs | jq '.[] | select(.identifier == "'$localInputIdentifier'") | .libinput.send_events | . == "enabled"')
	if [[ $isEnabled == 'false' ]]; then
		exit 0;
	fi
	if [[ ! -n "$remoteIP" ]] && [[ ! -e $remoteCacheFile ]]; then
		echo 'Please use terminal to create remote cache' | swaynag -m "nc-input.sh error" -l
		exit 0;
	elif [[ ! -n "$remoteIP" ]] && [[ "$remotePort" == "$defaultPort" ]] && [[ -n $(cat $remoteCacheFile) ]]; then
		cacheContent=$(cat $remoteCacheFile)
		remoteIP=$(echo $cacheContent | awk '{print $1}')
		remotePort=$(echo $cacheContent | awk '{print $2}')
	else
		echo "$remoteIP $remotePort" > $remoteCacheFile;
	fi
	$(xxd -a -l 1 $killInputDev && eval $killSelfCmd) &!
	trap onSendCleanup EXIT;
	scp $0 root@$remoteIP:$remoteScript
	ssh  -f root@$remoteIP "chmod +x $remoteScript && $remoteScript listen"
	swaymsg input $localInputIdentifier events disabled
	notify-send "nc-input.sh" 'Local input DISABLED.'
	cat $localInputDev | nc $remoteIP $remotePort
elif [[ $mode == "listen" ]]; then
	trap onListenCleanup EXIT
	nc -l -p $remotePort > /dev/input/mouse0
fi
