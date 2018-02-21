#! /bin/zsh

context=$(xclip -o);
msg="couldn't find anything to play"
term='alacritty'

torrent() {
	file=$1
	destination="Downloads" # Relative to $HOME
	lsblkItem=$(lsblk  -l | sed '/^.*sda.*$/d' | tail -n +2 | grep -w sd\[a-z]\[1-9] | awk '{print $1}')
	if [[ -n $lsblkItem ]]; then
		altDestination="/mnt/lukas/videos"
		if [[ ! -d $altDestination ]]; then
			$term -e zsh -c "echo mount additional disk for destination disk;sudo mount /dev/$(lsblk -l | tail -n 1 | awk '{print $1}') /mnt; mkdir -p $altDestination"
		fi
		destination=$altDestination
	fi
	if [[ $freshness -lt 3000 ]]; then
		msg="Latest torrent file"
		$term -e zsh -c "echo Downloading to $(lsblk -l | tail -n 1 | awk '{print $1 " " $4}'): $destination; peerflix \"$file\" -f $destination/ -k -l"

	fi
}

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
	torrent $context
elif [[ $context =~ "http" ]]; then
	msg="Some http stream"
	mpv $context &!
elif ls ~/Downloads/*.torrent 1> /dev/null 2>&1; then
	file=$(ls -1t ~/Downloads/*.torrent | head -n 1)
	fileModDate=$(stat -c %Y "$file")
	now=$(date +%s)
	freshness=$(($now-$fileModDate))
	if [[ $freshness -lt 3000 ]]; then
		torrent $file
	fi
fi

notify-send "Context Runner" "$msg"
