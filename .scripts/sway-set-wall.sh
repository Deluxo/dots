#! /bin/sh

CONFIG="$XDG_CONFIG_HOME/sway/config"
echo "$(cat $CONFIG | sed "s#^set \$wallpaper .*#set \$wallpaper $1#")" > $CONFIG
swaymsg reload
