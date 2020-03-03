#! /bin/bash
path="$HOME/Pictures/Screenshots"
name="scr_$(date +%F_%T | sed 's#:\|\-#_#g').png"

fp="$path/$name"

mkdir -p $path;

sway=$(ps a -o command | grep ^sway)


toClipboardCmd='wl-copy'
captureCmd='grim'
captureAreaCmd='grim -g "$(slurp)"'

if [[ -z $sway ]]; then
	toClipboardCmd='xclip -i -selection clipboard'
	captureCmd='maim'
	captureAreaCmd='maim -s'
fi

if [[ "$@" =~ "area" ]];then
	eval $captureAreaCmd $fp
else
	$captureCmd $fp
fi

echo $fp | $toClipboardCmd

if [[ "$@" =~ "online" ]]; then
	file="$(readlink -f $fp)"
	basefile="$( basename "$file" | sed -e 's/[^a-zA-Z0-9._-]/-/g' )"
	curl -s --upload-file "$file" "https://transfer.sh/$basefile" | $toClipboardCmd
fi
