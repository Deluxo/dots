#! /bin/bash

defaultmode="dimblur" # " " "dim" "blur" "dimblur"
lockfile="/tmp/lock.sh.lock"
folder="$HOME/.cache/i3lock"
resized="$folder/resized.png" # resized image for your resolution
dim="$folder/dim.png" # image with subtle overlay of black
blur="$folder/blur.png" # blurred version
dimblur="$folder/dimblur.png"
l_resized="$folder/l_resized.png"
l_dim="$folder/l_dim.png"
l_blur="$folder/l_blur.png"
l_dimblur="$folder/l_dimblur.png"
wallpaper="$(cat .fehbg | awk '{print $3}' | sed "s/'//g" | tail -n 1)"

prelock() {
	pkill -u "$USER" -USR1 dunst
	playerctl pause
}

lock() {
	#$1 image path
	letterEnteredColor=02a7fdff
	letterRemovedColor=d23c3dff
	passwordCorrect=00000000
	passwordIncorrect=d23c3dff
	background=00000000
	foreground=ffffffff
	i3lock \
		-n -i "$1" \
		--timepos="x-90:h-ch+30" \
		--datepos="tx+24:ty+25" \
		--clock --datestr "Type password to unlock..." \
		--insidecolor=$background --ringcolor=$foreground --line-uses-inside \
		--keyhlcolor=$letterEnteredColor --bshlcolor=$letterRemovedColor --separatorcolor=$background \
		--insidevercolor=$passwordCorrect --insidewrongcolor=$passwordIncorrect \
		--ringvercolor=$foreground --ringwrongcolor=$foreground --indpos="x+280:h-70" \
		--radius=20 --ring-width=4 --veriftext="" --wrongtext="" \
		--textcolor="$foreground" --timecolor="$foreground" --datecolor="$foreground"
}

postlock() {
	pkill -u "$USER" -USR2 dunst
	playerctl play
}

# Options
case "$1" in
	"")
		xautolock -locknow
		;;
	-l | --lock)
		case "$2" in
			"")
				prelock
				playerctl pause
				lock "$l_resized"
				postlock
				;;
			dim)
				prelock
				lock "$l_dim"
				postlock
				;;
			blur)
				prelock
				lock "$l_blur"
				postlock
				;;
			dimblur)
				prelock
				lock "$l_dimblur"
				postlock
				;;
		esac
		;;
	-u | --update)
		rectangles=" "
		SR=$(xrandr --query | grep ' connected' | grep -o '[0-9][0-9]*x[0-9][0-9]*[^ ]*')
		for RES in $SR; do
			SRA=(${RES//[x+]/ })
			CX=$((${SRA[2]} + 25))
			CY=$((${SRA[1]} - 30))
			rectangles+="rectangle $CX,$CY $((CX+300)),$((CY-80)) "
		done
		y_res=$(xdpyinfo | grep dimensions | sed -r 's/^[^0-9]*([0-9]+x[0-9]+).*$/\1/')
		mkdir -p "$folder"
		convert "$wallpaper" -resize "$y_res""^" -gravity center -extent "$y_res" "$resized"
		convert "$resized" -fill black -colorize 40% "$dim"
		convert "$resized" -blur 0x5 "$blur"
		convert "$dim" -blur 0x5 "$dimblur"
		convert "$resized" -draw "fill black fill-opacity 0.4 $rectangles" "$l_resized"
		convert "$dim" -draw "fill black fill-opacity 0.4 $rectangles" "$l_dim"
		convert "$blur" -draw "fill black fill-opacity 0.4 $rectangles" "$l_blur"
		convert "$dimblur" -draw "fill black fill-opacity 0.4 $rectangles" "$l_dimblur"
		;;

	--on)
		echo 'locked' > $lockfile
		xset +dpms
		xset s on
		xautolock -locker "$0 -l $defaultmode" -time 1 &
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
		#if [ -f $lockfile ]; then
			#$0 --off
		#else
			#$0 --on
		#fi
		if [[ -f $lockfile ]] && [[ $(<$lockfile) == 'locked' ]]; then
			$0 --off --allow-blanking
		elif [[ -f $lockfile ]] && [[ $(<$lockfile) == 'blanking' ]]; then
			$0 --off
		else
			$0 --on
		fi
		;;
esac

