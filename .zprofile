
XDG_CONFIG_HOME=$HOME/.config
LANG=en_GB.utf8

#if [[ ! -s $HOME/.dbus/Xdbus ]]; then
	#mkdir -p $HOME/.dbus
	#touch $HOME/.dbus/Xdbus
	#chmod 600 $HOME/.dbus/Xdbus
	#env | grep DBUS_SESSION_BUS_ADDRESS > $HOME/.dbus/Xdbus
	#echo 'export DBUS_SESSION_BUS_ADDRESS' >> $HOME/.dbus/Xdbus
#fi

#eval $(ssh-agent)
#ssh-add ~/.ssh/github
#ssh-add ~/.ssh/id_rsa
#ssh-add ~/.ssh/gitlab
#ssh-add ~/.ssh/llevickasdev
#ssh-add ~/.ssh/hwp0.l.dedikuoti.lt

export EDITOR="vim"
export BROWSER="qutebrowser"
export PATH="$PATH:$HOME/.scripts"
export SXHDK_SHELL=/bin/bash
export VISUAL="$EDITOR"
export XDG_CONFIG_HOME=$HOME/.config
export _JAVA_AWT_WM_NONREPARENTING=1
#export allow_rgb10_configs=false
export BROWSER="$HOME/.scripts/qutebrowser-nouveau.sh"

source /usr/share/fzf/completion.zsh
source /usr/share/fzf/fzf-extras.zsh
source /usr/share/fzf/key-bindings.zsh
source ~/.devsh

#[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx

#export QT_QPA_PLATFORM=wayland-egl
export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
export _JAVA_AWT_WM_NONREPARENTING=1
export BEMENU_BACKEND=wayland 
[[ "$(tty)" = "/dev/tty1" ]] && exec sway
#[[ "$(tty)" = "/dev/tty1" ]] && exec sway -d 2> /home/lukas/sway.log
