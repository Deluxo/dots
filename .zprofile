XDG_CONFIG_HOME=$HOME/.config
LANG=en_GB.utf8

#if [[ ! -s $HOME/.dbus/Xdbus ]]; then
	#mkdir -p $HOME/.dbus
	#touch $HOME/.dbus/Xdbus
	#chmod 600 $HOME/.dbus/Xdbus
	#env | grep DBUS_SESSION_BUS_ADDRESS > $HOME/.dbus/Xdbus
	#echo 'export DBUS_SESSION_BUS_ADDRESS' >> $HOME/.dbus/Xdbus
#fi

export BASE16_SHELL=$HOME/.config/base16-shell
export DMENU="rofi"
export TERM_CMD="kitty"
export EDITOR="vim"
export BROWSER="/usr/bin/qutebrowser"
export PATH="$PATH:$HOME/.scripts"
export SXHDK_SHELL=/bin/bash
export VISUAL="$EDITOR"
export XDG_CONFIG_HOME=$HOME/.config
export _JAVA_AWT_WM_NONREPARENTING=1
startx
