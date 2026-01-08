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

if command -v eza > /dev/null
    abbr -a ls eza
    abbr -a l  "eza -l"
    abbr -a ll "eza -la"
else
    abbr -a l  "ls -lh"
    abbr -a ll "ls -lah"
end

if test "$TERM" = "xterm-kitty"
    abbr -a kicat 'kitten icat'
    function rg --wraps rg; kitten hyperlinked_grep $argv; end
    function ssh --wraps ssh; kitten ssh $argv; end
end

if test (uname -o) = "Darwin"
    # mac specefic aliases
    abbr -a o open
else
    abbr -a o xdg-open
end

