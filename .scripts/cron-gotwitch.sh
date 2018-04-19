#! /bin/zsh

export DISPLAY=:0.0

tmpDir=/tmp/gotwitch
popsFile=$tmpDir/gotwitch-popular
subsFile=$tmpDir/gotwitch-subscriptions
notifiedFile=$tmpDir/gotwitch-notified

mkdir -p $tmpDir
touch $notifiedFile
gotwitch -lbgt --padding 0 > $subsFile
gotwitch -lgt --padding 0 > $popsFile

subs=$(cat $subsFile)
notified=$(cat $notifiedFile)
notify=($(echo "$subs" | awk '{print $1}'))

for n in $notify; do
	inSubsFile=$(echo "$subs" | grep -i $n)

	oldStream=$(echo "$notified" | grep "$n" | grep -v "$inSubsFile")
	if [[ -n "$oldStream" ]]; then
		echo "lol"
		notified=$(echo "$notified" | grep -vi $oldStream)
	fi;

	inNotifiedFile=$(echo "$notified" | grep "$inSubsFile")
	if [[ ! -n "$inNotifiedFile" ]]; then
		entry=$(echo "$inSubsFile" | sed "s/ / is playing /1" | sed "s/ (http.*$//")
		icon=$(echo "$inSubsFile" | grep -oe "http.*[^)]")
		localIcon=$(echo $icon | sed "s/http.*\///")
		localIcon=$tmpDir/$localIcon
		if [[ ! -f $localIcon ]]; then
			curl -s "$icon" > $localIcon
		fi
		notify-send -t 5000 -i "$localIcon" "${(C)n}" "$entry"
		notified=$(echo "$notified\n$inSubsFile")
	fi
done

echo $notified > $notifiedFile
