export ZSH="/home/slas3r/.oh-my-zsh"
export PATH=$PATH:"/home/slas3r/.local/bin":"/home/slas3r/.bin"
ZSH_THEME="robbyrussell"

COMPLETION_WAITING_DOTS="true"

plugins=(
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

export EDITOR='nvim'

# Aliases
alias py=python3
alias python=python3
alias ipy=ipython
alias duh='du -ha --max-depth=1'
alias gitsc='git clone --depth=1'
alias chx='chmod u+x'
alias c=clear
alias v=nvim

alias icat='kitty +kitten icat'

# Functions
mcd(){ mkdir "$1" && cd "$1"; };
