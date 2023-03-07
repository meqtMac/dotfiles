# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="clean"
plugins=(git vi-mode)
source $ZSH/oh-my-zsh.sh
alias ohmyzsh="mate ~/.oh-my-zsh"

# CS 61A ok alias
alias ok="python3 ok --local"

# Move file to trash, including iCloud Drive
# Check if the shell is running on macOS
if [[ $(uname -s) == "Darwin" ]]; then

    # Function to check if a file or directory is under iCloud Drive
    function is_in_icloud() {
        if [[ -d "$HOME/Library/Mobile Documents/com~apple~CloudDocs" ]]; then
            local path="$(realpath "$1")"
            [[ $path =~ ^$HOME/Library/Mobile\ Documents/com~apple~CloudDocs/.* ]]
        else
            return 1
        fi
    }

    # Function to move files to the Trash directory
    function t() {
        # Check if the Trash directory exists
        if [[ ! -d "$HOME/.Trash" ]]; then
            echo "Error: ~/.Trash directory does not exist."
            return 1
        fi

        # Check if iCloud Drive directory exists
        if [[ -d "$HOME/Library/Mobile Documents/com~apple~CloudDocs" ]]; then
            # Move files to iCloud Drive's Trash directory if they are under iCloud Drive, otherwise move them to the local Trash directory
            for file in "$@"; do
                if is_in_icloud "$file"; then
                    echo "iCloud file"
                    mv -i "$file" "${HOME}/Library/Mobile Documents/com~apple~CloudDocs/.Trash/"
                else
                    echo "non-iCloud file"
                    mv -i "$file" "${HOME}/.Trash/"
                fi
            done
        else
            echo "Error: iCloud Drive directory does not exist."
            return 1
        fi
    }
fi