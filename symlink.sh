#!/bin/sh

SCRIPT_DIR=$(cd $(dirname $0); pwd)

is_available_command() {
    if command -v $1 >/dev/null 2>&1
    then
        return 0
    else
        return 1
    fi
}

add_settings_head() {
    echo "# Settings for $2" >> $1
    echo "if is_available_command \"$2\"" >> $1
    echo "then" >> $1
}

add_settings_tail() {
    echo "fi" >> $1
}

setup_zsh() {
    local tmpfile=/tmp/zshrc.tail
    touch $tmpfile
    if is_available_command "direnv"
    then
        add_settings_head $tmpfile "direnv"
        direnv hook zsh >> $tmpfile
        add_settings_tail $tmpfile
    fi
    if is_available_command "anyenv"
    then
        add_settings_head $tmpfile "anyenv"
        echo 'export ANYENV_ROOT=$HOME/.anyenv' >> $tmpfile
        echo 'eval "$(env PATH=$PATH:$ANYENV_ROOT/libexec $ANYENV_ROOT/libexec/anyenv-init - --no-rehash)"' >> $tmpfile
        add_settings_tail $tmpfile
    fi
    cat $SCRIPT_DIR/zshrc $tmpfile > $HOME/.zshrc
    rm -f $tmpfile
}

setup_vim() {
    local rcdir=$HOME/.vim/rc
    if [ ! -d $rcdir ]
    then
        mkdir -p $rcdir
    fi
    ln -Fis $SCRIPT_DIR/dein.toml $rcdir
    ln -Fis $SCRIPT_DIR/dein_lazy.toml $rcdir
    ln -Fis $SCRIPT_DIR/.vimrc $HOME
}

setup_tmux() {
    local tmpfile=/tmp/tmux.conf.head
    if [ ! -z $TMUX_ENV ]
    then
        echo "set-option -g prefix C-t" > $tmpfile
        echo ".tmux.conf setting for remote."
    else
        echo "set-option -g prefix C-g" > $tmpfile
        echo ".tmux.conf setting for local."
    fi
    cat $tmpfile $SCRIPT_DIR/tmux.conf > $HOME/.tmux.conf
    rm -f $tmpfile
}

# .zshrc
setup_zsh
# .vimrc
if is_available_command "vim"
then
    setup_vim
else
    echo "Vim is not installed. Settings for Vim was skipped."
fi
# .tmux.conf
if is_available_command "tmux"
then
    setup_tmux
else
    echo "Tmux is not installed. Settings for Tmux was skipped."
fi
echo "Installed dotfiles."
echo "Next actions:"
echo '* Add "source $HOME/.zshrc" to your .zprofile'
echo "* Launch vim and install plugins."
