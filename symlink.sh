#!/bin/sh

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

setup_bash() {
    local tmpfile=/tmp/bashrc.tail
    if is_available_command "pyenv"
    then
        add_settings_head $tmpfile "pyenv"
        pyenv init - >> $tmpfile
        add_settings_tail $tmpfile
    fi

    if is_available_command "rbenv"
    then
        add_settings_head $tmpfile "rbenv"
        rbenv init - >> $tmpfile
        add_settings_tail $tmpfile
    fi

    if is_available_command "direnv"
    then
        add_settings_head $tmpfile "direnv"
        direnv hook bash >> $tmpfile
        add_settings_tail $tmpfile
    fi
    cat bashrc $tmpfile > .bashrc
    rm -f $tmpfile
}

setup_vim() {
    if [ ! -d ~/.vim/bundle/neobundle.vim ]
    then
        mkdir -p ~/.vim/bundle
        git clone https://github.com/Shougo/neobundle.vim.git ~/.vim/bundle/neobundle.vim
        echo "Installed NeoBundle."
    fi
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
    cat $tmpfile tmux.conf > .tmux.conf
    rm -f $tmpfile
}

# Setup
cd $(dirname $0)
# .bashrc
setup_bash
# .vimrc
if is_available_command "vim"
then
    setup_vim
else
    echo "Vim is not installed. Settings for Vim is skipped."
fi
# .tmux.conf
if is_available_command "tmux"
then
    setup_tmux
else
    echo "Tmux is not installed. Settings for Tmux is skipped."
fi

# Make symlinks
dotfiles=`ls -A | grep "^\." | grep -v "^\.git"`
for dotfile in $dotfiles
do
    ln -Fis "$PWD/$dotfile" $HOME
done

echo "Installed dotfiles."
echo "Next actions:"
echo '* Add "source $HOME/.bashrc" to your .bash_profile'
echo "* Launch vim and install plugins."
