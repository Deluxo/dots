#!/bin/sh
dir="."   #Set the default temp dir
tmpA1="$dir/spectrumhist_1_$$.png"
tmpB1="$dir/spectrumhist_1_$$.cache"
output_hex="/tmp/colors-xres-output"
output_ternary="/tmp/colors-bspwmrc-output"
output_binary="/tmp/colors-polybar-output"
trap "rm -f $tmpA1 $tmpB1; exit 0" 0   #remove temp files
trap "rm -f $tmpA1 $tmpB1; exit 1" 1 2 3 15  #remove temp files

generate(){
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
}

randomize(){
	new=$(cat $1 | sort --random-sort)
	echo "$new" > $1
}

recolor_xres(){
	echo "recoloring Xresources..."
	colors=($(<$output_hex))
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
	colors=($(<$output_ternary))
	colors=$(echo $colors | sort -r)

	config="$HOME/.config/bspwm/bspwmrc"
	config_backup="$config-backup"
	xres=$(cat $config)
	identifiers=("active_border_color" "normal_border_color" "focused_border_color")
	if [ ! -f $config_backup ]
	then
		cp "$config" "$config_backup"
	fi
	for i in ${!colors[@]}
	do
		line="bspc config ${identifiers[i]}"
		xres=$(echo "$xres" | sed -E "s/$line '#.{6}'/$line '#${colors[i]}'/ig")
		echo "$line \#${colors[i]}"
		$line \#${colors[i]}
	done
	echo "$xres" > $config
}

recolor_polybar(){
	echo "recoloring polybar..."
	colors=($(<$output_binary))
	config="$HOME/.config/polybar/config"
	config_backup="$config-backup"
	xres=$(cat $config)
	identifiers=("foreground =")
	if [ ! -f $config_backup ]
	then
		cp "$config" "$config_backup"
	fi
	for i in ${!colors[@]}
	do
		line="${identifiers[i]}"
		xres=$(echo "$xres" | sed -E "s/^$line #.{6,8}$/$line #${colors[1]}/ig")
	done
	echo "$xres" > $config
	barname=$(cat $config | grep -i "\[bar" | sed 's/.*\///i; s/]//')
	killall polybar
	polybar $barname &!
}

recolor_conky(){
	echo "recoloring conky..."
	colors=($(<$output_binary))
	config="$HOME/.config/conky/*.conf"
	identifiers=("default_color =")
	for f in $config
	do
		xres=$(cat $f)
		line="${identifiers[0]}"
		xres=$(echo "$xres" | sed -E "s/$line '.{6,8}'/$line '${colors[1]}'/ig")
		echo "$xres" > $f
	done
}


case "$1" in
	--generate | -g)
		if [[ $2 =~ "x" ]]
		then
			echo "generating for Xresources..."
			generate $3 16 $output_hex
		elif [[ $2 =~ "bspwm" ]]
		then
			echo "generating for bspwm..."
			generate $3 3 $output_ternary
		elif [[ $2 =~ "polybar" ]] || [[ $2 =~ "conky" ]]
		then
			echo "generating for $2..."
			generate $3 2 $output_binary
		fi
		;;
	--randomize | -r)
		if [[ $2 =~ "x" ]]
		then
			echo "randomizing Xresources..."
			randomize $output_hex
			recolor_xres
		elif [[ $2 =~ "bspwm" ]]
		then
			randomize $output_ternary
			recolor_bspwm
		elif [[ $2 =~ "polybar" ]]
		then
			randomize $output_binary
			recolor_polybar
		elif [[ $2 =~ "conky" ]]
		then
			randomize $output_binary
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
		echo "generating for Xresources..."
		generate $2 "16" $output_hex

		echo "generating for bspwm..."
		generate $2 "3" $output_ternary

		echo "generating for polybar & conky..."
		generate $2 "2" $output_binary

		recolor_xres
		recolor_bspwm
		recolor_polybar
		recolor_conky
		feh --bg-fill $2
		;;
esac
