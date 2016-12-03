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
	echo "recoloring Xresources..."
	colors=($(<$output_16))
	config="$HOME/.Xresources"
	config_backup="$config-backup"
	xres=$(cat $config)
	if [ ! -f $config_backup ]
	then
		cp $config $config_backup
	fi
	for i in ${!colors[@]}
	do
		line="$(printf '#define base0%x' $i)"
		xres=$(echo "$xres" | sed -E "s/$line #.{6}/$line #${colors[i]}/ig")
	done
	echo "$xres" > $config
	xrdb $config
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


case "$1" in
	--generate | -g)
		generate $3 16 $output_16
		generate $3 8 $output_8
		;;
	--randomize | -r)
		if [[ $2 =~ "x" ]]
		then
			echo "randomizing Xresources..."
			randomize $output_16
			recolor_xres
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
	--everything | -e)
		generate $2 "16" $output_16
		generate $2 "8" $output_8
		recolor_xres
		recolor_bspwm
		recolor_polybar
		recolor_conky
		feh --bg-fill $2
		;;
esac
