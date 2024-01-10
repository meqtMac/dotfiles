# dotfiles
Storage my dotfiles for:
<span style="float:right"><img src = "https://img.shields.io/badge/文档同步时间-20230313-blue"></span>
- vim <span style="float:right"><img src = "https://img.shields.io/badge/macOS-✔-green"></span> <span style="float:right"><img src = "https://img.shields.io/badge/Linux-✔-green"></span> 
- git <span style="float:right"><img src = "https://img.shields.io/badge/macOS-✔-green"></span> <span style="float:right"><img src = "https://img.shields.io/badge/Linux-✔-green"></span> 
- oh-my-zsh <span style="float:right"><img src = "https://img.shields.io/badge/macOS-✔-green"></span> <span style="float:right"><img src = "https://img.shields.io/badge/Linux-✔-green"></span> 
- trash <span style="float:right"><img src = "https://img.shields.io/badge/macOS-✔-green"></span> <span style="float:right"><img src = "https://img.shields.io/badge/Linux-x-red"></span> 


and with an install script.<span style="float:right"><img src = "https://img.shields.io/badge/macOS-✔-green"></span> <span style="float:right"><img src = "https://img.shields.io/badge/Linux-✔-green"></span> 

## vim
Configurations and color scheme are stored in `vimrc` and `vim` directory.

## git
Set up git editor to vim, exclude `.DS_Store` and `.vscode` directory, add an alias `git graph`.

## zsh
Configure oh-my-zsh theme and plugins

## trash
Implement a `function trash()` to trash instead of `rm` file, 😭😭😭, a rm accidient is the direct cause of this function. 

In newer version, on macOS, use AppleScript to call Finder App to delete posix file, this is mucher than naively move to trash in older version, which evokes problems like delete files with name confliction.

On Linux, call `gio trash`, I havn't tested the function, as I don't have a linux desktop envioronment.

After all, the install script and the function is write by new bing with following requirements
> write a shell function t which calls macOS system api on macOS and gio trash on Linux to move a file to trash, it take files in current directory as arguments, if the input is empty, display help message for usage, and implement --help flag

## install script
Create symbolics links for dotfiles, and check if `.zshrc` has sources `.my_zshrc`, if not, append code to source `.my_zshrc` in `.zshrc`

If on macOS, create a symbolic link to iCloud Drive directory.

install dotfiles with
``` zsh
./install.sh
```

### install for swift user
if you are a swift programming language learn, your can install by running 
``` sh
swift run
```
I perfer to write script in swift.
the install script first check if the links or files with name to be create exist, you need to manually delete those files before install.

## toolsets
- [Swift](https://www.swift.org/download/)
- [Rust](https://www.rust-lang.org/learn/get-started)
- Python + Conda
- [Brew](https://brew.sh)
- [OhMyZsh](https://ohmyz.sh)
- [Hexo](https://hexo.io)
- [ClashX Pro]

