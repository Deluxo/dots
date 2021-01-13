#! /bin/sh

color0='#1f222e55'
color1='#ea51b2'
color2='#9294b3'
color3='#00f769'
color4='#62d6e8'
color5='#b45bcf'
color6='#a1efe4'
color7='#e9e9f4'

export BEMENU_BACKEND=wayland
export BEMENU_OPTS=$(cat <<EOF
-biw 
-P "❯" 
-p "❯" 
-H 38 
--fn "Fira Code 13" 
--tb "$color0" 
--tf "$color7" 
--fb "$color0" 
--ff "$color2" 
--hb "$color0" 
--hf "$color1" 
--sb "$color0" 
--scb "$color0" 
--nb "$color0" 
--nf "$color7" 
EOF
)
