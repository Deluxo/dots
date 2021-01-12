#! /bin/sh

COUNT=$(curl -u "$(getmuttvar.sh address):$(getmuttvar.sh pass)" --silent "https://mail.google.com/mail/feed/atom" | \
	xmlstarlet format | \
	sed 's/ xmlns.*=".*"//g' | \
	xmlstarlet sel -t -m '//fullcount' -v . -n)

if [[ $COUNT =~ ^[0-9]+$ ]]; then
	CLASS=$([ "$COUNT" == 0 ] && echo "empty" || echo "full")
	ICON=$([ "$COUNT" == 0 ] && echo " " || echo "$COUNT  ")

	echo "{\"text\": \"$ICON\", \"alt\": \"$COUNT New Emails\", \"tooltip\": \"$COUNT\", \"class\": \"$CLASS\"}"
else
	echo "{\"text\": \"\", \"alt\": \"Offline\", \"tooltip\": \"Offline\", \"class\": \"offline\"}"
fi
