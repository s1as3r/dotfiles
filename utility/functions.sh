mcd() {
    mkdir "$1" && cd "$1"
};

# Update dotfiles
dfu() {
    if [ `uname -o` = Android ];
    then 
        install_file=./termux_install
    else 
        install_file=./install
    fi
    (
        cd ~/.dotfiles && git pull --ff-only && $install_file -q
    )
};

# Execute a command in a specific directory
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

# Download all images from a url
imgd() {
    if [[ $1 =~ '^https?://(.*)\..*' ]]; then
        domain=${match[1]}
        curl "$1" | pup 'img[src$='"$2"']  attr{src}' | xargs -i{} wget {} --directory-prefix $domain;
    else
        echo "Provided argument is not a URL"
        echo "Usage: imgd URL [EXT]"
    fi
}

