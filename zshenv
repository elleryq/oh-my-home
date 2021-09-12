export PYENV_ROOT="$HOME/.pyenv"
export PATH="${PYENV_ROOT}/bin:$PATH"
eval "$(pyenv init --path)"

# In Debian/Ubuntu, .profile will set this.
# set PATH so it includes user's private bin if it exists
#if [ -d "$HOME/bin" ] ; then
#    export PATH="$HOME/bin:$PATH"
#fi
if [ -d "$HOME/bin" ] ; then
    PRIVATE_USER_BIN_EXISTED=$(python -c "import os;print('$HOME/bin') in os.environ['PATH'].split(':')")
    if [ "$PRIVATE_USER_BIN_EXISTED" = "False" ]; then
        export PATH="$HOME/bin:$PATH"
    fi
fi

# For gcin qt5 immodule
if [ -z "$QT_IM_MODULE" ]; then
    export QT_IM_MODULE=gcin
fi

# For NVM/NodeJS
# export NVM_DIR="/home/ellery/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

export LOCAL_PATH="$HOME/.local"
export MANPATH="$LOCAL_PATH/share/man:$MANPATH"
export NODE_PATH="$LOCAL_PATH/lib/node_modules:$NODE_PATH"

export MY_ZSH_DEBUG=FOO
