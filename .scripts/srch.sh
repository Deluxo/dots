#! /bin/bash

case "$1" in
	pdf*)
		path=$2
		shift 2
		pattern=$@
		export LESS=-R
		(echo "SEARCH START" && find $path -name '*.pdf' -exec sh -c "pdftotext '{}' - | grep --with-filename --label='{}' --color=always -C 10 \"$pattern\"" \; && echo "SEARCH END" )
		;;
	*)
		echo "$1 Didn't match anything"
		;;
esac
