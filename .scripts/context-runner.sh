#! /bin/zsh

context=$(xclip -o);


# Video
if [[ $context =~ "twitch.tv" ]]; then
	livestreamer $context best --player mpv&!
elif [[ $context =~ "youtube.com" || $context =~ "youtu.be" ]]; then
	mpv $context
# Torrent
elif [[ $context =~ "magnet:" ]]; then
	peerflix "$context" -f "Downloads/" -k &!
elif [[ $context =~ ".torrent" ]]; then
	peerflix "$context" -f "Downloads/" -k &!
else
	notify-send "Clipboard" "No possible solutions to clipboard data found";
fi
