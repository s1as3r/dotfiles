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
xin() {
    (
        cd "${1}" && shift && "${@}"
    )
};

