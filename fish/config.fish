# env vars used in the config
set TERM_IS_KITTY (test "$TERM" = "xterm-kitty"; and echo true; or echo false)
set OS_IS_MAC     (test (uname -o) = "Darwin"; and echo true; or echo false)
set HAVE_EZA      (command -v eza > /dev/null; and echo true; or echo false)

function _source_if_exists -a fpath
    test -f $fpath; and source $fpath
end

source $__fish_config_dir/abbrs.fish

fish_add_path $HOME/.dotfiles/scripts
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/go/bin
fish_add_path $HOME/.juliaup/bin
fish_add_path $HOME/.local/bin
fish_add_path /opt/cuda/bin

if $OS_IS_MAC
    fish_add_path /opt/homebrew/bin
end

# homebrew
if test -f "/home/linuxbrew/.linuxbrew/bin/brew"
    eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    set -gx HOMEBREW_NO_AUTO_UPDATE 1
end

# env vars
set -gx EDITOR nvim
set -gx FZF_DEFAULT_OPTS '--height 70% --layout=reverse --border'
set -q  GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH $HOME/.ghcup/bin # ghcup-env
set -gx RIPGREP_CONFIG_PATH $HOME/.ripgreprc

set -l _android_home "/home/slas3r/Android/Sdk/"
if test -d $_android_home
    set -gx ANDROID_HOME $_android_home
    fish_add_path "$ANDROID_HOME/emulator"
    fish_add_path "$ANDROID_HOME/platform-tools"
end

# zoxide
if command -v zoxide > /dev/null
    set -gx _ZO_ECHO 1
    zoxide init fish --cmd j | source
end

_source_if_exists "/home/slas3r/.opam/opam-init/init.fish"
EMSDK_QUIET=1 _source_if_exists "/home/slas3r/.emsdk/emsdk_env.fish"

fish_vi_key_bindings

set --erase TERM_IS_KITTY
set --erase OS_IS_MAC
set --erase HAVE_EZA
