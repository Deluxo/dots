#! /bin/sh

if [ -r "$HOME/.dbus/Xdbus" ]; then
  . "$HOME/.dbus/Xdbus"
fi
export DISPLAY=:0.0
export XAUTHORITY="$HOME/.Xauthority"

$@
