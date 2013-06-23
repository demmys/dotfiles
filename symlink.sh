#!/bin/sh

cd $(dirname $0)
dotfiles=`ls -A | grep "^\." | grep -v "^\.git"`

for dotfile in $dotfiles
do
	ln -Fis "$PWD/$dotfile" $HOME
done

if [ ! -d ~/.vim/vundle.git ]; then
    git clone http://github.com/gmarik/vundle.git ~/.vim/vundle.git
fi

if [ ! -z $TMUX_ENV ]; then
    echo "set-option -g prefix C-t" > ~~~tmp
    rm -f $HOME/.tmux.conf
    cat ~~~tmp .tmux.conf > $HOME/.tmux.conf
    rm -f ~~~tmp
    echo ".tmux.conf setted for remote"
fi
