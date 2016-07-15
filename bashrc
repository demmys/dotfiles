if [ ! -z $BASHRC_LOADED ]
then
    BASHRC_LOADED=
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
PATH=$HOME/bin:$PATH
for d in $HOME/bin/*/
do
    PATH=$d:$PATH
done

source ~/.bash_profile
