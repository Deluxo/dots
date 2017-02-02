#! /bin/zsh

if [ -r "$HOME/.dbus/Xdbus" ]; then
  . "$HOME/.dbus/Xdbus"
fi
export DISPLAY=:0.0

tasks=$(task ls)

if [ $tasks -z ]
then
	notify-send "Task" "You are not living your fullest\!\nMake new tasks\!"
else
	notify-send "Task `task ls | head -n -1`"
fi
