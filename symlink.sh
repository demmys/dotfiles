#!/bin/sh

cd $(dirname $0)
dotfiles=`ls -A | grep "^\." | grep -v "^\.git"`

for dotfile in $dotfiles
do
	ln -Fis "$PWD/$dotfile" $HOME
done

if [ ! -d ~/.vim/vundle.git ]; then
    git clone http://github.com/gmarik/vundle.git ~/.vim/vundle.git
    echo "\033[0;31mInstalled Vundle.\033[0;39m"
fi

if [ ! -z $TMUX_ENV ]; then
    echo "set-option -g prefix C-t" > ~~~tmp
    echo "\033[0;31m.tmux.conf setting for remote.\033[0;39m"
else
    echo "set-option -g prefix C-g" > ~~~tmp
    echo "\033[0;31m.tmux.conf setting for local.\033[0;39m"
fi
cat ~~~tmp .tmux.conf > ~~~.tmux.conf
mv ~~~.tmux.conf .tmux.conf
rm -f ~~~tmp

echo "\033[0;31mInstalled dotfiles.\nYou should run :BundleInstall in vim next.\033[0;39m"
