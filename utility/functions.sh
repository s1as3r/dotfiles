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

