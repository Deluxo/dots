#! /bin/bash
path="$HOME/Pictures/Screenshots"
name="scr-$(date +%T).png"

mkdir -p $path;

if [[ $1 == 'area' ]];then
	maim -s $path/$name
else
	scrot $path/$name
fi
