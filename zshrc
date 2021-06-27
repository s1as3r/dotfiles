export ZSH="/home/slas3r/.oh-my-zsh"
export PATH=$PATH:"/home/slas3r/.local/bin":"/home/slas3r/.bin"
ZSH_THEME="robbyrussell"

COMPLETION_WAITING_DOTS="true"

plugins=(
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

export EDITOR='nvim'

source '~/.utility/aliases.sh'
source '~/.utility/functions.sh'

# Aliases
alias icat='kitty +kitten icat'
