export ZSH=/home/lukas/.oh-my-zsh
ZSH_THEME="minimal"
# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"
CASE_SENSITIVE="true"
DISABLE_LS_COLORS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# Paths
NPM_PACKAGES="${HOME}/.npm-packages"
NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
SCRIPTS="${HOME}/.scripts"
PATH="$NPM_PACKAGES/bin:$SCRIPTS:$PATH"

# Aliases
alias g='gotwitch --streamer '
alias p='sudo pacman -Syu'
alias gl='git log --graph --all --color --stat --oneline --pretty=format:"%C(red)%h%C(yellow)% d %C(green)% s%C(blue)% aN, %aE%C(magenta)% ci%+b"'
alias weather='curl wttr.in'
alias extip='dig +short myip.opendns.com @resolver1.opendns.com'
alias c='~/.scripts/colorize.sh'

# Completions
eval "$(gotwitch --completion-script-zsh)"

curl --version 2>&1 > /dev/null
if [ $? -ne 0 ]; then
  echo "Could not find curl."
  return 1
fi

m() {
	~/.scripts/./lightmode.sh $1
}

transfer() { 
	for (( i=1; i<=$#; i++ )); do
		eval arg=\$$i
		# get temporary filename, output is written to this file so show progress can be showed
		tmpfile="$( mktemp -t transferXXX )"
		# upload stdin or file
		file="$(readlink -f $arg)"

		if tty -s; 
		then 
			basefile="$( basename "$file" | sed -e 's/[^a-zA-Z0-9._-]/-/g' )"

			if [ ! -e $file ];
			then
				echo "File $file doesn't exists."
				return 1
			fi
			if [ -d $file ];
			then
				# zip directory and transfer
				zipfile="$( mktemp -t transferXXX.zip )"
				cd "$(dirname "$file")" && zip -r -q - "$(basename "$file")" >> "$zipfile"
				curl --progress-bar --upload-file "$zipfile" "https://transfer.sh/$basefile.zip" >> "$tmpfile"
				rm -f $zipfile
			else
				# transfer file
				curl -s --upload-file "$file" "https://transfer.sh/$basefile" >> "$tmpfile"
			fi
		else 
			# transfer pipe
			curl -s --upload-file "-" "https://transfer.sh/$file" >> "$tmpfile"
		fi
		# cat output link
		cat "$tmpfile"
		echo

		# cleanup
		rm -f "$tmpfile"
	done
}

runx() {
	xinit "$1" -- :1 vt$XDG_VTNR
}

printer() {
	if [[ "$1" == "ls" ]]; then
		lpq -a
	elif [ "$1" == "rm" ]; then
		lprm
		lpq -a
	fi
}

rs() {
	for p in $@
	do
		killall -KILL $p && $p &!
	done
}
