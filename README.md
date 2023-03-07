# dotfiles
Storage my dotfiles for:
- vim
- git
- oh-my-zsh
- macOS trash

and with an install script.

## vim
Configurations and color scheme are stored in `vimrc` and `vim` directory.

## git
Set up git editor to vim, exclude `.DS_Store` and `.vscode` directory, add an alias `git graph`.

## zsh
Configure oh-my-zsh theme and plugins

## macOS
Create a `t` shell function, to move files to `$HOME/.Trash`, beside, if a file is stored in iCloud Drive, move to `.Trash` directory for iCloud Drive, and it would simultaneously be copied to `$HOME/.Trash`, besides, it would echo if the file is an icloud file or normal file.

Beside, create a symbolic link to iCloud Drive.

## install script
Create symbolics links for dotfiles, and check if `.zshrc` has sources `.my_zshrc`, if not, append code to source `.my_zshrc` in `.zshrc`

If on macOS, create a symbolic link to iCloud Drive directory.

install dotfiles with
``` zsh
./install.sh
```
the install script first check if the links or files with name to be create exist, you need to manually delete those files before install.
