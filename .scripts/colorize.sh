#!/bin/sh
dir="."   #Set the default temp dir
tmpA1="$dir/spectrumhist_1_$$.png"
tmpB1="$dir/spectrumhist_1_$$.cache"
output_16="/tmp/colors-16-output"
output_3="/tmp/colors-3-output"
output_2="/tmp/colors-2-output"
output_8="/tmp/colors-8-output"
trap "rm -f $tmpA1 $tmpB1; exit 0" 0   #remove temp files
trap "rm -f $tmpA1 $tmpB1; exit 1" 1 2 3 15  #remove temp files

print_color_palette(){
	for i in {0..15}
	do
		echo " $i)	$(tput setaf $i) ███"
		printf '\e[0m'
	done
}

generate(){
	if [ ! -f "$1" ]
	then
		echo "Incorrect file path. No such file found."
		exit 1
	else
		colors=$2
		convert -quiet -regard-warnings "$1" -alpha off +dither -colors $colors -depth 8 +repage "$tmpA1"
		convert "$tmpA1" -set colorspace RGB -colorspace rgb -format %c -define histogram:unique-colors=true histogram:info:- | \
			sed -n 's/^ *\(.*\): (\(.*,\)\(.*,\)\(.*\)) #\(.*\) rgb(\(.*\))$/\1 \2 \3 \4 \5 \6/p' | \
			sort -n -k 1,1 | \
			awk -v wd=10 -v mag=1 '
		{ list=""; i=NR; count[i]=$1; rgb[i]=$2 $3 $4; hex[i]=$5; hsl[i]=$6 }
	END { for (i=1; i<=NR; i++)
	{ ht[i]=int(10000*count[i]/count[NR])/100; list=""hex[i]"" list; if(i<NR){list = "\n" list}}
	list="" list "";print list; }'\
		> $3
fi
}

randomize(){
	new=$(cat $1 | sort --random-sort)
	echo "$new" > $1
}

