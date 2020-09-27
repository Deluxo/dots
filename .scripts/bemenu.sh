#! /bin/sh

color0=#0c0d0e
color1=#e31a1c
color2=#31a354
color3=#dca060
color4=#3182bd
color5=#756bb1
color6=#80b1d3
color7=#b7b8b9

export BEMENU_BACKEND=wayland
export BEMENU_OPTS=$(cat <<EOF
-b
-i
-w
-p '❯'
--fn 'Scientifica 18px'
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
