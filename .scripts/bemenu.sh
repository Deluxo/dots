#! /bin/sh

color0='#1b2b34'
color1='#ec5f67'
color2='#99c794'
color3='#fac863'
color4='#6699cc'
color5='#c594c5'
color6='#5fb3b3'
color7='#c0c5ce'

export BEMENU_BACKEND=wayland
export BEMENU_OPTS=$(cat <<EOF
-b
-i
-w
-p '❯'
--fn 'Overpass Semibold 18px'
--nb "$color0"
--tb "$color0"
--fb "$color0"
--ff "$color2"
--hb "$color0"
--hf "$color3"
--sb "$color0"
--scb "$color0"
--nf "$color7"
EOF
)
