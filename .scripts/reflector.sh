#! /bin/bash

reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist
