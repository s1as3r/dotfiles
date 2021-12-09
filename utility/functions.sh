mcd() {
    mkdir "$1" && cd "$1"
};

# Update dotfiles
dfu() {
    (
        cd ~/.dotfiles && git pull --ff-only && ./install -q
    )
};

# Execute a command in a specific directory
# credit: anishathalye/dotfiles
xin() {
    (
        cd "${1}" && shift && "${@}"
    )
};

# Add a directory to path
pathadd() {
    if [ -d "$1" ] && [[ "$PATH" != *"$1"* ]]; then
        if [[ "$2" == "-p" ]]; then # Prepend
            PATH="$1${PATH:+":$PATH"}"
        else # Append
            PATH="${PATH:+"$PATH:"}$1"
        fi
    fi
}

# Extract archived files
# credit: http://nparikh.org/notes/zshrc.txt
extract () {
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2)  tar -jxvf $1                        ;;
            *.tar.gz)   tar -zxvf $1                        ;;
            *.bz2)      bunzip2 $1                          ;;
            *.gz)       gunzip $1                           ;;
            *.tar)      tar -xvf $1                         ;;
            *.tbz2)     tar -jxvf $1                        ;;
            *.tgz)      tar -zxvf $1                        ;;
            *.zip)      unzip $1                            ;;
            *.pax)      cat $1 | pax -r                     ;;
            *.pax.Z)    uncompress $1 --stdout | pax -r     ;;
            *.rar)      unrar x $1                          ;;
            *.Z)        uncompress $1                       ;;
            *)          echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# url encode text
enurl () {
	python3 -c "print(__import__('urllib.parse').parse.quote('$1'))"
}

# decode url encoded text
deurl () {
	python3 -c "print(__import__('urllib.parse').parse.unquote('$1'))"
}
