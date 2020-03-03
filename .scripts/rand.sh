#! /bin/zsh

for i in `seq 1 "$2"`;
do
	cat /dev/urandom | base64 | head -c "$1"
	echo "\n";
done;
