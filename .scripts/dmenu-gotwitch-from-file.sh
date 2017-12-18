#! /bin/sh

sep=""
gamePrefix=" "
gameOffsetPrefix="games: offset "
gamesList="Games"
streamerPrefix=" "

streamers()
{
	echo "$gamesList"
	echo $sep
	cat /tmp/gotwitch-subscriptions | sed "s/^/$streamerPrefix/gi"
	echo $sep
	cat /tmp/gotwitch-popular | sed "s/^/$streamerPrefix/gi"
}

game()
{
	gotwitch game -i 1000 -o $1 | sed "s/^/$gamePrefix/gi"
	echo "$gameOffsetPrefix$(($1 + 1))"
}

watch()
{
	gotwitch -w $1
}

if [[ -z "$@" ]]; then
	streamers

elif [[ "$@" == "$gamesList" ]]; then
	game 0

elif [[ "$@" =~ "$gameOffsetPrefix" ]]; then
	offset=$(echo $1 | awk '{print $3;}')
	game $offset

elif [[ "$@" =~ "$gamePrefix" ]]; then
	game=$(echo $@ | sed "s/$gamePrefix//gi")
	gotwitch -q "$game" -si 1000 --padding 20 | sed "s/^/$streamerPrefix/gi"

elif [[ "$@" =~ "$streamerPrefix" ]]; then
	game=$(echo $@ | sed "s/$gamePrefix//gi")
	channel=$(echo $1 | awk '{print $2;}')
	watch "$channel"
fi
