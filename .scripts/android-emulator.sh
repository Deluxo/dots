#! /bin/sh

binPath=$ANDROID_HOME/emulator/emulator
chmod +x $binPath

export QEMU_AUDIO_DRV=none 
export QT_QPA_PLATFORM=xcb

if [[ $1 == '--no-fork' ]]; then
	$binPath @q
else
	$binPath @q $@ &> /dev/null &!
fi
