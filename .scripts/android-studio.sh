#! /bin/sh

binPath=$ANDROID_HOME/../android-studio/bin/studio.sh

chmod +x $binPath

if [[ $1 == '--no-fork' ]]; then
	$binPath
else
	$binPath &> /dev/null &!
fi
