# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13
export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to  shown in the command execution time stamp 
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
# HIST_STAMPS="mm/dd/yyyy"

ZSH_CUSTOM=$HOME/.oh-my-home/zsh_custom

export PATH="$HOME/.oh-my-home/bin:$HOME/.local/bin:$PATH"

# WORKON HOME
if [ -z $WORKON_HOME ]; then
    export WORKON_HOME=$HOME/.virtualenvs
fi

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git git-extras github python pylint virtualenv virtualenvwrapper gnu-utils autojump sudo tmux django gitignore systemadmin rvm golang fileop tig pyenv)

source $ZSH/oh-my-zsh.sh

# User configuration
# echo $PATH  # Debug purpose.

# export MANPATH="/usr/local/man:$MANPATH"

# # Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

export LANG=zh_TW.utf-8
export TERM=xterm-256color

# http://mikegrouchy.com/blog/2014/06/pro-tip-pip-upgrade-all-python-packages.html
alias pipup="pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs pip install -U"

# Need to install pythonpy
# pip install pythonpy --user
#if [ -e $HOME/.local ] && [ -e $HOME/.local/bash_completion.d ] && [ -e $HOME/.local/bash_completion.d/pycompletion.sh ]; then
#    source $HOME/.local/bash_completion.d/pycompletion.sh
#fi

#
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

#export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# golang GVM
# [[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
if [ ! -d $HOME/.go ]; then
    mkdir -p $HOME/.go
fi
which go > /dev/null
if [ $? -eq 0 ]; then
    export GOROOT=$(go env GOROOT)
    export GOPATH=$HOME/.go
    export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
fi

# Add dockviz
if [ ! -z "$(which docker)" ]; then
    alias dockviz="docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock nate/dockviz"
fi

# Enable AWS CLI auto completion
# https://gist.github.com/kevingo/1435330959666b773218
if [ -e /usr/local/bin/aws_zsh_completer.sh ]; then
    source /usr/local/bin/aws_zsh_completer.sh
else
    if [ -e $HOME/.local/bin/aws_zsh_completer.sh ]; then
        source $HOME/.local/bin/aws_zsh_completer.sh
    fi
fi

if [ -e $HOME/.zshrc.local ]; then
    source "$HOME/.zshrc.local"
fi


# added by travis gem
[ -f /home/ellery/.travis/travis.sh ] && source /home/ellery/.travis/travis.sh

# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /home/ellery/.local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /home/ellery/.local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh
