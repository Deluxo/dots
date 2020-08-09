#! /bin/sh

color0='#1c1e26'
color1='#e93c58'
color2='#efaf8e'
color3='#efb993'
color4='#df5273'
color5='#b072d1'
color6='#24a8b4'
color7='#cbced0'

export BEMENU_BACKEND=wayland

bemenu-run \
-b \
-i \
-w \
-p '❯' \
--fn 'Overpass Semibold 18px' \
--nb "$color0" \
--tb "$color0" \
--fb "$color0" \
--ff "$color2" \
--hb "$color0" \
--sb "$color0" \
--scb "$color0" \
--nf "$color7" \
