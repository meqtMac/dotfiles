#!/bin/zsh

# Set DOTFILES_DIR to the current working directory
DOTFILES_DIR=$(pwd)

# Define the link targets
ZSHRC_TARGET=$DOTFILES_DIR/zshrc
VIM_TARGET=$DOTFILES_DIR/vim
GITIGNORE_TARGET=$DOTFILES_DIR/gitignore
VIMRC_TARGET=$DOTFILES_DIR/vimrc

# Define the link names
ZSHRC_LINK=$HOME/.my_zshrc
VIM_LINK=$HOME/.vim
GITIGNORE_LINK=$HOME/.gitignore
VIMRC_LINK=$HOME/.vimrc

# Function to create a link
function create_link {
    local target=$1
    local link_name=$2
    if [[ -e $link_name ]]; then
        echo "Error: $link_name already exists."
    elif [[ -L $link_name ]]; then
        echo "Error: $link_name is a symlink that points to $(readlink $link_name)."
    else
        ln -s $target $link_name
        echo "Created $link_name"
    fi
}

# Create the links
create_link $ZSHRC_TARGET $ZSHRC_LINK
create_link $VIM_TARGET $VIM_LINK
create_link $GITIGNORE_TARGET $GITIGNORE_LINK
create_link $VIMRC_TARGET $VIMRC_LINK

# Append code to .zshrc to source ~/.my_zshrc if it doesn't already
if ! grep -Fxq "if [[ -e ~/.my_zshrc ]]; then" ~/.zshrc; then
    echo "if [[ -e ~/.my_zshrc ]]; then" >> ~/.zshrc
    echo "    source ~/.my_zshrc" >> ~/.zshrc
    echo "else" >> ~/.zshrc
    echo '    echo "Error: ~/.my_zshrc file or link does not exist."' >> ~/.zshrc
    echo "fi" >> ~/.zshrc
    echo "Added sourcing of .my_zshrc to .zshrc"
else
    echo ".zshrc already sources .my_zshrc"
fi



