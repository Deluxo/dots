#! /bin/zsh

export DISPLAY=:0.0

popsFile=/tmp/gotwitch-popular
subsFile=/tmp/gotwitch-subscriptions
notifiedFile=/tmp/gotwitch-notified
touch $notifiedFile

gotwitch -lbg --padding 0 > $subsFile
gotwitch -lg --padding 0 > $popsFile

subs=$(cat $subsFile)
notified=$(cat $notifiedFile)
notify=($(echo "$subs" | awk '{print $1}'))

for n in $notify; do
	inSubsFile=$(echo "$subs" | grep -i $n)

	oldStream=$(echo "$notified" | grep "$n" | grep -v "$inSubsFile")
	if [[ -n "$oldStream" ]]; then
		notified=$(echo "$notified" | grep -vi $oldStream)
	fi;

	inNotifiedFile=$(echo "$notified" | grep "$inSubsFile")
	if [[ ! -n "$inNotifiedFile" ]]; then
		entry=$(echo "$inSubsFile" | sed "s/ / is playing /1")
		notify-send -t 10000 "Gotwitch" "$entry"
		notified=$(echo "$notified\n$inSubsFile")
	fi
done
echo $notified > /tmp/gotwitch-notified
