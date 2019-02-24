#! /bin/sh

killall xwinwrap &> /dev/null

nice -n 19 xwinwrap -ov -ni -fs -- mpv --no-stop-screensaver -wid WID --keepaspect=yes --volume 0 --panscan 1 --loop "$1" --speed 1 -ao null --af='' > /dev/null 2>&1 &!
