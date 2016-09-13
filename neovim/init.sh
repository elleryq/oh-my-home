#!/bin/bash
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln -s ~/.oh-my-home/neovim/init.vim ~/.config/nvim/init.vim
nvim +PlugInstall
