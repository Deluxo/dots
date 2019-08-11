#[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
if [ "$(tty)" = "/dev/tty1" ]; then
	exec sway
fi