recolor_xres(){
	specific_color="$1"
	echo "recoloring Xresources..."
	colors=($(<$output_16))
	config="$HOME/.Xresources"
	config_backup="$config-backup"
	xres=$(cat $config)
	if [ ! -f $config_backup ]
	then
		cp $config $config_backup
	fi
	if [[ -z $specific_color ]]
	then
		for i in ${!colors[@]}
		do
			line="$(printf '#define base0%x' $i)"
			xres=$(echo "$xres" | sed -E "s/$line #.{6}/$line #${colors[i]}/ig")
		done
	else
		line="$(printf '#define base0%x' $specific_color)"
		current_color=$(echo "$xres" | awk "/$line/ {print \$3}" | tr -d '# \n')
		n=$(echo ${colors[@]} | tr -s " " "\n" | grep -n "$current_color" | cut -d":" -f 1)
		if [[ $n -ge ${#colors[@]} ]]
		then
			n=0
		fi
		xres=$(echo "$xres" | sed -E "s/$line #.{6}/$line #${colors[n]}/ig")
	fi
	echo "$xres" > $config
	xrdb $config
	killall -USR1 urxvt
}

switch_xres(){
	config="$HOME/.Xresources"
	config_backup="$config-backup"
	xres=$(cat $config)
	if [ ! -f $config_backup ]
	then
		cp $config $config_backup
	fi
	colors=($(echo "$xres" | awk '/#define base0. #.{0,8}/ {print $3}' | cut -c 2-7))
	echo ${colors[0]}
	color1=$1
	color2=$2
	line1="$(printf '#define base0%x' $color1)"
	line2="$(printf '#define base0%x' $color2)"
	xres=$(echo "$xres" | sed -E "s/$line1 #.{6}/$line1 #${colors[$color2]}/ig")
	xres=$(echo "$xres" | sed -E "s/$line2 #.{6}/$line2 #${colors[$color1]}/ig")
	echo "$xres" > $config
	xrdb $config
	killall -USR1 urxvt
}

recolor_bspwm(){
	echo "recoloring bspwm..."
	colors=($(<$output_8))
	colors=$(echo $colors | sort -r)

	config="$HOME/.config/bspwm/bspwmrc"
	config_backup="$config-backup"
	xres=$(cat $config)
	identifiers=("active_border_color" "normal_border_color" "focused_border_color")
	if [ ! -f $config_backup ]
	then
		cp "$config" "$config_backup"
	fi
	for i in ${!identifiers[@]}
	do
		line="bspc config ${identifiers[i]}"
		xres=$(echo "$xres" | sed -E "s/$line '#.{6}'/$line '#${colors[i]}'/ig")
		$line "#${colors[i]}"
	done
	echo "$xres" > $config
}

recolor_polybar(){
	echo "recoloring polybar..."
	colors=($(<$output_8))
	config="$HOME/.config/polybar/config"
	config_backup="$config-backup"
	xres=$(cat $config)
	identifiers=("foreground =")
	rand=$(shuf -i 0-$[${#colors[@]}-1] -n 1)
	echo $rand
	if [ ! -f $config_backup ]
	then
		cp "$config" "$config_backup"
	fi
	for i in ${!colors[@]}
	do
		line="${identifiers[i]}"
		xres=$(echo "$xres" | sed -E "s/^$line #.{0,8}$/$line #${colors[$rand]}/ig")
	done
	echo "$xres" > $config
	barname=$(cat $config | grep -i "\[bar" | sed 's/.*\///i; s/]//')
	killall polybar
	polybar $barname &!
}

recolor_conky(){
	echo "recoloring conky..."
	colors=($(<$output_8))
	config="$HOME/.config/conky/*.conf"
	identifiers=("default_color =")
	rand=$(shuf -i 0-$[${#colors[@]}-1] -n 1)
	for f in $config
	do
		xres=$(cat $f)
		line="${identifiers[0]}"
		xres=$(echo "$xres" | sed -E "s/$line '.{0,8}'/$line '${colors[$rand]}'/ig")
		echo "$xres" > $f
	done
}

cycle(){
while true
do
	if [[ -z $5 ]]
	then
		clear
		"$1" -r "$2"
		$3
		sleep "$4"
	else
		"$1" -r "$2" && urxvt -e sh -c "$3" && sleep "$4"
	fi
done
}


case "$1" in
	--generate | -g)
		generate $2 16 $output_16
		generate $2 8 $output_8
		;;
	--randomize | -r)
		if [[ $2 =~ "x" ]]
		then
			if [[ -z $3 ]]
			then
				echo "randomizing Xresources..."
				randomize $output_16
				recolor_xres
			else
				echo "randomizing Xresources..."
				recolor_xres $3
			fi
		elif [[ $2 =~ "bspwm" ]]
		then
			randomize $output_8
			recolor_bspwm
		elif [[ $2 =~ "polybar" ]]
		then
			randomize $output_8
			recolor_polybar
		elif [[ $2 =~ "conky" ]]
		then
			randomize $output_8
			recolor_conky
		fi
		;;
	--wallpaper | -w)
		feh --bg-fill $1
		;;
	--bspwm | -b)
		recolor_bspwm
		;;
	--cycle | -c)
		echo "kill the loop with Ctrl-C when happy"
		if [[ $2 =~ "x" ]]
		then
			cycle $0 "x" "killall -USR1 urxvt" 1
		elif [[ $2 =~ "bspwm" ]]
		then
			cycle $0 "bspwm" "" 1
		elif [[ $2 =~ "polybar" ]]
		then
			cycle $0 "polybar" "" 2
		elif [[ $2 =~ "conky" ]]
		then
			cycle $0 "conky" "" 2
		fi
		;;
	--everything | -e)
		generate $2 "16" $output_16
		generate $2 "8" $output_8
		recolor_xres
		recolor_bspwm
		recolor_polybar
		recolor_conky
		feh --bg-fill $2
		;;
	--print-palette | -p)
		print_color_palette
		;;
	--switch | -s)
		switch_xres $2 $3
		;;
esac
