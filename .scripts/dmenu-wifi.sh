#! /bin/sh

MENU=$(cat <<EOF
List
New
EOF
)

MODE=$(echo "$MENU" | $DMENU)

if [[ $MODE == "List" ]]; then
	LIST=$(nmcli device wifi list | tail -n +2 | sed 's/^\*/ /' | awk '{print $2}')
	nmcli connection up $(echo "$LIST" | $DMENU)
fi
