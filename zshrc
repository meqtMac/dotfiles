# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="clean"
plugins=(git vi-mode)
source $ZSH/oh-my-zsh.sh
alias ohmyzsh="mate ~/.oh-my-zsh"

# CS 61A ok alias
alias ok="python3 ~/icloud/CSLS/CS61A/code/ok --local"

# new Bing: write a shell function t which calls macOS system api on macOS and gio trash on Linux to move a file to trash, it take files in current directory as arguments, if the input is empty, display help message for usage, and implement --help flag
function trash() {
    if [[ $# -eq 0 ]] || [[ $1 == "--help" ]]; then
        echo "Usage: trash [file...]"
        echo "Move files to the trash."
        return
    fi

    for file in "$@"; do
        if [[ "$(uname)" == "Darwin" ]]; then
            # use AppleScript on macOS
            osascript -e "tell application \"Finder\" to delete POSIX file \"$(pwd)/$file\""
        elif [[ "$(uname)" == "Linux" ]]; then
            # use gio trash on Linux
            gio trash "$(pwd)/$file"
        else
            echo "Unsupported operating system"
        fi
    done
}
