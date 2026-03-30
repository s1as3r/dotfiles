fish_add_path $HOME/.dotfiles/scripts
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/go/bin
fish_add_path $HOME/.juliaup/bin
fish_add_path $HOME/.local/bin
fish_add_path /opt/cuda/bin

if test (uname -o) = "Darwin"
    set -gx HOMEBREW_NO_AUTO_UPDATE 1
    fish_add_path /opt/homebrew/bin
end

# env vars
set -gx EDITOR nvim
set -gx FZF_DEFAULT_OPTS '--height 70% --layout=reverse --border'
set -q  GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME;
set -gx PATH $HOME/.cabal/bin $PATH $HOME/.ghcup/bin # ghcup-env
set -gx RIPGREP_CONFIG_PATH $HOME/.ripgreprc
set -gx RR_DEFAULT_DISPLAY_NO 0

set -l _android_home "$HOME/Android/Sdk/"
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

source_if_exists "$HOME/.cargo/env.fish"
source_if_exists "$HOME/.opam/opam-init/init.fish"
EMSDK_QUIET=1 source_if_exists "$HOME/.emsdk/emsdk_env.fish"

fish_vi_key_bindings
