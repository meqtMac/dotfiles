# HomeBrew
#export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/linuxbrew-bottles
#export PATH="/usr/local/bin:$PATH"
#export PATH="/usr/local/sbin:$PATH"

# HomeBrew END

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
#export PATH="/opt/homebrew/opt/node@18/bin:$PATH"
#export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
#export PATH="/opt/homebrew/bin:$PATH"
#

# Path to your oh-my-zsh installation.
#icloud="/Users/meqt/Library/Mobile Documents/com~apple~CloudDocs"
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="clean"
plugins=(git vi-mode)
source $ZSH/oh-my-zsh.sh
alias ohmyzsh="mate ~/.oh-my-zsh"

alias gitlog="git log --all --graph --decorate"
