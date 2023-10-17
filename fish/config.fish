abbr -a py python3
abbr -a ipy ipython
abbr -a duh "du -ha --max-depth=1"
abbr -a chx "chmod u+x"
abbr -a v nvim
abbr -a gitsc "git clone --depth=1"
abbr -a gic "git commit"
abbr -a gis "git status"
# abbr -a o xdg-open
abbr -a o open
# abbr -a p paru
abbr -a c cargo
# abbr -a yeet paru -Rns
abbr -a cmd command
abbr -a wwc "warp-cli connect"
abbr -a wwd "warp-cli disconnect"
abbr -a po poetry
abbr -a g git

if command -v exa > /dev/null
    abbr -a ls exa
    abbr -a l 'exa -l'
    abbr -a ll 'exa -la'
else
    abbr -a l 'ls -lh'
    abbr -a ll 'ls -lah'
end

if test "$TERM" = "xterm-kitty"
    abbr -a icat 'kitty +kitten icat'
    function hg --wraps rg; kitty +kitten hyperlinked_grep $argv; end
    function ssh --wraps rg; kitty +kitten ssh $argv; end
end

set -gx EDITOR nvim

# zoxide
if which zoxide &> /dev/null
    set -gx _ZO_ECHO 1
    zoxide init fish --cmd j | source
end

set -gx FZF_DEFAULT_OPTS '--height 70% --layout=reverse --border'
set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /home/slas3r/.ghcup/bin # ghcup-env

if which fzf &> /dev/null
    fzf_key_bindings
end

fish_add_path $HOME/.dotfiles/scripts
fish_add_path /opt/homebrew/bin
fish_add_path $HOME/.cargo/bin
fish_vi_key_bindings

