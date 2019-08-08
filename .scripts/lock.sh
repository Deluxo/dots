#! /bin/bash

if [[ -z $(which i3lock) ]]; then
	msg="Get i3lock from: https://github.com/PandorasFox/i3lock-color"
	notify-send "Error" "$msg"
	echo $msg;
	exit 1;
fi

defaultmode="" # " " "dim" "blur" "dimblur"
lockfile="/tmp/lock.sh.lock"
folder="$HOME/.cache/i3lock"

prelock() {
	pkill -u "$USER" -USR1 dunst
	if [[ $(playerctl status) == 'Playing' ]]; then
		echo 1 > "$lockfile.isplaying"
		playerctl pause
	else
		if [[ -f "$lockfile.isplaying" ]]; then
			rm "$lockfile.isplaying"
		fi
	fi
}

lock() {
	i3lock \
		--blur 10 \
\
		--insidecolor=00000055 \
		--insidevercolor=ffffff22 \
		--insidewrongcolor=ffffff22 \
\
		--ringcolor=ffffff11 \
		--ringvercolor=ffffff22 \
		--ringwrongcolor=ffffff22 \
\
		--keyhlcolor=ffffffff \
		--bshlcolor=ffffff88 \
		--separatorcolor=ffffff00 \
\
		--verifcolor=ffffffff \
		--wrongcolor=ffffffff \
		--layoutcolor=ffffffff \
		--timecolor=ffffffff \
		--datecolor=ffffffff \
\
		--verif-font=inter \
		--wrong-font=inter \
		--layout-font=inter \
		--time-font=inter \
		--date-font=inter \
\
		--radius 100 \
		--ring-width 5 \
		--line-uses-ring \
		--clock \
		--indicator \
		--show-failed-attempts
}

postlock() {
	pkill -u "$USER" -USR2 dunst
	if [[ -f "$lockfile.isplaying" ]]; then
		playerctl play
		rm "$lockfile.isplaying"
	fi
}

# Options
case "$1" in
	"")
		xautolock -locknow
		;;
	-l | --lock)
		case "$2" in
			"")
				#prelock
				#playerctl pause
				lock
				#postlock
				;;
		esac
		;;
	--on)
		echo 'locked' > $lockfile
		xset +dpms
		xset s on
		xautolock -locker "$0 -l $defaultmode" -time 1 &!
		;;
	--off)
		rm $lockfile
		killall xautolock
		if [[ $2 == '--allow-blanking' ]]; then
			echo 'blanking' > $lockfile
			xset +dpms
			xset s on
		else
			xset -dpms
			xset s off
		fi
		;;
	--toggle)
		if [[ -f $lockfile ]] && [[ $(<$lockfile) == 'locked' ]]; then
			$0 --off --allow-blanking
		elif [[ -f $lockfile ]] && [[ $(<$lockfile) == 'blanking' ]]; then
			$0 --off
		else
			$0 --on
		fi
		;;
esac

