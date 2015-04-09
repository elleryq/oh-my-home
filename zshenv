#export PYENV_ROOT="$HOME/.pyenv"
#export PATH="$PYENV_ROOT/bin:$PATH"
#eval "$(pyenv init -)"

# In Debian/Ubuntu, .profile will set this.
# set PATH so it includes user's private bin if it exists
#if [ -d "$HOME/bin" ] ; then
#    export PATH="$HOME/bin:$PATH"
#fi
PRIVATE_USER_BIN_EXISTED=$(python -c "import os;print '/home/ellery/bin' in os.environ['PATH'].split(':')")
if [ "$PRIVATE_USER_BIN_EXISTED" = "False" ]; then
    export PATH="$HOME/bin:$PATH"
fi

# For NodeJS
export LOCAL_PATH="$HOME/.local"
export MANPATH="$LOCAL_PATH/share/man:$MANPATH"
export NODE_PATH="$LOCAL_PATH/lib/node_modules:$NODE_PATH"
