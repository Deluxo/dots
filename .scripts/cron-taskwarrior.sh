#! /bin/zsh

if [ -r "$HOME/.dbus/Xdbus" ]; then
  . "$HOME/.dbus/Xdbus"
fi
export DISPLAY=:0.0
export XAUTHORITY="$HOME/.Xauthority"

icon="/usr/share/icons/EvoPop/512x512/mimetypes/text-x-generic.png"
body="$(task ls | head -n -2 | tail -n +4)"

if [[ -n $body ]]; then
	notify-send "TaskWarrior" "$body"
fi
