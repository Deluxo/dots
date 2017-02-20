#! /bin/zsh

context=$(xclip -o);
msg="couldn't find anything to play"

if [[ $context =~ "twitch.tv" ]]; then
	msg="Twitch.tv"
	livestreamer $context best --player mpv&!
elif [[ $context =~ "youtube" ]]; then
	msg="Youtube"
	mpv $context &!
elif [[ $context =~ "magnet:" ]]; then
	msg="Magnet"
	peerflix "$context" -f "Downloads/" -k &!
elif [[ $context =~ ".torrent" ]]; then
	msg="selected torrent file"
	peerflix "$context" -f "Downloads/" -k &!
elif [[ $context =~ "http" ]]; then
	msg="Some http stream"
	mpv $context &!
elif ls ~/Downloads/*.torrent 1> /dev/null 2>&1; then
	file=$(ls -1t ~/Downloads/*.torrent | head -n 1)
	fileModDate=$(stat -c %Y "$file")
	now=$(date +%s)
	freshness=$(($now-$fileModDate))
	if [[ $freshness -lt 3000 ]]; then
		msg="Latest torrent file"
		peerflix "$file" -f "Downloads/" -k &!
	fi
fi

notify-send "Context Runner" "$msg"
