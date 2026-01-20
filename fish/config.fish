source $__fish_config_dir/abbrs.fish

fish_add_path $HOME/.dotfiles/scripts
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/go/bin
fish_add_path $HOME/.juliaup/bin
fish_add_path $HOME/.local/bin
fish_add_path /opt/cuda/bin

if test (uname -o) = "Darwin"
    fish_add_path /opt/homebrew/bin
end

# homebrew
if test -f "/home/linuxbrew/.linuxbrew/bin/brew"
    eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
end

# env vars
set -gx EDITOR nvim
set -gx FZF_DEFAULT_OPTS '--height 70% --layout=reverse --border'
set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH $HOME/.ghcup/bin # ghcup-env
set -gx HOMEBREW_NO_AUTO_UPDATE 1
set -gx RIPGREP_CONFIG_PATH $HOME/.ripgreprc
set -gx ANDROID_HOME "/home/slas3r/Android/Sdk/"

fish_add_path "$ANDROID_HOME/emulator"
fish_add_path "$ANDROID_HOME/platform-tools"

# zoxide
if command -v zoxide > /dev/null
    set -gx _ZO_ECHO 1
    zoxide init fish --cmd j | source
end

# opam
source "/home/slas3r/.opam/opam-init/init.fish" > /dev/null 2> /dev/null; or true

# emsdk
EMSDK_QUIET=1 source "/home/slas3r/.emsdk/emsdk_env.fish"

fish_vi_key_bindings
