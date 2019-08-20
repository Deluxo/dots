#[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx

XDG_CONFIG_HOME=$HOME/.config
LANG=en_GB.utf8

if [[ ! -s $HOME/.dbus/Xdbus ]]; then
	mkdir -p $HOME/.dbus
	touch $HOME/.dbus/Xdbus
	chmod 600 $HOME/.dbus/Xdbus
	env | grep DBUS_SESSION_BUS_ADDRESS > $HOME/.dbus/Xdbus
	echo 'export DBUS_SESSION_BUS_ADDRESS' >> $HOME/.dbus/Xdbus
fi

eval $(ssh-agent)
ssh-add ~/.ssh/github
ssh-add ~/.ssh/id_rsa
ssh-add ~/.ssh/gitlab
ssh-add ~/.ssh/llevickasdev

export EDITOR="vim"
export PATH="$PATH:$HOME/.scripts"
export SXHDK_SHELL=/bin/bash
export VISUAL="$EDITOR"
export XDG_CONFIG_HOME=$HOME/.config
export _JAVA_AWT_WM_NONREPARENTING=1
export allow_rgb10_configs=false
export QT_QPA_PLATFORM=wayland-egl
#export SDL_VIDEODRIVER=wayland
export CLUTTER_BACKEND=wayland

source ~/.devsh

if [ "$(tty)" = "/dev/tty1" ]; then
	exec sway
fi
