#! /bin/zsh

if [ -z "$@" ];then
	ls ~/.password-store
else
	title=$(echo $@ | head -c -5)
	pass show -c $title > /dev/null
fi
