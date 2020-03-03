#!/bin/bash

#bemenu \
	#-b \
	#--fn "Hack 15"
	#--tb                  defines the title background color. (wx)
	#--tf                  defines the title foreground color. (wx)
	#--fb                  defines the filter background color. (wx)
	#--ff                  defines the filter foreground color. (wx)
	#--nb                  defines the normal background color. (wx)
	#--nf                  defines the normal foreground color. (wx)
	#--hb                  defines the highlighted background color. (wx)
	#--hf                  defines the highlighted foreground color. (wx)
	#--sb                  defines the selected background color. (wx)
	#--sf                  defines the selected foreground color. (wx)
	#--scb                 defines the scrollbar background color. (wx)
	#--scf                 defines the scrollbar foreground color. (wx)


# vim: set ft=sh sw=4 et:

MODE="$1"

if [[ $MODE == "commands" ]]; then
    COMMAND="compgen -c | sort -u | fzf --no-extended --print-query --bind ctrl-n:replace-query | tail -n1"
elif [[ $MODE == "pass" ]]; then
    COMMAND="find $HOME/.config/password-store -type f -name '*.gpg' -printf '%P\\n' | awk '{ print substr(\$0, 0, length(\$0)-4) }' | fzf --bind ctrl-n:replace-query"
else
    exit 1
fi

TMP=$(mktemp)

alacritty --class "alacritty-menu" -e bash -c "$COMMAND > $TMP"

cat "$TMP"
rm "$TMP"
