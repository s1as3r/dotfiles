# aliases and abbreviations
abbr -a py "python3"
abbr -a ipy "ipython"
abbr -a chx "chmod u+x"
abbr -a v "nvim"
abbr -a c "cargo"
abbr -a cmd "command"
abbr -a wwc "warp-cli connect"
abbr -a wwd "warp-cli disconnect"
abbr -a po "poetry"
abbr -a g "git"
abbr -a gisc "git clone --depth=1"
abbr -a gicl "git clone"
abbr -a gic "git commit"
abbr -a gis "git status"
abbr -a gil "git log --oneline --graph"

if command -v eza > /dev/null
    abbr -a ls eza
    abbr -a l 'eza -l'
    abbr -a ll 'eza -la'
else
    abbr -a l 'ls -lh'
    abbr -a ll 'ls -lah'
end

if test "$TERM" = "xterm-kitty"
    abbr -a kicat 'kitty +kitten icat'
    function hg --wraps rg; kitty +kitten hyperlinked_grep $argv; end
    function ssh --wraps ssh; kitty +kitten ssh $argv; end
end

if test (uname -o) = "Darwin"
    # mac specefic aliases
    abbr -a o open
else
    abbr -a o xdg-open
end

