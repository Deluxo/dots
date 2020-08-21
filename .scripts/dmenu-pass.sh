#! /bin/zsh

PASSWORD_STORE_PATH="$HOME/.password-store"
pass show $(find $PASSWORD_STORE_PATH -name '*.gpg' | sed "s#$PASSWORD_STORE_PATH/##g" | sed 's/.gpg//g' | $DMENU) | wl-copy -on
