! /bin/zsh

sleep 4 && plank &

sleep 6 && ~/.scripts/bar.sh &

sleep 8 && compton --config ~/.config/compton/compton.conf --dbus &

sleep 10 && ~/.scripts/start-conkies.sh &

sleep 20 && mopidy &

#stalonetray -p -f --window-type desktop --grow-gravity W &
