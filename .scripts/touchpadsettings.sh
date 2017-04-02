touchpadID=$(xinput list | grep -i touchpad | cut -f 2 | cut -d "=" -f 2)
echo "touchpad: $touchpadID"
tappingSetting=$(xinput list-props $touchpadID | grep -i "Tapping Enabled" | head -n 1 | cut -f 2 -d "(" | cut -f 1 -d ")")
xinput set-prop $touchpadID $tappingSetting 1
