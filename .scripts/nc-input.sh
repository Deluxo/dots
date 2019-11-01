#! /bin/sh

# The license of this script is MIT.
#
# This script assumes the host (initiator) uses sway as a windown manager,
# and both the host and the client (linux machines) have these programs installed:
#   * nc - netcat
#   * ssh
#
# The host is assumed to have also:
#   * notify-send
#   * sway
#   * scp

# Upon event from this device, the session will end
killInputDev="/dev/input/event7"

# Local device identifier from swaymsg -t get_inputs
localInputIdentifier="1:1:AT_Translated_Set_2_keyboard"
defaultPort="4680"
remoteCacheFile="/tmp/nc-input-remote"
mode=${1:-kill}
remoteIP=${2}
remotePort=${3:-$defaultPort}
localInputDev="$(ls -d -1 /dev/input/by-path/* | grep event-kbd | head -n 1)"
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

	if [[ ! -n "$remoteIP" ]] && [[ "$remotePort" == "$defaultPort" ]] && [[ -n $(cat $remoteCacheFile) ]]; then
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

	nc -l -p $remotePort > $localInputDev
fi
