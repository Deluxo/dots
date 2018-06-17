#! /bin/bash

# sudo sensei-raw-ctl --mode normal
# sudo sensei-raw-ctl --polling 1000
# sudo sensei-raw-ctl --cpi-on 700
# sudo sensei-raw-ctl --cpi-off 1500
# sudo sensei-raw-ctl --pulsation steady
# sudo sensei-raw-ctl --save

sudo sensei-raw-ctl --intensity low
sudo sensei-raw-ctl --mode normal
sudo sensei-raw-ctl --polling 1000
sudo sensei-raw-ctl --cpi-off 1170
sudo sensei-raw-ctl --cpi-on 5670

if [[ "$(/usr/bin/sudo /usr/bin/sensei-raw-ctl --show)" =~ "steady" ]]; then
	sudo sensei-raw-ctl --pulsation trigger
else
	sudo sensei-raw-ctl --pulsation steady
fi

sudo sensei-raw-ctl --save
