abbr -a py python3
abbr -a ipy ipython
abbr -a duh 'du -ha --max-depth=1'
abbr -a chx 'chmod u+x'
abbr -a v nvim
abbr -a gitsc 'git clone --depth=1'
abbr -a o xdg-open
abbr -a p paru
abbr -a yay paru -Syu
abbr -a yeet paru -Rns

if command -v exa > /dev/null
    abbr -a ls exa
    abbr -a l 'exa -l'
    abbr -a ll 'exa -la'
else
    abbr -a ls ls
    abbr -a l 'ls -lh'
    abbr -a ll 'ls -lah'
end

if test "$TERM" = "xterm-kitty"
    abbr -a icat 'kitty +kitten icat'
    abbr -a hg 'kitty +kitten hyperlinked-grep'
end

set -gx EDITOR nvim


# autojump
if test -f /usr/share/autojump/autojump.fish
    source /usr/share/autojump/autojump.fish
end

set -gx FZF_DEFAULT_OPTS '--height 70% --layout=reverse --border'
set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /home/slas3r/.ghcup/bin # ghcup-env

if which fzf > /dev/null
    fzf_key_bindings
end

fish_vi_key_bindings
