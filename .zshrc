export ZSH=/home/lukas/.oh-my-zsh
ZSH_THEME="minimal"
# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"
CASE_SENSITIVE="true"
DISABLE_LS_COLORS="true"
export VISUAL="vim"
# DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# Paths
NPM_PACKAGES="${HOME}/.npm-packages"
NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
SCRIPTS="${HOME}/.scripts"
PATH="$NPM_PACKAGES/bin:$SCRIPTS:$PATH"
export GOPATH=$HOME/Documents/Dev/go
export GOBIN="$HOME/Documents/Dev/go/bin"
export PATH="$PATH:$GOPATH/bin"

# Aliases
alias g='gotwitch --streamer '
alias p='sudo pacman -Syu'
alias gl='git log --graph --all --color --stat --oneline --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"'
alias weather='curl wttr.in'
alias extip='dig +short myip.opendns.com @resolver1.opendns.com'
alias c='~/.scripts/colorize.sh'
export XDG_CONFIG_HOME=$HOME/.config

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
    if [ $# -eq 0 ];
    then
        echo "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"
        return 1
    fi
    tmpfile=$( mktemp -t transferXXX )
    file=$1

    if tty -s;
    then
        basefile=$(basename "$file" | sed -e 's/[^a-zA-Z0-9._-]/-/g')

        if [ ! -e $file ];
        then
            echo "File $file doesn't exists."
            return 1
        fi
        if [ -d $file ];
        then
            zipfile=$( mktemp -t transferXXX.zip )
            cd $(dirname $file) && zip -r -q - $(basename $file) >> $zipfile
            curl --progress-bar --upload-file "$zipfile" "https://transfer.sh/$basefile.zip" >> $tmpfile
            rm -f $zipfile
        else
            curl --progress-bar --upload-file "$file" "https://transfer.sh/$basefile" >> $tmpfile
        fi
    else
        curl --progress-bar --upload-file "-" "https://transfer.sh/$file" >> $tmpfile
    fi
    cat $tmpfile
    rm -f $tmpfile
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
