# aliases and abbreviations
abbr -a py    "python3"
abbr -a ipy   "ipython"
abbr -a chx   "chmod u+x"
abbr -a v     "nvim"
abbr -a c     "cargo"
abbr -a cmd   "command"
abbr -a wwc   "warp-cli connect"
abbr -a wwd   "warp-cli disconnect"
abbr -a g     "git"
abbr -a gisc  "git clone --depth=1"
abbr -a gicl  "git clone"
abbr -a gic   "git commit"
abbr -a gis   "git status --short"
abbr -a gil   "git log --oneline --graph"
abbr -a gid   "git diff"
abbr -a gids  "git diff --staged"
abbr -a gia   "git add"
abbr -a ju    "just"

if $HAVE_EZA
    abbr -a ls eza
    abbr -a l  "eza -l"
    abbr -a ll "eza -la"
else
    abbr -a l  "ls -lh"
    abbr -a ll "ls -lah"
end

if $TERM_IS_KITTY
    abbr -a kicat 'kitten icat'
    function rg --wraps rg; kitten hyperlinked_grep $argv; end
    function ssh --wraps ssh; kitten ssh $argv; end
    function ls --wraps ls; command ls --hyperlink $argv; end

    if $HAVE_EZA
        function eza --wraps eza; command eza --hyperlink $argv; end
    end
end

if $OS_IS_MAC
    abbr -a o open
else
    abbr -a o xdg-open
end

if command -v hyprctl > /dev/null
    abbr -a monon  'hyprctl keyword monitor "desc:BOE, preferred, auto, 1.25"'
    abbr -a monoff 'hyprctl keyword monitor "desc:BOE, disable"'
end
