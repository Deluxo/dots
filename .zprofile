XDG_CONFIG_HOME=$HOME/.config
LANG=en_GB.utf8

#if [[ ! -s $HOME/.dbus/Xdbus ]]; then
	#mkdir -p $HOME/.dbus
	#touch $HOME/.dbus/Xdbus
	#chmod 600 $HOME/.dbus/Xdbus
	#env | grep DBUS_SESSION_BUS_ADDRESS > $HOME/.dbus/Xdbus
	#echo 'export DBUS_SESSION_BUS_ADDRESS' >> $HOME/.dbus/Xdbus
#fi

export TERM="kitty"
export EDITOR="vim"
export BROWSER="/usr/bin/qutebrowser"
export PATH="$PATH:$HOME/.scripts"
export SXHDK_SHELL=/bin/bash
export VISUAL="$EDITOR"
export XDG_CONFIG_HOME=$HOME/.config
export _JAVA_AWT_WM_NONREPARENTING=1

export MOZ_ENABLE_WAYLAND=1
export MOZ_WAYLAND_USE_VAAPI=1
export QT_QPA_PLATFORM=wayland
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_TYPE=wayland

[[ "$(tty)" = "/dev/tty1" ]] && exec sway
