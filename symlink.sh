#!/data/data/com.termux/files/usr/bin/bash

cd $(dirname $0)

if [ ! -d ~/.vim/bundle/neobundle.vim ]; then
    mkdir -p ~/.vim/bundle
    git clone https://github.com/Shougo/neobundle.vim.git ~/.vim/bundle/neobundle.vim
    echo "Installed NeoBundle."
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
    ln -s "$PWD/$dotfile" $HOME
done

echo "Installed dotfiles.\nYou should launch vim and install plugins next."
