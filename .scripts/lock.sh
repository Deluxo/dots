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
wallpaper="$2" || "$(cat .fehbg | awk '{print $3}' | sed "s/'//g" | tail -n 1)"

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
	timeFontSize=100
	dateFontSize=50
	i3lock \
		-n -i "$1" \
		--clock \
		--datestr "%A %m" --datepos="x+100:y+1250" \
		--timestr="%H:%M" --timepos="x+100:y+1190" \
		--time-align=1 --date-align=1 --layout-align=2 \
		--insidecolor=$background\
		--separatorcolor=$background \
		--line-uses-inside \
		--keyhlcolor=$letterEnteredColor \
		--bshlcolor=$letterRemovedColor \
		--insidevercolor=$passwordCorrect \
		--insidewrongcolor=$passwordIncorrect \
		--timecolor="$foreground" \
		--datecolor="$foreground" \
		--textcolor="$foreground"\
		--ringcolor=$foreground \
		--ringvercolor=$foreground \
		--ringwrongcolor=$foreground \
		--radius=100 --ring-width=10 \
		--veriftext="" --wrongtext="" \
		--timesize="$timeFontSize" --datesize="$dateFontSize"
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
				lock "$resized"
				postlock
				;;
			dim)
				prelock
				lock "$dim"
				postlock
				;;
			blur)
				prelock
				lock "$blur"
				postlock
				;;
			dimblur)
				prelock
				lock "$dimblur"
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
		if [[ -f $lockfile ]] && [[ $(<$lockfile) == 'locked' ]]; then
			$0 --off --allow-blanking
		elif [[ -f $lockfile ]] && [[ $(<$lockfile) == 'blanking' ]]; then
			$0 --off
		else
			$0 --on
		fi
		;;
esac

