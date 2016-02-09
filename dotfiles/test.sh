#!/bin/sh
dotfiles="bashrc gitconfig vimrc xmodmap i3/file /i3/file."
for dotfile in $dotfiles; do
	if [ -d /tmp/ ]
	then
		echo $dotfile
	else
		echo NOPE
	fi
done
