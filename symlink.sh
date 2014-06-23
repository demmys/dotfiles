#!/bin/sh

cd $(dirname $0)

if [ ! -d ~/.vim/vundle.git ]; then
    git clone http://github.com/gmarik/vundle.git ~/.vim/vundle.git
    echo "Installed Vundle."
fi

if [ ! -z $TMUX_ENV ]; then
    echo "set-option -g prefix C-t" > ~~~tmp
    echo ".tmux.conf setting for remote."
else
    echo "set-option -g prefix C-g" > ~~~tmp
    echo ".tmux.conf setting for local."
fi
cat ~~~tmp tmux.conf > ~~~tmux.conf
mv ~~~tmux.conf .tmux.conf
rm -f ~~~tmp

dotfiles=`ls -A | grep "^\." | grep -v "^\.git"`
for dotfile in $dotfiles
do
    ln -Fis "$PWD/$dotfile" $HOME
done

echo "Installed dotfiles.\nYou should run :BundleInstall in vim next."
