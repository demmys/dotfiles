if [ ! -z $ZSHRC_LOADED ]
then
    ZSHRC_LOADED=
    return 0
fi
export ZSHRC_LOADED=loaded
source ~/.zprofile

is_available_command() {
    if command -v $1 >/dev/null 2>&1
    then
        return 0
    else
        return 1
    fi
}

# PATH for brewed softwares
if is_available_command "brew"
then
    PATH=/usr/local/bin:/usr/local/sbin:$PATH
fi
# PATH for home-build softwares
if [ -d "$HOME/bin" ]
then
    PATH=$HOME/bin:$PATH
    for d in $HOME/bin/*
    do
        if [ -d $d ]
        then
            PATH=$d:$PATH
        fi
    done
fi
export PATH
