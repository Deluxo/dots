#!/bin/sh

XDG_CONFIG_HOME=$HOME/.config
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap
LANG=en_GB.utf8

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

if [[ ! -s $HOME/.dbus/Xdbus ]]; then
	mkdir -p $HOME/.dbus
	touch $HOME/.dbus/Xdbus
	chmod 600 $HOME/.dbus/Xdbus
	env | grep DBUS_SESSION_BUS_ADDRESS > $HOME/.dbus/Xdbus
	echo 'export DBUS_SESSION_BUS_ADDRESS' >> $HOME/.dbus/Xdbus
fi

eval $(ssh-agent)
#ssh-add ~/.ssh/github
#ssh-add ~/.ssh/id_rsa
#ssh-add ~/.ssh/gitlab
#ssh-add ~/.ssh/llevickasdev
ssh-add ~/.ssh/synergyeffect

#export SDL_AUDIODRIVER=alsa
#export APULSE_CAPTURE_DEVICE=default
#export APULSE_CAPTURE_DEVICE=plug:dsnoop
export EDITOR="vim"
export PATH="$PATH:$HOME/.scripts"
export SXHDK_SHELL=/bin/bash
export VISUAL="$EDITOR"
export XDG_CONFIG_HOME=$HOME/.config
export _JAVA_AWT_WM_NONREPARENTING=1
export SXHDK_SHELL=/bin/bash
export QT_WEBENGINE_DISABLE_NOUVEAU_WORKAROUND=1
#export MPD_HOST=/home/lukas/.config/mpd/socket
#export APULSE_CAPTURE_DEVICE=default
#export SDL_AUDIODRIVER=alsa
#export allow_rgb10_configs=false
#export APULSE_CAPTURE_DEVICE=plug:dsnoop
export PATH="$PATH:$HOME/.scripts"

#source ~/.devsh

mkdir -p $HOME/.dbus
touch $HOME/.dbus/Xdbus
chmod 600 $HOME/.dbus/Xdbus
env | grep DBUS_SESSION_BUS_ADDRESS > $HOME/.dbus/Xdbus
echo 'export DBUS_SESSION_BUS_ADDRESS' >> $HOME/.dbus/Xdbus

setxkbmap -option caps:escape
xsetroot -cursor_name left_ptr
~/.fehbg &
picom --experimental-backends &
exec xmonad
