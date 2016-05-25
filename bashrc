if [ ! -z $BASHRC_LOADED ]
then
    return 0
fi
export BASHRC_LOADED=loaded

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
bindirs=($HOME/bin $HOME/scripts)
for d in ${bindirs[@]}
do
    if [ -d "$d" ]
    then
        PATH=$d:$PATH
    fi
done

source ~/.bash_profile
