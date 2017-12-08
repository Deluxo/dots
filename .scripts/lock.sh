#! /bin/bash
folder="$HOME/.cache/i3lock"
resized="$folder/resized.png" # resized image for your resolution
dim="$folder/dim.png" # image with subtle overlay of black
blur="$folder/blur.png" # blurred version
dimblur="$folder/dimblur.png"
l_resized="$folder/l_resized.png"
l_dim="$folder/l_dim.png"
l_blur="$folder/l_blur.png"
l_dimblur="$folder/l_dimblur.png"
wallpaper=$(cat .fehbg | awk '{print $3}' | sed "s/'//g" | tail -n 1)

# Options
case "$1" in
	-l | --lock)
		case "$2" in
			"")
				pkill -u "$USER" -USR1 dunst
				playerctl pause
				i3lock \
					-n -i "$l_resized" \
					--timepos="x-90:h-ch+30" \
					--datepos="tx+24:ty+25" \
					--clock --datestr "type password to unlock..." \
					--insidecolor=00000000 --ringcolor=ffffffff --line-uses-inside \
					--keyhlcolor=d23c3dff --bshlcolor=d23c3dff --separatorcolor=00000000 \
					--insidevercolor=fecf4dff --insidewrongcolor=d23c3dff \
					--ringvercolor=ffffffff --ringwrongcolor=ffffffff --indpos="x+280:h-70" \
					--radius=20 --ring-width=3 --veriftext="" --wrongtext="" \
					--textcolor="ffffffff" --timecolor="ffffffff" --datecolor="ffffffff"
				pkill -u "$USER" -USR2 dunst
				;;
			dim)
				pkill -u "$USER" -USR1 dunst
				i3lock \
					-n -i "$l_dim" \
					--timepos="x-90:h-ch+30" \
					--datepos="tx+24:ty+25" \
					--clock --datestr "Type password to unlock..." \
					--insidecolor=00000000 --ringcolor=ffffffff --line-uses-inside \
					--keyhlcolor=d23c3dff --bshlcolor=d23c3dff --separatorcolor=00000000 \
					--insidevercolor=fecf4dff --insidewrongcolor=d23c3dff \
					--ringvercolor=ffffffff --ringwrongcolor=ffffffff --indpos="x+280:h-70" \
					--radius=20 --ring-width=3 --veriftext="" --wrongtext="" \
					--textcolor="ffffffff" --timecolor="ffffffff" --datecolor="ffffffff"
				pkill -u "$USER" -USR2 dunst
				;;
			blur)
				pkill -u "$USER" -USR1 dunst
				i3lock \
					-n -i "$l_blur" \
					--timepos="x-90:h-ch+30" \
					--datepos="tx+24:ty+25" \
					--clock --datestr "Type password to unlock..." \
					--insidecolor=00000000 --ringcolor=ffffffff --line-uses-inside \
					--keyhlcolor=d23c3dff --bshlcolor=d23c3dff --separatorcolor=00000000 \
					--insidevercolor=fecf4dff --insidewrongcolor=d23c3dff \
					--ringvercolor=ffffffff --ringwrongcolor=ffffffff --indpos="x+280:h-70" \
					--radius=20 --ring-width=3 --veriftext="" --wrongtext="" \
					--textcolor="ffffffff" --timecolor="ffffffff" --datecolor="ffffffff"
				pkill -u "$USER" -USR2 dunst
				;;
			dimblur)
				pkill -u "$USER" -USR1 dunst
				i3lock \
					-n -i "$l_dimblur" \
					--timepos="x-90:h-ch+30" \
					--datepos="tx+24:ty+25" \
					--clock --datestr "Type password to unlock..." \
					--insidecolor=00000000 --ringcolor=ffffffff --line-uses-inside \
					--keyhlcolor=d23c3dff --bshlcolor=d23c3dff --separatorcolor=00000000 \
					--insidevercolor=fecf4dff --insidewrongcolor=d23c3dff \
					--ringvercolor=ffffffff --ringwrongcolor=ffffffff --indpos="x+280:h-70" \
					--radius=20 --ring-width=3 --veriftext="" --wrongtext="" \
					--textcolor="ffffffff" --timecolor="ffffffff" --datecolor="ffffffff"
				pkill -u "$USER" -USR2 dunst
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
esac

