#! /bin/zsh

context=$(xclip -o);
msg="couldn't find anything to play"
term='urxvt'

if [[ $context =~ "twitch.tv" ]]; then
	msg="Twitch.tv"
	livestreamer $context best --player mpv&!
elif [[ $context =~ "youtube" ]]; then
	msg="Youtube"
	mpv $context &!
elif [[ $context =~ "magnet:" ]]; then
	msg="Magnet"
	$term -e zsh -c "peerflix \"$context\" -f \"Downloads/\" -k -l"
elif [[ $context =~ ".torrent" ]]; then
	msg="selected torrent file"
	$term -e zsh -c "peerflix \"$context\" -f \"Downloads/\" -k -l"
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
		$term -e zsh -c "peerflix \"$file\" -f Downloads/ -k -l"
	fi
fi

notify-send "Context Runner" "$msg"
