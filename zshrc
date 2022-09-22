export ZSH="/home/slas3r/.oh-my-zsh"
export PATH=$PATH:"/home/slas3r/.local/bin":"/home/slas3r/.bin"
ZSH_THEME="robbyrussell"

COMPLETION_WAITING_DOTS="true"

plugins=(
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

export EDITOR='nvim'

source ~/.utility/aliases.sh
source ~/.utility/functions.sh
[[ -s /etc/profile.d/autojump.sh ]] && source /etc/profile.d/autojump.sh

# Aliases
alias icat='kitty +kitten icat'
alias hg='kitty +kitten hyperlinked_grep'

source /usr/share/autojump/autojump.sh

# Enavle vi mode
set -o vi
