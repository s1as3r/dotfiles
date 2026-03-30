# update dotfiles
function dfu -d "update dotfiles"
    fish -c "cd ~/.dotfiles/ && git pull --ff-only && ./install -q"
end
