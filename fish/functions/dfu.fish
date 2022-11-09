# update dotfiles
function dfu
    fish -c "cd ~/.dotfiles/ && git pull --ff-only && ./install -q"
end
