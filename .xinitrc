#!/bin/sh

XDG_CONFIG_HOME=$HOME/.config
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap
LANG=en_GB.utf8

# merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

#if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
#fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

eval $(ssh-agent)
ssh-add ~/.ssh/github
ssh-add ~/.ssh/id_rsa
ssh-add ~/.ssh/gitlab

export VISUAL="vim"
export EDITOR="$VISUAL"
export GOPATH=$HOME/Documents/dev/golang
export GOBIN="$HOME/Documents/dev/golang/bin"
export ANDROID_HOME=$HOME/Documents/dev/android/sdk
export ANDROID_SDK_ROOT=$ANDROID_HOME
export XDG_CONFIG_HOME=$HOME/.config
export _JAVA_AWT_WM_NONREPARENTING=1
export SXHDK_SHELL=/bin/bash
export MPD_HOST=/home/lukas/.config/mpd/socket
export NPM_GLOBAL=/home/lukas/Documents/dev/js/npm
export PATH="$PATH:$GOBIN:$NPM_GLOBAL/bin:$HOME/Documents/dev/android/sdk/tools"
export APULSE_CAPTURE_DEVICE=default
export PATH="$HOME/.scripts:$HOME/Documents/dev/android/sdk/build-tools:$HOME/Documents/dev/android/sdk/tools:$HOME/Documents/dev/android/sdk/platform-tools/:$PATH"
export SDL_AUDIODRIVER=alsa
export allow_rgb10_configs=false

xsetroot -cursor_name left_ptr
~/.fehbg &
exec bspwm
