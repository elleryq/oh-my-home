# oh-my-home
Home stuffs

The script will install:
 * git
 * zsh and oh-my-zsh
 * pyenv
 * git-cola
 * cscope
 * ctags
 * gawk
 * build-essential
 * vim and my forked exvim
 * gcin
 * parcellite
 * terminator

After installation, $HOME will contain these files/directories:
 * .oh-my-zsh
 * .oh-my-home
 * .pyenv
 * .zshenv
 * .zshrc
 * exvim

Use ansible:
```
sudo add-apt-repository ppa:ansible/ansible
sudo apt-get update && sudo apt-get install ansible
```

TODO:
 * consider desktop/server usage.
