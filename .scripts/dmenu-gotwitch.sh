#! /bin/sh

tmpDir="/tmp"
filePrefix="gotwitch-"
subscriptionsFile="$tmpDir"/"$filePrefix"subscriptions
popularFile="$tmpDir"/"$filePrefix"popular
updateFreqInSec="30"

if [[ ! -e "$popularFile" ]]; then
	gotwitch streams -a > $popularFile;
	gotwitch streams -ba > $subscriptionsFile;
fi

fileModDate=$(stat -c %Y "$popularFile")
now=$(date +%s)
freshness=$(($now-$fileModDate))

if [[ $freshness -gt $updateFreqInSec ]]; then
	gotwitch streams -a > $popularFile;
	gotwitch streams -ba > $subscriptionsFile;
fi

if [ -z "$@" ] || [ "$@" == "Back" ]
then
	echo Subscriptions;
	echo Popular
else
	if [ "$@" == "Subscriptions" ]; then
		echo Back;
		cat "$subscriptionsFile";
	elif [ "$@" == "Popular" ]; then
		echo Back;
		cat "$popularFile";
	else
		channel=$(echo $@ | awk '{print $1;}')
		gotwitch -s $channel
	fi
fi
