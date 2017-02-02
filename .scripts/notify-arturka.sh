#! /bin/zsh

if [ -r "$HOME/.dbus/Xdbus" ]; then
  . "$HOME/.dbus/Xdbus"
fi
export DISPLAY=:0.0

medis="$(/home/lukas/.scripts/arturka.sh)"
notify-send "Artūrkos medinis" "$medis"
