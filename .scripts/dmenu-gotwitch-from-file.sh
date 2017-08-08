#! /bin/sh

sep="- - - - - - - - - -"

streamers()
{
	echo "games"
	echo $sep
	cat /tmp/gotwitch-subscriptions
	echo $sep
	cat /tmp/gotwitch-popular
}

game()
{
	gotwitch game -i 1000 -o $1 | sed 's/^/games: /gi'
	echo "games: offset $(($1 + 1))"
}

watch()
{
	gotwitch -w $1
}

if [[ -z "$@" ]]; then
	streamers
elif [[ "$@" == "games" ]]; then
	game 0
elif [[ "$@" =~ "games: offset " ]]; then
	offset=$(echo $1 | awk '{print $3;}')
	game $offset
elif [[ "$@" =~ "games: " ]]; then
	game=$(echo $@ | sed 's/games: //gi')
	gotwitch -q "$game" -si 1000 --padding 20
else
	channel=$(echo $1 | awk '{print $1;}')
	watch "$channel"
fi
