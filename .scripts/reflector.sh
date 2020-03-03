#! /bin/bash

reflector --verbose --protocol http --latest 5 --sort rate --save /etc/pacman.d/mirrorlist
