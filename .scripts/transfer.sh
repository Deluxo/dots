for (( i=1; i<=$#; i++ )); do
	eval arg=\$$i
	file="$(readlink -f $arg)"
	basefile="$( basename "$file" | sed -e 's/[^a-zA-Z0-9._-]/-/g' )"
	curl -s --upload-file "$file" "https://transfer.sh/$basefile"
	echo
done
