#! /bin/sh

sep="|"
gamePrefix=" "
gameOffsetPrefix="games: offset "
gamesList="Games"
streamerPrefix=" "
input=$(echo $@ | awk '{print $1}')
tmpDir=/tmp/gotwitch
popsFile=$tmpDir/gotwitch-popular
subsFile=$tmpDir/gotwitch-subscriptions
notifiedFile=$tmpDir/gotwitch-notified

streamers()
{
	echo "$gamesList"
	cat $subsFile | sed "s/^/$streamerPrefix/gi" | sed "s/ / $gamePrefix/2" | sed "s/ (http.*)$//"
	cat $popsFile | sed "s/^/$streamerPrefix/gi" | sed "s/ / $gamePrefix/2" | sed "s/ (http.*)$//"
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

elif [[ "$gamesList" =~ $input ]]; then
	game 0

elif [[ "$gameOffsetPrefix" =~ $input ]]; then
	offset=$(echo $1 | awk '{print $3;}')
	game $offset

elif [[ "$gamePrefix" =~ $input ]]; then
	game=$(echo $@ | sed "s/$gamePrefix//gi")
	gotwitch -q "$game" -si 1000 --padding 20 | sed "s/^/$streamerPrefix/gi"

elif [[ "$streamerPrefix" =~ $input ]]; then
	game=$(echo $@ | sed "s/$gamePrefix//gi")
	channel=$(echo $1 | awk '{print $2;}')
	watch "$channel"
fi
