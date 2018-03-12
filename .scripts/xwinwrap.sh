#! /bin/sh

xwinwrap -ov -ni -fs -- mpv -wid WID --keepaspect=yes --volume 0 --panscan 1 --loop "$1" &!
